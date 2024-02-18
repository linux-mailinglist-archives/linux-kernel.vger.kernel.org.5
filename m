Return-Path: <linux-kernel+bounces-70188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22771859488
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 05:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478D01C21568
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 04:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACDBCA62;
	Sun, 18 Feb 2024 04:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zep1ktrE"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C22363C7;
	Sun, 18 Feb 2024 04:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708229829; cv=none; b=KGiu/Yr8eQ1k6D3uCH8QxU8/47lDDdsX2Pcs8xw67dvCL4Ev2iaIwJYu2zFAkK08J5/Rp46R4p9DlrdKlnqpCrS3d1M9cK2HxeH28IDcRdD241SxwgoRcMRCg5Fbh+wSErEBxHBbPq879yoOc6EH+o1pJ3rX1cl823brequXIDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708229829; c=relaxed/simple;
	bh=N3hwU/btY80glv17224/mtq7CT91waFcbZxaN8s7Hto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0QYrIeDk2YAXVpJPmQTiy7rbwgzfPLeuyc/JO2Iugu3KMa3bwHHVVPu6ne88Kix3SNp9joNWV8WVbGFFaknvvYT+YjcqMnC9DByXuxb/c+2Z+oyHNmEaoFhALSd+8ciy8I7wOsHXNtmXXZXEAVZqz08FdZxTa9jT7cxFDuGkpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zep1ktrE; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6869e87c8d8so14786426d6.2;
        Sat, 17 Feb 2024 20:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708229827; x=1708834627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kmAGwgibsE40CKblzU9xPszVIKszLetJVWs39LtLs4=;
        b=Zep1ktrEAL6HPzHuABJ0S+yyf/EVFaxXCAEWB7791hgF45m9FXFE6TYjr8ZQywV8WN
         S2yy+DIBDIKv/0HzG+VSZKrIYyAj+VyyMloPSryi6+ky8OXS531XddGPvI4+aT7jNSwM
         g+wdbsXxlwQE0yoqDaQx1S5WMaFa9McWG9Cho0RdDojiVVSW+mwE/r6jfoPH21KW7Ms0
         p+cjiacriLD6fGyQPqU7IEyTDWMYPyhQrT/DpqbEq7TJBxdLiMA9GdUbc68N4VrgWf+f
         BV3Nv3WPVj4xE/bwk95G2JwE0kROCY/b1XnN4CGShywMirg9NNetdxBdW3k7g2Rdo0rK
         0/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708229827; x=1708834627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kmAGwgibsE40CKblzU9xPszVIKszLetJVWs39LtLs4=;
        b=AoteVRDXdqsDNNMsudSU8Bo44FYBfobNlETzc2tPDb7YCaFn0WbaT/qkjRMFVNIku7
         RyZ8zAMR72bvWnesEy3wfQkeJFCpgFSW8Ff2x9bKSGdNQfkqbjFgjfBX9hOW0ohtefnc
         Rg3i9HO3UhB2ZkYXKrZv4cYA/5U+J/lDj9hZgigOlAWGoUoThi7iRmgTpt3JtVeexuSe
         ahwM8hN06XatefUdi2aoCh2JcwjHoJTgTAYz/ZlLc+tgTE+1uIJJpG4IHR1Fsq0acMph
         Vzp3awuJCGuJuzYdERazVBKrsC1nFC1VIIil3FOcV+zUWNT2nVYME/BnXuXqcmvqltMS
         NOSg==
X-Forwarded-Encrypted: i=1; AJvYcCU3DBX8UjKxgMP7Kh5gDCbpsyjzT8azKpgWTltzC1fjCNChFJGOVJwxmy8R8YQYpuv9U53B/Sh/y2VhFXQeWR5mxy3DULV0rKOpOG8QO8nIT8Ql2CL+hf+6a2om83iTPCGhyPQkwwMChg==
X-Gm-Message-State: AOJu0YzlupXH3q3Up16Kgqdvq64CpV6iv/hryv8Ao7SAu65shTI2Cvxy
	U0MyaDvka/lVnrb6lWbPppopGwa0e39N19/TtQtRA7TXK8kUYVoi
X-Google-Smtp-Source: AGHT+IHf6ee0rDa6Ed2eZUrQnMvT93H3rJzSArxd7p1/1rUC8eiZBBrZK63LdjUZwJ1bDg1j0GFceg==
X-Received: by 2002:ad4:5bc7:0:b0:68f:390c:270e with SMTP id t7-20020ad45bc7000000b0068f390c270emr7016310qvt.22.1708229826877;
        Sat, 17 Feb 2024 20:17:06 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:dde9:2f2d:61e4:7364])
        by smtp.gmail.com with ESMTPSA id or31-20020a056214469f00b0068eeebc4656sm1713621qvb.139.2024.02.17.20.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 20:17:06 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org
Cc: aford@beaconembedded.com,
	Lucas Stach <l.stach@pengutronix.de>,
	Adam Ford <aford173@gmail.com>,
	Marek Vasut <marex@denx.de>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
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
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V5 3/6] arm64: dts: imx8mp: add HDMI power-domains
Date: Sat, 17 Feb 2024 22:16:41 -0600
Message-ID: <20240218041649.1209173-4-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240218041649.1209173-1-aford173@gmail.com>
References: <20240218041649.1209173-1-aford173@gmail.com>
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
Tested-by: Marek Vasut <marex@denx.de>
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
V5:  No Change

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


