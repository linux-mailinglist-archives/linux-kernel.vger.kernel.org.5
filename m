Return-Path: <linux-kernel+bounces-91123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E848709CA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C1F1F215F5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22B378B41;
	Mon,  4 Mar 2024 18:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f8lPk11s"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9709D78690
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577775; cv=none; b=YaETla++Rm23WGnh+EGxQA/+J0oXh4qPBaaLa5WSY1hW1Zz73GMv5AYiIkSVZ9RGa1UhMLTogihdvJXql2tcLZB4TQKjILqLRYUP0lUK5Vw943BUg+QawOIg3N8GiWLQSt+bOm2SdKJCz66OxllZXCVMonFUMZfH4E+EFu1eawo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577775; c=relaxed/simple;
	bh=sy7J/3Uf9hlt3onS7yftJYHxlZc1w3pRFJcvG+xnVO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkDhasRzeB+Go91v8R5I8lAM+2bFNKzP80AKPcWk6zPETJ+GYy42vy71BuAQat+q9egVByVf7I5M5eQPvvmF4OCi9Kojb7F/jROTa2MB8s6OzlACGy77lv+/Eh0Y/PLfXvY33FprYsg90dZFC2E+ojFDuquqhK0xPe1PI8P2ZsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f8lPk11s; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso3462086a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 10:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709577773; x=1710182573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SM5uZvE85G8+vG8XJqLb9PlkllYek7aYYZFNBNAQhyM=;
        b=f8lPk11sKHvp2UXi4Ed5Xttbt3psq1w/897NREspKllzxpXAwcZ8Po+iM6QBv1WhzX
         CjHT+g+Yvmg0oL1Err5uorhuFknSJBsQSOG64ptbTJv/fTwiSJAPC4CWkdWJ8NkmmiTs
         UZG60Z688IkFs+vkmbQgTm6N32fFAlkQDDYL/+3oBxnX5AxqbQmeA7HIkXis4f8zpuoA
         GDhPYHMcp85fspXS0Kn+KyQHmraN8aDbyytTo38f+qxrCB46KjChQH1Bs+Yk8hQVVDr1
         VXq/7OzjXnfc1QpGcSkndO2aO5YKdJ+u/XOAVknlWiRdGjhBejLl+VixQtvW1S9uyeYQ
         xp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709577773; x=1710182573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SM5uZvE85G8+vG8XJqLb9PlkllYek7aYYZFNBNAQhyM=;
        b=HU2La31BBMWuOtzlFNgwbDxqFV6Uk8meC4Exne4K8dBl1YyeT1ONIJUb8a3DOuTscz
         6uACpftvO2iNuaz6iUDtLpw+O53jpyEkbHMgiWxKRO6eRTqeUMcnFEE1tp6l/qWNGTba
         mkVVkVp/OZdJEjCljT7fS6TVpCwIf3NB+Pd8iXpzHBTMPI9+fe7l/TOBFW5IvI2YWtsb
         T2aKTU9SoCJhGWs850TkCN0WBivKvdQ/p4VrwDGrYFwW8rT5KdDadM7e/4GkKtKDgOF+
         kUY4QSeb4T4QKt+YTM0vQsKmml072VRD5Xr3agDzymux82ybo5Niw06zT+HUkpz+OIlt
         ZNQw==
X-Forwarded-Encrypted: i=1; AJvYcCWCohn6mfVtVsiFgD9S0dsYAH1ua4Jdip/HOJ0UsLTynDzQbvCFlc3zI203tjC4X13ASfbAtwUJa646Dy2fBuUIeZt7atAobHjKbYOw
X-Gm-Message-State: AOJu0YwKIabxJKzb2WbFro3T0NhuqXtgBKH6NkAJCt37TGfJn0RD2kaJ
	9fHnv48o3r4cxf56/Nlklol4e3oyRIAKLmlU49yp35ZWYUUVBP5TQZArIEs/3GgcCQ+aFSZWf9y
	y
