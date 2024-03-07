Return-Path: <linux-kernel+bounces-96050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A627875697
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAEE5281F76
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0129C13699E;
	Thu,  7 Mar 2024 19:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="YKse3Jvb"
Received: from outgoing4.flk.host-h.net (outgoing4.flk.host-h.net [188.40.0.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9776135A66;
	Thu,  7 Mar 2024 19:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838328; cv=none; b=J0EJkirvVTDnj0Li6NKs4iOg4Lsbu0+DAQRSVH8FvdAUCM6qV/gjvwiBfRzSdMmrDwymby60mpeOd6xIizDCk8V86GgnByeZRYP+yC+7ilnqXXjSGgdg02WRwtiwQzV6ZNptFzboi5agSjs4Vwqd7qDrT3JA8kyS3L1TrGa/QBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838328; c=relaxed/simple;
	bh=8aOsQ9dXU/uHaHhbDZiHLR63A2lxD1hCAqIW2LWrACY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NMfQB0t+ApD0q1lCmTm3fs/VeimMuS3dK4eIm+rPNjHI8oEDyp4bCRDZw8DF01IS5A5/d/dDDKXaIRLWmnk/mB3s8owblv8DGvqiTe6QTewt5XOWH9e1ZKHqTiI68WIKhzqo2A+y6s8uGXlmjdKIxQfMyXSyNWSbBhTVRxP12uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=YKse3Jvb; arc=none smtp.client-ip=188.40.0.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc
	:content-type; bh=CkkEezkguIbm3o6UtY6xuUlSDLGF/rVfjuM8OlCCJgg=; b=YKse3JvbwQm
	WFYEl2Gp46CYEfT0nDRnpymPHQziwWe8L/S1NFx2geFLedziV9VS+BXfASiOn8tC7f1Hbxh8KzF8W
	f2YZfHfU8R/kBaXpHrODTDT3hELwqCcMwLQqSh0F6wH5pxGSAWqze2gFqXpyPGhLDEr2NEDnV+gxr
	ugnY9zn27M6VhXp2/5sV1U8MTKEdTOEI+bvt1dvlqJMhEebvLQhqL/s04JBpP9/1K+5mlMXh+0fLs
	T7To7LsazWri9C8o3ieKEulPAdrd4vKz7vG4MwlDcIceVUv2KRzKCNbGL0kBQZZSUgmPCzZflkYZU
	u/gZ7UUD0f2scyYu5osCs+w==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam1-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1riJ3I-00HIFu-VJ; Thu, 07 Mar 2024 21:05:15 +0200
Received: from [41.144.0.96] (helo=localhost.localdomain)
	by www31.flk1.host-h.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1riJ3E-0007Za-5h; Thu, 07 Mar 2024 21:05:08 +0200
From: Justin Swartz <justin.swartz@risingedge.co.za>
To: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Justin Swartz <justin.swartz@risingedge.co.za>,
	linux-mips@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 2/3] mips: dts: ralink: mt7621: reorder serial0 properties
Date: Thu,  7 Mar 2024 21:04:06 +0200
Message-Id: <20240307190408.23443-2-justin.swartz@risingedge.co.za>
In-Reply-To: <20240307190408.23443-1-justin.swartz@risingedge.co.za>
References: <CAMhs-H_eUKm7C40oCzuKwwEMZAcOJ-g4MghAfkGAmxRM0AXPUw@mail.gmail.com>
 <20240307190408.23443-1-justin.swartz@risingedge.co.za>
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
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+EJWyemKZyVEbbV54WwyIJPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wCPRB8bAzJcv2cv+UqiTTc2+CpNcmBnO4XM3Sck4bwNogU
 WCl1nkLBzZX0KuJ9bXiS85Z42w/+2OBolTNFbPomXFWCX8oNdggW7HE9XDTdSejrkEpbuUvwMvHx
 3T+KSG//gbuP7hnUK8NQdLwsVWKIFDZRrTGv3rxiw9tFrqFSCFNiLZt/QXQnOBRD+jq1HsKsDh/6
 Srgk2K3gr1VBfJbChkYH6fbrypLNrde+UooQVNLReLErukdelEOHUIpaBbp5GdnsN8+UvimwMinK
 0+Txhz2u9qvrL2PODYgMZQApJXOjDLkqunZ9NcY2bHZn7CfFscMZZf3sCkN20I5vMh4akiObI7Kj
 vK7X04QEin24qbfMFd8eGjnYW8aSH5qj4ujh/13psIvqSqJFa1CcANErDW/w69saM9prk3jNnHtn
 nuEt/J9wDZeQfiNOYsLDFBdwYt2XtlLzy7G7T4kla0JNnAWQx3FS11bhwUa9HCIwKB+TroNcRY33
 oNmH4nRQzHQazgY7lmveanvOdQzf6IMJ3345q/s6ySNrGnXycmhg3MW3Cu62CB3+QcEeXee7EsSr
 AP5R/Cae/ZemygD++WnmLtBcNrQxKZYuPe8bdCyw79zlPbqLQkZr26Lcxdvj8cqI+CogZdOhX7v3
 ClXzrmMENhJLl6MBfhzHVBR0wHQZxzIUka7Uq615Mik1qzcz308HFwsY4DWIzjhTYXUG8GBZhle6
 F/kpBdN+oWjoATjEFDwcaiz0R34rhTN+GTbl4uS+pZovX9cex7Ac4fawcerGI7TrGXpM/B/M0BZd
 PfIU1BX7pZc1sE3vsz58auH/srM2fgZ9JmgLbj7sqoEiwv7LCxIiAE5ODMnmwjvj2589zjbyZCiM
 WpBpW8YvoIIqmZcWhL/r/eFjMjJnMHeiAPOVAT1rE1/vP68Bb4z3v3h3gCdXrv2+9GnNX30LKqXb
 fwFKgm/rnYBl+Mj5KqOl6Jzub/f3QhLRbOgisvi5VU9eNBtgo6zjiatjNO/pnMCjuIvXs/AyV/Ns
 URB/R+FlEHyAzksgfaRvdgw0WK34QWnzHHMcN6qoXPjenLhIOF1oeRYbjF1Hp647mOWoQlc3hL3c
 ZMexQ8VxpTDmnfa+pzT1vSQKfAk/SzcWdtcr5u4DiPd4u/m4iBmYb1/LCV4/EuVHup06w3Vwxf9C
 F7D6LKKRTfdjzQ6YC7Heg3Xf7O1TOd6RcY/MXB8eEq3bCN2QohZvyS03iBmgsz450Kmjd3fGV8nM
 bkxHyXWCxCogb2beJIaKQwoPjGI9+ZGz2GEpaMILIbtf63VNbf0lrvssY+k7AHGi1NevGWTo2+h8
 Lhk4HCeZR7ymlGVRtthBJ2y8A5arx6JItKpFaUNPGMMlvbMX0nyK1NiAJ0y2Qvvn6ds6mor35w4f
 SfHzQbABJfgy21HclcZkPRq7NhoxyMwqi8Q23Rgadfh5T5n5D4OHHpbEIgsllZKWnzc5M5WlNtVJ
 qo05MS+4ayUpOtEhdxekWDmK9g==
X-Report-Abuse-To: spam@antispamquarantine.host-h.net

Reorder serial0 properties according to the guidelines laid
out in Documentation/devicetree/bindings/dts-coding-style.rst

Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
---
 arch/mips/boot/dts/ralink/mt7621.dtsi | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
index dca415fdd..3ad4e2343 100644
--- a/arch/mips/boot/dts/ralink/mt7621.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
@@ -114,16 +114,12 @@ memc: memory-controller@5000 {
 		serial0: serial@c00 {
 			compatible = "ns16550a";
 			reg = <0xc00 0x100>;
-
+			reg-io-width = <4>;
+			reg-shift = <2>;
 			clocks = <&sysc MT7621_CLK_UART1>;
-
 			interrupt-parent = <&gic>;
 			interrupts = <GIC_SHARED 26 IRQ_TYPE_LEVEL_HIGH>;
-
-			reg-shift = <2>;
-			reg-io-width = <4>;
 			no-loopback-test;
-
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart1_pins>;
 		};
-- 


