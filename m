Return-Path: <linux-kernel+bounces-51503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A1A848BFA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C174F2848EE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303AD1170B;
	Sun,  4 Feb 2024 07:49:41 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3FAE578
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707032980; cv=none; b=QkiTBZYoBQzOIFsreVOVSPWd1Z8SUqIAFlzxdbdo9aDKWd+P/7MeoYa8xx4SBX4F8wI1OvYJCmLNnSq1qukjmr9YYaptTfBXLMRewOIgTRB95swLpNqTpeUhp8RymYG2aHle7ybCmN6eONBzvqo+8AtP5mN3QQTLUkqpS4n104g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707032980; c=relaxed/simple;
	bh=sjrcDCbhSwKtcGnasHHrnMOZkhXGt64pWlRqOR6tDZA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQZrKuqJpLC5tNOJdiTu7U1GGpIeoz+XR3Khm23ZaQkk3I3JWYJUTRXtPSRXaG31Vko5H/TVUdDT6ZdBW1mZkHeuFFgLo7dNerQm8F0TYuOLqWC2nqLzYqGh8ovM0yibm2JRtaJteQx3aHTStVVUu9SAWPLkd98fObfdKQVCwWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TSM800v2Mz1xnBQ;
	Sun,  4 Feb 2024 15:48:32 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id 479921A0178;
	Sun,  4 Feb 2024 15:49:36 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 4 Feb 2024 15:49:36 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <jonathan.cameron@huawei.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<hejunhao3@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
Subject: [PATCH 7/7] docs: perf: Update usage for target filter of hisi-pcie-pmu
Date: Sun, 4 Feb 2024 15:45:27 +0800
Message-ID: <20240204074527.47110-8-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20240204074527.47110-1-yangyicong@huawei.com>
References: <20240204074527.47110-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)

From: Junhao He <hejunhao3@huawei.com>

One of the "port" and "bdf" target filter interface must be set, and
the related events should preferably used in the same group.
Update the usage in the documentation.

Signed-off-by: Junhao He <hejunhao3@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 .../admin-guide/perf/hisi-pcie-pmu.rst        | 31 ++++++++++++++-----
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/perf/hisi-pcie-pmu.rst b/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
index 7e863662e2d4..c98ea4b0f0d4 100644
--- a/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
+++ b/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
@@ -37,9 +37,20 @@ Example usage of perf::
   hisi_pcie0_core0/rx_mwr_cnt/ [kernel PMU event]
   ------------------------------------------
 
-  $# perf stat -e hisi_pcie0_core0/rx_mwr_latency/
-  $# perf stat -e hisi_pcie0_core0/rx_mwr_cnt/
-  $# perf stat -g -e hisi_pcie0_core0/rx_mwr_latency/ -e hisi_pcie0_core0/rx_mwr_cnt/
+  $# perf stat -e hisi_pcie0_core0/rx_mwr_latency,port=0xffff/
+  $# perf stat -e hisi_pcie0_core0/rx_mwr_cnt,port=0xffff/
+
+The related events usually used to calculate the bandwidth, latency or others.
+They need to start and end counting at the same time, therefore related events
+are best used in the same event group to get the expected value. There are two
+ways to know if they are related events:
+a) By event name, such as the latency events "xxx_latency, xxx_cnt" or
+   bandwidth events "xxx_flux, xxx_time".
+b) By event type, such as "event=0xXXXX, event=0x1XXXX".
+
+Example usage of perf group::
+
+  $# perf stat -e "{hisi_pcie0_core0/rx_mwr_latency,port=0xffff/,hisi_pcie0_core0/rx_mwr_cnt,port=0xffff/}"
 
 The current driver does not support sampling. So "perf record" is unsupported.
 Also attach to a task is unsupported for PCIe PMU.
@@ -51,8 +62,12 @@ Filter options
 
    PMU could only monitor the performance of traffic downstream target Root
    Ports or downstream target Endpoint. PCIe PMU driver support "port" and
-   "bdf" interfaces for users, and these two interfaces aren't supported at the
-   same time.
+   "bdf" interfaces for users.
+   Please notice that, one of these two interfaces must be set, and can not
+   be supported at the same time. If they are both set, only "port" filter is
+   valid.
+   If "port" filter not being set or is set explicitly to zero (default), the
+   "bdf" filter will be in effect, because "bdf=0" meaning 0000:000:00.0.
 
    - port
 
@@ -95,7 +110,7 @@ Filter options
 
    Example usage of perf::
 
-     $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,trig_len=0x4,trig_mode=1/ sleep 5
+     $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,port=0xffff,trig_len=0x4,trig_mode=1/ sleep 5
 
 3. Threshold filter
 
@@ -109,7 +124,7 @@ Filter options
 
    Example usage of perf::
 
-     $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,thr_len=0x4,thr_mode=1/ sleep 5
+     $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,port=0xffff,thr_len=0x4,thr_mode=1/ sleep 5
 
 4. TLP Length filter
 
@@ -127,4 +142,4 @@ Filter options
 
    Example usage of perf::
 
-     $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,len_mode=0x1/ sleep 5
+     $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,port=0xffff,len_mode=0x1/ sleep 5
-- 
2.24.0


