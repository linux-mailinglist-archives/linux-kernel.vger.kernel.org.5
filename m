Return-Path: <linux-kernel+bounces-42556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D24A084030C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881FA1F2343A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3905915B;
	Mon, 29 Jan 2024 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="2GSlDyqc"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A045821B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706524934; cv=none; b=ivuRT9JkZZJJwI5vzA2x++DEHBcGC2CdVOyXFbWCsX6HCquBos3ty0SONo6yXlHaetRfGIg+IjQ+VwKBGJdUAA57xW1imOpVB1nCgDTxA7rFKBqGHDpD6BsvW0nDxbpEaNsOhzNklH58zZCZbNF/CItBDmRHpABOZhLoqIxOa/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706524934; c=relaxed/simple;
	bh=fvTMrxGTgQP5shcwR9YmUV+YxzR4KmUQp8IrSM1zMeA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hvsn0Iu3+Cnk5e9ZSzfyMdcF2JoyQc/To8ybtBlRj2vIhqjhV0dM1oJoKJa+BwpRwfCFm11YKLziSxDtHuJW3lcF5AgSSKrg2UOzbD6EvfKGTeSRWzT7WUttGxEoqvASMCovrw60tezPHZTJa4eL2pHcitpcSc2BTf4QXN6L9iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=2GSlDyqc; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T61ECc013749;
	Mon, 29 Jan 2024 11:41:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=7vOrMpK
	rhmC5GZ7lLl0/bEb14hQaIT+NcW4xeoCn3wg=; b=2GSlDyqctOIb3x4m53c1K5/
	Oide7sWqUf+6oQbsbk9X/s0qXKxkfTUq8dKtWnxmZcwYuDlGUD61WEgNLtZfkpPt
	kKjb6PSZHK9vYqdaqle8FCDu3k7rrAWsl5vCouyBtRb3WXpMcZGwe57klr0udbNa
	BPII8BBknXd3gZiav/gn3qMYbY8BBXm0YlBqvRXp1+I5qVuoCmHHG0GGkrc973d/
	Mw2EZzQqbz0L60i/VzV8Mn1QoqHP8d5Pw4Fk4HTMFTMSIClw9+MbPydfNuHBldeK
	dlp+VcrC+SePb21VjSIMv7i0WwEve26xRxt2qNiqJxBv9stP/hMKp+GTmBycpnA=
	=
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vwc94v9dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 11:41:21 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E46AC100064;
	Mon, 29 Jan 2024 11:41:18 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DD6FB21683A;
	Mon, 29 Jan 2024 11:41:18 +0100 (CET)
Received: from localhost (10.252.28.37) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 29 Jan
 2024 11:41:16 +0100
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
To: Yannick Fertre <yannick.fertre@foss.st.com>,
        Raphael Gallais-Pou
	<raphael.gallais-pou@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v3 0/3] Update STM DSI PHY driver
Date: Mon, 29 Jan 2024 11:41:03 +0100
Message-ID: <20240129104106.43141-1-raphael.gallais-pou@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_06,2024-01-29_01,2023-05-22_02


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
Changes in v3-resend:
	- Removed last patch as it has been merged
https://lore.kernel.org/lkml/bf49f4c9-9e81-4c91-972d-13782d996aaa@foss.st.com/

Changes in v3:
	- Fix smatch warning (disable dsi->pclk when clk_register fails)

Changes in v2:
	- Added patch 1/4 to use SYSTEM_SLEEP_PM_OPS instead of old macro
	  and removed __maybe_used for accordingly
	- Changed SET_RUNTIME_PM_OPS to RUNTIME_PM_OPS

Raphael Gallais-Pou (3):
  drm/stm: dsi: use new SYSTEM_SLEEP_PM_OPS() macro
  drm/stm: dsi: expose DSI PHY internal clock

Yannick Fertre (1):
  drm/stm: dsi: add pm runtime ops

 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 279 ++++++++++++++++++++++----
 1 file changed, 238 insertions(+), 41 deletions(-)

-- 
2.25.1


