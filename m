Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DD17BA0EF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240275AbjJEOs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240109AbjJEOoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:44:55 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5A02B915;
        Thu,  5 Oct 2023 07:22:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkMeoBuVLyhrobZeEkSu6fhBiuO5bG1dnRfVONqMcgknzKMkN84tSr1a+ba0ZIxEZOv9f/kxZvy+Y6WKwCxLvDoAXuUuGiGyJxmFw7WDtBcBJ7Rm77Mcb70eF7MK3Hk8VxcFxZ3UfXN6vwoqT7KE7DUAd0hltu3X55wgeY4PyUkoTc63KJ0DAhhLiAJRadsYuuGlng5YEt42l+nxmzDY4QNGeJkEEDES9A7HoNbe1ZCTcVyymwKCLb1vJqa1pRPlYwm7kfBzErh/H/+ZsccE7AL5y9ewDuTLOv/nG8LH8KSooq1/vzCqH+4Ecp13iYN1UMnkwVqlFHAq0/vsjcgpTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZmxiXzEO19QM2XmvIEFIwZKQdGn7QT9D65OteTQosY=;
 b=BN9gptm6eHkwoiJAEYtbjDACMyS6rMTCRqTrpSWs3caJ4KzbgnMrDFGNhNgCNVKi4butRHLEr3B/mWRVLiw2OXJQmxVZQ5wq9Fm/g15VjZD9foojUPpuWQpdo8zAtJcIdi7mZSaKYIq0zZu5gR6q1oZgvCFlTnkAB5hKu4IuoED9eT3d/hVqq505lW9REsjQ1Do08GfsQP7gThHlGK8tUOs/NgNCjY5eVxgIrRz9cZ3AbOwDWi6uYw/mPzJv5dZa/flhiS7+FHRVmTFyV7FQLRRR56mNQlYhLKZrXP/5EpLVvbA/jm3jyDOZwtP/PRx93lAZuM0HLpdiF8jLa/wpUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZmxiXzEO19QM2XmvIEFIwZKQdGn7QT9D65OteTQosY=;
 b=gRuy9eh3ZjP9a6KoniDf1lRPhO8mHC5G1o6dLsKzz6ypmcuGyT0slfBUy2zprRoA2KSYa/mQaJN/Wa91S/d0x8JemigwpyLQacouPz3Hmb99kKqiSDFnL8uU5oqR7HWQ1ZkRx4mXH6Hbca8FZ2Yt9+A1vwWtLk4HxRFt/fARMXo=
Received: from CH0PR03CA0296.namprd03.prod.outlook.com (2603:10b6:610:e6::31)
 by IA0PR12MB8423.namprd12.prod.outlook.com (2603:10b6:208:3dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Thu, 5 Oct
 2023 14:22:50 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::a) by CH0PR03CA0296.outlook.office365.com
 (2603:10b6:610:e6::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Thu, 5 Oct 2023 14:22:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 14:22:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 09:22:26 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 09:22:25 -0500
Received: from xhdpiyushm40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 5 Oct 2023 09:22:23 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <michal.simek@amd.com>,
        <Thinh.Nguyen@synopsys.com>, <p.zabel@pengutronix.de>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH] usb: dwc3: xilinx: add reset-controller support