X-Google-Smtp-Source: AGHT+IECPDyDlAAakzo/VocZLl6Yj1VZB5Pjl5VCZCb2Do4EUEpl0tXD7//C4+5lGM7gVUCFptSxCA==
X-Received: by 2002:a17:90a:8d86:b0:29a:f005:9ad2 with SMTP id d6-20020a17090a8d8600b0029af0059ad2mr6928434pjo.42.1709577772850;
        Mon, 04 Mar 2024 10:42:52 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:164d:f5c6:5814:1e78])
        by smtp.gmail.com with ESMTPSA id qn12-20020a17090b3d4c00b00299bf19e872sm10368258pjb.44.2024.03.04.10.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 10:42:52 -0800 (PST)
Date: Mon, 4 Mar 2024 11:42:49 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: abdellatif.elkhlifi@arm.com
Cc: Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Drew.Reed@arm.com,
	Adam.Johnston@arm.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 1/3] remoteproc: Add Arm remoteproc driver
Message-ID: <ZeYWKVpeFm1+4mlT@p14s>
References: <20240301164227.339208-1-abdellatif.elkhlifi@arm.com>
 <20240301164227.339208-2-abdellatif.elkhlifi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301164227.339208-2-abdellatif.elkhlifi@arm.com>

Good day Abdellatif,

On Fri, Mar 01, 2024 at 04:42:25PM +0000, abdellatif.elkhlifi@arm.com wrote:
> From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> 
> introduce remoteproc support for Arm remote processors
> 
> The supported remote processors are those that come with a reset
> control register and a reset status register. The driver allows to
> switch on or off the remote processor.
> 
> The current use case is Corstone-1000 External System (Cortex-M3).
> 
> The driver can be extended to support other remote processors
> controlled with a reset control and a reset status registers.
> 
> The driver also supports control of multiple remote processors at the
> same time.
> 
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> ---
>  MAINTAINERS                    |   6 +
>  drivers/remoteproc/Kconfig     |  18 ++
>  drivers/remoteproc/Makefile    |   1 +
>  drivers/remoteproc/arm_rproc.c | 395 +++++++++++++++++++++++++++++++++
>  4 files changed, 420 insertions(+)
>  create mode 100644 drivers/remoteproc/arm_rproc.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d1052fa6a69..54d6a40feea5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1764,6 +1764,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/interrupt-controller/arm,vic.yaml
>  F:	drivers/irqchip/irq-vic.c
>  
> +ARM REMOTEPROC DRIVER
> +M:	Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> +L:	linux-remoteproc@vger.kernel.org
> +S:	Maintained
> +F:	drivers/remoteproc/arm_rproc.c
> +

Humm... I'm not sure this is needed for now.  You'll be CC'ed in future postings
anyway if someone changes this drivers.

>  ARM SMC WATCHDOG DRIVER
>  M:	Julius Werner <jwerner@chromium.org>
>  R:	Evan Benn <evanbenn@chromium.org>
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 48845dc8fa85..57fbac454a5d 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -365,6 +365,24 @@ config XLNX_R5_REMOTEPROC
>  
>  	  It's safe to say N if not interested in using RPU r5f cores.
>  
> +config ARM_REMOTEPROC
> +	tristate "Arm remoteproc support"
> +	depends on HAS_IOMEM && ARM64
> +	default n
> +	help
> +	  Say y here to support Arm remote processors via the remote
> +	  processor framework.
> +
> +	  The supported processors are those that come with a reset control register
> +	  and a reset status register. The design can be extended to support different
> +	  processors meeting these requirements.
> +	  The driver also supports control of multiple remote cores at the same time.
> +
> +	  Supported remote cores:
> +	      Corstone-1000 External System (Cortex-M3)
> +

Please remove.  The descrition in the Kconfig file should be related to a family
of device and the specific model number found in the driver.  

