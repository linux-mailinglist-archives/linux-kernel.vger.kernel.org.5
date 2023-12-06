Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D71680685B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377005AbjLFHb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377100AbjLFHbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:31:19 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088661732;
        Tue,  5 Dec 2023 23:31:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5HZx+waU7+ZKWJIlqF+O+IxDPxfEwU7BF1JRGIA9D1kNRvXdOqD2eC+YppVN2P+qTDRssJqr+C4I5a26JiWmjjnVQCRwhsojCAmC5T59vSCw1YqtGxUx+SlFbSQsUbqIrJFKuziI37magemCnibiXSeGGvpep/Ybj5zcH4NyRqlq89oi7R7sPsQLJT2oGmZ+3+6Qj9wI4CLMv4n/uz1lR9bPvcrD/TUQLRf7EDDVg2ZEn/7uie9Mw6RNzVEKzbfBXXE+PF+WaYDuX3oT80gvPa7Gvyua561/mH3ZnKkUgipwnjxFafiRAT0PeJS9+6ibmzUzDHZ1V5yB5BkTnEOuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZratQVfQBCl5uoVBQ/zQ7PAfRxCUobVD/bahhAth84=;
 b=ZzZYjlkW22DNQlTjUXoF7Yt6ytPdIYwi+mrzY7L/er2CLsUm50p5TsIbiLBJIYiEQf0MBaLPrAIs5pkUaohlet5Z9N48khN8RyfXRiG5z8YOyqi4mYvHH5WBN7qLh1L5uYoY++gLm46oMxl4yyEgNekn3jEa+LqXkbD0myHCyknAERdvce9gaE2lEF7EDiPMijgYNC9RQ93GxWlaJnh83p54hiAfFcFOd891ZdQC8ZCOeISivSY0/msjfv5Bk5y6RNmUpGY+oH7IJN6VrnIKVxrQjPL7kKIpC47gbTxN+SOxQjCj6wfe4gGfKFSghRPLVE2CmrkHzD9xJ++xENFWow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZratQVfQBCl5uoVBQ/zQ7PAfRxCUobVD/bahhAth84=;
 b=We+Brr57iQXMsH6t/U/h60R2ar/Aq3FhvrxO+fcQtA75PiX8c6H+5oHiRoZURjaape79mh5+SBMd/uTNyZA5GIXpBxYeV62ryPvyTNX6ZM0EzcDkpUH38df/qHg2aPwpk/zzLi786xZeE6w8gC9zKfsf1RclFE1CwHe1L5730tQ=
Received: from MW4PR04CA0235.namprd04.prod.outlook.com (2603:10b6:303:87::30)
 by SN7PR12MB7369.namprd12.prod.outlook.com (2603:10b6:806:298::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.26; Wed, 6 Dec
 2023 07:31:07 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:87:cafe::48) by MW4PR04CA0235.outlook.office365.com
 (2603:10b6:303:87::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 07:31:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.2 via Frontend Transport; Wed, 6 Dec 2023 07:31:07 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 01:30:34 -0600
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
Subject: [PATCH v15 4/9] wifi: mac80211: Add support for WBRF features
Date:   Wed, 6 Dec 2023 15:29:42 +0800
Message-ID: <20231206072947.1331729-5-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206072947.1331729-1-Jun.Ma2@amd.com>
References: <20231206072947.1331729-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|SN7PR12MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d7c2163-1e37-4823-7f70-08dbf62d4fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SRNKhkxf5LmprSQI+dCH0XWGUbdtBv1Wf61LuWg806C2OjXtIr4cShM8j63UexlWkosAIuuNBUaFOUtEqoSZMHmdozGzpPuh7apyy0RFdgDwsVriiQC2aQMyfc3v9G0d5KUBy9hmLhe4iXKPM74S8VKwr1y0in+auquaqJLE39bl470GfM/NncjVyuFC1NuYxlkBacrkqydbV1sIORa9+S5BDrxftKthsEqmvBkVtuGLMQIujRrdvqkY6dQfmYjpx+b4LK/Caky/ClUl0qA/fG9BrCxH+Bt1ruWX0Ns9uf5IS5V/LBpT//MNy05wkJ6IS+Ep4NM1rB9cGCT7xP196rugRE4SvKGtsjsZC5sJ5V4npXrNc/8UevBSPmikquqJc1SJ9eEY5vXkgkR74SeOEijZxlmyS48Xb/mVORMj432VMxzPYovGqIN59g14BcZYEpXOtJsQ3IHKzC+iw6rxXQN856l+mdYFzy7ECj5lju2eJLt1vls/DHZUdW2xve62VILZ7UpyFuIlzCKCKSEsmtbmyb7tC171BFweQjLtGVF7xrgNRfXQuQaIHaVj4fx+sChUQ1t4asjCpnfu+2uvhGJz9Q5/s32I0EgtLC55EwKrr4CLTTDENHFeOKmgbfjXfjeqFOYVTT8Ycl7QV+k3ZlG+jQKupUe9uWStv6he3Ve2JOQraMLCjrE/MSKLvicQbtAvhL3CZ70y1Mc1XPYgw8NmdX25UarF+NMkM/Qs3XIL8y3Kpn1wT8ltX6J4XSbDa+TFTPfHJHoKOebLM99QJJetRauI/X3ibg1rcce3lN4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(82310400011)(451199024)(186009)(1800799012)(64100799003)(36840700001)(40470700004)(81166007)(32650700002)(336012)(356005)(36756003)(921008)(82740400003)(70586007)(86362001)(40460700003)(36860700001)(426003)(8676002)(8936002)(40480700001)(7696005)(5660300002)(7416002)(1076003)(110136005)(2906002)(41300700001)(70206006)(4326008)(83380400001)(316002)(54906003)(2616005)(45080400002)(26005)(478600001)(16526019)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 07:31:07.2271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7c2163-1e37-4823-7f70-08dbf62d4fbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7369
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

