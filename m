Return-Path: <linux-kernel+bounces-109133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AA088150F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389291F21333
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22F652F78;
	Wed, 20 Mar 2024 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OaJ9r7Iz"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E230535C2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710950264; cv=none; b=RUkBWHoJicv79IR854a7UrnAfPTqD0Y5zNEA295VxG9yrpRyTXjfjlEcbWj0q1Pj4BNW4mR0KsMVdY71gAK9uA2yCIGX1yvxzM4jXUmtTMEgfQ0LAPV8Yo4/b6CQgqTR8V1SkKvu/3MK+IC/OfBwoUtuGJ1kZqM416KZ4Le0MfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710950264; c=relaxed/simple;
	bh=r0ak66ssCi3v8L4aH4iJf/K++/fet36yzMs5pVft3bY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rCewKi3LDF0JXMrRqfFVnzaBqTHdDxGaGZp6vA7Pfkl/4k5oxa+0SR1zOwfr3XBAPlZVRvqhQJgRygW3J6l8xe+lQ70NfsxGA7K2GHBJiJpTwZgWfw8MJqLNXhLNXfl5TABaXVgk7jPmFuOdFGj9xu+lhw4LzW9+jvR/p6iJqcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OaJ9r7Iz; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3416a975840so2383653f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 08:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710950260; x=1711555060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dvFhOZEdWgbkuIb07EEmslRhXhcd8rV5Y+Pi8wq12vc=;
        b=OaJ9r7IzbzjJNZX3JWnp8UVUpFlI+NB1EBC7xWWNinLlrTOFuzjGE4BeJiym2jQtUN
         gfD2Sh1EKVrZv/+Di3ywXozMlQ2EzBlF43YJTBK3JzlqBpLyIHqWlVnvg61XWcw22t7C
         CBilesWhb9dq1W+i7zbJBKUdWkGwxhdmOy2dvvyPfccJdTRhI/zAXurwaYw+LoAGjQJC
         LNU8d2VDfPDC0m/oyM9Z3z3bzqlGxGAKjGigGS2dxJYEJw7RURoM49nUC4BYoL2w6Ex2
         XLY7kyh6EpIMUp6UmqJvnU/JVUh3DjTMbxAcS2u1KFRYg6S4KhjQxfDiQg9/yfHpqsbu
         ZkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710950260; x=1711555060;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dvFhOZEdWgbkuIb07EEmslRhXhcd8rV5Y+Pi8wq12vc=;
        b=XkAFW7u5zQam3UNnc7nO5BRM9nefKmVl5EVrMmblaxSBFzsTg9iZPuGuo9BMmUfBhU
         F1MGOBkj24afD3OF/7fmfMlwZJSpYUN3QJU3Ht03c0QCeJfiMtKgRsNDsijlxocwu0xc
         MS+cCSE5F4ugVlw1Ux3RSs6r9tEmn2Lrk68hA6zft2y9FJoNJ96kJiHZLIhN3qGfUgmo
         TYV+LjH2oKRple0qoeelRb65gnTKt5TmZ/Na1RlwBTqhSqSuyFeGhH6OnL+Q50hoRd9f
         extYtp3ma7QPsPkk3gE8kqQTBO5+UkyGZEooq/6RRui2iAQsKnnVsS6aQlHIDOXGuJ1b
         wtog==
X-Gm-Message-State: AOJu0YwdGFbCEQHfSUl5Q/vXhT+8teJDFlgsLL1W5n4PFgMPW52QqPLp
	RVGYaK98ljHY6YPez7jnkHbt5DEVZwQ6d4BixMPICh7f5wqWhodpeHHTn/t4O5U=
X-Google-Smtp-Source: AGHT+IEKaAmnVFo+IjWEqz0fS/YvFUddanev65qDber8aszUxJr1IeD7HI8T7Rjz5kNerYOgzT0sVA==
X-Received: by 2002:a5d:4cc1:0:b0:33e:7f5c:732c with SMTP id c1-20020a5d4cc1000000b0033e7f5c732cmr13609647wrt.62.1710950260547;
        Wed, 20 Mar 2024 08:57:40 -0700 (PDT)
