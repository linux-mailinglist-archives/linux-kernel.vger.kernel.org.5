Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EA47EF92E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 22:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346200AbjKQVJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 16:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjKQVJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 16:09:40 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3692D52;
        Fri, 17 Nov 2023 13:09:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPiDc11S88rDYqmAehOsdtwZLqK61X0llKk0EI7s82cX6uDM4d2a8tjQeZ53Skd2TIPFqmPNCYuIhxsrCJ2u2MwYcvhvTtNBOQZ16s6iViWeogOMeiLoiESsoz5F5sHytq63Kep+6j65zAE6HfZZfHuCK0Ej/zrfojlmSjF3TB+cc5rGtkUOqzABaowPxbaDGZavUcet+PWGugi4+eq22XBmiMf9YL2kYzqQTRgO8CdfaSheNLSao+v4+4kVMNMG+nU4Aj+TRYyV98KblbcUHhKlgVruAuDwN+BPV6hVeSvSrTo+7PxywxKjC5T4NycJBlWKfiXrFTtx3LzG57n0Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A03hEYNcjSS8d1zZbRBrQjX1WYCxxmU5do23a04VO1I=;
 b=gfvpduHihUENmyKihGATb7XVaVofxwlmv77fNMi4HbniTA9NViudODu871GU9yuHgaP7r89Kyfn6hbwZKsFJiwD7VMMmD+z8KL6n7j0is9hFbW5GZpZoBnFaJh0Zg+GAZ4zQWX/+Jy3iTQjRA+qtS+aKpHZLrr96fMDSnX0j2oT1meRc6lI4TCQOgPGZVORJzOs1oGQcqXLKKkqddJ1GNw+69qAkqO4lEIcIWSKs54KDQPbNbfnTnrOucwBQcXwJYIPvUhiNYWsUbuD9ULo7o5dvEPqZswCvqfvI1p/50pWXvMJrgN2fRCIfibidKq9FqawromamXWuwI2jT/43nnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=o2.pl smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A03hEYNcjSS8d1zZbRBrQjX1WYCxxmU5do23a04VO1I=;
 b=DRArC7IMyhKraZrF82FIi2b96Y+bAPfxCBrDOklRh8F04564X++RerrZM5lvVHOlVYxdv9O9ZV+vcXYhXmgBe7sRnGLuzsSepLghdfx3T4L5FDtfLwzjeZYZQcMNwXEBYH2L2YywHOVF5fD/8dGyelFjzKZiXHmifPQXcjd8mEc=
Received: from MW4P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::8)
 by SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 21:09:34 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::f3) by MW4P220CA0003.outlook.office365.com
 (2603:10b6:303:115::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23 via Frontend
 Transport; Fri, 17 Nov 2023 21:09:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Fri, 17 Nov 2023 21:09:34 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 17 Nov
 2023 15:09:33 -0600
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
Subject: [PATCH 2/4] rtc: Adjust failure return code for cmos_set_alarm()
Date:   Fri, 17 Nov 2023 00:32:18 -0600
Message-ID: <20231117063220.65093-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|SJ2PR12MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: 22b4fb51-7f8a-4e10-e1c5-08dbe7b18001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hhbdlTfoobFI+uUJClk3TlSaXhGCNn75khd2qUstz5v9sjNvojd3gB4yvSfITlZIIHi5/kSaNCS4a+UnhSzQGQJDhBPId+/FIFtG21prCKvVcvmXbNJug0MTTZQig3rBeHofTrjGlBKXnibX170bXqXbHoY2YQYTOBvM067yd0Z9L3mubVpIeiycupWv0m6kw011/tU3aD0JFPUNU4PNiykB3d92mbHhVKV0hboKuygNPB8l+0a9yqjUItpmWBagFDMavXQ7ns41l4GyUHFUmPtM3xkFiyjB2sGx+MoTVK/2AmBTGZd+dZAwpuR4fumgcRamRStZZdClDGtvJXUx91hHt/LNP0U/Tzi/FCHUUVpZmHlhnSUiLR+TS26UrtcmbhmrOaVoiV0Yu71zHGqyeWyVpRvTWotUfmPYa7K3M78wRSA1yl0asrn9ZkiweE3pxQ8OjnLLqAqoAPme2YW+/kr2WAgeRo/IroCUOvEKpQXDtgidoyG7yPmTc2SQwCz3qRFMJb3kWCX4ImvaGZymzhKRANkjFrihB/EMo5tHT6rVjequnNDM9C3QZpcK2j/FiccYvDsstIrSGOXLKydmzuxXmmc4wXOFRu9SzddTIl2oAUzuSl5sPiaFe8fqCgqzoilCR9i/x+JTrgG1AmAeQoAYporSalAFlh9XfK9zv+wiR1NSKInqiLXlZQKxufuzuyjfU3ug3dE7hnHOZCSbwH/MxY9td1vLQobKLRPsVr/IeGCF4y4ht4GhmzYfafI/SvwKi+u5vWN0WV0DSgbw/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(82310400011)(36840700001)(40470700004)(46966006)(44832011)(7696005)(478600001)(40460700003)(6666004)(54906003)(70206006)(70586007)(4326008)(8676002)(8936002)(110136005)(316002)(47076005)(36860700001)(83380400001)(2906002)(356005)(40480700001)(81166007)(41300700001)(36756003)(1076003)(2616005)(7416002)(5660300002)(336012)(426003)(82740400003)(26005)(16526019)(4744005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 21:09:34.4173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b4fb51-7f8a-4e10-e1c5-08dbe7b18001
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210
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

When mc146818_avoid_UIP() fails to return a valid value, this is because
UIP didn't clear in the timeout period. Adjust the return code in this
case to -ETIMEDOUT.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/rtc/rtc-cmos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 228fb2d11c70..b39890a5531e 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -557,7 +557,7 @@ static int cmos_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	 * Use mc146818_avoid_UIP() to avoid this.
 	 */
 	if (!mc146818_avoid_UIP(cmos_set_alarm_callback, &p))
-		return -EIO;
+		return -ETIMEDOUT;
 
 	cmos->alarm_expires = rtc_tm_to_time64(&t->time);
 
-- 
2.34.1

