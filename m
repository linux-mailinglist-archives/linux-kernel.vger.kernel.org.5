Return-Path: <linux-kernel+bounces-54851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D511084B47D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 140281C23147
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C38132C0A;
	Tue,  6 Feb 2024 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EQ5Sh+fJ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D655F132489;
	Tue,  6 Feb 2024 12:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221047; cv=none; b=JFYPQ5sGSCJYn1X/ODfvGQf8pbFemLuVEh62dg8GfHr1CVPYwDqT2F/cU4phAY7nFOdFYbt3QozwpTFiayNHSbLQoRMD5hWthA4RSsOsYn/lMy7Ar6N4LLuIrl4MDNNLSmhhYfPaTw7pJQrye1tbnB6VsWdFoKWQ2r/iWtNkM2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221047; c=relaxed/simple;
	bh=EiKdr/c9u9JrjmRxZthlmQfwVXETFnQKLUqxsjuilV0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=llkTbHR3sRnwO8ISIEjXfXiMN0oxNmXMm5e45MeCDRddHF1fSjFHOaQoirL9DLsUpjtSs6eDSDGEMo3jBCx9NrEA4whtqoNlMmeDHzQti9QAA98SxFLZ9kBjuUsbz8D0rJsbbFd9qsO4LDFCY2/aXVCi+iJR96OkcbLiwHwbE2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EQ5Sh+fJ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707221045; x=1738757045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EiKdr/c9u9JrjmRxZthlmQfwVXETFnQKLUqxsjuilV0=;
  b=EQ5Sh+fJZrqFpLaN/7z7D6St+zNk7XEyrXkDxggYJ659dV6gnxxP9JhF
   8m4ItOkqzRD4jk43DAvBKaocaqj23IFe2BRzN2RlBY8YDyEdEDXFQnhJQ
   vTHJBaJ+R4n1npID2SS2M5VB7uZ5LOOiquOUxzIV8ja/rnBhO65pP0hDM
   Xd+t8u7JKb1Ji19BkBx658pIMS9yxfVEiY4bUm2FJCjVdu3sL/UN+SlHE
   TixFhlGKObirkOLkcT6Ni5cnQUsWVWCBxwp2qKqSYLTlhY1FsvhU/ObGh
   G8xo+x6sSfP6HGDgvaOv6JIvjT6sJkMyvyz+rPWQ6SOwXqbBTYooJkJZb
   g==;
X-CSE-ConnectionGUID: /iuDP2QxSliEsbGRCUpaQw==
X-CSE-MsgGUID: v3sBQFHaQxKUz4RPHrKjVw==
X-IronPort-AV: E=Sophos;i="6.05,247,1701154800"; 
   d="scan'208";a="17200240"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Feb 2024 05:03:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 05:03:40 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 6 Feb 2024 05:03:38 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v3 4/8] ARM: dts: microchip: sama5d27_wlsom1: Add power-supply property for sdmmc1 node
Date: Tue, 6 Feb 2024 14:03:18 +0200
Message-ID: <20240206120322.88907-5-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206120322.88907-1-mihai.sain@microchip.com>
References: <20240206120322.88907-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The sdmmc1 controller is powered from 3.3V regulator.
Add vmmc-supply and vqmmc-supply properties to sdmmc nodes.
The sdmmc controller from SAMA5D2 MPU has support for
IO voltage signaling/switching required by the UHS sd-card.
In order to avoid the issues from the tuning procedure required by
the UHS cards, keep the vqmmc at 3V3 to use the sd high-speed mode.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
index 4617805c7748..96819ea24cbd 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
@@ -368,6 +368,8 @@ &sdmmc1 {
 	no-1-8-v;
 	non-removable;
 	bus-width = <4>;
+	vmmc-supply = <&vdd_3v3>;
+	vqmmc-supply = <&vdd_3v3>;
 	status = "okay";
 
 	wilc: wifi@0 {
-- 
2.43.0


