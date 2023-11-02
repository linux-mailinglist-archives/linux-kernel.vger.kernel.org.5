Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177F17DED20
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbjKBHMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbjKBHMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:12:06 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A54912D;
        Thu,  2 Nov 2023 00:12:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoFxttKz2ekDV2de680f21IB3WRj3Ttpk0ceuAWy3TuL9gIc5cnelXEMQFX7iXjy+UxD1amGAJIs0GAwDEcAdb1XViFjj3jUGPvDzALxINY56fwovrojdUBAsFWZFWTERv8oyqiDDy5nMMS9X3BpsTCCvbSKHZdYgxZyJGaQ3nVMkxBcNDkw8vDYkJ2/z+556XIWy3pgUnw1PQR3MdwYbQRkBV7I0mzR0jSYng/rqfTLaF3bfUzX4GE/LdREmCHpy1BXlLs9LXbh7MKP2hYhAPxbyGSFFhRj9ryYordPZ2mOVih6zPE3Q0TOn/s5B0BDfPnjkBGkzspeYXCP3u/SSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIa/PktP5rCqp+kuRIPAJx7p5ryHLyS/h3nkURcEr3c=;
 b=dqwM5SQh42cEh3+vxDqp3k7QTtQULy2RoNBePZjXXwP2nhWnq1/gY4tFRqCOfLs/IT4qhJhwbIpQxg1zVJFBeVnVtNVZHGTQp7EmtBuYo2hB0BPsVo8NbrmssKdjFt4HqhrhMGzzrhhYWQbjw40Qvzoqgj0DiU6doV/qtmIBHdPUGwE+8qr0B5cav4ZC0D9ul28LODiEx8KpCW/gyz8SQHyPPIo0adLKt/K7o2cK8kCFhDbYK+moCa7tzxRxIK0pCy5fQXFnsDFAFgZGHaqA1Z1bNk3KL9UlA/h0b46BsIl2IpHzxWrEzlnMxtnS15cIRPTXwSBSevJWnPdg19m3JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIa/PktP5rCqp+kuRIPAJx7p5ryHLyS/h3nkURcEr3c=;
 b=e58gn3GoqCI7cqdTvHjqWHaNSt7IvX/q5/7CXRfcMsQ1aOVU/QYAqkDmMvsptuzjv0P1WwcW22FQX4XP0XBhFExLPZqNPePhM/gNLTSHekMEe4uzhWRvSQlo9cRHP8GTI3V++TwCvaQWyF9TNv8n8XfeIKT68EUMFxa0yUaIFFU=
Received: from DS7PR03CA0287.namprd03.prod.outlook.com (2603:10b6:5:3ad::22)
 by CH0PR12MB5122.namprd12.prod.outlook.com (2603:10b6:610:bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 07:11:57 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:5:3ad:cafe::6) by DS7PR03CA0287.outlook.office365.com
 (2603:10b6:5:3ad::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Thu, 2 Nov 2023 07:11:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Thu, 2 Nov 2023 07:11:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 2 Nov
 2023 02:11:56 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 2 Nov
 2023 02:11:54 -0500
Received: from xhdpiyushm40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Thu, 2 Nov 2023 02:11:52 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <laurent.pinchart@ideasonboard.com>, <dan.scally@ideasonboard.com>,
        <michal.simek@amd.com>, <gregkh@linuxfoundation.org>
CC:     <siva.durga.prasad.paladugu@amd.com>,
        <radhey.shyam.pandey@amd.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH] usb: gadget: uvc_video: unlock before submitting a request to ep
Date:   Thu, 2 Nov 2023 12:41:38 +0530
Message-ID: <20231102071138.828126-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|CH0PR12MB5122:EE_
X-MS-Office365-Filtering-Correlation-Id: f2293b27-2c0a-4335-7b04-08dbdb73002e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qK8vskqxgWZ63x0TxADWKC8Gc0O20nqX2tLxypXc9qSnD35su2JuXHeeDd/L3MQmEB+X7nlbXlMIYF0tocxxBKysZiYxOSh+qh1IZJ+imOsjp2/MFNDsogVeip/1z/+TI6bVG8Y3pz3/gJb2otEuJKDbUygnVx0GlYmB8sGyznPavBdSuuTxO1bEBdNUJfgTRPz5t2u5XsegxVPvpWh9jqU63WE1oCz+mv28HGUyIMLk5CJ1ldLGIXfskQG3m6xVvPayZtfOBl5Ae8hmbZCuNKgKFy50A1PQYnAAHp6FsAZRwo7kaURaUpl7kEsz60kO/1SHVpnDpYevVBwmAZH5vfzX/qEy6PZxTLaFJNUjAkJR2MEMfw70OuUnK5fX91pEWMNiykGznDLqe66Kt6cx5HCtbro5XhZMQW3DyN39aulEnQUMSON7LI5fz8nXVayqNLtmOviRpccN+SdChNh4ruRcieEAjPhL7ROL1NbwbaE+IoQ9Pv1QZILNlflkI2k8clODFxfw3v8evoIl/kaQdwof8Wzhyig2JC+w5jlyRz5e3zfjHOwcUoOP4xQ8f7aCjViE/7RGasvveSy0sfJ3xs8Tp7JH8Rt0I68wgNO4MhPkveSasyqub5DAuYFaLmYyIOukgrEa3MSLNeBhn3f4E4AGo/j25YB3LENaPb9AeX/bMiiqntCiYGrMn7QeB6rGYbinSltfFQPezbo3ot+x8plSVB067WeL9Q2zjbZkdzVxB6M/N2cNDk6BDLcf323cPXJNtdDo8t0TkatsRKwAcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(82310400011)(40470700004)(46966006)(36840700001)(5660300002)(41300700001)(70586007)(110136005)(70206006)(316002)(54906003)(44832011)(2906002)(8676002)(8936002)(4326008)(478600001)(40480700001)(40460700003)(6666004)(36860700001)(47076005)(81166007)(83380400001)(356005)(36756003)(26005)(336012)(1076003)(86362001)(2616005)(426003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 07:11:57.2731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2293b27-2c0a-4335-7b04-08dbdb73002e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5122
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There could be chances where the usb_ep_queue() could fail and trigger
complete() handler with error status. In this case, if usb_ep_queue()
is called with lock held and the triggered complete() handler is waiting
for the same lock to be cleared could result in a deadlock situation and
could result in system hang. To aviod this scenerio, call usb_ep_queue()
with lock removed. This patch does the same.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
 drivers/usb/gadget/function/uvc_video.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 91af3b1ef0d4..0a5d9ac145e7 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -460,11 +460,12 @@ static void uvcg_video_pump(struct work_struct *work)
 			req->no_interrupt = 1;
 		}
 
-		/* Queue the USB request */
-		ret = uvcg_video_ep_queue(video, req);
 		spin_unlock_irqrestore(&queue->irqlock, flags);
 
+		/* Queue the USB request */
+		ret = uvcg_video_ep_queue(video, req);
 		if (ret < 0) {
+			usb_ep_set_halt(video->ep);
 			uvcg_queue_cancel(queue, 0);
 			break;
 		}
-- 
2.25.1

