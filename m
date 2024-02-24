Return-Path: <linux-kernel+bounces-79569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518B186244F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A6028282C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 10:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C6D3D75;
	Sat, 24 Feb 2024 10:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="XuZ0DvGR"
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9A622301;
	Sat, 24 Feb 2024 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.156.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708771045; cv=none; b=SbqPpsGaZLvGLuh8bvwJUiTda7w0t/4fSLUZrfp4N78nAoMH+asHKlaBocDGiA0RSpcMgrHgKKSLwiZbPK4lKHkiwBq2xAxvQzhnYg5redT25PR0ggUufRZT73geYf2CkKk1xmVDjhLiAiyOtSswGGtvhqKvNrsQN3jcvuL8P98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708771045; c=relaxed/simple;
	bh=fWqZNEar9N0goNDbvcwSQjOGSY3rI92CNJCz+cIZIDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xjy3g5GFTnpZgIt9zUc60q+9y7t6vph9qH6EUiMJzyldEynCYAqqY1fx6gH4KSvRgYRpMhal8mC4btHoCxQddEWq/OB9QWIgkvYShmpr26pkZT3SQ8JqLw6aYczarQFUtiM+0r071JNDP1afB13UelJgWP2Fo3j4w15ead4e0vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; spf=pass smtp.mailfrom=bewilderbeest.net; dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b=XuZ0DvGR; arc=none smtp.client-ip=71.19.156.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bewilderbeest.net
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:712b:6300::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 72D8A33F;
	Sat, 24 Feb 2024 02:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1708771041;
	bh=WAN0Rojvl/Ox9LSN3FFZ7ka8EkTa4ejvkvMOzuGgctA=;
	h=From:To:Cc:Subject:Date:From;
	b=XuZ0DvGR63N+RR4B7W1fM8PVo6V1ltV0vx5hyhT+cd9hr8wCNbrwSkelG9y9ZsFGq
	 OVha8HXII8JEw9Hg7FXCGiacGhQmR0PRUalZHl3YEPs+i8CdsJrH8+nzIt3c2sTAdR
	 CEPSCnXwtNPPgFNVyXSg8VdWAJ08hsCBmbV5YwbY=
From: Zev Weiss <zev@bewilderbeest.net>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>
Cc: Zev Weiss <zev@bewilderbeest.net>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: aspeed: Add vendor prefixes to lm25066 compat strings
Date: Sat, 24 Feb 2024 02:37:07 -0800
Message-ID: <20240224103712.20864-2-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to the way i2c driver matching works (falling back to the driver's
id_table if of_match_table fails) this didn't actually cause any
misbehavior, but let's add the vendor prefixes so things actually work
the way they were intended to.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts | 4 ++--
 arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts
index 4554abf0c7cd..9aa2de3723b5 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts
@@ -98,14 +98,14 @@ w83773g@4c {
 
 	/* IPB PMIC */
 	lm25066@40 {
-		compatible = "lm25066";
+		compatible = "ti,lm25066";
 		reg = <0x40>;
 		shunt-resistor-micro-ohms = <1000>;
 	};
 
 	/* 12VSB PMIC */
 	lm25066@41 {
-		compatible = "lm25066";
+		compatible = "ti,lm25066";
 		reg = <0x41>;
 		shunt-resistor-micro-ohms = <10000>;
 	};
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts
index 6600f7e9bf5e..e830fec0570f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts
@@ -14,7 +14,7 @@ efuse##n {					\
 
 #define EFUSE(hexaddr, num)							\
 	efuse@##hexaddr {							\
-		compatible = "lm25066";						\
+		compatible = "ti,lm25066";					\
 		reg = <0x##hexaddr>;						\
 		shunt-resistor-micro-ohms = <675>;				\
 		regulators {							\
-- 
2.43.2


