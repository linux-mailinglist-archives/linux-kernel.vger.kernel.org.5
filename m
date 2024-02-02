Return-Path: <linux-kernel+bounces-50477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B1F84799C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3B041F2C82E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832BC15E5C6;
	Fri,  2 Feb 2024 19:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuBSU1Qa"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D6315E5BA;
	Fri,  2 Feb 2024 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706901888; cv=none; b=SLi7CyLyWND755U0BvkQmEcNqlngdis3dky3uM+54MKzHiGJLstEA/wQJfb1Tgy89Y/2IQqBsxwQ7GR4W2pvUkosA2rdVPy395Ztf6F+qXm9HIMqFujF5Y+30gzXi+KWMU43zSMJCUw2GZRtu2hc+YkosluRCIOztmBAQ1G3rjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706901888; c=relaxed/simple;
	bh=VzsNAmetuwaJAri48Hvu4bRMn6DOByRxemY4EnBT+zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wf6AveH+gwjEmcU/jAEq792Xokc/XKxWNNDpezGd9MzWnEeU1LZKL2ncPnJIFp2M6q8g6KJ41LTeBte52IVbZ6WOawpkd1ZBuBulFJkWJbpD7A8u7tEPNCVwGfhq/gHjfCozgTEA0IpIB+WfuK1jaaJXs6GuI2uhS+rtAwwXFRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuBSU1Qa; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-59502aa878aso1163279eaf.1;
        Fri, 02 Feb 2024 11:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706901886; x=1707506686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E2HCzONe6LgbNHkou0opA4ZegVuXZrSGIHqWmkGo0sw=;
        b=SuBSU1Qa7d6mHaKeLWpev3l54vWk5dqpszE1nIGLH3MtzIms8uEYX9imn5Mo+yja0/
         pgzetHCW1Ogk7G0ym2SivaBsl6GgSDz7cOAKIPqMr29JLR8TDlsicGyuh8WjQQ2F5jiV
         lI5ldMHQBQQ/lV3hWCgNaqFScsnonqjANjrMsnIYqf3yd4OYzvCAcauIb6oAmn+VWLVs
         j4kYKdruVbYjgcp9vUhci3nC23ESvwVBzR+QXSmCDWWxWYMvmHsClzlkYigQFmYq1CFs
         hDgsnbTeYHrCU2rVSwzaR9hw/kyM1j4pICf50oTR3ZbCDlp3vAwWA/JG5EoFlbclYbgo
         p39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706901886; x=1707506686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2HCzONe6LgbNHkou0opA4ZegVuXZrSGIHqWmkGo0sw=;
        b=k+XdX7DFBav81TJHi5Xb7jQT6RBKhXlSshxkLKlr6WqBPfa/yEn3yHDINFJyMb2Bnc
         68WlXtgLy9CIFiKC4nK3qwVYryPxM/kFynD6i79U6MKQxNyfaqgdpHo3WLkTHRbJEnYT
         mUVd+wRD9ClIRXBB1egI9qwvPeCtAFMToEff/a6vIO6Fx9ZZWcX134yW5Z/dHgBWWSwy
         awQpjC3t9pRqjqrc3zBBpMkIsWghdHSq79mwtO1QNe6Sm/IMWW3zeUcrJXm5DGl+CTsB
         C4QJMMRESkW1z7+G56hdPWfs9aN3bgb8Dl8KYqi02grCARvTYnlBlijSLF/RsKTbDzXy
         097Q==
X-Gm-Message-State: AOJu0YwneZM1DvfdhfQ2FVYT9thhfITAY4U8yQFl+8BuN4Ag8Tsb5CXH
	tVEd4Q9G90oFi52rksTG4ZAh4HvFoFmFGsr3GneqfLxwQbku3IFj
