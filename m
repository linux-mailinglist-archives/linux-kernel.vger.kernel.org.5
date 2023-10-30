Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DEE7DB400
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjJ3HUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjJ3HUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:20:01 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279C9F9;
        Mon, 30 Oct 2023 00:19:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRa3BNow11Hh62yV5jIdbm6NxbkJqBfjEnwe2hZ4TOUMdEHrJYtcJtokLfdhaRpDo7iRYiT8omtS7FKZMWDTsZYUOn4oGkbxzGDgHJJld3O8eloO5dnz2US5upJD6G8oHEshVVLLMQ8/8e0XIp1Q/fskq4kGsxyskkbqRknmIABURaJyUaF/6AOX3RJzE9AwfmJTX5DH40wQfdB4Jp2GUSpLq2EVVT4EemZJjpjdfxcYJFTmamkoS79llobT2ZBWYMNV8zI9spDM38rFybplCA/74FJVR0e/Ri7BBcINo7dKDQ98i36fV1+dSyddohMcTqlsl8x11V3HXC3IyUFH5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b47FqelRefLaNhS5fA+DTa7jmlBH5D7qfcxAlOfSPuI=;
 b=iez4pY4q+79iX3TgM7PEIMCQZuM/qPcaQoVxgCBqWOKb9EITD60rYHHiP9kV+kDSdoUZii/eEd2YuqWUb9Hlhfb4NkQIAq0VsnobEQZ8zDNk6wKVivlFBYgFICEVCPZVLkG7nzWI/pMTYFvF/3rlX+PNjBDPphsipnR++zBGKiDnRvKuuGU3is/+tS0mnzt9WTTyaYWXCFf2X/5feYNuw2SGx/ckyhrgQGjOMpEWwOVupxGOB7nivNTadAlKUYyKXe8Kpqvc4DQ6Hv3YyN6AWHlHYlaLFmfp1UWl9hFqa9W0mq6Luj74ZNWW8jvV1rxreAn/GMd6ZcbXF/oxW4k7vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b47FqelRefLaNhS5fA+DTa7jmlBH5D7qfcxAlOfSPuI=;
 b=1g0+VqkDbicOyTjvIw2V0qgUnKIkiTNjFFprbirzgKQChdSqBRDYwvfSKigs9HauNvcDRiEfXkZPNqzXBSrDTJtmUwxNgngAHR2/Q2Cl3L564K3YBiGhZT9SgvkaPR8lD+nTowJf7GwJQqS6DaxCI4IDKJDcc+7gxUvFrNEN4/Q=
