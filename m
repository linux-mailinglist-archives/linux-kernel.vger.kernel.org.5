Return-Path: <linux-kernel+bounces-57851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5738684DE33
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3C5B1F2195E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F996D1BC;
	Thu,  8 Feb 2024 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="uIs3cud2"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5396D1B1;
	Thu,  8 Feb 2024 10:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387801; cv=none; b=UDH1pgd98eYDnvMmNbv7iXtJi6Hfg4z19AojMWS2Nx97PLToQbjzJOKxBXdGQ1erm4q5iESxP/XnytAVRnRm/J/2+6WdZKvzhLRZhVeM2K9inpKBkF8xVmREcx1Rw9ZaciQSqsJPQncNdqbd/cn1o+4GpL5fVldWsULeURORKwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387801; c=relaxed/simple;
	bh=rdTUwc8x+VP4Z80u7knDZnICtRjt28f4v9RiwMWuWNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bb0Gdwz3/v2/BrsdXUDA7wvp+eyg68RME3LxuNfFc32cSrZWjJJ+HxmEvgPmtaiODOGJbdE10A56LsMRY14KmIv8D0Ax5thZh+h9ULd17xXYckeuaB2IAy3fvyRufapaf5g0cLl6szupDLVqvuO7omLEd9LXNHpaMDcO4fuIw9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=uIs3cud2; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 277F260A49;
	Thu,  8 Feb 2024 10:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1707387798;
	bh=rdTUwc8x+VP4Z80u7knDZnICtRjt28f4v9RiwMWuWNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uIs3cud2W+1a+liFnivGr1DZTxgNDfsoAFHv75Q+ClJErKFdZL69vvVTVIcLDmRyT
	 X0uCOotD6bHkHC1LnexQQl0LYVQegSn09St1jFJ+nWiH+QK18Cw3mmfuAVh3NtECNa
	 1N3J4NsfH5CTjzfFpGbU7oQyb4TB1lRaIpj0JmJA8ttSdDMwguOw7ccWXQCHoQ5tRz
	 w+wgBN5UgGMq8V6WgrnJ4Z8hzw+DiZb0GeMmje+O6NRiCenl9dmAb/xkFA83cL9C9m
	 e4LOLSagkDSGjFDbP1NRYvkTHLvD8DcU8f0tCmpoJ5Y6tXcUXHy2s89zb/te+sNp+a
	 4Hl6raPkSR9rQ==
Date: Thu, 8 Feb 2024 12:22:52 +0200
From: Tony Lindgren <tony@atomide.com>
To: Rob Herring <robh@kernel.org>
Cc: Andreas Kemnade <andreas@kemnade.info>, mturquette@baylibre.com,
	sboyd@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, kristo@kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: clock: ti: Convert interface.txt to
 json-schema
Message-ID: <20240208102252.GB52537@atomide.com>
References: <20231127202359.145778-1-andreas@kemnade.info>
 <20231128171647.GA3343123-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128171647.GA3343123-robh@kernel.org>

Hi,

* Rob Herring <robh@kernel.org> [231128 17:16]:
> On Mon, Nov 27, 2023 at 09:23:59PM +0100, Andreas Kemnade wrote:
> > Convert the OMAP interface clock device tree binding to json-schema
> > and fix up reg property which is optional and taken from parent if
> > not specified.
> > Specify the creator of the original binding as a maintainer.
> 
> Great! This and other TI clocks are at the top of the list[1] of 
> occurrences of undocumented (by schemas) compatibles: 
> 
>    3763 ['ti,omap3-interface-clock']
>    3249 ['ti,divider-clock']
>    1764 ['ti,mux-clock']
>    1680 ['ti,gate-clock']
>    1522 ['ti,wait-gate-clock']
>    1459 ['ti,composite-clock']
>    1343 ['ti,composite-mux-clock']
>    1341 ['ti,clkctrl']
>    1296 ['fsl,imx6q-ssi', 'fsl,imx51-ssi']
>    1196 ['ti,composite-gate-clock']
>    1032 ['ti,clockdomain']
> 
> Of course, that's largely due to OMAP being early clock adopter and 
> trying to do fine-grained clocks in DT.

So related to dealing with the warnings above, and the numerous
warnings for unique_unit_address, I suggest we update the clksel clock
children for the standard reg property as we already discussed a bit
earlier.

The suggested patch for the am3 clksel children is below for reference.
I have at least one issue to sort out before I can post proper patches.

The issue I'm seeing is that updating omap3 clkcsel clocks in a similar
way adds a new error that gets multiplied by about 50 times as the
dss_tv_fck and dss_96m_fck both seem to really be gated by the same
bit..