Received: from [192.168.0.102] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id bj26-20020a0560001e1a00b0033ed84facdbsm11762079wrb.82.2024.03.20.08.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 08:57:40 -0700 (PDT)
Message-ID: <f92ddb35-55b3-4d49-8554-20b30257f1b5@linaro.org>
Date: Wed, 20 Mar 2024 15:57:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] media: qcom: camss: Add new VFE driver for SM8550
Content-Language: en-US
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, andersson@kernel.org, konrad.dybcio@linaro.org,
 mchehab@kernel.org, quic_yon@quicinc.com
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240320141136.26827-1-quic_depengs@quicinc.com>
 <20240320141136.26827-7-quic_depengs@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240320141136.26827-7-quic_depengs@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/03/2024 14:11, Depeng Shao wrote:
> From: Yongsheng Li <quic_yon@quicinc.com>
> 
> Add IFE driver for SM8550, the main difference with
> old HW is register offset is different, register
> update, reset and buf done is moved to CSID. And
> the image address support 36 bits, so need to right
> shift the image address when configuring the write
> master.
> 
> Signed-off-by: Yongsheng Li <quic_yon@quicinc.com>
> Co-developed-by: Depeng Shao <quic_depengs@quicinc.com>
> Signed-off-by: Depeng Shao <quic_depengs@quicinc.com>

Same comment with your co-developed and SOB

> ---
>   drivers/media/platform/qcom/camss/Makefile    |   1 +
>   .../media/platform/qcom/camss/camss-vfe-780.c | 455 ++++++++++++++++++
>   drivers/media/platform/qcom/camss/camss-vfe.h |   1 +
>   3 files changed, 457 insertions(+)
>   create mode 100644 drivers/media/platform/qcom/camss/camss-vfe-780.c
> 
> diff --git a/drivers/media/platform/qcom/camss/Makefile b/drivers/media/platform/qcom/camss/Makefile
> index c5fcd6eec0f2..ac40bbab18a3 100644
> --- a/drivers/media/platform/qcom/camss/Makefile
> +++ b/drivers/media/platform/qcom/camss/Makefile
> @@ -18,6 +18,7 @@ qcom-camss-objs += \
>   		camss-vfe-4-8.o \
>   		camss-vfe-17x.o \
>   		camss-vfe-480.o \
> +		camss-vfe-780.o \
>   		camss-vfe-gen1.o \
>   		camss-vfe.o \
>   		camss-video.o \
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe-780.c b/drivers/media/platform/qcom/camss/camss-vfe-780.c
> new file mode 100644
> index 000000000000..a78647f23c8c
> --- /dev/null
> +++ b/drivers/media/platform/qcom/camss/camss-vfe-780.c
> @@ -0,0 +1,455 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * camss-vfe-780.c
> + *
> + * Qualcomm MSM Camera Subsystem - VFE (Video Front End) Module v780 (SM8550)
> + *
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +
> +#include "camss.h"
> +#include "camss-vfe.h"
> +
> +#define VFE_HW_VERSION			(vfe_is_lite(vfe) ? 0x1000 : 0x0)
> +
> +#define VFE_IRQ_CMD			(vfe_is_lite(vfe) ? 0x1038 : 0x30)
> +#define     IRQ_CMD_GLOBAL_CLEAR	BIT(0)
> +
> +#define VFE_IRQ_MASK(n)			((vfe_is_lite(vfe) ? 0x1024 : 0x34) + (n) * 4)
> +#define	    IRQ_MASK_0_BUS_TOP_IRQ	(vfe_is_lite(vfe) ? BIT(0) | BIT(1) | BIT(2) : \
> +						BIT(0) | BIT(4) | BIT(18))
> +#define	    IRQ_MASK_1_BUS_TOP_IRQ(n)	(vfe_is_lite(vfe) ? BIT(2 * n + 2) | BIT(2 * n + 3) : \
> +						BIT(2 * n + 8) | BIT(2 * n + 9))
> +#define VFE_IRQ_CLEAR(n)		((vfe_is_lite(vfe) ? 0x102C : 0x3C) + (n) * 4)
> +#define VFE_IRQ_STATUS(n)		((vfe_is_lite(vfe) ? 0x101C : 0x44) + (n) * 4)
> +
> +#define BUS_REG_BASE			(vfe_is_lite(vfe) ? 0x1200 : 0xC00)
> +
> +#define VFE_BUS_WM_CGC_OVERRIDE		(BUS_REG_BASE + 0x08)
> +#define		WM_CGC_OVERRIDE_ALL	(0x7FFFFFF)
> +
> +#define VFE_BUS_WM_TEST_BUS_CTRL	(BUS_REG_BASE + 0xdc)
> +
> +#define VFE_BUS_WM_CFG(n)		(BUS_REG_BASE + 0x200 + (n) * 0x100)
> +#define		WM_CFG_EN			(0)
> +#define		WM_VIR_FRM_EN		(1)
> +#define		WM_CFG_MODE			(16)
> +#define			MODE_QCOM_PLAIN	(0)
> +#define			MODE_MIPI_RAW	(1)
> +#define VFE_BUS_WM_IMAGE_ADDR(n)	(BUS_REG_BASE + 0x204 + (n) * 0x100)
> +#define VFE_BUS_WM_FRAME_INCR(n)	(BUS_REG_BASE + 0x208 + (n) * 0x100)
> +#define VFE_BUS_WM_IMAGE_CFG_0(n)	(BUS_REG_BASE + 0x20c + (n) * 0x100)
> +#define                WM_IMAGE_CFG_0_DEFAULT_WIDTH    (0xFFFF)
> +#define VFE_BUS_WM_IMAGE_CFG_1(n)	(BUS_REG_BASE + 0x210 + (n) * 0x100)
> +#define VFE_BUS_WM_IMAGE_CFG_2(n)	(BUS_REG_BASE + 0x214 + (n) * 0x100)
> +#define                WM_IMAGE_CFG_2_DEFAULT_STRIDE    (0xFFFF)
> +#define VFE_BUS_WM_PACKER_CFG(n)	(BUS_REG_BASE + 0x218 + (n) * 0x100)
> +#define VFE_BUS_WM_HEADER_ADDR(n)	(BUS_REG_BASE + 0x220 + (n) * 0x100)
> +#define VFE_BUS_WM_HEADER_INCR(n)	(BUS_REG_BASE + 0x224 + (n) * 0x100)
> +#define VFE_BUS_WM_HEADER_CFG(n)	(BUS_REG_BASE + 0x228 + (n) * 0x100)
> +
> +#define VFE_BUS_WM_IRQ_SUBSAMPLE_PERIOD(n)	(BUS_REG_BASE + 0x230 + (n) * 0x100)
> +#define VFE_BUS_WM_IRQ_SUBSAMPLE_PATTERN(n)	(BUS_REG_BASE + 0x234 + (n) * 0x100)
> +#define VFE_BUS_WM_FRAMEDROP_PERIOD(n)		(BUS_REG_BASE + 0x238 + (n) * 0x100)
> +#define VFE_BUS_WM_FRAMEDROP_PATTERN(n)		(BUS_REG_BASE + 0x23c + (n) * 0x100)
> +
> +#define VFE_BUS_WM_MMU_PREFETCH_CFG(n)	(BUS_REG_BASE + 0x260 + (n) * 0x100)
> +#define VFE_BUS_WM_MMU_PREFETCH_MAX_OFFSET(n)	(BUS_REG_BASE + 0x264 + (n) * 0x100)
> +#define VFE_BUS_WM_SYSTEM_CACHE_CFG(n)	(BUS_REG_BASE + 0x268 + (n) * 0x100)
> +
> +
> +/* for titan 780, each bus client is hardcoded to a specific path */
> +#define RDI_WM(n)			((vfe_is_lite(vfe) ? 0 : 23) + (n))

