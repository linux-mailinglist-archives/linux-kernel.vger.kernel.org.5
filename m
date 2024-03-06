Return-Path: <linux-kernel+bounces-94557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7916C874154
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3562B283A34
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B4F14263B;
	Wed,  6 Mar 2024 20:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="bJNSTlDO"
Received: from outgoing6.flk.host-h.net (outgoing6.flk.host-h.net [188.40.0.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E75D140E25;
	Wed,  6 Mar 2024 20:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709756550; cv=none; b=czYSKZZLv+7fDpHz4m//M68l9WepXJv9fXrz5URq8PdmPI63EU0FxYrr3HEFTbNcRI5EPvH6Wmkpuj5Aj02yofVkw8mrEy+jfm+J8Zyr/XU4EBbJFgYJ9GM7Ioisi1m+dZjroqQxKmW6W199NMrsWLlCm7XeYaUw7/yegZG6yGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709756550; c=relaxed/simple;
	bh=iKBxmrjRTHGaEWBsa/2VCeVm3QJ9DmZ63Q3pN6vvTvU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q3A5gnEHE3H3kr74cTXPGFTcXp+1IVm4s2ce6dccTAnLLK8WyeEVpFKPCxbP2ghAoiDUPiHRl17HaPvYSn5z/GZ4PYKrdhkYEdwutzVkxIJumgu89sd1AuIDBv8BqX76G5lo8wT2vaQHJRsY5z5C3VzSeO/RhP5ehvD74+Pq/yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=bJNSTlDO; arc=none smtp.client-ip=188.40.0.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:in-reply-to:references
	:content-type; bh=RhOLI7ajqF1MzAQANawDx0KfHIUFrOMc9rxDpzQgGmE=; b=bJNSTlDOefy
	61b8/QuoxOvA42AWQqm1kAvHCV3qeLtR5GrQfNiVaVycHmbXFfLH4aPxUFoc+akDmZZx7Gk/QMEXE
	cHH71/mSN3wj7/osvCMDiese8sViwqZFKCpjv+gcIeipAXRvZys3EO/GACJBHytLSTbBWPC7UxxE+
	uvIXRQqCp4GVRLxsa65ZguHq4lkplCnhO0z6HfSNKEOX6r05t+ZYs4TxzJkf2UM4qk5qId7rwk5xB
	9lPfVEcvoXLhq104vi7ZwgTSSQZEFB2F3x2109X9ZA/kHmpAZn/utHBNDJlUGVW5qZ6TFHv0n0NZa
	WE8rRz0xMe/ZenNg+CehQtQ==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam2-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rhxmP-008FKI-VC; Wed, 06 Mar 2024 22:22:23 +0200
Received: from [41.144.0.96] (helo=localhost.localdomain)
	by www31.flk1.host-h.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rhxmO-000470-No; Wed, 06 Mar 2024 22:22:21 +0200
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
Subject: [PATCH] mips: dts: ralink: mt7621: add cell count properties to usb0
Date: Wed,  6 Mar 2024 22:21:30 +0200
Message-Id: <20240306202131.2009-1-justin.swartz@risingedge.co.za>
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
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT8u1iKio0m5ENqq/v6sUdjUPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wCPRB8bAzJcv2cv+UqiTTc2+CpNcmBnO4XM3Sck4bwNogU
 WCl1nkLBzZX0KuJ9bXiS85Z42w/+2OBolTNFbPomXFWCX8oNdggW7HE9XDTdSejrkEpbuUvwMvHx
 3T+KSG//gbuP7hnUK8NQdLwsVWKIFDZRrTGv3rxiw9tFrqFSCFNiLZt/QXQnOBRD+jq1HsKsDh/6
 Srgk2K3gr1VBfJbChkYH6fbrypLNrde+UooQVNLReLErukdelEOHUIpaBbp5GdnsN8+UvimwMinK
 0+Txhz2u9qvrL2PODYgMZQApJXOjDLkqunZ9NcY2bHZn7CfFscMZZf3sCkN20I5vMh4akiObI7Kj
 vK7X04QEin24qbfMFd8eGjnYW8aSH5qj4ujh/13psIvqSqJFa1CcANErDW/w69saM9prk3jNnHtn
 nuEt/J9wDZeQfiNOYsLDFBdwYt2XtlLzy7G7T4kla0JNnAWQx3FS11bhwUa9HCIwKB+TroNcRY33
 oNmH4nRQzHQazgY7lmveanvOdQzf6IMJ3345q/s6ySNrGnXycmhg3HT6l/+R2RQwiqvJZHD34MCo
 naNQbqJUPRwZtKOTN8gOLtBcNrQxKZYuPe8bdCyw79zlPbqLQkZr26Lcxdvj8cqI+CogZdOhX7v3
 ClXzrmMENhJLl6MBfhzHVBR0wHQZxzIUka7Uq615Mik1qzcz30/jNv+A51L2swh0gYW0eVWShle6
 F/kpBdN+oWjoATjEFDwcaiz0R34rhTN+GTbl4uS+pZovX9cex7Ac4fawcerGI7TrGXpM/B/M0BZd
 PfIU1BX7pZc1sE3vsz58auH/srM2fgZ9JmgLbj7sqoEiwv7LCxIiAE5ODMnmwjvj2589zjbyZCiM
 WpBpW8YvoIIqmZcWhL/r/eFjMjJnMHeiAPOVAT1rE1/vP68Bb4z3v3h3gCdXrv2+9GnNX30LKqXb
 fwFKgm/rnYBl+Mj5KqOl6Jzub/f3QhLRbOgisvi5VU9eNBtgo6zjiatjNO/pnMCjuIvXs/AyV/Ns
 URB/R+FlEHyAzksgfaRvdgw0WK34QWnzHHMcN6qoXPjenLhIOF1oeRYbjF1Hp647mOWoQlc3hL3c
 AHYPcQ0eIL+UT9voGXmPy/EfqKigCkS4jvgpgnSnhVl4u/m4iBmYb1/LCV4/EuVHup06w3Vwxf9C
 F7D6LKKRTfdjzQ6YC7Heg3Xf7O1TOd6RcY/MXB8eEq3bCN2QohZvyS03iBmgsz450Kmjd3fGV352
 DiYuZ9qKjQENeFDfQ/Eil4ujX9wEjPOhkfiiTRngIbtf63VNbf0lrvssY+k7AHGi1NevGWTo2+h8
 Lhk4HCeZR7ymlGVRtthBJ2y8A5arx6JItKpFaUNPGMMlvbMX0nyK1NiAJ0y2Qvvn6ds6mor35w4f
 SfHzQbABJfgy21HclcZkPRq7NhoxyMwqi8Q23Rgadfh5T5n5D4OHHpbEIgsllZKWnzc5M5WlNtVJ
 qo05MS+4ayUpOtEhdxekWDmK9g==
X-Report-Abuse-To: spam@antispamquarantine.host-h.net

Add default #address-cells and #size-cells properties to usb0,
suitable for hubs and devices without explicitly declared
interface nodes, as:

  "#address-cells":
    description: should be 1 for hub nodes with device nodes,
      should be 2 for device nodes with interface nodes.
    enum: [1, 2]

  "#size-cells":
    const: 0

-- from Documentation/devicetree/bindings/usb/usb-device.yaml

Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
---
 arch/mips/boot/dts/ralink/mt7621.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
index 2069249c8..f02965db1 100644
--- a/arch/mips/boot/dts/ralink/mt7621.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
@@ -309,6 +309,9 @@ usb: usb@1e1c0000 {
 
 		interrupt-parent = <&gic>;
 		interrupts = <GIC_SHARED 22 IRQ_TYPE_LEVEL_HIGH>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
 	};
 
 	gic: interrupt-controller@1fbc0000 {
-- 


