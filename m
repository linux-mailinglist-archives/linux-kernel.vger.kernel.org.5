Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C8D7D9F99
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346249AbjJ0SMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbjJ0SMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:12:10 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A639AC
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 11:12:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgLox9xEDb+49vR3APmjU2P4XAHGL/hNTpaa2brIOaP4hWVgxaHOLPwpEHpNh/p/IhteXxTTwcXdGolv4K0cZvc5Ki8i7VW0baqqgu4kS0cF7M7yKt0zhGrDAhGzFfVf2e5KorTOXaAwYV39/x+R5ihSbZhjTjt9Hr8g08S4psJ/03wHhcwUCeImbIPAmYBM96MZDj2FAKYEVPTO20c7oD6mhK9M/vjRaLZYfloki2WapkbxpgapzGtD/xY5DvRZfdoBQ82TrkZvzEMIkU7F0JP+L9QyRVQsx87KtidTNybc3+MnV2b9unYTFmv7dmilXmAHA1xd9uhmlAWtN98j1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rf6aFWKk2WNk6+2Cm9guoLcKkK4BdsXzquTr2TICsP4=;
 b=MR4nTiOZ8YzdGNKFmtuBvwTEIi5W3Tpwl+kBRXQroS2qtvzjNKJ+Dkp/tMfdCzX/8kAtwnNpoIqV+0GTKrOsnFffytsitUMjp1GcjnweguElGUMrtkPAlnQz4Zy9xOCqjbbRV6Kj6mExn81hMP7lAQSwhOZKu0Q+gg3QqzWdddh3o/4qwgj6k46lZDo8i0gFZ/ZXYIwjvFGg5OmSvkbItPKQ6pr+oHJgvzSSZAWyhjDiWPGzW+qhKJSQaSijDc6ZgEqRG/rKJeUH17yiPFJUMxtn4XGZeYfKXJ5eRI42NSVOCqrSmiwHyAkzUtOUb1yPLK/TG6ro7Xwujwl6eLMuHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rf6aFWKk2WNk6+2Cm9guoLcKkK4BdsXzquTr2TICsP4=;
 b=0WT1JQVtnk7dWz5KiRA42i8dgyxayO0o2matjv84/NGkL11rDTmWmFQT3s/ZBsnbk/xiqBAG0rEhEiyMKGd+puUGmZVlHCef/GJDqmhWou2JTT1jQxiHoMf8UhwZpp5IVJjMuOrJ8E+p/is+vTHSWB8VWl9+KvRCQ/enqNnX4Mg=
Received: from PR0P264CA0062.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1d::26)
 by BN9PR12MB5196.namprd12.prod.outlook.com (2603:10b6:408:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 18:12:06 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10a6:100:1d:cafe::63) by PR0P264CA0062.outlook.office365.com
 (2603:10a6:100:1d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22 via Frontend
 Transport; Fri, 27 Oct 2023 18:12:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Fri, 27 Oct 2023 18:12:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 27 Oct
 2023 13:11:58 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 27 Oct
 2023 13:11:58 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Fri, 27 Oct 2023 13:11:56 -0500
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <michal.simek@amd.com>, <robh@kernel.org>, <arnd@arndb.de>,
        <ruanjinjie@huawei.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH] soc: xilinx: fix quoted string split across lines
Date:   Fri, 27 Oct 2023 23:41:35 +0530
Message-ID: <1698430295-2731040-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|BN9PR12MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: b623af95-e53e-44b9-7592-08dbd71839c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4xkaqJGC459yXqiUvTsvamqPGXqjjZmESEDncwAd5dZuBLLLLHcVgoSbtSbSCIx9b5ODui94U4xKU1wFTsNbbt94mRAwAHFBGq00VIgMIiHwDn+ROdP+La99ilmWw9JgxQodZDNrV+7eQIsg+RaDM01MW/8DSdBiLoCSPqGlScZAMaJEYgH8kREtHbCJOodhPOMxy6YVjErbQc4xP06hZJ7myA/Ys8Vd5Uy750RXArMls+K+JaxkBvUf9oH8N4PE4YY1BUBhOzM9pxeebS7ccOMyp5E8cAjALzGyM1BZI54E2JW7IVK0Sa/femSbT//tArkqJQy9fjCwUXQ2TMGkmWScK40q2zQ1J22Y7vN2fwWlccutHeB/uzMMicqKPGzWvbfufhwYeoO/MM5qoLdi1E5Mj8K8OqZmPYqiqaSOuSwT4epD/QMEnPfkqlVCNTmxlmSVnP/5mT/JbbyEXf+k9/+PesqpST03hYKwNJ6W5ZtzCWq2VWNCbEvztXLcSD3Zge3CAKQmtAvh4SOLI/moxNQ3erQ8CCIEc+93glEtNDxyU0YQUDnQN+dxZEwIayCg01fsoUB5lwYXbtF0rRk0iPojbyjJ8BXvUsHwUYOY60A+G1pFkGM4+pLIWI4qfhX1R+hDcpUhy289KLj72I57Yj980BRFDeOtkj00tn4WuBiNMvvZ0/J35UBS2ergyl8/nljdVx6R5AsJ8GHwth7PiSY4dC0sjq384J/D/vhri2HDZ6HrZxSJ2TTwcjGF2BClVl2I40zG3m6TJhqj9RLi4AKT+S4zafplEuhTms5M7DShI37oFSLXMaJ3yhYJczN5
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(230173577357003)(230273577357003)(451199024)(186009)(1800799009)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(8676002)(4326008)(5660300002)(8936002)(70586007)(81166007)(478600001)(36860700001)(356005)(86362001)(36756003)(2906002)(41300700001)(70206006)(316002)(110136005)(54906003)(40460700003)(40480700001)(83380400001)(426003)(2616005)(47076005)(82740400003)(336012)(26005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 18:12:05.0861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b623af95-e53e-44b9-7592-08dbd71839c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5196
X-Spam-Status: No, score=1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Simek <michal.simek@xilinx.com>

Fix checkpatch warning "quoted string split across lines".
No functional change.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/soc/xilinx/zynqmp_power.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
index c2c819701eec..1f8fe3d4ebb0 100644
--- a/drivers/soc/xilinx/zynqmp_power.c
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -83,8 +83,8 @@ static irqreturn_t zynqmp_pm_isr(int irq, void *data)
 			pm_suspend(PM_SUSPEND_MEM);
 			break;
 		default:
-			pr_err("%s Unsupported InitSuspendCb reason "
-				"code %d\n", __func__, payload[1]);
+			pr_err("%s Unsupported InitSuspendCb reason code %d\n",
+			       __func__, payload[1]);
 		}
 	}
 
@@ -252,8 +252,8 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
 						dev_name(&pdev->dev),
 						&pdev->dev);
 		if (ret) {
-			dev_err(&pdev->dev, "devm_request_threaded_irq '%d' "
-					    "failed with %d\n", irq, ret);
+			dev_err(&pdev->dev, "devm_request_threaded_irq '%d' failed with %d\n",
+				irq, ret);
 			return ret;
 		}
 	} else {
-- 
2.34.1

