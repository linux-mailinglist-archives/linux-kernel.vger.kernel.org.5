Return-Path: <linux-kernel+bounces-42957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0171C840942
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945E81F288CF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67050152E03;
	Mon, 29 Jan 2024 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ILWkiaqk"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD72657DB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706540713; cv=none; b=NAXk8fQnCc2cbEmo89ingsKvOTyzGUkigbUPxiSyeZcVz3lBAmLX33iOinocVTl7Ab1MItvbWlvOpv6IZtIGHJ0XP31PHIHGwH4H3Cw1aJTcJFOsupvZMDhPvU22JcgZmuyRTTgAcpJOIgtGwTZZwjFoKlbtmK1GzDdprGfjVoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706540713; c=relaxed/simple;
	bh=w0SmiVf1VIVWURSBibSHsWqoAWrZC4py0itUpxFcYnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZM8GG0z+mOIOR72Zz1yod+x5kcbTJEjIDZZ6juXKaIstzRceLZkKA5uEwIzgn2I0rCJ0xqg068JQQzwmL0fG3oh3b8pcSHctauLwiEDrF4nASYIvY+FPioVOeRzEXQovPuelev4B4J0QiZXQRm8LoSIVyKQlNhbeaFdX50+9SV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ILWkiaqk; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-510e0d700c6so1469330e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 07:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706540708; x=1707145508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=is7ro7B8vSrt0TvYSJ+DPFn+IXQv7f7Zkz1f/rmDyPY=;
        b=ILWkiaqk9/a/cmBsH7vwMDCpY4e1MF8/5shvUoLYTVd569elx9/arEHeB3Wumvyo7E
         CfK5/RDvOGkQEWnw6zHLkx3gsGrObAXOJQ23/4hkZXqfF8H4JIzkj9Kyc8IwCBMHZdtD
         zGhtvuywz8F6Y9AMhq4ThUEUUehq2HSm6ArRwLofSLwdzjLS2K+0vUT3fQOIiV5va1f4
         0oPeNXFIScxeuf/SL+I/+QK8FFIAS97tboGOvGiKtFU7TSt4JwM+VdbA7sTyb0laW0dp
         kcC4XL1kWDqZqJQrBslsCSkpqTLTJGbFEE055j2yh6a/Jd42vM4RhdnKHnZoVwOWjQEo
         kInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706540708; x=1707145508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=is7ro7B8vSrt0TvYSJ+DPFn+IXQv7f7Zkz1f/rmDyPY=;
        b=MrD0nmwPrB48ujs9PpYxozI+fZBAnrfiQTR2UdH5e903FR5B8UyoDn/Dza7xBsEOz2
         I7jWtDlfih4KJJEl74skdUiH7dti8Gwtbg8wwdmyUl86RRvNCQG6PF7WJnHnvVfVnYwN
         sePouDDAiICCJCVhWKpCWc7qCwi/vcvQZHDiYXxpb8xe4Kxnb/s8RvmXRSna2Ur5D+Hj
         gO7PQUHjCdhG7lKYtI0fJ59KpOOkVuGHEpF8zWfSdqnilPa00Xl0opwct/9hhwPIoVqC
         fCWIRe6yPRq3kT+5C6qCk+cvBO3O17j67NK3POCwHP/kD4dOuFaH++nHXduHldrLFhXG
         OjPA==
X-Gm-Message-State: AOJu0Yxy0OSOKze4yyNkrV+iTSz6Vz1T1pCA5rJPig/PK2h5ZX9HJoe0
	QW++SXJ1WJKZquAPdsFHHxYITAwcxe02fvvMA+avREW1loTKpRek8GcPchiEJzQ=
X-Google-Smtp-Source: AGHT+IEqmh/cI1PozuMSleeGae2wsgcL+hEQKSB8fVSpWf8NAz1wVQzEOkLik3p398u18vSo0zPTnA==
X-Received: by 2002:a05:6512:20d2:b0:50e:7aaf:ec53 with SMTP id u18-20020a05651220d200b0050e7aafec53mr3597889lfr.12.1706540708419;
        Mon, 29 Jan 2024 07:05:08 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b0040e4914f28dsm14282173wmq.18.2024.01.29.07.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 07:05:07 -0800 (PST)
Date: Mon, 29 Jan 2024 18:05:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Meir Elisha <meir6264@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] Staging: rtl8723bs: Remove extra spaces
Message-ID: <080d2c0d-49b1-45e9-9b7b-fae2afaf0b4f@moroto.mountain>
References: <20240129141856.416532-1-meir6264@Gmail.com>
 <20240129141856.416532-3-meir6264@Gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129141856.416532-3-meir6264@Gmail.com>

On Mon, Jan 29, 2024 at 04:18:54PM +0200, Meir Elisha wrote:
> Fix checkpatch warning: please, no space before tabs
> 
> Signed-off-by: Meir Elisha <meir6264@Gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme.c | 48 +++++++++++------------
>  1 file changed, 23 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> index 5568215b35bd..a7c4350e0783 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> @@ -169,7 +169,7 @@ void _rtw_free_network(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwor
>  {
>  	unsigned int delta_time;
>  	u32 lifetime = SCANQUEUE_LIFETIME;
> -/* 	_irqL irqL; */
> +/*	_irqL irqL; */

Just delete dead code.

>  	struct __queue *free_queue = &(pmlmepriv->free_bss_pool);
>  
>  	if (!pnetwork)
> @@ -389,7 +389,7 @@ int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst, u8 fea
>  	d_cap = le16_to_cpu(tmpd);
>  
>  	return (src->ssid.ssid_length == dst->ssid.ssid_length) &&
> -		/* 	(src->configuration.ds_config == dst->configuration.ds_config) && */
> +		/*	(src->configuration.ds_config == dst->configuration.ds_config) && */

Here too.

>  			((!memcmp(src->mac_address, dst->mac_address, ETH_ALEN))) &&
>  			((!memcmp(src->ssid.ssid, dst->ssid.ssid, src->ssid.ssid_length))) &&
>  			((s_cap & WLAN_CAPABILITY_IBSS) ==

regards,
dan carpenter


