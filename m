Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B2C7DA07F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbjJ0Sbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbjJ0Sbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:31:37 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5AB30E3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 11:24:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCRxLfHLVy8BIm0i5UY1QS7bDIGs9RUaYZnvyGh5jIXGPduyeWn+owDuTnXolBMbIfEVd4JHndFYPPrKXfONOTIkRwd43bWagPpZ2Rm9jX7Y14v9O1eoVOcTZArpKqHhih2dZlhDMsxtykto4uttUtDuYohSb44plEyaEbvh2z/Ik3pUU7Xawx5A0mQs8RFYNVpNqFy74LZOV4f3EtSt5dZMVG+3eTn0L+YX7t8SZKEznuwEHluSTh9GGpWsfeVXWfLDgtR1e3OBWZ861FcNqlJnAuAIaPdOSs5OELQbE2RiRRTjStTaj+OLt//yzOipu0l2zJwlbcSu5EH5oq1dEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMA+UxbfldUCe8PPWe408b1BXD1IHlFnVLXiFtKPcKo=;
 b=SB0eicxoQkJhsqEWFI6j4or+9/Dsn/sjPS+4DD9d2z0o+AgMgCVRJaW6zSBr8PJ/+XJ6lTrnS1y9fCnW26n4XuW4/iXOv1m4bozu6gGQaBnGIEmuIGoMVudz3T+r/uNpeWt1ImngJmDeirOSq92qV41p4VwQYDBmZFT1AnzsdgfRoJHNLnU0K/jOHLOoaSFoxbQ62IZ3WZYePJTVs+RUWLceb6biLJupG282hNnejtvd38UWTtwtX2JW2QIWnlTCKDNB+gWEANXIffXQ0cFltoY67ViDaE2nUlqs6k7MAIO7gArNoy5/Xsuosu109JehotkRyspDYK3/LrLtcPHFYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=xilinx.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMA+UxbfldUCe8PPWe408b1BXD1IHlFnVLXiFtKPcKo=;
 b=kUsb+VC1miNsy7dzgIdmOpaKuOtqwn8V8cwDYsq8uc+1GiYBlYZPw3XJ+ZIBoVAelwIT1/GNvdvLtngDupHugtJ9kpCyTsIRanPyywVa9/5T2fq/wRSz9TNPTT7tW1Q7axBDiV+tkQFjrNPUkru+zFisxU46mZVQjxrvVF2MDXw=
Received: from CH2PR08CA0009.namprd08.prod.outlook.com (2603:10b6:610:5a::19)
 by SA0PR12MB4560.namprd12.prod.outlook.com (2603:10b6:806:97::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 18:24:09 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::d) by CH2PR08CA0009.outlook.office365.com
 (2603:10b6:610:5a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22 via Frontend
 Transport; Fri, 27 Oct 2023 18:24:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Fri, 27 Oct 2023 18:24:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 27 Oct
 2023 13:24:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 27 Oct
 2023 13:24:07 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Fri, 27 Oct 2023 13:24:05 -0500
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <abhyuday.godhasara@xilinx.com>, <michal.simek@amd.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>,
        Tanmay Shah <tanmay.shah@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH] soc: xilinx: fix unhandled SGI warning message
Date:   Fri, 27 Oct 2023 23:53:59 +0530
Message-ID: <1698431039-2734260-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|SA0PR12MB4560:EE_
X-MS-Office365-Filtering-Correlation-Id: 83bbf8d7-c6ad-4c2d-8485-08dbd719e964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RvHop7bqCr+zJKKtsVMo2JuNt4MzWcE2pP7ONCcuzILQfGeQMHOl/ypqK5drui2q3m2hgO9aDTZIkrqQp0Hs8Pp1FBhDLBx7ztjEYhyJqUS/Nj/UxOmo/UAO4cD8X5tHXsUuEpceRJhcdYSBwP5VwRwVJrx9yX/J1CGJlm7PKoOH3QDNea4KY1fB368CqrnHptevnYVdemwWxljuToS/hE8AOtsfnoRO1qvEf+GLXOf4BLPsbkub6wFUFGK5lkylJ7Av+OvdQWFVVL6gJvE4Pi4I2klExqj9NinG1LnmyXlVprJSFiYJTOb7haj48zYPeeZaibJDkE/iq+2v/UepbcKjHqQT/5Jr522X71hdh8yYnEcWK//6Ao+XWXMkEUh46UfakR7E9hzg8l/FK3EMB1decglwfKRTXd/39d+9hIfhst6obruBUD7Yr/37ytqJgOFZHL8Pa8wT226MTDr4r8fgYWSks3i69XN89KlBJvghVSnPk7l8ajM4Wl4SCnCZo33pRHRRmr2tHnSkAQv2axV2DTDBf9t1eokCQyfPVCtJ5WasCt14vPR0Hpcop74gN+u3u381SgYEzvoeDgbE2fY+ogqQYTDanYIBVHPdENpVT4l47lJvaVqij4t2FRGCS+8HqWrmsmacR2crLkTgoM4yMl8UcZe6MClW0SLMnayjXbnR5n3FuG3/u8APq06HdgKHUlxb2p7A8mT/9yurb7Y2479G/Rg408bOGj+zmGlMBBIGcIt7WSGbHYIrnhEqAZS0gmBZysgvY+GRB+aK6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(41300700001)(5660300002)(6636002)(54906003)(316002)(478600001)(2906002)(8676002)(4326008)(70586007)(70206006)(110136005)(8936002)(6666004)(40460700003)(2616005)(26005)(40480700001)(336012)(426003)(83380400001)(47076005)(36860700001)(82740400003)(86362001)(356005)(81166007)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 18:24:09.2109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83bbf8d7-c6ad-4c2d-8485-08dbd719e964
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4560
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

From: Tanmay Shah <tanmay.shah@xilinx.com>

Xen broadcasts SGI to each VM when multiple VMs run on Xen hypervisor. In
such case spurious SGI is expected if one event is registered by one VM and
not registered by another VM. We let users know that Unhandled SGI is not
error and expected if kernel is running on Xen hypervisor.

Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/soc/xilinx/xlnx_event_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
index 86a048a10a13..6356b80ce57b 100644
--- a/drivers/soc/xilinx/xlnx_event_manager.c
+++ b/drivers/soc/xilinx/xlnx_event_manager.c
@@ -477,7 +477,7 @@ static void xlnx_call_notify_cb_handler(const u32 *payload)
 		}
 	}
 	if (!is_callback_found)
-		pr_warn("Didn't find any registered callback for 0x%x 0x%x\n",
+		pr_warn("Unhandled SGI node 0x%x event 0x%x. Expected with Xen hypervisor\n",
 			payload[1], payload[2]);
 }
 
-- 
2.1.1

