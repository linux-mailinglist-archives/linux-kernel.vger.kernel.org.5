Return-Path: <linux-kernel+bounces-63599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9A085320C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68BB21F23598
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96AB5645F;
	Tue, 13 Feb 2024 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8kUuA8D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1159B55E72;
	Tue, 13 Feb 2024 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831318; cv=none; b=d27zEm8di3JfeC6BC9kRa1/JfoX1mQtt8ELrg6kM7YXRqSmz+TxyESze+8cErmkRJxSUIY3MglxGAr+C7JjcT1zQgjs35vQUpB9seTFlRt+4GykMJdY1Cx8Dbe3Z/T71CU5i6S3E8Fqg8yVpfM2IQPk+DrWmZCkZlC/btWmvOEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831318; c=relaxed/simple;
	bh=hWYB7hzE02nmcZir4gyGszu+ssGzykhABiMcXYZhWc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nsd/b2je9nM8dr1XW08NV5C4hogmSaEEoXG1uHnkiel/S2LR2RxVd/lH5rtSyJsjecd+5BqMkIFANcsqwxzM3IbjGd9CUIw9djQI63hVWoiyZu6nFH2h6ebzejOes1TyTzLQJpOw5IfsQnf2Au8GxmXT9ojKBXAx16/zLpv6Ez0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8kUuA8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9E5C433C7;
	Tue, 13 Feb 2024 13:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707831317;
	bh=hWYB7hzE02nmcZir4gyGszu+ssGzykhABiMcXYZhWc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h8kUuA8DVRrTOU30krCZjESSXRmrvf8X3glSUNjwzAmH3Mlp+o50Kutkc3E+xXYAQ
	 Jn359JgRelrX8ncdBaRxUOEN7L8i0KkgEHFLWhhszwwEFIfE51haAi8WL5gJjKdqeX
	 AtcJSQIabuPyLnn2/TZIMZUmPaxrCOuAOaaRUbWJQ5FrmNbEdijdVaJ8gcdyVc6179
	 yIgUHdpXo5qGq9x4TPW8rGZ7S9N1FPW889Wo7ebQPSH873yGII2goqvufDv40rOtJD
	 03Wm36B+MqXlIhoIACQgHajYz8Y9ikpevYcf2e7ywr+mEP5FIIcBeVzoi8elc4EEGJ
	 qILZr4nkCg34A==
Date: Tue, 13 Feb 2024 07:35:15 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-msm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Amol Maheshwari <amahesh@qti.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: misc: qcom,fastrpc: Compute callbacks
 can be DMA coherent
Message-ID: <170783131383.1076615.17145419971543353598.robh@kernel.org>
References: <20240212110827.59302-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212110827.59302-1-krzysztof.kozlowski@linaro.org>


On Mon, 12 Feb 2024 12:08:27 +0100, Krzysztof Kozlowski wrote:
> Apparently on Qualcomm SM8550 and SM8650 the FastRPC compute callbacks
> are DMA coherent:
> 
>   sm8650-qrd.dtb: fastrpc: compute-cb@2: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. Add missing subject prefix.
> ---
>  Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!


