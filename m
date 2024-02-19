Return-Path: <linux-kernel+bounces-71038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8249859FCA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 227E1B20CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC87824A0A;
	Mon, 19 Feb 2024 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuGSa5Pk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176432376D;
	Mon, 19 Feb 2024 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335386; cv=none; b=Ixd+TFl50I7qkJrAd45hDj6ycjnFHc5IuOUb6S/30EABOsEebM7YKBSolF5LyK5PuQRwGbi97xvE3ph33fjrFWwrxZrig3xXSKZfqJgL/OoFNItZflIFcRUkIEYyZKkxrhKFTK0haFYF8R8yzSPRCKcpTMBDr0rs4Ux5tcwwbt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335386; c=relaxed/simple;
	bh=JRPmrEv9gjNSe3XKa/1/hoE+552uSlwY7LJEpBHT2NY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qN3PBfzCWOrZy+Lw+JWb7rFjAiCi3fikYK3VVdjPcnE3Sepp3+gIlcXGS3WAKtIROtsozaVTPl/BWLmeTUviFml5A4cdbpNpal1+M12mmwFUv0WqXUKWozk6iJWal/Z+gSLgDRZLCsL6VE1sckUAChCitDJf9ZpfLNEqNZAjbak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuGSa5Pk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B69B1C433C7;
	Mon, 19 Feb 2024 09:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708335385;
	bh=JRPmrEv9gjNSe3XKa/1/hoE+552uSlwY7LJEpBHT2NY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tuGSa5PkhnxfWj8GauWyd8CyEDeyka7bRVYv94Xemy74DhPEGCagusutiAM92D3Fg
	 v2PqOQuMCzYLEhYaBspD3NYz4KtMFZPXfCGx8eb3YcnYkcWfJwDixTUH9sgIpYlNEc
	 a1VFrlIXdnwRNyZGtSQsCGzAw80kW6pNIR7IfP9rKl+OrXy3ebl0J/bKmUSpB2J1ub
	 diZv3AD6qkf+CCSFRKRudvj8w1XWUIieabV3fpwa1vpLksgSqUVp6z39UJdV2YkuZs
	 LPs/4+MUHIPW9H13IbA6o2gJSwe7gyWwIlUVVrczIMp9Jm+Ou7oGzUdWw2+Hj7DzwU
	 UcFIu7erN6QmQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A831C48BC3;
	Mon, 19 Feb 2024 09:36:25 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Mon, 19 Feb 2024 12:36:13 +0300
Subject: [PATCH 1/2] arm64: dts: mt7622: add port@5 as CPU port
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240219-for-mediatek-v1-1-7078f23eab82@arinc9.com>
References: <20240219-for-mediatek-v1-0-7078f23eab82@arinc9.com>
In-Reply-To: <20240219-for-mediatek-v1-0-7078f23eab82@arinc9.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: erkin.bozoglu@xeront.com, mithat.guner@xeront.com, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708335384; l=1934;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=Dyf6RoFzaYd8gc3DOMB65qzJ0IGXiSBDbE/B8hL5EUk=;
 b=GRe/NnYvt1hIheDRqi/7Mopy1KSIqZfbYDKDWSl7bvsU2LCMGywswlvBQ98vQU6C4KmQscnEf
 wRGauX6MqEMBnFwuS4FzSGyeARFjYw+MJXrvd9qeWyYfrtdh/kcN16B
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

From: Arınç ÜNAL <arinc.unal@arinc9.com>

On Banana Pi BPI-R64 and MediaTek MT7622 RFB1 board, port 5 of the MT7531
switch is connected to the second MAC of the SoC as a CPU port. Add the
port and set up the second MAC on the bindings.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts  | 12 +++++++++++
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts       | 24 ++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
index 850b3e277368..224bb289660c 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -186,6 +186,18 @@ port@4 {
 					label = "lan3";
 				};
 
+				port@5 {
+					reg = <5>;
+					ethernet = <&gmac1>;
+					phy-mode = "rgmii";
+
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+						pause;
+					};
+				};
+
 				port@6 {
 					reg = <6>;
 					label = "cpu";
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index 5c26021fc4cf..41629769bdc8 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -118,6 +118,18 @@ fixed-link {
 		};
 	};
 
+	gmac1: mac@1 {
+		compatible = "mediatek,eth-mac";
+		reg = <1>;
+		phy-mode = "rgmii";
+
+		fixed-link {
+			speed = <1000>;
+			full-duplex;
+			pause;
+		};
+	};
+
 	mdio-bus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -156,6 +168,18 @@ port@4 {
 					label = "wan";
 				};
 
+				port@5 {
+					reg = <5>;
+					ethernet = <&gmac1>;
+					phy-mode = "rgmii";
+
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+						pause;
+					};
+				};
+
 				port@6 {
 					reg = <6>;
 					label = "cpu";

-- 
2.40.1