No admixture of hex and decimal please.

> +
> +#define MAX_VFE_OUTPUT_LINES	4
> +#define MAX_VFE_ACT_BUF	1
> +
> +static u32 vfe_hw_version(struct vfe_device *vfe)
> +{
> +	u32 hw_version = readl_relaxed(vfe->base + VFE_HW_VERSION);
> +
> +	u32 gen = (hw_version >> 28) & 0xF;
> +	u32 rev = (hw_version >> 16) & 0xFFF;
> +	u32 step = hw_version & 0xFFFF;
> +
> +	dev_info(vfe->camss->dev, "VFE HW Version = %u.%u.%u\n", gen, rev, step);
> +
> +	return hw_version;
> +}

Same comment as with CSID, its time to rationalise all of this 
replicated code down to one place, instead of proliferating it further.

> +static void vfe_global_reset(struct vfe_device *vfe)
> +{
> +}
> +
> +static void vfe_wm_start(struct vfe_device *vfe, u8 wm, struct vfe_line *line)
> +{
> +	struct v4l2_pix_format_mplane *pix =
> +		&line->video_out.active_fmt.fmt.pix_mp;
> +
> +	wm = RDI_WM(wm); /* map to actual WM used (from wm=RDI index) */
> +
> +	/* no clock gating at bus input */
> +	writel_relaxed(0, vfe->base + VFE_BUS_WM_CGC_OVERRIDE);
> +
> +	writel_relaxed(0x0, vfe->base + VFE_BUS_WM_TEST_BUS_CTRL);
> +
> +	writel_relaxed(ALIGN(pix->plane_fmt[0].bytesperline, 16) * pix->height >> 8,
> +		       vfe->base + VFE_BUS_WM_FRAME_INCR(wm));
> +	writel_relaxed((WM_IMAGE_CFG_0_DEFAULT_WIDTH & 0xFFFF),
> +		       vfe->base + VFE_BUS_WM_IMAGE_CFG_0(wm));
> +	writel_relaxed(WM_IMAGE_CFG_2_DEFAULT_STRIDE,
> +		       vfe->base + VFE_BUS_WM_IMAGE_CFG_2(wm));
> +	writel_relaxed(0, vfe->base + VFE_BUS_WM_PACKER_CFG(wm));
> +
> +	/* no dropped frames, one irq per frame */
> +	writel_relaxed(0, vfe->base + VFE_BUS_WM_FRAMEDROP_PERIOD(wm));
> +	writel_relaxed(1, vfe->base + VFE_BUS_WM_FRAMEDROP_PATTERN(wm));
> +	writel_relaxed(0, vfe->base + VFE_BUS_WM_IRQ_SUBSAMPLE_PERIOD(wm));
> +	writel_relaxed(1, vfe->base + VFE_BUS_WM_IRQ_SUBSAMPLE_PATTERN(wm));
> +
> +	writel_relaxed(1, vfe->base + VFE_BUS_WM_MMU_PREFETCH_CFG(wm));
> +	writel_relaxed(0xFFFFFFFF, vfe->base + VFE_BUS_WM_MMU_PREFETCH_MAX_OFFSET(wm));
> +
> +	writel_relaxed(1 << WM_CFG_EN | MODE_MIPI_RAW << WM_CFG_MODE,
> +		       vfe->base + VFE_BUS_WM_CFG(wm));
> +}
> +
> +static void vfe_wm_stop(struct vfe_device *vfe, u8 wm)
> +{
> +	wm = RDI_WM(wm); /* map to actual WM used (from wm=RDI index) */
> +	writel_relaxed(0, vfe->base + VFE_BUS_WM_CFG(wm));
> +}

