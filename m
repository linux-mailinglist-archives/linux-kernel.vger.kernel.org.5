Return-Path: <linux-kernel+bounces-125203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26987892218
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91DE21F262FD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279861327F5;
	Fri, 29 Mar 2024 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+HDWVJu"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAB933CC4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711731691; cv=none; b=HoxAkUlZz+F1IlTsMbi29N4mqhJfW+jjpvNwQzAIcCTS8ZpJFpnSgWOsAA1wL+8PUovt1b6LyIIBX8pjZs6c23qi99gwBZXprg5gzLU2NjmUwq4x2COdH+Xuf4g8uvEhTdm1ML+0jBGzlIermCvQX5H65HSvEGpz6saN9OYpyqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711731691; c=relaxed/simple;
	bh=LP0SVM4zANcE16ZCf3lnVQEx3fF0+VnawnvnS4QpQYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H610967t9404HaqfYqenGjkXiVh0pfk6QRG9ZmwtAyc2iPpIUBX75KDQOkmLFHMm3sVvj4HKGY322XWQXD6q46GNFbZwJuEOuind2tyyGSK0+jJo1Mnl9kXpcwj+KmEWqXxO0RhZ3DVy40QvoYxLP7l9nQPwv5OO7dMSnKarrg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+HDWVJu; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513e8bf8228so648731e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711731688; x=1712336488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YgKPKTTDQgEgY8lj4hlaReR5NBDNtvQ5L48mb+0x4WA=;
        b=S+HDWVJuFMqCN7gLUQDnOh0DKtiCTWTM+u2Nlfu6z+dno7hflzzhCrEOH3Yu8WjID8
         hccsdSXrTOHfwjIlHeDQ1JrDkcAZwlCm7yoK+6GiqyZKZJNOHDERm638FnqD2KkjAETx
         VRSCyI2PAlnyWL+YNbDlNUQ1RtOFMEgbNiRL3EiDHsJE45LbhRMzxsnIWT8U2XPALx6i
         CH9TMiOvO4OCLmRLuv8o8B3tOoulCjS5y2Lms/yIs5kHkM+ONJALnj5Dw/CCt/5bIcpb
         JGO3UImWgbDtFwH8powQlnqJ9mso8bCrWVT1qP7RqBMLmK0BylXKjxYY/hPLRRsjJIBY
         m80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711731688; x=1712336488;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgKPKTTDQgEgY8lj4hlaReR5NBDNtvQ5L48mb+0x4WA=;
        b=ZQC3qKJmZJss1fnikYUS9lPjXlaRahCWg17chWcd3jhewHPQdjIvjr97H+9hlAHKpg
         zjz9cu3wm81z2p0kus2UU4k/fvsqvRYZV7jE9FFGhe1Q0G3OX/Pkd+SdqpJ6ZJ+wLoY8
         YZrDxRLPOZ+vdnVaXvaGP3ECHzH4xknTZuFBW7CS0rtDPv6rpMCNNBA824pJhpKRSZed
         Ie5CVRcP1cv56wzSCpdG9cBjaj+5fGZTpmQYFUWW5+bu+jbqMVvyPC7z9HKs0L8qrGdC
         4Sk7xM0PDVcZNrALTgRK9OiX5lOq99/3/7KpsVXnJpUJ5Hv/50qsWBxHaSC66x6bj+HA
         M0cA==
X-Forwarded-Encrypted: i=1; AJvYcCWAZMH6b8ufXjdwWPmbu5ZNIQ16K9OLN/wVstRM70jEqZhB+DTvngWaUMzddTJpTCKCokcOVdTqxHLPpXRlfwqHM7MmakuBgKLBFpNg
X-Gm-Message-State: AOJu0YyiplYAVnylA0hdU38noQchOLw8tbHOYamFqkCVs3GH6n2LsVsD
	GNVUepZURGIOE2P1kJpV5F5aGjrm+KPPobmxGidQRjYvX0mMIYqw
X-Google-Smtp-Source: AGHT+IGbzUlYjpg2H6wy5rwHetA0LZ3y7qQGSobT7HctFnWI9n67GlsHS93OVi9HU1Kh08LuNnXHOw==
X-Received: by 2002:ac2:5b08:0:b0:513:ec32:aa87 with SMTP id v8-20020ac25b08000000b00513ec32aa87mr1763697lfn.6.1711731687515;
        Fri, 29 Mar 2024 10:01:27 -0700 (PDT)
Received: from [192.168.0.103] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id z25-20020a170906075900b00a4e4108a86bsm333688ejb.23.2024.03.29.10.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 10:01:27 -0700 (PDT)
Message-ID: <e1c87cd1-8542-4170-820f-0deeabc22e83@gmail.com>
Date: Fri, 29 Mar 2024 18:01:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8192e: remove unnecessary wrapper
To: Michael Straube <straube.linux@gmail.com>, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240329111458.14961-1-straube.linux@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240329111458.14961-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/29/24 12:14, Michael Straube wrote:
> _rtl92e_dm_ctrl_initgain_byrssi() is just a wrapper around
> _rtl92e_dm_ctrl_initgain_byrssi_driver(). Using a wrapper here adds
> no value, remove it. Keep the name _rtl92e_dm_ctrl_initgain_byrssi().
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
> Compile-tested only.
> 
>   drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> index 4c67bfe0e8ec..aebe67f1a46d 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> @@ -163,7 +163,6 @@ static	void	_rtl92e_dm_check_tx_power_tracking(struct net_device *dev);
>   
>   static void _rtl92e_dm_dig_init(struct net_device *dev);
>   static void _rtl92e_dm_ctrl_initgain_byrssi(struct net_device *dev);
> -static void _rtl92e_dm_ctrl_initgain_byrssi_driver(struct net_device *dev);
>   static void _rtl92e_dm_initial_gain(struct net_device *dev);
>   static void _rtl92e_dm_pd_th(struct net_device *dev);
>   static void _rtl92e_dm_cs_ratio(struct net_device *dev);
> @@ -929,11 +928,6 @@ static void _rtl92e_dm_dig_init(struct net_device *dev)
>   		dm_digtable.rx_gain_range_min = DM_DIG_MIN;
>   }
>   
> -static void _rtl92e_dm_ctrl_initgain_byrssi(struct net_device *dev)
> -{
> -	_rtl92e_dm_ctrl_initgain_byrssi_driver(dev);
> -}
> -
>   /*-----------------------------------------------------------------------------
>    * Function:	dm_CtrlInitGainBeforeConnectByRssiAndFalseAlarm()
>    *
> @@ -952,7 +946,7 @@ static void _rtl92e_dm_ctrl_initgain_byrssi(struct net_device *dev)
>    *
>    ******************************************************************************/
>   
> -static void _rtl92e_dm_ctrl_initgain_byrssi_driver(struct net_device *dev)
> +static void _rtl92e_dm_ctrl_initgain_byrssi(struct net_device *dev)
>   {
>   	struct r8192_priv *priv = rtllib_priv(dev);
>   	u8 i;

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

