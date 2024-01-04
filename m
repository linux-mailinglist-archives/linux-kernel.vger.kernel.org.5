Return-Path: <linux-kernel+bounces-16719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CABD68242EA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560731F232CD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C42224DC;
	Thu,  4 Jan 2024 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="sZEd0/Ip"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223CB22337;
	Thu,  4 Jan 2024 13:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404BG7q8008005;
	Thu, 4 Jan 2024 14:44:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=4Xb/guP
	VNffz69iwgR6eg6cVtv2SHDElUbVJtlX0iAw=; b=sZEd0/IpcdQwa8fAKxNW01x
	0PsNSAo0aRzKjG8wyz216iXv5FYt+8+usw4gsTXpdNyUAkA3CvEbTqHnWdlLktPZ
	2fJ+hSwuGvFOOpk5vWumdNpfEmXGsmhlnyrhjdCIdvhZM8Lh8hFrnCWvH/3TFgqv
	a2VQ/XYwWV6b1FRhQ4fbovCZq9bUzlYMzmye/BuXy7su3wV5bNQwn75J6/d1rHRL
	STgoDFkSs5gTyRW8+G/DGEMt3ZALiRDwZwmr8cEYAGDttzF+gdacAMOefHz83pOX
	V3acnCXqH3snGO8oMrC9Lf62eDq49qHxthlEnE8IqR7BYvwJByZazzVEsSvGCAA=
	=
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vd9q1m8ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 14:44:46 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 65E7410002A;
	Thu,  4 Jan 2024 14:44:42 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 517BF22FA28;
	Thu,  4 Jan 2024 14:44:42 +0100 (CET)
Received: from localhost (10.252.5.254) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 4 Jan
 2024 14:44:41 +0100
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
Subject: [PATCH v3 0/4] Update STM DSI PHY driver
Date: Thu, 4 Jan 2024 14:44:30 +0100
Message-ID: <20240104134434.744497-1-raphael.gallais-pou@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_07,2024-01-03_01,2023-05-22_02

This patch series aims to add several features of the dw-mipi-dsi phy
driver that are missing or need to be updated.

First patch update a PM macro.

Second patch adds runtime PM functionality to the driver.

Third patch adds a clock provider generated by the PHY itself.  As
explained in the commit log of the second patch, a clock declaration is
missing.  Since this clock is parent of 'dsi_k', it leads to an orphan
clock.  Most importantly this patch is an anticipation for future
versions of the DSI PHY, and its inclusion within the display subsystem
and the DRM framework.

Last patch fixes a corner effect introduced previously.  Since 'dsi' and
'dsi_k' are gated by the same bit on the same register, both reference
work as peripheral clock in the device-tree.

---
Changes in v3:
	- Fix smatch warning (disable dsi->pclk when clk_register fails)

Changes in v2:
	- Added patch 1/4 to use SYSTEM_SLEEP_PM_OPS instead of old macro
	  and removed __maybe_used for accordingly
	- Changed SET_RUNTIME_PM_OPS to RUNTIME_PM_OPS

Raphael Gallais-Pou (3):
  drm/stm: dsi: use new SYSTEM_SLEEP_PM_OPS() macro
  drm/stm: dsi: expose DSI PHY internal clock
  arm: dts: st: fix DSI peripheral clock on stm32mp15 boards

Yannick Fertre (1):
  drm/stm: dsi: add pm runtime ops

 arch/arm/boot/dts/st/stm32mp157.dtsi          |   2 +-
 arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts |   2 +-
 arch/arm/boot/dts/st/stm32mp157c-dk2-scmi.dts |   2 +-
 arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts |   2 +-
 arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts |   2 +-
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c         | 279 +++++++++++++++---
 6 files changed, 243 insertions(+), 46 deletions(-)

-- 
2.25.1


