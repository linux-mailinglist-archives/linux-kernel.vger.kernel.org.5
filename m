Return-Path: <linux-kernel+bounces-132141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F16D89902D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5DE282D80
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4490713C3D1;
	Thu,  4 Apr 2024 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oW0aINKT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F01813C9A5;
	Thu,  4 Apr 2024 21:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265810; cv=none; b=l3sznh3sZRHcaIrdlBj034qZJhhY6HtvbaZl5EuxoBSTaLXvPhQY87lAPbMi97+uJmKNyLopv+fqvUah62CqrBtaYpwgnde2wLhhtpo22NTZm427En32shPMK3dFP4hsue4GWv2M6wH1sAGsJIL+6fjIR3xDEcp4G18Zy4xdw1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265810; c=relaxed/simple;
	bh=kovnjzwiC0G2cWnn4/jPF54CWL4xZ+ju8Z91pLGS6d4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BgKm2qmd1+bAc962VOsB5RSX0+9seyvIuahZYlyTd4DXX7/j/CPtcmVBTI2ss3Yj95fR49EpREXvbCfJGdvX+VTMa6XxOJeqT8fP7r99hMNs9EtegedgngmJYpmQ8xR59i5ib6e0lU2NXAGBYGEetLiqZpfZZe9vCs2ECIQSRO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oW0aINKT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5364AC43394;
	Thu,  4 Apr 2024 21:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712265810;
	bh=kovnjzwiC0G2cWnn4/jPF54CWL4xZ+ju8Z91pLGS6d4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oW0aINKTppo9dk7pY+UkZHeSVhSwlgU0aG7y5ps1ldIQUe7NxR0lBeNF0G22ih871
	 PFW8i0JdLHQBlLN1gNRcfBvG8HiAX9T9NJpyLKN97lEtF+NNXJiNYALfFAtvLWoJJk
	 nce05VHcj90RAGQdKLLZd1a/YfNGbgLWXz28OicmPwqIdVqgrgaKX3r0wRP4Z8qzRu
	 kE6+WqINMG1X0ZDySpW60Dd2JxIKsSQDSNOgn4plpLTLt2liQPxIhRkU//61sdiZIM
	 qm6INd0i4SV18Sqf0UMEQIBcjhHPVrF+4oc4NWtsDRbASMF/TVRpmLC9Wr2PpiEyOF
	 8nldDmbyWA0eA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Danila Tikhonov <danila@jiaxyga.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: pm6150: correct Type-C compatible
Date: Thu,  4 Apr 2024 16:22:57 -0500
Message-ID: <171226578660.615813.8144995995970983880.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240328074544.5076-1-krzysztof.kozlowski@linaro.org>
References: <20240328074544.5076-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 28 Mar 2024 08:45:44 +0100, Krzysztof Kozlowski wrote:
> The first part of the compatible of Type-C node misses ending quote,
> thus we have one long compatible consisting of two compatible strings
> leading to dtbs_check warnings:
> 
>   sc7180-idp.dtb: usb-vbus-regulator@1100: compatible:0: 'qcom,pm6150-vbus-reg,\n qcom,pm8150b-vbus-reg' does not match '^[a-zA-Z0-9][a-zA-Z0-9,+\\-._/]+$'
>   sc7180-idp.dtb: /soc@0/spmi@c440000/pmic@0/usb-vbus-regulator@1100: failed to match any schema with compatible: ['qcom,pm6150-vbus-reg,\n          qcom,pm8150b-vbus-reg']
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: pm6150: correct Type-C compatible
      commit: 5582e357d0c6bfdc889773ca3c9b7b0dd31dc334

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

