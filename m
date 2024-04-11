Return-Path: <linux-kernel+bounces-139982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 990478A09F6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27ABDB29696
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B381B13FD9F;
	Thu, 11 Apr 2024 07:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nxIFpaW1"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3600F13E054;
	Thu, 11 Apr 2024 07:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820892; cv=none; b=ab0GegEfp6LxtmpURLKdJIWwgifYEgGCdppAAJRQ+L/xZ1vb6lW21fw63hZzcJ4PTF9ODwoTmQUsaxR6I/Ty3HUm2Mx7WAb+EHjEvdM1e13gtFnXvWZ5QfcYud/JKFdJTnOHw4QmKwAfQPJgdm2Upd+dIRgnLaRw+yp9J6q2QDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820892; c=relaxed/simple;
	bh=/SPCX2F9y/UoY3CU+K/fQTJBkLQWFHUwk0mb9NCfbu0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fLMR5BKfnVxsEMUjlPIwjuU0xneBUHYxpo4FGKwsyjWwASAwHykPoUp9YacublmTr68ZQT+9Q0iSIfBZD8dOnk8kZwj83SckK8OAVmwUucocIYSpQSxqEFlcHvqIo1T32Ysb1JDrMmenUXKGSY4gBghagKMpm9dADpAE8jMRbMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nxIFpaW1; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712820890; x=1744356890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/SPCX2F9y/UoY3CU+K/fQTJBkLQWFHUwk0mb9NCfbu0=;
  b=nxIFpaW1n5u9zZwWscT3ixy6VBZveAk4E0RI5s+j/c+JTElkXLJZGlR/
   Ta1G9B8/+wBnmj3IKhtQPsZYrc2HSiH4ncN0thDWUxIyLBFM3mtXfANob
   y3z2XutMfad+Rij7XiXkfxKqmRXdAI49DK/jZAeUmuB6b6H4Ailq2aU6/
   3CB9Q+wWwXcEcgLMSaqalGOs/6ojyQNTXTnkjGmPfsubaxs2y33DvNU/v
   hMh4w0WpNzp+zl771SCGmN9P9ev7DsNypWjRXhyvaPIB3llYBlA3Ib0cg
   c0QinBos8LPilb+GBV8mV9PQaRBkWt36wvzKjU7Va2iUyEoaY2Afq8bBn
   w==;
X-CSE-ConnectionGUID: jDRmTUiXRgK//h330KmRHg==
X-CSE-MsgGUID: y8CdosgzQnaA6IFrC2I87w==
X-IronPort-AV: E=Sophos;i="6.07,192,1708412400"; 
   d="scan'208";a="21068909"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 00:34:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 00:34:17 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 00:34:15 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 03/13] ARM: dts: microchip: sama5d2: Remove the empty lines 47 and 63
Date: Thu, 11 Apr 2024 10:33:43 +0300
Message-ID: <20240411073353.3831-4-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411073353.3831-1-mihai.sain@microchip.com>
References: <20240411073353.3831-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Remove the empty line 47 from etb node.
Remove the empty line 63 from etm node.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/sama5d2.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/sama5d2.dtsi b/arch/arm/boot/dts/microchip/sama5d2.dtsi
index 5f8e297e19ed..7aea6c2368a2 100644
--- a/arch/arm/boot/dts/microchip/sama5d2.dtsi
+++ b/arch/arm/boot/dts/microchip/sama5d2.dtsi
@@ -44,7 +44,6 @@ pmu {
 	etb@740000 {
 		compatible = "arm,coresight-etb10", "arm,primecell";
 		reg = <0x740000 0x1000>;
-
 		clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 		clock-names = "apb_pclk";
 
@@ -60,7 +59,6 @@ etb_in: endpoint {
 	etm@73c000 {
 		compatible = "arm,coresight-etm3x", "arm,primecell";
 		reg = <0x73c000 0x1000>;
-
 		clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 		clock-names = "apb_pclk";
 
-- 
2.44.0


