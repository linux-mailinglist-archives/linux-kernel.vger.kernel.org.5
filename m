Return-Path: <linux-kernel+bounces-162113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C328B5616
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888E91F210ED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB123EA8C;
	Mon, 29 Apr 2024 11:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j36D8Guj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F924BA2E;
	Mon, 29 Apr 2024 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714388989; cv=none; b=MAxChGFZdMhWVA0tXyVUn3+Ybk/OgPhEXpDWGznRt29JxFtTf24Lxhc0EpAjucKNM41jlUYmbsE6tfNy4k/BKAvPpxKaRreBFceowLe9KSBiiydhLUiDw05ixSmpCEWoL2GuXyobwoD7a1JMcDYnT77PaWWCxo6lAM7TevRnikw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714388989; c=relaxed/simple;
	bh=n4VlKWuglTL9gac4bOpz80Mk+hjg6Jo4dPHuMPumD3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JwkXkCqiHeW4P85ggRZEzrU4m7zEYQqyDUZSEs4jYfVFY+9R8x01QpLqvSJarHnqFURRyiVjBe6xWi0IKW+yAwE0E+hzMxHfHykAyGFHc+koCHFX+8DNyy4O68rmPjvVNuATwJV33ORs5V/fm15Jjy8+dcWPd5ZEOXeDehIY1Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j36D8Guj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3526CC113CD;
	Mon, 29 Apr 2024 11:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714388989;
	bh=n4VlKWuglTL9gac4bOpz80Mk+hjg6Jo4dPHuMPumD3E=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=j36D8GujfbADIPE30rNyIbo/zD+9Vxq5AsF3IQW/3tHZ/1Lj4OaYM8SRyREF1+LrD
	 WZW08P95QOjlPsz/wNQcy0gavlooz2G91mGBYisJUaSuIHNqFA4iYGtx9Y5Jn1BJ0V
	 KAUcBabp265WikNSAiM6VkRJ5M6mst8f6R3kII7dKINhCPAgkwq5+LzeTdid4XHJlY
	 34lfHwjHcZ1cczrEIhPCMJcr/TaTkveYrumjTL6Iidj7sC6r4LUAaW4ulwtTU9xIVx
	 cLF5m2yAoCD1gZjRxJdqqz6u43htWtUqV4GGezP43rBdt5B91CUUcVALQp69sqdfky
	 kxKUknV8mSIQA==
Message-ID: <4dadb3e5-e2e9-4a42-8020-51104ddca0e1@kernel.org>
Date: Mon, 29 Apr 2024 14:09:43 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/6] interconnect: icc-clk: Allow user to specify
 master/slave ids
Content-Language: en-US
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, konrad.dybcio@linaro.org,
 dmitry.baryshkov@linaro.org, quic_anusha@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240429091314.761900-1-quic_varada@quicinc.com>
 <20240429091314.761900-2-quic_varada@quicinc.com>
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20240429091314.761900-2-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.04.24 12:13, Varadarajan Narayanan wrote:
> Presently, icc-clk driver autogenerates the master and slave ids.
> However, devices with multiple nodes on the interconnect could
> have other constraints and may not match with the auto generated
> node ids. Hence, allow the driver to provide the preferred master
> and slave ids.
> 
> Also, update clk-cbf-8996 accordingly.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Acked-by: Georgi Djakov <djakov@kernel.org>

> ---
> v9: squash cbf-msm8996 change into this
> v8: Per review feedback, set master/slave ids explicitly. Dont autogenerate
>      https://lore.kernel.org/linux-arm-msm/f1b0d280-6986-4055-a611-2caceb15867d@linaro.org/
> ---
>   drivers/clk/qcom/clk-cbf-8996.c  | 7 ++++++-
>   drivers/interconnect/icc-clk.c   | 6 +++---
>   include/linux/interconnect-clk.h | 2 ++
>   3 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-cbf-8996.c b/drivers/clk/qcom/clk-cbf-8996.c
> index fe24b4abeab4..a077d4403967 100644
> --- a/drivers/clk/qcom/clk-cbf-8996.c
> +++ b/drivers/clk/qcom/clk-cbf-8996.c
> @@ -237,7 +237,12 @@ static int qcom_msm8996_cbf_icc_register(struct platform_device *pdev, struct cl
>   	struct device *dev = &pdev->dev;
>   	struct clk *clk = devm_clk_hw_get_clk(dev, cbf_hw, "cbf");
>   	const struct icc_clk_data data[] = {
> -		{ .clk = clk, .name = "cbf", },
> +		{
> +			.clk = clk,
> +			.name = "cbf",
> +			.master_id = MASTER_CBF_M4M,
> +			.slave_id = SLAVE_CBF_M4M,
> +		},
>   	};
>   	struct icc_provider *provider;
>   
> diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
> index d787f2ea36d9..2be193fd7d8f 100644
> --- a/drivers/interconnect/icc-clk.c
> +++ b/drivers/interconnect/icc-clk.c
> @@ -108,7 +108,7 @@ struct icc_provider *icc_clk_register(struct device *dev,
>   	for (i = 0, j = 0; i < num_clocks; i++) {
>   		qp->clocks[i].clk = data[i].clk;
>   
> -		node = icc_node_create(first_id + j);
> +		node = icc_node_create(first_id + data[i].master_id);
>   		if (IS_ERR(node)) {
>   			ret = PTR_ERR(node);
>   			goto err;
> @@ -118,10 +118,10 @@ struct icc_provider *icc_clk_register(struct device *dev,
>   		node->data = &qp->clocks[i];
>   		icc_node_add(node, provider);
>   		/* link to the next node, slave */
> -		icc_link_create(node, first_id + j + 1);
> +		icc_link_create(node, first_id + data[i].slave_id);
>   		onecell->nodes[j++] = node;
>   
> -		node = icc_node_create(first_id + j);
> +		node = icc_node_create(first_id + data[i].slave_id);
>   		if (IS_ERR(node)) {
>   			ret = PTR_ERR(node);
>   			goto err;
> diff --git a/include/linux/interconnect-clk.h b/include/linux/interconnect-clk.h
> index 0cd80112bea5..170898faaacb 100644
> --- a/include/linux/interconnect-clk.h
> +++ b/include/linux/interconnect-clk.h
> @@ -11,6 +11,8 @@ struct device;
>   struct icc_clk_data {
>   	struct clk *clk;
>   	const char *name;
> +	unsigned int master_id;
> +	unsigned int slave_id;
>   };
>   
>   struct icc_provider *icc_clk_register(struct device *dev,