Received: from CY5PR13CA0042.namprd13.prod.outlook.com (2603:10b6:930:11::10)
 by DS0PR12MB7511.namprd12.prod.outlook.com (2603:10b6:8:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 07:19:40 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:11:cafe::7b) by CY5PR13CA0042.outlook.office365.com
 (2603:10b6:930:11::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.14 via Frontend
 Transport; Mon, 30 Oct 2023 07:19:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Mon, 30 Oct 2023 07:19:39 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 30 Oct
 2023 02:19:34 -0500
From:   Ma Jun <Jun.Ma2@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <lenb@kernel.org>,
        <johannes@sipsolutions.net>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <alexander.deucher@amd.com>, <Lijo.Lazar@amd.com>,
        <mario.limonciello@amd.com>, <netdev@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>
CC:     <majun@amd.com>, Evan Quan <quanliangl@hotmail.com>,
        Ma Jun <Jun.Ma2@amd.com>
Subject: [Patch v13 4/9] wifi: mac80211: Add support for WBRF features
Date:   Mon, 30 Oct 2023 15:18:27 +0800
Message-ID: <20231030071832.2217118-5-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030071832.2217118-1-Jun.Ma2@amd.com>
References: <20231030071832.2217118-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|DS0PR12MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b8d27ca-470c-4db8-4971-08dbd91894a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Va9DIqJEB85PM7hffGQdYUzLY3VxQS+NGt0KqKBynI/NlRfbS9WCcrM51tz4b+RuoRfXSvJe0j+M55fGmtn3JRPGP5L4M+SAnOrpGj12VeA2q0fzNPeleZDNfvo4oTksOL1D0nzn6ZsGr6DXzVz9+KazPDmff/RUKQBh270Ei1AFBiqMNImaPCIvv4NuWjlhcBRAmzP4IhDG2mTqJWdesi+Kt+OwP+ojWosJEIJtrziyC+LXqtS42sR2X25CJ3oZRli8WWlh3kJvrDRwKNo3BafSw5sDztuO1bETweFY7Pd4IeaqD1U2H6CIJpk1lyoFMBl8t6iDFj2pjPmz4E+Iogf+d2Z/yN78VOXDl7YGpIkmuRqTbypipWE94Gvul8EMizuDLj1qKur4OLcyALcYCcBfcK2LmFZqNwgvcntxZqrIEprOnTRUe0qULZLKSTuRLHNv6MM+gtekpiQqHzdmNSMP97JWjKffyBQW7W514se+BfzWackgwZQcfqy0/Vrh3sODKjt0ZvMycqQkI8jxO+50PikA6XzuCjhtpfNYNQbhDLLBGOhmYIq5YS5YX7zVMH/q/xQcpme6DfUeC5PzkYnP1rov7p/LtBzG8nbHVp4VlKwrv3iMXyxTZ97u8qAGclOfxLETIYjvLpYH0eb9skp7lTm5nC6R5K9TiKFpP5ZCx4HXtfL+QthWCaCTFT8CH/1Izjq1SZMj/F9BtccD2TNbwtGhUoGXMTN/UhzKUTVSl7aS+Ub8TSyYrChv4N9NTQDUEUrVKGF45YsVp9uUeU/uYbpRZUGzWEVYQjSc77E=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(82310400011)(36840700001)(40470700004)(40480700001)(40460700003)(45080400002)(478600001)(110136005)(70586007)(70206006)(7696005)(6666004)(32650700002)(83380400001)(36756003)(36860700001)(82740400003)(81166007)(356005)(1076003)(2616005)(41300700001)(2906002)(426003)(336012)(16526019)(26005)(86362001)(921008)(8676002)(8936002)(316002)(54906003)(4326008)(7416002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 07:19:39.7938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8d27ca-470c-4db8-4971-08dbd91894a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7511
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
---
 net/mac80211/Makefile      |  2 +
 net/mac80211/chan.c        |  9 ++++
 net/mac80211/ieee80211_i.h |  7 +++
 net/mac80211/main.c        |  2 +
 net/mac80211/wbrf.c        | 95 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 115 insertions(+)
 create mode 100644 net/mac80211/wbrf.c

diff --git a/net/mac80211/Makefile b/net/mac80211/Makefile
index b8de44da1fb8..d46c36f55fd3 100644
--- a/net/mac80211/Makefile
+++ b/net/mac80211/Makefile
@@ -65,4 +65,6 @@ rc80211_minstrel-$(CONFIG_MAC80211_DEBUGFS) += \
 
 mac80211-$(CONFIG_MAC80211_RC_MINSTREL) += $(rc80211_minstrel-y)
 
+mac80211-y += wbrf.o
+
 ccflags-y += -DDEBUG
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 68952752b599..458469c224ae 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -506,11 +506,16 @@ static void _ieee80211_change_chanctx(struct ieee80211_local *local,
 
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
@@ -668,6 +673,8 @@ static int ieee80211_add_chanctx(struct ieee80211_local *local,
 	lockdep_assert_held(&local->mtx);
 	lockdep_assert_held(&local->chanctx_mtx);
 
+	ieee80211_add_wbrf(local, &ctx->conf.def);
+
 	if (!local->use_chanctx)
 		local->hw.conf.radar_enabled = ctx->conf.radar_enabled;
 
@@ -748,6 +755,8 @@ static void ieee80211_del_chanctx(struct ieee80211_local *local,
 	}
 
 	ieee80211_recalc_idle(local);
+
+	ieee80211_remove_wbrf(local, &ctx->conf.def);
 }
 
 static void ieee80211_free_chanctx(struct ieee80211_local *local,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 98ef1fe1226e..1172554bd831 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1600,6 +1600,8 @@ struct ieee80211_local {
 
 	/* extended capabilities provided by mac80211 */
 	u8 ext_capa[8];
+
+	bool wbrf_supported;
 };
 
 static inline struct ieee80211_sub_if_data *
@@ -2637,4 +2639,9 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
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
index 24315d7b3126..b20bdaac84db 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1396,6 +1396,8 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	debugfs_hw_add(local);
 	rate_control_add_debugfs(local);
 
+	ieee80211_check_wbrf_support(local);
+
 	rtnl_lock();
 	wiphy_lock(hw->wiphy);
 
diff --git a/net/mac80211/wbrf.c b/net/mac80211/wbrf.c
new file mode 100644
index 000000000000..ca3f30b58476
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
+	bandwidth = MHZ_TO_KHZ(bandwidth);
+	center_freq = MHZ_TO_KHZ(center_freq);
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

