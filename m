Return-Path: <linux-kernel+bounces-78147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E990860F8C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B068B1F23C94
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD2E79DB5;
	Fri, 23 Feb 2024 10:38:25 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601045D48A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684704; cv=none; b=mpNi/vHKQf4CTcO8k9DSFBUG6/hEB/UjVrQx5LYOFSOrQXE9LfEm5EY2VhcnHgr71tFeghOKujFB8F2xCwAqc7q0QvmvQGJ6KbNssDI8XbmTMoQ0yCYzyCGF82qy8QqYUdxg0L7lZjMA4HGK5fAcYiux2QKuEEPSP1kjrBD4YXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684704; c=relaxed/simple;
	bh=5n3559cEWEbpQWlpMl+OVrcvBOIGzA8flYrbVfgKdKw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jp7jvuLZ3dBy5joKx9eCXBaDUNkq8huIztRYMPxFOm0XYdo+TdKfkxvtuE2PQb/X+8Im96C4k1dl9QMT9iibDIE+pM4D6ucXRl8Ef05dhmd5fHSA6neWKIeJq5cySB+etN/MhQbeg3BpxDgOKjC4HaFiFw4nfugcUwO/ckWJoy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Th5vS6z7Wz1FKlQ;
	Fri, 23 Feb 2024 18:33:24 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id D68C91400CB;
	Fri, 23 Feb 2024 18:38:18 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 18:38:18 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <jonathan.cameron@huawei.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<hejunhao3@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
Subject: [PATCH v2 1/8] drivers/perf: hisi_pcie: Rename hisi_pcie_pmu_{config,clear}_filter()
Date: Fri, 23 Feb 2024 18:33:52 +0800
Message-ID: <20240223103359.18669-2-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20240223103359.18669-1-yangyicong@huawei.com>
References: <20240223103359.18669-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)

From: Yicong Yang <yangyicong@hisilicon.com>

hisi_pcie_pmu_{config,clear}_filter() are config/clear HISI_PCIE_EVENT_CTRL
register which contains not only the filter but also the event code. The
function names are bit misleading. Rename it to
hisi_pcie_pmu_{config,clear}_event_ctrl() to reflects their functions
more accurately.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/perf/hisilicon/hisi_pcie_pmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index b90ba8aca3fa..9760ddde46fd 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -216,7 +216,7 @@ static void hisi_pcie_pmu_writeq(struct hisi_pcie_pmu *pcie_pmu, u32 reg_offset,
 	writeq_relaxed(val, pcie_pmu->base + offset);
 }
 
-static void hisi_pcie_pmu_config_filter(struct perf_event *event)
+static void hisi_pcie_pmu_config_event_ctrl(struct perf_event *event)
 {
 	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
@@ -259,7 +259,7 @@ static void hisi_pcie_pmu_config_filter(struct perf_event *event)
 	hisi_pcie_pmu_writeq(pcie_pmu, HISI_PCIE_EVENT_CTRL, hwc->idx, reg);
 }
 
-static void hisi_pcie_pmu_clear_filter(struct perf_event *event)
+static void hisi_pcie_pmu_clear_event_ctrl(struct perf_event *event)
 {
 	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
@@ -505,7 +505,7 @@ static void hisi_pcie_pmu_start(struct perf_event *event, int flags)
 	WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
 	hwc->state = 0;
 
-	hisi_pcie_pmu_config_filter(event);
+	hisi_pcie_pmu_config_event_ctrl(event);
 	hisi_pcie_pmu_enable_counter(pcie_pmu, hwc);
 	hisi_pcie_pmu_enable_int(pcie_pmu, hwc);
 	hisi_pcie_pmu_set_period(event);
@@ -526,7 +526,7 @@ static void hisi_pcie_pmu_stop(struct perf_event *event, int flags)
 	hisi_pcie_pmu_event_update(event);
 	hisi_pcie_pmu_disable_int(pcie_pmu, hwc);
 	hisi_pcie_pmu_disable_counter(pcie_pmu, hwc);
-	hisi_pcie_pmu_clear_filter(event);
+	hisi_pcie_pmu_clear_event_ctrl(event);
 	WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
 	hwc->state |= PERF_HES_STOPPED;
 
-- 
2.24.0


