Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D407CB8B3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 04:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbjJQCzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 22:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbjJQCz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 22:55:28 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D38B0;
        Mon, 16 Oct 2023 19:55:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHyDEuvfsHlxft5Jqf2x9J/ppaa3ThAq2NNdcNxOeuJH5GYAGNQCgFYqU7WgzYx4aA3X2OJvgspQY5fpgL/VUM8qjVnFAXKIWu2YrpUwAjNsq3C8Tp+2s1NXe1S8Uz94eADEXY0u9j8fWVasBDGBaCLsq17dIZtIc/FbePFZa7uy0LykPMINJy5WnvAcvn7Z+n2/m+JqsbKa722bJLRf//T2bHYSILDPnBvDZ6wOO7MIN0cbK0W60rzdBRQ/f+kNR3QptyWnpWUWIQ3K7oRog/GiBMJmJWvjE2CeQqwYit4B+M6fz8OOnIucjFp3qQe9zmOfurLbio51cFOxwtYSfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJSxBZLi6UMarzyI+M1Uw+LTtZy6N+Qcpeab/YKqf1U=;
 b=ZuiDqtd7Vd1ZNILnycMRYbrmMN7dd2kthTzE1qIQWXMnd6/DvNWvypo+CF3qC8fEe+aih0hZxL1Y6kWUGYmFpPHg44soMAfZ5B2uKOryvsRLEt0zfYJTs+IujuB/Ur25sJETK4J2BbMr2mO+kUH0M/QGpaRQlzL5P0I11h7WWzSEjgf3Cou1ppsSgOGcZ3iYbRmKTqowqoSMMyYv0hmD6JA8FItR4Dn6J8JLl4UiqUxtM+jw+nva7bBNSp7/wb3jw5/crlxFwYHgRYhQo0k0r1QJWsiiKgzN9sDZ7AQKs+xe+j4/q85xvyPmBxapQjICB+QCzgT2UR9POUQXXHAsdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJSxBZLi6UMarzyI+M1Uw+LTtZy6N+Qcpeab/YKqf1U=;
 b=Gb4wUf5+qI2wb0ld3C+HSYN9zr9bM5i+HvAnJoDRWY6gGPjRQXNEEGPIMhKn5//Kuz20I9ApiXAoZHcwt0rd1vwNeO0VEvZSuiCB6AqEy0JwIiRywxa5ArGeD+BAm96CYtNBYqpLsKd2iu37PWKSVaklQ0eMIq2pRdhPYw4dTyM=
