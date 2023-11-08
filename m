Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BB37E5986
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjKHOyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjKHOyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:54:49 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C211BDD;
        Wed,  8 Nov 2023 06:54:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J91kYStla8tNjzfaYINqQhb9PZuLJESU195rg59NmFYHr5ZE+xp9qVXdnGJX3xiBL1hWsqDA7vYRm9QHbVlhi5WNmkddUli/xTQqqXKAYaciB1RzTHMrDLmpUaXlmzf913Er9w6D8av+6xAIjpn2A5aBo/0iHp0ZE/kg7EURE2qIO0JfLj1qLtnY9WEYQ/7McJzQ67bC7F/Om9Yo7kjY6fWxgro96AMOvnD/3+vvxm4JGB5zMjD+bIkMWa4A3CBmmubM1DRNvfd0LS3ZTy/G5dHdQIOmJ7Jm+kNdk0tyNwwDmjTVTY+nZSrbXmOASZiTyD+T25MLsBCT90HTUm7CWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80Hu0Ak65fOGd2sqhF+5aodRNAAjsTCb/QibLqC6xGI=;
 b=FsiyKncU2tAcD9XnWHDCFRUnD2NjDGDHP9HbGm8uUs0SVshqgVU0Gv5ReE3RbXopDJL+8p8zrMuv9jyGHCVYbGbT6E4ieBW8lBEeRf+/GVRYqHOr8OKqmuB3GLNqvzxmdiKCorIPPBSdLU9JamRlpROV+Z2p/MhD1EvHboJrP2hOD0EdaV6RaTWLT+8+9ByxJauni7rfL8h9fToRQZ5gYj90QW4kER+zC4QgVs5TptxsFox965Cpqjw5l5FZ03lvlHlgR8+lgcPKM7T6acTHYYCvi6Y1aCXZoRQaT4ZQgpEvOqetKAc/YuelGNKGL/+yi/jAn2xaF9U6v3+lEyxaEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80Hu0Ak65fOGd2sqhF+5aodRNAAjsTCb/QibLqC6xGI=;
 b=L3k36UKOSrL1lg3ybRwNcMozp8MyHvojjykB1IJBlX4Xfsko63SIVp8dk2j3NsSPiNIdujQepxo8Amboa1zy3LDbNwg8ciyTCrObx/sYGOJ3Xb5liHk2qIZB6x93KwyGrQHMW9vTcL9tRN09yzo6ByNbT1MxvJkMiTyRxrGaTIs=
Received: from MN2PR16CA0019.namprd16.prod.outlook.com (2603:10b6:208:134::32)
 by IA1PR12MB7758.namprd12.prod.outlook.com (2603:10b6:208:421::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 14:54:43 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:134:cafe::6b) by MN2PR16CA0019.outlook.office365.com
 (2603:10b6:208:134::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.34 via Frontend
 Transport; Wed, 8 Nov 2023 14:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 14:54:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 08:54:42 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 08:54:42 -0600
Received: from xhdpiyushm40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Wed, 8 Nov 2023 08:54:39 -0600
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <michal.simek@amd.com>,
        <laurent.pinchart@ideasonboard.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.scally@ideasonboard.com>, <s.shtylyov@omp.ru>,
        <khtsai@google.com>, <siva.durga.prasad.paladugu@amd.com>,
        <radhey.shyam.pandey@amd.com>,
        "Piyush Mehta" <piyush.mehta@amd.com>
Subject: [PATCH V2] usb: gadget: uvc_video: unlock before submitting a request to ep
Date:   Wed, 8 Nov 2023 20:24:26 +0530
Message-ID: <20231108145426.2358406-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|IA1PR12MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e5d423-332d-40e3-ac4f-08dbe06aa44f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QNe3BHK7fgLDN+vWZMYgLhB9QM1vgU/tb+XqLwjpf8yr65MP1OUQgridKeGOKOpTPHZnRxHr3sOpuGFnJAKp5OMgwSdg/GXbnEbJkgiBKvJ6rCTaMxmwc1tMA5ynycssDI2A4xM/0WZR6PD1C7uVPc4hvlQUg/DOn2vyEY7pZqy6ADzLUNyTnmUei49/d8R3Ruk9kbKOgcxRs6pUJa8ay7wLaG3Yi/cdHxPoxffuJNa0Fx9VEW9u/FV87JEGrusswtADGPJ07B7ffDISucYlxKQ3haUk3h0eNLmjq2QV/uTX9mrF3c9J/UnqKz6ChcHB8VdJ4XHdt2nsQbeeiexEHhpYdDbe3PYiXSO4ngAC8hApIq5AvthqNl1qP4qF8lQOl0CB9djx2hJSfYtXCLAGzboEtevzAiii2WcxAKkSnfXMfqlbrs7wg0OnPIgU//yun2dG58xHnIDyqKiy3dq1zU2O46KLhRbCESpFFJcYiDbeueMNGgWvp07z/dhTuDSo/CrfA7CphgM4uR2nSk8SiWH0JEBnR1fvO7J7uEDz+nIoOb8ykuo1F8bxYFScKyjWh272d/XzJtn170EleR10iKFwfnxpS+Ox1QzbCoQpHW101jTQ031qLaLAIlVDYxkLvj0sgcZMgWSET+aRQvSFfuu6ahA0GTyEUcJgfulNHseSzsxyHgKbCnQrglsKppqABeoCk9eVdTF9/TC2rLnZIy7Hnxh/aUPMStvBhNCTL1VWQ9JfVY+bt4uSa4Gh/cmC76t3DgehdGHVl/moDn+gcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(2616005)(40460700003)(40480700001)(966005)(478600001)(36860700001)(47076005)(82740400003)(36756003)(86362001)(356005)(81166007)(83380400001)(2906002)(1076003)(336012)(426003)(6666004)(70206006)(54906003)(110136005)(70586007)(26005)(316002)(44832011)(41300700001)(8936002)(4326008)(8676002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 14:54:43.0428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e5d423-332d-40e3-ac4f-08dbe06aa44f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7758
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There could be chances where the usb_ep_queue() could fail and trigger
complete() handler with error status. In this case, if usb_ep_queue()
is called with lock held and the triggered complete() handler is waiting
for the same lock to be cleared could result in a deadlock situation and
could result in system hang, so call usb_ep_queue() without the lock to
resolve this issue.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
Changes in V2:
- Addressed Dan and Sergey review comments:
 - Removed unwanted usb_ep_set_halt, it's alreadly call on error path.
 - Updated commit message.

Link: https://lore.kernel.org/lkml/20231102071138.828126-1-piyush.mehta@amd.com/T/
---
 drivers/usb/gadget/function/uvc_video.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 91af3b1ef0d4..705d762b7f5c 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -460,10 +460,10 @@ static void uvcg_video_pump(struct work_struct *work)
 			req->no_interrupt = 1;
 		}
 
-		/* Queue the USB request */
-		ret = uvcg_video_ep_queue(video, req);
 		spin_unlock_irqrestore(&queue->irqlock, flags);
 
+		/* Queue the USB request */
+		ret = uvcg_video_ep_queue(video, req);
 		if (ret < 0) {
 			uvcg_queue_cancel(queue, 0);
 			break;
-- 
2.25.1

