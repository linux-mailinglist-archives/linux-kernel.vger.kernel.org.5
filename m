Return-Path: <linux-kernel+bounces-51195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34098487A2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA723284BFB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A46760279;
	Sat,  3 Feb 2024 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cpo0c4Ax"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1913F60244;
	Sat,  3 Feb 2024 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706979240; cv=none; b=bZXonBc2Vbb2YaAwsCibqNM+ZJDipSnP9hueZ7A+qeCfzaxqvBrEdDs7uhMuzUVQgzL24SUMT0TWsrbcpIP6yjmhpyDTr9QvEF21lZLWY1L5DRThNgdo98Ocovr01R1BJLbaYSNOo442t1ABOzbSJgeLIqny0H3geDoj6hfGw5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706979240; c=relaxed/simple;
	bh=Kx4mkhdN3SyyLPOagSVqcTTF72r3nIf+AcswJ8B90uU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UI6RVnRe0zN8pntbqe3qTf0QHBfmOF692CM423dpjHu8Phk0ze5AzlVMWgb1o10cuoadX0Fmh4ag/WJxeQ/e6BN3qdfrdtf/SphnKWmyhipxaoB+kuEl5nLb8udHwQqqrtC65o9z4/k0j3DLNFinIf5OUdcHobSTJf90TTqytFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cpo0c4Ax; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c2c8606ef1so29142139f.2;
        Sat, 03 Feb 2024 08:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706979238; x=1707584038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taDwADqgs/vXZTWtQL/uIsBG3gMoUnf1EEy+EC/Jro4=;
        b=Cpo0c4AxfP4L+0avPWX5BM3PW8PtMIkyQptXp6gXS2SKwvgjSkbX2tbUaa5KWv7azk
         7UCdcH3BmSLNtE1Aiw6sqWyLBPVxJo45+21VgDCXivAVeOKTZndzSyz/RDqy3iQaHNsh
         Wh5hFtu6KAWQvGZ+dmbXzo0a2Dte4p9S6eDGouGZgBeTZRJn+R3QJl9C1zoaNmdiCvS3
         1eCMZdGOd/oNZ5nqfCkv9RHvgUwIPdIW85HE/vUi1xW4ymMn+GN2KAKMtmQnRSeUjaru
         5XUSnR0qSts+XM+m5fJSAY4pq9KowH89SCtQsSfalIwR9AU2VK0iVXgkS0mO7hYmjvH2
         wMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706979238; x=1707584038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=taDwADqgs/vXZTWtQL/uIsBG3gMoUnf1EEy+EC/Jro4=;
        b=UzBAvNeUbl7TJUniQqO4f6PLbcnDWpKXRa/2bdMG1kfZLvQH2sBcZxZtbv9Eulf539
         dVzxw+Phuvaafha/rjJ2DcmJw4aRDDqSgUOLGa1C3B3fSZZMolOsP8koi7uThjaiu8PR
         0F7Hxe5GziWpPo9zdcyzeU25hPrFA3IguCQzNQQi2el289K4+NahTjpjPJsHRXuALE3Y
         3XH6FrUWFGk9y+lwB6fPkEk9XcLnRW0FkbkE/0g1IskYWoqHwfdEPrt00US4N9XAYZqK
         NqASAamqGtrh6ew1KGFLQkZgL5lqCxWxoIi5ARrHDaqDIvgVJ1a7EXb3HZ/iXFRKZ5++
         x6Ng==
X-Gm-Message-State: AOJu0YwYvKDPp/A4H/0Dw2mL839/WP+oA/ASvf1MvAXTst4pFRRa/bJL
	fWDytBHu2uPJNBVexYAtGdWNbrl33e1LR3wzf6pehbz7cMP0IKFx