> +	  It's safe to say N here.
> +
>  endif # REMOTEPROC
>  
>  endmenu
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index 91314a9b43ce..73126310835b 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -39,3 +39,4 @@ obj-$(CONFIG_STM32_RPROC)		+= stm32_rproc.o
>  obj-$(CONFIG_TI_K3_DSP_REMOTEPROC)	+= ti_k3_dsp_remoteproc.o
>  obj-$(CONFIG_TI_K3_R5_REMOTEPROC)	+= ti_k3_r5_remoteproc.o
>  obj-$(CONFIG_XLNX_R5_REMOTEPROC)	+= xlnx_r5_remoteproc.o
> +obj-$(CONFIG_ARM_REMOTEPROC)		+= arm_rproc.o
> diff --git a/drivers/remoteproc/arm_rproc.c b/drivers/remoteproc/arm_rproc.c
> new file mode 100644
> index 000000000000..6afa78ae7ad3
> --- /dev/null
> +++ b/drivers/remoteproc/arm_rproc.c
> @@ -0,0 +1,395 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2024 Arm Limited and/or its affiliates <open-source-office@arm.com>
> + *
> + * Authors:
> + *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/firmware.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/remoteproc.h>
> +
> +#include "remoteproc_internal.h"
> +
> +/**
> + * struct arm_rproc_reset_cfg - remote processor reset configuration
> + * @ctrl_reg: address of the control register
> + * @state_reg: address of the reset status register
> + */
> +struct arm_rproc_reset_cfg {
> +	void __iomem *ctrl_reg;
> +	void __iomem *state_reg;
> +};
> +
> +struct arm_rproc;
> +

This is useless, please remove.

> +/**
> + * struct arm_rproc_dcfg - Arm remote processor configuration

Configuration?  This looks more like operations to me.  Please consider
renaming.

> + * @stop: stop callback function
> + * @start: start callback function
> + */
> +struct arm_rproc_dcfg {
> +	int (*stop)(struct rproc *rproc);
> +	int (*start)(struct rproc *rproc);
> +};
> +
> +/**
> + * struct arm_rproc - Arm remote processor instance
> + * @rproc: rproc handler
> + * @core_dcfg: device configuration pointer
> + * @reset_cfg: reset configuration registers
> + */
> +struct arm_rproc {
> +	struct rproc				*rproc;
> +	const struct arm_rproc_dcfg		*core_dcfg;
> +	struct arm_rproc_reset_cfg		reset_cfg;
> +};
> +
> +/* Definitions for Arm Corstone-1000 External System */
> +
> +#define EXTSYS_RST_CTRL_CPUWAIT			BIT(0)
> +#define EXTSYS_RST_CTRL_RST_REQ			BIT(1)
> +
> +#define EXTSYS_RST_ACK_MASK				GENMASK(2, 1)
> +#define EXTSYS_RST_ST_RST_ACK(x)			\
> +				((u8)(FIELD_GET(EXTSYS_RST_ACK_MASK, (x))))
> +
> +#define EXTSYS_RST_ACK_NO_RESET_REQ			(0x0)
> +#define EXTSYS_RST_ACK_NOT_COMPLETE			(0x1)
> +#define EXTSYS_RST_ACK_COMPLETE			(0x2)
> +#define EXTSYS_RST_ACK_RESERVED			(0x3)
> +
> +#define EXTSYS_RST_ACK_POLL_TRIES			(3)
> +#define EXTSYS_RST_ACK_POLL_TIMEOUT			(1000)

On my side most of the values above came out misaligned.

