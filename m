Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946C7783A05
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 08:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbjHVGck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 02:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjHVGca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 02:32:30 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E021A5;
        Mon, 21 Aug 2023 23:32:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGxeLBEgWbX/ZOILZht1AW+c/WWI1j4aKQAFf0tZGAvPmDWSl///kbexFOwZp8Oiy7WgqM/wsLBB55AkR8qoXr4PgtLtu4KGxe0suMlE8WCsKrnUTmWPiHJPeD2Fmh0lnoWERD1/AIiimiNT//8otIf7toRFFmE1ZvteOmrG7/3PaIfIJYdZ8ftsdqhZ0eZHT7ev67ouFY2nzx6cDAfY8G452F0JG3bYtfIN8c3HBpsO6s0YaJdWSc87p36FtmRL4hiRme5wocYKKom43rwnffS6Uya64Wl1iz8gk4wCpyqZQGMUb9RDN1a0eCC1cS5cHkr4AcFNPK8D3Wyd5OANNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0EQGJB9LSNPwfXG8wjfxhnxkoSQdYYPt3IqTh/iGPI=;
 b=P8DyF5zS4S/c54Zj3Jkn/0978Ccc/vB94ibrdFyl9BHwdCnhuly3N5kGQnhZ8oFJN1MdpTpdFk4RidE/5ZsF0MJpcXHLZZx9QMIU9VNSuqgorPBqDHQT5xdyhzqxI1SU07HuicbHtk9eeDdGmZjUc/X+ERj6z7sko4Bfsh1yyFAv1PCwREqbhvJmYcL45hTIzq1oPUKoYjJDjDnNaWFeFDc9bvvMNiR8s0id36vM/+uAsQ3cxtoPoCaq+7sgCBtj/wkMIjkg0z9ILW9C1xAfmot1lQq+9/g6oGz6uBP91v0SN7F6TalFd/xp0+wFz3cFGpbNbiaElUikr2R6p99X1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0EQGJB9LSNPwfXG8wjfxhnxkoSQdYYPt3IqTh/iGPI=;
 b=EJ6d0/K0z2bDM2/AaG5qCEGF7iPJDQ02xWBricRjeSii0NC2uwHY9gB3O6R3eJjhjpRzpEly6ozqxKWhD3W4xOFqVJWQt0IIAxn4QrO0u2UUlr5Jlu/dlFk3YD3NPZR0KQe3KfAuQRFn6piRNbIU5aPBbozMrbq4CKZfDahXSXU=