I think the dss_tv_fck might be derived from the dss_96m_fck really,
and the documentation is wrong. If anybody has more info on this please
let me know, otherwise I guess I'll just leave the clock@e00 not updated
for now.

Regards,

Tony

> [1] https://gitlab.com/robherring/linux-dt/-/jobs/5620809910#L5618
>

8< ---------------------------
diff --git a/arch/arm/boot/dts/ti/omap/am33xx-clocks.dtsi b/arch/arm/boot/dts/ti/omap/am33xx-clocks.dtsi
--- a/arch/arm/boot/dts/ti/omap/am33xx-clocks.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am33xx-clocks.dtsi
@@ -108,30 +108,31 @@ clock@664 {
 		compatible = "ti,clksel";
 		reg = <0x664>;
 		#clock-cells = <2>;
-		#address-cells = <0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 
-		ehrpwm0_tbclk: clock-ehrpwm0-tbclk {
+		ehrpwm0_tbclk: clock-ehrpwm0-tbclk@0 {
+			reg = <0>;
 			#clock-cells = <0>;
 			compatible = "ti,gate-clock";
 			clock-output-names = "ehrpwm0_tbclk";
 			clocks = <&l4ls_gclk>;
-			ti,bit-shift = <0>;
 		};
 
-		ehrpwm1_tbclk: clock-ehrpwm1-tbclk {
+		ehrpwm1_tbclk: clock-ehrpwm1-tbclk@1 {
+			reg = <1>;
 			#clock-cells = <0>;
 			compatible = "ti,gate-clock";
 			clock-output-names = "ehrpwm1_tbclk";
 			clocks = <&l4ls_gclk>;
-			ti,bit-shift = <1>;
 		};
 
-		ehrpwm2_tbclk: clock-ehrpwm2-tbclk {
+		ehrpwm2_tbclk: clock-ehrpwm2-tbclk@2 {
+			reg = <2>;
 			#clock-cells = <0>;
 			compatible = "ti,gate-clock";
 			clock-output-names = "ehrpwm2_tbclk";
 			clocks = <&l4ls_gclk>;
-			ti,bit-shift = <2>;
 		};
 	};
 };
@@ -566,17 +567,19 @@ clock@52c {
 		compatible = "ti,clksel";
 		reg = <0x52c>;
 		#clock-cells = <2>;
-		#address-cells = <0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 
-		gfx_fclk_clksel_ck: clock-gfx-fclk-clksel {
+		gfx_fclk_clksel_ck: clock-gfx-fclk-clksel@1 {
+			reg = <1>;
 			#clock-cells = <0>;
 			compatible = "ti,mux-clock";
 			clock-output-names = "gfx_fclk_clksel_ck";
 			clocks = <&dpll_core_m4_ck>, <&dpll_per_m2_ck>;
-			ti,bit-shift = <1>;
 		};
 
-		gfx_fck_div_ck: clock-gfx-fck-div {
+		gfx_fck_div_ck: clock-gfx-fck-div@0 {
+			reg = <0>;
 			#clock-cells = <0>;
 			compatible = "ti,divider-clock";
 			clock-output-names = "gfx_fck_div_ck";
@@ -589,30 +592,32 @@ clock@700 {
 		compatible = "ti,clksel";
 		reg = <0x700>;
 		#clock-cells = <2>;
-		#address-cells = <0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 
-		sysclkout_pre_ck: clock-sysclkout-pre {
+		sysclkout_pre_ck: clock-sysclkout-pre@0 {
+			reg = <0>;
 			#clock-cells = <0>;
 			compatible = "ti,mux-clock";
 			clock-output-names = "sysclkout_pre_ck";
 			clocks = <&clk_32768_ck>, <&l3_gclk>, <&dpll_ddr_m2_ck>, <&dpll_per_m2_ck>, <&lcd_gclk>;
 		};
 
-		clkout2_div_ck: clock-clkout2-div {
+		clkout2_div_ck: clock-clkout2-div@3 {
+			reg = <3>;
 			#clock-cells = <0>;
 			compatible = "ti,divider-clock";
 			clock-output-names = "clkout2_div_ck";
 			clocks = <&sysclkout_pre_ck>;
-			ti,bit-shift = <3>;
 			ti,max-div = <8>;
 		};
 
-		clkout2_ck: clock-clkout2 {
+		clkout2_ck: clock-clkout2@7 {
+			reg = <7>;
 			#clock-cells = <0>;
 			compatible = "ti,gate-clock";
 			clock-output-names = "clkout2_ck";
 			clocks = <&clkout2_div_ck>;
-			ti,bit-shift = <7>;
 		};
 	};
 };
-- 
2.43.0