> +
> +/**
> + * arm_rproc_start_cs1000_extsys() - custom start function
> + * @rproc: pointer to the remote processor object
> + *
> + * Start function for Corstone-1000 External System.
> + * Allow the External System core start execute instructions.
> + *
> + * Return:
> + *
> + * 0 on success. Otherwise, failure
> + */
> +static int arm_rproc_start_cs1000_extsys(struct rproc *rproc)
> +{
> +	struct arm_rproc *priv = rproc->priv;
> +	u32 ctrl_reg;
> +
> +	/* CPUWAIT signal of the External System is de-asserted */
> +	ctrl_reg = readl(priv->reset_cfg.ctrl_reg);
> +	ctrl_reg &= ~EXTSYS_RST_CTRL_CPUWAIT;
> +	writel(ctrl_reg, priv->reset_cfg.ctrl_reg);
> +
> +	return 0;
> +}
> +
> +/**
> + * arm_rproc_cs1000_extsys_poll_rst_ack() - poll RST_ACK bits
> + * @rproc: pointer to the remote processor object
> + * @exp_ack: expected bits value
> + * @rst_ack: bits value read
> + *
> + * Tries to read RST_ACK bits until the timeout expires.
> + * EXTSYS_RST_ACK_POLL_TRIES tries are made,
> + * every EXTSYS_RST_ACK_POLL_TIMEOUT milliseconds.
> + *
> + * Return:
> + *
> + * 0 on success. Otherwise, failure
> + */
> +static int arm_rproc_cs1000_extsys_poll_rst_ack(struct rproc *rproc,
> +						u8 exp_ack, u8 *rst_ack)
> +{
> +	struct arm_rproc *priv = rproc->priv;
> +	struct device *dev = rproc->dev.parent;
> +	u32 state_reg;
> +	int tries = EXTSYS_RST_ACK_POLL_TRIES;
> +	unsigned long timeout;
> +
        struct device *dev = rproc->dev.parent;
	struct arm_rproc *priv = rproc->priv;
	int tries = EXTSYS_RST_ACK_POLL_TRIES;
	unsigned long timeout;
	u32 state_reg;

> +	do {
> +		state_reg = readl(priv->reset_cfg.state_reg);
> +		*rst_ack = EXTSYS_RST_ST_RST_ACK(state_reg);
> +
> +		if (*rst_ack == EXTSYS_RST_ACK_RESERVED) {
> +			dev_err(dev, "unexpected RST_ACK value: 0x%x\n",
> +				*rst_ack);
> +			return -EINVAL;
> +		}
> +
> +		/* expected ACK value read */
> +		if ((*rst_ack & exp_ack) || (*rst_ack == exp_ack))

I'm not sure why the second condition in this if() statement is needed.  As far
as I can tell the first condition will trigger and the second one won't be
reached.

> +			return 0;
> +
> +		timeout = msleep_interruptible(EXTSYS_RST_ACK_POLL_TIMEOUT);
> +
> +		if (timeout) {
> +			dev_err(dev, "polling RST_ACK  aborted\n");
> +			return -ECONNABORTED;
> +		}
> +	} while (--tries);
> +
> +	dev_err(dev, "polling RST_ACK timed out\n");
> +
> +	return -ETIMEDOUT;
> +}
> +
> +/**
> + * arm_rproc_stop_cs1000_extsys() - custom stop function
> + * @rproc: pointer to the remote processor object
> + *
> + * Reset all logic within the External System, the core will be in a halt state.
> + *
> + * Return:
> + *
> + * 0 on success. Otherwise, failure
> + */
> +static int arm_rproc_stop_cs1000_extsys(struct rproc *rproc)
> +{
> +	struct arm_rproc *priv = rproc->priv;
> +	struct device *dev = rproc->dev.parent;
> +	u32 ctrl_reg;
> +	u8 rst_ack, req_status;
> +	int ret;
> +

	struct device *dev = rproc->dev.parent;
	struct arm_rproc *priv = rproc->priv;
	u8 rst_ack, req_status;
	u32 ctrl_reg;
	int ret;

> +	ctrl_reg = readl(priv->reset_cfg.ctrl_reg);
> +	ctrl_reg |= EXTSYS_RST_CTRL_RST_REQ;
> +	writel(ctrl_reg, priv->reset_cfg.ctrl_reg);
> +
> +	ret = arm_rproc_cs1000_extsys_poll_rst_ack(rproc,
> +						   EXTSYS_RST_ACK_COMPLETE |
> +						   EXTSYS_RST_ACK_NOT_COMPLETE,
> +						   &rst_ack);
> +	if (ret)
> +		return ret;
> +
> +	req_status = rst_ack;
> +
> +	ctrl_reg = readl(priv->reset_cfg.ctrl_reg);
> +	ctrl_reg &= ~EXTSYS_RST_CTRL_RST_REQ;
> +	writel(ctrl_reg, priv->reset_cfg.ctrl_reg);
> +
> +	ret = arm_rproc_cs1000_extsys_poll_rst_ack(rproc, 0, &rst_ack);
> +	if (ret)
> +		return ret;
> +
> +	if (req_status == EXTSYS_RST_ACK_COMPLETE) {
> +		dev_dbg(dev, "the requested reset has been accepted\n");

Please remove

> +		return 0;
> +	}
> +
> +	dev_err(dev, "the requested reset has been denied\n");

There is enough error reporting in arm_rproc_cs1000_extsys_poll_rst_ack(),
please remove.

> +	return -EACCES;
> +}
> +
> +static const struct arm_rproc_dcfg arm_rproc_cfg_corstone1000_extsys = {
> +	.stop          = arm_rproc_stop_cs1000_extsys,
> +	.start         = arm_rproc_start_cs1000_extsys,
> +};
> +
> +/**
> + * arm_rproc_stop() - Stop function for rproc_ops
> + * @rproc: pointer to the remote processor object
> + *
> + * Calls the stop() callback of the remote core
> + *
> + * Return:
> + *
> + * 0 on success. Otherwise, failure
> + */
> +static int arm_rproc_stop(struct rproc *rproc)
> +{
> +	struct arm_rproc *priv = rproc->priv;
> +
> +	return priv->core_dcfg->stop(rproc);
> +}
> +
> +/**
> + * arm_rproc_start() - Start function for rproc_ops
> + * @rproc: pointer to the remote processor object
> + *
> + * Calls the start() callback of the remote core
> + *
> + * Return:
> + *
> + * 0 on success. Otherwise, failure
> + */
> +static int arm_rproc_start(struct rproc *rproc)
> +{
> +	struct arm_rproc *priv = rproc->priv;
> +
> +	return priv->core_dcfg->start(rproc);
> +}
> +
> +/**
> + * arm_rproc_parse_fw() - Parse firmware function for rproc_ops
> + * @rproc: pointer to the remote processor object
> + * @fw: pointer to the firmware
> + *
> + * Does nothing currently.
> + *
> + * Return:
> + *
> + * 0 for success.
> + */
> +static int arm_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
> +{
> +	return 0;
> +}
> +
> +/**
> + * arm_rproc_load() - Load firmware to memory function for rproc_ops
> + * @rproc: pointer to the remote processor object
> + * @fw: pointer to the firmware
> + *
> + * Does nothing currently.
> + *
> + * Return:
> + *
> + * 0 for success.
> + */
> +static int arm_rproc_load(struct rproc *rproc, const struct firmware *fw)
> +{

What is the point of doing rproc_of_parse_firmware() if the firmware image is
not loaded to memory?  Does the remote processor have some kind of default ROM
image to run if it doesn't find anything in memory?

> +	return 0;
> +}
> +
> +static const struct rproc_ops arm_rproc_ops = {
> +	.start		= arm_rproc_start,
> +	.stop		= arm_rproc_stop,
> +	.load		= arm_rproc_load,
> +	.parse_fw	= arm_rproc_parse_fw,
> +};
> +
> +/**
> + * arm_rproc_probe() - the platform device probe
> + * @pdev: the platform device
> + *
> + * Read from the device tree the properties needed to setup
> + * the reset and comms for the remote processor.
> + * Also, allocate a rproc device and register it with the remoteproc subsystem.
> + *
> + * Return:
> + *
> + * 0 on success. Otherwise, failure
> + */
> +static int arm_rproc_probe(struct platform_device *pdev)
> +{
> +	const struct arm_rproc_dcfg *core_dcfg;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct arm_rproc *priv;
> +	struct rproc *rproc;
> +	const char *fw_name;
> +	int ret;
> +	struct resource *res;
> +
> +	core_dcfg = of_device_get_match_data(dev);
> +	if (!core_dcfg)
> +		return -ENODEV;
> +
> +	ret = rproc_of_parse_firmware(dev, 0, &fw_name);
> +	if (ret) {
> +		dev_err(dev,
> +			"can't parse firmware-name from device tree (%pe)\n",
> +			ERR_PTR(ret));
> +		return ret;

Please replace with dev_err_probe().

> +	}
> +
> +	dev_dbg(dev, "firmware-name: %s\n", fw_name);
> +
> +	rproc = rproc_alloc(dev, np->name, &arm_rproc_ops, fw_name,
> +			    sizeof(*priv));

Using devm_rproc_alloc() would make this driver even more simple.

> +	if (!rproc)
> +		return -ENOMEM;
> +
> +	priv = rproc->priv;
> +	priv->rproc = rproc;
> +	priv->core_dcfg = core_dcfg;
> +
> +	res = platform_get_resource_byname(pdev,
> +					   IORESOURCE_MEM, "reset-control");
> +	priv->reset_cfg.ctrl_reg = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv->reset_cfg.ctrl_reg)) {
> +		ret = PTR_ERR(priv->reset_cfg.ctrl_reg);
> +		dev_err(dev,
> +			"can't map the reset-control register (%pe)\n",
> +			ERR_PTR((unsigned long)priv->reset_cfg.ctrl_reg));

dev_err_probe()

> +		goto err_free_rproc;

This isn't needed after moving to devm_rproc_alloc().

> +	} else {
> +		dev_dbg(dev, "reset-control: %p\n", priv->reset_cfg.ctrl_reg);
> +	}
> +
> +	res = platform_get_resource_byname(pdev,
> +					   IORESOURCE_MEM, "reset-status");
> +	priv->reset_cfg.state_reg = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv->reset_cfg.state_reg)) {
> +		ret = PTR_ERR(priv->reset_cfg.state_reg);
> +		dev_err(dev,
> +			"can't map the reset-status register (%pe)\n",
> +			ERR_PTR((unsigned long)priv->reset_cfg.state_reg));
> +		goto err_free_rproc;

Same comments as above.

> +	} else {
> +		dev_dbg(dev, "reset-status: %p\n",
> +			priv->reset_cfg.state_reg);

This isn't adding anything valuable, please remove.

> +	}
> +
> +	platform_set_drvdata(pdev, rproc);
> +
> +	ret = rproc_add(rproc);

