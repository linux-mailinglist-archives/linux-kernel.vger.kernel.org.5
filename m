Return-Path: <linux-kernel+bounces-162115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1878B5620
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C622826F7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2350446AF;
	Mon, 29 Apr 2024 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiTVkJQW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52E83F8F4;
	Mon, 29 Apr 2024 11:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389020; cv=none; b=STbAVruFxVETPUcUXNA2T85NwjDZCO8Mj5Ip/p9NHhNdeukx/Ks49vMTYAJglqb3anrlmaBPkz+73Nkn1Xej8wxqVldpe/zL/BFEvuO285J3j0IdXvef/0bqOBoBACu8gx3UzvnIBCbuAQ/cGTh4emejboWPlOtcSGfvUOOWvhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389020; c=relaxed/simple;
	bh=Jw3BF58j9P0+pjLJIARhtTeUVYkoPyQ1uQaF82KC3Y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FjS/r0JKz7+zIJsKXxkcs96TjiuZWdXHAAhB7hNLuuACnCZsnTi9chtYPPUiSEEMbQ4981fHR7nRMYOeGaYJK4JAK9nvUo9Y/DUOeqFstPP9iN2e6X2KlbX4T7fFR+NW9iwvHt5gO2q3aASd+sHPOZeEHcoyrcUbsUfqmITTqjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiTVkJQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707E2C113CD;
	Mon, 29 Apr 2024 11:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714389019;
	bh=Jw3BF58j9P0+pjLJIARhtTeUVYkoPyQ1uQaF82KC3Y4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AiTVkJQW7op2LofnLvs340f5MU8ojxjvvCr13fEzy0b+UyD3RbbTQg/i/11ALgKBr
	 T8/pvOqZucIMlrp8o4BbwLllopJbDrCPXZJsgJ68NpEcJ4Cl2CTslrqPueqgzFVoSR
	 Al81zGt5eW8KNn6c/tYHv1uBbgpDFLdBoNYdFxwDJi7xA0yoF4RDtZt72OusTVVu9X
	 QqN89uJkj3p75e7UqVOBIikxVS/GL75mTIa4Xi6hWKhUxRKq7g8NURfZyeAEbnOYdp
	 qVwgZ5pBbwSc377NOE9b96YhFGw/NZNyrJF6ghlpInYwwIvheDy8GKE9p3h8f5SCEI
	 riYtYrr5Hy7uA==
Message-ID: <56d29770-6cf2-43bf-9d48-6f314a5ac5e1@kernel.org>
Date: Mon, 29 Apr 2024 14:10:16 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/6] dt-bindings: interconnect: Add Qualcomm IPQ9574
 support
Content-Language: en-US
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, konrad.dybcio@linaro.org,
 dmitry.baryshkov@linaro.org, quic_anusha@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240429091314.761900-1-quic_varada@quicinc.com>
 <20240429091314.761900-3-quic_varada@quicinc.com>
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20240429091314.761900-3-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.04.24 12:13, Varadarajan Narayanan wrote:
> Add interconnect-cells to clock provider so that it can be
> used as icc provider.
> 
> Add master/slave ids for Qualcomm IPQ9574 Network-On-Chip
> interfaces. This will be used by the gcc-ipq9574 driver
> that will for providing interconnect services using the
> icc-clk framework.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Acked-by: Georgi Djakov <djakov@kernel.org>

