Return-Path: <linux-kernel+bounces-136979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C677289DAA0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 030571C22FB0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E21130E33;
	Tue,  9 Apr 2024 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2VwLffo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1119131196;
	Tue,  9 Apr 2024 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669928; cv=none; b=VuKP+LFTpn+RSsfMBHuvq/zHHEgIXjiF2Iw/PaLs4wZ8J4T/YbBbOzLWqtFnA1ChXYPotNmNka7+vlQ5fJ5JD6W2S8RsuT02MZc/gxzKeZRtDEbDzk4PhTqi4Fv8B+cSCihOy9zxKQ3JVwrGp9fu2JG4huv03EkNs6Jbcl+Rnu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669928; c=relaxed/simple;
	bh=cuqKTraWVNHAMrTrk6z7X0Eq3BVQgg7TMXqERPpyqNY=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=sSHjFsXGq3uGGl+NtAW/BTQ1t3LHiLJ2BtWlgtbMD1hRX/UUNhhEOl2tHqGEEY9+pDxEgzC2tz2Pp4YDDsRdS2uPg26n4QXher+Wr9tBzRqclUnd9j4h6vG1bF6wNXfqdD2qqqGEygkc/xpX9qQ7HV7UkvpFucPIJBXBbpPRiN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2VwLffo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1845DC433F1;
	Tue,  9 Apr 2024 13:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712669928;
	bh=cuqKTraWVNHAMrTrk6z7X0Eq3BVQgg7TMXqERPpyqNY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=N2VwLffo1d1c98JACvj2qKWUS7CbnK9rF7jrER+4sk37lku+e6XXNLDa++oxOfJ4d
	 xHn1Rlc/M1pyjDpdXoY2mmv11/kaEBbJSsxaCHIj5lPXH6hi3FUwUopYdG8ru7P02D
	 f1zPUoaZy5lc6827o4lMq9w2bpyh/3QZKdbAPYA1e+GZPmSL2wgxfsAyMEVGPfP0Pu
	 ZEd/vQCIewurDZydS8QpPub2jC95Y0ffDIL27Nl2fD0FYmN50fqMyE0M51z5wxv0K2
	 m5nOz6F9CZNeb+isg4NwoshmljOXOxF1g/ilEWjudIBV6xK/6eWkm7nvJFg/5Tt1UY
	 2PuaypdTGMaJg==
Date: Tue, 09 Apr 2024 08:38:47 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240407-samsung-galaxy-zfold5-q5q-v4-0-8b67b1813653@yahoo.com>
References: <20240407-samsung-galaxy-zfold5-q5q-v4-0-8b67b1813653@yahoo.com>
Message-Id: <171266958390.1032516.5807331549436106311.robh@kernel.org>
Subject: Re: [PATCH v4 0/2] Samsung Galaxy Z Fold5 initial support


On Sun, 07 Apr 2024 07:38:12 +0200, Alexandru Marc Serdeliuc wrote:
> - removed extraneous new line
> - removed pcie_1_phy_aux_clk
> - removed extranous pcie1
> 
> This documents and add intial dts support for Samsung Galaxy Z Fold5 (samsung,q5q)
> which is a foldable phone by Samsung based on the sm8550 SoC.
> 
> Currently working features:
> - Framebuffer
> - UFS
> - i2c
> - Buttons
> 
> Signed-off-by: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
> ---
> Alexandru Marc Serdeliuc (2):
>       dt-bindings: arm: qcom: Document the Samsung Galaxy Z Fold5
>       arm64: dts: qcom: sm8550: Add support for Samsung Galaxy Z Fold5
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml |   1 +
>  arch/arm64/boot/dts/qcom/Makefile               |   1 +
>  arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts | 593 ++++++++++++++++++++++++
>  3 files changed, 595 insertions(+)
> ---
> base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
> change-id: 20240407-samsung-galaxy-zfold5-q5q-ab1fdb3df966
> 
> Best regards,
> --
> Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y qcom/sm8550-samsung-q5q.dtb' for 20240407-samsung-galaxy-zfold5-q5q-v4-0-8b67b1813653@yahoo.com:

arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dtb: pcie-1-phy-aux-clk: 'clock-frequency' is a required property
	from schema $id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dtb: phy@1c0e000: clock-output-names: ['pcie1_pipe_clk'] is too short
	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#
arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dtb: phy@1c0e000: #clock-cells:0:0: 1 was expected
	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#






