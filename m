Return-Path: <linux-kernel+bounces-105090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BD387D8F5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 06:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C001C21000
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 05:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD331429B;
	Sat, 16 Mar 2024 05:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="aIe6jTWg"
Received: from outgoing6.flk.host-h.net (outgoing6.flk.host-h.net [188.40.0.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41695EAE4;
	Sat, 16 Mar 2024 05:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710565283; cv=none; b=aj26Mlk3xmD6e2hfc4/HuS4xgHRNUdUmmLdcJ2B2xO0hK21vD3rJnM9Y982bdh+vtXHhN+zeq6z9nMLkWSqCOV+4XdxJsLAtr7Q8MWXUT+SayZ6+iKjj3PkmNYj8dfJLkE7Opjg0btj7BLZu/2u72GiFpVzEilnSt6EgdOSkJEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710565283; c=relaxed/simple;
	bh=mIyoE9ikz5ox6OyZaHvuReiwZYIh0JgikxUzJTYxFWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c3Zjp0g3gjb7AvHovoJb6En4PB0Mofx3zXmB78DKpjB3ChxiM3Dica+XjbNu6Bufu80xHzrFQF6i39dbYTYfcjVyahXj+OYhRkc1NmKgjzeyDhJxsXKt1wBxaVDcOHwFoQm3r7c8lKkzBnPDe95UELDhxuBvwOXUCZJDpS6mqN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=aIe6jTWg; arc=none smtp.client-ip=188.40.0.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc
	:content-type; bh=/DjG87g9IardstQkHEEXGiNL8drkyhp8jBlCWLwD+Ww=; b=aIe6jTWgHDV
	erg/B0r6NsKJm/AWRQ1rlQPn3Tw3hQ8HGpXah0jHD4pte38BwXTacg5sMNGwTngcaXb7ym0Cnis/R
	47JzZoxDZORhumssEmeNJIwX8h9vP75TkSKYiFaKqz+Euk8THDZQSCikyQiacBJ2mZ9GkDmm17tDj
	c2C0tJyy9F0IsiAbgmUcn4x2zqJdWQAvn8Iavx7c5Kc5yqWC4S+gG0DVqkX2kUSwjEoW8Y9Tp+cTc
	fHlorPrOJTLoqxjf2lhPYDwXdJMi16G6qn5ekTVJNe+NuE8ezkN/sE5z9XEagWAx199P8eP5xjzG2
	V7qWkN++AfynKuV6MfQ4KiQ==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam2-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rlMAW-00F9J9-Ey; Sat, 16 Mar 2024 07:01:17 +0200
Received: from [41.144.0.193] (helo=localhost.localdomain)
	by www31.flk1.host-h.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rlM4i-00048C-K2; Sat, 16 Mar 2024 06:55:17 +0200
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
Subject: [PATCH 11/14] mips: dts: ralink: mt7621: reorder ethernet node attributes and kids
Date: Sat, 16 Mar 2024 06:54:39 +0200
Message-Id: <20240316045442.31469-12-justin.swartz@risingedge.co.za>
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00355180699005)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT96kg1FEjS3CTjJtl8sNy9QPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wPY5yY5vX9MqMW2dd4bQescfggEolMHSR1Me+1tLQd/4/M
 684FXPwRt/ItN/QGHZWwYVP/cCt8Z7AC3QZraAAXGOt0uV2bCpZmMTDaVY6o43+4/UA7yKh3fsRx
 FRwz3BBjyk7zbazyOxi/UqYNqAkRRGBP0VCgd4sTxz5Nt/DkcKfPy9Occ20k9TJ7Nj73O0V9NPjB
 nDE1daoPH54M/DHR5hr5ConJQfcb9SHvDRICkaHkmqj+K0XGa5SFpMYJI0DpfOOu7mUz0fsyGD6a
 bRQ+0H7Q2OEpckvWJAOmdJd77Z9vwc+QHB+X+u7aTqYHtT1NFG5qXEfeIX239vWfI6H8t9z6MXWg
 ZYbrkExtRMjfc/Em1xUk+uitP3ztfVUM86oAc60fMGKzOErxxj0B+NXHNlDo60GNfZ2F/yvXF5fp
 0YCObyJslD58xugMMZCpQQvGifDpq5EYH46qR+vFm9wC7ren9RtRNyYim5e3GD8LGX4whxLggZ+w
 3rysbgAyUKjvL2J0djuO4juAaA0bvabgXwvUJUc3Xwu/zqbuNWtRwjFHUMh0hmW6W8nKNfUFN1Wy
 XsfpoA8yRVY+nIJ7kGZoLtBcNrQxKZYuPe8bdCyw79zlPbqLQkZr26Lcxdvj8cqI+CogZdOhX7v3
 ClXzrmMENhJLl6MBfhzHVBR0wHQZxzIUka7Uq615Mik1qzcz30/jNv+A51L2swh0gYW0eVWShle6
 F/kpBdN+oWjoATjEFDwcaiz0R34rhTN+GTbl4uS+pZovX9cex7Ac4fawcerGI7TrGXpM/B/M0BZd
 PfIU1BX7pZc1sE3vsz58auH/srM2fgZ9JmgLbj7sqoEiwv7LCxIiAE5ODMnmwjvj2589zjbyZCiM
 WpBpW8YvoIIqmZcWhL/r/eFjMjJnMHeiAPOVK0T+c9pM0FteOLwuqFxkZtxbXpCgbiKBsA+Ddi6m
 awd1jemntr2PrMOTF1fDnHo5A9JQxMw0XtBqT5kbx7zuprmKeJENT1oiQUtfU17WEZPRHu1+r6ov
 Q/IKaojN7gdb+Glhdb8DP7Iz3Z0Qa+VGiF/lfNRtaK1t4SnssY938wKgOC3c9GkW+OmRHU05XGuW
 g+VcQ3bZb7F7k2CvWvw8dbdRONqsj33t0is+SdoOwsm4Y7vjLT/nX97U2UmgDow/b5qgpERsDkCX
 BgcGBwKlYailDNhe7w2QIanZ/NegoJ79AXUnIiEEoyCaZXMG8LAkbJoO2tY/Mg5ClXd30oBm8U++
 JlmpaolH3tK93iPfP9+3LgPdZUXr4QqbrgAldMRDzvRIrLdBLXTfmJPwcu083nLYM3A6BXfvel8O
 EFDbU51Q2S43vcWL3lM20b9wQESc+PquLiZOpxiedGbqX4nzL9MgCv99rrli2UQdOGeuQqV2IVXB
 o/3R5VqqcOmERbjE+D5FzT0EaduWMjGSdmMR5Ch1HY0a4RW7JP9zvdSGB9tIDxuFtg36jUhUk8/b
 P2/Mw1j9lmNQqiIAMR1SEszVdPY4ocfmWv3Fe9Iziczdq+A=
X-Report-Abuse-To: spam@antispamquarantine.host-h.net

Rearrange attributes and descendents declared under the
ethernet node, recursively, to follow the DTS style guide.

Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
---
 arch/mips/boot/dts/ralink/mt7621.dtsi | 88 +++++++++++++++------------
 1 file changed, 48 insertions(+), 40 deletions(-)

diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
index 8aa9eba68..f6418201b 100644
--- a/arch/mips/boot/dts/ralink/mt7621.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
@@ -364,46 +364,22 @@ ethernet: ethernet@1e100000 {
 		compatible = "mediatek,mt7621-eth";
 		reg = <0x1e100000 0x10000>;
 
-		clocks = <&sysc MT7621_CLK_FE>, <&sysc MT7621_CLK_ETH>;
-		clock-names = "fe", "ethif";
-
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		resets = <&sysc MT7621_RST_FE>, <&sysc MT7621_RST_ETH>;
-		reset-names = "fe", "eth";
+		clock-names = "fe", "ethif";
+		clocks = <&sysc MT7621_CLK_FE>, <&sysc MT7621_CLK_ETH>;
 
 		interrupt-parent = <&gic>;
 		interrupts = <GIC_SHARED 3 IRQ_TYPE_LEVEL_HIGH>;
 
-		mediatek,ethsys = <&sysc>;
-
 		pinctrl-names = "default";
 		pinctrl-0 = <&mdio_pins>, <&rgmii1_pins>, <&rgmii2_pins>;
 
-		gmac0: mac@0 {
-			compatible = "mediatek,eth-mac";
-			reg = <0>;
-			phy-mode = "trgmii";
-
-			fixed-link {
-				speed = <1000>;
-				full-duplex;
-				pause;
-			};
-		};
-
-		gmac1: mac@1 {
-			compatible = "mediatek,eth-mac";
-			reg = <1>;
-			phy-mode = "rgmii";
+		reset-names = "fe", "eth";
+		resets = <&sysc MT7621_RST_FE>, <&sysc MT7621_RST_ETH>;
 
-			fixed-link {
-				speed = <1000>;
-				full-duplex;
-				pause;
-			};
-		};
+		mediatek,ethsys = <&sysc>;
 
 		mdio: mdio-bus {
 			#address-cells = <1>;
@@ -412,73 +388,105 @@ mdio: mdio-bus {
 			switch0: switch@1f {
 				compatible = "mediatek,mt7621";
 				reg = <0x1f>;
-				mediatek,mcm;
-				resets = <&sysc MT7621_RST_MCM>;
-				reset-names = "mcm";
-				interrupt-controller;
+
 				#interrupt-cells = <1>;
+				interrupt-controller;
 				interrupts = <GIC_SHARED 23 IRQ_TYPE_LEVEL_HIGH>;
 
+				reset-names = "mcm";
+				resets = <&sysc MT7621_RST_MCM>;
+
+				mediatek,mcm;
+
 				ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
 
 					port@0 {
-						status = "disabled";
 						reg = <0>;
 						label = "swp0";
+						status = "disabled";
 					};
 
 					port@1 {
-						status = "disabled";
 						reg = <1>;
 						label = "swp1";
+						status = "disabled";
 					};
 
 					port@2 {
-						status = "disabled";
 						reg = <2>;
 						label = "swp2";
+						status = "disabled";
 					};
 
 					port@3 {
-						status = "disabled";
 						reg = <3>;
 						label = "swp3";
+						status = "disabled";
 					};
 
 					port@4 {
-						status = "disabled";
 						reg = <4>;
 						label = "swp4";
+						status = "disabled";
 					};
 
 					port@5 {
 						reg = <5>;
+
 						ethernet = <&gmac1>;
 						phy-mode = "rgmii";
 
 						fixed-link {
-							speed = <1000>;
 							full-duplex;
 							pause;
+							speed = <1000>;
 						};
 					};
 
 					port@6 {
 						reg = <6>;
+
 						ethernet = <&gmac0>;
 						phy-mode = "trgmii";
 
 						fixed-link {
-							speed = <1000>;
 							full-duplex;
 							pause;
+							speed = <1000>;
 						};
 					};
 				};
 			};
 		};
+
+		gmac0: mac@0 {
+			compatible = "mediatek,eth-mac";
+			reg = <0>;
+
+			phy-mode = "trgmii";
+
+			fixed-link {
+				full-duplex;
+				pause;
+				speed = <1000>;
+			};
+		};
+
+		gmac1: mac@1 {
+			compatible = "mediatek,eth-mac";
+			reg = <1>;
+
+			phy-mode = "rgmii";
+
+			fixed-link {
+				full-duplex;
+				pause;
+				speed = <1000>;
+			};
+		};
+
 	};
 
 	pcie: pcie@1e140000 {
-- 



