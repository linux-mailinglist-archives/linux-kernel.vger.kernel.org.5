Return-Path: <linux-kernel+bounces-45375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C87B842F6C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A7C1C22C5B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A837D40A;
	Tue, 30 Jan 2024 22:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebptkNaT"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2415A7D3FE;
	Tue, 30 Jan 2024 22:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706652675; cv=none; b=JhWF83+QNv+8UIB+FSEd7v70WE8Fs8nGLKl6Uq9Ovqin3hdNO3/DXduwoDi6/C3F+GOjXgZc5ytpOUYZCr3/M909jcvMJuO/r7PiwbMsXMe+/lycqMcCN1MWtxSNJWDYrjMjMB4Lcpbjp6gkrc6H/gV9nM2g7sKSNm33MYSAIK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706652675; c=relaxed/simple;
	bh=oSqyi3mVU7QS7x2jYdyUrY+3NHGEMVnwrT6hR/v/aRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KUocElNqwB1hBlwt8h247DGtd8gINspLjxgeEIRtfHhbnbZR53nlItbIz8HwFa+VP4jR812XXllk+z9M5dp7lBho0nbHUI3TpVqL0qk/kOAuZzZHzgsai0CPnHf/OJrfLuEBD+G2X5dHVdZkRkGuAD75R8KBKudWyYRO3xogF9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebptkNaT; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3604697d63so266956166b.3;
        Tue, 30 Jan 2024 14:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706652672; x=1707257472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QUnCuHfqCBV79IBZ5Lp4urGXCgccRoBnaSQQzC74PU0=;
        b=ebptkNaTzp77P8bhvkYxqqGDkvMqiBm1SUIJR420iwl1U7qXN/qKFNVwATUo2nVk11
         +UPX0ldO4EKkmGEALcsCh8IPi6Y3+ECBcUZqEtpSWArB+vtJASyw15OwzMVyxT6lp+zt
         3PuwkxDboFJ2whEld6pJ1MK++HiuoPJY09DHArodFAi8TwtTCCL3Njj3QyO23w+FDuhq
         ZUxxy0Tm/H6Tki91LpAz9ohjvJTjbpiaPET1FvqrL8znqeo/jqch83+fZhygcCvz3LXS
         z3uAN1zRU3mrha+bPxM9ajzwpC6PAuUiyuLP0tQMLFFeRgagpe51lO1NcvWUU0FRn2La
         PV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706652672; x=1707257472;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUnCuHfqCBV79IBZ5Lp4urGXCgccRoBnaSQQzC74PU0=;
        b=ryaaHFX7bHH2xkb0wUC3pBtN5aflggJWY/+lNq6P8FT6F6XTe7WmemaUfbiaDs9Jq5
         NFThHnjYT7OxpKAboZPr2cCAhoAy5Ulc+Bag3aRxxj0CFIWKcsy2yNjwxVMnX5bVFu3n
         THYR8M3iLUGKU+9F3/opgmd/W+6a6QJjWDaPsn/rpVupbFYziWKiNdKucXmG04SDqlxO
         MGOq9ARt2RE+irDlPyWHA5CNy3Lfu9+lqaIc7o4kCTlE7Mao6SxIa/18RDdOZNpAAHyd
         RR+cMk8DCb0hb7xYHj06/4WksplLXk/4/VhoyYp1dp2FXXkG7yT3arIOQc3yh174drx5
         fR4Q==
X-Gm-Message-State: AOJu0Yw574BMokV9zO/MbgYPhGe6uHVOa/hniSGpP35dD4nmC0L3SCjp
	jwQTSZAYOnGgEWZNDIDHbqRrssjRMm4IXWbiL8G9bL4XDyjGKhlrBGy5HAHF+nYvig==
X-Google-Smtp-Source: AGHT+IFwBEq2SN1TkzJhORjzTidgitEvGlR+ee3NWHMI5YMKUAgWABFG0sQru6oK7k3oWKV61P4n3g==
X-Received: by 2002:a17:906:6712:b0:a35:2f7a:385b with SMTP id a18-20020a170906671200b00a352f7a385bmr7230560ejp.23.1706652671994;
        Tue, 30 Jan 2024 14:11:11 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:7400:ff68:7ab4:4169? (2a02-8389-41cf-e200-7400-ff68-7ab4-4169.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:7400:ff68:7ab4:4169])
        by smtp.gmail.com with ESMTPSA id vu2-20020a170907a64200b00a35a9745910sm2988697ejc.137.2024.01.30.14.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 14:11:11 -0800 (PST)
Message-ID: <7d7382d6-4999-4519-86c5-34f6c175e83f@gmail.com>
Date: Tue, 30 Jan 2024 23:11:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Input: bcm5974 - check endpoint type before starting
 traffic
