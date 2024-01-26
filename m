Return-Path: <linux-kernel+bounces-40312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543CF83DE44
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793561C21981
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AE61D557;
	Fri, 26 Jan 2024 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V864lOE7"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB13D1D527
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706285078; cv=none; b=oTH5g+Y236sXcLxvgA7Wg2VJQIZqxdAFy6X5KzPQuF6xCrqD14avySqnC0eZ6i5Vg8THUQUyx2tdCaZXAxNhHQkSpT+HAFTWUK6Q2CJfeeNVk2XEcNYJXxlkgrhNv+ueFrKTwsWcZWw212NMl2545tU8+J7ecxKTbVm92olvmO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706285078; c=relaxed/simple;
	bh=73RWoDQJtwPFPJEjV7O0ZLzfbhtb7+xMuK7/KiH5tD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USnrpq7UVB581ewwrr5iJH68x9PeeTNlRTvte4DI0mc20MoDuNg/45UEM/PxcPrPmN9cPfbIUA71M8+g8qPm3drZEO2ziSNFfEvQNMoP2s5A30ei+i7nNmUJZsNFnKqEQzoFNUvwIOStXMFgBt9Illb2dXAdVPDYIwQYNpklr3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V864lOE7; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6dc6f47302bso636251b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706285076; x=1706889876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ul7lxF0Nsmp5HrxxWvZJZpSzKEkv99O+cdJcdiUBsYM=;
        b=V864lOE7An0tkaP6HANdzXTYaHKP743fBfpQL6PfDfSSSjxgL5yMT6nyfN++VL4+6i
         SkTGctgKs7GNiZHxdWgtqMAIp4a2I3zvtS+qSRggWF5x9dlEe51aFWZifNLbD15lWf5A
         j+NXLTaujUf6Aj9ue0G1nM9/F3dnt25GoPXEKWvBRLHLOGaJVvRBZ0trCqAiMVPRUUr3
         AwP9W4Qd+dmi2aj4rzYrNoFgCYCj3TTJHwm7sUp5tuMclXoWbbtNBszsRjI/0IpFPswQ
         3OeJYdb8QqFBZnXQhDNOyCFZmdHSQlXC7UYrwTomTYbGPraHwhiIvDxGRfBMyI6NOgBP
         KM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706285076; x=1706889876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ul7lxF0Nsmp5HrxxWvZJZpSzKEkv99O+cdJcdiUBsYM=;
        b=ClnGUNNUR3uHal6TsXJw/ivlQl0Is34JW8nF3JmJxSjapR2DzU8nGXSMlLBPK+i/y6
         GnYpMI6MtsJfq5jSQNIOXdqdye5bn1sPr/ThEGalgNE03YuE8LiPEgSLUyJpJbCGqSKy
         xuMN1d+NKIfDZ0SlmkVI/aBXsa1GimdsRUcRN889fMU1TMIn4twNDsdesaUFZ2W2MV8N
         0vV1D9jK7YopfHrISpg+IX+BYHfhSLH00dFeimhr/5xg4urKoDoy3FHd9n9HFbAqbdJ1
         JQkp61MqZ46e65gCxfD3uQKvS8hYPodEW05DfTwasZ+m03THdUUvKHOy8b3kscBGMVzD
         /8+g==
X-Gm-Message-State: AOJu0YwG6z17iSYMET8tVi19y4fCfWCcfZymffF/nV8MJovcrbHhxiYU
	s7qwt3Tok7PXuOl63OdwfaMx/rWTNAhkB9LhveOX/y61hOXJrzisM4AsQdsjnqM=
X-Google-Smtp-Source: AGHT+IFjV3Xtg0kqffRx1AiTCWMwpOb43lYu7WyzExL6WlUk4vgTnNKvjLvUOojt6NQc3fyuQ9CWAg==
X-Received: by 2002:a05:6a20:da91:b0:19c:64a5:2162 with SMTP id iy17-20020a056a20da9100b0019c64a52162mr1880684pzb.20.1706285075918;
        Fri, 26 Jan 2024 08:04:35 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:4ad7:9f92:4f45:da3f])
        by smtp.gmail.com with ESMTPSA id fa20-20020a056a002d1400b006d70b0d4639sm1246182pfb.107.2024.01.26.08.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 08:04:35 -0800 (PST)
