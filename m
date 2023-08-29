Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8943378CD42
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbjH2UBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238219AbjH2UBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:01:42 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DE91B9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 13:01:38 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68a3b66f350so4137879b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 13:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693339298; x=1693944098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ChvkLVt5w3Q2cbAQM4vYA5GoOX5KIxx/qYAM03iwTHM=;
        b=gb4jomrJsLIZ/Yb0zUBuHSRwWQLJmaktjjeE0uGAVEUsKMbgQMaIJXyvHuUOb3fXMf
         V5k65nhJeH9pK9kH/1cC3xVR8DvOxou5tabpleR0HnGfnJMkTkPVwiHbM6a/g4D2GOWi
         qgxgos5CfK7dolc0CNR9IoLIup/rnEFzj1w81Il8zC/+ccKb4x2Ys+MfLC/IS6hoaEaf
         setPKeV4XcStr0nOPCSoWNrIFNxqhn3uLwKul8EGSYg/gqcNENrbaE3ur0ClwgJ2KLhq
         iaZ1lQFpITvcRxQr/vmasgIb+8SOTQ3P0yX8HwJN4ULUloTfiBXkZajI3Vn4cXUSsFWl
         okCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693339298; x=1693944098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ChvkLVt5w3Q2cbAQM4vYA5GoOX5KIxx/qYAM03iwTHM=;
        b=HreqWL4dxZSCPK9jFAh8nYt2gQtfCwTOj+rsRTQnOxB7jqtVX38yMoJcH4u/Yd7OgY
         D4sOUjVRnaZrx7XgQrA3PQAB+OnCAa6PEwqZqLJGmAGpumIX6sAigCoB0mrBJ3TapZx5
         csaHJqHzJrth6aqrsLbESM3U0Dx+M+cH0SpttJcFC5jEVSCcfZwGwlZrHqvMDrNkv6hO
         hu0tKy6M31QqApTiHNUhyaW6Gg5cizJa0v3Fd9tQiyX+Yy1CqQNk/CNUpxuDDulN7vQb
         Ku2NU/RwdQ8/REZVpRZQ0yI1HXxGk1xmJ2mSjiDlboJXEUUcQq9ZF/4Te+y4ZJto966r
         Nh8A==
X-Gm-Message-State: AOJu0Yx6pMG9mNgehzTxaA1SHQwRlC8FrmCnlMCZA7WFKq71UsWRI8JJ
        7chzDiJXNVUHD1vdNZwQmQEN3l7sqQMXSGvIeQo=
X-Google-Smtp-Source: AGHT+IGdONEz+Ij/6vvpNJSG+ndmI+otJQTogNUUBQKIM0htSmA0rHogV6+Peie6jxkyOHjZwf8gEw==
X-Received: by 2002:a05:6a21:99a2:b0:14c:c511:385c with SMTP id ve34-20020a056a2199a200b0014cc511385cmr354355pzb.58.1693339297885;
        Tue, 29 Aug 2023 13:01:37 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:2d5e:515:f0b9:8087])
        by smtp.gmail.com with ESMTPSA id b26-20020aa7811a000000b006883561b421sm8866599pfi.162.2023.08.29.13.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 13:01:37 -0700 (PDT)
Date:   Tue, 29 Aug 2023 14:01:34 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Hari Nagalla <hnagalla@ti.com>
Cc:     andersson@kernel.org, p.zabel@pengutronix.de,
        martyn.welch@collabora.com, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 5/5] remoteproc: k3-m4: Add a remoteproc driver for
 M4F subsystem
Message-ID: <ZO5OnjJAQJC0UCq+@p14s>
References: <20230808044529.25925-1-hnagalla@ti.com>
 <20230808044529.25925-6-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808044529.25925-6-hnagalla@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 11:45:29PM -0500, Hari Nagalla wrote:
