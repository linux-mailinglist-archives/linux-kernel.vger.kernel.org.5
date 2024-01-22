Return-Path: <linux-kernel+bounces-33584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 149D3836BC4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C571C2640A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6594123C;
	Mon, 22 Jan 2024 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="erNTQGfo"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC0B3D967
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937124; cv=none; b=fZpPQiBlOSRgHrxn+O2DqumNxEdfpXJMHCVJoJmcls7VL5ahiZ+3l7onPD2Vs+T/CnKJlMLOCgvlEQWTqPy+CxrMkSFqJge6fgkOMAaY0N6qGaqtj8EKkNvgZRrAOqY7alsaWbcwpq56koc1GRmGVEy6MvbR9+fafSGBotFiZK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937124; c=relaxed/simple;
	bh=BvwWPeLzqApj6/aakWVtDh425ZxMeXm2qLCP8IuXz+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=s2cu8FvgDiDloTY5GAsiTA8X60PpkeTU1kehoeNNtal+ZpcKNMk6Xkflq/r1LthrGxzvfYhQ262J/vPAkkaDyBO8iTiCr1Utv3RUTpMc+oxuU5nk4S4cDi7Yq8bbTLcL4LONc+e+jrBAtHvD5saFd3i0ShvvAenlTZYKBPBVmd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=erNTQGfo; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50ea98440a7so3077771e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705937120; x=1706541920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3AQjau4ZDJPt3vD1a6+z6eC19xr+A2RrxxaysJwwBPg=;
        b=erNTQGfoO8zI//lBNdiUpxlNKISlNcJtu0B3gYifbdoUKObef4lygrl+UIgMgbqPob
         yMR3aiynGPcrD0We0uGINK4GC3xUXcJ1MK3qpTNuqUiePMOCqwitaDlPD2GXx8YAbQX4
         AQODUY1/y4Q1A2BCXhHP6wrfbY5mfNT1fvHwSk5IPBbpyJZprKbv+xSYXk+5zfBY7ZSw
         QSx8QajAbTbGJWyfThBjgGV0TrAYH/NQe2en8ygDA1xZRL3JxkSbfY9tsAY7NKg3ZhGM
         4ayom+o+1aUVSqJwHhVVMINtvR5ebMss5UfGAyi4nZLjH8iuK2FvtTLrXohhBoikv4/u
         wVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705937120; x=1706541920;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3AQjau4ZDJPt3vD1a6+z6eC19xr+A2RrxxaysJwwBPg=;
        b=sm6QXSLbZ1rd0lXUyKYJt0qjD4xMHb38NYShaHn9vgn8oTJD7cAPRZ5CRMlIVEP9jS
         BaeMLEaeHryHEXZZXeRxLVTm3Ceovqk2Bq9JzUWsQW4Rsj3TdH+mBMQQIUPdxnyYCtQ6
         0t+M1BSlEKfd7kEi9oZ5aR9pIKexHE0k186Lvd/ksqpSwORW5WpXajRWVR1ObOEm+o4B
         3QvLPtB4FZOkiLgfSKdiGZ0ngXMNgMDIdlbMlh5+0Wi7NXQyYniL30x+vTWfvmNJ7psJ
         MC86bjI3/cKgf6qXlnh25+Uox7+JhU68bGfY4IfAugJnZmgCiplFU30R67Yvm94kSPFD
         pvYA==
X-Gm-Message-State: AOJu0YxaFku9L/odaIeEwTUrmP7mv476Xr6+2xYw7mrKNHBMjJupeMCJ
	v/J4j2dYbQXVvj4dLNTM5wJ6NVOwS6xGkaBoi3DwfrF2saQjblc84FtFBPzpfr8=
X-Google-Smtp-Source: AGHT+IEj32NBin8MAmagamSf9rR5DVDPMCHsnryZC36mY/oQt/TkjUqOBOwpAZwYLasCljbiBBqHUg==
X-Received: by 2002:a05:6512:3b20:b0:50e:9355:a24b with SMTP id f32-20020a0565123b2000b0050e9355a24bmr1409426lfv.22.1705937119802;
        Mon, 22 Jan 2024 07:25:19 -0800 (PST)
Received: from [192.168.231.132] (178235179218.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.218])
        by smtp.gmail.com with ESMTPSA id hu14-20020a170907a08e00b00a2f15b8cb76sm5302537ejc.184.2024.01.22.07.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 07:25:19 -0800 (PST)
Message-ID: <9224341f-e0d8-427b-9064-4a51bf5c547e@linaro.org>
Date: Mon, 22 Jan 2024 16:25:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [1/4] interconnect: qcom: icc-rpmh: Add QoS config support
Content-Language: en-US
To: Odelu Kukatla <quic_okukatla@quicinc.com>, georgi.djakov@linaro.org,
 Bjorn Andersson <andersson@kernel.org>, Georgi Djakov <djakov@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240122143030.11904-1-quic_okukatla@quicinc.com>
 <20240122143030.11904-2-quic_okukatla@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240122143030.11904-2-quic_okukatla@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.01.2024 15:30, Odelu Kukatla wrote:
