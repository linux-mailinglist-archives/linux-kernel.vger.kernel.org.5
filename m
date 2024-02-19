Return-Path: <linux-kernel+bounces-71039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B06859FCB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 610BBB20AFA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5F624B24;
	Mon, 19 Feb 2024 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aq+fezDu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3990F23772;
	Mon, 19 Feb 2024 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335386; cv=none; b=J4xFFro8L6Y3BW0rqq/PxsmzoOP5qbAN3yhCkFF4we6wabBPENtLROMlrC8/piOp5ESjpzeIqQGF8dG1NnbEPZNOjXNSI1vM4T4RZ5e1XyxgXuqXHObMzwZFSnU5ncPbtQaRgxCUhvvoRPHLCVlCwoJ26HExIvLTlQwfRsGaKBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335386; c=relaxed/simple;
	bh=DPs7xzTtibskM7IfcNZHafi1s4OR/BO95p3ospi+tMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rasmmMzHVZTqfGTuaaWzNBqmvuH0wNDLShb5DslW1pB0TYuAhZt2SVNQ+J9K8kkfFtlncZOxnrE9iTgm+b/YbIgQAUvNdRUAtpGRHDuWl6grapDMOiQBHx0JxRxmuu1Rc0YWx9H8IeMGVgG3gWuf2WyNVEQGbOhEnTnb3tXxSFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aq+fezDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C11DEC43394;
	Mon, 19 Feb 2024 09:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708335385;
	bh=DPs7xzTtibskM7IfcNZHafi1s4OR/BO95p3ospi+tMg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Aq+fezDuLAyoeKI+WScEoKL9At4VrcFdBdBIHrH0JGJcYMyrdWAjcbL6SJ3bIJNs1
	 ePqg3zNAgYm4O2mYtkbBss1aIoFzfGiDcRTvg6C5dKUvmOkbXc3Va/MVjp/SVTkpbC
	 uZlvQm1PjooyzOYY1h7e9e3dhjj3quHc2QlpsKthvSDQY+WudwS61KK2UqoR4qvA8Z
	 srG2czF0IR8ymL9tMckWJuX7r9nYoZvBtiv1xMpOK1irFPnySvfZzGsEAAyFB7NXGt
	 RbHQTJRxKGwnIYfLSVqc/0YKrenJmW2Xt4d/1MRXHsRKqs0wbylvU0Jb6c3ufLuSxh
	 gZXC9ES3p5KjQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6E2C54787;
	Mon, 19 Feb 2024 09:36:25 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Mon, 19 Feb 2024 12:36:14 +0300
Subject: [PATCH 2/2] arm64: dts: mt7986: add port@5 as CPU port
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240219-for-mediatek-v1-2-7078f23eab82@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708335384; l=2158;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=58182oTWmYdN/H9gOxWBaCjBXGKyd/UkxWiwHahp3Xo=;
 b=8ixGoZdtLfMIYfLLr7jnFfKQiIaoNd41jekDYSA4+3eH7gG17EnPXLUZKqLWTyNpHq5tzSDDq
 OLuyHKPxO4SCQd7MBszzXTj/H/1sT7bqFSPjNa2ZliffoymFdSh5C6Z
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

From: Arınç ÜNAL <arinc.unal@arinc9.com>

On MediaTek MT7986b RFB and MediaTek MT7986a RFB, port 5 of the MT7531
switch is connected to the second MAC of the SoC as a CPU port. Add the
port and set up the second MAC on the bindings.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 24 ++++++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts | 24 ++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
index 2f884c24f1eb..5d8e3d3f6c20 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
@@ -65,6 +65,18 @@ fixed-link {
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
 	mdio: mdio-bus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -288,6 +300,18 @@ port@4 {
 			label = "lan4";
 		};
 
+		port@5 {
+			reg = <5>;
+			ethernet = <&gmac1>;
+			phy-mode = "rgmii";
+
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+				pause;
+			};
+		};
+
 		port@6 {
 			reg = <6>;
 			label = "cpu";
diff --git a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
index 57dcaeef31d7..58f77d932429 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
@@ -45,6 +45,18 @@ fixed-link {
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
 	mdio: mdio-bus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -83,6 +95,18 @@ port@4 {
 					label = "lan4";
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