Date:   Thu, 5 Oct 2023 19:52:15 +0530
Message-ID: <20231005142215.1530-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|IA0PR12MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: 961e7c36-2e9a-40b6-77f4-08dbc5ae8de7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Zjxz8vgrVO9pqohwJYptmAsYjA35p2VBpz1ccA2NSNTppJPSzjj/tZLE/ZsneJRlYJO+d6hybXcXsqLVrMJ1U/q7DPwcpfZs1yGzRpHo3UQbhShSSiG6IcDX/mhS8C9V5ZJHUGgkqHnVu5p+lq9YQejrQXLv8HYTdk8uCQf629AbKg2fwsBz8BQIRVtUnSdjCjkbmDdjCS4F0Lj+tPW3vWKzWtG0CfdY2g7R9SrtpfsJdgoP7YtJNsefq+BPsHGKc2Le46DWjrIoBD6P3NMn1aQW4ZotjWPn6Cy4QWIiIboHTz6/Tut6smTFxaZG3Xb0UhSSl4B7TGr4eqIDapr5+C2Wo+e9ixdpnvyAt2VpBOkDmGxg96olgBLis7FOLmsGFdV1bHUdPlQlnhStcybxPBBvYf85+vs+bnY1XCZZQyJcpI+PlcYWTLqxQX8RYd7zBHIJLIUuiDkow/oqwc4zNNAY+db7ecAIIMSqZX60ZMNC9hf7yCilWi7naIBs/1iH4IXIztWeg+RjHyhv1vqQtgyYKSwnPsNXzOuybeDdkOA+ejODZruIBs3ihj7xm+Lx3OucpI9EFWo+T28WZfYT+ggxGIrHhVhc+qGccWVjxhWyzU/dqcV/kqadNF9U83XgerZdcwjJEl1MK5O1RBCUfG34uOL+5gtUXK33xOT2wJMrrkkRV81X5i4Lhb/fkWAu2usTqrDLq9X7HGP34CnUi6gzZZ6jiUkDzCOonwu31Ef0Vmy0KvhFkyQN8OM1424Y8gBmTE9xTsH6Z5+lUmhFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(186009)(82310400011)(451199024)(1800799009)(64100799003)(36840700001)(40470700004)(46966006)(2906002)(44832011)(8676002)(8936002)(5660300002)(4326008)(41300700001)(40460700003)(316002)(70586007)(2616005)(70206006)(54906003)(36860700001)(40480700001)(110136005)(26005)(336012)(426003)(36756003)(6666004)(1076003)(82740400003)(81166007)(356005)(83380400001)(86362001)(47076005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 14:22:49.8014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 961e7c36-2e9a-40b6-77f4-08dbc5ae8de7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8423
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a reset-controller for supporting Xilinx versal platforms. To reset
the USB controller, get the reset ID from device-tree and using ID trigger
the reset, with the assert and deassert reset controller APIs for USB
controller initialization. Delay of microseconds is added in between assert
and deassert to meet the setup and hold the time requirement of the reset.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
 drivers/usb/dwc3/dwc3-xilinx.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index 19307d24f3a0..d0780bf231fb 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -32,9 +32,6 @@
 #define XLNX_USB_TRAFFIC_ROUTE_CONFIG		0x005C
 #define XLNX_USB_TRAFFIC_ROUTE_FPD		0x1
 
-/* Versal USB Reset ID */
-#define VERSAL_USB_RESET_ID			0xC104036
-
 #define XLNX_USB_FPD_PIPE_CLK			0x7c
 #define PIPE_CLK_DESELECT			1
 #define PIPE_CLK_SELECT				0
@@ -72,20 +69,26 @@ static void dwc3_xlnx_mask_phy_rst(struct dwc3_xlnx *priv_data, bool mask)
 static int dwc3_xlnx_init_versal(struct dwc3_xlnx *priv_data)
 {
 	struct device		*dev = priv_data->dev;
+	struct reset_control	*crst;
 	int			ret;
 
+	crst = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(crst))
+		return dev_err_probe(dev, PTR_ERR(crst), "failed to get reset signal\n");
+
 	dwc3_xlnx_mask_phy_rst(priv_data, false);
 
 	/* Assert and De-assert reset */
-	ret = zynqmp_pm_reset_assert(VERSAL_USB_RESET_ID,
-				     PM_RESET_ACTION_ASSERT);
+	ret = reset_control_assert(crst);
 	if (ret < 0) {
 		dev_err_probe(dev, ret, "failed to assert Reset\n");
 		return ret;
 	}
 
-	ret = zynqmp_pm_reset_assert(VERSAL_USB_RESET_ID,
-				     PM_RESET_ACTION_RELEASE);
+	/* reset hold time */
+	usleep_range(5, 10);
+
+	ret = reset_control_deassert(crst);
 	if (ret < 0) {
 		dev_err_probe(dev, ret, "failed to De-assert Reset\n");
 		return ret;
-- 
2.17.1

