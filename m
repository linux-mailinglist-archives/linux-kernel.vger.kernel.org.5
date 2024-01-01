Return-Path: <linux-kernel+bounces-13889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E87A821445
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 16:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D1CEB2117D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 15:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930D963D9;
	Mon,  1 Jan 2024 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZRCOX8W"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D128F6116;
	Mon,  1 Jan 2024 15:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95469C433C7;
	Mon,  1 Jan 2024 15:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704123827;
	bh=zPnzCjn9QOkXUy8dvYci9jgjlA+acxJXGlng7zvr0Gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eZRCOX8Wa+h7iZPKz6qbhKyje4SPcdT7RhbQP2LY7C3E8vHjtPJr1tNuwGEPbfFVl
	 QSpxMXeJGAV2KqQYaEaYTCdoEI1ZOYfr/FzuE0ZGc8+A94yx8kSriEBe/7LXVibkaj
	 T5YkRwT4sr4FvbROX9AkM1Gex/DA8LHMUA3fdIEzgr+ElbAyzuT1U831mPX8QekctQ
	 B5p0YNxX93cY37btljgd2nG6D5VTgxMPhMUJ0yj3+4uTI9yuRQLIV3XUNey3+hhC0B
	 L3cJkUdqTLrt3bKAYznj7dN3P0fOeygzyB5U6YbXpJFDS70OWKZ/W6yhBRMr/QO3vO
	 oE5EFzXvFo+iw==
Date: Mon, 1 Jan 2024 21:13:36 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Luca Weiss <luca@z3ntu.xyz>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Heidelberg <david@ixit.cz>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: add power domain to UFS phy
 interface
Message-ID: <20240101154336.GA3280@thinkpad>
References: <20231229202959.266502-1-david@ixit.cz>
 <2710291.mvXUDI8C0e@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2710291.mvXUDI8C0e@z3ntu.xyz>

On Fri, Dec 29, 2023 at 10:37:56PM +0100, Luca Weiss wrote:
> On Freitag, 29. Dezember 2023 21:29:54 CET David Heidelberg wrote:
> > Reported by: `make CHECK_DTBS=1 qcom/sdm845-oneplus-enchilada.dtb`
> > 
> > Signed-off-by: David Heidelberg <david@ixit.cz>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > b/arch/arm64/boot/dts/qcom/sdm845.dtsi index c2244824355a..ad8677b62bfb
> > 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -2644,6 +2644,8 @@ ufs_mem_phy: phy@1d87000 {
> >  			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
> >  				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
> > 
> > +			power-domains = <&gcc UFS_PHY_GDSC>;
> > +
> >  			resets = <&ufs_mem_hc 0>;
> >  			reset-names = "ufsphy";
> 
> This is potentially the wrong power domain, see the conversation here:
> https://lore.kernel.org/linux-arm-msm/20231204172829.GA69580@thinkpad/
> 

Yes, GDSCs are the power domain of the controllers, not PHYs. This applies to
other peripherals such as USB, PCIe etc...

- Mani

> Hopefully Mani can give some input here :)
> 
> Regards
> Luca
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

