Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2813680684D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377083AbjLFHau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377109AbjLFHam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:30:42 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC36D44;
        Tue,  5 Dec 2023 23:30:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlsdEf7Wi6aCmA2S48F4ht1J5rSLfAQSkgT5jALyWiK+sY5y7NEg6KXvMQZZgnWyNNL8lW3ELWlyEw5ralUhU8QjCC3/wbmUdEDLG5OAFFFjsxema23JgODTpqFuMwpGUtNK+1d14aVUYJgvU9nFEmH+PkrHklG2fuIjfaAMPazOpBO5AIyCxdbibMPM5+N5YPNEy0By1wC1fMQheR+PrysdvJb+55yiFQ5cmPKUyt/beXfb13AiRm5yd3FI9/h6NXkpbj4snYmzrRlHUiL1TVKeHW5xGeGE+z/1O9IhwDV2tGMhLOvu+g46BGzTRraZ/8oiquzVgEO8RFwaxKgs6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/wBKyGGIB45ndx95MMnM6Duag1kd0fpvxX7IeiP5XU=;
 b=nDTjsD401cd30K/ZKPunFms6QX515Rqbg+E5aElzPZpXDGbO21rYFpKkjaTniJJaiqRHR15cMGiNjEkl6KuQGbx+fOp8H3JsZJFpL/X4RYQjL14YOajsgHQAdh4KKTvz6KLEuYNhT4Uj/gF8NHA80lr4isiebvX2XrhkXzL2n0dDq8eY5dcvf5mzJQUqfbQZ0t63LGOjEc/H9UNYT4uiHaLet1DesjAxGjXa1Sw54jK9b1FaifxawSubZu4Hy30/nJ7Y7an4p4FgJ20kRhxSe1lwgzwBoPwGtVW3f+qOuh3PAqHP5SotSwDhawA5Ahs74r/S1RtH7C+wOXMTEa+BtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/wBKyGGIB45ndx95MMnM6Duag1kd0fpvxX7IeiP5XU=;
 b=lwae4/zxXeAqm9WKZmk0Ey+GSZ6IrftuiS93Jx/LYxVP7ZmVx+nG4ebCb9/6MFZj8UE0UXg1Ew6o3wIMb5knYxwLIp7NiyS1VsmaTjdfdsQpzczBOjjJ7uCzFjRqKDr2L1Wr302F4kzGM0HfMugQpPM8A1L5oAFYA7OP2b5WEaU=
Received: from MW4PR03CA0284.namprd03.prod.outlook.com (2603:10b6:303:b5::19)
 by DM4PR12MB5184.namprd12.prod.outlook.com (2603:10b6:5:397::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 07:30:36 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:b5:cafe::43) by MW4PR03CA0284.outlook.office365.com
 (2603:10b6:303:b5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.29 via Frontend
 Transport; Wed, 6 Dec 2023 07:30:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.2 via Frontend Transport; Wed, 6 Dec 2023 07:30:35 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 01:30:29 -0600
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
Subject: [PATCH v15 3/9] cfg80211: expose nl80211_chan_width_to_mhz for wide sharing
Date:   Wed, 6 Dec 2023 15:29:41 +0800
Message-ID: <20231206072947.1331729-4-Jun.Ma2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|DM4PR12MB5184:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d5db0d-65c3-4bf1-61ab-08dbf62d3cb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +oLNey7RN1a47qiUl51IjgBjKVffQVI79JXoCL4HtRZd7XFb4fu2NsJm5nJgfBWCUfvdwC5EnWlk0AVXrrCH8+KUVyOxsabKHWTzDxuY5VBkkBjto7pxpfJtQNikUafsfRvvC3+VWLqucT9ReJVh7dphOfRG51BTgBHRl6b58gT6byqO3yjoq+Oq0lGHOMlTmQ78kJYB2dKd+V00I8Px8Ky3WBahvdZHug5fwtWtM0AZeecctCyb+US1qZWCVgZsiJeNXH/5sasNY5F9jh712omr/dJS48uuQEbIvWkzLjcixdsL2b9ZAF+lDb6x+1TeDvofFrI9V+QgKayo/6XNoum2zJ8XgZqi8H6BWTqdiPUYSorBmG+Arpte46XWrBHRh4j3MzqHt2FixAktTNHE6ffbCXk77mUXz7Lk0V2WliKDyvmkDp1YEuSWeoaM9sw9WYRshHzwjKwWJjCMmQA2zFQbbt/k8k2c+WY3CyGq/Zlv5x8nY5O12cAGkx/E0fcAsysDtU91qYDL3Hm62rWVnbLlPLXkO28/I0WaBx1xTWXNqycq9lz0SIX0gZuKQf2UCKBc4y77Rwl+14NepDXaa3CAbCpuqZ8z9SK6Whdukj5SiITF/OT0Opn6VbTnW1/zitIerLoxwcCdb/p4e1cnHUQfo1jh6UEsCmvENbvDy2ZzyFSOwaAIvp9hVeBpTSvDsgsphkk57uGm8qHxburzs4wwGij671UhIgdj6bOjQ6OY7bH2gpf0u80sIJVZPvSByK45TkQ4stf4HJVA9UOXspS+VQ4y9vXPRm29tPkb8aM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(82310400011)(186009)(36840700001)(40470700004)(36860700001)(81166007)(356005)(7696005)(26005)(336012)(426003)(16526019)(40480700001)(32650700002)(8676002)(4326008)(8936002)(110136005)(54906003)(316002)(70586007)(70206006)(82740400003)(83380400001)(2616005)(478600001)(1076003)(6666004)(45080400002)(86362001)(40460700003)(5660300002)(7416002)(2906002)(921008)(36756003)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 07:30:35.3648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d5db0d-65c3-4bf1-61ab-08dbf62d3cb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5184
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

The newly added WBRF feature needs this interface for channel
width calculation.

Signed-off-by: Evan Quan <quanliangl@hotmail.com>
Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

--
v8->v9:
  - correct typo(Mhz -> MHz) (Johnson)
v13:
 - Fix the format issue (IIpo Jarvinen)
---
 include/net/cfg80211.h | 9 +++++++++
 net/wireless/chan.c    | 3 ++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4ecfb06c413d..c784e86a6d99 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -976,6 +976,15 @@ const struct cfg80211_chan_def *
 cfg80211_chandef_compatible(const struct cfg80211_chan_def *chandef1,
 			    const struct cfg80211_chan_def *chandef2);
 
+/**
+ * nl80211_chan_width_to_mhz - get the channel width in MHz
+ * @chan_width: the channel width from &enum nl80211_chan_width
+ *
+ * Return: channel width in MHz if the chan_width from &enum nl80211_chan_width
+ * is valid. -1 otherwise.
+ */
+int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width);
+
 /**
  * cfg80211_chandef_valid - check if a channel definition is valid
  * @chandef: the channel definition to check
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 2d21e423abdb..dfb4893421d7 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -141,7 +141,7 @@ static bool cfg80211_edmg_chandef_valid(const struct cfg80211_chan_def *chandef)
 	return true;
 }
 
-static int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width)
+int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width)
 {
 	int mhz;
 
@@ -190,6 +190,7 @@ static int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width)
 	}
 	return mhz;
 }
+EXPORT_SYMBOL(nl80211_chan_width_to_mhz);
 
 static int cfg80211_chandef_get_width(const struct cfg80211_chan_def *c)
 {
-- 
2.34.1

