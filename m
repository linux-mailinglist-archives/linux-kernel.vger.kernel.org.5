Return-Path: <linux-kernel+bounces-22307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52856829C0F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE2871F24AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8804B5D4;
	Wed, 10 Jan 2024 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PV0oozhR"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703374A9A8;
	Wed, 10 Jan 2024 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40AE97xm082833;
	Wed, 10 Jan 2024 08:09:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704895747;
	bh=po3UiSglZdWYsDN1/s3YWLTYlpjeHOvee1PiW6JaQsU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=PV0oozhRR420U4xtP2Dpq9PJu5rZqHzbY87LsrR9eTGqxmWKtvveW98lUoP8HRAiY
	 Juv48WZdFX6V5qORyrTzm+iFKLjn8qiU7Px600cG98gfxAA2fruzd6VJSM6KUNf0o9
	 8lJTOACbkj2foOfFaB6SAF9btyIul/vkbnp2pvM8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40AE97SW098351
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Jan 2024 08:09:07 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Jan 2024 08:09:07 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Jan 2024 08:09:07 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40AE96C5025520;
	Wed, 10 Jan 2024 08:09:06 -0600
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 12/16] arm64: dts: ti: k3-serdes: Add MIT license along with GPL-2.0
Date: Wed, 10 Jan 2024 08:08:59 -0600
Message-ID: <20240110140903.4090946-13-nm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110140903.4090946-1-nm@ti.com>
References: <20240110140903.4090946-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Modify license to include dual licensing as GPL-2.0-only OR MIT
license for SoC and TI evm device tree files. This allows for Linux
kernel device tree to be used in other Operating System ecosystems
such as Zephyr or FreeBSD.

While at this, update the GPL-2.0 to be GPL-2.0-only to be in sync
with latest SPDX conventions (GPL-2.0 is deprecated).

While at this, update the TI copyright year to sync with current year
to indicate license change.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-serdes.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-serdes.h b/arch/arm64/boot/dts/ti/k3-serdes.h
index 21b4886c47ba..a011ad893b44 100644
--- a/arch/arm64/boot/dts/ti/k3-serdes.h
+++ b/arch/arm64/boot/dts/ti/k3-serdes.h
@@ -1,8 +1,8 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
 /*
  * This header provides constants for SERDES MUX for TI SoCs
  *
- * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #ifndef DTS_ARM64_TI_K3_SERDES_H
-- 
2.43.0


