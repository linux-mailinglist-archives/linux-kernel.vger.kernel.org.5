Return-Path: <linux-kernel+bounces-67451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E802856BB1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD061F2128E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7323F1386D7;
	Thu, 15 Feb 2024 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z53TqLO7"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8AF1369AC
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019731; cv=none; b=bu1iXBOau17Rwl6olWfaHsO9755NGawc52KDOGi6aMbPQYmbyY4gwmB4dGvgfFsvch9nzSWl6hQjYjplpHXs1sFHelH9euAvaoSgEwMg2Kv3ewf9OPAGIMcE+TVFa39b3yRB3tGGMKYYjW8sraXYNvZylsFzfHb8so4KAMI15v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019731; c=relaxed/simple;
	bh=qrTaakqRAPccZJkKzTa2VDsicEBBfpGpDdAlWZurPwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UVOX6h8vHKRQtO/ynJ1jiwlaIhs4NxKY2MDvieHxfdJYN/Wk5hL+FcRWbicfcd0quJ8mvWiLFGgs67VVMrUkVGVsr4L+h4Wzau5ExNBRSZBiZu9mLkCNRlkcLreNX00i9+NhyEkKe9l4b7huAyL2bTdAeNwsvI534BfNwFVkpPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z53TqLO7; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-511a45f6a57so1499034e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708019727; x=1708624527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JDWXjBWcKFEbyW8Uf48hnpLWCBqnIeEgb6RPWjwQokE=;
        b=z53TqLO7cPLfcxhVXTBELFDVh4ILdOkeQQ/w6r0qOWJWDzwA2Jl/vAtmCgPoxsiPnu
         SU6D5JYpDABlET30PC3wMLy+Gz96jszr1inLPSCaWuixm85YY/+J/fRTxscQWXuWYQaX
         23ePZ5Qv6uzyliiQcwThqLArRmG1bm39PU1oswNfLKe3xcNFhsJP51miNWcz2Z7pvvAo
         7HHX7HXDimM8p199E7Ccrd8BSoMhnrLP4mBiZGXQG70Ei0Xl3lnOmxVN20UGrSa5Bdq9
         TK7mcIgfxBkei7IGbbbeSZYnsrN/W9Ml+0gHgTSHkgW8Xc3CVel2/bmfEMBeQg3XyzXq
         NeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708019727; x=1708624527;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JDWXjBWcKFEbyW8Uf48hnpLWCBqnIeEgb6RPWjwQokE=;
        b=mSJQ8Lpskw+t8P/CIxWolq6d0e3e/nDJ77JBsOsGRvZq1GRbDtKf4MYmoVn4AxhvWq
         thrq6TkVAwJeNJZq8eKApTm7Ig+0d1WUZGECMkGIWyzQOy/cRaXvypNcMsG8hDMQskeD
         EN6t8wL5cSQE31ISp9XwS6tocUTmVy3c1vFnDS2zu2FoQdCmyapD30LpjfXyiXX+Lm+Y
         OinhbwjyJA8Nj840Jkzv1Fs/bzWyHcZiiDl9fgOhqD0dc28LwxC4dzAs0VUZ4tNHIbRq
         xCwOWHFMqjvHKaxY5tm412rW6Ty0aOxXFSXStXFlQG4/dOh9/LGNyJnYSAjvVo3aQcEW
         ifNA==
X-Forwarded-Encrypted: i=1; AJvYcCWvV0RSyL2oh/76bknDnqIRREIX8seY8f96zUB/zR6A9jbFUBMS7tfU5VUJ3E/+PI/xVhzljOoI/e3P8vMfnUgqRh/2V7nzmIV3qtTf
X-Gm-Message-State: AOJu0YyYRs/rApa9a4Ex5bYmXvlU463rlamsTWQQmoQ6LIuV0G2dQ+sj
	8NDNIn8o1C0W0sBBveY8Q8qea2UugXxwQWkEc7dNhmuvsAJkctqWFEJkTORKytM=
X-Google-Smtp-Source: AGHT+IHCLIfN6muAhaewbjdhnO1CjXkKfDODDb3Jlvpzo3uuFHn1hyVeYSewW3DaaUIu7nCHSXFxCA==
X-Received: by 2002:ac2:4d8d:0:b0:511:5537:fb26 with SMTP id g13-20020ac24d8d000000b005115537fb26mr1993787lfe.39.1708019720252;
        Thu, 15 Feb 2024 09:55:20 -0800 (PST)
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id g6-20020aa7c586000000b005619eea3d52sm749980edq.8.2024.02.15.09.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 09:55:14 -0800 (PST)
Message-ID: <4cb0144c-303b-4b91-bf88-0a7d7412afe1@linaro.org>
Date: Thu, 15 Feb 2024 18:55:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] drivers: mtd: nand: Add qpic_common API file
Content-Language: en-US
To: Md Sadre Alam <quic_mdalam@quicinc.com>, andersson@kernel.org,
 broonie@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, manivannan.sadhasivam@linaro.org,
 linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20240215134856.1313239-1-quic_mdalam@quicinc.com>
 <20240215134856.1313239-3-quic_mdalam@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240215134856.1313239-3-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.02.2024 14:48, Md Sadre Alam wrote:
