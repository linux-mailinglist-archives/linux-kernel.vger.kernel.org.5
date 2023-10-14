Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B7F7C9739
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 01:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjJNXQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 19:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjJNXP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 19:15:59 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E7ADC;
        Sat, 14 Oct 2023 16:15:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIHnUbYMjufmr/GjGFgs7CEliyji+u+IqtORT4A2zuL0SzARXxLfitOcXixdLpWHJDxCxtLvP0DWHOgIvihYqmnBlYQU3ZeLLFszA0P0p1GnxXmG40jSXgPT/Bv+bxgCGCEkRwJhZhWJMbWm5RugzfmdYY9gD2iCsgJ/Mw+9/Ihh33TUptwUfzJqYZ/cBlwKxybx4o57M76jMR3IrJMm5ge2+oWlS/hdidinTtHgpEXRq9vwABxzm5mmJRZtLxk82mMqdfq7cCxybIOuz0u9HCJfyou+xh7nPpApXRBIQWJqbhhaHSTMSoePwSqIMiV6lzSw1b9kTbhgh06DQ42Z7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpsNQc9oclzCEfPjRsXgGNZNh0auLcZ5wh7TxsYLIVo=;
 b=c5dZoLLK3BUfTOzsNPEJpU432+KNdi+IQCEjycWzK/ipzhrzrMMLqCFrqTuuFPBz5GLtXSXZgxIJDG90fl60NdLMdB1ver2dbRsdwDJbGcwZv2vSQMc0m8U36eZaeSKHyMGS6E9HQ3NqHHKT1sMNPRMO9vvJ1XePVRXEymv+naAh3feXmMOJEHWhJL9BSs/phtKRe4k5S7w6zXueVBJQKwcwiikNlbtTboLivbYFy0zAz1lVm1fpvJpW1wdLo4IjEUnpeHjzPCfHZQDGjh2vnr1DG532JH11pU7Y/wYUjSxWwg2+1Cv5wTh8wVd+MNWlb1tFAZeA5e2g1PjTcUurMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpsNQc9oclzCEfPjRsXgGNZNh0auLcZ5wh7TxsYLIVo=;
 b=GcwLzIqa2BOV49FD/Z7cnLX8Wc9hIUn5W5bRs9CMjj3PV0GOozvOrUYyH/aJjZGaAxzzr+pCav0Jm+VZCpcXfzqwXnG1T2HmWtumlVHYFlz2DEgcpA6bYk+X5+Qpp3JfKpCx1JeGhtF+JrN2dPIO0uB9ynSrhq5i8N+l6Ev3f1A=
Received: from SA1P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::22)
 by PH7PR12MB6490.namprd12.prod.outlook.com (2603:10b6:510:1f5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Sat, 14 Oct
 2023 23:15:52 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:22c:cafe::b4) by SA1P222CA0007.outlook.office365.com
 (2603:10b6:806:22c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Sat, 14 Oct 2023 23:15:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Sat, 14 Oct 2023 23:15:51 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 14 Oct
 2023 18:15:51 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Sat, 14 Oct 2023 18:15:50 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Tanmay Shah" <tanmay.shah@amd.com>
Subject: [RESEND PATCH v3 0/2] remoteproc: get rproc devices for clusters
Date:   Sat, 14 Oct 2023 16:15:46 -0700
Message-ID: <20231014231548.637303-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|PH7PR12MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c6eb843-fb5b-4dbd-f9bd-08dbcd0b823e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gbeCyi5ycusMmClGS9d4dRD3z3yGu426WT+hUvIchNVDZUh5RrouaOA0ID/UMxmuyYIvCD3ba3qxMSed9n/rkuycpG8cAPnAnn3zktiJyTjRMnaxFpi782YPJi1KY86kvEO4WeU5ezF1+zYL6CK2psefFWiF89FtkqvhPPxY550Z1z4WVRTxiDGf+nC4z9UkxXOdS6QU0niHPSCsEQYw+od0mz54IDSYJs8eWbfK3TEmzobCyPvYx0f63XCn52gsNWIqbuKYFOg5xv5QD211zRJelupYemUajD/vSC6GqeJo4jmcwlDxErTreaxOGOrP0/WzoCf64iSg2ksttNKnWJJq+eP92YkKDS1aqP4IwdfT0jJgJ1JJFdznWFOEzyScSEdJ+ZkEn40pRKlIBrwWnvpwD/HiBIB7yB1evGBNeb+a/4wBVETZICcacms9+mCBkUWUNcGygRUaQs0MVezWAFEhFs/tJgzjOGi7b2AIThuAaXAA4bhCnkWnZqT4I0lBC9kzI/+d5fPpKvSYAUN5ZB3m0QWTtOBfT/IIBYXOR9DCwwJdYP0M8Hu/HvoOOzTRm6JQfiIAPIp1XScXxbfHrMOVC+WYhJ6yAtbmL564WOuTEbout/GP+ZvWULNWxpRHctu9OBI23qGJ8vbKw5esBz1Dty1s7d4STCw7Em01Exl+Utx/L5kGnEgHUZ27VEON1l/HTrP1KV9Feq/FwrbquhuqbBLEwm2lYK58z/Rik/6mnPV0DukC+A7aMByXWWgenBMaRI6HtfEg68jqscK5Sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(110136005)(70586007)(316002)(70206006)(54906003)(26005)(1076003)(426003)(336012)(83380400001)(36756003)(2616005)(40480700001)(356005)(82740400003)(81166007)(86362001)(36860700001)(47076005)(966005)(478600001)(6666004)(41300700001)(5660300002)(44832011)(2906002)(4744005)(8676002)(4326008)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2023 23:15:51.5931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6eb843-fb5b-4dbd-f9bd-08dbcd0b823e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6490
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series extends original patch and makes rproc_put() work
for clusters along with rprog_get_by_phandle().

Changes in v3:
  - remove module_put call that was introduced in the patch by mistake
  - remove redundant check in rproc_put
  - Add inline comments in rproc_put that explains functionality

Changes in v2:
  - Introduce patch to fix rproc_put as per modified rproc_get_by_phandle

v1 is here: https://lore.kernel.org/all/20221214221643.1286585-1-mathieu.poirier@linaro.org/

Mathieu Poirier (1):
  remoteproc: Make rproc_get_by_phandle() work for clusters

Tanmay Shah (1):
  remoteproc: enhance rproc_put() for clusters

 drivers/remoteproc/remoteproc_core.c | 45 ++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)


base-commit: a7d272979d3a89b117ca2c547dc8a465c4f28635
-- 
2.25.1

