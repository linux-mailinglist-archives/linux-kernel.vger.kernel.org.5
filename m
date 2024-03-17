Return-Path: <linux-kernel+bounces-105571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CC987E095
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 23:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA361F21117
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 22:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B06A219FD;
	Sun, 17 Mar 2024 22:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAWDrHs/"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FAB20B0E;
	Sun, 17 Mar 2024 22:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710713498; cv=none; b=pDk6WB79QnS8Ou6MSy0UGDcUFTaHddhUW+zYI7QYLoqi56Xfn3G+fG0UeL94ZYXD6ian6sXrsWeBN86JW2RBYKKvs5TmiX4Qhrul5hJMDFqMf1uTknxBcljFd07q+wLiwpN0WL/wtbBVGwIJlAGXR58pJiIvlcEQbj944UBtukw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710713498; c=relaxed/simple;
	bh=PEBrw+rZ/IUgtTaCxgC0G76w2nDNDk9oPdmXzXNfhjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ee5V67DCJg4l649dpQI+xtPC+g4lGLFp3vbfklZpMqQGEz8GE1nE9O78sK0FSMUf3LPypdZb43BNRINjm/5Hcm4E8u+ZK0dxjld6efXdhX3T4tw0zpiN5bZiGY+qNF3HtIatSH8BgkX9Ha/0en7C+LQ3PZAJf06d9duvbHhuoRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAWDrHs/; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-513cf9bacf1so4688476e87.0;
        Sun, 17 Mar 2024 15:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710713495; x=1711318295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDIU3B3LIVzuN5PE/PJX7w58eJrKbdUCsia7rvfzz/E=;
        b=LAWDrHs/TTVGU97ozkb8RKRSG8+4GaQlktJvFSYlUFc3kxROl1dCxPuqgDebISiddx
         J6kYlrhSwJ063LeziYMZ6GZoZ7W8xTXZqJNSRTaCviRMsBTdukHrwDNxhFV4F4Ylf2/Q
         47mEMg5p3kUnu4YNXvekgOd0bnz7sq91idDsZyDHHAdy5P4O0qSSCPktqnPpt5QQA3Oi
         ZbnkBvRP/f6fQC1QacuDhgTj896fTeXUYc7yvI7O1186qgEFCfHJkgwDqRpMHYdsYH+K
         I9C9W4coZy0gtQq5C35JmiE6NHRYaHzNt1limESTLdfFTtSR6XGFF2VNwEExzDi3RS7u
         1kIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710713495; x=1711318295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDIU3B3LIVzuN5PE/PJX7w58eJrKbdUCsia7rvfzz/E=;
        b=Zwy+YYHEGWgE4fg9opy1yQ6Jr/4Gzpt/fwjWOKVIksByoLKSqsn9IW4v3aNI4EFD3j
         vVhpk+q0WTnYOEDVPecfio7iwcY2kClxw1x3sedYPUwZx1OgdvaaE3PnzJ56UaG+Bnm0
         2+CB79AibNLMH3+H7qQhtQVdTWPf9/6uEQlFEFlGIoG4esDs7mSV7BqrCYYy628Kz9IP
         Pk4j7RdPKXIEPYIkt0Amldu1r4ZZBoB/+cy2Vf/ylIPP/b2yTqWXmsEwO4uXbOytoRvQ
         YFJSfBPJETiewb2q6Fy3okXmzEcw3fRZ86HxCylsmGuMoOztCC+GQThkTW7eOrkzNtVT
         s+Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVoc7II0+JLeHDhgRtjN/MuuvoQ94a63uWjip3KRFF17YQMjCRnucMS9YF+p0wpK6t76GmXMu6UDbsIugASGfychWlbdj+90db7Q0f80VZfq15es1pYQ2tQqeUwryW4wQBL7Xjv9ESVZw==
X-Gm-Message-State: AOJu0YyGD+CJoZUsFFBPOSUfzzxTi2WEXqogPeLm6cO9S8e3Yktq23CM
	PeubqT1Zujik4J6zzWTi0oLbPD+jIJsl13OGtG5Ev1fNt+0g9wZy