X-Google-Smtp-Source: AGHT+IGQNqqD/wy73YHkVD3ERsEwXagmrxTN8x3oRROnbC+hTIM4j4wdB7Vy0MsDSE3QgK1SaBwNrA==
X-Received: by 2002:a05:6359:4c0b:b0:178:950d:1175 with SMTP id kj11-20020a0563594c0b00b00178950d1175mr8935031rwc.13.1706901886015;
        Fri, 02 Feb 2024 11:24:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWMOJqxGVe94hngn8tQchgZJkhPSV7BBxVdzUCCUf5Jwle7mf0vpPo3EHFaXqVlZP4Hu2RZvPG35YT9M9TwYJ6R8+GbB+6277LC+DVjJA7RMB1T7NT2Qq+fpnmCrKUCPDi16TapMvWn7/ax2XtKTo5+5E9lClnX/opZV+Z6mim/hcqKAf2S8QbtiUbYloY+/qbDde28
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 28-20020a630e5c000000b005d553239b16sm2166377pgo.20.2024.02.02.11.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 11:24:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 2 Feb 2024 11:24:39 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jack Doan <me@jackdoan.com>
Cc: jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: Add MSI PSU HID monitoring driver
Message-ID: <4dbe0482-7165-4143-8d76-378ab1b25a0b@roeck-us.net>
References: <20240108185604.2858930-1-me@jackdoan.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108185604.2858930-1-me@jackdoan.com>

On Mon, Jan 08, 2024 at 11:56:04AM -0700, Jack Doan wrote:
> This driver provides a sysfs interface for MSI power supplies with a
> USB-HID monitoring interface.
> 
> Measurements for the output voltage and current for each rail are provided,
> as well as total output power, temperature, and fan control.
> 
> This patch adds:
> - hwmon driver msi-psu
> - hwmon documentation
> - updates MAINTAINERS
> 
> Signed-off-by: Jack Doan <me@jackdoan.com>
> ---
>  Documentation/hwmon/index.rst   |   1 +
>  Documentation/hwmon/msi-psu.rst |  64 +++
>  MAINTAINERS                     |   7 +
>  drivers/hwmon/Kconfig           |  12 +
>  drivers/hwmon/Makefile          |   1 +
>  drivers/hwmon/msi-psu.c         | 801 ++++++++++++++++++++++++++++++++
>  6 files changed, 886 insertions(+)
>  create mode 100644 Documentation/hwmon/msi-psu.rst
>  create mode 100644 drivers/hwmon/msi-psu.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 72f4e6065bae..34e4bc086bdb 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -159,6 +159,7 @@ Hardware Monitoring Kernel Drivers
>     mp2888
>     mp2975
>     mp5023
> +   msi-psu
>     nct6683
>     nct6775
>     nct7802
> diff --git a/Documentation/hwmon/msi-psu.rst b/Documentation/hwmon/msi-psu.rst
> new file mode 100644
> index 000000000000..3dda7190a627
> --- /dev/null
> +++ b/Documentation/hwmon/msi-psu.rst
> @@ -0,0 +1,64 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Kernel driver msi-psu
> +=========================
> +
> +Supported devices:
> +
> +* MSI MEG Ai1300P
> +
> +* MSI MEG Ai1000P
> +
> +Author: Jack Doan
> +
> +Description
> +-----------
> +
> +This driver provides a sysfs interface for MSI PSUs with a HID monitoring
> +interface.
> +
> +Measurements for the output voltage and current for each rail are provided,
> +as well as total output power, temperature, and fan control.
> +
> +Additional properties are available in debugfs, such as an efficiency
> +measurement, and switching to/from 12V multi-rail mode
> +
> +Sysfs entries
> +-------------
> +
> +============    ===============================================================
> +curr1_input     Current on the 12v psu rail
> +curr2_input     Current on the 5v psu rail
> +curr3_input     Current on the 3.3v psu rail
> +fan1_input      RPM of psu fan
> +in0_input       Voltage of the psu ac input
> +in1_input       Voltage of the 12v psu rail
> +in2_input       Voltage of the 5v psu rail
> +in3_input       Voltage of the 3.3v psu rail
> +power1_input    Total power usage
> +pwm1            PWM value for fan1. Writes to this file will switch set
> +                pwm1_enable to manual control mode.

No, that is unexpected and not supposed to happen.

> +pwm1_enable     PWM mode for fan1. (1) means "auto", and uses the built-in fan
> +                curve. (3) means manual control

The ABI (Documentation/ABI/testing/sysfs-class-hwmon) says:

                - 0: no fan speed control (i.e. fan at full speed)
                - 1: manual fan speed control enabled (using `pwmY`)
                - 2+: automatic fan speed control enabled

I really do not see the point of declaring that 1 shall mean automatic,
or to skip 2.

..

> +#define REPLY_SIZE 40 /* max length of a reply to a single command */

#define<space>NAME<tab>value

for all defines, please.

Guenter