devm_rproc_add()

> +	if (ret) {
> +		dev_err(dev, "can't add remote processor (%pe)\n",
> +			ERR_PTR(ret));
> +		goto err_free_rproc;
> +	} else {
> +		dev_dbg(dev, "remote processor added\n");

Please remove.

> +	}
> +
> +	return 0;
> +
> +err_free_rproc:
> +	rproc_free(rproc);
> +
> +	return ret;
> +}
> +
> +/**
> + * arm_rproc_remove() - the platform device remove
> + * @pdev: the platform device
> + *
> + * Delete and free the resources used.
> + */
> +static void arm_rproc_remove(struct platform_device *pdev)
> +{
> +	struct rproc *rproc = platform_get_drvdata(pdev);
> +
> +	rproc_del(rproc);
> +	rproc_free(rproc);
> +}

This shouldn't be needed anymore after using devm_rproc_alloc() and
devm_rproc_add().

> +
> +static const struct of_device_id arm_rproc_of_match[] = {
> +	{ .compatible = "arm,corstone1000-extsys", .data = &arm_rproc_cfg_corstone1000_extsys },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, arm_rproc_of_match);
> +
> +static struct platform_driver arm_rproc_driver = {
> +	.probe = arm_rproc_probe,
> +	.remove_new = arm_rproc_remove,
> +	.driver = {
> +		.name = "arm-rproc",
> +		.of_match_table = arm_rproc_of_match,
> +	},
> +};
> +module_platform_driver(arm_rproc_driver);
> +

I am echoing Krzysztof view about how generic this driver name is.  This has to
be related to a family of processors or be made less generic in some way.  Have
a look at what TI did for their K3 lineup [1] - I would like to see the same
thing done here.

Thanks,
Mathieu

[1]. https://elixir.bootlin.com/linux/latest/source/drivers/remoteproc/ti_k3_dsp_remoteproc.c#L898


> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Arm Remote Processor Control Driver");
> +MODULE_AUTHOR("Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>");
> -- 
> 2.25.1
> 