Received: from MW4P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::15)
 by BY5PR12MB4035.namprd12.prod.outlook.com (2603:10b6:a03:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 17 Oct
 2023 02:55:22 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::b3) by MW4P221CA0010.outlook.office365.com
 (2603:10b6:303:8b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Tue, 17 Oct 2023 02:55:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 02:55:21 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 21:55:14 -0500
From:   Ma Jun <Jun.Ma2@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <lenb@kernel.org>,
        <johannes@sipsolutions.net>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <alexander.deucher@amd.com>, <Lijo.Lazar@amd.com>,
        <mario.limonciello@amd.com>
CC:     <majun@amd.com>, <netdev@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        Evan Quan <quanliangl@hotmail.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH v12 4/9] wifi: mac80211: Add support for WBRF features
Date:   Tue, 17 Oct 2023 10:53:53 +0800
Message-ID: <20231017025358.1773598-5-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017025358.1773598-1-Jun.Ma2@amd.com>
References: <20231017025358.1773598-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|BY5PR12MB4035:EE_
X-MS-Office365-Filtering-Correlation-Id: 62bf1e72-1e7f-4bcd-4cc7-08dbcebc8111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJJolvk6f3JmPoj9a/SwHii8B/q2+hFAYPpTBQWXNVvKrvQ4Akm+HFplBprTcHXr7PMl8z5zdsZRu3iOx6wxFedLmCGKxus3UIMlvo0QchfkkXsWgq3obYq0SaeOkNVHkTKAPHJd1MTtltgIDLPPWwuVx/MnOv1RyqrxNXuEQ7NnoLc7T5TkSQ4g8AnYqJE6+8cltEOZVKs/X6TkqNxKNeyA3MQTvMFaoZMXt5Bj7YdR72P/93QPTyVzJCYOFb1WkGCL0zf1oS+7bEWiWC+02VAR+C+z3oidsLzyumEiJ6uQzzcjyVgcAXcwj78kio/62znZur3VGs3lJJQdyUXce+g4FbZFD6Xd0xr6GUctkRbvEkYg3uwXiFP55xiZEY2dCZJAlU8gDm843nPD6OOgs5zwAH7cHg+1OOot6qTxnzwDbLA4TrAt/9hVOnaUooHiOqfD4LIOL0iliJkOncVcMJFDNjvayGacS+HBnsnta5rtAlQzsFUfhCjL/OBdmqKyNy4LkmIZ9QlQUofE+JjNp1iyZ3IsVaDUNP0mlWbw8hLlIdzM/HU9b3TVvUwWDd7mPiPYKhF9GvrjVB5qH3SuP7xxTNYXoDatvG49Kk2l5poFUTtf2d+rgYdM1SPA0egiMrLVL3o929auh1lwBcR2qi12C4P4l+A+rVlR4FwS+C7PWkTLsa6lqg2YClaqMpulwsGOUP+fClid4lxwg/PO/ErKe1RZa5yK3AU+l0RrHFY+O9xOtJhZ4FX9e//a21GtGpi5CWt+stRx74XNdJp3uPRe5y7ECPbIzAzP6Mc3NpU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(1800799009)(451199024)(186009)(82310400011)(64100799003)(40470700004)(36840700001)(40480700001)(7416002)(40460700003)(6636002)(81166007)(8676002)(16526019)(2616005)(336012)(1076003)(921005)(356005)(110136005)(26005)(426003)(82740400003)(36756003)(54906003)(8936002)(5660300002)(316002)(2906002)(41300700001)(70206006)(70586007)(478600001)(4326008)(6666004)(83380400001)(45080400002)(7696005)(86362001)(36860700001)(32650700002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 02:55:21.6218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bf1e72-1e7f-4bcd-4cc7-08dbcebc8111
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4035
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
register the frequencies in use(or unregister those frequencies no longer
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
---
 include/linux/ieee80211.h  |   1 +
 net/mac80211/Makefile      |   2 +
 net/mac80211/chan.c        |   9 ++++
 net/mac80211/ieee80211_i.h |   9 ++++
 net/mac80211/main.c        |   2 +
 net/mac80211/wbrf.c        | 105 +++++++++++++++++++++++++++++++++++++
 6 files changed, 128 insertions(+)
 create mode 100644 net/mac80211/wbrf.c

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 4b998090898e..f995d06da87f 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4335,6 +4335,7 @@ static inline int ieee80211_get_tdls_action(struct sk_buff *skb, u32 hdr_size)
 /* convert frequencies */
 #define MHZ_TO_KHZ(freq) ((freq) * 1000)
 #define KHZ_TO_MHZ(freq) ((freq) / 1000)
+#define KHZ_TO_HZ(freq)  ((freq) * 1000)
 #define PR_KHZ(f) KHZ_TO_MHZ(f), f % 1000
 #define KHZ_F "%d.%03d"
 
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
index 91633a0b723e..719f2c892132 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1600,6 +1600,8 @@ struct ieee80211_local {
 
 	/* extended capabilities provided by mac80211 */
 	u8 ext_capa[8];
+
+	bool wbrf_supported;
 };
 
 static inline struct ieee80211_sub_if_data *
@@ -2638,4 +2640,11 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 				    const struct ieee80211_eht_cap_elem *eht_cap_ie_elem,
 				    u8 eht_cap_len,
 				    struct link_sta_info *link_sta);
+
+void ieee80211_check_wbrf_support(struct ieee80211_local *local);
+void ieee80211_add_wbrf(struct ieee80211_local *local,
+			struct cfg80211_chan_def *chandef);
+void ieee80211_remove_wbrf(struct ieee80211_local *local,
+			   struct cfg80211_chan_def *chandef);
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
index 000000000000..7329f554c7af
--- /dev/null
+++ b/net/mac80211/wbrf.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Wifi Band Exclusion Interface for WLAN
+ * Copyright (C) 2023 Advanced Micro Devices
+ *
+ */
+
+#include <linux/acpi_amd_wbrf.h>
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
+static void get_chan_freq_boundary(u32 center_freq,
+				   u32 bandwidth,
+				   u64 *start,
+				   u64 *end)
+{
+	bandwidth = MHZ_TO_KHZ(bandwidth);
+	center_freq = MHZ_TO_KHZ(center_freq);
+
+	*start = center_freq - bandwidth / 2;
+	*end = center_freq + bandwidth / 2;
+
+	/* Frequency in HZ is expected */
+	*start = KHZ_TO_HZ(*start);
+	*end = KHZ_TO_HZ(*end);
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
+	get_chan_freq_boundary(chandef->center_freq1,
+			       bandwidth,
+			       &start_freq1,
+			       &end_freq1);
+
+	ranges_in->band_list[0].start = start_freq1;
+	ranges_in->band_list[0].end = end_freq1;
+	ranges_in->num_of_ranges = 1;
+
+	if (chandef->width == NL80211_CHAN_WIDTH_80P80) {
+		get_chan_freq_boundary(chandef->center_freq2,
+				       bandwidth,
+				       &start_freq2,
+				       &end_freq2);
+
+		ranges_in->band_list[1].start = start_freq2;
+		ranges_in->band_list[1].end = end_freq2;
+		ranges_in->num_of_ranges++;
+	}
+}
+
+void ieee80211_add_wbrf(struct ieee80211_local *local,
+			struct cfg80211_chan_def *chandef)
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
+void ieee80211_remove_wbrf(struct ieee80211_local *local,
+			   struct cfg80211_chan_def *chandef)
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

