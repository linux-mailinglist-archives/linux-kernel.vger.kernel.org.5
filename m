Return-Path: <linux-kernel+bounces-105086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7887387D8E8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 05:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1611C210DA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 04:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A40D1BC4E;
	Sat, 16 Mar 2024 04:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="QA8UtVhP"
Received: from outgoing4.flk.host-h.net (outgoing4.flk.host-h.net [188.40.0.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BBA1BC20;
	Sat, 16 Mar 2024 04:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710564913; cv=none; b=MHA3mh/zlldoyD5FlATzvagsGAcgXl/8k2KNRSXmTl+et6bs51q6sv4sPj8epnmFy/gK27Dd/pZ8sjcu3hw6YXynsTi7IdqIddQ6aYWDQby7JU5O83CRJRZDPifpj6LNkCqjn/GBR1JbBc1iVKD9Djpw8VfHjeZxp7cb63/Gho4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710564913; c=relaxed/simple;
	bh=oWbCDq0FK0I7xS1KU/FZS0J8CDWqA1ZuqFHrs6e16Ck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SHCmm8V1waJmjvzdDx0tSaRXCtzWc+h4AHd9VSEmHMl+1g0lwq0PRNeX4r6FmNvpntrjbIWp5CX37BNgZxxNLwOcOekFjrP4WazKbG3IiXcFhM5PpEkOwwle8F8VExQvin2jw195pRHo+13zvxCoq6uDD7fVnSG485Y90BWuGxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=QA8UtVhP; arc=none smtp.client-ip=188.40.0.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc
	:content-type; bh=M6AVpAALKBguRN0p7bEU28pHCVhJpFsLfv2jpId0kvg=; b=QA8UtVhP4+u
	yRb4XTxv3Sh4K3fCJY4Es4bqcv0QMBGUi2Az1JXO9AP0XaJtzdBBxyprk4PvpMwRwekeqQN9Boq8c
	xXaXDzo2bIvTs71NW40H8iyAusueu6NSZ8JluVsSliltV8q5Rhpn7ciZxnmBRYQaAIIgEQKcQJK86
	KR7J/BMdguVx+BYMvm6L/NHJdgRogUuRV+Is4hwLcemPNHU3A4GrBFmKtBWsYqp4G2dIztpvjuoww
	Ly15jlmE99vHxnUQpXBiadIHrpnBdafXDd981dYEwJal4nNHW2e4SPXQYtdwZWtyhVZWGYkt/YAY3
	B7f9ctTD7pSaWUzGV5xlq7Q==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam1-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rlM4b-00By7o-3A; Sat, 16 Mar 2024 06:55:09 +0200
Received: from [41.144.0.193] (helo=localhost.localdomain)
	by www31.flk1.host-h.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rlM4a-00048C-1y; Sat, 16 Mar 2024 06:55:08 +0200
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
Subject: [PATCH 09/14] mips: dts: ralink: mt7621: reorder mmc node attributes
Date: Sat, 16 Mar 2024 06:54:37 +0200
Message-Id: <20240316045442.31469-10-justin.swartz@risingedge.co.za>
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00352614512713)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT8UDEkE82fkC2gep8p+lOPfPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wCPRB8bAzJcv2cv+UqiTTc2+CpNcmBnO4XM3Sck4bwNogU
 WCl1nkLBzZX0KuJ9bXiS85Z42w/+2OBolTNFbPomXFWCX8oNdggW7HE9XDTdSejrkEpbuUvwMvHx
 3T+KSG//gbuP7hnUK8NQdLwsVWKIFDZRrTGv3rxiw9tFrqFSCFNiLZt/QXQnOBRD+jq1HsKsDh/6
 Srgk2K3gr1VBfJbChkYH6fbrypLNrde+UooQVNLReLErukdelEOHUIpaBbp5GdnsN8+UvimwMinK
 0+Txhz2u9qvrL2PODYgMZQApJXOjDLkqunZ9NcY2bHZn7CfFscMZZf3sCkN20I5vMh4akiObI7Kj
 vK7X04QEin24qbfMFd8eGjnYW8aSH5qj4ujh/13psIvqSqJFa1CcANErDW/w69saM9prk3jNnHtn
 nuEt/J9wDZeQfiNOYsLDFBdwYt2XtlLzy7G7T4kla0JNnAWQx3FS11bhwUa9HCIwKB+TroNcRY33
 oNmH4nRQzHQazgY7lmveanvOdQzf6IMJ3345q/s6ySNrGnXycmhg3FZtg9L/4D3IdjU7jgQ9kr1w
 GYjbvhzWX8Co+5c+eruaLtBcNrQxKZYuPe8bdCyw79zlPbqLQkZr26Lcxdvj8cqI+CogZdOhX7v3
 ClXzrmMENhJLl6MBfhzHVBR0wHQZxzIUka7Uq615Mik1qzcz308HFwsY4DWIzjhTYXUG8GBZhle6
 F/kpBdN+oWjoATjEFDwcaiz0R34rhTN+GTbl4uS+pZovX9cex7Ac4fawcerGI7TrGXpM/B/M0BZd
 PfIU1BX7pZc1sE3vsz58auH/srM2fgZ9JmgLbj7sqoEiwv7LCxIiAE5ODMnmwjvj2589zjbyZCiM
 WpBpW8YvoIIqmZcWhL/r/eFjMjJnMHeiAPOVK0T+c9pM0FteOLwuqFxkZtxbXpCgbiKBsA+Ddi6m
 awd1jemntr2PrMOTF1fDnHo5A9JQxMw0XtBqT5kbx7zuprmKeJENT1oiQUtfU17WEZPRHu1+r6ov
 Q/IKaojN7gdb+Glhdb8DP7Iz3Z0Qa+VGiF/lfNRtaK1t4SnssY938wKgOC3c9GkW+OmRHU05XGuW
 g+VcQ3bZb7F7k2CvWvw8dRRAAGTtpIcCl6rs3DrWsyzSfiT+l3FvXziQPKM9nduMb5qgpERsDkCX
 BgcGBwKlYailDNhe7w2QIanZ/NegoJ79AXUnIiEEoyCaZXMG8LAkbJoO2tY/Mg5ClXd30oBm8U++
 JlmpaolH3tK93iPfP9+mLIREJ/NOdtI62oaf3zKhaU0sxcztHvRVOJrtvab1f3LYM3A6BXfvel8O
 EFDbU51Q2S43vcWL3lM20b9wQESc+PquLiZOpxiedGbqX4nzL9MgCv99rrli2UQdOGeuQqV2IVXB
 o/3R5VqqcOmERbjE+D5FzT0EaduWMjGSdmMR5Ch1HY0a4RW7JP9zvdSGB9tIDxuFtg36jUhUk8/b
 P2/Mw1j9lmNQqiIAMR1SEszVdPY4ocfmWv3Fe9Iziczdq+A=
X-Report-Abuse-To: spam@antispamquarantine.host-h.net

Shuffle the attributes of the MMC node to meet the guidelines
provided by the DTS style guide.

Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
---
 arch/mips/boot/dts/ralink/mt7621.dtsi | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
index b28aee1e4..1fbe345bd 100644
--- a/arch/mips/boot/dts/ralink/mt7621.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
@@ -289,29 +289,33 @@ spi0: spi@b00 {
 	};
 
 	mmc: mmc@1e130000 {
-		status = "disabled";
-
 		compatible = "mediatek,mt7620-mmc";
 		reg = <0x1e130000 0x4000>;
 
 		bus-width = <4>;
-		max-frequency = <48000000>;
-		cap-sd-highspeed;
-		cap-mmc-highspeed;
-		vmmc-supply = <&mmc_fixed_3v3>;
-		vqmmc-supply = <&mmc_fixed_1v8_io>;
-		disable-wp;
 
-		pinctrl-names = "default", "state_uhs";
-		pinctrl-0 = <&sdhci_pins>;
-		pinctrl-1 = <&sdhci_pins>;
+		cap-mmc-highspeed;
+		cap-sd-highspeed;
 
 		clocks = <&sysc MT7621_CLK_SHXC>,
 			 <&sysc MT7621_CLK_50M>;
 		clock-names = "source", "hclk";
 
+		disable-wp;
+
 		interrupt-parent = <&gic>;
 		interrupts = <GIC_SHARED 20 IRQ_TYPE_LEVEL_HIGH>;
+
+		max-frequency = <48000000>;
+
+		pinctrl-names = "default", "state_uhs";
+		pinctrl-0 = <&sdhci_pins>;
+		pinctrl-1 = <&sdhci_pins>;
+
+		vmmc-supply = <&mmc_fixed_3v3>;
+		vqmmc-supply = <&mmc_fixed_1v8_io>;
+
+		status = "disabled";
 	};
 
 	usb: usb@1e1c0000 {
-- 



