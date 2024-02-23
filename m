Return-Path: <linux-kernel+bounces-77990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCB1860DC7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADF9282AF3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B135B5914E;
	Fri, 23 Feb 2024 09:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ag5f4FES"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F306F5A78C;
	Fri, 23 Feb 2024 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708679809; cv=none; b=R5B086OmRpDGsAqCNKSdHW3ZEtNzzhFMysEKWS5nIPIGknDUpsCXid5Elx3fnUczJZHEnW4p0S3hQzJJ04iPyqJz0LXCx+B4dZGuADfydvqhJyr7a+tyGw7KUA0IsGC4cK05CmFK00ofuG6KydRXL0moZLm6/xKbSnCMx1KEjig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708679809; c=relaxed/simple;
	bh=YoF3dk31A/j0uSO9Qix6SS7BWhxzO8062EL/EiHfj10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=FViyXaFk2aecbAvhko3xfXOtuFKBIQN+cscteTz4+UXUJsci/dOa1IWYy/J2Vaani88AgcsCwBxmjZrKvKBiSQtRdw6gwKYjoIlrXaMNiWjGVQkd9dEVqw81ahC1xqwRQOhqKJKOg6lOYn+g7B9zhhD2X4vvhBXPZowcCqWX3k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ag5f4FES; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708679807; x=1740215807;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=YoF3dk31A/j0uSO9Qix6SS7BWhxzO8062EL/EiHfj10=;
  b=ag5f4FESYxXUCgdjJ3EZ1q6PlfahEwIXje9L3cXkk5opQzappK9jAN8v
   uAWp/7ddtcExJayDjW3a63UlsosQlxPtYDv7dTJBCbn8/T9aNZm7lTqV3
   TiYhnwHE+0VpIoEsdc5HtJIXSeeGV2tDDHyS0C9l86UA9mtc3IzaA2IWL
   MZPdU7IQlBSOk9AT8qxLyYWqAwpIk1QV9xXKjg8vm0jqiJypgfdLF/m6H
   0+5y2zSInOi+a+DFwLNxV639N5czZNfXWDJIt8f8KTsyN0axB8Xk4HEEX
   LepVD42ksFWW5zgkfOITvyQqPhehYUkRPKHJgq+gueVTK0IidDm4MI+Cq
   w==;
X-CSE-ConnectionGUID: ELdSTgfdS3639c6bp/k3lg==
X-CSE-MsgGUID: cDpuJKGzRdesnCVedCGZ9Q==
X-IronPort-AV: E=Sophos;i="6.06,179,1705388400"; 
   d="scan'208";a="16715320"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 02:16:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 02:16:23 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 23 Feb 2024 02:16:18 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Fri, 23 Feb 2024 14:46:22 +0530
Subject: [PATCH v2 1/2] ARM: dts: microchip: sama7g5: add sama7g5
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240223-b4-sama5d2-flexcom-yaml-v2-1-7e96c60c7701@microchip.com>
References: <20240223-b4-sama5d2-flexcom-yaml-v2-0-7e96c60c7701@microchip.com>
In-Reply-To: <20240223-b4-sama5d2-flexcom-yaml-v2-0-7e96c60c7701@microchip.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, "Lee
 Jones" <lee@kernel.org>, Kavyasree Kotagiri
	<kavyasree.kotagiri@microchip.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Balakrishnan Sambath
	<balakrishnan.s@microchip.com>
X-Mailer: b4 0.13.0

Add sama7g5 flexcom specific compatible in DT with fallbacks.

Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7g5.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/sama7g5.dtsi b/arch/arm/boot/dts/microchip/sama7g5.dtsi
index 269e0a3ca269..6496a4ca376f 100644
--- a/arch/arm/boot/dts/microchip/sama7g5.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7g5.dtsi
@@ -698,7 +698,7 @@ sha: crypto@e1814000 {
 		};
 
 		flx0: flexcom@e1818000 {
-			compatible = "atmel,sama5d2-flexcom";
+			compatible = "microchip,sama7g5-flexcom", "atmel,sama5d2-flexcom";
 			reg = <0xe1818000 0x200>;
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 38>;
 			#address-cells = <1>;
@@ -723,7 +723,7 @@ uart0: serial@200 {
 		};
 
 		flx1: flexcom@e181c000 {
-			compatible = "atmel,sama5d2-flexcom";
+			compatible = "microchip,sama7g5-flexcom", "atmel,sama5d2-flexcom";
 			reg = <0xe181c000 0x200>;
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 39>;
 			#address-cells = <1>;
@@ -747,7 +747,7 @@ i2c1: i2c@600 {
 		};
 
 		flx3: flexcom@e1824000 {
-			compatible = "atmel,sama5d2-flexcom";
+			compatible = "microchip,sama7g5-flexcom", "atmel,sama5d2-flexcom";
 			reg = <0xe1824000 0x200>;
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 41>;
 			#address-cells = <1>;
@@ -791,7 +791,7 @@ tdes: crypto@e2014000 {
 		};
 
 		flx4: flexcom@e2018000 {
-			compatible = "atmel,sama5d2-flexcom";
+			compatible = "microchip,sama7g5-flexcom", "atmel,sama5d2-flexcom";
 			reg = <0xe2018000 0x200>;
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 42>;
 			#address-cells = <1>;
@@ -817,7 +817,7 @@ uart4: serial@200 {
 		};
 
 		flx7: flexcom@e2024000 {
-			compatible = "atmel,sama5d2-flexcom";
+			compatible = "microchip,sama7g5-flexcom", "atmel,sama5d2-flexcom";
 			reg = <0xe2024000 0x200>;
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 45>;
 			#address-cells = <1>;
@@ -911,7 +911,7 @@ tcb0: timer@e2814000 {
 		};
 
 		flx8: flexcom@e2818000 {
-			compatible = "atmel,sama5d2-flexcom";
+			compatible = "microchip,sama7g5-flexcom", "atmel,sama5d2-flexcom";
 			reg = <0xe2818000 0x200>;
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 46>;
 			#address-cells = <1>;
@@ -935,7 +935,7 @@ i2c8: i2c@600 {
 		};
 
 		flx9: flexcom@e281c000 {
-			compatible = "atmel,sama5d2-flexcom";
+			compatible = "microchip,sama7g5-flexcom", "atmel,sama5d2-flexcom";
 			reg = <0xe281c000 0x200>;
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 47>;
 			#address-cells = <1>;
@@ -959,7 +959,7 @@ i2c9: i2c@600 {
 		};
 
 		flx11: flexcom@e2824000 {
-			compatible = "atmel,sama5d2-flexcom";
+			compatible = "microchip,sama7g5-flexcom", "atmel,sama5d2-flexcom";
 			reg = <0xe2824000 0x200>;
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 49>;
 			#address-cells = <1>;

-- 
2.25.1


