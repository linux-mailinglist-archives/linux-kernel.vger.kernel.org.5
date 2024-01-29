Return-Path: <linux-kernel+bounces-42961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FED0840957
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3795B22473
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF0A153BC2;
	Mon, 29 Jan 2024 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CawMW8MK"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D26152E03
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706540922; cv=none; b=ET1D+1SySxjdpThaRDhUwCGekTz5E5Z6nMgM3aWKYz8yuWG72GIbYXCcy9fzORYQjFk9G7Gvr5KFjCV33UqRvYmM5ERd+sz0xFHzOI4FeDu2OFcdpHPYsWfwd8fs22u1r3HmEV0WBU0fzgMf17h1Ojoy5Ee4DZ0woqrz6El59yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706540922; c=relaxed/simple;
	bh=TvYc0o6580YbXidZl8mC8lUkNACoSav70Z1m/H+6tY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5nNNl8a6SMzGc5TGlLBQM8Ck9UP5nmd83XYEygJ0kcRORE4WpTY3lgABddVIy/Nz6TTp5JmeCh55dTf5i6FbsvGgrfy1vYWWxiJOLc/+E+9qdQ14HvSsVCBavlz6H5YBjodzEmd9BWHyDr9R3q4MlVELXg9wEXdW1b0rYGDUk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CawMW8MK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40ef6bbb61fso9144205e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 07:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706540919; x=1707145719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n6cwbDbWLh7v+Hr7qWbFBpGzaMo6CtewwpyzoCKYp78=;
        b=CawMW8MKKsuTAQfSGmM+HzbrJRZxufMAkucWBYE9uxBcIKylYLc/az2f42pTwGw5q/
         fhP8I8qjEEvLpl7X3CaiQ9wkEUZka9RpennOn33QLiaDB55Qf3/VYJfRlpwxdjsMEpba
         fk97ftcaVRm+DXoYZzwD6Lbbzuyf6a13BC1pGhjygRXR6SNvlWgiwE5FRGhpQp5yeuuH
         F3aX3eoksvTJmXInzGNQnrIraxXeG26CmcL+eXU6e3y/vhySm3WTzyMeCG7bMavI9U5z
         CEGeuVIBYbjAmv7rB/PJVH2kP8e+0WrpDRXAOOhnLa9s9P4vaAkbowEMGLXSRFGpIqKn
         7cHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706540919; x=1707145719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6cwbDbWLh7v+Hr7qWbFBpGzaMo6CtewwpyzoCKYp78=;
        b=YZScM0CJLmDZmHrmATuFaIOLhO2XLvR0DD//VarY86gpxov/I3DXLcpDAFUQIz5QVl
         Igxdkijks7uecv5Dn3btvSmtLWdDuka/vzAidcmwlX4nb3Jtyoqru15LkRG5zdCbtvhd
         MMRQ4dtCJOM5cfzYo3YCHrntVCdn6oxQU9z8D8itWfEX1RmSJJ1BUWXsjrMTypnwxX5A
         p1BpbazZupdI2jCQX4DBO8x9uyou9m/0SjB5oQ4Q/d1rPhUpgEmwFXrvc4nnNpmfCcoT
         BIA5xpoIbo9TuVkNDjqseIlG6uHRlnpASIiYzSavKrM9Gs0DWp03J8Lb8I4S0NW2K2V0
         9Oig==
X-Gm-Message-State: AOJu0YypCMfeuJ21D9n/BrTuHBxPDqx2nUuqN+AnNUPBMTOzzBTkIhUn
	MaJ6ugii5Wvpd5eUUKHpUygaLzD5qeAEZwvG/wdKB+gKjx36bho5fqF5xOPm1ck=
X-Google-Smtp-Source: AGHT+IHMJzhv2MnPPwPMGGUmJ06IHYBSMp+B4effQYkqj/MHj3BYszh4U8CN5g12VqY/IR2e7km/ng==
X-Received: by 2002:adf:f884:0:b0:33a:e4da:2214 with SMTP id u4-20020adff884000000b0033ae4da2214mr3796745wrp.50.1706540919694;
        Mon, 29 Jan 2024 07:08:39 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id er8-20020a056000438800b0033af0234b3esm2148627wrb.49.2024.01.29.07.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 07:08:39 -0800 (PST)
Date: Mon, 29 Jan 2024 18:08:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Meir Elisha <meir6264@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] Staging: rtl8723bs: fix else after break warning
Message-ID: <83d0680c-e057-4fb4-a6ee-ed7e0ba06599@moroto.mountain>
References: <20240129141856.416532-1-meir6264@Gmail.com>
 <20240129141856.416532-5-meir6264@Gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129141856.416532-5-meir6264@Gmail.com>

On Mon, Jan 29, 2024 at 04:18:56PM +0200, Meir Elisha wrote:
> Fix checkpatch warning: else is not generally useful after a break or return
> 
> Signed-off-by: Meir Elisha <meir6264@Gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme.c | 38 +++++++++--------------
>  1 file changed, 14 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> index 044483f3d678..efaac84f22b4 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> @@ -1540,30 +1540,23 @@ void _rtw_join_timeout_handler(struct timer_list *t)
>  
>  	spin_lock_bh(&pmlmepriv->lock);
>  
> -	if (rtw_to_roam(adapter) > 0) { /* join timeout caused by roaming */
> +	if (rtw_to_roam(adapter) == 0) { /* join timeout caused by roaming */

The comment is wrong now.

regards,
dan carpenter


