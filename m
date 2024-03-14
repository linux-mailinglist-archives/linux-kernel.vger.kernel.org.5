Return-Path: <linux-kernel+bounces-103646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560F387C269
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B54283561
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C5874C0E;
	Thu, 14 Mar 2024 18:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsmwSFDt"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2831A38D0;
	Thu, 14 Mar 2024 18:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710439739; cv=none; b=JB/6LwiuIQIZ+aaXe1nLpJT5KDVntPQbpkqdZ0u2WrE6vrLpd3YjL6pBpBbMLr7YFoemENPKfMN71GV6dwuLB4zxz1BjhLgO3oXpYB1O436+WhA5Ng2Wdam+qAOdqEPM4eYUv+YANqnAyRS0FnjtV/4lSztOuE6r/RJqZ2UtKqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710439739; c=relaxed/simple;
	bh=X6o8TSPFA25/+lbdQH4LC6ihPnyGKBsoHvc/7dwd6Kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aNCb4NfAHE55YeY7QFCSnzceyDdbKZwPhYtTDbAn9KSMV4eb6BoGDZiLJo5oCdQVjSNdJs5ZKOC92MVlc/5LWfS6z0SbHyTP84OoWlVnhls6Ry3iYGX0NCs/MdeoHwg6gjQvuyM4sVKFqOVbEP686kZGjx1tPHS6q9rgWdok2AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsmwSFDt; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e66817ff5dso576269a34.0;
        Thu, 14 Mar 2024 11:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710439736; x=1711044536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=O6QjNBOUXNMcsITHYgGLYglrjmHq8B75jMGMpg7X+sA=;
        b=HsmwSFDt3wGSK1HCL1hf0drafFWDlyIs6I165LRz233m7yIFvdZ7oOZ2MRpRSG+gHa
         Hqt0fgCHY6CEDSHIbHUkdJ2oXiw5zkwmTtAOtDPtJVcx2GZTVhBPIsY8VbX6d8JKRgy8
         OhQPvpg02wnKaYNEgIl60P8FvUqkJL38qtL+yIzzDp3vLnojQc2U/Zd9mzQ9hVpYCdCC
         zNdE6kC3ViB39mqBfPF81ILvNi+eOBEqzWaTUD1gZXzAHS2FrCKNxqx+i+neMTI7Z5Yp
         n4mhJtfatAYbm7ea15bFQeEBYHAB84PqpT02Xn2J+pgP5BGCQ4m8+AiWDX/3yU0i3q6m
         tQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710439736; x=1711044536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6QjNBOUXNMcsITHYgGLYglrjmHq8B75jMGMpg7X+sA=;
        b=TtMVXQf/9lDLugmVzw4E3xXJ7AvVbkshtYvagiqptDYLr+MdlEy9RTkOtbzOa5rslP
         LfVrZeXoIVuUzXG4LZMqe4/X/vdC+17svucXmdqtEO1AT72Ew2Hsw+328A954RbPsRux
         Za4v/E+XgukeTtSZ/Kq4eFU1Yuzrw+8C6IQ02GB4hUurFW0ObGQKOzJ9uBWM9T47Lh1/
         H+VnYjpLWBSt5bHUJor0OKerMQ4qh2dBNIUjcTQeWOt3eZFYAif/KpbgY1zYWBjRKdb6
         sveFnTpY001Jgzn5uskOHV9LNNKiqiu0HJiKZpuQlEYhOv+ykDY3Xe+f9wPb/7TD49Hi
         AXxA==
X-Forwarded-Encrypted: i=1; AJvYcCWtq6LH6D/hk6ISqSC5rRfwNnyAu8hidG3chFUfh8Ag/HJziHfczyOBvMJMCJ9mwbXkVY/CmByiR0MfVJ0UJZP7muyC5K6ENPRwQvsAZvAcwxCQIiZ1MIvulhodPJe84AF+pPgnkf8ceINHZn0=
X-Gm-Message-State: AOJu0YxTd7OriIlpo64hYxuWX4Oq7eGqEQ4miWwgTnybcI1j2PCF6Mp5
	rEZuStiTTKaoV4gtARBiLnec7+dskAcVAJrVqlk+kxaJYAea89bur+q9R09g
X-Google-Smtp-Source: AGHT+IEP1bedK+Yggcc37A6cZSW3SoeHE9/yvyPLi/Ng3EufKic3dCTFQ336z48Icdx9WwcHiuDtrw==
X-Received: by 2002:a9d:7c87:0:b0:6e6:7667:992e with SMTP id q7-20020a9d7c87000000b006e67667992emr964963otn.28.1710439736504;
        Thu, 14 Mar 2024 11:08:56 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id s5-20020a056830124500b006e51a824d56sm366857otp.51.2024.03.14.11.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 11:08:56 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <fd321855-0ee6-41ce-9cdf-364aa971f5f3@lwfinger.net>
Date: Thu, 14 Mar 2024 13:08:53 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] net: b43: Convert sprintf/snprintf to sysfs_emit
To: Li Zhijian <lizhijian@fujitsu.com>, linux-kernel@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 b43-dev@lists.infradead.org
References: <20240314094823.1324898-1-lizhijian@fujitsu.com>
 <20240314094823.1324898-2-lizhijian@fujitsu.com>
