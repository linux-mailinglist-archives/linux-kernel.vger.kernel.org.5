Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743017FAA3E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjK0T0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjK0T0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:26:07 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2D5D5F;
        Mon, 27 Nov 2023 11:26:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFP+eYN7WgIZedvzWrGsPB3iPhsFhknVd6paBITexzGv0MoKLn5a2hvHuGvjTmCuxXpSLaWVWD8dfvGq+jSDOBJ+i811wmfYMp63wfL0jl2oAFsS7NoNJcJBNy93UkF9XVTxAqOT5d2cpZtIGNcjwiLgrE+7ydQXotnUHCVEGpuq1JQi3mMAWkU1cWy9yHgNM3g4y2Vak583XMGApqmNigjYleOgr1LBkhWjIioGGoMITjQgMYTBYIhcBnDt4kp9zo3y3v55pwN129zp4LUAn0ctZtqytbc7isYkUGSxrSJffFtDkq9CP9pafeT00+jjPK1qREUYEB1q1wOnKFhpoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9ZrCFErcBAy7Yk6qivLfS3bEBNFGYcPShN6qVOcVYQ=;
 b=QAkPK2Ebu60m0BQK9gUWgZH2gHGyZGMeg/odhFSEQMldRToaO22G8QsLWThX8eyHVebeG4pF0xD3r7nRlGJ4QLvF7YCcsn6z6qeveFrnSE8lY9wJHNOn+O7UZqrZbhibsB/2m6FD39Opx/P+b2ZtSVtkjINppBncwTtQoRUjXYv150Rcz5teu4O8q/095+oxj0Hr957IL4SgccLdf1fjWmzGIkrIIcTdAGeAg2ns+94SbiK8y1VU6t9I1lniIRrIXnVG5GZ06Jsg9iZ6NK0wEwjNZqr9xZF4rbchSYKcavCzFaE7jJ2MrAsuwlbhS84T+fe5HgW+rx5nBLOy6Epi4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=o2.pl smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9ZrCFErcBAy7Yk6qivLfS3bEBNFGYcPShN6qVOcVYQ=;
 b=wjxmWIDxkb6Xgq3PeYsQRGRiULAhJ1bINDqZqEBO/8VYQTkGf5C/Y++fmJzBP5Fq8qzwqNWQICNp44f8FdPlkCN76/HTo5jdrqyBiW+NzZOK6uF+M7UkhVNNzo+qc/tl4lXKjTfKH3yua+l3SvA+EvNFBIeg8tVcIZ/KETl2kIk=
Received: from SJ0PR13CA0019.namprd13.prod.outlook.com (2603:10b6:a03:2c0::24)
 by MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Mon, 27 Nov
 2023 19:26:11 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::ac) by SJ0PR13CA0019.outlook.office365.com
 (2603:10b6:a03:2c0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19 via Frontend
 Transport; Mon, 27 Nov 2023 19:26:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Mon, 27 Nov 2023 19:26:10 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 27 Nov
 2023 13:26:09 -0600
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
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 1/4] rtc: mc146818-lib: Adjust failure return code for mc146818_get_time()
Date:   Mon, 27 Nov 2023 13:25:50 -0600
Message-ID: <20231127192553.9734-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127192553.9734-1-mario.limonciello@amd.com>
References: <20231127192553.9734-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|MN2PR12MB4080:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ddda40e-5f3f-45c0-534b-08dbef7eb674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HMriGn6mpjwtEZt8ZNFHCnDnrRgeAHqrrrJgaNNNGThTXkngszx9JWOrKRMu2xQ/zG+JDACnS5F13/iIPFijtRclzcj12jm851tCsV9AHO7yvVEqrd7HWCOc63x6dKjd5vCqQuu4O5t5NTANtGaKAfRUzVjQJX7Z68AgQsMSAcjFbGIwEED9lJA6Rdfy/Z3r+1WWOBh1fPYaAPj3meF336ElGCLlUZDFa9AqtVfhUsgF4vkYosCKi2PBDu2IcA/g9w9wgS+nb0uiUpVCGq59dIH17QbeCAvh+U0zrydiCU3/TiQc3S9APlwB0GfhtfjyEvM6nVGdw6uC98pfjKtY8jR/JpUfeORDMspi4SwBUbPgQfQkGmTkY7U5v72jU5lMIiKU3fJjzRJOvjQjsgeQbg7jqMmRFAeT2v+A06gY/ezrq2ZrBksghyXkBKkHvdLBRZ+XyXur4XVXTSZ12ukjYUvoIQ++IoTIJ0VtHoWgBfnGis1OHa/SMEtd3C0lqZxOCnnJdm6P48ewgdGosI9FyZcinbnG8z+hdHshHz376YYBZxn98yA1CkK/dZ9o96jUf2l4gmtb544z+heLEzcF5L+LTtP7LT+IA/PHCLN5A03JHuH+wVYFg8FowEYu3vC8FDblHPZZGGcMMv+gqakwC4JFazSwNnEaf27vP7XdBHZI0PTC7d8xsjx4gkVqjejx9u9TsGz7vv6v2Nc6byKm/LpbOiFq4m6TPQY/URyD2rl0wHInwuBjugYZr1OJDrShJvqp8blG6xzLn/3D+7nx+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(356005)(82740400003)(36756003)(478600001)(41300700001)(81166007)(7696005)(8936002)(8676002)(4326008)(336012)(426003)(70206006)(316002)(54906003)(110136005)(70586007)(1076003)(26005)(86362001)(16526019)(47076005)(2616005)(66574015)(83380400001)(6666004)(36860700001)(44832011)(2906002)(5660300002)(40480700001)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 19:26:10.8270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddda40e-5f3f-45c0-534b-08dbef7eb674
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080
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

Tested-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Reviewed-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Acked-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: stable@vger.kernel.org
Fixes: 2a61b0ac5493 ("rtc: mc146818-lib: refactor mc146818_get_time")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Add tags
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

