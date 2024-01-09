Return-Path: <linux-kernel+bounces-20666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F9F828339
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECAD61C24A68
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E43133CFD;
	Tue,  9 Jan 2024 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhB5fRQ5"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666A42E650;
	Tue,  9 Jan 2024 09:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e741123acso2805933e87.0;
        Tue, 09 Jan 2024 01:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704792682; x=1705397482; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdolU0EUOihiv4P24pkLi7UHCL7sN9mCnSKzJVpdC60=;
        b=OhB5fRQ5LguOXWFMeVnEZISpWGj4ao7Xy3+KOeHoMauumDau18q979T+bs2woHCSx4
         oNYV4jWID1U7sxDTgvyStaCccNsCLpWIQnovJbS7MRMhpMeiUp/nm/PlbbzaMOfx7Sva
         96o1ejdJo+e2GAyA5+t2OT+FK1PQ6EpC5PDksVpcJWEUToedNBzk6GCtpyZtpWOUxX0B
         GTPvdzhhuTibBw482rvdrNijg9A4KCdKbEN22U7jXwvBZg9JTvgmh73qT5pVkfXQ1cIe
         g6BxmD0RMDh/BxUVS/N1+LPtL3xhPP+vr5RXbxyV742gcRnVZZ/OsBKoG6wqx0J1vcrQ
         Vr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704792682; x=1705397482;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fdolU0EUOihiv4P24pkLi7UHCL7sN9mCnSKzJVpdC60=;
        b=B8KRyXW56RM7py0N95olGuIgq5bYRJZzfXPloIdZM/lY6d8YhJVBuTcIiIT232ULDW
         1Jv5ahS9NVwv4SIL0iHqwqpMLFKJ61xgjSnMn+IpVI0BJ5W7eriVlHbmXXxPryDzRPwP
         CJSaoNQfgwJy0acWqo41Vdc4RN3C9muQN8JkbVi5xeR9zt7+oob4NYoWXtvUrfRum2fr
         akoDtvfILCehRZgJC+LYBsq3PrCGtBSYPjwLaWpsMuPBBJ/LASJsoJJwalLUoH4zdlOR
         UDEoxxjFpsCJUYWbM7KTxAIZGBZSm+y1Mts1yF0jq/FKybW9hO+704myGUe4KkmQxyHr
         GF2g==
X-Gm-Message-State: AOJu0YxQkjKM+MHWwlXqCxVJNneJXhpSwKSKGrDOuINJV/LWspVUX4Ls
	S2hlaAeTiSEmN0sJInSM8I1gk/2IoOQ=
X-Google-Smtp-Source: AGHT+IESVJ/YLD2uTnT3j2Rl1g58Yxup1gbLsz3UvJQEcPWd3BdOIIpMKOQ3OQB4Mjnn6tGAo2Ckig==
X-Received: by 2002:ac2:58d6:0:b0:50e:696e:150e with SMTP id u22-20020ac258d6000000b0050e696e150emr1755069lfo.7.1704792681797;
        Tue, 09 Jan 2024 01:31:21 -0800 (PST)
Received: from [192.168.1.105] ([178.176.74.61])
        by smtp.gmail.com with ESMTPSA id n30-20020ac2491e000000b0050e76a5624csm253765lfi.242.2024.01.09.01.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 01:31:21 -0800 (PST)
Subject: Re: [PATCH v3] usb: core: Prevent null pointer dereference in
 update_port_device_state
To: Udipto Goswami <quic_ugoswami@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alan Stern <stern@rowland.harvard.edu>
Cc: Krishna Kurapati <quic_kriskura@quicinc.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240109061708.26288-1-quic_ugoswami@quicinc.com>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <3bb51617-81e1-7d19-598d-2b57164320e1@gmail.com>
Date: Tue, 9 Jan 2024 12:31:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240109061708.26288-1-quic_ugoswami@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 1/9/24 9:17 AM, Udipto Goswami wrote:

> Currently,the function update_port_device_state gets the usb_hub from
> udev->parent by calling usb_hub_to_struct_hub.
> However, in case the actconfig or the maxchild is 0, the usb_hub would
> be NULL and upon further accessing to get port_dev would result in null
> pointer dereference.
> 
> Fix this by introducing an if check after the usb_hub is populated.
> 
> Fixes: 83cb2604f641 ("usb: core: add sysfs entry for usb device state")
> Cc: stable@vger.kernel.org
> Signed-off-by: Udipto Goswami <quic_ugoswami@quicinc.com>
> ---
> v3: Re-wrote the comment for better context.
> v2: Introduced comment for the if check & CC'ed stable.
> 
>  drivers/usb/core/hub.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index ffd7c99e24a3..6b514546e59b 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2053,9 +2053,23 @@ static void update_port_device_state(struct usb_device *udev)
>  
>  	if (udev->parent) {
>  		hub = usb_hub_to_struct_hub(udev->parent);
> -		port_dev = hub->ports[udev->portnum - 1];
> -		WRITE_ONCE(port_dev->state, udev->state);
> -		sysfs_notify_dirent(port_dev->state_kn);
> +
> +		/*
> +		 * The Link Layer Validation System Driver (lvstest)
> +		 * has procedure of unbinding the hub before running
> +		 * the rest of the procedure. This triggers
> +		 * hub_disconnect will set the hub's maxchild to 0.

   I can't parse this sentence, s/th is missing...

> +		 * This would result usb_hub_to_struct_hub in this
> +		 * function to return NULL.

   "This would result in usb_hub_to_struct_hub in this function
returning NULL", perhaps?

> +		 *
> +		 * Add if check to avoid running into NULL pointer
> +		 * de-reference.
> +		 */
> +		if (hub) {
> +			port_dev = hub->ports[udev->portnum - 1];
> +			WRITE_ONCE(port_dev->state, udev->state);
> +			sysfs_notify_dirent(port_dev->state_kn);
> +		}
>  	}
>  }
>  

MBR, Sergey

