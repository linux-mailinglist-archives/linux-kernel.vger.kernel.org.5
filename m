Return-Path: <linux-kernel+bounces-7650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C7F81AB3A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E7DA284A1B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129324B153;
	Wed, 20 Dec 2023 23:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrET1FXL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5CF405D0;
	Wed, 20 Dec 2023 23:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6d741fb7c8eso235560b3a.2;
        Wed, 20 Dec 2023 15:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703116180; x=1703720980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/17HUnA1b2Ejc4Dlc4vTnouAPJSVQU1gDj3fmAp96k=;
        b=lrET1FXL2cLl9vTm9OUPIpMaC0thLIeCYIwfWvxD1eaKATww8fULiCAwb9tHXdaf4u
         JL+ZNPXBjwjNKDwuHDCJ2yjuqYJJ8b3AIRbyzdodzYZ9UcgL0WtByI11vmeDLR1uU2Bw
         1YnH02omBslLCsF7FlBskgrlsZmVKV09LRAdwALaFrTZzh8UL+CHdQQnPl9d4JV36r72
         XTt0hWLapfWU//a0b6BuQQS5d8TfRlVEl62DBBWYeCKVk6rsWipK3Ucuk2co6E+yNeIG
         mT8f2CPCXfNQT+DTeg37AkcoymqJV+De5ETuczYcv0bzqujvH8XgfPvurbFcYx3SrYiR
         VqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703116180; x=1703720980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/17HUnA1b2Ejc4Dlc4vTnouAPJSVQU1gDj3fmAp96k=;
        b=NGshURLuIp7hy7j3SPZLCg3dJ/M25JNz4s5jG9hDKej0Q2c2nPFlBpn7dppduFaWy0
         UHg0jUjZxDU0kyhQtd0+mRO3rzi8b31kqwrsqhG7vs58QOKf5tjn7hmOuyWc14LTzBOe
         xNczScfV7xVZ/ikou4jrWmOJIRY0Q9YrC7yBedUVlrQJZWtqLw59vTvErl4a8w8aeImF
         PFZyyIMN9dAJMBQtdkkfezQ/3g9Mqg56NcvzVDZumVZSGX/laE0w4/OndoR3gPz9f0Ke
         1QPA05qjbNVJcP6FxTxaNKvlPxyt6ippRXhNE77wjBhlVDX0c0uX87D6j+P3s7ydGhN0
         9qdQ==
X-Gm-Message-State: AOJu0Yxcz3nQ3GA3O/POHGVgL2RHWxfN2hnEpP4tOcGX4COlGEPmThQu
	3zPplutnGAK9mgF0eKfjIiJ7YoJ9Q4A=
X-Google-Smtp-Source: AGHT+IF0Zz9EXJXS7XTNxW20sWwUHwuO06q5sxXyyFzX6Llnr7DDDeM97k9UU2OcZARgAMMP/w76CA==
X-Received: by 2002:a05:6a00:2da6:b0:6d9:35c3:e78a with SMTP id fb38-20020a056a002da600b006d935c3e78amr4298616pfb.24.1703116179844;
        Wed, 20 Dec 2023 15:49:39 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c7-20020a056a00008700b006cd88728572sm305053pfj.211.2023.12.20.15.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 15:49:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 20 Dec 2023 15:49:38 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (acpi_power_meter) Install IPMI handler for Dell
 systems
Message-ID: <5a81eda0-5044-4088-9aba-cf725e6fca9a@roeck-us.net>
References: <20231220051350.392350-1-kai.heng.feng@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220051350.392350-1-kai.heng.feng@canonical.com>

On Wed, Dec 20, 2023 at 01:13:50PM +0800, Kai-Heng Feng wrote:
> The following error can be observed at boot:
> [    3.717920] ACPI Error: No handler for Region [SYSI] (00000000ab9e62c5) [IPMI] (20230628/evregion-130)
> [    3.717928] ACPI Error: Region IPMI (ID=7) has no handler (20230628/exfldio-261)
> 
> [    3.717936] No Local Variables are initialized for Method [_GHL]
> 
> [    3.717938] No Arguments are initialized for method [_GHL]
> 
> [    3.717940] ACPI Error: Aborting method \_SB.PMI0._GHL due to previous error (AE_NOT_EXIST) (20230628/psparse-529)
> [    3.717949] ACPI Error: Aborting method \_SB.PMI0._PMC due to previous error (AE_NOT_EXIST) (20230628/psparse-529)
> [    3.717957] ACPI: \_SB_.PMI0: _PMC evaluation failed: AE_NOT_EXIST
> 
> On Dell systems several methods of acpi_power_meter access variables in
> IPMI region [0], so request module 'ipmi_si' which will load 'acpi_ipmi'
> and install the region handler accordingly.
> 
> [0] https://www.dell.com/support/manuals/en-us/redhat-enterprise-linux-v8.0/rhel8_rn_pub/advanced-configuration-and-power-interface-acpi-error-messages-displayed-in-dmesg?guid=guid-0d5ae482-1977-42cf-b417-3ed5c3f5ee62
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/hwmon/acpi_power_meter.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> index 703666b95bf4..b9db53166bc9 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -882,6 +882,8 @@ static int acpi_power_meter_add(struct acpi_device *device)
>  	strcpy(acpi_device_name(device), ACPI_POWER_METER_DEVICE_NAME);
>  	strcpy(acpi_device_class(device), ACPI_POWER_METER_CLASS);
>  	device->driver_data = resource;
> +	if (dmi_match(DMI_SYS_VENDOR, "Dell Inc."))
> +		request_module("ipmi_si");
>  

This looks like a terrible hack to me. Is there precedent of similar hacks
elsewhere showing that this is the "way to go" ?

Guenter

>  	res = read_capabilities(resource);
>  	if (res)
> -- 
> 2.34.1
> 

