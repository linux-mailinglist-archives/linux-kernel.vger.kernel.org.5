Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843B17723C0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjHGMVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbjHGMVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:21:17 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08171E46;
        Mon,  7 Aug 2023 05:20:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLVbgSuOaFr+NzB8RQUlgXKN3wewHs0TyuxA0HwWaJS5NZOl0slT+rhGpjo7j+pdO0XlCZA5EdSXWD3eqx5UX0Auc9yL+WWfBRC8X+/1ev6SMB4AfCbNVU1oG+/xumk18VLu0zUH3Uq6olnGqNMI+8GD8mYxleXQyDx0ItbEMH0sG4TB1RmEeR8dJwnRJbUY2JGd73ze+vRtblSXpUCZTntSM1NE6NGWZN24/tkCmu7oLvaOsE1rVwMV5zX0EmPVeqakNql6MpgNHS+EwFj/AfBvD242k9fCA3SZTQ9E7kdWUE5WMtiQF8LWHbsvYLXqWuHfxrxVBDlWwF972EyYcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zV8cyOpyi0L6DE8j4lygV50KnCcHX4GbFjMd1Cw23fw=;
 b=Ijs+TUD1uwlm9Xh6TAtaZeRfflFFmyyk9+sdHvcKvdBF2/w5pLDKYEEomQllJj2u3KnhTpVbRtNg9tt1VbuadBXQM7imMVZyVk1Am6nL/luZFbMGduAx9S4nYuk0WyYyHUPLyHTBWFHtttp/Q0khOdeUqfmm0LJDFVMlfnDRpQvExCpYZTkTSi+9++qGED7pqjtIsIl2aZ3Wd90NTi7GENbS8WxvqJz6Vv3Pd8mNL/K9PawAf99DKmJPI46bW4bA+bYfSV4/0o5mRAASIfOJQwpjv5zYPXQDLzQmR20GVag6XoMWW16DgcsWACBOXMXMt6ed4ZrOlWjvheFp9urChw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rowland.harvard.edu smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zV8cyOpyi0L6DE8j4lygV50KnCcHX4GbFjMd1Cw23fw=;
 b=I0UQQ37nkHGLGFGMQ2hLh9ZgYlKTFUybuILVrN5Fdh0GJBRhWGbl8S1ijQd+9wqHJp6WEv+JGXZ+CBksVISjUAgObdKurhBqbUta9KS6iTfs/2HYJ760964nOGNPDRFFykiW5qfcs4C5/h0aibPN3Kq+dM9EfXX0nd68AXM62sU=
Received: from SA0PR12CA0029.namprd12.prod.outlook.com (2603:10b6:806:6f::34)
 by DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 12:20:48 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:6f:cafe::24) by SA0PR12CA0029.outlook.office365.com
 (2603:10b6:806:6f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Mon, 7 Aug 2023 12:20:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 12:20:50 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 07:20:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 05:20:49 -0700
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 7 Aug 2023 07:20:47 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <stern@rowland.harvard.edu>, <gregkh@linuxfoundation.org>
CC:     <michal.simek@amd.com>, <siva.durga.prasad.paladugu@amd.com>,
        <radhey.shyam.pandey@amd.com>, <git@amd.com>,
        <linux-usb@vger.kernel.org>,
        <usb-storage@lists.one-eyed-alien.net>,
        <linux-kernel@vger.kernel.org>, Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH] uas: Add US_FL_NO_ATA_1X for linux tcm_usb_gadget
Date:   Mon, 7 Aug 2023 17:50:25 +0530
Message-ID: <20230807122025.2818062-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DS0PR12MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: dec6cfce-cb0b-45f1-2109-08db9740bd01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JclJFE4WUes+c+40Yp59SvLvVxbTLKVXJFX5tB6WFsg64SUF6MtZTor3C3GqgJTua4uJywXHRLrnrdQ/RpbUIDrNTgXjQOT2F5rvBC1VM8SfwQDpaOF5uLY90RCcf6uhOC7ApbsOTmRsrsC+9++OQ0ab/ElGiFUv7IZ3pJimZyK7xD4REXvmizI1QCPBh33i8FUeuiqOogcgPNGCbChOpugytWEF6kBnTVJoNm6HVGSRyp06GcMuOG23QamrMNc8mXaqXGYCtV5zOZ/MaZbcEgiy3Hch74FfXGsYzxvj3jj+YJTUQxMX3WYOoytJvb8h8dSAsHC1gWJX1hGyFvRf+FcCnfmmGqfg9mYYIDhpHDlTU4b0tAVF9WCAG3p8vtdXG8Q34FvSGHCblqAdnE0c0Blpsg4GsQtspk3kVD5yV79ogMkCFkixohlUNnlR1VW1PB4NaS1hD0dKmnB2L2uy5vttH/yP1HaDS+OOTNoJESJQrgJNTOHrkjhtuSd8nuaLH4XM7u/C73LuLYPaELOVSehxMhr/dvr2smPqrT3ENmEHPGbBValgMa2YtRnmDv6CFZofXoWBTRVxNNwbcwkiyNudL0LQMNI2FCW4WJvTIEoiSegjYsq8aj6Ob8AyoA7nuOMPaEOFW/tvoT/3p2pIXaOGiboRe/+Rs3GIh5vNkUg4Rz3Pjq+7fd3t8GJi/OSxD7rjqe4mCQc126EHKV35upMWmQ1GdFPrVuPvc2G10QeHzeCamV6IObKyzCF0esHS4w1Kfrs9Aubr+CmsysTMZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(1800799003)(82310400008)(186006)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(2616005)(6666004)(81166007)(86362001)(478600001)(82740400003)(1076003)(356005)(26005)(36756003)(41300700001)(316002)(5660300002)(44832011)(8676002)(8936002)(54906003)(110136005)(4326008)(2906002)(70206006)(70586007)(336012)(47076005)(83380400001)(36860700001)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 12:20:50.7101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dec6cfce-cb0b-45f1-2109-08db9740bd01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8245
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux kernel's tcm_usb_gadget requires the US_FL_NO_ATA_1X quirk.
It does not respond to the ATA_12 family of commands and hangs. The host
prevents the issuing of ATA_12 commands to the TCM module, by introducing
this quirk, the host is permitted to proceed with other operations.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
 drivers/usb/storage/unusual_uas.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
index 1f8c9b16a0fb..2fc0220c72ee 100644
--- a/drivers/usb/storage/unusual_uas.h
+++ b/drivers/usb/storage/unusual_uas.h
@@ -177,6 +177,13 @@ UNUSUAL_DEV(0x4971, 0x8017, 0x0000, 0x9999,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_NO_REPORT_OPCODES),
 
+/* Reported-by: Piyush Mehta <piyush.mehta@amd.com> */
+UNUSUAL_DEV(0x0525, 0xa4a5, 0x0000, 0x9999,
+		"NetChip",
+		"Target Product",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_NO_ATA_1X),
+
 /* "G-DRIVE" external HDD hangs on write without these.
  * Patch submitted by Alexander Kappner <agk@godking.net>
  */
-- 
2.25.1

