Return-Path: <linux-kernel+bounces-120657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5AA88DB16
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6858EB23887
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF474D9E1;
	Wed, 27 Mar 2024 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZekZGj7s"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448F3487A5;
	Wed, 27 Mar 2024 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711534704; cv=none; b=HcD4QEgxtZ4PqVELRU53unmWwV3qqpZ6foIO9hMuxWAMMbMVwvfjKPoRqUagi6igllXYEwF5rbXXzoI387U/FKoxr4YA6gTunAP7M24yP/8D+CRfCv7WdALztILPX8QPSj2hEqn1K50e+x98JBp/qFcu9UQiYWn14yaZP55AMU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711534704; c=relaxed/simple;
	bh=wD2nTcpMdJZrzZufqmtVM7xTKD12zXfm5p9LDsV06bA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XK9S8aznJBWwUG/DtyLLRZDe+kXGem7eaSQ77iFVH2QOOMgv0FWhh6mNm7tqsujyN99/XJIrKVpKQ+zvk1SrYc1rYo6qkLrFuPKNa6kL49AtDwbZFubiBbAAliRMaN8XEe0Xv/G3jWiSJn3wMjd7AJwzBP/+LLuBZLui/3dN2wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZekZGj7s; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1711534704; x=1743070704;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wD2nTcpMdJZrzZufqmtVM7xTKD12zXfm5p9LDsV06bA=;
  b=ZekZGj7s97P7QV5G6hoQTRBbtZAqxX48es6KxZFfHs0zIZDm69PG0x2R
   5dlq5QSFU5PkzCp75JC+6beH3ZD8aCQDTmxS+E/c6Bqx39ZiVy0ITyQ7T
   wP0GKYs6OdMCDzkY0DbRwRX4P5e0y5qAkhCXNXULmfDVc4kQXvxdeMVGw
   iVjMVb0mHlPlM9HU+X0BBA2EuxmNV70HMLCoi93sVRN3qzFUtznvlV4n8
   xXvH4rE2w7ThjSHn5dEpW87q67n4Wb8RczZYvOyMD6/Qg4BFVXvZzBmmV
   6qU2mhhLD29w/oXv/Jbpy/syEU7fIo6iVWdHossw/TKZiSwFW36uFZ488
   w==;
X-CSE-ConnectionGUID: calzwGTlQgCl6fVaUG6ALA==
X-CSE-MsgGUID: LNxzxDpGQwKx1MJ2IQ3y4A==
X-IronPort-AV: E=Sophos;i="6.07,158,1708412400"; 
   d="scan'208";a="18378694"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Mar 2024 03:18:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 03:17:47 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 03:17:44 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<lgirdwood@gmail.com>, <broonie@kernel.org>, <andrei.simion@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 3/7] ARM: dts: microchip: sama5d2_icp: Update the node names from pmic-regulators
Date: Wed, 27 Mar 2024 12:17:20 +0200
Message-ID: <20240327101724.2982-4-mihai.sain@microchip.com>
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
 arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts b/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
index 999adeca6f33..f20de8180381 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
@@ -194,7 +194,7 @@ mcp16502@5b {
 			lpm-gpios = <&pioBU 7 GPIO_ACTIVE_LOW>;
 
 			regulators {
-				vdd_io_reg: VDD_IO {
+				vdd_io_reg: BUCK1 {
 					regulator-name = "VDD_IO";
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
@@ -213,7 +213,7 @@ regulator-state-mem {
 					};
 				};
 
-				VDD_DDR {
+				BUCK2 {
 					regulator-name = "VDD_DDR";
 					regulator-min-microvolt = <1350000>;
 					regulator-max-microvolt = <1350000>;
@@ -232,7 +232,7 @@ regulator-state-mem {
 					};
 				};
 
-				VDD_CORE {
+				BUCK3 {
 					regulator-name = "VDD_CORE";
 					regulator-min-microvolt = <1250000>;
 					regulator-max-microvolt = <1250000>;
@@ -251,7 +251,7 @@ regulator-state-mem {
 					};
 				};
 
-				VDD_OTHER {
+				BUCK4 {
 					regulator-name = "VDD_OTHER";
 					regulator-min-microvolt = <600000>;
 					regulator-max-microvolt = <1850000>;
-- 
2.44.0


