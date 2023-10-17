Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C75F7CB8B4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 04:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbjJQCz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 22:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbjJQCzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 22:55:24 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A24F1;
        Mon, 16 Oct 2023 19:55:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWcDrHueLGs406bz9HOjmWziDoy71w9sTlmWNcu24vyl+LtJkFAKdWjKUDGwYzwAkzxOgEq+ctDMw9QezRYcd7QH8Zx2ehm2JaTONohiHVbHY5TnqP5vehvhReetwy2cnNFVVjhivQSUhkeVWAHEAJRQw22DL28Hn1Og3iwnDsRKQz5/+YdkvyJR+U18xAc/wU0VPDZwR1OmmCS1NRO35eATbOF9nmaMgkdMcA4nIL6gW4u0PakJqYKF3JTlAyL+3v+4RJGvUuwZh9KKzI0kI0kRnbUThldIWUfEfjtHz3dgerr/EvgGM2a29nBFYRpXp71DbDoNufluZGrFG45tMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWM0UAslXye3DnOqC0H7Rz0HZbhdEltQo516tP/V/w8=;
 b=IfeXKddFHX42pkwnnm7dae08Zk0RL0NjFJXmWCegT7mgWrG14D3kwKnRjjbmtRt8FGDptODTacvAkz/LyMq61lpl/kGy9HiyzQ+jpCCXMCpuhxdhCYOTtF7D4rvNbSrj7FEWJh9IoXkk9zyWFQTWu2dS0CRblg/bldk9jwUuEyYzaCu6f8B3Eh2qRsQfJ4E2iA4KZTEce5YqoGNS9+FkkCM3mCR+Gjp4pir7Lyj4RGXOT84Xdh7aFr11wVS0InURYXGl9nAHaXKnP2N5XgcXmsRPaegRqQPTdLCc9iQIou5J5+xbtCe/Soh/9tWw+vv1Dtuc9BCIsyF7sphxlZ1h1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWM0UAslXye3DnOqC0H7Rz0HZbhdEltQo516tP/V/w8=;
 b=f2B0pjsFopWLxQU66/Aq+5Q9DuacZttp6Qq1xnF4kUa+NsWTt8C8osArSHtJb9lEw11sGOU85DiR+gQOvDoMnZcL/nbLvogrS/XHhIlTz71YjCJt0C0filb+MuI6vtlF3ayjlWW+z05YcOjZif8qp5P0pXahpkEhQ71LfMXbaXI=
Received: from BYAPR04CA0032.namprd04.prod.outlook.com (2603:10b6:a03:40::45)
 by DS7PR12MB6334.namprd12.prod.outlook.com (2603:10b6:8:95::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 02:55:15 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::dc) by BYAPR04CA0032.outlook.office365.com
 (2603:10b6:a03:40::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Tue, 17 Oct 2023 02:55:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Tue, 17 Oct 2023 02:55:14 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 21:55:09 -0500
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
Subject: [PATCH v12 3/9] cfg80211: expose nl80211_chan_width_to_mhz for wide sharing
Date:   Tue, 17 Oct 2023 10:53:52 +0800
Message-ID: <20231017025358.1773598-4-Jun.Ma2@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|DS7PR12MB6334:EE_
X-MS-Office365-Filtering-Correlation-Id: 23cb968e-20d1-499e-7574-08dbcebc7cdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2UsX+G6ZMAePLz9pLrlg50qJo5NZDVpyaNvr6vUc79UiMayWZZIVk5uPZH9M/rUHo9+roYcwpD8qx8w/cxpumk11EkaQiKKbT3zbG9NCtwe6G7/R13f0n/rVkKhXcEh1Wxg/neqT8wFSTUYsu7iq9nDT/iNfYVB/YCO/30EGkSmBR8X35TNv3WUFPqLcto4vt+A/XVZlz6NuXenkol8NLvxAgACO8vijdHhu9acVh/2A79TtjT9IrQGtfKaFsAUVwQz/Zg1TrfV/2LEjFR771W1IEG17tKFEscnJng14RtEtgf0jD/xLfqbGBZiXe8WCmakbF/w9NOO+iLSO/nM/3eXT46a2K6fuOQNiQiYB5Hv1ywbvGrZHbV5j+ThDnyj5YtQIFVOf3EvuM/XaPABLF7kgmcDh//u2ugg8rCdmyexsohnM2pET4QDDwJ9lsc5WWELINAwP/6t2FXEIL4arkjErsuwLNwKHSToPS92OJ5NebV7nF8f3eNPaa67FmocqCjHOR2eb+sga2QlEIOPCSD57OB8qHI8YPuwEbWc94KrNmp7SQUR+ZdALGSVcQQCNwiIdpIzqMrA2KD2c/cnnbV813xXMbNbouxf72A1h2LW1kBTnOqdRDkhUP0NQKTeO6onq6DajLpwcttOFBD54mtAL5bbvmuRozTVmcVqte8S0AQ2sn20FFFskwEEEN/sKfJgAMupfhUEs7V80sCZ+DMkJP4RxVKsDm3QbpWEyPfhwurbt7tg/IjnlKy4Ivf0A3k/yfSS5rJ1lXSypHERnEv3yafi2JCwVrZingb0A9Lo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(451199024)(82310400011)(64100799003)(1800799009)(186009)(36840700001)(40470700004)(40480700001)(40460700003)(82740400003)(921005)(36756003)(356005)(81166007)(32650700002)(83380400001)(36860700001)(6666004)(26005)(7696005)(16526019)(2906002)(336012)(54906003)(316002)(45080400002)(6636002)(70206006)(2616005)(70586007)(478600001)(1076003)(426003)(110136005)(7416002)(86362001)(41300700001)(8936002)(8676002)(4326008)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 02:55:14.5556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23cb968e-20d1-499e-7574-08dbcebc7cdd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6334
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

The newly added WBRF feature needs this interface for channel
width calculation.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Signed-off-by: Evan Quan <quanliangl@hotmail.com>

--
v8->v9:
  - correct typo(Mhz -> MHz) (Johnson)
---
 include/net/cfg80211.h | 8 ++++++++
 net/wireless/chan.c    | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d6fa7c8767ad..026d91083f37 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -923,6 +923,14 @@ const struct cfg80211_chan_def *
 cfg80211_chandef_compatible(const struct cfg80211_chan_def *chandef1,
 			    const struct cfg80211_chan_def *chandef2);
 
+/**
+ * nl80211_chan_width_to_mhz - get the channel width in MHz
+ * @chan_width: the channel width from &enum nl80211_chan_width
+ * Return: channel width in MHz if the chan_width from &enum nl80211_chan_width
+ * is valid. -1 otherwise.
+ */
+int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width);
+
 /**
  * cfg80211_chandef_valid - check if a channel definition is valid
  * @chandef: the channel definition to check
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 0b7e81db383d..227db04eac42 100644
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