> From: Martyn Welch <martyn.welch@collabora.com>
> 
> The AM62x and AM64x SoCs of the TI K3 family has a Cortex M4F core in
> the MCU domain. This core is typically used for safety applications in a
> stand alone mode. However, some application (non safety related) may
> want to use the M4F core as a generic remote processor with IPC to the
> host processor. The M4F core has internal IRAM and DRAM memories and are
> exposed to the system bus for code and data loading.
> 
> A remote processor driver is added to support this subsystem, including
> being able to load and boot the M4F core. Loading includes to M4F
> internal memories and predefined external code/data memories. The
> carve outs for external contiguous memory is defined in the M4F device
> node and should match with the external memory declarations in the M4F
> image binary. The M4F subsystem has two resets. One reset is for the
> entire subsystem i.e including the internal memories and the other, a
> local reset is only for the M4F processing core. When loading the image,
> the driver first releases the subsystem reset, loads the firmware image
> and then releases the local reset to let the M4F processing core run.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> ---
> Changes since v1:
>  - Addressed minor review comments (refactoring completed in separate
>    patch)
> 
> Changes since v2:
>  - Refactoring completed first, thus smaller change
> 
> Changes since v3:
>  - Removed 'ipc_only' flag and made changes in probe() to enact right
>    operations
>  - Fixed spelling mistakes in commit message
>  - Changed some 'dev_err' messages to 'dev_info'
>  - Removed unnecessary checks rproc state
> 
> Changes since v4:
>  - None
> 
>  drivers/remoteproc/Kconfig               |  13 +
>  drivers/remoteproc/Makefile              |   1 +
>  drivers/remoteproc/ti_k3_common.h        |   7 +-
>  drivers/remoteproc/ti_k3_m4_remoteproc.c | 333 +++++++++++++++++++++++
>  4 files changed, 353 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/remoteproc/ti_k3_m4_remoteproc.c
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 48845dc8fa85..85c1a3a2b987 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -339,6 +339,19 @@ config TI_K3_DSP_REMOTEPROC
>  	  It's safe to say N here if you're not interested in utilizing
>  	  the DSP slave processors.
>  
> +config TI_K3_M4_REMOTEPROC
> +	tristate "TI K3 M4 remoteproc support"
> +	depends on ARCH_K3
> +	select MAILBOX
> +	select OMAP2PLUS_MBOX
> +	help
> +	  Say m here to support TI's M4 remote processor subsystems
> +	  on various TI K3 family of SoCs through the remote processor
> +	  framework.
> +
> +	  It's safe to say N here if you're not interested in utilizing
> +	  a remote processor.
> +
>  config TI_K3_R5_REMOTEPROC
>  	tristate "TI K3 R5 remoteproc support"
>  	depends on ARCH_K3
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index 55c552e27a45..e30908ca4bfc 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -37,5 +37,6 @@ obj-$(CONFIG_ST_REMOTEPROC)		+= st_remoteproc.o
>  obj-$(CONFIG_ST_SLIM_REMOTEPROC)	+= st_slim_rproc.o
>  obj-$(CONFIG_STM32_RPROC)		+= stm32_rproc.o
>  obj-$(CONFIG_TI_K3_DSP_REMOTEPROC)	+= ti_k3_dsp_remoteproc.o ti_k3_common.o
> +obj-$(CONFIG_TI_K3_M4_REMOTEPROC)	+= ti_k3_m4_remoteproc.o ti_k3_common.o
>  obj-$(CONFIG_TI_K3_R5_REMOTEPROC)	+= ti_k3_r5_remoteproc.o
>  obj-$(CONFIG_XLNX_R5_REMOTEPROC)	+= xlnx_r5_remoteproc.o
> diff --git a/drivers/remoteproc/ti_k3_common.h b/drivers/remoteproc/ti_k3_common.h
> index 917a9c82b4cf..5de014e1065f 100644
> --- a/drivers/remoteproc/ti_k3_common.h
> +++ b/drivers/remoteproc/ti_k3_common.h
> @@ -2,11 +2,15 @@
>  /*
>   * TI K3 Remote Processor(s) driver common code
>   *
> - * Refactored from ti_k3_dsp_remoteproc.c.
> + * Refactored from ti_k3_dsp_remoteproc.c and ti_k3_m4_remoteproc.c.

How can this be refactored from ti_k3_m4_remoteproc.c when it did not exists
before this patchset? 

>   *
>   * ti_k3_dsp_remoteproc.c:
>   * Copyright (C) 2018-2022 Texas Instruments Incorporated - https://www.ti.com/
>   *	Suman Anna <s-anna@ti.com>
> + *
> + * ti_k3_m4_remoteproc.c:
> + * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
> + *	Hari Nagalla <hnagalla@ti.com>
>   */
>  
>  #ifndef REMOTEPROC_TI_K3_COMMON_H
> @@ -82,6 +86,7 @@ struct k3_rproc {
>  	u32 ti_sci_id;
>  	struct mbox_chan *mbox;
>  	struct mbox_client client;
> +	bool ipc_only;

From the comments above this should have been removed.

I will not move forward with the rest of this patch.  I am done reviewing this
version.

Thanks,
Mathieu

>  };
>  
>  void k3_rproc_kick(struct rproc *rproc, int vqid);
> diff --git a/drivers/remoteproc/ti_k3_m4_remoteproc.c b/drivers/remoteproc/ti_k3_m4_remoteproc.c
> new file mode 100644
> index 000000000000..010b3a2fc1fa
> --- /dev/null
> +++ b/drivers/remoteproc/ti_k3_m4_remoteproc.c
> @@ -0,0 +1,333 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * TI K3 Cortex-M4 Remote Processor(s) driver
> + *
> + * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
> + *	Hari Nagalla <hnagalla@ti.com>
> + */
> +
> +#include <linux/io.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/omap-mailbox.h>
> +#include <linux/platform_device.h>
> +#include <linux/remoteproc.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +
> +#include "omap_remoteproc.h"
> +#include "remoteproc_internal.h"
> +#include "ti_sci_proc.h"
> +#include "ti_k3_common.h"
> +
> +/*
> + * Power up the M4F remote processor.
> + *
> + * This function will be invoked only after the firmware for this rproc
> + * was loaded, parsed successfully, and all of its resource requirements
> + * were met. This callback is invoked only in remoteproc mode.
> + */
> +static int k3_m4_rproc_start(struct rproc *rproc)
> +{
> +	struct k3_rproc *kproc = rproc->priv;
> +	struct device *dev = kproc->dev;
> +	u32 boot_addr;
> +	int ret;
> +
> +	ret = k3_rproc_request_mbox(rproc);
> +	if (ret)
> +		return ret;
> +
> +	boot_addr = rproc->bootaddr;
> +	ret = k3_rproc_release(kproc);
> +	if (ret)
> +		goto put_mbox;
> +
> +	return 0;
> +
> +put_mbox:
> +	mbox_free_channel(kproc->mbox);
> +	return ret;
> +}
> +
> +/*
> + * Stop the M4 remote processor.
> + *
> + * This function puts the M4 processor into reset, and finishes processing
> + * of any pending messages. This callback is invoked only in remoteproc mode.
> + */
> +static int k3_m4_rproc_stop(struct rproc *rproc)
> +{
> +	struct k3_rproc *kproc = rproc->priv;
> +	struct device *dev = kproc->dev;
> +
> +	mbox_free_channel(kproc->mbox);
> +
> +	k3_rproc_reset(kproc);
> +
> +	return 0;
> +}
> +
> +/*
> + * Attach to a running M4 remote processor (IPC-only mode)
> + *
> + * This rproc attach callback only needs to request the mailbox, the remote
> + * processor is already booted, so there is no need to issue any TI-SCI
> + * commands to boot the M4 core. This callback is used only in IPC-only mode.
> + */
> +static int k3_m4_rproc_attach(struct rproc *rproc)
> +{
> +	struct k3_rproc *kproc = rproc->priv;
> +	struct device *dev = kproc->dev;
> +	int ret;
> +
> +	ret = k3_rproc_request_mbox(rproc);
> +	if (ret)
> +		return ret;
> +
> +	dev_info(dev, "M4 initialized in IPC-only mode\n");
> +	return 0;
> +}
> +
> +/*
> + * Detach from a running M4 remote processor (IPC-only mode)
> + *
> + * This rproc detach callback performs the opposite operation to attach callback
> + * and only needs to release the mailbox, the M4 core is not stopped and will
> + * be left to continue to run its booted firmware. This callback is invoked only in
> + * IPC-only mode.
> + */
> +static int k3_m4_rproc_detach(struct rproc *rproc)
> +{
> +	struct k3_rproc *kproc = rproc->priv;
> +	struct device *dev = kproc->dev;
> +
> +	mbox_free_channel(kproc->mbox);
> +	dev_info(dev, "M4 deinitialized in IPC-only mode\n");
> +	return 0;
> +}
> +
> +static const struct rproc_ops k3_m4_rproc_ops = {
> +	.start		= k3_m4_rproc_start,
> +	.stop		= k3_m4_rproc_stop,
> +	.attach		= k3_m4_rproc_attach,
> +	.detach		= k3_m4_rproc_detach,
> +	.kick		= k3_rproc_kick,
> +	.da_to_va	= k3_rproc_da_to_va,
> +	.get_loaded_rsc_table = k3_get_loaded_rsc_table,
> +};
> +
> +static int k3_m4_rproc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	const struct k3_rproc_dev_data *data;
> +	struct k3_rproc *kproc;
> +	struct rproc *rproc;
> +	const char *fw_name;
> +	bool r_state = false;
> +	bool p_state = false;
> +	int ret = 0;
> +	int ret1;
> +
> +	data = of_device_get_match_data(dev);
> +	if (!data)
> +		return -ENODEV;
> +
> +	ret = rproc_of_parse_firmware(dev, 0, &fw_name);
> +	if (ret) {
> +		dev_err(dev, "failed to parse firmware-name property, ret = %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	rproc = rproc_alloc(dev, dev_name(dev), &k3_m4_rproc_ops, fw_name,
> +			    sizeof(*kproc));
> +	if (!rproc)
> +		return -ENOMEM;
> +
> +	rproc->has_iommu = false;
> +	rproc->recovery_disabled = true;
> +	if (data->uses_lreset) {
> +		rproc->ops->prepare = k3_rproc_prepare;
> +		rproc->ops->unprepare = k3_rproc_unprepare;
> +	}
> +	kproc = rproc->priv;
> +	kproc->rproc = rproc;
> +	kproc->dev = dev;
> +	kproc->data = data;
> +
> +	kproc->ti_sci = ti_sci_get_by_phandle(np, "ti,sci");
> +	if (IS_ERR(kproc->ti_sci)) {
> +		ret = PTR_ERR(kproc->ti_sci);
> +		if (ret != -EPROBE_DEFER) {
> +			dev_err(dev, "failed to get ti-sci handle, ret = %d\n",
> +				ret);
> +		}
> +		kproc->ti_sci = NULL;
> +		goto free_rproc;
> +	}
> +
> +	ret = of_property_read_u32(np, "ti,sci-dev-id", &kproc->ti_sci_id);
> +	if (ret) {
> +		dev_err(dev, "missing 'ti,sci-dev-id' property\n");
> +		goto put_sci;
> +	}
> +
> +	kproc->reset = devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(kproc->reset)) {
> +		ret = PTR_ERR(kproc->reset);
> +		dev_err(dev, "failed to get reset, status = %d\n", ret);
> +		goto put_sci;
> +	}
> +
> +	kproc->tsp = k3_rproc_of_get_tsp(dev, kproc->ti_sci);
> +	if (IS_ERR(kproc->tsp)) {
> +		dev_err(dev, "failed to construct ti-sci proc control, ret = %d\n",
> +			ret);
> +		ret = PTR_ERR(kproc->tsp);
> +		goto put_sci;
> +	}
> +
> +	ret = ti_sci_proc_request(kproc->tsp);
> +	if (ret < 0) {
> +		dev_err(dev, "ti_sci_proc_request failed, ret = %d\n", ret);
> +		goto free_tsp;
> +	}
> +
> +	ret = k3_rproc_of_get_memories(pdev, kproc);
> +	if (ret)
> +		goto release_tsp;
> +
> +	ret = k3_reserved_mem_init(kproc);
> +	if (ret) {
> +		dev_err(dev, "reserved memory init failed, ret = %d\n", ret);
> +		goto release_tsp;
> +	}
> +
> +	ret = kproc->ti_sci->ops.dev_ops.is_on(kproc->ti_sci, kproc->ti_sci_id,
> +					       &r_state, &p_state);
> +	if (ret) {
> +		dev_err(dev, "failed to get initial state, mode cannot be determined, ret = %d\n",
> +			ret);
> +		goto release_mem;
> +	}
> +
> +	/* configure devices for either remoteproc or IPC-only mode */
> +	if (p_state) {
> +		dev_info(dev, "configured M4 for IPC-only mode\n");
> +		rproc->state = RPROC_DETACHED;
> +		/* override rproc ops with only required IPC-only mode ops */
> +		rproc->ops->prepare = NULL;
> +		rproc->ops->unprepare = NULL;
> +		rproc->ops->start = NULL;
> +		rproc->ops->stop = NULL;
> +		rproc->ops->attach = k3_m4_rproc_attach;
> +		rproc->ops->detach = k3_m4_rproc_detach;
> +		rproc->ops->get_loaded_rsc_table = k3_get_loaded_rsc_table;
> +	} else {
> +		dev_info(dev, "configured M4 for remoteproc mode\n");
> +		/*
> +		 * ensure the M4 local reset is asserted to ensure the core
> +		 * doesn't execute bogus code in .prepare() when the module
> +		 * reset is released.
> +		 */
> +		if (data->uses_lreset) {
> +			ret = reset_control_status(kproc->reset);
> +			if (ret < 0) {
> +				dev_err(dev, "failed to get reset status, status = %d\n",
> +					ret);
> +				goto release_mem;
> +			} else if (ret == 0) {
> +				dev_warn(dev, "local reset is deasserted for device\n");
> +				k3_rproc_reset(kproc);
> +			}
> +		}
> +	}
> +
> +	ret = rproc_add(rproc);
> +	if (ret) {
> +		dev_err(dev, "failed to add register device with remoteproc core, status = %d\n",
> +			ret);
> +		goto release_mem;
> +	}
> +
> +	platform_set_drvdata(pdev, kproc);
> +
> +	return 0;
> +
> +release_mem:
> +	k3_reserved_mem_exit(kproc);
> +release_tsp:
> +	ret1 = ti_sci_proc_release(kproc->tsp);
> +	if (ret1)
> +		dev_err(dev, "failed to release proc, ret = %d\n", ret1);
> +free_tsp:
> +	kfree(kproc->tsp);
> +put_sci:
> +	ret1 = ti_sci_put_handle(kproc->ti_sci);
> +	if (ret1)
> +		dev_err(dev, "failed to put ti_sci handle, ret = %d\n", ret1);
> +free_rproc:
> +	rproc_free(rproc);
> +	return ret;
> +}
> +
> +static int k3_m4_rproc_remove(struct platform_device *pdev)
> +{
> +	struct k3_rproc *kproc = platform_get_drvdata(pdev);
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	rproc_del(kproc->rproc);
> +
> +	ret = ti_sci_proc_release(kproc->tsp);
> +	if (ret)
> +		dev_err(dev, "failed to release proc, ret = %d\n", ret);
> +
> +	kfree(kproc->tsp);
> +
> +	ret = ti_sci_put_handle(kproc->ti_sci);
> +	if (ret)
> +		dev_err(dev, "failed to put ti_sci handle, ret = %d\n", ret);
> +
> +	k3_reserved_mem_exit(kproc);
> +	rproc_free(kproc->rproc);
> +
> +	return 0;
> +}
> +
> +static const struct k3_rproc_mem_data am64_m4_mems[] = {
> +	{ .name = "iram", .dev_addr = 0x0 },
> +	{ .name = "dram", .dev_addr = 0x30000 },
> +};
> +
> +static const struct k3_rproc_dev_data am64_m4_data = {
> +	.mems = am64_m4_mems,
> +	.num_mems = ARRAY_SIZE(am64_m4_mems),
> +	.boot_align_addr = SZ_1K,
> +	.uses_lreset = true,
> +};
> +
> +static const struct of_device_id k3_m4_of_match[] = {
> +	{ .compatible = "ti,am64-m4fss", .data = &am64_m4_data, },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, k3_m4_of_match);
> +
> +static struct platform_driver k3_m4_rproc_driver = {
> +	.probe	= k3_m4_rproc_probe,
> +	.remove	= k3_m4_rproc_remove,
> +	.driver	= {
> +		.name = "k3-m4-rproc",
> +		.of_match_table = k3_m4_of_match,
> +	},
> +};
> +
> +module_platform_driver(k3_m4_rproc_driver);
> +
> +MODULE_AUTHOR("Hari Nagalla <hnagalla@ti.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("TI K3 M4 Remoteproc driver");
> -- 
> 2.34.1
> 
