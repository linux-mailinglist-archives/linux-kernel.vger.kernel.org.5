Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CB17F1573
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjKTOQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjKTOQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:16:24 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C84110;
        Mon, 20 Nov 2023 06:16:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDwtTK7LRvrmhVJBFF0SrCZG4Ehfocggf9qL/k+eqYFLC+hkDIw/WjdI3jf2SdWNy99rze0chMn04c5Lb3EyCUQrskpA93dSpdRQDJ+aONPtg0jTcNVnzaQouuLxVNK7mp5vWfqA2tC7HwmwRWo74SpPtfVBAI7eyerbattdJJ7hI0eI6AaFCIIW89quV76dF8Jjuvfc30J1PuyAOtOuiOQh0WuYro34FObAQkAf2mAa/MCRhZ8ZKSnM/q61MAjqY8DqkeUmW6PQNFZcy7/PHxZH8+LcWrdHkqDob+lYFAT+TxdoTQsx3+nh/OWw/HHnsD2/i3PtF8vJPpKN8fJy8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AQ+mHof3kjrxEz9O7jMsJYhFe655aK6wk5/P6yxx+E=;
 b=dpmdxfRYmpzIP0Nae7p87BcmqrSqz5VAt4OOSzFWym5qJzGCI0QJzJg7gk7+uzJ10d0rIFl1rO1iCWu33HP7WL59evhz3uVPFLZ9DfU81Pd2Nt0p4WhwckmUayLywykyxXes4NaV57lOtgJyy85Amht/s/+yi2NpD1R61/FuXLHua2WI/G7bwc1VhjMJGqZTUKVtogFvLtid+b1Y9HFptMCK3tkGzAVtyLZKuIxODMUNIdTR5j1MtLxJIdUooltac52wM9HPvXhd4a5/8+HNKoF/7wTG3g9xBP35Pyngvobv9LAeKckfQuA7hDBt5804bgHKvlP5ElzC39WbQ4XoUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=o2.pl smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AQ+mHof3kjrxEz9O7jMsJYhFe655aK6wk5/P6yxx+E=;
 b=LN6qFNNtaTVj+eJD0qtgZwMN4AxYFE2AV5BqX6J21rQSMejIP7F61nXBAfo800/4rlCZso0TMFqwrt0WNq2VPoAmn8xWk8Vx6KjNrBIPlSD3qIkU4maFK3WNFWVBN1syj8jE7EF3oDW/QvQ0uYhn0L9uuaWQH46/BVri4hEp2yU=
Received: from CY8PR12CA0058.namprd12.prod.outlook.com (2603:10b6:930:4c::23)
 by DM4PR12MB6662.namprd12.prod.outlook.com (2603:10b6:8:b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 14:16:18 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:4c:cafe::67) by CY8PR12CA0058.outlook.office365.com
 (2603:10b6:930:4c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Mon, 20 Nov 2023 14:16:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 14:16:18 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 20 Nov
 2023 08:16:16 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <tobrohl@gmail.com>,
        <aalsing@gmail.com>, <Dhaval.Giani@amd.com>, <xmb8dsv4@gmail.com>,
        <x86@kernel.org>, <dhaval.giani@gmail.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v2 1/4] rtc: mc146818-lib: Adjust failure return code for mc146818_get_time()
Date:   Mon, 20 Nov 2023 08:15:52 -0600
Message-ID: <20231120141555.458-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120141555.458-1-mario.limonciello@amd.com>
References: <20231120141555.458-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|DM4PR12MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: b82c310b-9a2e-4a05-79ec-08dbe9d343ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jL9RDqRQFso9fznOglG/9zPPG7NJMns+JYleJBDWBXlEEhAZE2gp+3JnKGaYfP5Ur8y6v7/sHHXQalek9TAzfW8XyZJdsttbEiBHJS4Wp/S084N2yo+0Zw7IeBpuomOVFoXRBFWQ39p8qWFITWNrpPxtODbYMlPWJf6zTYAJuG2eyebyiQ9BvcWQcZrYz7Y4UNV1c4j3Z/XlwRJgIwtF4iv6hD9pSHuMXWG5ZC7kXK9ob2QUbjPylrMhuYXg/00h0AwyqN2EBDSBouIvKfN07oAMvpEVtLtx4vOuTtXX0tgOMoqg6CYEEtpAXN0NBWoRp3j/QtciCES0+xtFpjvIgeZCOIMPGQV56BFL0tgg0YCG+mtha5OQ22SMtD5XuPBCqfq3g/eN3eZpDBfGN64171+VgjTlxTLENn3vdyUVvWZixRZxW9MBc16/RTls+qBub/a/rqFyuQ5d1Ji0niq2S9L7vSmgpVfHW2EusbzvgBA513zCJmWPfGwsg9GHtsfxCDvAlhujnChwKrLm9pu51xIvtIImePfsZgo3dqrL8Hd/pziLnX24fPpQoP4Dneo0Hit514mu1mbP6zNdXpqO33ldLAZKv0/I+dUiSHBGQ7aiCLPFI/DLu20i7aSPt7iQiM80kdpmBuGSrDTeCG0Uq4j0bXspGsSwnjDg+/VklkJubKESUceBwlatPN+s8UmfrYZfL22ZDibddsuBoUiFm3Qxj6hiW64f37A7vWGUU5zUF7qCuOaDfFWafFEWSinAoqi5ZB2mv6BldVHZz4qSmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(82310400011)(451199024)(64100799003)(1800799012)(186009)(36840700001)(46966006)(40470700004)(40460700003)(83380400001)(426003)(336012)(26005)(16526019)(1076003)(47076005)(36860700001)(4326008)(8676002)(8936002)(41300700001)(7416002)(2906002)(44832011)(5660300002)(316002)(478600001)(7696005)(6666004)(110136005)(70586007)(70206006)(54906003)(36756003)(81166007)(86362001)(82740400003)(356005)(2616005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 14:16:18.4933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b82c310b-9a2e-4a05-79ec-08dbe9d343ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6662
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

Cc: stable@vger.kernel.org
Fixes: 2a61b0ac5493 ("rtc: mc146818-lib: refactor mc146818_get_time")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Add stable and fixes tag
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

