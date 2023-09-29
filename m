Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176957B3233
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbjI2MPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbjI2MPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:15:32 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13DE19F;
        Fri, 29 Sep 2023 05:15:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqPn0mKKnIQ0k7v8ME0KyCOspGeUwKbUDYd6dlM1QNvOQjQhbEOY4tbnEeYu0VSAjz9VWysRGzVeTxlCitoELcNixszlrFvOt2OEQJLRbNg+oMhuZO1XZ0qbZ3xG92U+Qzx4WnKQZFSeYEJVA45yDeExQ3X7iN9uZMYtO+4DGCH4dtKtwaiavbrLLTG709QMPokcwLEkyCIBOGA2Z19Pp2LrYHOrQBj9fS9Z+x8OzOHbaAQk6g/vsnZ5B9sHrAQjztFS4YWdPYpuvavSY2i4sGJ60uEXhoUvJTWyyh2XB+ZwjK5Z8olAa+y6Xkh3w0qZMEHN154+YvMjMB2UrN0M0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPQ202lgOtNv+CjgcEOgF09lVo7x6AcaE15+v5B/WaY=;
 b=YyZHEU+jhuWna7BSYB9ydRl0kCljFtUiFOKepaIr7bBHfKnPI96dB+qdYTqkgs/bu+jep7WU+qsjFQekEL6IuG01HlSjS5NcD1hT6NpfYTEqTDiOibc5MlryADp0HGN/TF2x5iOgJyhXP8LXCkDfEGXZhDoI+ecXMAH/rG7d6spb6o1r1B0ZpIM+U/dYZWUgOCnTQurvAz9BTd0OouH6IH1Z4UWw5tgBft3Ws5wxcIiG7JtB2PZbpw8Bfxprzp3kQtXG5BazwqZ2lnbc0vNzvRuOQzMjNnXDIuUkRCL/1X3RB/T61a/YDJMLAnsph2W0Jk60mVaZ95K8FM2lAoeTcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPQ202lgOtNv+CjgcEOgF09lVo7x6AcaE15+v5B/WaY=;
 b=DuC6++Q1JWHe8lM/bdfw/vFAqkdE4mJO+qrz9TJjBfD9DgbxxJW3Rivlf9CWOSAy5TxsN8UtJMT99zrm1yvrbBnIgHAFDI+bKxzq/p1lTGhLLNu/aKGsGi7GoFqVCRJL4wRIcBMOc7Vrg9lz0SRRyCMnVD2QZ4WON+mVRakvGAw=
Received: from MN2PR18CA0029.namprd18.prod.outlook.com (2603:10b6:208:23c::34)
 by SA1PR12MB8920.namprd12.prod.outlook.com (2603:10b6:806:38e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 12:15:27 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::ce) by MN2PR18CA0029.outlook.office365.com
 (2603:10b6:208:23c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26 via Frontend
 Transport; Fri, 29 Sep 2023 12:15:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 29 Sep 2023 12:15:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 07:15:26 -0500
Received: from xhdpiyushm40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 29 Sep 2023 07:15:22 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <michal.simek@amd.com>,
        <u.kleine-koenig@pengutronix.de>, <linus.walleij@linaro.org>,
        <robh@kernel.org>, <herve.codina@bootlin.com>, <frank.li@vivo.com>,
        <balbi@ti.com>
CC:     <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>, <stable@vger.kernel.org>
Subject: [RESEND PATCH V3] usb: gadget: udc-xilinx: replace memcpy with memcpy_toio
Date:   Fri, 29 Sep 2023 17:45:14 +0530
Message-ID: <20230929121514.13475-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|SA1PR12MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: 63dace53-9d4e-474a-ff97-08dbc0e5c3ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fS0/xsQrOJWpExl/5cLLGY4E7Ryh5sA3kX33Xy2spzngAv6RLQ//X3E62eKABwXOT3AQsw5NFEtdL3hhf+HXVl81/SK0/ihN81MlOIMtXHj796k8IAAEXCBL/7BYEQQCGpyXn42ONPCPyXkfyQywyi3zISgNmS2z40PswL3/nqYI/kWkxJglMu0U5lc8lS3DUYl2BSHXs3V3iO79+I4VCt7CbNzCBFDiQzEtTnE7jvCntiGO6V/qxgbAulzc5+uP2v8qBjcPAhpODQwWtMi1mMlyc+KlvT2pON5ujoAK7f3yQDGpvx36olno/Fwvfmr7H+wcwmZ1Za6AdBtrGAeWFcKt5so1iYmirdZcYZjtRTekOctrg3qj297YkVu1uOT/687VN3k8IynReFnBWj33n1Q4w9aeZe1RUhM3/VahLMWXWDhI4UFn5PDrWjHvKDHfJpeKVzU86O3JOgiaZoZE2U+4F+E/rzd17jHrbljkSgL6K7inoVFfDMAtOK8ifaO/y9u/8I2q1lQh8d4+bLpv5uOwIGHsIgtyHtQaTyTdYLHq8+1PeZ4NqohilfcsTJDC1guwpUOW2nS28ZvTNaA4xPt6bu9VVmR54ShC3TrNuj5M6XCRr1Ildw59Jkd4+NuPmcEg5YEivXX6/DY3LUCuhZaKfkoE3Q5tQOSNEzzWOJMCCrzqrKCi8Imq1B4oSnNkq8PYgU9r163bRLj3vCbhZ1PFFpaedS1wL8VNZPOmQfFYeKdLouwxoCnYfHaOEyMtDgDyHhB5mS6F+5Qu0hJOIfNiETyKwwTsdKp2HS4aMzM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(6666004)(81166007)(82740400003)(356005)(2616005)(41300700001)(1076003)(54906003)(26005)(316002)(36756003)(86362001)(70586007)(70206006)(110136005)(44832011)(2906002)(5660300002)(336012)(426003)(47076005)(83380400001)(7416002)(8936002)(8676002)(4326008)(36860700001)(966005)(478600001)(45080400002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 12:15:26.7493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63dace53-9d4e-474a-ff97-08dbc0e5c3ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8920
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
Changes in RESEND V3:
- Resend Patch- Created on https://github.com/torvalds/linux.git
  Branch: master

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
-- 
2.17.1

