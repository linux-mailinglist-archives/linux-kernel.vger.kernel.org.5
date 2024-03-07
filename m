Return-Path: <linux-kernel+bounces-96335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B212875A60
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9865B21E29
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914863839C;
	Thu,  7 Mar 2024 22:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="DlRT/qdV"
Received: from outgoing1.flk.host-h.net (outgoing1.flk.host-h.net [188.40.0.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76722F4FC;
	Thu,  7 Mar 2024 22:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709851138; cv=none; b=HU/peiDOFTbBjfes4gdQNPQMPuz0D+CNBu1rm+VVDbAoNQ1KB0u+RWosf+UsHD9QhsKyynmwGvsrAz39UphOpw/rd2rIqvL7Lbx6FN6WK02UEO82O25U6zljExvECEShUEQHTA0Vgj6KNUh9rEmaqHfXp8GCPEB5GEF6RhIL+qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709851138; c=relaxed/simple;
	bh=wL4NyZZE9y5hpECyPu4zMJgWgfdbyPA7hO9wu+MDuuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Si7vrrJqFMCT/Sj3tsAYcCFJS+0sG+PLZuDz1IuaD/7lyr1UBwBxqtA4Jx53+/1TRH1Az3DvW1JicDOKAP76Mud86dzJWbhrYcSJQnpnSv1xlSMwu/6V0uVNWHnpAjEuRJOBmFaLxEEfUjER0QCiHg7AkdJyPB+mJ59uVwLUQPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=DlRT/qdV; arc=none smtp.client-ip=188.40.0.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc
	:content-type; bh=4c3qgpikoPrAL+mWZEwmjcnn4NWwsri0mLkHjgl7PRM=; b=DlRT/qdVEMA
	Qj39H2GPQb4ofFgfIMQTCj+Xt+qf58ee5LyeA/UW4vQYZdISWVhvIQoBYlnCfZRfqUeHr/nDAUogG
	PT717D8eTx0yc8FZU/GEcFxCYx1V8/XcciEZdNS6CWgxfWtV83nuz78PNltMuJukVt/DBTOokZ2KD
	gpLS+bm5r7NARjDxQt5FDsKSBkW+Z4hKE9kEq2tcb5lC+FLoeEE5aJabsBf95jhsLctC2YnWFNkLV
	AKejbrYb5Xcumk+MyNQgJmMoo9DpUdKsZ5NTT/l9iZzwmp8bgC20QfYwKIRvKdpUW0gVwXx4iGyAP
	k+VtLHy4YymNUSExqdCMtyA==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam3-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1riMNx-00EJC0-0y; Fri, 08 Mar 2024 00:38:47 +0200
Received: from [41.144.0.96] (helo=localhost.localdomain)
	by www31.flk1.host-h.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1riMNv-00063S-5w; Fri, 08 Mar 2024 00:38:43 +0200
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
Subject: [PATCH v2] mips: dts: ralink: mt7621: add cell count properties to usb
Date: Fri,  8 Mar 2024 00:37:55 +0200
Message-Id: <20240307223756.31643-1-justin.swartz@risingedge.co.za>
In-Reply-To: <0001-mips-dts-ralink-mt7621-add-cell-count-properties-to-.patch>
References: <0001-mips-dts-ralink-mt7621-add-cell-count-properties-to-.patch>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.03)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+ShUxo1lZhr/4810rqkDy2PUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wCPRB8bAzJcv2cv+UqiTTc2+CpNcmBnO4XM3Sck4bwNogU
 WCl1nkLBzZX0KuJ9bXiS85Z42w/+2OBolTNFbPomXFWCX8oNdggW7HE9XDTdSejrkEpbuUvwMvHx
 3T+KSG//gbuP7hnUK8NQdLwsVWKIFDZRrTGv3rxiw9tFrqFSCFNiLZt/QXQnOBRD+jq1HsKsDh/6
 Srgk2K3gr1VBfJbChkYH6fbrypLNrde+UooQVNLReLErukdelEOHUIpaBbp5GdnsN8+UvimwMinK
 0+Txhz2u9qvrL2PODYgMZQApJXOjDLkqunZ9NcY2bHZn7CfFscMZZf3sCkN20I5vMh4akiObI7Kj
 vK7X04QEin24qbfMFd8eGjnYW8aSH5qj4ujh/13psIvqSqJFa1CcANErDW/w69saM9prk3jNnHtn
 nuEt/J9wDZeQfiNOYsLDFBdwYt2XtlLzy7G7T4kla0JNnAWQx3FS11bhwUa9HCIwKB+TroNcRY33
 oNmH4nRQzHQazgY7lmveanvOdQzf6IMJ3345q/s6ySNrGnXycmhg3JnjXMk6WVt2DdYZpaI7YoqC
 n3oZFShGuGVczvnnMQuyLtBcNrQxKZYuPe8bdCyw79zlPbqLQkZr26Lcxdvj8cqI+CogZdOhX7v3
 ClXzrmMENhJLl6MBfhzHVBR0wHQZxzIUka7Uq615Mik1qzcz30+tdk6yIuh9K7v+Nq0Cm3JVhle6
 F/kpBdN+oWjoATjEFDwcaiz0R34rhTN+GTbl4uS+pZovX9cex7Ac4fawcerGI7TrGXpM/B/M0BZd
 PfIU1BX7pZc1sE3vsz58auH/srM2fgZ9JmgLbj7sqoEiwv7LCxIiAE5ODMnmwjvj2589zjbyZCiM
 WpBpW8YvoIIqmZcWhL/r/eFjMjJnMHeiAPOVAT1rE1/vP68Bb4z3v3h3gCdXrv2+9GnNX30LKqXb
 fwFKgm/rnYBl+Mj5KqOl6Jzub/f3QhLRbOgisvi5VU9eNBtgo6zjiatjNO/pnMCjuIvXs/AyV/Ns
 URB/R+FlEHyAzksgfaRvdgw0WK34QWnzHHMcN6qoXPjenLhIOF1oeRYbjF1Hp647mOWoQlc3hL3c
 dBMSQgQtiTUcJp5roVy0accKGd6B3Bcq0EWwerTw3MB4u/m4iBmYb1/LCV4/EuVHup06w3Vwxf9C
 F7D6LKKRTfdjzQ6YC7Heg3Xf7O1TOd6RcY/MXB8eEq3bCN2QohZvyS03iBmgsz450Kmjd3fGV6Vl
 lQvK5SVFh0jOtrkFCxJXdkkgrbJ9PcBIysKIgfarIbtf63VNbf0lrvssY+k7AHGi1NevGWTo2+h8
 Lhk4HCeZR7ymlGVRtthBJ2y8A5arx6JItKpFaUNPGMMlvbMX0nyK1NiAJ0y2Qvvn6ds6mor35w4f
 SfHzQbABJfgy21HclcZkPRq7NhoxyMwqi8Q23Rgadfh5T5n5D4OHHpbEIgsllZKWnzc5M5WlNtVJ
 qo05MS+4ayUpOtEhdxekWDmK9g==
X-Report-Abuse-To: spam@antispamquarantine.host-h.net

Add default #address-cells and #size-cells properties to the
usb node, which should be suitable for hubs and devices without
explicitly declared interface nodes, as:

  "#address-cells":
    description: should be 1 for hub nodes with device nodes,
      should be 2 for device nodes with interface nodes.
    enum: [1, 2]

  "#size-cells":
    const: 0

-- Documentation/devicetree/bindings/usb/usb-device.yaml

This version of the patch places the properties according to
the order recommended by:

   Documentation/devicetree/bindings/dts-coding-style.rst

Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
---
 arch/mips/boot/dts/ralink/mt7621.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
index 5a89f0b8c..7532e17dd 100644
--- a/arch/mips/boot/dts/ralink/mt7621.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
@@ -289,10 +289,10 @@ usb: usb@1e1c0000 {
 		reg = <0x1e1c0000 0x1000
 		       0x1e1d0700 0x0100>;
 		reg-names = "mac", "ippc";
-
+		#address-cells = <1>;
+		#size-cells = <0>;
 		clocks = <&sysc MT7621_CLK_XTAL>;
 		clock-names = "sys_ck";
-
 		interrupt-parent = <&gic>;
 		interrupts = <GIC_SHARED 22 IRQ_TYPE_LEVEL_HIGH>;
 	};
-- 


