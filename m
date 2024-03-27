Return-Path: <linux-kernel+bounces-120658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AD288DB19
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19C7FB23697
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83244F5FD;
	Wed, 27 Mar 2024 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="I89VUz2x"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FD54AEFB;
	Wed, 27 Mar 2024 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711534706; cv=none; b=Q0XcIxDovhneMBcQcGZY3nmu+IumUbhTbsct7Duf8k2CRanmSfpJV42QMNs8nLzexVt3F5yTlKoa6ftWAVk/RKu4aaJc9EyWZp0Lx2lmD0B+dqJB3SUNnTvJKvXky9P8E9an412WJcqRkfQYZaLbaWEtZV9D4lRU3i0/wmJGlp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711534706; c=relaxed/simple;
	bh=p/0BBHnJr+FFftUotJoEcJBJoL48GuwYWP98R4CFmoQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DOhiUcMwZEmTthRBMWeUxaecSfg2AB4R8GrDSrJINIqAxhW8BgLRGW03RhaZfCRhbS+DKlC3Jg8FHKScgYvWkrFfTKZOwhpCp64ajAdh/8S25U2wJkkbwt3/qwPsHvL0SNfaXX9IEoNwTqTBl4sdSrMg08VspAZ2PUGQyWzS6TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=I89VUz2x; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1711534705; x=1743070705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p/0BBHnJr+FFftUotJoEcJBJoL48GuwYWP98R4CFmoQ=;
  b=I89VUz2xJRV0GK151mUk3ZrOqzf74yJYQS52w3k/o9Qc4qfZSwEmSkOy
   ruiJ8h4iNw/MyHvjA43j7y95/T/B2qQDmGbRfA97fo9lQif+3AKZNLNum
   QijrA7K6p+ewq1Ue3m78oBfIzI1RImS135OG28YiemgUy7210oGO2QN+k
   zhw7b4bSItEdJTRmZNwLO8M/vJTTlgOOpokmCBi0nLEQi96ATSW3sOTvO
   jLkY614Sn5PX39VkadRiYIVLG+7pqVv+GspFswF8zwMCn6v1g7kuy6Igb
   iVn0LR/3SGpTwA8BSxzRs9MrF+5qaRxfAzJUXvvTN5Kr75Mq5nU1SJTsb
   w==;
X-CSE-ConnectionGUID: calzwGTlQgCl6fVaUG6ALA==
X-CSE-MsgGUID: R3qN4wlUQN+db0QLsypdCg==
X-IronPort-AV: E=Sophos;i="6.07,158,1708412400"; 
   d="scan'208";a="18378697"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Mar 2024 03:18:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 03:17:56 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 03:17:54 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<lgirdwood@gmail.com>, <broonie@kernel.org>, <andrei.simion@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 6/7] regulator: dt-bindings: microchip,mcp16502: Update the node names from buck regulators
Date: Wed, 27 Mar 2024 12:17:23 +0200
Message-ID: <20240327101724.2982-7-mihai.sain@microchip.com>
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

Update the node names from buck regulators in order to match
the datasheet and driver namings for buck regulators.
Using BUCK1-4 as node names is consistent with the node naming rules.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 .../bindings/regulator/microchip,mcp16502.yaml         | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/microchip,mcp16502.yaml b/Documentation/devicetree/bindings/regulator/microchip,mcp16502.yaml
index 1aca3646789e..72a1f8a92949 100644
--- a/Documentation/devicetree/bindings/regulator/microchip,mcp16502.yaml
+++ b/Documentation/devicetree/bindings/regulator/microchip,mcp16502.yaml
@@ -34,7 +34,7 @@ properties:
     description: List of regulators and its properties.
 
     patternProperties:
-      "^(VDD_(IO|CORE|DDR|OTHER)|LDO[1-2])$":
+      "^(BUCK[1-4]|LDO[1-2])$":
         type: object
         $ref: regulator.yaml#
         unevaluatedProperties: false
@@ -70,7 +70,7 @@ examples:
             reg = <0x5b>;
 
             regulators {
-                VDD_IO {
+                BUCK1 {
                     regulator-name = "VDD_IO";
                     regulator-min-microvolt = <3300000>;
                     regulator-max-microvolt = <3300000>;
@@ -89,7 +89,7 @@ examples:
                     };
                 };
 
-                VDD_DDR {
+                BUCK2 {
                     regulator-name = "VDD_DDR";
                     regulator-min-microvolt = <1350000>;
                     regulator-max-microvolt = <1350000>;
@@ -108,7 +108,7 @@ examples:
                     };
                 };
 
-                VDD_CORE {
+                BUCK3 {
                     regulator-name = "VDD_CORE";
                     regulator-min-microvolt = <1150000>;
                     regulator-max-microvolt = <1150000>;
@@ -127,7 +127,7 @@ examples:
                     };
                 };
 
-                VDD_OTHER {
+                BUCK4 {
                     regulator-name = "VDD_OTHER";
                     regulator-min-microvolt = <1050000>;
                     regulator-max-microvolt = <1250000>;
-- 
2.44.0


