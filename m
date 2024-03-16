Return-Path: <linux-kernel+bounces-105087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 861C687D8EC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 06:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16ACBB214B7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 05:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F6F6AB6;
	Sat, 16 Mar 2024 05:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="kVjdwj6P"
Received: from outgoing4.flk.host-h.net (outgoing4.flk.host-h.net [188.40.0.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22BA4A33;
	Sat, 16 Mar 2024 05:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710565277; cv=none; b=CjB1xIFwaVGIwEXaLpXddXpSj5aqcM0wvg2iEB9+VXfOZxAY+bql9JQDR0kaSB+MKYRNm2AAaczH+DSnypQzuhqd2U4vkKSHk2XGU8YeiH5/WjnDVBTvuV2ERpYazOiQ35YgGsqIPEIuz/NYF6bHRj1BMGzhmnPAgSFvdmQx0XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710565277; c=relaxed/simple;
	bh=oSfJMu5SXAU0DaHw9gtdUFWS56XBABVayla7/Nmfr/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WaJILnRRFAlcMaJqcrfGssg8BwjmV9M0MKVPEFqL9NkGVR5KrFHUfzNblbXV4KX9wrkBlwpTcx92drKEupcsp4qq6WMTf0tOzbhDmUqNTaYeKYqwPe2/XBCaf2EJ8cV5aHvnivfEuMKHC7bCKRG3E1Ssc9HyNSpecAktas+lMeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=kVjdwj6P; arc=none smtp.client-ip=188.40.0.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc
	:content-type; bh=CZTTO/cn70dET1uz8oqycPprN34msZsy0Dgdh0xlHck=; b=kVjdwj6PZCj
	s+nzUw4zhLZq9WrUnISkM64LheQaag3Wq8hI/1a31fpT7luCVNymj0DJMPxbhpHaP0GoxxR52OG/B
	p+V91Hu9m1z+BH0egwBNS2ztNN6DhnhODBkg4XWtsIja0L5nd8UlJypdTFnSwrx7FFEkTAVkhQCN5
	FGCAKDbklY4UhyneiJ/gkve9gghdNd67bWWti++SZ2oSQa6au/dFDNRiauwmQUqpvtoDuEulQC90Z
	ZP2XuSmZdRQk8NPkbHP706ytPx54mfY+tqu8KONrPdNo6AarWt/a+Pa85vb7Aky/j/1Hl04dDnwVL
	C/r1ycRaBpREozGz29Qu7Tg==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam1-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rlMAQ-00C0Qn-L1; Sat, 16 Mar 2024 07:01:12 +0200
Received: from [41.144.0.193] (helo=localhost.localdomain)
	by www31.flk1.host-h.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rlM4v-00048C-Es; Sat, 16 Mar 2024 06:55:29 +0200
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
Subject: [PATCH 14/14] mips: dts: ralink: mt7621: reorder the attributes of the root node
Date: Sat, 16 Mar 2024 06:54:42 +0200
Message-Id: <20240316045442.31469-15-justin.swartz@risingedge.co.za>
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
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT8+RqckuubhByQktCv4mdbIPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wPY5yY5vX9MqMW2dd4bQescfggEolMHSR1Me+1tLQd/4/M
 684FXPwRt/ItN/QGHZWwYVP/cCt8Z7AC3QZraAAXGOt0uV2bCpZmMTDaVY6o43+4/UA7yKh3fsRx
 FRwz3BBjyk7zbazyOxi/UqYNqAkRRGBP0VCgd4sTxz5Nt/DkcKfPy9Occ20k9TJ7Nj73O0V9NPjB
 nDE1daoPH54M/DHR5hr5ConJQfcb9SHvDRICkaHkmqj+K0XGa5SFpMYJI0DpfOOu7mUz0fsyGD6a
 bRQ+0H7Q2OEpckvWJAOmdJd77Z9vwc+QHB+X+u7aTqYHtT1NFG5qXEfeIX239vWfI6H8t9z6MXWg
 ZYbrkExtRMjfc/Em1xUk+uitP3ztfVUM86oAc60fMGKzOErxxj0B+NXHNlDo60GNfZ2F/yvXF5fp
 0YCObyJslD58xugMMZCpQQvGifDpq5EYH46qR+vFm9wC7ren9RtRNyYim5e3GD8LGX4whxLggZ+w
 3rysbgAyUKjvL2J0djuO4juAaA0bvabgXwvUJUc3Xwu/zqbuNWtRwhNYY2G2tNrvHYkEV3lqMP2o
 naNQbqJUPRwZtKOTN8gOLtBcNrQxKZYuPe8bdCyw79zlPbqLQkZr26Lcxdvj8cqI+CogZdOhX7v3
 ClXzrmMENhJLl6MBfhzHVBR0wHQZxzIUka7Uq615Mik1qzcz308HFwsY4DWIzjhTYXUG8GBZhle6
 F/kpBdN+oWjoATjEFDwcaiz0R34rhTN+GTbl4uS+pZovX9cex7Ac4fawcerGI7TrGXpM/B/M0BZd
 PfIU1BX7pZc1sE3vsz58auH/srM2fgZ9JmgLbj7sqoEiwv7LCxIiAE5ODMnmwjvj2589zjbyZCiM
 WpBpW8YvoIIqmZcWhL/r/eFjMjJnMHeiAPOVAT1rE1/vP68Bb4z3v3h3gCdXrv2+9GnNX30LKqXb
 fwFKgm/rnYBl+Mj5KqOl6Jzub/f3QhLRbOgisvi5VU9eNBtgo6zjiatjNO/pnMCjuIvXs/AyV/Ns
 URB/R+FlEHyAzksgfaRvdgw0WK34QWnzHHMcN6qoXPjenLhIOF1oeRYbjF1Hp647mOWoQlc3hL3c
 ZMexQ8VxpTDmnfa+pzT1vc+lfykhMHKZiewMI9ChBgZ4u/m4iBmYb1/LCV4/EuVHup06w3Vwxf9C
 F7D6LKKRTfdjzQ6YC7Heg3Xf7O1TOd6RcY/MXB8eEq3bCN2QohZvyS03iBmgsz450Kmjd3fGV6q0
 gQPmnT5g6Jz1Dgv4IPigGR48CFzhtwOWD733mMxYIbtf63VNbf0lrvssY+k7AHGi1NevGWTo2+h8
 Lhk4HCeZR7ymlGVRtthBJ2y8A5arx6JItKpFaUNPGMMlvbMX0nyK1NiAJ0y2Qvvn6ds6mor35w4f
 SfHzQbABJfgy21HclcZkPRq7NhoxyMwqi8Q23Rgadfh5T5n5D4OHHpbEIgsllZKWnzc5M5WlNtVJ
 qo05MS+4ayUpOtEhdxekWDmK9g==
X-Report-Abuse-To: spam@antispamquarantine.host-h.net

Move the compatible attribute of the DTS root node to first place.

Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
---
 arch/mips/boot/dts/ralink/mt7621.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
index 284811f32..0704eab4a 100644
--- a/arch/mips/boot/dts/ralink/mt7621.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
@@ -5,9 +5,10 @@
 #include <dt-bindings/reset/mt7621-reset.h>
 
 / {
+	compatible = "mediatek,mt7621-soc";
+
 	#address-cells = <1>;
 	#size-cells = <1>;
-	compatible = "mediatek,mt7621-soc";
 
 	cpus {
 		#address-cells = <1>;
-- 



