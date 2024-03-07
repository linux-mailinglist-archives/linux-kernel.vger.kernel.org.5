Return-Path: <linux-kernel+bounces-96321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E521875A31
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FEB81C20C67
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E1B13F006;
	Thu,  7 Mar 2024 22:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxvHkuHE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B38130AD0;
	Thu,  7 Mar 2024 22:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709850252; cv=none; b=YuSgywiI2So50hxujtROkNXI+fp4mo2wy4wDvoP5dIC31cF/nBWTodnHmdATEIXg9Ptck5w1gnZH3B62jSauE6Cuxd142fTC8BG4414NAtDB3bjYJp2+L3pth5S0wpX/s+INihHuKqD62VIbGD0ZlF3NmAE9krIgnMJhArZaBGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709850252; c=relaxed/simple;
	bh=oMeYecuHZIy3l6Q9Du0Z/SK+z9Wg3+rQlraIvaDliCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEH65AHpS0aw6IydZ41jJr+CJMW1p/bma/TxYNktpqj6yydzLsU+RORZOK7tPVKdFY+DtdrhjEbNxjowpBAFbc5br9UlK79NoHI43fArHON/A6sBt0U/dnkN1ETSyqX+3bQqxp44Zayqiu+rYUkSyRPX1MzFsqghtW9uRQnHggk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxvHkuHE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EE7C433F1;
	Thu,  7 Mar 2024 22:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709850251;
	bh=oMeYecuHZIy3l6Q9Du0Z/SK+z9Wg3+rQlraIvaDliCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nxvHkuHElKkgFc/iEqtq391OweqsrPmOn6N+UB6Si0PXtQeoOknkLKiCbnb1YdLNT
	 0riomS38WR/801S/Q+MleGSSfwA0obsRpkVSFeVDzK4kqku+f3pTVjgVb/qdd84+4L
	 of5uBJopiIm5gHazmhk7ysMrdq1STUXJVNq+E8QC4VLUeVjys3aMHDdxHT1c9CB260
	 zYixtqZoyHy3ikwD35iIfpkDdwWsQD2iQke+6s3NDs17OckpondwNRmoOlGNqyIsXq
	 JzHXrc8jBQqzjv8NgLKlHeWIdnw/aJXHZUz/mQwFLxgXWzquTwEVc4+G2HwyKV0zJu
	 kz7q6Xro/FXjQ==
Date: Thu, 7 Mar 2024 16:24:08 -0600
From: Rob Herring <robh@kernel.org>
To: Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc: andersson@kernel.org, robin.murphy@arm.com, quic_pdaly@quicinc.com,
	quic_sudaraja@quicinc.com, iommu@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org, joro@8bytes.org,
	djakov@kernel.org, will@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
	quic_cgoldswo@quicinc.com, quic_sukadev@quicinc.com,
	robdclark@gmail.com, linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org
Subject: Re: [PATCH v6 1/7] dt-bindings: iommu: Add Qualcomm TBU
Message-ID: <170985024752.3267604.7194637769214315327.robh@kernel.org>
References: <20240307190525.395291-1-quic_c_gdjako@quicinc.com>
 <20240307190525.395291-2-quic_c_gdjako@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307190525.395291-2-quic_c_gdjako@quicinc.com>


On Thu, 07 Mar 2024 11:05:19 -0800, Georgi Djakov wrote:
> The "apps_smmu" on the Qualcomm sdm845 platform is an implementation
> of the SMMU-500, that consists of a single TCU (Translation Control
> Unit) and multiple TBUs (Translation Buffer Units). These TBUs have
> hardware debugging features that are specific and only present on
> Qualcomm hardware. Represent them as independent DT nodes. List all
> the resources that are needed to operate them (such as registers,
> clocks, power domains and interconnects).
> 
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---
>  .../devicetree/bindings/iommu/qcom,tbu.yaml   | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/qcom,tbu.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


