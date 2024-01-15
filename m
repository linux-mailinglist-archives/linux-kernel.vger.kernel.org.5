Return-Path: <linux-kernel+bounces-25968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D9182D8F2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A4C2824F9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D89913AD4;
	Mon, 15 Jan 2024 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dF/BQG2m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0CB2919
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705322300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dr/8JgFmTBfE32B6mIfn3zI7m2veG/h6YX6miLSEnA4=;
	b=dF/BQG2meYsokrpIK1TteyFCzmHPR+phIROSnhnaYpdfVyk5jLjXC09e9i5dQFtGyPK7l7
	PdpXfMXMnUCQ9kiJ/r84xuc2iW4GyFGBn6pvK2nIlSIAqXojp95YYsOrXGXcGSmdpFpDZE
	kZGnlmlB7aS8ZJ2Vyj2MTnljc3fS1rk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-xGF4pUuGNnWdoI-_ZfdZVQ-1; Mon, 15 Jan 2024 07:38:19 -0500
X-MC-Unique: xGF4pUuGNnWdoI-_ZfdZVQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50e73a3a280so6139793e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 04:38:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705322298; x=1705927098;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dr/8JgFmTBfE32B6mIfn3zI7m2veG/h6YX6miLSEnA4=;
        b=u+KhBghbhcMqw2LIn9mKCosCuBOLQ+B0nlRyMcBvSrPKzbXWF4Vz/aNdWWTHG7EUPg
         VSe3axDVovvstuyAMmlfvB0w3QNWRY4E5DY46isBp5j7DFtQWWAAcNUainVy8kJCEBk2
         jFv9jas/yipM7BGcipifysvaVXP9Ho+MNnRjdWp26LCRrF19V+PT8b1OmLyvwIjWVTtf
         Kc70Jpj4k4ptYDJkebsb2TX69aaYRAtG8II+j1r0rAzW75tsACt+kImRSYADaWqrNzIa
         /jqHlvZGYt6TyCiTxB6uZUAcLzpICMQDtx74NP5j3BcfHDaKftRBLZx+e1KKoD6V9mtJ
         ATrg==
X-Gm-Message-State: AOJu0YxocUsm9PDn13iU9JRfZR97ay0QIkM4wnO1Vv+tyuCX5c/8dfCG
	6ZHLTTv2yeFx6sjMfpK1PWeYRYfpdk1e+xtuDbg2ax7feanUirJrumv/zJr71e+kuTdaVyde0JI
	g7nidrNpELDd6H/oveg7oc6289W0s6mzF
X-Received: by 2002:a05:6512:48c3:b0:50e:5049:a179 with SMTP id er3-20020a05651248c300b0050e5049a179mr1947810lfb.105.1705322297943;
        Mon, 15 Jan 2024 04:38:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEid8F0+Z+azt9DHERkU4iXM1IC9qS+5wiphoZcVWWiGGNKVpcy+TqeHGegNN/+7EtN/nPH0g==
X-Received: by 2002:a05:6512:48c3:b0:50e:5049:a179 with SMTP id er3-20020a05651248c300b0050e5049a179mr1947804lfb.105.1705322297567;
        Mon, 15 Jan 2024 04:38:17 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id z6-20020a170906668600b00a2327e826ccsm5216185ejo.201.2024.01.15.04.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 04:38:17 -0800 (PST)
Message-ID: <e776db0e-2376-415b-8688-f166118d4007@redhat.com>
Date: Mon, 15 Jan 2024 13:38:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: asus-wmi: Re-enable custom fan curves after
 setting throttle_thermal_policy
Content-Language: en-US
To: Andrei Sabalenka <mechakotik@gmail.com>, corentin.chary@gmail.com,
 ilpo.jarvinen@linux.intel.com, acpi4asus-user@lists.sourceforge.net,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Luke D. Jones" <luke@ljones.dev>
References: <20240115122315.10250-1-mechakotik@gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240115122315.10250-1-mechakotik@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/15/24 13:22, Andrei Sabalenka wrote:
> When changing throttle_thermal_policy, all the custom fan curves are getting disabled. This patch re-enables all the custom fan curves that were enabled before changing throttle_thermal_policy.
> 
> I believe it makes asus-wmi sysfs interface more convenient, as it allows userspace to manage fan curves independently from platform_profile and throttle_thermal_policy. At the kernel level, custom fan curves should not be tied to "power profiles" scheme in any way, as it gives the user less freedom of controlling them.

Setting a high performance power-profile typically also involves ramping up
the fans harder. So I don't think this patch is a good idea.

If you really want this behavior then you can always re-enable the custom
curve after changing the profile.

Luke, do you have any opinion on this?

Regards,

Hans




> 
> Signed-off-by: Andrei Sabalenka <mechakotik@gmail.com>
> ---
>  drivers/platform/x86/asus-wmi.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 18be35fdb..c2e38f6d8 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -3441,13 +3441,28 @@ static int throttle_thermal_policy_write(struct asus_wmi *asus)
>  		return -EIO;
>  	}
>  
> -	/* Must set to disabled if mode is toggled */
> -	if (asus->cpu_fan_curve_available)
> -		asus->custom_fan_curves[FAN_CURVE_DEV_CPU].enabled = false;
> -	if (asus->gpu_fan_curve_available)
> -		asus->custom_fan_curves[FAN_CURVE_DEV_GPU].enabled = false;
> -	if (asus->mid_fan_curve_available)
> -		asus->custom_fan_curves[FAN_CURVE_DEV_MID].enabled = false;
> +	/* Re-enable fan curves after profile change */
> +	if (asus->cpu_fan_curve_available && asus->custom_fan_curves[FAN_CURVE_DEV_CPU].enabled) {
> +		err = fan_curve_write(asus, &asus->custom_fan_curves[FAN_CURVE_DEV_CPU]);
> +		if (err) {
> +			pr_warn("Failed to re-enable CPU fan curve: %d\n", err);
> +			return err;
> +		}
> +	}
> +	if (asus->gpu_fan_curve_available && asus->custom_fan_curves[FAN_CURVE_DEV_GPU].enabled) {
> +		err = fan_curve_write(asus, &asus->custom_fan_curves[FAN_CURVE_DEV_GPU]);
> +		if (err) {
> +			pr_warn("Failed to re-enable GPU fan curve: %d\n", err);
> +			return err;
> +		}
> +	}
> +	if (asus->mid_fan_curve_available && asus->custom_fan_curves[FAN_CURVE_DEV_MID].enabled) {
> +		err = fan_curve_write(asus, &asus->custom_fan_curves[FAN_CURVE_DEV_MID]);
> +		if (err) {
> +			pr_warn("Failed to re-enable MID fan curve: %d\n", err);
> +			return err;
> +		}
> +	}
>  
>  	return 0;
>  }


