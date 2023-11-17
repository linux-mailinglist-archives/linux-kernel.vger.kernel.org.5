Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B967EF937
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 22:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346242AbjKQVJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 16:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346175AbjKQVJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 16:09:40 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4093EB6;
        Fri, 17 Nov 2023 13:09:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIso42epHChjN3wkzeWimyumRN1A/zLcCWEzbGdCiWu6GdtvDw1spZx7CGt3vJpLSVwEOU+MBBEiVyhxMfiOl5kAQGE3805NQwEqeoIeotCN+1RWRvbVveox6ZDe49ha/6u781s0lDoHs7UlCQ7cBr2roWqxN+xqw75aZwnSnCVcgSolqkPWXvm9JDZ6XXYiNHRlNFxWtBmPLaOyXF1VXPJQnGg3A7iNbZ+qUXuKbUVLzoOH5taVF0pVZSE7cIrijegvbPAKsIbPl2u0A3DAYYcVh2ZVHikTJ1q9dIEuycWtajYJ7rSCZFsgQWFdoml8GyZTcBk4c7aNvddJMJyJpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNMLQ8vk3cFmorweU+R2WqLnIvOWI61uBYh8EvW0MU8=;
 b=bJnyUOc1loOs5MqkTa40BIY7+7Iz8L44cei1sqhjxUiGjQAsc/RV852FUSGi4I3NYg08ptkljXC6ejAe/A9GuUzcHu2gJbhDSocWMtOizFEVsKf+cyULNQKmAj5a6BF6IShY3+mN41AcgXF6ZWByzBNlBvWleN6p9TCY6pMejFGzaefdklzZAzlD7vIt2gBQR9w2wI1GumoD30ye14RzBwiFRVVO0GT60AB3J3zgUx/pu6P3g7DFs6H4e5WjKd6ZmtboGhF4+V0v8NCqgKm0eODvxS4GK/+JZ3UVzjVBlvqXJ/hm4Cw1GJEbGVPB0hhYGXG2O730Jhofk1wsAr1oWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=o2.pl smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNMLQ8vk3cFmorweU+R2WqLnIvOWI61uBYh8EvW0MU8=;
 b=YdRZdyENutQtdNOk3ZKj98mfhL6UObIjH6RiV5PrLJd24tqr92hgiO3qiaOP2mE3hzGCwvDbTz6If3FLcJ7aZ2VqkafD1KVR6SYIslG03uNHG+bkTZiNXH2bkH8gaABGUTrM5+XQayD7YRrQbxuN8EqIBB5BJCkDZyiGNb3lCdo=
Received: from MW4P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::7)
 by DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 21:09:34 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::6d) by MW4P220CA0002.outlook.office365.com
 (2603:10b6:303:115::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23 via Frontend
 Transport; Fri, 17 Nov 2023 21:09:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Fri, 17 Nov 2023 21:09:33 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 17 Nov
 2023 15:09:32 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <tobrohl@gmail.com>,
        <aalsing@gmail.com>, <Dhaval.Giani@amd.com>, <xmb8dsv4@gmail.com>,
        <x86@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/4] rtc: mc146818-lib: Adjust failure return code for mc146818_get_time()
Date:   Fri, 17 Nov 2023 00:32:17 -0600
Message-ID: <20231117063220.65093-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117063220.65093-1-mario.limonciello@amd.com>
References: <20231117063220.65093-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|DM6PR12MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f5154f-c65d-4afb-22fd-08dbe7b17f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IA1JYvfGHFfWxnM8TyeLhOwTBhbAs0mX4/LluHTLgSxkt5FNCQ/VgRW+5sp6rIy8pz6nshIVZglfkxfRc5xZQFIJvnbQjb22BXMJHfezl47TatqO1wUoNfmNQWFmd544yNIduzoQvcNVeK9F+KdSdMhnPBspz+/t2MlQohzWLnV5LmwuHzYVFWtlfCEgwKKwOLLx0E6gqUcjziEoxmcb8CSozVfFSbV1VilLmKTViB/pjS8p4TcVK6A9yUEOePtf4wxK2c9VdsBvYMEYNhe2E+sN5FFozxhTZWIFkT0/rYznJ5q5XcOiLPfr6d+40cwCHIHfYTQ1/HvCKSxk05tNamIeh1WjXRFVVZDjeb1mKVGtlDZE/0jglkxGcNQGHNp2IDhOjDqC93QbjPIBon22ncW07u8ea8coWsrnH4QRUWtu0fEpoeMK4YQvR6bxAwWwQjVp5xlye3dxot5cnjtEGxnv8Pd/VNLPiL86KB4VnzA/PPFV13Ikgr2kneWq6jJY14irYMl8GX2azYx7pitQ/eRfhnBI0j2BY+yiE76X4mQYZSqefY/Z5OIav9gIF78vR1QypwlDY8/NKO47GsPysh4uklkP5gP+9fhqZurIM/ML2X2fY+mui60Hqc5TZBvoKSMHXudaQSH9KsKD/IySsLwCzHW2h5Qkfoz2EzdK/oUJLDxud4zX0zL9GRvky8htajqIChyErkkLKZ/nC/FSSQR8wFKCdvoeBwh0qhNaxt0xhU4Qlzh+xDU5XbHwtQxocWYY5Bqfprm3Bsv6e+SzUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(82310400011)(64100799003)(1800799009)(451199024)(186009)(46966006)(36840700001)(40470700004)(47076005)(7416002)(2906002)(4744005)(4326008)(5660300002)(8936002)(8676002)(40480700001)(36860700001)(44832011)(83380400001)(16526019)(40460700003)(54906003)(110136005)(70586007)(70206006)(426003)(41300700001)(336012)(26005)(356005)(1076003)(81166007)(36756003)(82740400003)(2616005)(316002)(7696005)(6666004)(86362001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 21:09:33.5891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f5154f-c65d-4afb-22fd-08dbe7b17f81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mc146818_get_time() calls mc146818_avoid_UIP() to avoid fetching the
time while RTC update is in progress (UIP). When this fails, the return
code is -EIO, but actually there was no IO failure.

The reason for the return from mc146818_avoid_UIP() is that the UIP
wasn't cleared in the time period. Adjust the return code to -ETIMEDOUT
to match the behavior.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/rtc/rtc-mc146818-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mc146818-lib.c b/drivers/rtc/rtc-mc146818-lib.c
index f1c09f1db044..43a28e82674e 100644
--- a/drivers/rtc/rtc-mc146818-lib.c
+++ b/drivers/rtc/rtc-mc146818-lib.c
@@ -138,7 +138,7 @@ int mc146818_get_time(struct rtc_time *time)
 
 	if (!mc146818_avoid_UIP(mc146818_get_time_callback, &p)) {
 		memset(time, 0, sizeof(*time));
-		return -EIO;
+		return -ETIMEDOUT;
 	}
 
 	if (!(p.ctrl & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
-- 
2.34.1