Content-Language: en-US
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 John Horan <knasher@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+348331f63b034f89b622@syzkaller.appspotmail.com
References: <20231007-topic-bcm5974_bulk-v3-1-d0f38b9d2935@gmail.com>
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20231007-topic-bcm5974_bulk-v3-1-d0f38b9d2935@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14.10.23 12:20, Javier Carrasco wrote:
> syzbot has found a type mismatch between a USB pipe and the transfer
> endpoint, which is triggered by the bcm5974 driver[1].
> 
> This driver expects the device to provide input interrupt endpoints and
> if that is not the case, the driver registration should terminate.
> 
> Repros are available to reproduce this issue with a certain setup for
> the dummy_hcd, leading to an interrupt/bulk mismatch which is caught in
> the USB core after calling usb_submit_urb() with the following message:
> "BOGUS urb xfer, pipe 1 != type 3"
> 
> Some other device drivers (like the appletouch driver bcm5974 is mainly
> based on) provide some checking mechanism to make sure that an IN
> interrupt endpoint is available. In this particular case the endpoint
> addresses are provided by a config table, so the checking can be
> targeted to the provided endpoints.
> 
> Add some basic checking to guarantee that the endpoints available match
> the expected type for both the trackpad and button endpoints.
> 
> This issue was only found for the trackpad endpoint, but the checking
> has been added to the button endpoint as well for the same reasons.
> 
> Given that there was never a check for the endpoint type, this bug has
> been there since the first implementation of the driver (f89bd95c5c94).
> 
> [1] https://eur04.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsyzkaller.appspot.com%2Fbug%3Fextid%3D348331f63b034f89b622&data=05%7C01%7Cjavier.carrasco%40wolfvision.net%7C1880f48b0ac1493b40ff08dbcc9f2ea8%7Ce94ec9da9183471e83b351baa8eb804f%7C1%7C0%7C638328756279240780%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=IOsiHpWoIkog8HHkYIY8Ljh762bPZiqgm5xd5oAbK3s%3D&reserved=0
> 
> Fixes: f89bd95c5c94 ("Input: bcm5974 - add driver for Macbook Air and Pro Penryn touchpads")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Reported-and-tested-by: syzbot+348331f63b034f89b622@syzkaller.appspotmail.com
> ---
> Changes in v3:
> - Use usb_check_int_endpoints() to validate the endpoints.
> - Link to v2: https://eur04.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fr%2F20231007-topic-bcm5974_bulk-v2-1-021131c83efb%40gmail.com&data=05%7C01%7Cjavier.carrasco%40wolfvision.net%7C1880f48b0ac1493b40ff08dbcc9f2ea8%7Ce94ec9da9183471e83b351baa8eb804f%7C1%7C0%7C638328756279240780%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=vqLE9mUP0ehBIgtI%2F52ONRsF1wOrikc0VVLrp6MMjqQ%3D&reserved=0
> 
> Changes in v2:
> - Keep error = -ENOMEM for the rest of the probe and return -ENODEV if
>   the endpoint check fails.
> - Check function returns now bool and was renamed (_is_ for
>   bool-returning functions).
> - Link to v1: https://eur04.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fr%2F20231007-topic-bcm5974_bulk-v1-1-355be9f8ad80%40gmail.com&data=05%7C01%7Cjavier.carrasco%40wolfvision.net%7C1880f48b0ac1493b40ff08dbcc9f2ea8%7Ce94ec9da9183471e83b351baa8eb804f%7C1%7C0%7C638328756279240780%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=Qf6kg4M2AvwSEpkwClGPpVdo1PO96WfUfTsiy6z28UI%3D&reserved=0
> ---
>  drivers/input/mouse/bcm5974.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
> index ca150618d32f..953992b458e9 100644
> --- a/drivers/input/mouse/bcm5974.c
> +++ b/drivers/input/mouse/bcm5974.c
> @@ -19,6 +19,7 @@
>   * Copyright (C) 2006	   Nicolas Boichat (nicolas@boichat.ch)
>   */
>  
> +#include "linux/usb.h"
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
>  #include <linux/slab.h>
> @@ -193,6 +194,8 @@ enum tp_type {
>  
>  /* list of device capability bits */
>  #define HAS_INTEGRATED_BUTTON	1
> +/* maximum number of supported endpoints (currently trackpad and button) */
> +#define MAX_ENDPOINTS	2
>  
>  /* trackpad finger data block size */
>  #define FSIZE_TYPE1		(14 * sizeof(__le16))
> @@ -891,6 +894,18 @@ static int bcm5974_resume(struct usb_interface *iface)
>  	return error;
>  }
>  
> +static bool bcm5974_check_endpoints(struct usb_interface *iface,
> +				    const struct bcm5974_config *cfg)
> +{
> +	u8 ep_addr[MAX_ENDPOINTS + 1] = {0};
> +
> +	ep_addr[0] = cfg->tp_ep;
> +	if (cfg->tp_type == TYPE1)
> +		ep_addr[1] = cfg->bt_ep;
> +
> +	return usb_check_int_endpoints(iface, ep_addr);
> +}
> +
>  static int bcm5974_probe(struct usb_interface *iface,
>  			 const struct usb_device_id *id)
>  {
> @@ -903,6 +918,11 @@ static int bcm5974_probe(struct usb_interface *iface,
>  	/* find the product index */
>  	cfg = bcm5974_get_config(udev);
>  
> +	if (!bcm5974_check_endpoints(iface, cfg)) {
> +		dev_err(&iface->dev, "Unexpected non-int endpoint\n");
> +		return -ENODEV;
> +	}
> +
>  	/* allocate memory for our device state and initialize it */
>  	dev = kzalloc(sizeof(struct bcm5974), GFP_KERNEL);
>  	input_dev = input_allocate_device();
> 
> ---
> base-commit: 401644852d0b2a278811de38081be23f74b5bb04
> change-id: 20231007-topic-bcm5974_bulk-c66b743ba7ba
> 
> Best regards,

Gentle reminder: this bug keeps on being found by syzbot and it was
included in the last monthly input report (Jan 2024):

https://lore.kernel.org/all/0000000000001df937060f20c585@google.com/T/

Best regards,
Javier Carrasco



