Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A21F80C5B8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbjLKKHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234783AbjLKKH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:07:26 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FDED5;
        Mon, 11 Dec 2023 02:07:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYus8sRpj8rgr/P5jyWqvP2TjF5tRl+dyeVSI+yDjp3c4j9OlxPwmFrwmbjnyL4z/4l4ew+sgBYFnEDlgM/dv4Fzg7CjXuf9YP4mOv9f2BgVPzuK+vSyOse7vP0yLOS1PHB0sEZ1BtHEMcHQqlqo/fpKfDtwdQxv54RM0UW2g9pewdVHbVvVKejk+0UKw9vAbtgq5X7bMsjyWkfxkmn2d/UOMl1mpNJJiqx3s++6In1TLCJOBDYKjSgios7H5aSzJP+wewbXRLH4ql8kPzjsPtgOd+8c934KcWhp8Oc2CO8D7eKsxjKRsj1aKxfMxLhGldUactnBsYUkxY+T3WtMOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZratQVfQBCl5uoVBQ/zQ7PAfRxCUobVD/bahhAth84=;
 b=FmProJ3J1ZY0TUrV9lnt5h+ejf+dOsOtyvdfU78oGRDacE+CDXsViwgecSQCaGztnrM+Q/GKVv3ARHhCQE156I4qj/JPKdacW7nejdfE4QWuwGFJrRNI/8cjf0ah9/u5JJm6hjYit1TCf2ecTXHdwVua78p5VX3oT0tNg95HDzHBpMPBk524UaoO+kujtwB0CM3kiFF1UDWSPgtRku/fikSCZSiLU7npxEWoX+KopzuitqhZVd1wq005YsnvIquGDhZd23rRX6FqUvFHUDyhmkdzDM/tX3enMed9ptIGQhTtAKBCwgpXwh+HRcAHScHsmVBNsO1dQZhgJA/NCSSp4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZratQVfQBCl5uoVBQ/zQ7PAfRxCUobVD/bahhAth84=;
 b=DoZcfzDhhG3T3eIsHcq0dbfHn/Ax0GGYlFhKxyiRznx2Amf8SdomHaex1cG35BoCRSFOXX5NhFzKt7PUaWk1vCuzNfIRLzmRIyCk6T6LhrxlhpP9CO8Xj4x3ibLsoZrL0Sf5RuXlcaELrCRCotyfJ0lTprEFbt4ToSf45aOPQ7E=
Received: from MW4P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::10)
 by SJ2PR12MB7800.namprd12.prod.outlook.com (2603:10b6:a03:4c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 10:07:25 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:80:cafe::7c) by MW4P223CA0005.outlook.office365.com
 (2603:10b6:303:80::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 10:07:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.2 via Frontend Transport; Mon, 11 Dec 2023 10:07:25 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 04:07:20 -0600
From:   Ma Jun <Jun.Ma2@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <lenb@kernel.org>,
        <hdegoede@redhat.com>, <johannes@sipsolutions.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <alexander.deucher@amd.com>,
        <Lijo.Lazar@amd.com>, <mario.limonciello@amd.com>,
        <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     <majun@amd.com>, Evan Quan <quanliangl@hotmail.com>,
        Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH v16 4/9] wifi: mac80211: Add support for WBRF features
Date:   Mon, 11 Dec 2023 18:06:25 +0800
Message-ID: <20231211100630.2170152-5-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211100630.2170152-1-Jun.Ma2@amd.com>
References: <20231211100630.2170152-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|SJ2PR12MB7800:EE_
X-MS-Office365-Filtering-Correlation-Id: 2de468f2-efea-47ba-e995-08dbfa30f9a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hoyQyKU6/bfMv9oUUFGMPxi3LPWZ2KUx1yjBC4ZWL1vyHGKygDck/xezl7ZDij5pOOLy3lXQSazcv2UyH61ljwRDeaMaU5f3pdbGGJaANBFz/QHuo1N1NWvJXqpyyh5X06ZVKkQKNhgu6fxKnW6oTZcGWyT2Cj58hdfDjPtlQfx69Mb5yq3t23/Fk6hGmwabUoDmFPhnXgBD4WSOZCVzgxVLW7+e15F7/nVxH4xrSFrXSbom+dnETFY8UAPmiyxdb0Iv8RL7Eepcy/KL/2Tm1cpb2XDOP8gaL0udE+6YRGSd0btJQoMULd1Cb5g9ki+7LDknP+bVDVNr02qmN61p+ccRgzP+1ee8rj72yv2yRC84ccacM+O0NJg6V143EOmijcxP1FVM9vZwjD2UuTpQbhmQiD6wR2DK8J3sFZ60VFn4pCkZjXQQo2LDswnntabifNKiXyKOqByQxYIoJSPHj4WX88qIsc+gtscsvZYClwR8ISNqOKH1XWMibrtzh/75BlMDXzpXpWFsOaMv5qN9OKsE4hET4+6kN1/hHq6tTPjfow1t9yTMyV8rv3PsQB3hIS1oSp5WruFL1PAhTALSidDhvtBx+/YH5Vf/xWU3ZL/QhkC+jgXfLvsi+0uiNV+1zAKx+7/I+r6MalG9t7tTFlWPxHM4gVcOKAhp5hEvEg3y30e7bFn3O/xu4xG+kvL8FGK2gVFR9UL9ZQMu6Q9jTF2pNL0p1IV0NrrjQ7OVbsxuBh69hDAt4Uztmdo4H1oOPCqYchNv3xHHbRwW2RnaAyvIk7pXlTY+WzOwW7f/4/4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(64100799003)(82310400011)(1800799012)(451199024)(186009)(40470700004)(36840700001)(7416002)(45080400002)(7696005)(2906002)(54906003)(70206006)(356005)(81166007)(86362001)(36756003)(921008)(8936002)(4326008)(8676002)(316002)(5660300002)(40480700001)(110136005)(70586007)(478600001)(40460700003)(41300700001)(36860700001)(32650700002)(82740400003)(26005)(336012)(426003)(1076003)(2616005)(83380400001)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 10:07:25.5309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de468f2-efea-47ba-e995-08dbfa30f9a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7800
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evan Quan <quanliangl@hotmail.com>