> Introduce support to initialize QoS settings for QNOC platforms.

You should describe why this is useful.

For reference, disabling QoS programming on sm8350 on an android
kernel & userspace yields an inconsistent 1-2% difference in
benchmarks like geekbench or antutu, but perhaps it's useful for
not clogging up the NoCs when there's a lot of multimedia-dram
traffic etc.?

> 
> Change-Id: I068d49cbcfec5d34c01e5adc930eec72d306ed89

This tag has no place upstream

> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
> ---
>  drivers/interconnect/qcom/icc-rpmh.c | 158 +++++++++++++++++++++++++++
>  drivers/interconnect/qcom/icc-rpmh.h |  33 ++++++
>  2 files changed, 191 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
> index c1aa265c1f4e..49334065ccfa 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.c
> +++ b/drivers/interconnect/qcom/icc-rpmh.c
> @@ -1,8 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
> +#include <linux/clk.h>
>  #include <linux/interconnect.h>
>  #include <linux/interconnect-provider.h>
>  #include <linux/module.h>
> @@ -14,6 +16,37 @@
>  #include "icc-common.h"
>  #include "icc-rpmh.h"
>  
> +/* QNOC QoS */
> +#define QOSGEN_MAINCTL_LO(p, qp)	(0x8 + (p->offsets[qp]))
> +#define QOS_SLV_URG_MSG_EN_SHFT		3
> +#define QOS_DFLT_PRIO_MASK		0x7
> +#define QOS_DFLT_PRIO_SHFT		4
> +#define QOS_DISABLE_SHIFT		24

mask + shift -> GENMASK(), then use FIELD_PREP/GET in the callers

These are already defined in icc-rpm.c.. Perhaps they can be factored out
to icc-qnoc.h or something?

[...]

> +
> +static int enable_qos_deps(struct qcom_icc_provider *qp)

Can we perhaps integrate this into .sync_state?

Currently, !synced_state holds all paths (and by extension, all BCMs)
at their max values, so they're definitely enabled, and it conviniently
is also supposed to only fire once.

