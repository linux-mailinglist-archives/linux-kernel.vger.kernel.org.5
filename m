Return-Path: <linux-kernel+bounces-162117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B778B5629
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DCCE1F214C9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA4140870;
	Mon, 29 Apr 2024 11:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtbQ6BR+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13C829437;
	Mon, 29 Apr 2024 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389051; cv=none; b=E5QZq5KmrftUyI7fkkFxqwHdG0Lsm1l4Dhyp6FoT2a4fTAX8Uzjrm8bDs3BgZsF7SiNWhqxgoqlKIxv/NkiskeFMygtzfPj9IpNTYFOX8yoBFVaIbXANIABrw2LkO0ml0RgJtqEUPpQOD3lCqeB+zQ2af6TDCs24Vu3qUvixXkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389051; c=relaxed/simple;
	bh=2xFiJF919yl60viNz/D6rBa2ad6gJAgeZZLR7Hj1Xz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FRIfFg2W2GX3nXEtnIKzdr1wpfrqqadKR26bPyP8sbQqp74Yr9swdnz23RRk4vpSJmncyGfpSD1TcnSFBA2VVVLhDw/NCxM5qHq5+6G96Y+5hulKsi4ssdn0M2fa2Ydwm3P1udu3+GzOochk+1G6ugmEM6aHpjC7lhEJNwKr0jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtbQ6BR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAD5C113CD;
	Mon, 29 Apr 2024 11:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714389050;
	bh=2xFiJF919yl60viNz/D6rBa2ad6gJAgeZZLR7Hj1Xz4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=NtbQ6BR+Q6bObSUx8Xy+3U7KJk7rjvo0SiKJJiV64cLte2sDBGxR7ZYoECsopVMZk
	 iMelZgM8RdCYxHVX9qflMGr7vJghokl8CCZ+Ci5FjEII0ks76cQ9u49prljudkEcuT
	 KYJhgPfo4ZJNeOI2fucX4Rni2gq6t28YKgPZFo40kvCaY7VZgEpA0cT4gWQEsqcLFh
	 Z4L62mccWoI2I5g0iNY5soR33l5yjmJc4wyK8fqfr0JualFurpILykyzj5xzfQQH8E
	 cC5TxqWW0EaF1KrZfTnIBUVffV5cowot2AYFWgJ/q9O6BJ4HawdswplAGzxZAPoorh
	 buOTj07FJZLGA==
Message-ID: <b1131b1a-5706-4675-8c97-c2e6a58d6be0@kernel.org>
Date: Mon, 29 Apr 2024 14:10:47 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/6] interconnect: icc-clk: Add devm_icc_clk_register
Content-Language: en-US
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, konrad.dybcio@linaro.org,
 dmitry.baryshkov@linaro.org, quic_anusha@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240429091314.761900-1-quic_varada@quicinc.com>
 <20240429091314.761900-4-quic_varada@quicinc.com>
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20240429091314.761900-4-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.04.24 12:13, Varadarajan Narayanan wrote:
> Wrap icc_clk_register to create devm_icc_clk_register to be
> able to release the resources properly.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Acked-by: Georgi Djakov <djakov@kernel.org>

> ---
> v8: Added Reviewed-by: Dmitry Baryshkov
> v7: Simplify devm_icc_clk_register implementation as suggested in review
> v5: Introduced devm_icc_clk_register
> ---
>   drivers/interconnect/icc-clk.c   | 18 ++++++++++++++++++
>   include/linux/interconnect-clk.h |  2 ++
>   2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
> index 2be193fd7d8f..f788db15cd76 100644
> --- a/drivers/interconnect/icc-clk.c
> +++ b/drivers/interconnect/icc-clk.c
> @@ -148,6 +148,24 @@ struct icc_provider *icc_clk_register(struct device *dev,
>   }
>   EXPORT_SYMBOL_GPL(icc_clk_register);
>   
> +static void devm_icc_release(void *res)
> +{
> +	icc_clk_unregister(res);
> +}
> +
> +int devm_icc_clk_register(struct device *dev, unsigned int first_id,
> +			  unsigned int num_clocks, const struct icc_clk_data *data)
> +{
> +	struct icc_provider *prov;
> +
> +	prov = icc_clk_register(dev, first_id, num_clocks, data);
> +	if (IS_ERR(prov))
> +		return PTR_ERR(prov);
> +
> +	return devm_add_action_or_reset(dev, devm_icc_release, prov);
> +}
> +EXPORT_SYMBOL_GPL(devm_icc_clk_register);
> +
>   /**
>    * icc_clk_unregister() - unregister a previously registered clk interconnect provider
>    * @provider: provider returned by icc_clk_register()
> diff --git a/include/linux/interconnect-clk.h b/include/linux/interconnect-clk.h
> index 170898faaacb..9bcee3e9c56c 100644
> --- a/include/linux/interconnect-clk.h
> +++ b/include/linux/interconnect-clk.h
> @@ -19,6 +19,8 @@ struct icc_provider *icc_clk_register(struct device *dev,
>   				      unsigned int first_id,
>   				      unsigned int num_clocks,
>   				      const struct icc_clk_data *data);
> +int devm_icc_clk_register(struct device *dev, unsigned int first_id,
> +			  unsigned int num_clocks, const struct icc_clk_data *data);
>   void icc_clk_unregister(struct icc_provider *provider);
>   
>   #endif


