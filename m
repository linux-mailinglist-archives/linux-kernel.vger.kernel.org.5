Return-Path: <linux-kernel+bounces-84089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 692FC86A21C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDC681F2477D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4645915697B;
	Tue, 27 Feb 2024 22:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoY21ncT"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0573514F996;
	Tue, 27 Feb 2024 22:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071508; cv=none; b=OXW7ChN6R7mgBO2lv23RpjY20vHMUy1QwXDJ9bbpjUz244Ybpeu4KtcTKceiDCvNz6I0lOzN2dvHGuKPzn3EcNS7CJCggYpJHXbygr+Y3Ee9pFNF+vNPN79N8Bjp+Fp+NLmBF4DNgSFLTv9aiLjnETQco8MxWdZRPZLXDfKP06k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071508; c=relaxed/simple;
	bh=HgWFGA0H5+lhtt9QkEwzUEZwEz7aw5R8sfP0/hVrD4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CAmnEUgAYT8qTm7vhPf9BRLKg/WuwbTOgMY3CaITD0arS+7FaJC5HaoDMuV2Yfx7DrTEywkRqxiwoe9hgQf3MKfY/nJet34KWEk9PBGREoReIzSWq/zCaEr4sNCJLKFD1rP3Ql1Kb3s9K0fki5yXrZONTMqe5ZXzDuJyahdgKI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoY21ncT; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-68f74fb38a8so19341176d6.3;
        Tue, 27 Feb 2024 14:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709071506; x=1709676306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmbbJGMEJkVi0DIu9K/lMBZ7/vUErHSNsjKRRkfuNd4=;
        b=RoY21ncTyWb5Zhes+PC7nd8JsoHr9/mLTuXgOO26vEyO1ABcn75NCDG1+md0FH2Nx5
         p2MOqfFmZAdCvMkxfs1d9lZetWlrZE1TaWxZd9eiK3aTiyUZDcbxP4xu5Z/n9z7gXtSw
         Ob+Akl9miM1iCu9D4HaVyDhSSGw2B7/D0IdsMRXGYe87zb0jo2orb6odkEQwdy7hhe4k
         3LyyUY1X6PCvuqyPM013kEXyY4FUJf92x0FjKvjP/QuyJD7TokzSrX4IHazwERIYZG8U
         8JX/3irXRg45XJ4yoWYUfXf3PLDn4xsyvg3YjygjS4a5pihTRgpQ0gCam5jju5QyVgR9
         pJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071506; x=1709676306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmbbJGMEJkVi0DIu9K/lMBZ7/vUErHSNsjKRRkfuNd4=;
        b=LRxJyOK5ROwFzNuV9xl2cokyUZBKv1pWMv35hwTAyKIgX9PyuEvY4GcNKdIG/JhXM3
         1u4hcuXnW2U948IPnjdJEkHdn7jDqJWa/VcAC6G67khS3VU88Hznr5g6Bj87S7ZLUUIe
         7WrgLDRFOH/3RhXWLr8qAq02MFCVmIURAVZdQuczHZ70LG5QROPYrRQ4jhwiHVe3cy+2
         y7Z7yUc/iSDpYDnW6D7OoS1RQTRXRrMDr/YuK7oEpLdtLT/Wn6p3ukbUJAVpWVx3e7d/
         hAGrVzlMlOUxzkLs7KywXgbj55RqgzfRQfc+kKmvdP+TzukLITReQ/SUvbMY6xEHxRM8
         VbgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj6o6bOxKhJWoI3/Qgk6iOGdOC3per8DSgZPEI2VM6Cy3K8l1zo+PgX0DqlhO9PUOctOGERfHJ2bQx7WFIxSqVOJtLPxBAtmv2yKldmnEfzh08ygfx8ZFrSHn7hCbpt0XfJ2nP1Hsisg==
X-Gm-Message-State: AOJu0Yx+86cscF99vUUzBqR7E/5fE9TOyPHbAalX3V+9MdB1ecTQuMZM
	IPeOQXaYtTV/dLHrK++XgtgPtwR3k+E84RXIpTUBZ2RF7ywPKnRk
X-Google-Smtp-Source: AGHT+IE6i0LWrYJlOlKNYdpd9Wfhikyo/roVvLACICkT0f6i3xk6KKObf+gk9jGM3IINovDqDgP+mg==
X-Received: by 2002:a0c:cd07:0:b0:68f:d594:52d2 with SMTP id b7-20020a0ccd07000000b0068fd59452d2mr3267671qvm.0.1709071505915;
        Tue, 27 Feb 2024 14:05:05 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:9ee3:b2ab:6ca:180d])
        by smtp.gmail.com with ESMTPSA id c12-20020a0ce14c000000b0068fc55bcf6asm4569556qvl.119.2024.02.27.14.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:05:05 -0800 (PST)
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
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 3/6] arm64: dts: imx8mp: add HDMI power-domains
Date: Tue, 27 Feb 2024 16:04:37 -0600
Message-ID: <20240227220444.77566-4-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227220444.77566-1-aford173@gmail.com>
References: <20240227220444.77566-1-aford173@gmail.com>
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
V6:  No Change

V5:  No Change

V4:  No Change

V3:  The hdmi_blk_ctrl was in the wrong place, so move it to AIPS4.
     power-domains@ fixed to read power-domain@

V2:  Add missing power-domains hdcp and hrv
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 38 +++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index bfc5c81a5bd4..c9bcb6641de7 100644
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