To support the WBRF mechanism, Wifi adapters utilized in the system must
register the frequencies in use (or unregister those frequencies no longer
used) via the dedicated calls. So that, other drivers responding to the
frequencies can take proper actions to mitigate possible interference.

Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Co-developed-by: Evan Quan <quanliangl@hotmail.com>
Signed-off-by: Evan Quan <quanliangl@hotmail.com>
Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
--
v1->v2:
  - place the new added member(`wbrf_supported`) in
    ieee80211_local(Johannes)
  - handle chandefs change scenario properly(Johannes)
  - some minor fixes around code sharing and possible invalid input
    checks(Johannes)
v2->v3:
  - drop unnecessary input checks and intermediate APIs(Mario)
  - Separate some mac80211 common code(Mario, Johannes)
v3->v4:
  - some minor fixes around return values(Johannes)
v9->v10:
  - get ranges_in->num_of_ranges set and passed in(Johannes)
v12:
  - use acpi_amd_wbrf_add_remove to replace the acpi_amd_wbrf_add_exclusion
    acpi_amd_wbrf_remove_exclusion
v13:
  - Fix the format issue (IIpo Jarvinen)
  - Remove KHZ_TO_HZ and use HZ_PER_KHZ in linux/units.h (IIpo Jarvinen)
v14:
  - KHZ_PER_MHZ and KHZ_PER_MHZ in linux/units.h (IIpo Jarvinen)
---
 net/mac80211/Makefile      |  2 +
 net/mac80211/chan.c        |  9 ++++
 net/mac80211/ieee80211_i.h |  7 +++
 net/mac80211/main.c        |  2 +
 net/mac80211/wbrf.c        | 95 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 115 insertions(+)
 create mode 100644 net/mac80211/wbrf.c

diff --git a/net/mac80211/Makefile b/net/mac80211/Makefile
index c9eb52768133..4406b4f8f3b9 100644
--- a/net/mac80211/Makefile
+++ b/net/mac80211/Makefile
@@ -67,4 +67,6 @@ mac80211-$(CONFIG_MAC80211_RC_MINSTREL) += $(rc80211_minstrel-y)
 
 obj-y += tests/
 
+mac80211-y += wbrf.o
+
 ccflags-y += -DDEBUG
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 1d928f29ad6f..aa24585359ee 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -507,11 +507,16 @@ static void _ieee80211_change_chanctx(struct ieee80211_local *local,
 
 	WARN_ON(!cfg80211_chandef_compatible(&ctx->conf.def, chandef));
 
+	ieee80211_remove_wbrf(local, &ctx->conf.def);
+
 	ctx->conf.def = *chandef;
 
 	/* check if min chanctx also changed */
 	changed = IEEE80211_CHANCTX_CHANGE_WIDTH |
 		  _ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for);
