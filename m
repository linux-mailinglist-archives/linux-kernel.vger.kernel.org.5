Return-Path: <linux-kernel+bounces-105088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9951787D8EF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 06:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1134DB214FA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 05:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33353DDAD;
	Sat, 16 Mar 2024 05:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="CnmyI4Xk"
Received: from outgoing4.flk.host-h.net (outgoing4.flk.host-h.net [188.40.0.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF875C89;
	Sat, 16 Mar 2024 05:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710565279; cv=none; b=SMA+hjGOpibd0tm6Yx+6XRb8bICjKmziw0SKJfDicH1o7UL3cv9bBx80ZAy+83RKaezdxYB5FZX5HmbeWMYgpObvWBBmqjshhT4glfBF95mhtQbAVSd816dKsnotKeggKhAOyq7HGVvWUXm885T1atBeTpU2YXjTBV5fkzy2LLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710565279; c=relaxed/simple;
	bh=nnkElslWgHa6V5Tt4oBUS12hPxibs3pTYN8GKJ11cok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SGIqWwZa9VYeRBRWGFjYCcKpKU1CXi21CCtiRgUdskSHIzt0170Yot2qivyeWRqdZs/6R7Qr+2rDfJfuTdgn8sOBwql8WZXyLZ90OaXd7ZFmp7SRhT8Ynm3eVjvuO14L/998LFGuGhFd31IvWuOjwwIx1Aiyc6AqMFawK+dXpkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=CnmyI4Xk; arc=none smtp.client-ip=188.40.0.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc
	:content-type; bh=ZLLKXiDuf/ZV7h8cTO2GqsnzYRx41EMWrLmnpm0TLqo=; b=CnmyI4Xks4x
	mVnG2ZzgYAdh/m+pnL2OiE0X6XJY6jRL2qGjKUYThqYBq7Hg9z3QMkQSCQlyLgPYTdBlEeUqAbUdD
	KOFDO4qwyWsG7U7FIX78MusTUuB3FIdypI4ySNtOAPayoDdA2fptUHsWIUET3duNz6kp1zDGEK04y
	mQeGuct0WI0y6DVWhSfIQotYryWUWRVinYrCIErMoviUViVz3KAY86bOaU0XgE1yxrZM1GYTm11dn
	CqPVtrN0HbNRRpwRBwvVyCdiP+Rgf6RdP6Bhjn6s969QzeKorAJKgbtArYoxiAh4wXkzaJP8xrLZf
	pRD/6ZeCBYCbZ2eILV4n51w==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam1-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rlMAS-00C0SF-Lr; Sat, 16 Mar 2024 07:01:13 +0200
Received: from [41.144.0.193] (helo=localhost.localdomain)
	by www31.flk1.host-h.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rlM4m-00048C-TN; Sat, 16 Mar 2024 06:55:21 +0200
From: Justin Swartz <justin.swartz@risingedge.co.za>
To: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mips@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Justin Swartz <justin.swartz@risingedge.co.za>
Subject: [PATCH 12/14] mips: dts: ralink: mt7621: reorder pcie node attributes and children
Date: Sat, 16 Mar 2024 06:54:40 +0200
Message-Id: <20240316045442.31469-13-justin.swartz@risingedge.co.za>
In-Reply-To: <20240316045442.31469-1-justin.swartz@risingedge.co.za>
References: <20240316045442.31469-1-justin.swartz@risingedge.co.za>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.01)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT9pM7yBTW3/qtGz5nSS82YvPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wPY5yY5vX9MqMW2dd4bQescfggEolMHSR1Me+1tLQd/4/M
 684FXPwRt/ItN/QGHZWwYVP/cCt8Z7AC3QZraAAXGOt0uV2bCpZmMTDaVY6o43+4/UA7yKh3fsRx
 FRwz3BBjyk7zbazyOxi/UqYNqAkRRGBP0VCgd4sTxz5Nt/DkcKfPy9Occ20k9TJ7Nj73O0V9NPjB
 nDE1daoPH54M/DHR5hr5ConJQfcb9SHvDRICkaHkmqj+K0XGa5SFpMYJI0DpfOOu7mUz0fsyGD6a
 bRQ+0H7Q2OEpckvWJAOmdJd77Z9vwc+QHB+X+u7aTqYHtT1NFG5qXEfeIX239vWfI6H8t9z6MXWg
 ZYbrkExtRMjfc/Em1xUk+uitP3ztfVUM86oAc60fMGKzOErxxj0B+NXHNlDo60GNfZ2F/yvXF5fp
 0YCObyJslD58xugMMZCpQQvGifDpq5EYH46qR+vFm9wC7ren9RtRNyYim5e3GD8LGX4whxLggZ+w
 3rysbgAyUKjvL2J0djuO4juAaA0bvabgXwvUJUc3Xwu/zqbuNWtRwnE3XvkU7twVMm/5tv4KTanw
 bOl0qtP5EgfDRdSDhnwOLtBcNrQxKZYuPe8bdCyw79zlPbqLQkZr26Lcxdvj8cqI+CogZdOhX7v3
 ClXzrmMENhJLl6MBfhzHVBR0wHQZxzIUka7Uq615Mik1qzcz308HFwsY4DWIzjhTYXUG8GBZhle6
 F/kpBdN+oWjoATjEFDwcaiz0R34rhTN+GTbl4uS+pZovX9cex7Ac4fawcerGI7TrGXpM/B/M0BZd
 PfIU1BX7pZc1sE3vsz58auH/srM2fgZ9JmgLbj7sqoEiwv7LCxIiAE5ODMnmwjvj2589zjbyZCiM
 WpBpW8YvoIIqmZcWhL/r/eFjMjJnMHeiAPOVAT1rE1/vP68Bb4z3v3h3gCdXrv2+9GnNX30LKqXb
 fwFKgm/rnYBl+Mj5KqOl6Jzub/f3QhLRbOgisvi5VU9eNBtgo6zjiatjNO/pnMCjuIvXs/AyV/Ns
 URB/R+FlEHyAzksgfaRvdgw0WK34QWnzHHMcN6qoXPjenLhIOF1oeRYbjF1Hp647mOWoQlc3hL3c
 ZMexQ8VxpTDmnfa+pzT1vQb2gnFjWtPhY8e0laryBOR4u/m4iBmYb1/LCV4/EuVHup06w3Vwxf9C
 F7D6LKKRTfdjzQ6YC7Heg3Xf7O1TOd6RcY/MXB8eEq3bCN2QohZvyS03iBmgsz450Kmjd3fGV1bD
 j7kHqUESfAz/L5nIuDmgMQk9EfnvGevAMTGcFT3bIbtf63VNbf0lrvssY+k7AHGi1NevGWTo2+h8
 Lhk4HCeZR7ymlGVRtthBJ2y8A5arx6JItKpFaUNPGMMlvbMX0nyK1NiAJ0y2Qvvn6ds6mor35w4f
 SfHzQbABJfgy21HclcZkPRq7NhoxyMwqi8Q23Rgadfh5T5n5D4OHHpbEIgsllZKWnzc5M5WlNtVJ
 qo05MS+4ayUpOtEhdxekWDmK9g==
X-Report-Abuse-To: spam@antispamquarantine.host-h.net

Reorder the attributes and child nodes of the PCIe Controller
node to meet the DTS style guidelines.

Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
---
 arch/mips/boot/dts/ralink/mt7621.dtsi | 68 +++++++++++++++++----------
 1 file changed, 43 insertions(+), 25 deletions(-)

diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
index f6418201b..aa06d12ac 100644
--- a/arch/mips/boot/dts/ralink/mt7621.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
@@ -495,70 +495,88 @@ pcie: pcie@1e140000 {
 		      <0x1e142000 0x100>, /* pcie port 0 RC control registers */
 		      <0x1e143000 0x100>, /* pcie port 1 RC control registers */
 		      <0x1e144000 0x100>; /* pcie port 2 RC control registers */
+		ranges = <0x02000000 0 0x60000000 0x60000000 0 0x10000000>, /* pci memory */
+			 <0x01000000 0 0x00000000 0x1e160000 0 0x00010000>; /* io space */
+
 		#address-cells = <3>;
+		#interrupt-cells = <1>;
 		#size-cells = <2>;
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&pcie_pins>;
-
 		device_type = "pci";
 
-		ranges = <0x02000000 0 0x60000000 0x60000000 0 0x10000000>, /* pci memory */
-			 <0x01000000 0 0x00000000 0x1e160000 0 0x00010000>; /* io space */
-
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0xF800 0 0 0>;
-		interrupt-map = <0x0000 0 0 0 &gic GIC_SHARED 4 IRQ_TYPE_LEVEL_HIGH>,
+		interrupt-map-mask = <0xf800 0 0 0>;
+		interrupt-map = <0x0000 0 0 0 &gic GIC_SHARED  4 IRQ_TYPE_LEVEL_HIGH>,
 				<0x0800 0 0 0 &gic GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH>,
 				<0x1000 0 0 0 &gic GIC_SHARED 25 IRQ_TYPE_LEVEL_HIGH>;
 
-		status = "disabled";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie_pins>;
 
 		reset-gpios = <&gpio 19 GPIO_ACTIVE_LOW>;
 
+		status = "disabled";
+
 		pcie@0,0 {
 			reg = <0x0000 0 0 0 0>;
+			ranges;
+
 			#address-cells = <3>;
+			#interrupt-cells = <1>;
 			#size-cells = <2>;
+
+			clocks = <&sysc MT7621_CLK_PCIE0>;
+
 			device_type = "pci";
-			#interrupt-cells = <1>;
+
 			interrupt-map-mask = <0 0 0 0>;
 			interrupt-map = <0 0 0 0 &gic GIC_SHARED 4 IRQ_TYPE_LEVEL_HIGH>;
-			resets = <&sysc MT7621_RST_PCIE0>;
-			clocks = <&sysc MT7621_CLK_PCIE0>;
-			phys = <&pcie0_phy 1>;
+
 			phy-names = "pcie-phy0";
-			ranges;
+			phys = <&pcie0_phy 1>;
+
+			resets = <&sysc MT7621_RST_PCIE0>;
 		};
 
 		pcie@1,0 {
 			reg = <0x0800 0 0 0 0>;
+			ranges;
+
 			#address-cells = <3>;
+			#interrupt-cells = <1>;
 			#size-cells = <2>;
+
+			clocks = <&sysc MT7621_CLK_PCIE1>;
+
 			device_type = "pci";
-			#interrupt-cells = <1>;
+
 			interrupt-map-mask = <0 0 0 0>;
 			interrupt-map = <0 0 0 0 &gic GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH>;
-			resets = <&sysc MT7621_RST_PCIE1>;
-			clocks = <&sysc MT7621_CLK_PCIE1>;
-			phys = <&pcie0_phy 1>;
+
 			phy-names = "pcie-phy1";
-			ranges;
+			phys = <&pcie0_phy 1>;
+
+			resets = <&sysc MT7621_RST_PCIE1>;
 		};
 
 		pcie@2,0 {
 			reg = <0x1000 0 0 0 0>;
+			ranges;
+
 			#address-cells = <3>;
+			#interrupt-cells = <1>;
 			#size-cells = <2>;
+
+			clocks = <&sysc MT7621_CLK_PCIE2>;
+
 			device_type = "pci";
-			#interrupt-cells = <1>;
+
 			interrupt-map-mask = <0 0 0 0>;
 			interrupt-map = <0 0 0 0 &gic GIC_SHARED 25 IRQ_TYPE_LEVEL_HIGH>;
-			resets = <&sysc MT7621_RST_PCIE2>;
-			clocks = <&sysc MT7621_CLK_PCIE2>;
-			phys = <&pcie2_phy 0>;
+
 			phy-names = "pcie-phy2";
-			ranges;
+			phys = <&pcie2_phy 0>;
+
+			resets = <&sysc MT7621_RST_PCIE2>;
 		};
 	};
 
-- 



