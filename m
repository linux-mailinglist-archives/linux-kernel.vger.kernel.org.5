Return-Path: <linux-kernel+bounces-45471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F32A84312D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96C0285B60
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABD0762D6;
	Tue, 30 Jan 2024 23:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amwcc2zX"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1AC7AE5B;
	Tue, 30 Jan 2024 23:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706657181; cv=none; b=Bj/aM9zmEP1V9n3yRLpc2C/9tovv6vK96ygouT6kTKGOqiF1O5S3CRa01j4elriNon3OKn37vN8jioOlNDGf03Z0rDEP0WRS70WcdMVZOdur8rwAlcGpn/Va5aHtUG4wKjjtDaUJP5Awy/vn6ettRo2kJZTykjosjOfCYgveSAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706657181; c=relaxed/simple;
	bh=gH/EOw2/islLgUYhN6dpfLl4WYA7kedk+j42fPzH0Yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QhydfwIo3MJQp0uQi41mBVCsc+UnWJO2OxqlNWMnBmH0pOvbndZ8JRHFy0wZ5iat7o9aPcW5YcxC+Auy36WV/Ic2nCzf510C/O6UJ13gwlXcV5JP0+VzRCZ6H1POylWINfV0ViBgMhb5/njL2gPZZH7SFOVLdjT1eYRRsDPqm+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amwcc2zX; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c00cfd7156so46772539f.0;
        Tue, 30 Jan 2024 15:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706657178; x=1707261978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kRoTzTxgBI5xqwAZuhcCYNJK5ig1u94EdajIZUuoskc=;
        b=amwcc2zXlbdUowOL4BAaO/xz2AH1z5W55aWlrM4bvgpA0pIHaFJVH8IW1NMLJgoHa6
         25tW1LPDOJn1sQ6VA83IJHwNXN+n6/yv5lIMP3pQE+b+a+9g9c6FFyAnORjVu0nqctc8
         vg4GNCfN+H+8j0vgcdF5bG69sISJTFyzrrBc7AkD1c/N75Uq1kO2cQPviQ1OT2K6WgcW
         vDmh+y9idCXQnVbkwBEW4w+NXQJLIGc5bs631ZJQS05qd1K2rRyYXoUTRl53vNhK/vSC
         oQmJq3mrAPt4f/ye9F/w3oFf9MRgdkUwb28qMV4/aCTL5HVnKL7WBOftgkKBGJH16s/n
         xWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706657178; x=1707261978;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRoTzTxgBI5xqwAZuhcCYNJK5ig1u94EdajIZUuoskc=;
        b=pMzdog/t2BXoeX5VhNAP24P7IeqVb2LpHzntnWDurmKLL3YR3ThOVU7k1LHw41xoU9
         X8xCUrigHsKWgFcdc2jjsu9BFaifwtmMFGgfPxFr5Bsnm5kw+8ew+T6rH2WwX79cO+Ab
         Zs8wonTwbcfKqqwRDIzEzs1VPzwDMGMvHTHPOnjWgslZahRMXrwtboEu8OQJhqZoryUN
         GyHp5AJELHwFebPZ8UKkA80WHlVekgbtwNf6GSr8TsplLRPeO7Pt0UDyCO5Y36+5wvO/
         949spedq46hCDuoeK8EpkGCFMnYkhcL3kdWBwjeGDg9NXSYewmzmotPHD4g4O7jLxC8p
         +pxA==
X-Gm-Message-State: AOJu0YzxQHNeb1eZ4+B9zXF9i6345yApAHBSVFxevl65TagHXVL6ba3f
	VdnBgfWZr2rneJbGbCSofT2zWZplB3SHw77W2sNw0JNrz8v51zbc8nDi7hR8
X-Google-Smtp-Source: AGHT+IG5NAcJP+cx5dI0us/TsXRpKHGdcbJNSRPpJf80MuWejOtCGvGJAPyweWXZWX+mcJZaGg1g7g==
X-Received: by 2002:a05:6e02:2389:b0:35f:b61f:a8a8 with SMTP id bq9-20020a056e02238900b0035fb61fa8a8mr78100ilb.26.1706657178176;
        Tue, 30 Jan 2024 15:26:18 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i65-20020a639d44000000b005bdbe9a597fsm7563429pgd.57.2024.01.30.15.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 15:26:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <975f0b2e-5cb0-480f-af96-b0bd5004e0b2@roeck-us.net>
Date: Tue, 30 Jan 2024 15:26:15 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] hwmon: add fan speed monitoring driver for Surface
 devices