Date: Fri, 26 Jan 2024 09:04:32 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/4] remoteproc: Add TEE support
Message-ID: <ZbPYECIMZe2yopwk@p14s>
References: <20240118100433.3984196-1-arnaud.pouliquen@foss.st.com>
 <20240118100433.3984196-2-arnaud.pouliquen@foss.st.com>
 <ZbKuhOpXYUCv2Irc@p14s>
 <a751acaa-16f2-40eb-ab1b-7e1e5d937a2b@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a751acaa-16f2-40eb-ab1b-7e1e5d937a2b@foss.st.com>

On Fri, Jan 26, 2024 at 02:39:33PM +0100, Arnaud POULIQUEN wrote:
> Hi Mathieu,
> 
> On 1/25/24 19:55, Mathieu Poirier wrote:
> > Hi Arnaud,
> > 
> > On Thu, Jan 18, 2024 at 11:04:30AM +0100, Arnaud Pouliquen wrote:
> >> From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> >>
> >> Add a remoteproc TEE (Trusted Execution Environment) device
> > 
> > Device or driver?  Seems to be the latter...
> 
> Right, driver is better
> 
> > 
> >> that will be probed by the TEE bus. If the associated Trusted
> >> application is supported on secure part this device offers a client
> >> interface to load a firmware in the secure part.
> >> This firmware could be authenticated and decrypted by the secure
> >> trusted application.
> >>
> >> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> >> ---
> >>  drivers/remoteproc/Kconfig          |   9 +
> >>  drivers/remoteproc/Makefile         |   1 +
> >>  drivers/remoteproc/tee_remoteproc.c | 393 ++++++++++++++++++++++++++++
> >>  include/linux/tee_remoteproc.h      |  99 +++++++
> >>  4 files changed, 502 insertions(+)
> >>  create mode 100644 drivers/remoteproc/tee_remoteproc.c
> >>  create mode 100644 include/linux/tee_remoteproc.h
> >>
> >> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> >> index 48845dc8fa85..85299606806c 100644
> >> --- a/drivers/remoteproc/Kconfig
> >> +++ b/drivers/remoteproc/Kconfig
> >> @@ -365,6 +365,15 @@ config XLNX_R5_REMOTEPROC
> >>  
> >>  	  It's safe to say N if not interested in using RPU r5f cores.
> >>  
> >> +
> >> +config TEE_REMOTEPROC
> >> +	tristate "trusted firmware support by a TEE application"
> >> +	depends on OPTEE
> >> +	help
> >> +	  Support for trusted remote processors firmware. The firmware
> >> +	  authentication and/or decryption are managed by a trusted application.
> >> +	  This can be either built-in or a loadable module.
> >> +
> >>  endif # REMOTEPROC
> >>  
> >>  endmenu
> >> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> >> index 91314a9b43ce..fa8daebce277 100644
> >> --- a/drivers/remoteproc/Makefile
> >> +++ b/drivers/remoteproc/Makefile
> >> @@ -36,6 +36,7 @@ obj-$(CONFIG_RCAR_REMOTEPROC)		+= rcar_rproc.o
> >>  obj-$(CONFIG_ST_REMOTEPROC)		+= st_remoteproc.o
> >>  obj-$(CONFIG_ST_SLIM_REMOTEPROC)	+= st_slim_rproc.o
> >>  obj-$(CONFIG_STM32_RPROC)		+= stm32_rproc.o
> >> +obj-$(CONFIG_TEE_REMOTEPROC)		+= tee_remoteproc.o
> >>  obj-$(CONFIG_TI_K3_DSP_REMOTEPROC)	+= ti_k3_dsp_remoteproc.o
> >>  obj-$(CONFIG_TI_K3_R5_REMOTEPROC)	+= ti_k3_r5_remoteproc.o
> >>  obj-$(CONFIG_XLNX_R5_REMOTEPROC)	+= xlnx_r5_remoteproc.o
> >> diff --git a/drivers/remoteproc/tee_remoteproc.c b/drivers/remoteproc/tee_remoteproc.c
> >> new file mode 100644
> >> index 000000000000..49e1e0caf889
> >> --- /dev/null
> >> +++ b/drivers/remoteproc/tee_remoteproc.c
> >> @@ -0,0 +1,393 @@
> >> +// SPDX-License-Identifier: GPL-2.0-or-later
> >> +/*
> >> + * Copyright (C) STMicroelectronics 2023 - All Rights Reserved
> >> + * Author: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> >> + */
> >> +
> >> +#include <linux/firmware.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/io.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of_address.h>
> >> +#include <linux/of_device.h>
> >> +#include <linux/of_reserved_mem.h>
> >> +#include <linux/remoteproc.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/tee_drv.h>
> >> +#include <linux/tee_remoteproc.h>
> >> +
> >> +#include "remoteproc_internal.h"
> >> +
> >> +#define MAX_TEE_PARAM_ARRY_MEMBER	4
> >> +
> >> +/*
> >> + * Authentication of the firmware and load in the remote processor memory
> >> + *
> >> + * [in]  params[0].value.a:	unique 32bit identifier of the remote processor
> >> + * [in]	 params[1].memref:	buffer containing the image of the buffer
> >> + */
> >> +#define TA_RPROC_FW_CMD_LOAD_FW		1
> >> +
> >> +/*
> >> + * Start the remote processor
> >> + *
> >> + * [in]  params[0].value.a:	unique 32bit identifier of the remote processor
> >> + */
> >> +#define TA_RPROC_FW_CMD_START_FW	2
> >> +
> >> +/*
> >> + * Stop the remote processor
> >> + *
> >> + * [in]  params[0].value.a:	unique 32bit identifier of the remote processor
> >> + */
> >> +#define TA_RPROC_FW_CMD_STOP_FW		3
> >> +
> >> +/*
> >> + * Return the address of the resource table, or 0 if not found
> >> + * No check is done to verify that the address returned is accessible by
> >> + * the non secure context. If the resource table is loaded in a protected
> >> + * memory the access by the non secure context will lead to a data abort.
> >> + *
> >> + * [in]  params[0].value.a:	unique 32bit identifier of the remote processor
> >> + * [out]  params[1].value.a:	32bit LSB resource table memory address
> >> + * [out]  params[1].value.b:	32bit MSB resource table memory address
> >> + * [out]  params[2].value.a:	32bit LSB resource table memory size
> >> + * [out]  params[2].value.b:	32bit MSB resource table memory size
> >> + */
> >> +#define TA_RPROC_FW_CMD_GET_RSC_TABLE	4
> >> +
> >> +/*
> >> + * Return the address of the core dump
> >> + *
> >> + * [in]  params[0].value.a:	unique 32bit identifier of the remote processor
> >> + * [out] params[1].memref:	address of the core dump image if exist,
> >> + *				else return Null
> >> + */
> >> +#define TA_RPROC_FW_CMD_GET_COREDUMP	5
> >> +
> >> +struct tee_rproc_mem {
> >> +	char name[20];
> >> +	void __iomem *cpu_addr;
> >> +	phys_addr_t bus_addr;
> >> +	u32 dev_addr;
> >> +	size_t size;
> >> +};
> >> +
> >> +struct tee_rproc_context {
> >> +	struct list_head sessions;
> >> +	struct tee_context *tee_ctx;
> >> +	struct device *dev;
> >> +};
> >> +
> >> +static struct tee_rproc_context *tee_rproc_ctx;
> >> +
> >> +static void prepare_args(struct tee_rproc *trproc, int cmd, struct tee_ioctl_invoke_arg *arg,
> >> +			 struct tee_param *param, unsigned int num_params)
> >> +{
> >> +	memset(arg, 0, sizeof(*arg));
> >> +	memset(param, 0, MAX_TEE_PARAM_ARRY_MEMBER * sizeof(*param));
> >> +
> >> +	arg->func = cmd;
> >> +	arg->session = trproc->session_id;
> >> +	arg->num_params = num_params + 1;
> >> +
> >> +	param[0] = (struct tee_param) {
> >> +		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> >> +		.u.value.a = trproc->rproc_id,
> >> +	};
> >> +}
> >> +
> >> +int tee_rproc_load_fw(struct tee_rproc *trproc, const struct firmware *fw)
> >> +{
> >> +	struct tee_ioctl_invoke_arg arg;
> >> +	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
> >> +	struct tee_shm *fw_shm;
> >> +	int ret;
> >> +
> >> +	fw_shm = tee_shm_register_kernel_buf(tee_rproc_ctx->tee_ctx, (void *)fw->data, fw->size);
> >> +	if (IS_ERR(fw_shm))
> >> +		return PTR_ERR(fw_shm);
> >> +
> >> +	prepare_args(trproc, TA_RPROC_FW_CMD_LOAD_FW, &arg, param, 1);
> >> +
> >> +	/* Provide the address of the firmware image */
> >> +	param[1] = (struct tee_param) {
> >> +		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
> >> +		.u.memref = {
> >> +			.shm = fw_shm,
> >> +			.size = fw->size,
> >> +			.shm_offs = 0,
> >> +		},
> >> +	};
> >> +
> >> +	ret = tee_client_invoke_func(tee_rproc_ctx->tee_ctx, &arg, param);
> >> +	if (ret < 0 || arg.ret != 0) {
> >> +		dev_err(tee_rproc_ctx->dev,
> >> +			"TA_RPROC_FW_CMD_LOAD_FW invoke failed TEE err: %x, ret:%x\n",
> >> +			arg.ret, ret);
> >> +		if (!ret)
> >> +			ret = -EIO;
> >> +	}
> >> +
> >> +	tee_shm_free(fw_shm);
> >> +
> >> +	return ret;
> >> +}
> >> +EXPORT_SYMBOL_GPL(tee_rproc_load_fw);
> >> +
> >> +int rproc_tee_get_rsc_table(struct tee_rproc *trproc)
> >> +{
> >> +	struct tee_ioctl_invoke_arg arg;
> >> +	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
> >> +	struct rproc *rproc = trproc->rproc;
> >> +	size_t rsc_size;
> >> +	int ret;
> >> +
> >> +	prepare_args(trproc, TA_RPROC_FW_CMD_GET_RSC_TABLE, &arg, param, 2);
> >> +
> >> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
> >> +	param[2].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
> >> +
> >> +	ret = tee_client_invoke_func(tee_rproc_ctx->tee_ctx, &arg, param);
> >> +	if (ret < 0 || arg.ret != 0) {
> >> +		dev_err(tee_rproc_ctx->dev,
> >> +			"TA_RPROC_FW_CMD_GET_RSC_TABLE invoke failed TEE err: %x, ret:%x\n",
> >> +			arg.ret, ret);
> >> +		return -EIO;
> >> +	}
> >> +
> >> +	rsc_size = param[2].u.value.a;
> >> +
> >> +	/* If the size is null no resource table defined in the image */
> >> +	if (!rsc_size)
> >> +		return 0;
> >> +
> >> +	/* Store the resource table address that would be updated by the remote core . */
> >> +	trproc->rsc_va = ioremap_wc(param[1].u.value.a, rsc_size);
> >> +	if (IS_ERR_OR_NULL(trproc->rsc_va)) {
> >> +		dev_err(tee_rproc_ctx->dev, "Unable to map memory region: %lld+%zx\n",
> >> +			param[1].u.value.a, rsc_size);
> >> +		trproc->rsc_va = NULL;
> >> +		return -ENOMEM;
> >> +	}
> >> +
> >> +	/*
> >> +	 * A cached table is requested as the physical address is not mapped yet
> >> +	 * but remoteproc needs to parse the table for resources.
> >> +	 */
> >> +	rproc->cached_table = kmemdup((__force void *)trproc->rsc_va, rsc_size, GFP_KERNEL);
> >> +	if (!rproc->cached_table)
> >> +		return -ENOMEM;
> >> +
> >> +	rproc->table_ptr = rproc->cached_table;
> >> +	rproc->table_sz = rsc_size;
> >> +
> >> +	return 0;
> >> +}
> >> +EXPORT_SYMBOL_GPL(rproc_tee_get_rsc_table);
> >> +
> >> +struct resource_table *tee_rproc_get_loaded_rsc_table(struct tee_rproc *trproc)
> >> +{
> >> +	return (__force struct resource_table *)trproc->rsc_va;
> >> +}
> >> +EXPORT_SYMBOL_GPL(tee_rproc_get_loaded_rsc_table);
> >> +
> >> +int tee_rproc_start(struct tee_rproc *trproc)
> >> +{
> >> +	struct tee_ioctl_invoke_arg arg;
> >> +	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
> >> +	int ret;
> >> +
> >> +	prepare_args(trproc, TA_RPROC_FW_CMD_START_FW, &arg, param, 0);
> >> +
> >> +	ret = tee_client_invoke_func(tee_rproc_ctx->tee_ctx, &arg, param);
> >> +	if (ret < 0 || arg.ret != 0) {
> >> +		dev_err(tee_rproc_ctx->dev,
> >> +			"TA_RPROC_FW_CMD_START_FW invoke failed TEE err: %x, ret:%x\n",
> >> +			arg.ret, ret);
> >> +		if (!ret)
> >> +			ret = -EIO;
> >> +	}
> >> +
> >> +	return ret;
> >> +}
> >> +EXPORT_SYMBOL_GPL(tee_rproc_start);
> >> +
> >> +int tee_rproc_stop(struct tee_rproc *trproc)
> >> +{
> >> +	struct tee_ioctl_invoke_arg arg;
> >> +	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
> >> +	int ret;
> >> +
> >> +	prepare_args(trproc, TA_RPROC_FW_CMD_STOP_FW, &arg, param, 0);
> >> +
> >> +	ret = tee_client_invoke_func(tee_rproc_ctx->tee_ctx, &arg, param);
> >> +	if (ret < 0 || arg.ret != 0) {
> >> +		dev_err(tee_rproc_ctx->dev,
> >> +			"TA_RPROC_FW_CMD_STOP_FW invoke failed TEE err: %x, ret:%x\n",
> >> +			arg.ret, ret);
> >> +		if (!ret)
> >> +			ret = -EIO;
> >> +	}
> >> +	if (trproc->rsc_va)
> >> +		iounmap(trproc->rsc_va);
> >> +	trproc->rsc_va = NULL;
> >> +
> >> +	return ret;
> >> +}
> >> +EXPORT_SYMBOL_GPL(tee_rproc_stop);
> >> +
> >> +static const struct tee_client_device_id stm32_tee_rproc_id_table[] = {
> >> +	{UUID_INIT(0x80a4c275, 0x0a47, 0x4905,
> >> +		   0x82, 0x85, 0x14, 0x86, 0xa9, 0x77, 0x1a, 0x08)},
> >> +	{}
> >> +};
> >> +
> >> +struct tee_rproc *tee_rproc_register(struct device *dev, unsigned int rproc_id)
> >> +{
> >> +	struct tee_client_device *rproc_tee_device;
> >> +	struct tee_ioctl_open_session_arg sess_arg;
> >> +	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
> >> +	struct tee_rproc *trproc;
> >> +	int ret;
> >> +
> >> +	/*
> >> +	 * The device is not probed by the TEE bus. We ignore the reason (bus could be not yet
> >> +	 * probed or service not available in the secure firmware)
> >> +	 * Assumption here is that the TEE bus is not probed.
> >> +	 */
> >> +	if (!tee_rproc_ctx)
> >> +		return ERR_PTR(-EPROBE_DEFER);
> >> +
> >> +	trproc =  devm_kzalloc(dev, sizeof(*trproc), GFP_KERNEL);
> >> +	if (!trproc)
> >> +		return ERR_PTR(-ENOMEM);
> >> +
> >> +	rproc_tee_device = to_tee_client_device(tee_rproc_ctx->dev);
> >> +	memset(&sess_arg, 0, sizeof(sess_arg));
> >> +
> >> +	/* Open session with rproc_tee load the OP-TEE Trusted Application */
> >> +	memcpy(sess_arg.uuid, rproc_tee_device->id.uuid.b, TEE_IOCTL_UUID_LEN);
> >> +
> >> +	sess_arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
> >> +	sess_arg.num_params = 1;
> >> +
> >> +	param[0] = (struct tee_param) {
> >> +		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> >> +		.u.value.a = rproc_id,
> >> +	};
> >> +
> >> +	ret = tee_client_open_session(tee_rproc_ctx->tee_ctx, &sess_arg, param);
> >> +	if (ret < 0 || sess_arg.ret != 0) {
> >> +		dev_err(dev, "tee_client_open_session failed, err: %x\n", sess_arg.ret);
> >> +		return ERR_PTR(-EINVAL);
> >> +	}
> >> +
> >> +	trproc->parent =  dev;
> >> +	trproc->rproc_id = rproc_id;
> >> +	trproc->session_id = sess_arg.session;
> >> +
> >> +	list_add_tail(&trproc->node, &tee_rproc_ctx->sessions);
> >> +
> >> +	return trproc;
> >> +}
> >> +EXPORT_SYMBOL_GPL(tee_rproc_register);
> >> +
> >> +int tee_rproc_unregister(struct tee_rproc *trproc)
> >> +{
> >> +	int ret;
> >> +
> >> +	if (!tee_rproc_ctx)
> >> +		return -ENODEV;
> >> +
> >> +	ret = tee_client_close_session(tee_rproc_ctx->tee_ctx, trproc->session_id);
> >> +	if (ret < 0)
> >> +		dev_err(trproc->parent,	"tee_client_close_session failed, err: %x\n", ret);
> >> +
> >> +	list_del(&trproc->node);
> >> +
> >> +	return ret;
> >> +}
> >> +EXPORT_SYMBOL_GPL(tee_rproc_unregister);
> >> +
> >> +static int tee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
> >> +{
> >> +	/* Today we support only the OP-TEE, could be extend to other tees */
> >> +	return (ver->impl_id == TEE_IMPL_ID_OPTEE);
> >> +}
> >> +
> >> +static int tee_rproc_probe(struct device *dev)
> >> +{
> >> +	struct tee_context *tee_ctx;
> >> +	int ret;
> >> +
> >> +	/* Only one RPROC OP-TEE device allowed */
> >> +	if (tee_rproc_ctx) {
> >> +		dev_err(dev, "An RPROC OP-TEE device was already initialized: only one allowed\n");
> >> +		return -EBUSY;
> >> +	}
> >> +
> >> +	/* Open context with TEE driver */
> >> +	tee_ctx = tee_client_open_context(NULL, tee_ctx_match, NULL, NULL);
> >> +	if (IS_ERR(tee_ctx))
> >> +		return PTR_ERR(tee_ctx);
> >> +
> >> +	tee_rproc_ctx = devm_kzalloc(dev, sizeof(*tee_ctx), GFP_KERNEL);
> >> +	if (!tee_ctx) {
> >> +		ret = -ENOMEM;
> >> +		goto err;
> >> +	}
> >> +
> >> +	tee_rproc_ctx->dev = dev;
> >> +	tee_rproc_ctx->tee_ctx = tee_ctx;
> >> +	INIT_LIST_HEAD(&tee_rproc_ctx->sessions);
> >> +
> >> +	return 0;
> >> +err:
> >> +	tee_client_close_context(tee_ctx);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static int tee_rproc_remove(struct device *dev)
> >> +{
> >> +	struct tee_rproc *entry, *tmp;
> >> +
> >> +	list_for_each_entry_safe(entry, tmp, &tee_rproc_ctx->sessions, node) {
> >> +		tee_client_close_session(tee_rproc_ctx->tee_ctx, entry->session_id);
> >> +		list_del(&entry->node);
> >> +		kfree(entry);
> >> +	}
> >> +
> >> +	tee_client_close_context(tee_rproc_ctx->tee_ctx);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +MODULE_DEVICE_TABLE(tee, stm32_tee_rproc_id_table);
> >> +
> >> +static struct tee_client_driver tee_rproc_fw_driver = {
> >> +	.id_table	= stm32_tee_rproc_id_table,
> >> +	.driver		= {
> >> +		.name		= KBUILD_MODNAME,
> >> +		.bus		= &tee_bus_type,
> >> +		.probe		= tee_rproc_probe,
> >> +		.remove		= tee_rproc_remove,
> >> +	},
> >> +};
> >> +
> >> +static int __init tee_rproc_fw_mod_init(void)
> >> +{
> >> +	return driver_register(&tee_rproc_fw_driver.driver);
> >> +}
> >> +
> >> +static void __exit tee_rproc_fw_mod_exit(void)
> >> +{
> >> +	driver_unregister(&tee_rproc_fw_driver.driver);
> >> +}
> >> +
> >> +module_init(tee_rproc_fw_mod_init);
> >> +module_exit(tee_rproc_fw_mod_exit);
> >> +
> >> +MODULE_DESCRIPTION(" TEE remote processor control driver");
> >> +MODULE_LICENSE("GPL");
> >> diff --git a/include/linux/tee_remoteproc.h b/include/linux/tee_remoteproc.h
> >> new file mode 100644
> >> index 000000000000..537d6dc3b858
> >> --- /dev/null
> >> +++ b/include/linux/tee_remoteproc.h
> >> @@ -0,0 +1,99 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> >> +/*
> >> + * Copyright(c) 2023 STMicroelectronics - All Rights Reserved
> >> + */
> >> +
> >> +#ifndef TEE_REMOTEPROC_H
> >> +#define TEE_REMOTEPROC_H
> >> +
> >> +#include <linux/remoteproc.h>
> >> +#include <linux/tee_drv.h>
> >> +
> >> +/**
> >> + * struct tee_rproc - TEE remoteproc structure
> >> + * @node:		Reference in list
> >> + * @rproc:		Remoteproc reference
> >> + * @parent:		Parent device
> >> + * @rproc_id:		Identifier of the target firmware
> >> + * @session_id:		TEE session identifier
> >> + * @rsc_va:		Resource table virtual address.
> >> + */
> >> +struct tee_rproc {
> >> +	struct list_head node;
> >> +	struct rproc *rproc;
> >> +	struct device *parent;
> >> +	u32 rproc_id;
> >> +	u32 session_id;
> >> +	void __iomem *rsc_va;
> >> +};
> >> +
> >> +#if IS_ENABLED(CONFIG_TEE_REMOTEPROC)
> >> +
> >> +struct tee_rproc *tee_rproc_register(struct device *dev, unsigned int rproc_id);
> >> +int tee_rproc_unregister(struct tee_rproc *trproc);
> >> +
> >> +int tee_rproc_load_fw(struct tee_rproc *trproc, const struct firmware *fw);
> >> +int rproc_tee_get_rsc_table(struct tee_rproc *trproc);
> > 
> > Shouldn't this be tee_rproc_get_rsc_table()?  Why the exception?
> 
> No reason, just a miss during concatenation of patches to prepare the series.
> I will change this.
> 
> > 
> >> +struct resource_table *tee_rproc_get_loaded_rsc_table(struct tee_rproc *trproc);
> >> +int tee_rproc_start(struct tee_rproc *trproc);
> >> +int tee_rproc_stop(struct tee_rproc *trproc);
> >> +
> >> +#else
> >> +
> >> +static inline struct tee_rproc *tee_rproc_register(struct device *dev, unsigned int rproc_id)
> >> +{
> >> +	return ERR_PTR(-ENODEV);
> >> +}
> >> +
> >> +static inline int tee_rproc_unregister(struct tee_rproc *trproc)
> >> +{
> >> +	/* This shouldn't be possible */
> > 
> > Why can't this be possible?  Looking at the Kconfig file it seems entirely
> > plausible to compile stm32_rproc without TEE_REMOTEPROC...
> 
> This sentence is copied from rpmsg.h [1]. It is not possible to call the API if
> the TEE_REMOTEPROC is not set, as an error is returned by tee_rproc_register.

Yes, I see.  I agree with your assessment.

> Therefore, we should not fall into a state where we call this API or another one.
> 
> [1]https://elixir.bootlin.com/linux/v6.7.1/source/include/linux/rpmsg.h#L218
> 
> Thanks,
> Arnaud
> 
> > 
> > More comments to come tomorrow or on Monday.
> > 
> > Thanks,
> > Mathieu
> > 
> >> +	WARN_ON(1);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static inline int tee_rproc_load_fw(struct tee_rproc *trproc,
> >> +				    const struct firmware *fw)
> >> +{
> >> +	/* This shouldn't be possible */
> >> +	WARN_ON(1);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static inline int tee_rproc_start(struct tee_rproc *trproc)
> >> +{
> >> +	/* This shouldn't be possible */
> >> +	WARN_ON(1);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static inline int tee_rproc_stop(struct tee_rproc *trproc)
> >> +{
> >> +	/* This shouldn't be possible */
> >> +	WARN_ON(1);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static inline int rproc_tee_get_rsc_table(struct tee_rproc *trproc)
> >> +{
> >> +	/* This shouldn't be possible */
> >> +	WARN_ON(1);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static inline struct resource_table *
> >> +	tee_rproc_get_loaded_rsc_table(struct tee_rproc *trproc)
> >> +{
> >> +	/* This shouldn't be possible */
> >> +	WARN_ON(1);
> >> +
> >> +	return NULL;
> >> +}
> >> +
> >> +#endif /* CONFIG_TEE_REMOTEPROC */
> >> +#endif /* TEE_REMOTEPROC_H */
> >> -- 
> >> 2.25.1
> >>

