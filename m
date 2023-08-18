Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C06780490
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357637AbjHRD22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357620AbjHRD2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:28:05 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614FB3ABB;
        Thu, 17 Aug 2023 20:27:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBbi7xE67S2I8VQs7gnzkbc5W2Vhf/IIRSzx/gsWIee3zLENSFsHnrPkuAuJvmR7bJpZFJ7j4laEvLAQL2pWVJz8iliOMJNbuE9Z9e6MsXlEZJad98Q0mwx44O7TbXcLKD7E7q64+ZhbjCqXHcjji9v9Vo1P9TLGE6n1hO64vAXgrjambPbKbY2Zxc7R8BNa0dXV7YTyqf77wcNdtgPHVrlvjD4XU/TiwCZ9Yh2jRHPmndV0JqdvleuSn/LJSZMSRjIK25yHCYfAnopYHi/vknPGt8JXemavW0muYASiTyqD4eO/irYOIQ0GRueMpfJgnmLepMrJ6cfcjQ5ASffHRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qu7ufWBfNSNsnpJhj/ftM09iZry5yoIJIMA8q53g9Nk=;
 b=lSswSN2F+XenLfzJZtVb/Zx0eoW9f7I2VbWYZNJktRm0GPBf1C5drIuSg38eqEDSrQ1N3e2zCQm9/bn1bW5eGQbgFgFytHrKT7bdEo0sJfja+ol5bAqMjjgsJu8UFCSK+bS/yMslwZEU3qTDKI3w38rOmX5LjQvvV2xHTI4SZwyWSzPIAlp0wGyPaYp4vBnbLD7RAemNfo6s7P2175KBJtlr0ReFo4AztdjbgXs4QmIi9lo+LF63Wd8WcWVme+wzOEWz6HGvMXRqq8NJFvfpW2ikgzpMQp67CYtE/ucNnzCgiX7UZXlRoct2QqJcYam8JIFgC90jTNLpm14naIk07Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qu7ufWBfNSNsnpJhj/ftM09iZry5yoIJIMA8q53g9Nk=;
 b=iPwBT7WAaKdtYbZXtGI9oHBsxXLj7sysGqEKjH8Nu2R2kFPyb/r3PW0eGeyYwhHReBQ+UAlRIkFJIgWA72BuIVai3haDbIpfx1kfD8l2jhZdG7rE2OHsyZUBYLESPZ/pRisGLJ4o9rK+qf9ZC3cfFT7NlAdlrvsYzbxc5nu6tIg=
Received: from BN9PR03CA0768.namprd03.prod.outlook.com (2603:10b6:408:13a::23)
 by SA1PR12MB7127.namprd12.prod.outlook.com (2603:10b6:806:29e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 03:27:35 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:408:13a:cafe::db) by BN9PR03CA0768.outlook.office365.com
 (2603:10b6:408:13a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Fri, 18 Aug 2023 03:27:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 03:27:34 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 22:27:29 -0500
From:   Evan Quan <evan.quan@amd.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <lenb@kernel.org>, <johannes@sipsolutions.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <alexander.deucher@amd.com>, <andrew@lunn.ch>,
        <rdunlap@infradead.org>, <quic_jjohnson@quicinc.com>,
        <horms@kernel.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        Evan Quan <evan.quan@amd.com>
Subject: [V9 3/9] cfg80211: expose nl80211_chan_width_to_mhz for wide sharing
Date:   Fri, 18 Aug 2023 11:26:13 +0800
Message-ID: <20230818032619.3341234-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818032619.3341234-1-evan.quan@amd.com>
References: <20230818032619.3341234-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|SA1PR12MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: a707d574-d416-430d-3590-08db9f9b108b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w6l4aOohbJtNGKJeVfQV9/tqgLBWMiet0XJSRxkZNyZM28K/CdutILd19VVjnSb4YzkKu0xE6I5UfEhRbz0+rQ5BCUS9dBRfAgu4Q1g2j6kt4tHhvPA6YJPbuckKbOkxe4JxQt5hb9y5C6r+RZQIz0eOObpHx/MGo31YfJ6q78A/zDufILteMbz+9+GPgHUU0C2HVqjrzzND9eZIC5s/r5U16w/bY4M/WoP53JOr5qmsTzqTMZ4cvMLQefideO1jLbvN6j6LRii1RO97jm8zWEuV5Sjisas17VMv0lb9LNkIuzMhyyBmM2qYrLlTz6X4zaIXOeWTiNP2WjU/wvV5wYCtdPeWDYcv0MAw10otD5sFdMJaC+HsweBVKrd5t4K89h8Sb8lrJF1lShu3Yxc13keh35lQq06eaSDGS7rugdcG4AEemxSCqxGR5cI8qoWbKpVFiBcWkKonk79XUkx1GaeCWFy8EKVNpjQNQr7KhY5FICqqjdb4YeCfBiVl2W+6nkwCXUPhX4Ue8vkkBw7trM4jXCBlLU2h9GTJMR607Bz3KH14rXvFD/1dMAy54RgHV5fk63OunaZOjfNVKlmQbb49nbU3EkBNPCb9L6y1lI9p2IAUJ6tCi//S8ajs1Q15TJqXQcyKyI+xe6920oI0ULDEhCTsOscZt4ryxVZoDsv/x8o73w6wn2bOEj8a/6ErbomSh7DXpw6fm1vu2cdKAtEJcbPBXllr26yLv8301h8ud8MXBzrQ31rN8twG8zIanc56JEB0Jqmp2+qeb/35p4+jv+7cWeZqFC83M6nurC9F2tZQJITwTPb4Crh4k2+dl/rorYc0QDjU0tQXKZKF0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199024)(1800799009)(82310400011)(186009)(40470700004)(36840700001)(46966006)(86362001)(36756003)(82740400003)(356005)(921005)(81166007)(40480700001)(2616005)(5660300002)(44832011)(110136005)(16526019)(70586007)(478600001)(70206006)(7696005)(6666004)(54906003)(316002)(26005)(1076003)(4326008)(8676002)(8936002)(41300700001)(40460700003)(47076005)(336012)(36860700001)(83380400001)(7416002)(426003)(2906002)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 03:27:34.8738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a707d574-d416-430d-3590-08db9f9b108b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7127
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly added WBRF feature needs this interface for channel
width calculation.

Signed-off-by: Evan Quan <evan.quan@amd.com>
--
v8->v9:
  - correct typo(Mhz -> MHz) (Johnson)
---
 include/net/cfg80211.h | 8 ++++++++
 net/wireless/chan.c    | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 7c7d03aa9d06..8c2a9b748621 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -920,6 +920,14 @@ const struct cfg80211_chan_def *
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