> Add qpic_common.c file which hold all the common
> qpic APIs which will be used by both qpic raw nand
> driver and qpic spi nand driver.
> 
> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

IIUC this is mostly moving code around?

I do however have some suggestions..

>  drivers/mtd/nand/Makefile            |    1 +
>  drivers/mtd/nand/qpic_common.c       |  786 +++++++++++++++++
>  drivers/mtd/nand/raw/qcom_nandc.c    | 1226 +-------------------------
>  include/linux/mtd/nand-qpic-common.h |  488 ++++++++++
>  4 files changed, 1291 insertions(+), 1210 deletions(-)
>  create mode 100644 drivers/mtd/nand/qpic_common.c
>  create mode 100644 include/linux/mtd/nand-qpic-common.h
> 
> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
> index 19e1291ac4d5..131707a41293 100644
> --- a/drivers/mtd/nand/Makefile
> +++ b/drivers/mtd/nand/Makefile
> @@ -12,3 +12,4 @@ nandcore-$(CONFIG_MTD_NAND_ECC) += ecc.o
>  nandcore-$(CONFIG_MTD_NAND_ECC_SW_HAMMING) += ecc-sw-hamming.o
>  nandcore-$(CONFIG_MTD_NAND_ECC_SW_BCH) += ecc-sw-bch.o
>  nandcore-$(CONFIG_MTD_NAND_ECC_MXIC) += ecc-mxic.o
> +obj-y += qpic_common.o
> diff --git a/drivers/mtd/nand/qpic_common.c b/drivers/mtd/nand/qpic_common.c
> new file mode 100644
> index 000000000000..4d74ba888028
> --- /dev/null
> +++ b/drivers/mtd/nand/qpic_common.c
> @@ -0,0 +1,786 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * QPIC Controller common API file.
> + * Copyright (C) 2023  Qualcomm Inc.
> + * Authors:	Md sadre Alam           <quic_mdalam@quicinc.com>
> + *		Sricharan R             <quic_srichara@quicinc.com>
> + *		Varadarajan Narayanan	<quic_varada@quicinc.com>
> + *
> + */
> +
> +#include <linux/mtd/nand-qpic-common.h>
> +
> +struct qcom_nand_controller *
> +get_qcom_nand_controller(struct nand_chip *chip)
> +{
> +	return container_of(chip->controller, struct qcom_nand_controller,
> +			    controller);
> +}
> +EXPORT_SYMBOL(get_qcom_nand_controller);

#define to_qcom_nand_controller()?

> +
> +/*
> + * Helper to prepare DMA descriptors for configuring registers
> + * before reading a NAND page.
> + */

Can you convert these to kerneldoc instead?

> +void config_nand_page_read(struct nand_chip *chip)
> +{
> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
> +
> +	write_reg_dma(nandc, NAND_ADDR0, 2, 0);
> +	write_reg_dma(nandc, NAND_DEV0_CFG0, 3, 0);
> +	if (!nandc->props->qpic_v2)

This is not going to scale going forward.. please include a version
enum instead.

[...]

> +
> +int prep_adm_dma_desc(struct qcom_nand_controller *nandc, bool read,
> +		      int reg_off, const void *vaddr, int size,
> +			     bool flow_control)
> +{
> +	struct desc_info *desc;
> +	struct dma_async_tx_descriptor *dma_desc;
> +	struct scatterlist *sgl;
> +	struct dma_slave_config slave_conf;
> +	struct qcom_adm_peripheral_config periph_conf = {};
> +	enum dma_transfer_direction dir_eng;
> +	int ret;

Revertse-christmas-tree, please

> +
> +	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
> +	if (!desc)
> +		return -ENOMEM;
> +
> +	sgl = &desc->adm_sgl;
> +
> +	sg_init_one(sgl, vaddr, size);
> +
> +	if (read) {
> +		dir_eng = DMA_DEV_TO_MEM;
> +		desc->dir = DMA_FROM_DEVICE;
> +	} else {
> +		dir_eng = DMA_MEM_TO_DEV;
> +		desc->dir = DMA_TO_DEVICE;
> +	}
> +
> +	ret = dma_map_sg(nandc->dev, sgl, 1, desc->dir);
> +	if (ret == 0) {

if (!ret)

> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	memset(&slave_conf, 0x00, sizeof(slave_conf));

Just zero-initialize it (= { 0 }) at declaration time

Konrad