+
+	ieee80211_add_wbrf(local, &ctx->conf.def);
+
 	drv_change_chanctx(local, ctx, changed);
 
 	if (!local->use_chanctx) {
@@ -667,6 +672,8 @@ static int ieee80211_add_chanctx(struct ieee80211_local *local,
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
+	ieee80211_add_wbrf(local, &ctx->conf.def);
+
 	if (!local->use_chanctx)
 		local->hw.conf.radar_enabled = ctx->conf.radar_enabled;
 
@@ -746,6 +753,8 @@ static void ieee80211_del_chanctx(struct ieee80211_local *local,
 	}
 
 	ieee80211_recalc_idle(local);
+
+	ieee80211_remove_wbrf(local, &ctx->conf.def);
 }
 
 static void ieee80211_free_chanctx(struct ieee80211_local *local,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 84df104f272b..9dd51481fb87 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1559,6 +1559,8 @@ struct ieee80211_local {
 
 	/* extended capabilities provided by mac80211 */
 	u8 ext_capa[8];
+
+	bool wbrf_supported;
 };
 
 static inline struct ieee80211_sub_if_data *
@@ -2600,4 +2602,9 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 				    const struct ieee80211_eht_cap_elem *eht_cap_ie_elem,
 				    u8 eht_cap_len,
 				    struct link_sta_info *link_sta);
+
+void ieee80211_check_wbrf_support(struct ieee80211_local *local);
+void ieee80211_add_wbrf(struct ieee80211_local *local, struct cfg80211_chan_def *chandef);
+void ieee80211_remove_wbrf(struct ieee80211_local *local, struct cfg80211_chan_def *chandef);
+
 #endif /* IEEE80211_I_H */
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 033a5261ac3a..f2ece7793573 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1405,6 +1405,8 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	debugfs_hw_add(local);
 	rate_control_add_debugfs(local);
 
+	ieee80211_check_wbrf_support(local);
+
 	rtnl_lock();
 	wiphy_lock(hw->wiphy);
 
diff --git a/net/mac80211/wbrf.c b/net/mac80211/wbrf.c
new file mode 100644
index 000000000000..a05c5b971789
--- /dev/null
+++ b/net/mac80211/wbrf.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Wifi Band Exclusion Interface for WLAN
+ * Copyright (C) 2023 Advanced Micro Devices
+ *
+ */
+
+#include <linux/acpi_amd_wbrf.h>
+#include <linux/units.h>
+#include <net/cfg80211.h>
+#include "ieee80211_i.h"
+
+void ieee80211_check_wbrf_support(struct ieee80211_local *local)
+{
+	struct wiphy *wiphy = local->hw.wiphy;
+	struct device *dev;
+
+	if (!wiphy)
+		return;
+
+	dev = wiphy->dev.parent;
+	if (!dev)
+		return;
+
+	local->wbrf_supported = acpi_amd_wbrf_supported_producer(dev);
+	dev_dbg(dev, "WBRF is %s supported\n",
+		local->wbrf_supported ? "" : "not");
+}
+
+static void get_chan_freq_boundary(u32 center_freq, u32 bandwidth, u64 *start, u64 *end)
+{
+	bandwidth *= KHZ_PER_MHZ;
+	center_freq *= KHZ_PER_MHZ;
+
+	*start = center_freq - bandwidth / 2;
+	*end = center_freq + bandwidth / 2;
+
+	/* Frequency in Hz is expected */
+	*start = *start * HZ_PER_KHZ;
+	*end = *end * HZ_PER_KHZ;
+}
+
+static void get_ranges_from_chandef(struct cfg80211_chan_def *chandef,
+				    struct wbrf_ranges_in_out *ranges_in)
+{
+	u64 start_freq1, end_freq1;
+	u64 start_freq2, end_freq2;
+	int bandwidth;
+
+	bandwidth = nl80211_chan_width_to_mhz(chandef->width);
+
+	get_chan_freq_boundary(chandef->center_freq1, bandwidth, &start_freq1, &end_freq1);
+
+	ranges_in->band_list[0].start = start_freq1;
+	ranges_in->band_list[0].end = end_freq1;
+	ranges_in->num_of_ranges = 1;
+
+	if (chandef->width == NL80211_CHAN_WIDTH_80P80) {
+		get_chan_freq_boundary(chandef->center_freq2, bandwidth, &start_freq2, &end_freq2);
+
+		ranges_in->band_list[1].start = start_freq2;
+		ranges_in->band_list[1].end = end_freq2;
+		ranges_in->num_of_ranges++;
+	}
+}
+
+void ieee80211_add_wbrf(struct ieee80211_local *local, struct cfg80211_chan_def *chandef)
+{
+	struct wbrf_ranges_in_out ranges_in = {0};
+	struct device *dev;
+
+	if (!local->wbrf_supported)
+		return;
+
+	dev = local->hw.wiphy->dev.parent;
+
+	get_ranges_from_chandef(chandef, &ranges_in);
+
+	acpi_amd_wbrf_add_remove(dev, WBRF_RECORD_ADD, &ranges_in);
+}
+
+void ieee80211_remove_wbrf(struct ieee80211_local *local, struct cfg80211_chan_def *chandef)
+{
+	struct wbrf_ranges_in_out ranges_in = {0};
+	struct device *dev;
+
+	if (!local->wbrf_supported)
+		return;
+
+	dev = local->hw.wiphy->dev.parent;
+
+	get_ranges_from_chandef(chandef, &ranges_in);
+
+	acpi_amd_wbrf_add_remove(dev, WBRF_RECORD_REMOVE, &ranges_in);
+}
-- 
2.34.1

