Return-Path: <linux-kernel+bounces-120659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D6D88DB1B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3D34B23793
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C19524D9;
	Wed, 27 Mar 2024 10:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vErhovuz"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168D048CC6;
	Wed, 27 Mar 2024 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711534706; cv=none; b=Ho7BdySgW+q5pN1zGKR/KnBtsn2POjPe5k1RJZuYVXGqYKbgOaNoB/uOIpWNFZEq9i9ls4nEInYreNWna3yLu37g6DR7hTvVXYLlJbOgoU+7zYGoOQfexoF3eSfEIfgrlgoH985DL3YmNAYc1mIi6gEFczv7i0qvy/Y96ok2oQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711534706; c=relaxed/simple;
	bh=FbQFohIcQhdcJ8OymS2bi8N+9kuCh4E7hphlH7j7T3w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qy3tiIi8oVwDEIwdmaL7Ow2sS/clmhrijB8wPukGmBqKMlpSj54wVXpfIQcDVEGY1SVg8/NKA0cdSjgcPJrEk5w04u9Klm4/QSEp9JdvF512gx54SfMWj9s3McblL5cXLTq5INZuCInTAeHWQ3yGJBhjIRqHrLeez88KzMMkcmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vErhovuz; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1711534705; x=1743070705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FbQFohIcQhdcJ8OymS2bi8N+9kuCh4E7hphlH7j7T3w=;
  b=vErhovuzS65JNVAxEYy3+2lG9JVxhPIva2TSC/mg/zvO0pmFhijAtjHS
   D+25vt/Vmt8gtPVY0gKLU/P814ZaU6I6cyIluzv1eFP0RVEdqqJTrBHll
   S7ICG5DGDrlyarjYC+kpF1kJuF3zb5yztu/g8cYDCnz4tW8ZQ6EDV0O0o
   utJfEgjKkdv2mhiZ691taETtSTGdWz0LJuuxEGn++PepX1T+yFWPSClqh
   XHTXnFNU6XxczN221hdlnSrG6MRRFn3R3i2vCZ/+C8xv5grw7BnWWpC8F
   1gr67mCxyA9WY8V1SjbpZND2Sg0qbdh1DslwgWEyrsBo6/TCVGWHo5pGJ
   Q==;
X-CSE-ConnectionGUID: calzwGTlQgCl6fVaUG6ALA==
X-CSE-MsgGUID: Kfo3bleVRRCTAD/kyczoKg==
X-IronPort-AV: E=Sophos;i="6.07,158,1708412400"; 
   d="scan'208";a="18378695"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Mar 2024 03:18:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 03:17:53 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 03:17:51 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<lgirdwood@gmail.com>, <broonie@kernel.org>, <andrei.simion@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 5/7] ARM: dts: microchip: sama7g5ek: Update the node names from pmic-regulators
Date: Wed, 27 Mar 2024 12:17:22 +0200
Message-ID: <20240327101724.2982-6-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327101724.2982-1-mihai.sain@microchip.com>
References: <20240327101724.2982-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Update the node names from pmic-regulators in order to match
the datasheet and driver namings for buck regulators.
Using BUCK1-4 as node names is consistent with the node naming rules.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama7g5ek.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts b/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
index 217e9b96c61e..5a9b8b6dd0df 100644
--- a/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
@@ -242,7 +242,7 @@ mcp16502@5b {
 			status = "okay";
 
 			regulators {
-				vdd_3v3: VDD_IO {
+				vdd_3v3: BUCK1 {
 					regulator-name = "VDD_IO";
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
@@ -262,7 +262,7 @@ regulator-state-mem {
 					};
 				};
 
-				vddioddr: VDD_DDR {
+				vddioddr: BUCK2 {
 					regulator-name = "VDD_DDR";
 					regulator-min-microvolt = <1350000>;
 					regulator-max-microvolt = <1350000>;
@@ -283,7 +283,7 @@ regulator-state-mem {
 					};
 				};
 
-				vddcore: VDD_CORE {
+				vddcore: BUCK3 {
 					regulator-name = "VDD_CORE";
 					regulator-min-microvolt = <1150000>;
 					regulator-max-microvolt = <1150000>;
@@ -303,7 +303,7 @@ regulator-state-mem {
 					};
 				};
 
-				vddcpu: VDD_OTHER {
+				vddcpu: BUCK4 {
 					regulator-name = "VDD_OTHER";
 					regulator-min-microvolt = <1050000>;
 					regulator-max-microvolt = <1250000>;
-- 
2.44.0