X-Google-Smtp-Source: AGHT+IGSIrWbB8jR5uaJBwAlIfAilmzMPT34+qSqtn8M+K3ASa98MtXlrgLootz9nRYzgIf22ww9/A==
X-Received: by 2002:a05:6602:2806:b0:7c0:3e72:998c with SMTP id d6-20020a056602280600b007c03e72998cmr6003233ioe.9.1706979238133;
        Sat, 03 Feb 2024 08:53:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUD62zg8tJ7qMwNwxmrNMP/+OYqlFBEhICF5gxfVobVJ4LnXerUR5pumG2PtuG5+Cmz7Qfs6PkvZNFzjWFg6HopgDfdIH+CrhJFHbAwLVkYFE1Gky5g76gmocMJz7rKSZSFH0wz0PGpn+QujBSeWaW1bTd4givdDsdoFza+0pxjcv6yKGy7rEu1/s7iTfuXWHEMSK1g8YxlUZ4ksVEg9YAVZdvygkgS04Ukez64aJpKQb5+2v2XodxFNH/1cAABEgBKWMPLLzszvggkQTSHX1GIolk8NFkZPPeLGYeYiUkpbeoRwsEhdm91rZxvI2XOpmQOT3rUKclMKk6QdMrzukJVrFFPyjXfvG//tBYVoSxIwE0BlykyOEbpyG+4FQFGigvg4XfwpnyZMSC9GgupXhY5d+t8AFac/q1sF2IdQXbISCSiY4ZAAaQI5dXDRVcf5BbfkjTrnoErFj1kkAX0sAKCdiLjVXD45OcGOIwrmReYBeajeQ9mV18gnX4UKlvr+uguAgY1PxVQ3g+CAAvwSlD8PdWuun7nmhBAM0+PBzXyteqCNHXeiswiDUcbqMyv9vhmmzJSJJP9iU07weq0Ne/emI/B35nszR/mec2Vw6qhN2F7u7TA22yJ61oR0pGna47Zv3k+AwHQdQ2z1JcP/od3janjHDB1aTzX9NNnYpC/WvYklUCj757VfqhEfzsVwqOTqRvRQcbYSS6bjs695FEGfS+gTqoI9XaRfw/wVyQvzSz0pCKN+ybkBc8UrWX3nt1CEdOw0keAF86Jp6Og8hwRbADGnVhU80JfhgEPIiVyzk4gWlVMOGMPHgDd00CbvE1A5M2HCUJrRackwYDqHSvO/JLky9AjE2C+/u1wQaqiRVngv6pYBgBUAzCqqqEK7X680hK1IciJbH63FpWpnoSS4FSoDH6zlB7rzbllUnyRFzEN8lftCtU9vmNGp84/0bO6zC
 tPc+kBpnmgA8VI5bKu/CBQBhxIXDGMbduBGf5zFg/mUqGiqIRi/nukYaNl5I8AcS2jy5e2zjr3Jfer0jAAOV7PBb7frc24lvmLSilFIjuj+0MkhPhuOWv5cvogwrsDLXMJ75BPLDJ3j54uiLyFRUhAmNX80hkWwe4o9O3vAKH/wFiBgsUin1KJr7WD0JtKOfNhxluLTZcCpooyc1EfcgOYrHNZNWHp8A==
Received: from aford-System-Version.lan ([2601:447:d002:5be:d9b2:bb4f:5531:6aa9])
        by smtp.gmail.com with ESMTPSA id t30-20020a05663836de00b00470b29b82b1sm1086256jau.154.2024.02.03.08.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 08:53:56 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: marex@denx.de,
	alexander.stein@ew.tq-group.com,
	frieder.schrempf@kontron.de,
	Lucas Stach <l.stach@pengutronix.de>,
	Adam Ford <aford173@gmail.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Liu Ying <victor.liu@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V8 05/12] arm64: dts: imx8mp: add HDMI power-domains
Date: Sat,  3 Feb 2024 10:52:45 -0600
Message-ID: <20240203165307.7806-6-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203165307.7806-1-aford173@gmail.com>
References: <20240203165307.7806-1-aford173@gmail.com>
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
V2:  Add missing power-domains hdcp and hrv
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 38 +++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 76c73daf546b..5c54073de615 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -836,6 +836,23 @@ pgc_mediamix: power-domain@10 {
 							 <&clk IMX8MP_CLK_MEDIA_APB_ROOT>;
 					};
 
+					pgc_hdmimix: power-domains@14 {
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
+					pgc_hdmi_phy: power-domains@15 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MP_POWER_DOMAIN_HDMI_PHY>;
+					};
+
 					pgc_mipi_phy2: power-domain@16 {
 						#power-domain-cells = <0>;
 						reg = <IMX8MP_POWER_DOMAIN_MIPI_PHY2>;
@@ -1361,6 +1378,27 @@ eqos: ethernet@30bf0000 {
 				intf_mode = <&gpr 0x4>;
 				status = "disabled";
 			};
+
+			hdmi_blk_ctrl: blk-ctrl@32fc0000 {
+				compatible = "fsl,imx8mp-hdmi-blk-ctrl", "syscon";
+				reg = <0x32fc0000 0x23c>;
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
 
 		aips5: bus@30c00000 {
-- 
2.43.0


