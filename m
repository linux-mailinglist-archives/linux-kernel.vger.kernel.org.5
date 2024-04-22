Return-Path: <linux-kernel+bounces-153370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E728ACD39
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ED52285711
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507D914F118;
	Mon, 22 Apr 2024 12:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QKVetmT4"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2F114A4C7
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713790045; cv=none; b=Wn0tk7a79J473osTH1ebWfcrJc3ZdsdSulPJChDuCTy/9VBQQi/WwAbam4o9x1jQOcVaIqg94oxEYFLg9IWKPrg0/pqM55HMXmvnh0ixj/QzEkgMoz0SKdDtvPhPfizVaO+dE4Z3oZTxuQYtTDVTAjtgK8L83Eyk0/RRbwfkTko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713790045; c=relaxed/simple;
	bh=xK0xpJYoCLIITlC+CsYauUdtz62QeVeHRGmWzCiWf5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpXMlBxzkPEYmA1NF0P3A1Nk9flFY5fY3tb6nq9YUwFSeCCaJsosR7eEmsujOBg50oZsivuClAiS33uK2Py4K6ZaGRFnhyp1sinakDGjYo0H8XCwcXFmALVQxFJtTGg8l7xjBuwJ0/ZfkIi5QtMWwVO3qwlSb+OIreKZXxjPwY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QKVetmT4; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51ae2e37a87so2604942e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 05:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713790042; x=1714394842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tAq2BIio/WgpUEPdT8jPUBANtNcgUg2oMhI7FrVaEB0=;
        b=QKVetmT4Qiv2LzM5bk/Rk+DI4aimjEbt6joAxLnYRDLX/FzEMNGF8e7jXAlwsrauwA
         c0xHKqmpHy76N/L5OvbNpQ9raifbYLglRIU6o0U0C47ElT+tlsLhwzs8RywixlGPoKoT
         BG2v89BzOhSKDFCFBbnEZsljWgBsLovuefUO0IenfK5GCcq3ZLK0NxUPLRJ2oHoVVTua
         YPBlZ9cyYeMVcpGP+TANdwTW7jxweUyLoKH3IonGyLckFiGZ1k2H6OF55duhqQWGq77g
         iKxLlyouFq8MohJmDXXj9VIzCMVkDB9FcPmUxoRzOyvl/Xv4+rdFnN0L94sombBSJL9J
         Diaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713790042; x=1714394842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAq2BIio/WgpUEPdT8jPUBANtNcgUg2oMhI7FrVaEB0=;
        b=REuyYTk+k/MEKC8O91m2rZugGZvEP6HVYUJNZBYcOEBtgzIumsWkGmKfzIYVsmoOAV
         L/Xn7xJpsNxo25WZvm539yzbk5XEHn9oRWWXNX8aw2kTtD+qLHZdJ0c4+8ZZkM5aFm0J
         Rb1phk9CTvr8C5eGZ+luFHBMGL8iS1KW53WqqOscV4J8+zzZ+51w197CNqTC1buNG7XD
         LQfGfma5KOK65tSdlRMMhT5mSaiBgk/afvBptGHtGHcXfKICQwhusgEdgS2G5zCj+GRb
         nReE9EnK2oLWTtuHx2bvg2j3m2+h1rbfwNg/bDSJj8YgN5ZhAwger0ewWYVyFASeC1wU
         ht+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXqPxNrX89gqW7NCN/GoN0xTImP4ka166Sj9CjQYAjOwCroRmd+Rm7k9ZB27YsFmeOp/V8OW7EGeOKz8N7ZbUvODzc8A04UKxvkfsYe
X-Gm-Message-State: AOJu0YzrQbntieLA5v2Vou9TxMuFXBmqxaC8x4zRQ0lLrqMaunLxq/2p
	Wu9CIwpvF8aUtPnImnRnkKkLLxVXRhoNFYIF/e6u0h+LVer0otehJ4uiR+gKrmw=
X-Google-Smtp-Source: AGHT+IEMH8RihJNVGuEx0Di87sDBlhXnXygmj8MwWRwVHNTMdA9GYNd7ZTy8dfvJApZvwx5iiRjYLw==
X-Received: by 2002:a05:6512:20c3:b0:51a:c3a6:9209 with SMTP id u3-20020a05651220c300b0051ac3a69209mr5156044lfr.68.1713790039896;
        Mon, 22 Apr 2024 05:47:19 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id r25-20020a170906351900b00a55b5c365dfsm1248156eja.199.2024.04.22.05.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 05:47:19 -0700 (PDT)
Date: Mon, 22 Apr 2024 15:47:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: ajk@comnets.uni-bremen.de, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+8e03da5d64bc85098811@syzkaller.appspotmail.com
Subject: Re: [PATCH] hams: Fix deadlock caused by unsafe-irq lock in sp_get()
Message-ID: <bac3fb0d-2810-496d-b3ef-26a7f208ec51@moroto.mountain>
References: <20240418173037.6714-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418173037.6714-1-aha310510@gmail.com>

On Fri, Apr 19, 2024 at 02:30:37AM +0900, Jeongjun Park wrote:
> 
> read_lock() present in sp_get() is interrupt-vulnerable, so the function needs to be modified.
> 
> 
> Reported-by: syzbot+8e03da5d64bc85098811@syzkaller.appspotmail.com
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  drivers/net/hamradio/6pack.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
> index 6ed38a3cdd73..f882682ff0c8 100644
> --- a/drivers/net/hamradio/6pack.c
> +++ b/drivers/net/hamradio/6pack.c
> @@ -372,12 +372,13 @@ static DEFINE_RWLOCK(disc_data_lock);
>  static struct sixpack *sp_get(struct tty_struct *tty)
>  {
>  	struct sixpack *sp;
> +	unsigned long flags;
>  
> -	read_lock(&disc_data_lock);
> +	flags = read_lock_irqsave(&disc_data_lock);

This doesn't compile.  At least build test your patches.

regards,
dan carpenter


