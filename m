Return-Path: <linux-kernel+bounces-13244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 285B28201EC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 22:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60C3C2840F1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 21:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EEF14A91;
	Fri, 29 Dec 2023 21:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="X7qwEdQn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FC914A84;
	Fri, 29 Dec 2023 21:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1703885877; bh=rlLO+itffQ8Pdluxb5C6POSj+RujmL7qJCHF3ofN3J4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X7qwEdQnLwr7FNmTSc/OyWdZH3dkdPHQc+vSUPmYBIc448lLace631pyWkzjxXDvD
	 lCopRDcbkUdPd98oGcbQPKBWH0/QUDsYkVm5YP1axtE+l9R/Ocr8ugQzC5UAuEFlIx
	 vor21uk9EnyIdoIb2PC/rGXw1KN9PegEOzmYGtWs=
From: Luca Weiss <luca@z3ntu.xyz>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 David Heidelberg <david@ixit.cz>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Manivannan Sadhasivam <mani@kernel.org>
Subject:
 Re: [PATCH] arm64: dts: qcom: sdm845: add power domain to UFS phy interface
Date: Fri, 29 Dec 2023 22:37:56 +0100
Message-ID: <2710291.mvXUDI8C0e@z3ntu.xyz>
In-Reply-To: <20231229202959.266502-1-david@ixit.cz>
References: <20231229202959.266502-1-david@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 29. Dezember 2023 21:29:54 CET David Heidelberg wrote:
> Reported by: `make CHECK_DTBS=1 qcom/sdm845-oneplus-enchilada.dtb`
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> b/arch/arm64/boot/dts/qcom/sdm845.dtsi index c2244824355a..ad8677b62bfb
> 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -2644,6 +2644,8 @@ ufs_mem_phy: phy@1d87000 {
>  			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
>  				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
> 
> +			power-domains = <&gcc UFS_PHY_GDSC>;
> +
>  			resets = <&ufs_mem_hc 0>;
>  			reset-names = "ufsphy";

This is potentially the wrong power domain, see the conversation here:
https://lore.kernel.org/linux-arm-msm/20231204172829.GA69580@thinkpad/

Hopefully Mani can give some input here :)

Regards
Luca



