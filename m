Return-Path: <linux-kernel+bounces-4435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A9E817D11
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F4D1C21F97
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EEB74E0F;
	Mon, 18 Dec 2023 22:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GAsXBk5G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F76740B9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cc259392a6so43814061fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702936844; x=1703541644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TV48NwoeEh8UyYxN5vIg56/uoKj764R1rkRKJ4M5O9c=;
        b=GAsXBk5GTsqXmGaT/ujOZxvBNZodAuLQaaSCRh8hVE2uu9LdjCZqMynpnGW9owOZRg
         41ylmrwaVhqID7GM9dMKWFsOqXS82Oks88/ffqVWZC6lFQIkLr8WZ3sB5zmQmkpV2Fbi
         qJl3j5Qsl3me5QJJP0DQtiZV7iOexdgVPyzyA3glIiLMoJfq21SKTGw/I6b+K6EFgk6P
         k+QHx0vlxfQdQ7/WtNwcbFYgxuYDro3OUP/BByAhtdHW/m6dm1C6WzFpY0h4Y6IMYW7V
         qnwgC9kboRXpBFufkyeCO330uot5yr4kUWs5xq3TdKNVxWo76U/NE4x4CQ0aksOJWyVg
         w2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702936844; x=1703541644;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TV48NwoeEh8UyYxN5vIg56/uoKj764R1rkRKJ4M5O9c=;
        b=JJzXYyYvKSHeHSqNfTLGU8dUglqYsctCKEsfr8eM9Cvek3NVYH3kjZhUFT+mnT7zvv
         qf1YnU57+1hYQyiuaOMBsoMd5nfauKjg1FemYmdsZRvI556+I4m5nSpUWBQiJTkZ7PX9
         nnkz95reQeZaqW5x7oWt4odxPYzYKwnl98+zTXtkAF2KJie9uMaxMA8KY9rMCgysppA2
         Ilit51Hz2BCx5ijm17QcXhGItIruj2SwfYJUk4wCmARVkHn0IC/RDRwbNFc6LbZyvBjU
         NUf06NFiqL7AwMbsCwnPTUm6Ukg0cq0W4vhfMZI4I/kYUI2J1oOMT6xj+0HK0zxtHBRQ
         R4OQ==
X-Gm-Message-State: AOJu0YzO1+4/LAaorkfu+Z5iZMYZMH3GiT989gLU7HwlTTS17utEvztq
	4o8TjU275foumjoJhGsLzpLflQ==
X-Google-Smtp-Source: AGHT+IGgpueoqA0Mb4wMMixhS8get+RvHeTmm+QK66446Ad7qRIcLU28/r5llZGNaDxrIxhcBdKRtQ==
X-Received: by 2002:a2e:9d05:0:b0:2cc:6910:a7e9 with SMTP id t5-20020a2e9d05000000b002cc6910a7e9mr1385081lji.55.1702936844187;
        Mon, 18 Dec 2023 14:00:44 -0800 (PST)
Received: from [172.30.205.119] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id i2-20020a2e8082000000b002cc5c149dd3sm980758ljg.120.2023.12.18.14.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 14:00:43 -0800 (PST)
Message-ID: <c265c494-6256-40e4-b88d-3285a52a205b@linaro.org>
Date: Mon, 18 Dec 2023 23:00:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/34] media: iris: add video processing unit(VPU)
 specific register handling
Content-Language: en-US
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com, agross@kernel.org,
 andersson@kernel.org, mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <1702899149-21321-13-git-send-email-quic_dikshita@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1702899149-21321-13-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/18/23 12:32, Dikshita Agarwal wrote:
> Registers are defined differently for different VPUs.
> Define ops for VPU specific handling to accommodate
> different VPUs. Implement boot sequence of firmware and interrupt
> programming.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
[...]

> +int write_register(struct iris_core *core, u32 reg, u32 value)
> +{
> +	void __iomem *base_addr;
> +	int ret;
> +
> +	ret = check_core_lock(core);
> +	if (ret)
> +		return ret;
> +
> +	base_addr = core->reg_base;
> +	base_addr += reg;
> +	writel_relaxed(value, base_addr);> +
> +	/* Make sure value is written into the register */
IIUC barriers only ensure the prior writes need to be submitted
before the next ones, they don't actually guarantee the value
arrives at the destination. You would probably want to read the
register back here to guarantee that.

> +	wmb();
> +
> +	return ret;
> +}
> +
> +int read_register(struct iris_core *core, u32 reg, u32 *value)
> +{
> +	void __iomem *base_addr;
> +
> +	base_addr = core->reg_base;
> +
> +	*value = readl_relaxed(base_addr + reg);
> +
> +	/* Make sure value is read correctly from the register */
> +	rmb();
You can drop _relaxed for that and simply use readl() instead of
this entire wrapper..

> +
> +	return 0;
> +}
> +
> +static const struct compat_handle compat_handle[] = {
> +	{
> +		.compat                  = "qcom,sm8550-iris",
> +		.init                    = init_iris3,
> +	},
> +};
> +
> +int init_vpu(struct iris_core *core)
> +{
> +	struct device *dev = NULL;
> +	int i, ret = 0;
> +
> +	dev = core->dev;
> +
> +	for (i = 0; i < ARRAY_SIZE(compat_handle); i++) {
> +		if (of_device_is_compatible(dev->of_node, compat_handle[i].compat)) {
> +			ret = compat_handle[i].init(core);
> +			if (ret)
> +				return ret;
> +			break;
> +		}
> +	}
> +
> +	if (i == ARRAY_SIZE(compat_handle))
> +		return -EINVAL;
> +
> +	return ret;
> +}
what's wrong with of_match_data?

