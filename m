Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A6E78F8B3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 08:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348394AbjIAGrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 02:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjIAGrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 02:47:22 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6033DCEB;
        Thu, 31 Aug 2023 23:47:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+iduAgM86axFVCr76ly+Y6yvi44+xgQ8bxoFQ6upP1euNvoOAE+L2mGOiIRvvJAU31MICyC6Qv0a7gQDnOcsjUnORoDkVkAo3brllIhg1xn59g0hafbHDXdKJfJi03638VtZVdqMZCPiwb+SCZd7T0DB42Begfsa8fY6l0tSzGLMm7KsNIXuh4okVTGNCfoYeMGtzDKPBWKRuALVyxapN7fPk8utvOdTNiGkW1B2JLOJsfHeSdWU8uS/cVjXfZVX/CaQAr+sBk4kiM5LMzud9nB7D/S5wDukZvUCylPBs7DMrzLyYmewqXrFzK6XUI0048hvmaaArW+yt+CkIwNkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEiJceLlcKnVFrL/MsFC1Z+4IxFS8HmzvW6SPBNXmRc=;
 b=Grtm3k4KSOe581+0g1rzTAgAAyZZTdwa5EOE+Z+Gv426iATUWvU2JwhOdvae6oJEVqlb0qdUelO/W5rQ3AR4tdw2xBsN3XXnROxUWXDmWmGnjC47Jh9p8GyUNhqRBSlruG3WYWxSSpQxQOm0sJBCtLCIoDZ2YBlPwFeqmf0JH5epyT9b6f1ahc4U5KcJT/rVzI7bAoB8+aK/Kd4jglJtM8so79w88fiB0ppgYxMG8r9kde1R9VCoAGaBdDm+7mdZYjGiRVMoA+xeVyK7M1H1mEiCQP0aD+9FXktmXR5keE60o4QDOoncmPlXGnY7GbLH0X1wDzfueDReHEjhX79tNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEiJceLlcKnVFrL/MsFC1Z+4IxFS8HmzvW6SPBNXmRc=;
 b=nxOwck8hJxsinVxu0gxVgPYs+/IobAdMRhCFmAeEg02VQKpQgkWSq/1HP39lkFFsiYmPURwLPfAzOoBfsC8xYDXMXSbAF+/Xta/zM+SXocTcu5exZiCMeZwnscEyXm2SZuCX94lstCDuAhmfjfw/ikNIzFNix1KI7gJknqTte7Q=
Received: from CY5P221CA0066.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::43) by
 MN0PR12MB6002.namprd12.prod.outlook.com (2603:10b6:208:37e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.37; Fri, 1 Sep
 2023 06:47:15 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:4:cafe::e5) by CY5P221CA0066.outlook.office365.com
 (2603:10b6:930:4::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23 via Frontend
 Transport; Fri, 1 Sep 2023 06:47:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Fri, 1 Sep 2023 06:47:15 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 1 Sep
 2023 01:47:14 -0500
Received: from xhdpiyushm40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 1 Sep 2023 01:47:10 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <michal.simek@amd.com>,
        <u.kleine-koenig@pengutronix.de>, <linus.walleij@linaro.org>,
        <robh@kernel.org>, <herve.codina@bootlin.com>, <frank.li@vivo.com>,
        <balbi@ti.com>
CC:     <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH V3] usb: gadget: udc-xilinx: replace memcpy with memcpy_toio
Date:   Fri, 1 Sep 2023 12:16:41 +0530
Message-ID: <20230901064641.7394-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|MN0PR12MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f5f6f8-7cdf-42b1-6cbd-08dbaab7472f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MUaEScZrfw++aKcCEKpZRXXAYVY7QFzV4nO1lCectdPQ3Sp36sqVxV2tPAhEWXsqaHmAZdFIXbkX10k4VIxF9mWRz/4b++JMRFfiAoE4y/TNDHgmpbJyQaAC9R8skHtjjzBMueYmlbW3ZkUNGeIXnz8o0Hg8oL2sczE02vDUmA8xsKdIZJtxqBLmF6U+XSiUd8RTYkf5wsxgPvIGl1Wd3Nnm2k2rZ+TPGiZSmYvMGazbzEs6C1aNWiX6eAAtGOcB90DsrNvxZkUlUD4SeuuBjXI7CUAvb6t16wmRT/r/b4xNU4QMzPZctcHPCSMOyhBOKDVGC4uO9z8U3VGyRdAngIjRcvndATtVaeKSY2uy8A7m0MLa1hX55WIczL3/AITxiwYCR4e2FfXEiFuFygb53XfsdNnEsODl3HtyojsimLyOWFUo3V1dfOR55iXNbgtCi21O1gm3RqGFY9jzShR/7VN7xm1FL/yIRXVrbxS38wlTVVRAk0rbwpUkeNMrMLTThsL4E/+h3+LEdxZPhL5mrk7vpLHPISt/FXQ7ekjpq7ITrTP8UOEtE6rPb13n1x9nE/mpW6wrAYea1R1YMtM/bzA0bM4+rLNXDFi2+pfYimHCkTxBaagfJzL5O9JjRZAWP4HJ2agYdsTL5IXvZtvpsLF594+srqxJAsPmkTEBe/iyT2qbkwNgmIrF+jAqIGNtNRp3Ne51IegF0ZoKJVCGlc6vOw1Ts+ubHYdZcOEwPzN1ipRvpDart/vv0mwj9rL9gKF+hXEwmT3vrnBsf3sPNxVIy+fb5MXWHNOhtUtRBbs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199024)(82310400011)(1800799009)(186009)(36840700001)(46966006)(40470700004)(82740400003)(356005)(54906003)(110136005)(70586007)(70206006)(966005)(6666004)(7416002)(426003)(336012)(81166007)(316002)(83380400001)(86362001)(2616005)(2906002)(45080400002)(1076003)(41300700001)(478600001)(36756003)(4326008)(8936002)(8676002)(47076005)(44832011)(26005)(36860700001)(40460700003)(5660300002)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 06:47:15.2147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f5f6f8-7cdf-42b1-6cbd-08dbaab7472f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6002
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For ARM processor, unaligned access to device memory is not allowed.
Method memcpy does not take care of alignment.

