Return-Path: <linux-kernel+bounces-105085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C575587D8E5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 05:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AEE7282888
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 04:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D721B7F7;
	Sat, 16 Mar 2024 04:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="WEbTPXY/"
Received: from outgoing4.flk.host-h.net (outgoing4.flk.host-h.net [188.40.0.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53911B95A;
	Sat, 16 Mar 2024 04:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710564909; cv=none; b=lu/mN+y2b06ZHl2Q/MO43WuCJxrQ/hA9SwHGjcIfyfyGkp36KsTqoJ7jNFAEBI05Z864EEMOtnamvv9LtFB8FIC2OS6m3pWXKMXjzH2sqGubR+ncYEebUn+FKM2BO/eFpaXEiqgXAHc1n8W9eMEGNVurBCPbuxfLvc6jWIDp0xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710564909; c=relaxed/simple;
	bh=0HN6W8x4zzPie7rF+ZHzWVMYRin8UWRwORe+U56Atmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GGdLDTDe9QEBUie94q/tIoztlJ8HKizo6PTGKYfoV0aTO59lidFqVvRi6YY3jM9it7Mc3c9q0V7ffGgbmmHdC5kSK61IdTzMpCEfXi0uBKQsR4Oxm3Ir4kNyjYLJyt787MLuyuuY6vCg1yyWbKkzAMgeJNkAiDkR33G0Nxwba2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=WEbTPXY/; arc=none smtp.client-ip=188.40.0.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc
	:content-type; bh=iwP5FsNiB2p0jX/GRZkiP7ML0+pW4H2OnLR8avLKbz0=; b=WEbTPXY/TkB
	R/HXOYcvrNMFKVBWAZM6P+aD4yE5Re03mzR8UCPVenfzM4QNy2oLED31M7Ead60VFLhvXJnXzNyth
	sxVdw91n4kMJLkPHb3+3sFljRXwclHy7V1WZOgVPjWmZ139I8QJtK3id243zYK4AL0EmEngEtAjhn
	N40hw+nOHAm237hvYdq+gDFYuML6Fs87aHDleV6WPB05THb4tYDpr+tQ2MyWjrljxQx7Ik9/gBLAv
	/7A5FRFE1A0XqNXBFiEnDRt8mcdTkFo4PhkkxgAFzYzeUlVG2C9O5TwpzZyFI8S9hl0I3t4s8PlV3
	IhTw4OkVOrfU/uGFKA6G4jA==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam1-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rlM4W-00By6D-UP; Sat, 16 Mar 2024 06:55:05 +0200
Received: from [41.144.0.193] (helo=localhost.localdomain)
	by www31.flk1.host-h.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rlM4V-00048C-QU; Sat, 16 Mar 2024 06:55:04 +0200
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
Subject: [PATCH 08/14] mips: dts: ralink: mt7621: move pinctrl and sort its children
Date: Sat, 16 Mar 2024 06:54:36 +0200
Message-Id: <20240316045442.31469-9-justin.swartz@risingedge.co.za>
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00211086697891)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+YQ8rLMZisstE8HsjlbYDpPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wCPRB8bAzJcv2cv+UqiTTc2+CpNcmBnO4XM3Sck4bwNogU
 WCl1nkLBzZX0KuJ9bXiS85Z42w/+2OBolTNFbPomXFWCX8oNdggW7HE9XDTdSejrkEpbuUvwMvHx
 3T+KSG//gbuP7hnUK8NQdLwsVWKIFDZRrTGv3rxiw9tFrqFSCFNiLZt/QXQnOBRD+jq1HsKsDh/6
 Srgk2K3gr1VBfJbChkYH6fbrypLNrde+UooQVNLReLErukdelEOHUIpaBbp5GdnsN8+UvimwMinK
 0+Txhz2u9qvrL2PODYgMZQApJXOjDLkqunZ9NcY2bHZn7CfFscMZZf3sCkN20I5vMh4akiObI7Kj
 vK7X04QEin24qbfMFd8eGjnYW8aSH5qj4ujh/13psIvqSqJFa1CcANErDW/w69saM9prk3jNnHtn
 nuEt/J9wDZeQfiNOYsLDFBdwYt2XtlLzy7G7T4kla0JNnAWQx3FS11bhwUa9HCIwKB+TroNcRY33
 oNmH4nRQzHQazgY7lmveanvOdQzf6IMJ3345q/s6ySNrGnXycmhg3OhX+mBPw6p4+AgTV3+hqS/w
 bOl0qtP5EgfDRdSDhnwOLtBcNrQxKZYuPe8bdCyw79zlPbqLQkZr26Lcxdvj8cqI+CogZdOhX7v3
 ClXzrmMENhJLl6MBfhzHVBR0wHQZxzIUka7Uq615Mik1qzcz308HFwsY4DWIzjhTYXUG8GBZhle6
 F/kpBdN+oWjoATjEFDwcaiz0R34rhTN+GTbl4uS+pZovX9cex7Ac4fawcerGI7TrGXpM/B/M0BZd
 PfIU1BX7pZc1sE3vsz58auH/srM2fgZ9JmgLbj7sqoEiwv7LCxIiAE5ODMnmwjvj2589zjbyZCiM
 WpBpW8YvoIIqmZcWhL/r/eFjMjJnMHeiAPOVK0T+c9pM0FteOLwuqFxkZtxbXpCgbiKBsA+Ddi6m
 awd1jemntr2PrMOTF1fDnHo5A9JQxMw0XtBqT5kbx7zuprmKeJENT1oiQUtfU17WEZPRHu1+r6ov
 Q/IKaojN7gdb+Glhdb8DP7Iz3Z0Qa+VGiF/lfNRtaK1t4SnssY938wKgOC3c9GkW+OmRHU05XGuW
 g+VcQ3bZb7F7k2CvWvw8dRRAAGTtpIcCl6rs3DrWsyxkqIWhq0No8c1Z2LbNGmmTb5qgpERsDkCX
 BgcGBwKlYailDNhe7w2QIanZ/NegoJ79AXUnIiEEoyCaZXMG8LAkbJoO2tY/Mg5ClXd30oBm8U++
 JlmpaolH3tK93iPfP9+mLIREJ/NOdtI62oaf3zKhYcm9jIBeZxq/HknEg+JATXLYM3A6BXfvel8O
 EFDbU51Q2S43vcWL3lM20b9wQESc+PquLiZOpxiedGbqX4nzL9MgCv99rrli2UQdOGeuQqV2IVXB
 o/3R5VqqcOmERbjE+D5FzT0EaduWMjGSdmMR5Ch1HY0a4RW7JP9zvdSGB9tIDxuFtg36jUhUk8/b
 P2/Mw1j9lmNQqiIAMR1SEszVdPY4ocfmWv3Fe9Iziczdq+A=
X-Report-Abuse-To: spam@antispamquarantine.host-h.net

Move the pinctrl node prior to the nodes that feature unit
addresses.

Sort pinctrl's child nodes into alphabetical order.

Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
---
 arch/mips/boot/dts/ralink/mt7621.dtsi | 172 +++++++++++++-------------
 1 file changed, 86 insertions(+), 86 deletions(-)

diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
index 60dfbae53..b28aee1e4 100644
--- a/arch/mips/boot/dts/ralink/mt7621.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
@@ -57,6 +57,92 @@ mmc_fixed_1v8_io: regulator-1v8 {
 		regulator-name = "mmc_io";
 	};
 
+	pinctrl: pinctrl {
+		compatible = "ralink,mt7621-pinctrl";
+
+		i2c_pins: i2c0-pins {
+			pinmux {
+				groups = "i2c";
+				function = "i2c";
+			};
+		};
+
+		mdio_pins: mdio0-pins {
+			pinmux {
+				groups = "mdio";
+				function = "mdio";
+			};
+		};
+
+		nand_pins: nand0-pins {
+			sdhci-pinmux {
+				groups = "sdhci";
+				function = "nand2";
+			};
+
+			spi-pinmux {
+				groups = "spi";
+				function = "nand1";
+			};
+		};
+
+		pcie_pins: pcie0-pins {
+			pinmux {
+				groups = "pcie";
+				function = "gpio";
+			};
+		};
+
+		rgmii1_pins: rgmii1-pins {
+			pinmux {
+				groups = "rgmii1";
+				function = "rgmii1";
+			};
+		};
+
+		rgmii2_pins: rgmii2-pins {
+			pinmux {
+				groups = "rgmii2";
+				function = "rgmii2";
+			};
+		};
+
+		sdhci_pins: sdhci0-pins {
+			pinmux {
+				groups = "sdhci";
+				function = "sdhci";
+			};
+		};
+
+		spi_pins: spi0-pins {
+			pinmux {
+				groups = "spi";
+				function = "spi";
+			};
+		};
+
+		uart1_pins: uart1-pins {
+			pinmux {
+				groups = "uart1";
+				function = "uart1";
+			};
+		};
+
+		uart2_pins: uart2-pins {
+			pinmux {
+				groups = "uart2";
+				function = "uart2";
+			};
+		};
+
+		uart3_pins: uart3-pins {
+			pinmux {
+				groups = "uart3";
+				function = "uart3";
+			};
+		};
+	};
+
 	palmbus: palmbus@1e000000 {
 		compatible = "palmbus";
 		reg = <0x1e000000 0x100000>;
@@ -202,92 +288,6 @@ spi0: spi@b00 {
 		};
 	};
 
-	pinctrl: pinctrl {
-		compatible = "ralink,mt7621-pinctrl";
-
-		i2c_pins: i2c0-pins {
-			pinmux {
-				groups = "i2c";
-				function = "i2c";
-			};
-		};
-
-		spi_pins: spi0-pins {
-			pinmux {
-				groups = "spi";
-				function = "spi";
-			};
-		};
-
-		uart1_pins: uart1-pins {
-			pinmux {
-				groups = "uart1";
-				function = "uart1";
-			};
-		};
-
-		uart2_pins: uart2-pins {
-			pinmux {
-				groups = "uart2";
-				function = "uart2";
-			};
-		};
-
-		uart3_pins: uart3-pins {
-			pinmux {
-				groups = "uart3";
-				function = "uart3";
-			};
-		};
-
-		rgmii1_pins: rgmii1-pins {
-			pinmux {
-				groups = "rgmii1";
-				function = "rgmii1";
-			};
-		};
-
-		rgmii2_pins: rgmii2-pins {
-			pinmux {
-				groups = "rgmii2";
-				function = "rgmii2";
-			};
-		};
-
-		mdio_pins: mdio0-pins {
-			pinmux {
-				groups = "mdio";
-				function = "mdio";
-			};
-		};
-
-		pcie_pins: pcie0-pins {
-			pinmux {
-				groups = "pcie";
-				function = "gpio";
-			};
-		};
-
-		nand_pins: nand0-pins {
-			spi-pinmux {
-				groups = "spi";
-				function = "nand1";
-			};
-
-			sdhci-pinmux {
-				groups = "sdhci";
-				function = "nand2";
-			};
-		};
-
-		sdhci_pins: sdhci0-pins {
-			pinmux {
-				groups = "sdhci";
-				function = "sdhci";
-			};
-		};
-	};
-
 	mmc: mmc@1e130000 {
 		status = "disabled";
 
-- 