Received: from BY3PR04CA0018.namprd04.prod.outlook.com (2603:10b6:a03:217::23)
 by BL1PR12MB5364.namprd12.prod.outlook.com (2603:10b6:208:314::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 06:32:18 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::53) by BY3PR04CA0018.outlook.office365.com
 (2603:10b6:a03:217::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Tue, 22 Aug 2023 06:32:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Tue, 22 Aug 2023 06:32:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 22 Aug
 2023 01:32:11 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 22 Aug
 2023 01:32:11 -0500
Received: from xhdpiyushm40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 22 Aug 2023 01:32:08 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <michal.simek@amd.com>,
        <u.kleine-koenig@pengutronix.de>, <linus.walleij@linaro.org>
CC:     <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH 1/3] usb: gadget: udc-xilinx: fix restricted __le16 degrades to integer warning
Date:   Tue, 22 Aug 2023 12:01:59 +0530
Message-ID: <20230822063201.16929-2-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230822063201.16929-1-piyush.mehta@amd.com>
References: <20230822063201.16929-1-piyush.mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|BL1PR12MB5364:EE_
X-MS-Office365-Filtering-Correlation-Id: af5c3c8e-f538-41be-8035-08dba2d987d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zo8gIrjwYvpFwBROeWA4ab1mGRTMG8E8nR4ujGF0FKRoDlGJeX3uTwxe4WcNNEUbxkdhDAY2qvNo8bLD+U0XEUuaCA1FvpZYJW+5B5gLuV0F7xbB78LXe0KCh1/OJcdKd/QbGuNh6dkZtdqLTtLOT/WgOaACQzibemLZu0r4aZR5RRrxB09jS7Yj/rOQUrmTyP1OQCe7XNO86uYdQFpp0AOpIZ6FDn4VfISOVWnlECNPg7gM/R4PTFnr0a2e4RJKIyFKoCxeHB3DZpzdD5jrn5BJdduXRx5EEr2AkX6v6MWaS3TwlgASqYAS9q4q53AjBqDFmaWmy8nGCJcMWrrwBDKoatDO4FsCnv6rgy1cOzepGG370KFmdE0HYTf+lz6uP+pEA+oz2I4oYHve5J9PLdrLL7bhLvP5w1J3pEvlkgCXkzBzIKs70X3OXwS5N2mXpTENyR6B9TbixeLaVTRYd9hN/hddDSBX5melePDGEn4rw3rOK3wV/hvl0byFAVBz5OkpbOny9PvV45YEGhZ+J69ZDlvdtaK7ix6XHmD4Ji/l/OSAQvNG5p+V6Ge+fZNlct1cu+Uh1yiV7HHuGApL8LNvEcKe7gLfJk5nrKkrafg7hDSzQrHZ7GEiAEy+H3zoMiVVhLkcEGEqqR1MUPkpS7pVMqilLyD4WZWHcYLPvgNbU6gT9THw0ExoCiiRo3TxabOmM5ghJCX7cdLnWDpQlxZ/fjK0GjF3zR5Pinlm1MguMJjTLLiKoYKZwZZEYxxo
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199024)(82310400011)(186009)(1800799009)(46966006)(36840700001)(40470700004)(2906002)(40480700001)(83380400001)(5660300002)(44832011)(426003)(336012)(26005)(36860700001)(86362001)(47076005)(8676002)(2616005)(8936002)(4326008)(70206006)(316002)(70586007)(54906003)(110136005)(966005)(82740400003)(478600001)(356005)(81166007)(6666004)(36756003)(40460700003)(41300700001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 06:32:17.2235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af5c3c8e-f538-41be-8035-08dba2d987d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5364
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb_ctrlrequest members wValue and wIndex are of type __le16, so to fix
this warnings we are using le16_to_cpu() macros.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/all/202209020044.CX2PfZzM-lkp@intel.com/
Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
 drivers/usb/gadget/udc/udc-xilinx.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index a4a7b90a97e7..e6308414cd1f 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -1617,13 +1617,13 @@ static void xudc_getstatus(struct xusb_udc *udc)
 	case USB_RECIP_INTERFACE:
 		break;
 	case USB_RECIP_ENDPOINT:
-		epnum = udc->setup.wIndex & USB_ENDPOINT_NUMBER_MASK;
+		epnum = le16_to_cpu(udc->setup.wIndex) & USB_ENDPOINT_NUMBER_MASK;
 		if (epnum >= XUSB_MAX_ENDPOINTS)
 			goto stall;
 		target_ep = &udc->ep[epnum];
 		epcfgreg = udc->read_fn(udc->addr + target_ep->offset);
 		halt = epcfgreg & XUSB_EP_CFG_STALL_MASK;
-		if (udc->setup.wIndex & USB_DIR_IN) {
+		if (le16_to_cpu(udc->setup.wIndex) & USB_DIR_IN) {
 			if (!target_ep->is_in)
 				goto stall;
 		} else {
@@ -1666,7 +1666,7 @@ static void xudc_set_clear_feature(struct xusb_udc *udc)
 
 	switch (udc->setup.bRequestType) {
 	case USB_RECIP_DEVICE:
-		switch (udc->setup.wValue) {
+		switch (le16_to_cpu(udc->setup.wValue)) {
 		case USB_DEVICE_TEST_MODE:
 			/*
 			 * The Test Mode will be executed
@@ -1686,13 +1686,15 @@ static void xudc_set_clear_feature(struct xusb_udc *udc)
 		break;
 	case USB_RECIP_ENDPOINT:
 		if (!udc->setup.wValue) {
-			endpoint = udc->setup.wIndex & USB_ENDPOINT_NUMBER_MASK;
+			endpoint = le16_to_cpu(udc->setup.wIndex) &
+					       USB_ENDPOINT_NUMBER_MASK;
 			if (endpoint >= XUSB_MAX_ENDPOINTS) {
 				xudc_ep0_stall(udc);
 				return;
 			}
 			target_ep = &udc->ep[endpoint];
-			outinbit = udc->setup.wIndex & USB_ENDPOINT_DIR_MASK;
+			outinbit = le16_to_cpu(udc->setup.wIndex) &
+					       USB_ENDPOINT_DIR_MASK;
 			outinbit = outinbit >> 7;
 
 			/* Make sure direction matches.*/
@@ -1869,7 +1871,7 @@ static void xudc_ep0_in(struct xusb_udc *udc)
 	u16 count = 0;
 	u16 length;
 	u8 *ep0rambase;
-	u8 test_mode = udc->setup.wIndex >> 8;
+	u8 test_mode = le16_to_cpu(udc->setup.wIndex) >> 8;
 
 	req = list_first_entry(&ep0->queue, struct xusb_req, queue);
 	bytes_to_tx = req->usb_req.length - req->usb_req.actual;
@@ -1880,12 +1882,12 @@ static void xudc_ep0_in(struct xusb_udc *udc)
 		case USB_REQ_SET_ADDRESS:
 			/* Set the address of the device.*/
 			udc->write_fn(udc->addr, XUSB_ADDRESS_OFFSET,
-				      udc->setup.wValue);
+				      le16_to_cpu(udc->setup.wValue));
 			break;
 		case USB_REQ_SET_FEATURE:
 			if (udc->setup.bRequestType ==
 					USB_RECIP_DEVICE) {
-				if (udc->setup.wValue ==
+				if (le16_to_cpu(udc->setup.wValue) ==
 						USB_DEVICE_TEST_MODE)
 					udc->write_fn(udc->addr,
 						      XUSB_TESTMODE_OFFSET,
-- 
2.17.1