USB detection failure with the unalingned address of memory, with
below kernel crash. To fix the unalingned address kernel panic,
replace memcpy with memcpy_toio method.

Kernel crash:
Unable to handle kernel paging request at virtual address ffff80000c05008a
Mem abort info:
  ESR = 0x96000061
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x21: alignment fault
Data abort info:
  ISV = 0, ISS = 0x00000061
  CM = 0, WnR = 1
swapper pgtable: 4k pages, 48-bit VAs, pgdp=000000000143b000
[ffff80000c05008a] pgd=100000087ffff003, p4d=100000087ffff003,
pud=100000087fffe003, pmd=1000000800bcc003, pte=00680000a0010713
Internal error: Oops: 96000061 [#1] SMP
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.15.19-xilinx-v2022.1 #1
Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __memcpy+0x30/0x260
lr : __xudc_ep0_queue+0xf0/0x110
sp : ffff800008003d00
x29: ffff800008003d00 x28: ffff800009474e80 x27: 00000000000000a0
x26: 0000000000000100 x25: 0000000000000012 x24: ffff000800bc8080
x23: 0000000000000001 x22: 0000000000000012 x21: ffff000800bc8080
x20: 0000000000000012 x19: ffff000800bc8080 x18: 0000000000000000
x17: ffff800876482000 x16: ffff800008004000 x15: 0000000000004000
x14: 00001f09785d0400 x13: 0103020101005567 x12: 0781400000000200
x11: 00000000c5672a10 x10: 00000000000008d0 x9 : ffff800009463cf0
x8 : ffff8000094757b0 x7 : 0201010055670781 x6 : 4000000002000112
x5 : ffff80000c05009a x4 : ffff000800a15012 x3 : ffff00080362ad80
x2 : 0000000000000012 x1 : ffff000800a15000 x0 : ffff80000c050088
Call trace:
 __memcpy+0x30/0x260
 xudc_ep0_queue+0x3c/0x60
 usb_ep_queue+0x38/0x44
 composite_ep0_queue.constprop.0+0x2c/0xc0
 composite_setup+0x8d0/0x185c
 configfs_composite_setup+0x74/0xb0
 xudc_irq+0x570/0xa40
 __handle_irq_event_percpu+0x58/0x170
 handle_irq_event+0x60/0x120
 handle_fasteoi_irq+0xc0/0x220
 handle_domain_irq+0x60/0x90
 gic_handle_irq+0x74/0xa0
 call_on_irq_stack+0x2c/0x60
 do_interrupt_handler+0x54/0x60
 el1_interrupt+0x30/0x50
 el1h_64_irq_handler+0x18/0x24
 el1h_64_irq+0x78/0x7c
 arch_cpu_idle+0x18/0x2c
 do_idle+0xdc/0x15c
 cpu_startup_entry+0x28/0x60
 rest_init+0xc8/0xe0
 arch_call_rest_init+0x10/0x1c
 start_kernel+0x694/0x6d4
 __primary_switched+0xa4/0xac

Fixes: 1f7c51660034 ("usb: gadget: Add xilinx usb2 device support")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/all/202209020044.CX2PfZzM-lkp@intel.com/
Cc: stable@vger.kernel.org
Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
Changes in V3:
- Added "(void __iomem *)" proper type-cast for memcpy_toio API.
- Resubmitting the patch because it was reverted due to a sparse error/warning.
- Sparse error/warning fix available in usb-next branch:
  Links:
  https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=usb-next&id=52ecf812de2548ea0704e67f99cea1d0f3b8b173
  https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=usb-next&id=0411fa8a5f655ebc0753e718fdfe68bc66a756f0
  https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=usb-next&id=7f93e683bc0667a6b5e0da4b49fa07938a9ccad4
- This patch created based on REPO:
  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
  Branch: usb-next 
  base-commit: 895ed7eb263d7ce2d2592fdd3e211464a556084a

Link: https://lore.kernel.org/all/202209020044.CX2PfZzM-lkp@intel.com/

Changes in V2:
- Address Greg KH review comments:
 - Added information in the form of a Fixes: commit Id (commit message).
 - Cc stable kernel.

Link:https://lore.kernel.org/all/YwW8zE8ieLCsSxPN@kroah.com/
---
 drivers/usb/gadget/udc/udc-xilinx.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index 56b8286a8009..74590f93ea61 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -497,11 +497,13 @@ static int xudc_eptxrx(struct xusb_ep *ep, struct xusb_req *req,
 		/* Get the Buffer address and copy the transmit data.*/
 		eprambase = (u32 __force *)(udc->addr + ep->rambase);
 		if (ep->is_in) {
-			memcpy(eprambase, bufferptr, bytestosend);
+			memcpy_toio((void __iomem *)eprambase, bufferptr,
+				    bytestosend);
 			udc->write_fn(udc->addr, ep->offset +
 				      XUSB_EP_BUF0COUNT_OFFSET, bufferlen);
 		} else {
-			memcpy(bufferptr, eprambase, bytestosend);
+			memcpy_toio((void __iomem *)bufferptr, eprambase,
+				    bytestosend);
 		}
 		/*
 		 * Enable the buffer for transmission.
@@ -515,11 +517,13 @@ static int xudc_eptxrx(struct xusb_ep *ep, struct xusb_req *req,
 		eprambase = (u32 __force *)(udc->addr + ep->rambase +
 			     ep->ep_usb.maxpacket);
 		if (ep->is_in) {
-			memcpy(eprambase, bufferptr, bytestosend);
+			memcpy_toio((void __iomem *)eprambase, bufferptr,
+				    bytestosend);
 			udc->write_fn(udc->addr, ep->offset +
 				      XUSB_EP_BUF1COUNT_OFFSET, bufferlen);
 		} else {
-			memcpy(bufferptr, eprambase, bytestosend);
+			memcpy_toio((void __iomem *)bufferptr, eprambase,
+				    bytestosend);
 		}
 		/*
 		 * Enable the buffer for transmission.
@@ -1021,7 +1025,7 @@ static int __xudc_ep0_queue(struct xusb_ep *ep0, struct xusb_req *req)
 			   udc->addr);
 		length = req->usb_req.actual = min_t(u32, length,
 						     EP0_MAX_PACKET);
-		memcpy(corebuf, req->usb_req.buf, length);
+		memcpy_toio((void __iomem *)corebuf, req->usb_req.buf, length);
 		udc->write_fn(udc->addr, XUSB_EP_BUF0COUNT_OFFSET, length);
 		udc->write_fn(udc->addr, XUSB_BUFFREADY_OFFSET, 1);
 	} else {
@@ -1752,7 +1756,7 @@ static void xudc_handle_setup(struct xusb_udc *udc)
 
 	/* Load up the chapter 9 command buffer.*/
 	ep0rambase = (u32 __force *) (udc->addr + XUSB_SETUP_PKT_ADDR_OFFSET);
-	memcpy(&setup, ep0rambase, 8);
+	memcpy_toio((void __iomem *)&setup, ep0rambase, 8);
 
 	udc->setup = setup;
 	udc->setup.wValue = cpu_to_le16((u16 __force)setup.wValue);
@@ -1839,7 +1843,7 @@ static void xudc_ep0_out(struct xusb_udc *udc)
 			     (ep0->rambase << 2));
 		buffer = req->usb_req.buf + req->usb_req.actual;
 		req->usb_req.actual = req->usb_req.actual + bytes_to_rx;
-		memcpy(buffer, ep0rambase, bytes_to_rx);
+		memcpy_toio((void __iomem *)buffer, ep0rambase, bytes_to_rx);
 
 		if (req->usb_req.length == req->usb_req.actual) {
 			/* Data transfer completed get ready for Status stage */
@@ -1915,7 +1919,7 @@ static void xudc_ep0_in(struct xusb_udc *udc)
 				     (ep0->rambase << 2));
 			buffer = req->usb_req.buf + req->usb_req.actual;
 			req->usb_req.actual = req->usb_req.actual + length;
-			memcpy(ep0rambase, buffer, length);
+			memcpy_toio((void __iomem *)ep0rambase, buffer, length);
 		}
 		udc->write_fn(udc->addr, XUSB_EP_BUF0COUNT_OFFSET, count);
 		udc->write_fn(udc->addr, XUSB_BUFFREADY_OFFSET, 1);

base-commit: 895ed7eb263d7ce2d2592fdd3e211464a556084a
-- 
2.17.1