vfe_wm_stop() as an example can/should live in a shared file.

As proof of concept code its fine to copy/paste between files but, to 
merge we need to get rid of any replicated code - introducing 
indirection/offsets as necessary.

> +static void vfe_wm_update(struct vfe_device *vfe, u8 wm, u64 addr,
> +			  struct vfe_line *line)
> +{
> +	wm = RDI_WM(wm); /* map to actual WM used (from wm=RDI index) */
> +	writel_relaxed((addr >> 8) & 0xFFFFFFFF, vfe->base + VFE_BUS_WM_IMAGE_ADDR(wm));
> +
> +	dev_dbg(vfe->camss->dev, "wm:%d, image buf addr:0x%llx\n",
> +		wm, addr);
> +}
> +
> +static void vfe_reg_update(struct vfe_device *vfe, enum vfe_line_id line_id)
> +{
> +	int port_id = line_id;
> +
> +	v4l2_subdev_notify(&vfe->line[line_id].subdev, NOTIFY_RUP, (void *)&port_id);
> +}
> +
> +static inline void vfe_reg_update_clear(struct vfe_device *vfe,
> +					enum vfe_line_id line_id)
> +{
> +	int port_id = line_id;
> +
> +	v4l2_subdev_notify(&vfe->line[line_id].subdev, NOTIFY_RUP_CLEAR, (void *)&port_id);
> +}

I'm not sure I quite understand why we need to use this API to clear 
registers inside of the address space of the same driver.

Is there not a much more direct way to write our _internal_ registers ?


