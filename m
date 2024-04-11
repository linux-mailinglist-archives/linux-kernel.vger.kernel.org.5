Return-Path: <linux-kernel+bounces-139989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8E98A09FE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B158D1C22700
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0961D1448E3;
	Thu, 11 Apr 2024 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pycnh6j4"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEB613FD7B;
	Thu, 11 Apr 2024 07:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820894; cv=none; b=eEqQcT6Ccme6G2bUzE0aObhMWiHH7JUtm5btz3BSBcXeI3JN4dPypc/hXFir7dmwwqrjs3s9S/8v84O9zaxY5hGKCwmNj+Eh7JiHfwk6m5Lw6PxeMsLN3l8Uvae1vRZop4ngy+/kPKc9U2Ksm0n0p26PkL1AfVfxawOf448LhRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820894; c=relaxed/simple;
	bh=dC/UUzAe+l4/nCTiw9wUyVrJ0rABADq2vofU68EWSTA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vu1UDYqOGtmBszTBNIsCPRAGIXtmYqrOPVINwVdlngeKl996gaDn9Ezgh2vZBUomtiWjLft8h6cCVpaWKjyG8eWOV1eGhfBUONv3fHm+X7OMtNBhvk05HLgIIc26mgt3H2ndJ3wrxFa/84MmAhIC0hWxc4EdTjEP+vggkLNasLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pycnh6j4; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712820892; x=1744356892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dC/UUzAe+l4/nCTiw9wUyVrJ0rABADq2vofU68EWSTA=;
  b=pycnh6j47Y53B/LwEUPIsaKcp6cAPdURGiozpmgC1Pf18UabY706NWp3
   yiUi1FOc921LXTPGU6nv8OY9v25u+ENn9iBuM26XjtMmxFDSUQteF0sCx
   6h7Ruefsr1T8Icm+8b8Ds2WdOFRi9INdQYZJBn2VqG+3AipBIPCludjas
   WvFPCT8fzYoZjgtRN3n2seGYuYpg913bC2WIBIWtwgrOerSOmDXm5jsVu
   wmyX3a7zZtdfNLnvrRq+O3GFBLQKZetxPo+GJhII6gl/qNJ+FRQ02GB1s
   +5tj0J/sqtwVcC85TApS7S5h9aSo1khTQeatxzAOkT1LbMYkmOeqzS0Xe
   g==;
X-CSE-ConnectionGUID: dQ5jbtg2Q1GDLCjGLtSnbQ==
X-CSE-MsgGUID: bUU5TWokT+eQUmZl1kpuLA==
X-IronPort-AV: E=Sophos;i="6.07,192,1708412400"; 
   d="scan'208";a="20534675"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 00:34:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 00:34:39 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 00:34:37 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 12/13] ARM: dts: microchip: sama5d4_xplained: Remove the empty line 247
Date: Thu, 11 Apr 2024 10:33:52 +0300
Message-ID: <20240411073353.3831-13-mihai.sain@microchip.com>
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

Remove the empty line 247 from gpio-keys node.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama5d4_xplained.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/microchip/at91-sama5d4_xplained.dts
index 95d701d13fef..a4c71dd96738 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d4_xplained.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d4_xplained.dts
@@ -244,7 +244,6 @@ rootfs@800000 {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_key_gpio>;
 
-- 
2.44.0


