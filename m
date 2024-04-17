Return-Path: <linux-kernel+bounces-148653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 590E38A8596
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52591F241A4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B671411E5;
	Wed, 17 Apr 2024 14:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQiaEkQ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A92C14039D;
	Wed, 17 Apr 2024 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713362880; cv=none; b=iFetm3Aiw3+bLLarrzQvjO9OPxHXcrahsK54ziFLZUPHYVz3JCX24RplRJmLuD22EpcP7OBD5K4B37m+921T6YfQnDIk8KevrgCJbbdTjAnhKzEkrY9SEk+Vc9Tax/IjyQaFtePoWG5KeeeWHXx/PkzqO4DlsjrHHn/XAMmz1zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713362880; c=relaxed/simple;
	bh=5hS45g5M3LFot7tByWQpyieDDMvyjOnns7f0oJIOwl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L46LU/Lk3tsQZ0aCc+3Bwm/KQaxfPn0ZsdL5oi86bYXTm8THcPziAlPs4ylU4qDxB9d9u3cBIp0/4zrvHnG1nWDlfIMqgLnIgezKkJfpS9T3XNF6soIjGjtokBkRony2sQOEwx58IsQ7vGALgtw+iDlgNJos3cOARPKjfzu5z5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQiaEkQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602EEC072AA;
	Wed, 17 Apr 2024 14:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713362879;
	bh=5hS45g5M3LFot7tByWQpyieDDMvyjOnns7f0oJIOwl8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ZQiaEkQ5LEF9f2Mr4pZ3UqHjKtntViJumK3VVtzx2AzjVPN6leObj1i4//Ek22y5Q
	 hZJuO9bYZtgmaweNPcZzd1AvTehpALBan7rGpnzUGjrjTpaWMXOg/+b+j4Eq+uts0T
	 GsOtD+rRY7ucw+zQEOcfXyA0BX9eDct9O2DymevoF1mZXgIgNzJ7/ckWg6k2ZXGou9
	 hZ6kWrHWt5dvZdUos2pbjV/Lth9cQWzwCrra09fdKP6iwPFV/PiZzPT0CRSRm4/rHY
	 GulJAyu8ZhgPL/dCT7+0TwAKn4j/Ui8oa2uCZvLHfJ6K7zDC1LlvNkjgOHfnCNUvqF
	 8k2C9yrBV3qYg==
Message-ID: <f00a62c8-6f4d-4be4-800e-58898ea58490@kernel.org>
Date: Wed, 17 Apr 2024 16:07:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/7] dt-bindings: interconnect: Add Qualcomm IPQ9574
 support
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, konrad.dybcio@linaro.org,
 djakov@kernel.org, dmitry.baryshkov@linaro.org, quic_anusha@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240417105605.836705-1-quic_varada@quicinc.com>
 <20240417105605.836705-4-quic_varada@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240417105605.836705-4-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/04/2024 12:56, Varadarajan Narayanan wrote:
> Add interconnect-cells to clock provider so that it can be
> used as icc provider.
> 
> Add master/slave ids for Qualcomm IPQ9574 Network-On-Chip
> interfaces. This will be used by the gcc-ipq9574 driver
> that will for providing interconnect services using the
> icc-clk framework.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
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
>  .../bindings/clock/qcom,ipq9574-gcc.yaml      |  3 +
>  .../dt-bindings/interconnect/qcom,ipq9574.h   | 59 +++++++++++++++++++
>  2 files changed, 62 insertions(+)
>  create mode 100644 include/dt-bindings/interconnect/qcom,ipq9574.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
> index 944a0ea79cd6..824781cbdf34 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
> @@ -33,6 +33,9 @@ properties:
>        - description: PCIE30 PHY3 pipe clock source
>        - description: USB3 PHY pipe clock source
>  
> +  '#interconnect-cells':
> +    const: 1
> +
>  required:
>    - compatible
>    - clocks
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

I still do not see any usage of it. At least symbol cannot be resolved.
I assume you use the value, otherwise it would mean our entire feedback
was ignored, but then why this cannot be searchable?

Again, open existing drivers and look how it is there. Not being able to
find the constant is not good.

Best regards,
Krzysztof


