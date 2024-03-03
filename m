Return-Path: <linux-kernel+bounces-89842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F266D86F65D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 18:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20C01B210F2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC5376413;
	Sun,  3 Mar 2024 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iH1y7myg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85CD763FF;
	Sun,  3 Mar 2024 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709486279; cv=none; b=gTo/oY82lpK0A9z2Z7x7gG3X2NFdVrNH8XrI2P33+aBstuOIz8aWMrglAR/Irsuo8onED3UOA8n4du8rgxjAYM0hI2oB4wsHtZ+n/+xWdtbZyK14mEvamNDljh/dbtFUMjlHU0RLqQMNocXZ1TzP34BAKy0hz8AmN+1CrvQXGJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709486279; c=relaxed/simple;
	bh=e2vLTaT13n49nCRwisq0j838Udy0Mga3nNilU4HTi5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PD+nwqmdVr8v4bsNf2hwXNIRHh1xatZyz1MwPOhTs65HycxI3r+OAiRX5u7kNn8QW17ArDBlbeTM9wgc+irOQJuKa+08PE3fTsB1qFmcnkwF9k2MOecEYpXkQh38lJ8ZIYE4r8+B+qrdsEsAahnNV3Jqb1jW9b5Liez4k7pfARA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iH1y7myg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82AAC433C7;
	Sun,  3 Mar 2024 17:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709486278;
	bh=e2vLTaT13n49nCRwisq0j838Udy0Mga3nNilU4HTi5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iH1y7mygqKShFhfj4UQ+YK55YbGPqMV1gEya3Ft9iqJJ8ZcCRSDP9zp/IXq5ngA/N
	 zv68BBtYyI5drdYheCk4IHgNZuO5wzHcoJNciouZU//CsO2u0k8uD4cz68LX3XENd3
	 jFNG3wxAFwtPe/bvotntZhcjsBHxIaOvQxIBsQoY=
Date: Sun, 3 Mar 2024 18:17:55 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Canfeng Zhuang <quic_czhuang@quicinc.com>
Cc: Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] misc: qualcomm: QRC driver for Robotic SDK MCU
Message-ID: <2024030343-protrude-unlocking-31ac@gregkh>
References: <20240304-qcom_qrc-v1-0-2a709f95fd61@quicinc.com>
 <20240304-qcom_qrc-v1-1-2a709f95fd61@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-qcom_qrc-v1-1-2a709f95fd61@quicinc.com>

On Mon, Mar 04, 2024 at 12:53:16AM +0800, Canfeng Zhuang wrote:
> QRC Driver support functions:

What is "QRC"?

> - Read data from serial device port.
> - Write data to serial device port.

Shouldn't you be doing that in userspace?  Why is this a kernel driver?

> - Pin control reset robotic controller.
> 
> Signed-off-by: Canfeng Zhuang <quic_czhuang@quicinc.com>
> ---
>  drivers/misc/Kconfig        |   1 +
>  drivers/misc/Makefile       |   1 +
>  drivers/misc/qrc/Kconfig    |  16 ++
>  drivers/misc/qrc/Makefile   |   6 +
>  drivers/misc/qrc/qrc_core.c | 336 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/misc/qrc/qrc_core.h | 143 ++++++++++++++++++

Why do you have a .h file for a single driver?

>  drivers/misc/qrc/qrc_uart.c | 345 ++++++++++++++++++++++++++++++++++++++++++++
>  7 files changed, 848 insertions(+)
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 4fb291f0bf7c..a43108af6fde 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -591,4 +591,5 @@ source "drivers/misc/cardreader/Kconfig"
>  source "drivers/misc/uacce/Kconfig"
>  source "drivers/misc/pvpanic/Kconfig"
>  source "drivers/misc/mchp_pci1xxxx/Kconfig"
> +source "drivers/misc/qrc/Kconfig"
>  endmenu
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index ea6ea5bbbc9c..ab3b2c4d99fa 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -68,3 +68,4 @@ obj-$(CONFIG_TMR_INJECT)	+= xilinx_tmr_inject.o
>  obj-$(CONFIG_TPS6594_ESM)	+= tps6594-esm.o
>  obj-$(CONFIG_TPS6594_PFSM)	+= tps6594-pfsm.o
>  obj-$(CONFIG_NSM)		+= nsm.o
> +obj-$(CONFIG_QCOM_QRC)		+= qrc/
> diff --git a/drivers/misc/qrc/Kconfig b/drivers/misc/qrc/Kconfig
> new file mode 100644
> index 000000000000..994985d7c320
> --- /dev/null
> +++ b/drivers/misc/qrc/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# QRC device driver configuration
> +#
> +
> +menu "QCOM QRC device driver"
> +
> +config QCOM_QRC
> +	tristate "QCOM QRC device driver for Robotic SDK MCU"

What is "QCOM", "QRC", SDK", and "MCU"?

> +	help
> +	  This kernel configuration is used to enable robotic controller
> +	  device driver. Say M here if you want to enable robotic
> +	  controller device driver.

Please write more here, this doesn't really describe what is happening.

> +	  When in doubt, say N.
> +
> +endmenu
> diff --git a/drivers/misc/qrc/Makefile b/drivers/misc/qrc/Makefile
> new file mode 100644
> index 000000000000..da2cf81f3c59
> --- /dev/null
> +++ b/drivers/misc/qrc/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Makefile for the QRC bus specific drivers.
> +
> +
> +obj-$(CONFIG_QCOM_QRC)		+= qrc_core.o qrc_uart.o

Why is a single driver 2 different files?

> diff --git a/drivers/misc/qrc/qrc_core.c b/drivers/misc/qrc/qrc_core.c
> new file mode 100644
> index 000000000000..5cedb050dac4
> --- /dev/null
> +++ b/drivers/misc/qrc/qrc_core.c
> @@ -0,0 +1,336 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* driver/misc/qrc/qrc_core.c

Why is the filename here?

> + *
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/sched.h>
> +#include <linux/init.h>
> +#include <linux/cdev.h>
> +#include <linux/slab.h>
> +#include <linux/poll.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/gpio.h>
> +#include <linux/delay.h>
> +
> +#include "qrc_core.h"
> +
> +#define QRC_DEVICE_NAME "qrc"

KBUILD_MODNAME.

> +static dev_t qrc_devt;
> +static struct class *qrc_class;

Please use class_register(), not class_create().

I've stopped here, please get someone in your group to review this
before sending it out again, you have internal experience with kernel
drivers, please take advantage of it.

thanks,

greg k-h

