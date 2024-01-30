Return-Path: <linux-kernel+bounces-45026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C147D842AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D706288216
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE55F1292D6;
	Tue, 30 Jan 2024 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5sVTDYc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173E126AC6;
	Tue, 30 Jan 2024 17:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706634891; cv=none; b=CBTmoLn44A5ejrzy99Wgg9U0mvM0MOQT9+UykzJiwxrUYyfyeF1nHqBXZuj6EMup1eNWLK1u5wb4ovUevLKlx7XE+Vw8ZAIXPT32r4joh7H6RkrFLfnZZgJn4lCsXaFpKuiVmlCQO9VflBLGzo3g0CXmq1n0RJqdR0ObgEKlDIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706634891; c=relaxed/simple;
	bh=A5T8FP/fhIVtH/olVEw0tzShluBYACTWaf+iE7kNjHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrk7NrM89gE42QmOaElXCgtUllBsrRz6JlYZCvcBSdxAAWuAJ6CKrTQGZR1tw1UOW4FZ7jHkZTjG16uS+wDqe94U7hZhKAgVZl4p8FcG21cP/lCYL8S8Do5refGWkIhyK35rllyIuBNGY6DREq7fF4B9jRJSKOVKC8MvoViAFqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5sVTDYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0B3C433C7;
	Tue, 30 Jan 2024 17:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706634890;
	bh=A5T8FP/fhIVtH/olVEw0tzShluBYACTWaf+iE7kNjHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B5sVTDYcZYQd6secc+1JOjx11SzAr4mybLbcRDSte3T8Xi62OLzcth2fj04pGx37w
	 SfdAaUIfYHZH44RnWaSeE9sFYUpJAVvbBDO1o42UR514TdkB7qJPRdy2etQ45uYCp6
	 DIKvVDpDFZohfFtwzm/tEAh30eyIsJHjeuts7GQ0PVks8OaC0jxNKjgm4tQXYFs9hz
	 WaskVbC/gMNGEhjIWK5Ytt8jNaVc1+Ck49ELh5odrADWqEZb0B1IMltoNXWNuBjPo8
	 WmLTkMkGEXr3xmf7AVnWdDUD8uDtkj4AzA9k9SbGrVkMM2T+8RC3RXS4Vs3RYjQBSj
	 MPdAOv5LpsXWQ==
Date: Tue, 30 Jan 2024 22:44:46 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/14] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Fix
 the usage of aux clk
Message-ID: <ZbkuhjOa31ma3Mx8@matsya>
References: <20240124-pcie-aux-clk-fix-v1-0-d8a4852b6ba6@linaro.org>
 <20240124-pcie-aux-clk-fix-v1-4-d8a4852b6ba6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124-pcie-aux-clk-fix-v1-4-d8a4852b6ba6@linaro.org>

On 24-01-24, 13:06, Manivannan Sadhasivam wrote:
> On some platforms, PHY block requires PCIE_PHY_AUX_CLK to be used when the
> PCIe link enters L1SS state. On those platforms, a dedicated
> PCIE_PHY_AUX_CLK is available from GCC. Other than this, the PHY block
> doesn't require any other "aux" clock, including PCIE_AUX_CLK which only
> required by the PCIe controller.
> 
> Historically, the DTs of the platforms requiring "aux" clock passed
> PCIE_PHY_AUX_CLK as "aux" clock. But over the period of time, platforms
> that do not require this dedicated "aux" clock mistakenly started passing
> the PCIE_AUX_CLK as the "aux" clock. More recently, SA8775P platform passed
> both "aux" (PCIE_AUX_CLK) and "phy_aux" (PCIE_PHY_AUX_CLK) clocks.
> 
> So to clean up this mess, let's remove the newly introduced "phy_aux" clock
> and just use "aux" clock to supply PCIE_PHY_AUX_CLK for platforms that
> require it. For the platforms that do not require a dedicated "aux" clock,
> the clock is removed from DT.
> 
> While at it, let's also define "qcom,sc7280-qmp-pcie-phy" compatible for
> SC7280 SoC which was earlier using the compatible
> "qcom,sm8250-qmp-gen3x2-pcie-phy" as the clock requirement has changed and
> also restructure the "clock-names" property for the affected platforms.

This one fails to apply for me

-- 
~Vinod

