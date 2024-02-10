Return-Path: <linux-kernel+bounces-60538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E8985064F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896E81F24BB1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 20:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6F35FEF2;
	Sat, 10 Feb 2024 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GT7LnDIU"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59005FDCF;
	Sat, 10 Feb 2024 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707597986; cv=none; b=XFyPQxEetaBfintwWjhS4SErAocEW4uSTM4PJOHRZYjlZD1Cnky3kzaFD5iXCGIE/SaZ71HnNPRe13CaLDi0P0OEBx5k9lfda8kw5k+30TbopX3YfVTuqpGfN37ARVG79ixHGFNn+KLudc36ofIJgX74aiFkZaNWpPrVR1NXgwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707597986; c=relaxed/simple;
	bh=1ZsWki7TuxRhvwZhQG/4r3m/Aa1ko8ikRKr99Le3u4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfRa7YtrSh3j6zh+I0tJ1iVShzlUF1a2IaU7sgoezgSin/xEgJwMLC7ulhay5/L4kQ1VCGumBdjqnpTXC0h2njO95gAbhJGhRIL63fPZyvDv7XarbnN8zOVqn+z8QF909sfgNF8e3lUET3TwyCWCoGn/wemM40JbdBVD5/+RWHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GT7LnDIU; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-21922481a2fso1440166fac.0;
        Sat, 10 Feb 2024 12:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707597983; x=1708202783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1sqss5k7/14SKgqnTfmbe/yknHcrWFOpPFDxDP9yBY=;
        b=GT7LnDIU8o2g+HU3zL6l7N41jjocOgnz3Y2YEUNu0TZ14loHQMHXjzw4zSpT9WqlG9
         1oO5ecrIu41wvvvSPLkNpQrkx6HMxW5P+40yWYOfnIAWQCGHIyZNbKYAFAOeOEKKdwPp
         dFYNCXc0Hpr1l+FcFZFrUhsFp94w0Q5fWCuik2dX0LcTL7LAmGoJRPO73KheIq9pbx+k
         2IbujjeTcdey7aI/RGvecEBAkSCh1cYvONS1fBwYlmGR2dbUnqNF09Shalg4j7wtSB1Y
         IlzZ5P5ap7a6wzXtRds8cjjD/jcHOJ/GVQcFmSpY7G0mU7zMBtdsnsu4UN8M07c3Qwq9
         qclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707597983; x=1708202783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1sqss5k7/14SKgqnTfmbe/yknHcrWFOpPFDxDP9yBY=;
        b=PujBuVPKXhPBdEF4a3nPQG9tK0w63k7P8s1F2G8KYU8QPxukWPl2PV5l6XSLZoR0Ei
         tOWUoNYm+G0FUG5Rbs7OWp7AmA1Sv+yHQM1eNE56uddHU4KwFtJ3ZBaLkDwAoYlU6dnv
         FQCgOO6EV/AFYAXgmGtwi0iyZxIK10oPTu4UIG4ttSfujgRPtEB7saia7JKPlxiBOdiE
         K6ASq+s1nJy8j3cdqtEtC2wt76NhvTuq/vx5hpdRfj9zCyz6ekFTPZid3pyAynICKz6M
         uXM3vmsaCXH3BuvwHBh6FP0gYSkG7m64LGWprl8IWC7SuNDRhcjenPQxBEGjyjyLC2+f
         afNA==
X-Gm-Message-State: AOJu0YxbWGCIm3pdNRN5xekJGAZlkGDH6pxQpFoZ/HJBLvEoKa15qQs8
	ZILkjPYf2JwBXkZdZFga55OpcXcH3/DZW+2G3akGyi+CzrXPQbxb
X-Google-Smtp-Source: AGHT+IGtzGY1r/Ey6eDWiFV4anbDVmrioD8tnnWliCkcJhnnp7ieNqchj1cxlnfA4BmipPtwyVROUA==
X-Received: by 2002:a05:6870:a68b:b0:219:8bb1:dbe0 with SMTP id i11-20020a056870a68b00b002198bb1dbe0mr2701988oam.23.1707597983515;
        Sat, 10 Feb 2024 12:46:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUyMJ/CooF1QNuyXGTObFWMvuvkFEmuT//Kug+lC0gcKpihQmxaVZht2CMxcEHCpsOiF5guQFaasdcNG674yFTAYhweQoskYZFRS3Tl62Jk8sdffneBLibhAbqkI6MXFFP2RH/40rPDQ19iBRpZ6//pUGLk44/4InI0FWKmbUDfZMJprVgnw0hci6O35jDUOG1KE8HcUpq9hdRCaJqt4YqMc7Fqsfrt7JEPRNrz0dfpNyLIjIHis5+46b1gH3wqWw2+HP0IkMBTDSUDDg3ZCOYgciZXmRTB8emI50Mnm0QUSM5nOtT0H2l6GBVCmJSu+3dupL9iGOW+8pSqfrPxIOrOFvs586OH0Y7RnaqtbVT+U2ki2qcGmbs+q/v3em7lpGTas5cRM0vrkWHTVu8cQ6JAc1qVGJW7VbJuOyWVVIaOi/Mcm/4N6VUrczhEdH9fkl8+abypCDebn2Ov9b3rT41mYV1XVARDefkAJGORsJaWZFv5c2a2myi2eTLXNve8c7nQgZ20+m2ivRnQAgEk6u1Xg73lBghraDXUp3pOxMfJoicuzKOOI35VDnVrm31QO6SBezpUEmE2mvDDtwLLUz4rEFPw9v+F5J6pBjIlTLyPCA==
