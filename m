Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E917B30EE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjI2K5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 06:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjI2K5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:57:32 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9575199
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 03:57:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXM9uJrspWfVTPP0vSUftYBFdBJQ+JpkXqvpQjbf/5p/mxfV2CIeN5H5i2i0afmPStVPsSBMPiI73xIZAv4dkr+wn9lfSpFQQVgRGurgkFOqh3gxCI8CgiMkA+n4GXKguNFV1EBHb0WpMlOpnVL/A+cI0UzfZ96n0+tpFR+wnVVEtcfBy0wIoi1XBGuUe0eHX343l2SkWGM/ZN12RVtahyUgsuqECP0KWfbi0UtMCr6Uup302LymTtFWR465yIEu9ZMregGG0vImkVd89/QY2aFzjXRANsgvCyBqSaGz0AoxEMt+/LGX+/uBwq9yzkENon3qG/lTLv/UasikUyS9YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtYk99h/1HDzsoD5YQ7osZir3q+ocxsZg5kQt+baZ1w=;
 b=RbA5t3aGMMKVoQeR3Jz1PzJZQEXEhF4qz6ZbtEyGLJNMJcINXaY4qcq43VU3mfAlZj0m/AQuBm/dRV/9EsOrvFeZEoKX8Ts2CRu9mYkHvbuZi49qCWS/qviQnLhDktnPsEKFkDWjCZBJx/AwkEuPjST9oqP99q1g9CYaw0M51dG3aw00FMNOb0T1IyaIPaPYd5cDxrDe1prgi2ntkHYF3x898oSKzSz7Sp2PYP7EIr0wrM/rDlvzrOzQ4DyUexdxslJGrX+/MU13MCVE0xrskqulkt54V9Qbm/arxgzT3x9f2W40SERE8V4rSEvq23PDXLjpFBMofk5Z6MAHQulzlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtYk99h/1HDzsoD5YQ7osZir3q+ocxsZg5kQt+baZ1w=;
 b=w6HKlPbNR42XhA80X5Lqj1pIBuzJ0o0IC+HI9fignlscIDAcbzXqVJ4DIDJ83lp3MgdClBckr70pFLU1u2qaLlGYCa2QKdk0oZ8vWmJgy4Cipm+7ECv24HHy062e/WgBguzNehVrffVDv7U/URCfL3kpNtUJWgT4tMMJEpw12IU=
Received: from PH8PR07CA0023.namprd07.prod.outlook.com (2603:10b6:510:2cd::11)
 by DS7PR12MB5935.namprd12.prod.outlook.com (2603:10b6:8:7e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 29 Sep
 2023 10:57:27 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::b7) by PH8PR07CA0023.outlook.office365.com
 (2603:10b6:510:2cd::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26 via Frontend
 Transport; Fri, 29 Sep 2023 10:57:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 29 Sep 2023 10:57:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 05:57:26 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 29 Sep 2023 05:57:25 -0500
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
        <tanmay.shah@amd.com>, <sai.krishna.potthuri@amd.com>,
        <nava.kishore.manne@amd.com>, <ben.levinsky@amd.com>,
        <dhaval.r.shah@amd.com>, <marex@denx.de>, <robh@kernel.org>,
        <arnd@arndb.de>, <izhar.ameer.shaikh@amd.com>,
        <ruanjinjie@huawei.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH 4/7] firmware: xilinx: Register event manager driver
Date:   Fri, 29 Sep 2023 03:55:55 -0700
Message-ID: <20230929105558.11893-5-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230929105558.11893-1-jay.buddhabhatti@amd.com>
References: <20230929105558.11893-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|DS7PR12MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: 66501c5e-cd7c-42dd-87ff-08dbc0dadeae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FShkHYhJP+b1LDyoBReCmut7rarzDLIugq5DHe1wc2NZK6Q3OQy/r3x1WmQX5rBczRmlpm3prXeFwLLp8HmRCzGspQJMXW3ITWS2//TGH6sljYZ0MFl7+V4mNmaXNXg46soHJ++P4yMZ7fABSQVUf40VcJ3CfFc1x1FB3RX3cVtedxYf5q7ndqlWfEgr40P8nbf9D74NK8RAIJqf3CHgyrI+9gWAunGW7SrZPhaO+rbm+tfACl2oAo1t+HiOMJ3Q5180rgjavrWBTeVXqgsYGA8+i8oqtEAzXokZxevy5tCwpln5cL02T/Zgf1ugbct+KkMfdH3rcUu8hEqfcNXXshPuSf+ZGTpTiBS9w2sD4ny4OM9RDtXtsfpGZrT1UoKjoeyUjt5HVinXCWiOsBz6A2GxhHfmDdgIebcx/MdO2excW7BlxWC87QXDQx/6iAxa3Lh3J/B6P69723Zb6zVayDjYjxzETtwd/I9FkpVOgAyl/TnVBW0toUdrmz+RuvxN2NciGXJD4V/zhVfA3iw6YIX/mCd4j3zmaxpEmy+lOZB1EQnTz6gvGhVFoR6ZxGHpQK+Sfp9hnO3KZiZKqZK7qF2GAzEjAEdadI3JtzzcrgzMJzdg9GHQsVWSJhSjS/+cwpXiYkkeoz0Puum+GQ7/E99xQbGgBOcUjmxPmVUWRTsvnTHwdv8fIn/iBW150M3E1k9o42H/hPiLo/4mVj3h+aZsM6BY2JgWNhPeEOurKV5m4WRg/o4J8gs5nqra4U5TGSTC0CXdvBnEhSKwu/1ioNzNTB+Ktfx7gOcrdD9zw6I=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(186009)(64100799003)(82310400011)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(54906003)(40460700003)(86362001)(40480700001)(36756003)(5660300002)(70586007)(8936002)(426003)(1076003)(44832011)(4326008)(336012)(8676002)(70206006)(26005)(110136005)(316002)(83380400001)(41300700001)(36860700001)(2906002)(6666004)(478600001)(2616005)(356005)(47076005)(82740400003)(921005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:57:27.3815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66501c5e-cd7c-42dd-87ff-08dbc0dadeae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5935
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use family code in order to register event manager
driver for Versal and Versal NET platforms, instead
of using compatible string.

Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 6583efa9ac48..c504702fe9c7 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1953,7 +1953,6 @@ ATTRIBUTE_GROUPS(zynqmp_firmware);
 static int zynqmp_firmware_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np;
 	struct zynqmp_devinfo *devinfo;
 	int ret;
 
@@ -2016,14 +2015,12 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 
 	zynqmp_pm_api_debugfs_init();
 
-	np = of_find_compatible_node(NULL, NULL, "xlnx,versal");
-	if (np) {
+	if (pm_family_code == VERSAL_FAMILY_CODE) {
 		em_dev = platform_device_register_data(&pdev->dev, "xlnx_event_manager",
 						       -1, &pm_sub_family_code, 4);
 		if (IS_ERR(em_dev))
 			dev_err_probe(&pdev->dev, PTR_ERR(em_dev), "EM register fail with error\n");
 	}
-	of_node_put(np);
 
 	return of_platform_populate(dev->of_node, NULL, NULL, dev);
 }
-- 
2.17.1

