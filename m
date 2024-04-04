Return-Path: <linux-kernel+bounces-131452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A37898815
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 325741C21D32
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0907912883A;
	Thu,  4 Apr 2024 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="P26Ki+lk"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AFB7492;
	Thu,  4 Apr 2024 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234357; cv=none; b=txuNbBJA/YWOH+RucINrlf34QHc0SqJ26DrVZGXDZHN56NKDFC1vqAJGxiFO573V8u8v+cveQAHqdhOgrsOb6ZakG74Nwos5RdZwCiy5MpyuVNsl+ft0HMR/yCeboPT0u9glinOB6w/0n3qq0TE+gSFdO/aRispi2Ngt/uirFb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234357; c=relaxed/simple;
	bh=WFAQW4FEBR+8bt+oLYnOmpcc/VJfD74WIkGOvY7XBjk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LYCk/ucZOCP0MzBiYlNdeQRoreO2FaldSomOGh09UsZ715cx4IKAtSQWGl2rqiSVV+sgdSkccyePY9kFqsKGvXYjWFCWI99Z3+YaaEbN9mwL1jdBigspnzjoplRKAfqeda0th9TMRknIDzNJxGr1EN2XwcG7W5KqHJo9kMY5JYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=P26Ki+lk; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712234354; x=1743770354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WFAQW4FEBR+8bt+oLYnOmpcc/VJfD74WIkGOvY7XBjk=;
  b=P26Ki+lk062GgNKzXvJTNYcMI477ie5G6ber7B2+S+17cPQ5duSdhDiY
   LH7fY9Z/Hq/FHOAOYV90EajE2v1Qc04RQSEvv5eRb8P5ucsA+CC5dCiQ4
   YgT0h5ZY5RIfrvUGuJp7d+hUoATa04bdUmxBCtWn2X+Wc9wVX3ZwJTvfM
   FPUPm8MjHKfIE0bWKunw3xiho9PzAQe4bWKkZVF2Qgk/YowdzlJQjTliI
   xaF4sLeSz+NL4uX08PbEC7Whj3Bz851Jn+GbNhcN1mPLLO+w0gVuD7Yk6
   vp7KC6ZIiMfKTFXyld2LNxIRB2uG6MsABWo1qLxEMR72g/3TfU/Fmz+Bh
   w==;
X-CSE-ConnectionGUID: uj5RG1T5T4qn7m5+TvSDNg==
X-CSE-MsgGUID: K95RXrtMTGCTEsaeo8U6Nw==
X-IronPort-AV: E=Sophos;i="6.07,179,1708412400"; 
   d="scan'208";a="21393778"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Apr 2024 05:39:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 05:38:33 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 05:38:31 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<mihai.sain@microchip.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH v2 1/2] ARM: dts: microchip: at91-sama7g5ek: Replace regulator-suspend-voltage with the valid property
Date: Thu, 4 Apr 2024 15:38:23 +0300
Message-ID: <20240404123824.19182-2-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404123824.19182-1-andrei.simion@microchip.com>
References: <20240404123824.19182-1-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

By checking the pmic node with microchip,mcp16502.yaml#
'regulator-suspend-voltage' does not match any of the
regexes 'pinctrl-[0-9]+' from schema microchip,mcp16502.yaml#
which inherits regulator.yaml# So replace regulator-suspend-voltage
with regulator-suspend-microvolt to avoid the inconsitency.

Fixes: 85b1304b9daa ("ARM: dts: at91: sama7g5ek: set regulator voltages for standby state")
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
v1 -> v2:
- drop "boot" from title
- put in commit message a snippet with the warning to explain the change
---
 arch/arm/boot/dts/microchip/at91-sama7g5ek.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts b/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
index 217e9b96c61e..20b2497657ae 100644
--- a/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
@@ -293,7 +293,7 @@ vddcore: VDD_CORE {
 
 					regulator-state-standby {
 						regulator-on-in-suspend;
-						regulator-suspend-voltage = <1150000>;
+						regulator-suspend-microvolt = <1150000>;
 						regulator-mode = <4>;
 					};
 
@@ -314,7 +314,7 @@ vddcpu: VDD_OTHER {
 
 					regulator-state-standby {
 						regulator-on-in-suspend;
-						regulator-suspend-voltage = <1050000>;
+						regulator-suspend-microvolt = <1050000>;
 						regulator-mode = <4>;
 					};
 
@@ -331,7 +331,7 @@ vldo1: LDO1 {
 					regulator-always-on;
 
 					regulator-state-standby {
-						regulator-suspend-voltage = <1800000>;
+						regulator-suspend-microvolt = <1800000>;
 						regulator-on-in-suspend;
 					};
 
@@ -346,7 +346,7 @@ vldo2: LDO2 {
 					regulator-max-microvolt = <3700000>;
 
 					regulator-state-standby {
-						regulator-suspend-voltage = <1800000>;
+						regulator-suspend-microvolt = <1800000>;
 						regulator-on-in-suspend;
 					};
 
-- 
2.34.1