Content-Language: en-US
From: Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20240314094823.1324898-2-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/24 04:48, Li Zhijian wrote:
> Per filesystems/sysfs.rst, show() should only use sysfs_emit()
> or sysfs_emit_at() when formatting the value to be returned to user space.
> 
> coccinelle complains that there are still a couple of functions that use
> snprintf(). Convert them to sysfs_emit().
> 
> sprintf() will be converted as weel if they have.
> 
> Generally, this patch is generated by
> make coccicheck M=<path/to/file> MODE=patch \
> COCCI=scripts/coccinelle/api/device_attr_show.cocci
> 
> No functional change intended
> 
> CC: Larry Finger <Larry.Finger@lwfinger.net>
> CC: Kalle Valo <kvalo@kernel.org>
> CC: linux-wireless@vger.kernel.org
> CC: b43-dev@lists.infradead.org
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
> Split them per subsystem so that the maintainer can review it easily
> [1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
> ---
>   drivers/net/wireless/broadcom/b43/sysfs.c       | 13 ++++---------
>   drivers/net/wireless/broadcom/b43legacy/sysfs.c | 17 +++++++----------
>   2 files changed, 11 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/b43/sysfs.c b/drivers/net/wireless/broadcom/b43/sysfs.c
> index 0679d132968f..261b2b746a9c 100644
> --- a/drivers/net/wireless/broadcom/b43/sysfs.c
> +++ b/drivers/net/wireless/broadcom/b43/sysfs.c
> @@ -53,19 +53,14 @@ static ssize_t b43_attr_interfmode_show(struct device *dev,
>   
>   	switch (wldev->phy.g->interfmode) {
>   	case B43_INTERFMODE_NONE:
> -		count =
> -		    snprintf(buf, PAGE_SIZE,
> -			     "0 (No Interference Mitigation)\n");
> +		count = sysfs_emit(buf, "0 (No Interference Mitigation)\n");
>   		break;
>   	case B43_INTERFMODE_NONWLAN:
> -		count =
> -		    snprintf(buf, PAGE_SIZE,
> -			     "1 (Non-WLAN Interference Mitigation)\n");
> +		count = sysfs_emit(buf,
> +				   "1 (Non-WLAN Interference Mitigation)\n");
>   		break;
>   	case B43_INTERFMODE_MANUALWLAN:
> -		count =
> -		    snprintf(buf, PAGE_SIZE,
> -			     "2 (WLAN Interference Mitigation)\n");
> +		count = sysfs_emit(buf, "2 (WLAN Interference Mitigation)\n");
>   		break;
>   	default:
>   		B43_WARN_ON(1);
> diff --git a/drivers/net/wireless/broadcom/b43legacy/sysfs.c b/drivers/net/wireless/broadcom/b43legacy/sysfs.c
> index eec087ca30e6..b1c5ea4750fa 100644
> --- a/drivers/net/wireless/broadcom/b43legacy/sysfs.c
> +++ b/drivers/net/wireless/broadcom/b43legacy/sysfs.c
> @@ -75,16 +75,15 @@ static ssize_t b43legacy_attr_interfmode_show(struct device *dev,
>   
>   	switch (wldev->phy.interfmode) {
>   	case B43legacy_INTERFMODE_NONE:
> -		count = snprintf(buf, PAGE_SIZE, "0 (No Interference"
> -				 " Mitigation)\n");
> +		count = sysfs_emit(buf, "0 (No Interference" " Mitigation)\n");
>   		break;
>   	case B43legacy_INTERFMODE_NONWLAN:
> -		count = snprintf(buf, PAGE_SIZE, "1 (Non-WLAN Interference"
> -				 " Mitigation)\n");
> +		count = sysfs_emit(buf, "1 (Non-WLAN Interference"
> +				   " Mitigation)\n");
>   		break;
>   	case B43legacy_INTERFMODE_MANUALWLAN:
> -		count = snprintf(buf, PAGE_SIZE, "2 (WLAN Interference"
> -				 " Mitigation)\n");
> +		count = sysfs_emit(buf, "2 (WLAN Interference"
> +				   " Mitigation)\n");
>   		break;
>   	default:
>   		B43legacy_WARN_ON(1);
> @@ -155,11 +154,9 @@ static ssize_t b43legacy_attr_preamble_show(struct device *dev,
>   	mutex_lock(&wldev->wl->mutex);
>   
>   	if (wldev->short_preamble)
> -		count = snprintf(buf, PAGE_SIZE, "1 (Short Preamble"
> -				 " enabled)\n");
> +		count = sysfs_emit(buf, "1 (Short Preamble" " enabled)\n");
>   	else
> -		count = snprintf(buf, PAGE_SIZE, "0 (Short Preamble"
> -				 " disabled)\n");
> +		count = sysfs_emit(buf, "0 (Short Preamble" " disabled)\n");
>   
>   	mutex_unlock(&wldev->wl->mutex);
>   

The code changes are OK, but the subject should be "wifi: b43:", not "net: 
b43:". Kalle may be able to correct this when he applies the patch.

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Thanks,

Larry