> +static void vfe_enable_irq_common(struct vfe_device *vfe, enum vfe_line_id line_id)
> +{
> +	int port_id = line_id;
> +
> +	/* enable top BUS status IRQ */
> +	writel_relaxed(IRQ_MASK_0_BUS_TOP_IRQ,
> +				vfe->base + VFE_IRQ_MASK(0));
> +
> +	writel_relaxed(IRQ_MASK_1_BUS_TOP_IRQ(port_id),
> +				vfe->base + VFE_IRQ_MASK(1));
> +}
> +
> +/*
> + * vfe_isr - VFE module interrupt handler
> + * @irq: Interrupt line
> + * @dev: VFE device
> + *
> + * Return IRQ_HANDLED on success
> + */
> +static irqreturn_t vfe_isr(int irq, void *dev)
> +{
> +	struct vfe_device *vfe = dev;
> +	u32 status;
> +
> +	status = readl_relaxed(vfe->base + VFE_IRQ_STATUS(0));
> +	writel_relaxed(status, vfe->base + VFE_IRQ_CLEAR(0));
> +	writel_relaxed(IRQ_CMD_GLOBAL_CLEAR, vfe->base + VFE_IRQ_CMD);
> +
> +	if (status)
> +		dev_dbg(vfe->camss->dev, "Top Status_0:0x%x\n", status);
> +
> +	status = readl_relaxed(vfe->base + VFE_IRQ_STATUS(1));
> +	writel_relaxed(status, vfe->base + VFE_IRQ_CLEAR(1));
> +	writel_relaxed(IRQ_CMD_GLOBAL_CLEAR, vfe->base + VFE_IRQ_CMD);
> +
> +	if (status)
> +		dev_dbg(vfe->camss->dev, "Top Status_1:0x%x\n", status);
> +
> +	return IRQ_HANDLED;
> +}

Why is this ISR required ? What does it do ?

Does it actually run on your reference hardware ?

If the purpose of the ISR is just to clear the status registers, why 
even enable it ?

> +
> +/*
> + * vfe_halt - Trigger halt on VFE module and wait to complete
> + * @vfe: VFE device
> + *
> + * Return 0 on success or a negative error code otherwise
> + */
> +static int vfe_halt(struct vfe_device *vfe)
> +{
> +	/* rely on vfe_disable_output() to stop the VFE */
> +	return 0;
> +}
> +
> +static int vfe_get_output(struct vfe_line *line)
> +{
> +	struct vfe_device *vfe = to_vfe(line);
> +	struct vfe_output *output;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&vfe->output_lock, flags);
> +
> +	output = &line->output;
> +	if (output->state > VFE_OUTPUT_RESERVED) {
> +		dev_err(vfe->camss->dev, "Output is running\n");
> +		goto error;
> +	}
> +
> +	output->wm_num = 1;
> +
> +	/* Correspondence between VFE line number and WM number.
> +	 * line 0 -> RDI 0, line 1 -> RDI1, line 2 -> RDI2, line 3 -> PIX/RDI3
> +	 * Note this 1:1 mapping will not work for PIX streams.
> +	 */
> +	output->wm_idx[0] = line->id;
> +	vfe->wm_output_map[line->id] = line->id;
> +
> +	output->drop_update_idx = 0;
> +
> +	spin_unlock_irqrestore(&vfe->output_lock, flags);
> +
> +	return 0;
> +
> +error:
> +	spin_unlock_irqrestore(&vfe->output_lock, flags);
> +	output->state = VFE_OUTPUT_OFF;
> +
> +	return -EINVAL;
> +}
> +
> +static int vfe_enable_output(struct vfe_line *line)
> +{
> +	struct vfe_device *vfe = to_vfe(line);
> +	struct vfe_output *output = &line->output;
> +	unsigned long flags;
> +	unsigned int i;
> +
> +	spin_lock_irqsave(&vfe->output_lock, flags);
> +
> +	vfe_reg_update_clear(vfe, line->id);
> +
> +	if (output->state > VFE_OUTPUT_RESERVED) {
> +		dev_err(vfe->camss->dev, "Output is not in reserved state %d\n",
> +			output->state);
> +		spin_unlock_irqrestore(&vfe->output_lock, flags);
> +		return -EINVAL;
> +	}
> +
> +	WARN_ON(output->gen2.active_num);
> +
> +	output->state = VFE_OUTPUT_ON;
> +
> +	output->sequence = 0;
> +
> +	vfe_wm_start(vfe, output->wm_idx[0], line);
> +
> +	for (i = 0; i < MAX_VFE_ACT_BUF; i++) {
> +		output->buf[i] = vfe_buf_get_pending(output);
> +		if (!output->buf[i])
> +			break;
> +		output->gen2.active_num++;
> +		vfe_wm_update(vfe, output->wm_idx[0], output->buf[i]->addr[0], line);
> +
> +		vfe_reg_update(vfe, line->id);
> +	}
> +
> +	spin_unlock_irqrestore(&vfe->output_lock, flags);
> +
> +	return 0;
> +}

So you'll see with the WIP code for x1e80100 which is I think the same 
VFE - no one generation less 680 - that this code is copy/pasted.

But there's again no good reason for that. Common code needs to be 
squashed down into one place.

---
bod