X-Google-Smtp-Source: AGHT+IFn0N0GzA1zPaazKzhyFHTss9QlGUK8P61HVX56vrihGWw26wgIJkeeFrchxoL5S3DAiIS8Gg==
X-Received: by 2002:a19:430b:0:b0:513:cbf2:50b3 with SMTP id q11-20020a19430b000000b00513cbf250b3mr5558840lfa.35.1710713494656;
        Sun, 17 Mar 2024 15:11:34 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id y16-20020a197510000000b00513d8e5a088sm973049lfe.140.2024.03.17.15.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 15:11:34 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Sean Wang <sean.wang@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	"David S . Miller" <davem@davemloft.net>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 1/4] arm64: dts: mediatek: mt7622: fix clock controllers
Date: Sun, 17 Mar 2024 23:10:47 +0100
Message-Id: <20240317221050.18595-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240317221050.18595-1-zajec5@gmail.com>
References: <20240317221050.18595-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

1. Drop unneeded "syscon"s (bindings were updated recently)
2. Use "clock-controller" in nodenames
3. Add missing "#clock-cells"

Fixes: d7167881e03e ("arm64: dts: mt7622: add clock controller device nodes")
Fixes: e9b65ecb7c30 ("arm64: dts: mediatek: mt7622: introduce nodes for Wireless Ethernet Dispatch")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 27 +++++++++++-------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 3ee9266fa8e9..283fdf7d2d8b 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -283,16 +283,14 @@ thermal_calibration: calib@198 {
 		};
 	};
 
-	apmixedsys: apmixedsys@10209000 {
-		compatible = "mediatek,mt7622-apmixedsys",
-			     "syscon";
+	apmixedsys: clock-controller@10209000 {
+		compatible = "mediatek,mt7622-apmixedsys";
 		reg = <0 0x10209000 0 0x1000>;
 		#clock-cells = <1>;
 	};
 
-	topckgen: topckgen@10210000 {
-		compatible = "mediatek,mt7622-topckgen",
-			     "syscon";
+	topckgen: clock-controller@10210000 {
+		compatible = "mediatek,mt7622-topckgen";
 		reg = <0 0x10210000 0 0x1000>;
 		#clock-cells = <1>;
 	};
@@ -734,9 +732,8 @@ wmac: wmac@18000000 {
 		power-domains = <&scpsys MT7622_POWER_DOMAIN_WB>;
 	};
 
-	ssusbsys: ssusbsys@1a000000 {
-		compatible = "mediatek,mt7622-ssusbsys",
-			     "syscon";
+	ssusbsys: clock-controller@1a000000 {
+		compatible = "mediatek,mt7622-ssusbsys";
 		reg = <0 0x1a000000 0 0x1000>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
@@ -793,9 +790,8 @@ u2port1: usb-phy@1a0c5000 {
 		};
 	};
 
-	pciesys: pciesys@1a100800 {
-		compatible = "mediatek,mt7622-pciesys",
-			     "syscon";
+	pciesys: clock-controller@1a100800 {
+		compatible = "mediatek,mt7622-pciesys";
 		reg = <0 0x1a100800 0 0x1000>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
@@ -921,12 +917,13 @@ sata_port: sata-phy@1a243000 {
 		};
 	};
 
-	hifsys: syscon@1af00000 {
-		compatible = "mediatek,mt7622-hifsys", "syscon";
+	hifsys: clock-controller@1af00000 {
+		compatible = "mediatek,mt7622-hifsys";
 		reg = <0 0x1af00000 0 0x70>;
+		#clock-cells = <1>;
 	};
 
-	ethsys: syscon@1b000000 {
+	ethsys: clock-controller@1b000000 {
 		compatible = "mediatek,mt7622-ethsys",
 			     "syscon";
 		reg = <0 0x1b000000 0 0x1000>;
-- 
2.35.3


