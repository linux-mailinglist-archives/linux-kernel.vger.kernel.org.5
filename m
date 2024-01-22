Return-Path: <linux-kernel+bounces-32522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505EB835CA5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83B611C210ED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0FC21344;
	Mon, 22 Jan 2024 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kaSXSEE9"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A4739AC5;
	Mon, 22 Jan 2024 08:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912249; cv=none; b=t434mdWazaJ/luaxQ32NSMgCo2nortCAkW4DQIfMrWHpw++60uJwk1KpbDxZJncNDDUejqFX168v3ywnJYBExuY8AHfpoXHUjQhqb8ysUj4Dj7hs2UxSd13t2jWg4QpU8rccvouk2LSBLIrOdr2XfwbxwERrOCBVrdk+AJpjEac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912249; c=relaxed/simple;
	bh=Ia2hVk9eM5wQHbe/b7mdo2yOfz17oFqWIhOV8eIVvmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a6HP1KHn+9YIIJMF/ToR+hKNWzN9S9xlCL3Pkn5c0Qp0kd2Dc4kX2bH+ZB0llJH+KxRRZBtjsMJr/yG+ad+OL7rOIxgusKaWkqiTU8RZ28cwOkH2BJAs+SO9Xn4zuB5B9mfpSa7GxqwYuS1aCCD/97kviZftneMYIIf59DfB3Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kaSXSEE9; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705912248; x=1737448248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ia2hVk9eM5wQHbe/b7mdo2yOfz17oFqWIhOV8eIVvmI=;
  b=kaSXSEE9PqDNnQO3LWR697LJnXT+wu9ztHyRY7EOa5FDbCH3i9aCvONu
   qixbczHWPayL5jQ7KnAdJOEEiU6e2+NozpfWCg2oDaWNqroV9fgQZkmiX
   OC9R/ExoHCn+Ur0562GaKAup+PLmB4rAWkFsdRVS8R2cPz3XqvmcntWB4
   14qyoaGOZ/5JBZVTxA3gFybijc6l7dVpz517eyQOWO8bIsnpG1DNeGrp0
   1UkAXtBcBmkqcLXmrAMOKaufTJuq6tFO8CMjQOEkso1gz4nek6w6T/l4f
   CivhyDIQWWscfki8imjJ5Z68hRgrMNM/rGvByCpPnjeXLmNt88bN4zBQI
   A==;
X-CSE-ConnectionGUID: 3jDV5insTnecMVYu3SUMmw==
X-CSE-MsgGUID: tePGqSCBQ5mxl/OALj4PUg==
X-IronPort-AV: E=Sophos;i="6.05,211,1701154800"; 
   d="scan'208";a="15568768"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jan 2024 01:30:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 01:30:19 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 01:30:12 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <manikandan.m@microchip.com>, <dharma.b@microchip.com>,
	<andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
	<Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <linux4microchip@microchip.com>
Subject: [PATCH 3/3] MAINTAINERS: add SAM9X7 SoC's LVDS controller
Date: Mon, 22 Jan 2024 13:59:47 +0530
Message-ID: <20240122082947.21645-4-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240122082947.21645-1-dharma.b@microchip.com>
References: <20240122082947.21645-1-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add the newly added LVDS controller for the SAM9X7 SoC to the existing
MAINTAINERS entry.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a7c4cf8201e0..24a266d20df6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14230,6 +14230,14 @@ S:	Supported
 F:	Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
 F:	drivers/power/reset/at91-sama5d2_shdwc.c
 
+MICROCHIP SAM9x7-COMPATIBLE LVDS CONTROLLER
+M:	Manikandan Muralidharan <manikandan.m@microchip.com>
+M:	Dharma Balasubiramani <dharma.b@microchip.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Supported
+F:	Documentation/devicetree/bindings/display/bridge/microchip,sam9x7-lvds.yaml
+F:	drivers/gpu/drm/bridge/microchip-lvds.c
+
 MICROCHIP SOC DRIVERS
 M:	Conor Dooley <conor@kernel.org>
 S:	Supported
-- 
2.25.1


