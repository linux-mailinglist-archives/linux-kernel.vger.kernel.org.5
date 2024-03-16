Return-Path: <linux-kernel+bounces-105089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F9987D8F2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 06:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2636A1C20D4D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 05:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093E5FC0C;
	Sat, 16 Mar 2024 05:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="X6Exh0nU"
Received: from outgoing6.flk.host-h.net (outgoing6.flk.host-h.net [188.40.0.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E18DC12C;
	Sat, 16 Mar 2024 05:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710565281; cv=none; b=NTmbfeHseUhYAEV5nS5D8mAWlofutK+jOKGW3ITAmLBADPYHIBCOP0ZbV/tx8V9nNq8ZpajYpQnUPW3LAVBT4nfJO2L0BTHa1UvIbobHff7D2T5X/UDzA3+Pv6sIoAg+S7eexlcGoEAmyL5cXGZM5dCbUByuheG9jPE6/GVjcWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710565281; c=relaxed/simple;
	bh=pJflWOuhSWjii0CFxIR/tujC1tYRbvVWmRE3TBPLNVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eUum4cruvq37FwoJr67m7xqmJ6/3ynOEhQYXShvpvtX15c9SNl6qt6MUJ72bmkJjTlqkvg//hg8NfWTvTZ72A9E5IuXeP2tyoHLvOPZpMEnFi7frn+s2mR2Hi52jCx8GvL+UhQcX5BeYm1NOVEnyfYscAMkK3rla6S7LR3Hsuz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=X6Exh0nU; arc=none smtp.client-ip=188.40.0.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc
	:content-type; bh=BH3xgWA8mmyArKQIZHEsckZAZY2smVn+7T1sXMMVFso=; b=X6Exh0nUiLg
	HJJdtovhT4t1IC7oUssOCR9xMLo6liG1/S5kx9ZPNXVHug1afG01Hhr9rRnrhFoXRR9cHVEihsmr5
	aqHaRnqR20oek7ntELUgKXLFQc7fXobICOIabjJayDbI4aUaOf930vdzchxvVfekBzqkTRwK/0aXO
	XfDG/cuyrBb98bIxW3Q4I6kSn54M846MV/wcMA9FyVHMgd8+b260fkpql1qvLRVsBiqSVn8tTFtsM
	HQBslEWzj19Jk5tHpJl70IAJhnSPDlw+w1rZd/uISjIb1jm5QONVI2v0UAiv53ynt9W1VSE4euZpg
	DdtJS9nYcVQgKLWLFVh0dVA==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam2-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rlMAU-00F9HU-8N; Sat, 16 Mar 2024 07:01:16 +0200
Received: from [41.144.0.193] (helo=localhost.localdomain)
	by www31.flk1.host-h.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rlM4r-00048C-6A; Sat, 16 Mar 2024 06:55:25 +0200
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
Subject: [PATCH 13/14] mips: dts: ralink: mt7621: reorder pci?_phy attributes
Date: Sat, 16 Mar 2024 06:54:41 +0200
Message-Id: <20240316045442.31469-14-justin.swartz@risingedge.co.za>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.02)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT/1KklyMJ7yZIgjH8grIC/TPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wPY5yY5vX9MqMW2dd4bQescfggEolMHSR1Me+1tLQd/4/M
 684FXPwRt/ItN/QGHZWwYVP/cCt8Z7AC3QZraAAXGOt0uV2bCpZmMTDaVY6o43+4/UA7yKh3fsRx
 FRwz3BBjyk7zbazyOxi/UqYNqAkRRGBP0VCgd4sTxz5Nt/DkcKfPy9Occ20k9TJ7Nj73O0V9NPjB
 nDE1daoPH54M/DHR5hr5ConJQfcb9SHvDRICkaHkmqj+K0XGa5SFpMYJI0DpfOOu7mUz0fsyGD6a
 bRQ+0H7Q2OEpckvWJAOmdJd77Z9vwc+QHB+X+u7aTqYHtT1NFG5qXEfeIX239vWfI6H8t9z6MXWg
 ZYbrkExtRMjfc/Em1xUk+uitP3ztfVUM86oAc60fMGKzOErxxj0B+NXHNlDo60GNfZ2F/yvXF5fp
 0YCObyJslD58xugMMZCpQQvGifDpq5EYH46qR+vFm9wC7ren9RtRNyYim5e3GD8LGX4whxLggZ+w
 3rysbgAyUKjvL2J0djuO4juAaA0bvabgXwvUJUc3Xwu/zqbuNWtRwuMbREsE9TmWz3t3brURPvSr
 AP5R/Cae/ZemygD++WnmLtBcNrQxKZYuPe8bdCyw79zlPbqLQkZr26Lcxdvj8cqI+CogZdOhX7v3
 ClXzrmMENhJLl6MBfhzHVBR0wHQZxzIUka7Uq615Mik1qzcz30/jNv+A51L2swh0gYW0eVWShle6
 F/kpBdN+oWjoATjEFDwcaiz0R34rhTN+GTbl4uS+pZovX9cex7Ac4fawcerGI7TrGXpM/B/M0BZd
 PfIU1BX7pZc1sE3vsz58auH/srM2fgZ9JmgLbj7sqoEiwv7LCxIiAE5ODMnmwjvj2589zjbyZCiM
 WpBpW8YvoIIqmZcWhL/r/eFjMjJnMHeiAPOVAT1rE1/vP68Bb4z3v3h3gCdXrv2+9GnNX30LKqXb
 fwFKgm/rnYBl+Mj5KqOl6Jzub/f3QhLRbOgisvi5VU9eNBtgo6zjiatjNO/pnMCjuIvXs/AyV/Ns
 URB/R+FlEHyAzksgfaRvdgw0WK34QWnzHHMcN6qoXPjenLhIOF1oeRYbjF1Hp647mOWoQlc3hL3c
 AHYPcQ0eIL+UT9voGXmPywdE0uYJOh+AQb1YdSeboil4u/m4iBmYb1/LCV4/EuVHup06w3Vwxf9C
 F7D6LKKRTfdjzQ6YC7Heg3Xf7O1TOd6RcY/MXB8eEq3bCN2QohZvyS03iBmgsz450Kmjd3fGV7y2
 7SwUA0R57OaOsdzcbqPAVI8T/o8mfTi4mg6e9+3dIbtf63VNbf0lrvssY+k7AHGi1NevGWTo2+h8
 Lhk4HCeZR7ymlGVRtthBJ2y8A5arx6JItKpFaUNPGMMlvbMX0nyK1NiAJ0y2Qvvn6ds6mor35w4f
 SfHzQbABJfgy21HclcZkPRq7NhoxyMwqi8Q23Rgadfh5T5n5D4OHHpbEIgsllZKWnzc5M5WlNtVJ
 qo05MS+4ayUpOtEhdxekWDmK9g==
X-Report-Abuse-To: spam@antispamquarantine.host-h.net

Reorder the attributes of the PCIe PHY nodes node to match
what the DTS style guide recommends.

Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
---
 arch/mips/boot/dts/ralink/mt7621.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
index aa06d12ac..284811f32 100644
--- a/arch/mips/boot/dts/ralink/mt7621.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
@@ -583,14 +583,18 @@ pcie@2,0 {
 	pcie0_phy: pcie-phy@1e149000 {
 		compatible = "mediatek,mt7621-pci-phy";
 		reg = <0x1e149000 0x0700>;
-		clocks = <&sysc MT7621_CLK_XTAL>;
+
 		#phy-cells = <1>;
+
+		clocks = <&sysc MT7621_CLK_XTAL>;
 	};
 
 	pcie2_phy: pcie-phy@1e14a000 {
 		compatible = "mediatek,mt7621-pci-phy";
 		reg = <0x1e14a000 0x0700>;
-		clocks = <&sysc MT7621_CLK_XTAL>;
+
 		#phy-cells = <1>;
+
+		clocks = <&sysc MT7621_CLK_XTAL>;
 	};
 };
-- 