[...]

> +
> +#define call_vpu_op(d, op, ...)			\
> +	(((d) && (d)->vpu_ops && (d)->vpu_ops->op) ? \
> +	((d)->vpu_ops->op(__VA_ARGS__)) : 0)
> +
> +struct compat_handle {
> +	const char *compat;
> +	int (*init)(struct iris_core *core);
> +};
> +
> +struct vpu_ops {
> +	int (*boot_firmware)(struct iris_core *core);
> +	int (*raise_interrupt)(struct iris_core *core);
> +};
or you can simply create functions like

boot_firmware(...)
raise_interrupt(...)

that call other functions as needed (unless there's no need if e.g.
the cores are so similar)

and drop this sugar (well, bitter sugar at least to my taste) syntax
[...]

> +	int ret;
> +	u32 value;
reverse-Christmas-tree, please
(Christmas is in a week, get festive! :D)

> +
> +	value = (u32)core->iface_q_table.device_addr;
> +	ret = write_register(core, UC_REGION_ADDR_IRIS3, value);
> +	if (ret)
> +		return ret;
> +
> +	value = SHARED_QSIZE;
> +	ret = write_register(core, UC_REGION_SIZE_IRIS3, value);
> +	if (ret)
> +		return ret;
> +
> +	value = (u32)core->iface_q_table.device_addr;
> +	ret = write_register(core, QTBL_ADDR_IRIS3, value);
> +	if (ret)
> +		return ret;
> +
> +	ret = write_register(core, QTBL_INFO_IRIS3, 0x01);
> +	if (ret)
> +		return ret;
> +
> +	value = (u32)((u64)core->iface_q_table.kernel_vaddr);
lower_32_bits()

> +	ret = write_register(core, CPU_CS_VCICMDARG0_IRIS3, value);
> +	if (ret)
> +		return ret;
> +
> +	value = (u32)((u64)core->iface_q_table.kernel_vaddr >> 32);
upper_32_bits()

> +	ret = write_register(core, CPU_CS_VCICMDARG1_IRIS3, value);
> +	if (ret)
> +		return ret;
> +
> +	if (core->sfr.device_addr) {
> +		value = (u32)core->sfr.device_addr + VIDEO_ARCH_LX;
> +		ret = write_register(core, SFR_ADDR_IRIS3, value);
> +		if (ret)
> +			return ret;
you're returning ret 3 lines below anyway

> +	}
> +
> +	return ret;
> +}
> +
> +static int boot_firmware_iris3(struct iris_core *core)
> +{
> +	u32 ctrl_init = 0, ctrl_status = 0, count = 0, max_tries = 1000;
> +	int ret;
> +
> +	ret = setup_ucregion_memory_map_iris3(core);
> +	if (ret)
> +		return ret;
> +
> +	ctrl_init = BIT(0);
this should be a named #define used inline

> +
> +	ret = write_register(core, CTRL_INIT_IRIS3, ctrl_init);
> +	if (ret)
> +		return ret;
> +
> +	while (!ctrl_status && count < max_tries) {
if you take the previous feedback into account, this can become
readl_poll_timeout()

> +		ret = read_register(core, CTRL_STATUS_IRIS3, &ctrl_status);
> +		if (ret)
> +			return ret;
> +
> +		if ((ctrl_status & CTRL_ERROR_STATUS__M_IRIS3) == 0x4) {
> +			dev_err(core->dev, "invalid setting for UC_REGION\n");
> +			break;
> +		}
> +
> +		usleep_range(50, 100);
> +		count++;
> +	}
> +
> +	if (count >= max_tries) {
> +		dev_err(core->dev, "Error booting up vidc firmware\n");
> +		return -ETIME;
> +	}

> +
> +	ret = write_register(core, CPU_CS_H2XSOFTINTEN_IRIS3, 0x1);
0x1? BIT(0)? probably a named BIT(0) that deserves its own #define?
> +	if (ret)
> +		return ret;
> +
> +	ret = write_register(core, CPU_CS_X2RPMH_IRIS3, 0x0);
similarly here

btw you can just return this

> +
> +	return ret;
> +}
> +
> +static int raise_interrupt_iris3(struct iris_core *core)
> +{
> +	return write_register(core, CPU_IC_SOFTINT_IRIS3, 1 << CPU_IC_SOFTINT_H2A_SHFT_IRIS3);
FIELD_PREP/GET, please

> +}
> +
> +static const struct vpu_ops iris3_ops = {
> +	.boot_firmware = boot_firmware_iris3,
> +	.raise_interrupt = raise_interrupt_iris3,
> +};
> +
> +int init_iris3(struct iris_core *core)
> +{
> +	core->vpu_ops = &iris3_ops;
> +
> +	return 0;
> +}
what is this dead function for?

Konrad