> +{
> +	struct qcom_icc_bcm *bcm;
> +	bool keepalive;
> +	int ret, i;
> +
> +	for (i = 0; i < qp->num_bcms; i++) {
> +		bcm = qp->bcms[i];
> +		if (bcm_needs_qos_proxy(bcm)) {
> +			keepalive = bcm->keepalive;
> +			bcm->keepalive = true;
> +
> +			qcom_icc_bcm_voter_add(qp->voter, bcm);
> +			ret = qcom_icc_bcm_voter_commit(qp->voter);
> +
> +			bcm->keepalive = keepalive;
> +
> +			if (ret) {
> +				dev_err(qp->dev, "failed to vote BW to %s for QoS\n",
> +					bcm->name);
> +				return ret;
> +			}
> +		}
> +	}
> +
> +	ret = clk_bulk_prepare_enable(qp->num_clks, qp->clks);
> +	if (ret) {
> +		dev_err(qp->dev, "failed to enable clocks for QoS\n");
> +		return ret;
> +	}

if (ret)
	dev_err(qp->dev...

return ret;

> +
> +	return 0;
> +}
> +
> +static void disable_qos_deps(struct qcom_icc_provider *qp)
> +{
> +	struct qcom_icc_bcm *bcm;
> +	int i;
> +
> +	clk_bulk_disable_unprepare(qp->num_clks, qp->clks);
> +
> +	for (i = 0; i < qp->num_bcms; i++) {
> +		bcm = qp->bcms[i];
> +		if (bcm_needs_qos_proxy(bcm)) {
> +			qcom_icc_bcm_voter_add(qp->voter, bcm);
> +			qcom_icc_bcm_voter_commit(qp->voter);
> +		}
> +	}
> +}
> +
> +int qcom_icc_rpmh_configure_qos(struct qcom_icc_provider *qp)
> +{
> +	struct qcom_icc_node *qnode;
> +	size_t i;
> +	int ret;
> +
> +	ret = enable_qos_deps(qp);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < qp->num_nodes; i++) {
> +		qnode = qp->nodes[i];
> +		if (!qnode)
> +			continue;
> +
> +		if (qnode->qosbox)
> +			qcom_icc_set_qos(qnode);
> +	}
> +
> +	disable_qos_deps(qp);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(qcom_icc_rpmh_configure_qos);

This is simply copypasted from downstream [1].. not necessary at all,
in this patch this func is exclusively called from within this file.

> +
> +static struct regmap *qcom_icc_rpmh_map(struct platform_device *pdev,
> +					const struct qcom_icc_desc *desc)
> +{
> +	void __iomem *base;
> +	struct resource *res;
> +	struct device *dev = &pdev->dev;

Reverse-Christmas-tree throughout the code, please

> +
> +	if (!desc->config)
> +		return NULL;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return NULL;
> +
> +	base = devm_ioremap(dev, res->start, resource_size(res));
> +	if (IS_ERR(base))
> +		return ERR_CAST(base);
> +
> +	return devm_regmap_init_mmio(dev, base, desc->config);
> +}


This is devm_platform_get_and_ioremap_resource + devm_regmap_init_mmio

please inline this in the probe func

[...]

>  
> @@ -213,6 +363,8 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
>  		if (!qn)
>  			continue;
>  
> +		qn->regmap = dev_get_regmap(qp->dev, NULL);

Why would all nodes need a regmap reference? there's to_qcom_provider()

> +
>  		node = icc_node_create(qn->id);
>  		if (IS_ERR(node)) {
>  			ret = PTR_ERR(node);
> @@ -229,6 +381,10 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
>  		data->nodes[i] = node;
>  	}
>  
> +	ret = qcom_icc_rpmh_configure_qos(qp);
> +	if (ret)
> +		goto err_remove_nodes;
> +
>  	ret = icc_provider_register(provider);
>  	if (ret)
>  		goto err_remove_nodes;
> @@ -247,6 +403,7 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
>  err_deregister_provider:
>  	icc_provider_deregister(provider);
>  err_remove_nodes:
> +	clk_bulk_put_all(qp->num_clks, qp->clks);

Use devm_clk_bulk_get_all instead

[...]

> + * @nodes: list of interconnect nodes that maps to the provider
> + * @num_nodes: number of @nodes
> + * @regmap: used for QOS registers access

QoS, 'register'

> + * @clks : clks required for register access
> + * @num_clks: number of @clks
>   */
>  struct qcom_icc_provider {
>  	struct icc_provider provider;
> @@ -25,6 +31,11 @@ struct qcom_icc_provider {
>  	struct qcom_icc_bcm * const *bcms;
>  	size_t num_bcms;
>  	struct bcm_voter *voter;
> +	struct qcom_icc_node * const *nodes;
> +	size_t num_nodes;
> +	struct regmap *regmap;
> +	struct clk_bulk_data *clks;
> +	int num_clks;
>  };
>  
>  /**
> @@ -41,6 +52,23 @@ struct bcm_db {
>  	u8 reserved;
>  };
>  
> +/**
> + * struct qcom_icc_qosbox - Qualcomm Technologies, Inc specific QoS config

qosbox -> qos

plus I'm not sure if the full company name adds value to a driver in
drivers/interconnect/qcom..

> + * @prio: priority value assigned to requests on the node
> + * @urg_fwd: if set, master priority is used for requests.

"master priority" meaning "this req goes before anyone else", or "use the
icc provider [master]'s priority value"?

> + * @prio_fwd_disable: if set, master priority is ignored and NOCs default priority is used.

NoC's

This sounds like !(prio || urg_fwd)? Surely it must do something more useful?


> + * @num_ports: number of @ports
> + * @offsets: qos register offsets
> + */
> +
> +struct qcom_icc_qosbox {
> +	u32 prio;
> +	u32 urg_fwd;
> +	bool prio_fwd_disable;
> +	u32 num_ports;
> +	u32 offsets[];

u32 offsets __counted_by(num_ports)

Also, it would probably be more clear if you renamed it to "port_offsets"

> +};
> +
>  #define MAX_LINKS		128
>  #define MAX_BCMS		64
>  #define MAX_BCM_PER_NODE	3
> @@ -58,6 +86,8 @@ struct bcm_db {
>   * @max_peak: current max aggregate value of all peak bw requests
>   * @bcms: list of bcms associated with this logical node
>   * @num_bcms: num of @bcms
> + * @regmap: used for QOS registers access
> + * @qosbox: qos config data associated with node
>   */
>  struct qcom_icc_node {
>  	const char *name;
> @@ -70,6 +100,8 @@ struct qcom_icc_node {
>  	u64 max_peak[QCOM_ICC_NUM_BUCKETS];
>  	struct qcom_icc_bcm *bcms[MAX_BCM_PER_NODE];
>  	size_t num_bcms;
> +	struct regmap *regmap;

Remove

> +	struct qcom_icc_qosbox *qosbox;

Why would this be a pointer and not a const member of the struct?

It seems totally counter-intuitive to reuse QoS settings for more than
one node, given their offsets are unique.

Konrad

[1] https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/blob/kernel.lnx.5.15.r26-rel/drivers/interconnect/qcom/icc-rpmh.c?ref_type=heads#L329-354


