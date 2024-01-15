Return-Path: <linux-kernel+bounces-25824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F04682D65E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347481C21636
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180ADF4E4;
	Mon, 15 Jan 2024 09:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="l3Q4DLLh"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2B6F4E7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5592d2bc270so950136a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 01:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705312354; x=1705917154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pV7vfHddpIjdo1gvqUviCk+EZ4jPGodxukJi3Cbz8BY=;
        b=l3Q4DLLh0/X7PRCPzveA7chRq6ngkkDoOFa2/ePiLDbfGft4L0dGQilXPAjJOvGLFI
         ZkF3vvyoXYgwzRovMOJY+8FedS4B+K5iFUboBH5XODO1Tox5q5TYK4ByBQqiXO6Wn4sk
         ayYuKV4FX7zv78d+RQQn4193jKd5LO562HqMPKwtMY0pxWrDquL76c75C1eJS0KwijgU
         TNQDd0ze5TAxJuxew4VNsGauK/78kJqEWtoXLYVjS796nKeaa5Z0peMvzR5dmUZdxyMu
         pM1zY6h5i/A5Rbqmk/KvDhIWAPNksCOAbuAkHdku2NRVq2No4fyzDXQdCDSqh2u1M+ex
         u/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705312354; x=1705917154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pV7vfHddpIjdo1gvqUviCk+EZ4jPGodxukJi3Cbz8BY=;
        b=emrtlAQet130K0Fte74zvRntTew1V4S22bAUDppqDzucCWw+gUGwBHZtdOyetesnL5
         HBjm6qQdVqtU3NRPwm+SrGG6kHSS/3JyCETK8aVEV5m4nWiwkYhP27BKHehshb5jr8jh
         6VUarCkN7goub5LDiocxdQMgnt1P6NI16nNlOD4KscfiGte5cw1g5QG9KNdK7U/mqLTv
         dsbCmJzDsSJUf2oXeT+cBHs8sYIPl8kZhSRkjc7Z4UUev+q9FMK5c2ZYERsChLaIca/Q
         2uytks3rp7qTV0OiRbWi+riku1CKydXWGem5Fq9DDxVgr9qTeV51n2uXx2LO93f8FUNZ
         Bczg==
X-Gm-Message-State: AOJu0YyXfrygxA6uyHrVj/M3fD5HKFcsqBMdfF7v9fqR2Fwe3P8lVqpk
	cm4HWLTohd+sq9+UsEJjqJB3VoVf994HvA==
X-Google-Smtp-Source: AGHT+IHg4iG+SxOvbGjJMJ0Mi05uMNiQ7rB6L6vuzmWHpH8DTKCsBTCPKrMB+dvhpzz7VfL5uOZEyg==
X-Received: by 2002:a17:906:a1d1:b0:a2a:19c8:e4ef with SMTP id bx17-20020a170906a1d100b00a2a19c8e4efmr2337014ejb.141.1705312354303;
        Mon, 15 Jan 2024 01:52:34 -0800 (PST)
Received: from blmsp ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id k16-20020a170906129000b00a274f3396a0sm5149479ejb.145.2024.01.15.01.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 01:52:33 -0800 (PST)
Date: Mon, 15 Jan 2024 10:52:32 +0100
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: m_can: remove redundant check for pm_clock_support
Message-ID: <nls37vv4rj6pn5vvrjizapb23l3mikpwkh2fk7gtrpnxgiym5b@jbmlyci4q3pg>
References: <20240104235723.46931-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240104235723.46931-1-francesco@dolcini.it>

On Fri, Jan 05, 2024 at 12:57:23AM +0100, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> m_can_clk_start() already skip starting the clock when
> clock support is disabled, remove the redundant check in
> m_can_class_register().
> 
> This also solves the imbalance with m_can_clk_stop() that is called
> afterward in the same function before the return.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

Best,
Markus

> ---
> I spotted the issue while debugging some other part of the code,
> the patch is only compile-tested.
> ---
>  drivers/net/can/m_can/m_can.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 16ecc11c7f62..bd1d1626684d 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -2056,11 +2056,9 @@ int m_can_class_register(struct m_can_classdev *cdev)
>  {
>  	int ret;
>  
> -	if (cdev->pm_clock_support) {
> -		ret = m_can_clk_start(cdev);
> -		if (ret)
> -			return ret;
> -	}
> +	ret = m_can_clk_start(cdev);
> +	if (ret)
> +		return ret;
>  
>  	if (cdev->is_peripheral) {
>  		ret = can_rx_offload_add_manual(cdev->net, &cdev->offload,
> -- 
> 2.39.2
> 

