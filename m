Return-Path: <linux-kernel+bounces-54852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A43A84B47E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CEA11C21428
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67C3132C27;
	Tue,  6 Feb 2024 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YZxahTgh"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65069131E4E;
	Tue,  6 Feb 2024 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221047; cv=none; b=LnTpiiSzVzu7i4FoAbFhUw8DGPozu2ysyS7o8iqSE+NX0Z+sD9r0M5rw/Q6q0hgWufev7p0FLbZ/I4WqZpwsj1rlGtwDunjJjcoPxZ4msoWdel/T1hLdS1kAlsoaRAYT1Pb9ZSgQZkUKCPlBoAF1qtoNkReJBHwqzKG3uvItvZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221047; c=relaxed/simple;
	bh=uuhzD7h2SKOvmlK9PXKVWDeAFZG64lM+lbWLD+e9xpQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QaUbiyZIf1jkJmPzi4F30LFklXeOg2ZIHr59s+SGr0mRmajMsmgtsSeMifuZX35t8qG02LqabiFF2ZeKHd5xLcPqAuOpopNupNyfTReUl1mbvGZyc+dxDug06revZEVZcpPE8z8sTCu8Kqcsq/lXWwj4pppph5tghP/zvlL5cK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YZxahTgh; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707221046; x=1738757046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uuhzD7h2SKOvmlK9PXKVWDeAFZG64lM+lbWLD+e9xpQ=;
  b=YZxahTghDOG9+0Ox+jRyWZ3YAdIiSs6XscO0y/NPlFtp1e7Vkqn54k5Y
   g3I25LwI4gaFcOkXvTE2lgIr6rPiz+IvNWhXRvCrDZOdlwHlct09rjN5f
   0i/lSGY9Kw9B02GVYpF4e/636wjy/RzcS0ClPU0m79G1piivnYUHzmzqc
   6EPkD0sWsLYEQPLvdhrRq0JHrYPPchrQEVk9wD4Hi5N3iGKveJazM+E1o
   /OoHsCV0ICU0NrH8EFSzhpdKLBGb4t5moH1cg8Q1ij+y/Dht4caLdCYZ1
   Ki6SYFGT1pZvGawkEOyeLlNeL5EgftsPje23B1mn+w9/QVct1yb4gREJb
   Q==;
X-CSE-ConnectionGUID: /iuDP2QxSliEsbGRCUpaQw==
X-CSE-MsgGUID: aqlGfhU5TlGcsgRLZZ5F4w==
X-IronPort-AV: E=Sophos;i="6.05,247,1701154800"; 
   d="scan'208";a="17200241"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Feb 2024 05:03:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 05:03:43 -0700
Received: from virtualbox.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 6 Feb 2024 05:03:40 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v3 5/8] ARM: dts: microchip: sama5d27_wlsom1_ek: Add power-supply property for sdmmc0 node
Date: Tue, 6 Feb 2024 14:03:19 +0200
Message-ID: <20240206120322.88907-6-mihai.sain@microchip.com>
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

The sdmmc0 controller is powered from 3.3V regulator.
Add vmmc-supply and vqmmc-supply properties to sdmmc0 node.
The sdmmc controller from SAMA5D2 MPU has support for
IO voltage signaling/switching required by the UHS sd-card.
In order to avoid the issues from the tuning procedure required by
the UHS cards, keep the vqmmc at 3V3 to use the sd high-speed mode.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
index 15239834d886..7b36e1970bb7 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
@@ -199,6 +199,8 @@ &sdmmc0 {
 	bus-width = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdmmc0_default>;
+	vmmc-supply = <&vdd_3v3>;
+	vqmmc-supply = <&vdd_3v3>;
 	status = "okay";
 };
 
-- 
2.43.0