> ---
> v8:
> Remove ICC_xxx macros
> Fix macro defines to be consistent with other bindings
> v7:
> Fix macro names to be consistent with other bindings
> v6:
> Removed Reviewed-by: Krzysztof Kozlowski
> Redefine the bindings such that driver and DT can share them
> 
> v3:
> Squash Documentation/ and include/ changes into same patch
> 
> qcom,ipq9574.h
> 	Move 'first id' to clock driver
> 
> ---
>   .../bindings/clock/qcom,ipq9574-gcc.yaml      |  3 +
>   .../dt-bindings/interconnect/qcom,ipq9574.h   | 59 +++++++++++++++++++
>   2 files changed, 62 insertions(+)
>   create mode 100644 include/dt-bindings/interconnect/qcom,ipq9574.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
> index 944a0ea79cd6..824781cbdf34 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
> @@ -33,6 +33,9 @@ properties:
>         - description: PCIE30 PHY3 pipe clock source
>         - description: USB3 PHY pipe clock source
>   
> +  '#interconnect-cells':
> +    const: 1
> +
>   required:
>     - compatible
>     - clocks
> diff --git a/include/dt-bindings/interconnect/qcom,ipq9574.h b/include/dt-bindings/interconnect/qcom,ipq9574.h
> new file mode 100644
> index 000000000000..42019335c7dd
> --- /dev/null
> +++ b/include/dt-bindings/interconnect/qcom,ipq9574.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +#ifndef INTERCONNECT_QCOM_IPQ9574_H
> +#define INTERCONNECT_QCOM_IPQ9574_H
> +
> +#define MASTER_ANOC_PCIE0		0
> +#define SLAVE_ANOC_PCIE0		1
> +#define MASTER_SNOC_PCIE0		2
> +#define SLAVE_SNOC_PCIE0		3
> +#define MASTER_ANOC_PCIE1		4
> +#define SLAVE_ANOC_PCIE1		5
> +#define MASTER_SNOC_PCIE1		6
> +#define SLAVE_SNOC_PCIE1		7
> +#define MASTER_ANOC_PCIE2		8
> +#define SLAVE_ANOC_PCIE2		9
> +#define MASTER_SNOC_PCIE2		10
> +#define SLAVE_SNOC_PCIE2		11
> +#define MASTER_ANOC_PCIE3		12
> +#define SLAVE_ANOC_PCIE3		13
> +#define MASTER_SNOC_PCIE3		14
> +#define SLAVE_SNOC_PCIE3		15
> +#define MASTER_USB			16
> +#define SLAVE_USB			17
> +#define MASTER_USB_AXI			18
> +#define SLAVE_USB_AXI			19
> +#define MASTER_NSSNOC_NSSCC		20
> +#define SLAVE_NSSNOC_NSSCC		21
> +#define MASTER_NSSNOC_SNOC_0		22
> +#define SLAVE_NSSNOC_SNOC_0		23
> +#define MASTER_NSSNOC_SNOC_1		24
> +#define SLAVE_NSSNOC_SNOC_1		25
> +#define MASTER_NSSNOC_PCNOC_1		26
> +#define SLAVE_NSSNOC_PCNOC_1		27
> +#define MASTER_NSSNOC_QOSGEN_REF	28
> +#define SLAVE_NSSNOC_QOSGEN_REF		29
> +#define MASTER_NSSNOC_TIMEOUT_REF	30
> +#define SLAVE_NSSNOC_TIMEOUT_REF	31
> +#define MASTER_NSSNOC_XO_DCD		32
> +#define SLAVE_NSSNOC_XO_DCD		33
> +#define MASTER_NSSNOC_ATB		34
> +#define SLAVE_NSSNOC_ATB		35
> +#define MASTER_MEM_NOC_NSSNOC		36
> +#define SLAVE_MEM_NOC_NSSNOC		37
> +#define MASTER_NSSNOC_MEMNOC		38
> +#define SLAVE_NSSNOC_MEMNOC		39
> +#define MASTER_NSSNOC_MEM_NOC_1		40
> +#define SLAVE_NSSNOC_MEM_NOC_1		41
> +
> +#define MASTER_NSSNOC_PPE		0
> +#define SLAVE_NSSNOC_PPE		1
> +#define MASTER_NSSNOC_PPE_CFG		2
> +#define SLAVE_NSSNOC_PPE_CFG		3
> +#define MASTER_NSSNOC_NSS_CSR		4
> +#define SLAVE_NSSNOC_NSS_CSR		5
> +#define MASTER_NSSNOC_IMEM_QSB		6
> +#define SLAVE_NSSNOC_IMEM_QSB		7
> +#define MASTER_NSSNOC_IMEM_AHB		8
> +#define SLAVE_NSSNOC_IMEM_AHB		9
> +
> +#endif /* INTERCONNECT_QCOM_IPQ9574_H */