Content-Language: en-US
To: Ivor Wanders <ivor@iwanders.net>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Maximilian Luz <luzmaximilian@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20240130230654.4218-1-ivor@iwanders.net>
 <20240130230654.4218-3-ivor@iwanders.net>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240130230654.4218-3-ivor@iwanders.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/24 15:06, Ivor Wanders wrote:
> Adds a driver that provides read only access to the fan speed for Microsoft
> Surface Pro devices. The fan speed is always regulated by the EC and cannot
> be influenced directly.
> 
> Signed-off-by: Ivor Wanders <ivor@iwanders.net>
> Link: https://github.com/linux-surface/kernel/pull/144
> Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> ---
> Changes in v4:
>    - Return 0 from surface_fan_hwmon_read instead of ret.
>    - Use PTR_ERR_OR_ZERO in probe instead of if statement.
> Changes in v3:
>    - Removed type and attr checks in read and is_visible.
>    - Removed assigning sdev to ssam_device drvdata.
>    - Propagate return from __ssam_fan_rpm_get.
>    - Renamed hwmon chip name from 'fan' to 'surface_fan'.
>    - Removed unnecessary platform_device header.
> Changes in v2:
>    - Removed all sysfs attributes except fan1_input. Simplified code
>      and updated documentation accordingly.
> ---
>   Documentation/hwmon/index.rst       |  1 +
>   Documentation/hwmon/surface_fan.rst | 25 ++++++++
>   MAINTAINERS                         |  8 +++
>   drivers/hwmon/Kconfig               | 13 +++++
>   drivers/hwmon/Makefile              |  1 +
>   drivers/hwmon/surface_fan.c         | 91 +++++++++++++++++++++++++++++
>   6 files changed, 139 insertions(+)
>   create mode 100644 Documentation/hwmon/surface_fan.rst
>   create mode 100644 drivers/hwmon/surface_fan.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 042e1cf95..4dfb3b9bd 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -202,6 +202,7 @@ Hardware Monitoring Kernel Drivers
>      smsc47m1
>      sparx5-temp
>      stpddc60
> +   surface_fan
>      sy7636a-hwmon
>      tc654
>      tc74
> diff --git a/Documentation/hwmon/surface_fan.rst b/Documentation/hwmon/surface_fan.rst
> new file mode 100644
> index 000000000..07942574c
> --- /dev/null
> +++ b/Documentation/hwmon/surface_fan.rst
> @@ -0,0 +1,25 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Kernel driver surface_fan
> +=========================
> +
> +Supported Devices:
> +
> +  * Microsoft Surface Pro 9
> +
> +Author: Ivor Wanders <ivor@iwanders.net>
> +
> +Description
> +-----------
> +
> +This provides monitoring of the fan found in some Microsoft Surface Pro devices,
> +like the Surface Pro 9. The fan is always controlled by the onboard controller.
> +
> +Sysfs interface
> +---------------
> +
> +======================= ======= =========================================
> +Name                    Perm    Description
> +======================= ======= =========================================
> +``fan1_input``          RO      Current fan speed in RPM.
> +======================= ======= =========================================
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 439cf523b..8e7870af3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14078,6 +14078,14 @@ F:	Documentation/driver-api/surface_aggregator/clients/dtx.rst
>   F:	drivers/platform/surface/surface_dtx.c
>   F:	include/uapi/linux/surface_aggregator/dtx.h
>   
> +MICROSOFT SURFACE SENSOR FAN DRIVER
> +M:	Maximilian Luz <luzmaximilian@gmail.com>
> +M:	Ivor Wanders <ivor@iwanders.net>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/hwmon/surface_fan.rst
> +F:	drivers/hwmon/surface_fan.c
> +
>   MICROSOFT SURFACE GPE LID SUPPORT DRIVER
>   M:	Maximilian Luz <luzmaximilian@gmail.com>
>   L:	platform-driver-x86@vger.kernel.org
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 307477b8a..4b4d999af 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1965,6 +1965,19 @@ config SENSORS_SMM665

I just noticed this. There is no SENSORS_SMM665 in the upstream kernel.
That driver was removed in v6.7. What is your baseline ? It doesn't even
seem to be based on a mainline kernel. When I try to apply the patch,
it fails completely.

Applying: hwmon: add fan speed monitoring driver for Surface devices
error: sha1 information is lacking or useless (MAINTAINERS).
error: could not build fake ancestor
Patch failed at 0001 hwmon: add fan speed monitoring driver for Surface devices

Please base your patches on the latest mainline kernel.

Thanks,
Guenter


