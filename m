Return-Path: <linux-kernel+bounces-82449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A46F18684B7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3361F1F23114
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF4D13698A;
	Mon, 26 Feb 2024 23:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LALAkJs9"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A785C135A5C;
	Mon, 26 Feb 2024 23:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708991148; cv=none; b=QZOlBYYbPr9d0I/435Bygo54+yanyNAk55HP/zJ2iY4uC+KEK9SGDqh7z6mtylubtUzze0zbLGem9Zt0IVWaU4n5sGXVqSz7DmlSbTaoNOAk7xjd8ET+eBBerjtkvjzaFbUAy19rDbGDaIRHhLiTyLQwiY66+yMu3/2w+dikypA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708991148; c=relaxed/simple;
	bh=HgWFGA0H5+lhtt9QkEwzUEZwEz7aw5R8sfP0/hVrD4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxoXOGjsJ5E1vF3DKkWi//5bTLU6F9N/SJHrxly2H8lNBq8y6G71RVGuUdmNkiWqrvNXCC16OASEL0BM5m9ka0x9FxV4pCzBb7FCe4Uy7cDvpXQuZ1yPd1LEB03nDStE4a+T5myQ4B0Chl5vSJYYoAvLnoXDAVh6sHPTBQrLItM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LALAkJs9; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c48e13e0d7so214255439f.1;
        Mon, 26 Feb 2024 15:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708991143; x=1709595943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmbbJGMEJkVi0DIu9K/lMBZ7/vUErHSNsjKRRkfuNd4=;
        b=LALAkJs9V9PNyjNaWbL5dOGFRwa66EadcrwQP9AlACCwl0LeX42HjkJbnX56pgKQ41
         XG96hoIkZBOsreMUXonvl6SuV62OBX6KoQak8eZkocfaxyQNjKBw7dLs4bwoPVpcbaM+
         6OCTpreLjZ5ev6RM9P6A1Nz3KcQZUiSdxkzZEaTWuDsrctWUrs1GEULJFkgNa105JI5d
         vSU99ue+i8X3AccopyrC68a7w9LxxKosSjqL7Bep0ngCQOwny5PNlfeoeClVAfbBn8AD
         mVc2bietq0fkmJHaBnx7TNjaX/GhsgFIynmX5o8wgTqbDJ7dqrE2ve0TyPw409rc/aFe
         QA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708991143; x=1709595943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmbbJGMEJkVi0DIu9K/lMBZ7/vUErHSNsjKRRkfuNd4=;
        b=bIPgXtpTwXvVOF5e6kyVQnTrKf7B/KooT0P+zkDvmr8nJmZxIVeagSGCRPxhX4SHEw
         9p23iC1359GYetsfkuhYi4+1PNacuwTfisRIN398ez+u/NV5s7VcpRjdoHBzHVxNhzP1
         7Wm4GFz0KgTgLgNf/xQ9jcX0pC2D6kqvLNVhgSuRq0V+3XZnlS/Lpq+QgfAdmy2C39yY
         xhTLatJoSTIFGw86ZEq3HSRRnmBPvuIf57vyK8D1FugrBmgr8qgvwsRzPkOTtapxET7c
         55qHJATEjuT05hMSELc9QiroMey2Flbq3AClHd6S/a1eIoKWh5xsHsQWyb+ppYFGBWjK
         gruw==
X-Forwarded-Encrypted: i=1; AJvYcCWKUFaNWR2B7R7y56aV5Q57O5xrsxwgree/O+b9Uv1YcZEOJRHm+Q6NM6DwIJWMKenXtylpnRer6hSXjFIbreynHX9nu6BgnO6qrs+nPm+w8q+NBDDwPrKTH5CIOv0QXFlIoWoYFoVO0A==
X-Gm-Message-State: AOJu0Yzai+wqSqEOGr30/Uoy1f223ixEjhHxi1GzJ/IDj4+K4q43wL8K
	sA0XDE4AfxAKSTJMe67JuyFwZwaQT9mtA9htgkxYtOdbNEczFheX
X-Google-Smtp-Source: AGHT+IF/D27yCsFHmcnDOIj2v/3qnuFfvdwald7NsSXdAw9JoGcg8pGnM7Hg/+MU8soiTVaTtq1Tig==
X-Received: by 2002:a5e:8f4d:0:b0:7c7:cd56:f17 with SMTP id x13-20020a5e8f4d000000b007c7cd560f17mr4399717iop.19.1708991143316;
        Mon, 26 Feb 2024 15:45:43 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:9c95:d061:819a:2ab2])
        by smtp.gmail.com with ESMTPSA id c25-20020a023319000000b004741cf1e95esm1545317jae.11.2024.02.26.15.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 15:45:42 -0800 (PST)
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
Subject: [PATCH V6 3/6] arm64: dts: imx8mp: add HDMI power-domains
Date: Mon, 26 Feb 2024 17:45:14 -0600
Message-ID: <20240226234532.80114-4-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226234532.80114-1-aford173@gmail.com>
References: <20240226234532.80114-1-aford173@gmail.com>
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


