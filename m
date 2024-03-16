Return-Path: <linux-kernel+bounces-105084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B07FE87D8E2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 05:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E108B1C20F5E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 04:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485BC18EB0;
	Sat, 16 Mar 2024 04:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="Xifgdzys"
Received: from outgoing4.flk.host-h.net (outgoing4.flk.host-h.net [188.40.0.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EA318EA2;
	Sat, 16 Mar 2024 04:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710564905; cv=none; b=UNuONy8OTJGoiitoj8cxdVHHsIpH5/Ei/+Im1lvVDHq8Mu2jeHcwVB19s1zSS1F0LQfjCmX+foK5pMPkPseBBhosaNuYyfZGNBrdNJHd9xh3kUVwRtXc3h2PT+RflBqAEjSi5M6p0R9MCeqzo0O6FkBLOBiH1iAkb9JF4F78eHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710564905; c=relaxed/simple;
	bh=/MQvHkSuLZCpcoM2aPJPxqlXH61OgqIb/7fNadwO2mk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AbXou9uLJqOQWjSD6GF2iikOKDyx5O9Nr7lHsQ7Pe1I4kE14QS8UIC45euKydwa7iCgV0BSC4rqRElmhZnDcg8565x0T3Axcey1DK9gV4rVYmaIdJDv/yR8JHyANieRF9UANyxM7x6B09xWg5iiJ3/rcGvl01Je7QyFpNir3pgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=Xifgdzys; arc=none smtp.client-ip=188.40.0.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc
	:content-type; bh=LCeILb7fpZMvYEmdlBLFZB3FNHXwO10tSMn6VzUAg4Q=; b=Xifgdzys7pb
	YUiNE+Q1SsleOjcHzYdqUwP11BP5SJDiWfMmqvPkdBAJ2O9uMNegNc7231RSVe4T3q1zW362/opCR
	QMYCrlXadpDTxEaAQUBNuKkpkMeSoKee40Ia0qutCS206jpGlZ8CYSwstdSgZyEAGRosXb3vGh90f
	QRY2CfU3p/XY4gye58K069ew58Zafyecj9dnHmjl3/3GfGV8STWV5KUySX8Z/2u65U2ymbbvpK/Bp
	p2/k5DpmdB+sAVUJePIhh0VN6gH474nu5RQZugfPRWNef0pU5O9hb6XEzkniQF+rpefnF5R8oywzp
	i7pwgD5rJnV2bJRRzsPj5KQ==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam1-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rlM4S-00By0s-Mb; Sat, 16 Mar 2024 06:55:01 +0200
Received: from [41.144.0.193] (helo=localhost.localdomain)
	by www31.flk1.host-h.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rlM4R-00048C-Hm; Sat, 16 Mar 2024 06:55:00 +0200
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
Subject: [PATCH 07/14] mips: dts: ralink: mt7621: reorder spi0 node attributes
Date: Sat, 16 Mar 2024 06:54:35 +0200
Message-Id: <20240316045442.31469-8-justin.swartz@risingedge.co.za>
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
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT8VmHicyBRxT0hvQmPJoLrPPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wCPRB8bAzJcv2cv+UqiTTc2+CpNcmBnO4XM3Sck4bwNogU
 WCl1nkLBzZX0KuJ9bXiS85Z42w/+2OBolTNFbPomXFWCX8oNdggW7HE9XDTdSejrkEpbuUvwMvHx
 3T+KSG//gbuP7hnUK8NQdLwsVWKIFDZRrTGv3rxiw9tFrqFSCFNiLZt/QXQnOBRD+jq1HsKsDh/6
 Srgk2K3gr1VBfJbChkYH6fbrypLNrde+UooQVNLReLErukdelEOHUIpaBbp5GdnsN8+UvimwMinK
 0+Txhz2u9qvrL2PODYgMZQApJXOjDLkqunZ9NcY2bHZn7CfFscMZZf3sCkN20I5vMh4akiObI7Kj
 vK7X04QEin24qbfMFd8eGjnYW8aSH5qj4ujh/13psIvqSqJFa1CcANErDW/w69saM9prk3jNnHtn
 nuEt/J9wDZeQfiNOYsLDFBdwYt2XtlLzy7G7T4kla0JNnAWQx3FS11bhwUa9HCIwKB+TroNcRY33
 oNmH4nRQzHQazgY7lmveanvOdQzf6IMJ3345q/s6ySNrGnXycmhg3P0mHPOVe7X1XEyZtUFGKEmr
 AP5R/Cae/ZemygD++WnmLtBcNrQxKZYuPe8bdCyw79zlPbqLQkZr26Lcxdvj8cqI+CogZdOhX7v3
 ClXzrmMENhJLl6MBfhzHVBR0wHQZxzIUka7Uq615Mik1qzcz308HFwsY4DWIzjhTYXUG8GBZhle6
 F/kpBdN+oWjoATjEFDwcaiz0R34rhTN+GTbl4uS+pZovX9cex7Ac4fawcerGI7TrGXpM/B/M0BZd
 PfIU1BX7pZc1sE3vsz58auH/srM2fgZ9JmgLbj7sqoEiwv7LCxIiAE5ODMnmwjvj2589zjbyZCiM
 WpBpW8YvoIIqmZcWhL/r/eFjMjJnMHeiAPOVAT1rE1/vP68Bb4z3v3h3gCdXrv2+9GnNX30LKqXb
 fwFKgm/rnYBl+Mj5KqOl6Jzub/f3QhLRbOgisvi5VU9eNBtgo6zjiatjNO/pnMCjuIvXs/AyV/Ns
 URB/R+FlEHyAzksgfaRvdgw0WK34QWnzHHMcN6qoXPjenLhIOF1oeRYbjF1Hp647mOWoQlc3hL3c
 ZMexQ8VxpTDmnfa+pzT1vcFHeffjpT9zgUdMJRNapBV4u/m4iBmYb1/LCV4/EuVHup06w3Vwxf9C
 F7D6LKKRTfdjzQ6YC7Heg3Xf7O1TOd6RcY/MXB8eEq3bCN2QohZvyS03iBmgsz450Kmjd3fGVy0d
 PYsJIx8Kw6KVNDfstscpjGvO47GvPREGbd7TnBV3Ibtf63VNbf0lrvssY+k7AHGi1NevGWTo2+h8
 Lhk4HCeZR7ymlGVRtthBJ2y8A5arx6JItKpFaUNPGMMlvbMX0nyK1NiAJ0y2Qvvn6ds6mor35w4f
 SfHzQbABJfgy21HclcZkPRq7NhoxyMwqi8Q23Rgadfh5T5n5D4OHHpbEIgsllZKWnzc5M5WlNtVJ
 qo05MS+4ayUpOtEhdxekWDmK9g==
X-Report-Abuse-To: spam@antispamquarantine.host-h.net

Reorder the attributes of the SPI controller node so that
they're aligned with the DTS style guide.

Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
---
 arch/mips/boot/dts/ralink/mt7621.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
index 87a3bcbc0..60dfbae53 100644
--- a/arch/mips/boot/dts/ralink/mt7621.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
@@ -183,22 +183,22 @@ serial2: serial@e00 {
 		};
 
 		spi0: spi@b00 {
-			status = "disabled";
-
 			compatible = "ralink,mt7621-spi";
 			reg = <0xb00 0x100>;
 
-			clocks = <&sysc MT7621_CLK_SPI>;
-			clock-names = "spi";
-
-			resets = <&sysc MT7621_RST_SPI>;
-			reset-names = "spi";
-
 			#address-cells = <1>;
 			#size-cells = <0>;
 
+			clock-names = "spi";
+			clocks = <&sysc MT7621_CLK_SPI>;
+
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi_pins>;
+
+			reset-names = "spi";
+			resets = <&sysc MT7621_RST_SPI>;
+
+			status = "disabled";
 		};
 	};
 
-- 