Received: from aford-System-Version.lan ([2601:447:d002:5be:27d7:3989:2897:88a7])
        by smtp.gmail.com with ESMTPSA id m20-20020a0cdb94000000b0068c9db26ae1sm2079526qvk.41.2024.02.10.12.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 12:46:22 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: marex@denx.de,
	aford@beaconembedded.com,
	Lucas Stach <l.stach@pengutronix.de>,
	Adam Ford <aford173@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 3/6] arm64: dts: imx8mp: add HDMI power-domains
Date: Sat, 10 Feb 2024 14:45:59 -0600
Message-ID: <20240210204606.11944-4-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240210204606.11944-1-aford173@gmail.com>
References: <20240210204606.11944-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lucas Stach <l.stach@pengutronix.de>

This adds the PGC and HDMI blk-ctrl nodes providing power control for
HDMI subsystem peripherals.

Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
V4:  No Change

V3:  The hdmi_blk_ctrl was in the wrong place, so move it to AIPS4.
     power-domains@ fixed to read power-domain@

V2:  Add missing power-domains hdcp and hrv
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 38 +++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 9ab9c057f41e..0730d4cf9bc4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -836,6 +836,23 @@ pgc_mediamix: power-domain@10 {
 							 <&clk IMX8MP_CLK_MEDIA_APB_ROOT>;
 					};
 
+					pgc_hdmimix: power-domain@14 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MP_POWER_DOMAIN_HDMIMIX>;
+						clocks = <&clk IMX8MP_CLK_HDMI_ROOT>,
+							 <&clk IMX8MP_CLK_HDMI_APB>;
+						assigned-clocks = <&clk IMX8MP_CLK_HDMI_AXI>,
+								  <&clk IMX8MP_CLK_HDMI_APB>;
+						assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_500M>,
+									 <&clk IMX8MP_SYS_PLL1_133M>;
+						assigned-clock-rates = <500000000>, <133000000>;
+					};
+
+					pgc_hdmi_phy: power-domain@15 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MP_POWER_DOMAIN_HDMI_PHY>;
+					};
+
 					pgc_mipi_phy2: power-domain@16 {
 						#power-domain-cells = <0>;
 						reg = <IMX8MP_POWER_DOMAIN_MIPI_PHY2>;
@@ -1889,6 +1906,27 @@ hsio_blk_ctrl: blk-ctrl@32f10000 {
 				#power-domain-cells = <1>;
 				#clock-cells = <0>;
 			};
+
+			hdmi_blk_ctrl: blk-ctrl@32fc0000 {
+				compatible = "fsl,imx8mp-hdmi-blk-ctrl", "syscon";
+				reg = <0x32fc0000 0x1000>;
+				clocks = <&clk IMX8MP_CLK_HDMI_APB>,
+					 <&clk IMX8MP_CLK_HDMI_ROOT>,
+					 <&clk IMX8MP_CLK_HDMI_REF_266M>,
+					 <&clk IMX8MP_CLK_HDMI_24M>,
+					 <&clk IMX8MP_CLK_HDMI_FDCC_TST>;
+				clock-names = "apb", "axi", "ref_266m", "ref_24m", "fdcc";
+				power-domains = <&pgc_hdmimix>, <&pgc_hdmimix>,
+						<&pgc_hdmimix>, <&pgc_hdmimix>,
+						<&pgc_hdmimix>, <&pgc_hdmimix>,
+						<&pgc_hdmimix>, <&pgc_hdmi_phy>,
+						<&pgc_hdmimix>, <&pgc_hdmimix>;
+				power-domain-names = "bus", "irqsteer", "lcdif",
+						     "pai", "pvi", "trng",
+						     "hdmi-tx", "hdmi-tx-phy",
+						     "hdcp", "hrv";
+				#power-domain-cells = <1>;
+			};
 		};
 
 		pcie: pcie@33800000 {
-- 
2.43.0


