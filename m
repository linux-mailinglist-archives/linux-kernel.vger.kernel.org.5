Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAA17DFBE8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 22:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377404AbjKBVIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 17:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbjKBVIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 17:08:46 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2010.outbound.protection.outlook.com [40.92.59.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B39618B;
        Thu,  2 Nov 2023 14:08:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5g+uRqOeiHybCmDuJAv4JtdYtXIfesjwV0Do8Sb44Qw7fmsvyaQAC6wyFHn8jmkcxu8LAHOQpc99GEYT2k0cmF+z1sBZB/jIwSzkgdAiYTagqwQqWLbXQlSoXCERrZYurIDnXsce4dFOhDoHM4I+h596CSLGuPpwdpd+gKUK1F4fxQlRjIM1u1yAa+47iVH+awF9pQwvpXFamlzpI5H/k+4Xd05ch/ZXmRY4bAaJBDocOJEeiD2T1+mKf0f7OayNnjKxuN23RocZa9plWuN7UyBOkzFYlXOTURTVLEWCnXiEc2+W0oCgxL7gS1i/j4Jvl/ewzlbNCiBEU1ywt1a3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWViHfiTMTuKjmjYjkawo1t/PJT9rIAMGWs7rouVDmA=;
 b=Dx1oqIc4GCoasvxR8KT4pghtZEydpY+n5pks7y6gnsMPzSWQJxMsJCCxg3TLoFyCgPy2kkLUru2uNyk1V+WRoJsqKC7SoJIz7MxZzoTcxdcFr8xwl+jC/Sb1zYLnnMoqPj9b7cu0qZZKU2bnl0ZPff/56aDXCHKwTaoFbR2vcq8RrWHLLUSUljLWNY0s3PMUxMm7bRGFUjzo/4eb618AkRgRcRX/z4ITudN2YiKSLwV4B+njZx2xN9Ew/US1L7dYoWRtl8uzZwoTUWaFSTZICMeFhSLVjCB6fzIUfSTm2/E7yiTCqjxEz11iBMeUCsr3ALkrUrvr8x8xk9bzvUPFnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS4PR02MB7903.eurprd02.prod.outlook.com (2603:10a6:20b:4b3::5)
 by DB9PR02MB7891.eurprd02.prod.outlook.com (2603:10a6:10:33f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 21:08:40 +0000
Received: from AS4PR02MB7903.eurprd02.prod.outlook.com
 ([fe80::a2ef:c7a3:facd:dc98]) by AS4PR02MB7903.eurprd02.prod.outlook.com
 ([fe80::a2ef:c7a3:facd:dc98%6]) with mapi id 15.20.6933.028; Thu, 2 Nov 2023
 21:08:40 +0000
From:   Cameron Williams <cang1@live.co.uk>
To:     sudip.mukherjee@codethink.co.uk, sudipm.mukherjee@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     Cameron Williams <cang1@live.co.uk>, stable@vger.kernel.org
Subject: [PATCH v2 2/2 RESEND] parport: parport_serial: Add Brainboxes device IDs and geometry
Date:   Thu,  2 Nov 2023 21:07:06 +0000
Message-ID: <AS4PR02MB7903A4094564BE28F1F926A6C4A6A@AS4PR02MB7903.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231102210745.1107-1-cang1@live.co.uk>
References: <BBParportSerialV2>
 <20231102210745.1107-1-cang1@live.co.uk>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [tAbaQoxBMLZMjPlaUOCGo7mud3HfVf6t]
X-ClientProxiedBy: LO4P265CA0192.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::20) To AS4PR02MB7903.eurprd02.prod.outlook.com
 (2603:10a6:20b:4b3::5)
X-Microsoft-Original-Message-ID: <20231102210745.1107-2-cang1@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR02MB7903:EE_|DB9PR02MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c2411f9-45fc-4e3c-02dc-08dbdbe7e35c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IEhEFeIZia3g8iMAToWGDE9GqZ5MzVU/GDi+SkzbOm/Fm3KNeLtFaq20PTagCo9LszC+1T5JbvoVXTc6pdIcwfmo79e5aVm+hAq7APadBvTrtafUmwR8ccEZ+oPf89uoR0lNpDjM7Omjc5rKXyBoZGtE4/2t5LR2OUD0PEAdCuYPYCWoDgWBz/xLuCoRa8xX/8aZZghnJjoL2joL/bu7PvR7bAgl2i+K13GUZN/E6M3vEevwGzWqmxrZBdzXU6yKWu2UKrEWRsPdtJAGWx0GHyMlJXe/su22dV0vzwf9IcF9UlCO5/EmFWRuw/yLLLqaufP2K/dIdS2Xw4A2Co1/fLaJreQQ0ThW3odjLSYX0XxKRJNvFiJOMKZOYYhE97sEvZ0D/wC6rj0jbEfEX9YPsXlJgF+UvtQdinvkP87b3mURLDpbhT2uu6hTZJL5ZadWkncwxrkp74eCyEZOvIUXctdDbP/sRqOei7fE4Pt7zDwb8tk84dNKhjbySSoGEfBf/LxfJ7Mx5mTTQwo06P8PSfq3I5uxCCN5veePWiU8GpwvFb9Ai1rB8lHJuwlCV9ePImkynb8sErr/HAVu8Jssbe/Z6xyHDIZJO72dRUidb1w=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gbgd/BRKbXWDVggk7EBBck/3HahHmejkLsAfYmrx4Xq4pYoME7ZDld755a4P?=
 =?us-ascii?Q?MCCEWwVJDFrGsKphK6+/w/l++16I2pPZyS7Q1gXvsK7hJikT+8newPqGw2LC?=
 =?us-ascii?Q?mvClZBNp9sZ0aCp+Vs/rrQpnaK6IYiwANhlYddUg8Ta5FsRGSx97usw8aAl6?=
 =?us-ascii?Q?cMvZbzhSWF3vfYjWnFAVjcLG2jTpsoL6G24g2e1kmjPpLpKSU5WWGmzMbriz?=
 =?us-ascii?Q?ubJ7dYRomOekQiequjjFM8jaUfSUycMz+OzfXe2oCZgap1lYZRMli7IHzuji?=
 =?us-ascii?Q?icTWxnN97Kb8f3Dxo5czFxOF9amayBQVXjC9m21zwhcGYCSm56dCT9hm/EHL?=
 =?us-ascii?Q?tsaHuZK955WJJh/ukbWdy9Fs7StW/TFCaAghHvRk+Zn0QHrvnJbnEDO5NujP?=
 =?us-ascii?Q?rFCeIhePAOf+h+YoOu5cF+6CfRGxIc/OOtYjFqSqQqfPG7B+1T5IHDc1Jf6Y?=
 =?us-ascii?Q?xIrzHj38ii3rEKOstNqz+Dy4ORvHvy0EPFhtMp++Dl8UWmGrv1W4ZjXByA0G?=
 =?us-ascii?Q?hZlmTV0Hy+Nh+yGPE1lZ9O1nbxltYxDhj1rVtHh2f8tNqTccj0JgkcL0kQmO?=
 =?us-ascii?Q?kGlrbVgHMZjH2qsgSXAZgEr6+VvB2xfLF5WEW19qBwSRZ6lvx86XeYOrDTs5?=
 =?us-ascii?Q?ID9wNBC44EoaVLHkB4Ubw8h/43efquD+xMQ9UY38Vye3Dr4gr3H42iA3Hw3p?=
 =?us-ascii?Q?yqVeKteiTiSJlO4YUn/pokWWSyOHrNjoauh0EbxWN+Fi8HRIKuq1+KEioZD+?=
 =?us-ascii?Q?+TPorllp8MjVCI9zVD4qu5CPa4uAkDoRs57IZr/KYRcTkQMwj0JjfYVlk75R?=
 =?us-ascii?Q?I2FiGU5QDHz9ekRBMPomxcVX2ckzuLjxfprKOtVAJHS5xQkvfOc/+TdJU7+i?=
 =?us-ascii?Q?812TMbzARYs+3HLehkZyOmNNjRv19353HFkiQ/2/4E6M4ESO2Em6Nhq71wyv?=
 =?us-ascii?Q?b4c9VT93qapFawE1sPaiFY5fqOkMARdk6wwAA8Lt2FRBddkJty82Vr4x8iFQ?=
 =?us-ascii?Q?SaVKOn+K5TGYQ+4U5vIvoYkvkua6cSptPqmp4pJk85xaGdlEMesaQFbEKVYV?=
 =?us-ascii?Q?d+WTOWOtcNvGJDk+jFvThZSV8qIo4ZT2yveWHfx5aYN6FAefOFMRuQ5Go5nc?=
 =?us-ascii?Q?QIYo8UOivKUWjhLVWr3iZmejFftawQ+wAOsiz2PvHVotMvmUmdd+iYTdgoDR?=
 =?us-ascii?Q?yOqeILUH5aAniuTApIgu1KL5ryV4EoErN+50xQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2411f9-45fc-4e3c-02dc-08dbdbe7e35c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR02MB7903.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 21:08:40.4360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7891
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device IDs for the Brainboxes UC-203, UC-257, UC-414, UC-475,
IS-300/IS-500 and PX-263/PX-295 and define the relevant "geometry"
for the cards.
This patch requires part 1 of this series.

Cc: stable@vger.kernel.org
Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
Looks like this slipped through the grate the first time. Cc LKML and stable this time.

v1 - v2:
This is a re-submission for [1] with the changes separated into different patches.
Part 1 of this series is required for this patch.

[1] https://lore.kernel.org/all/DU0PR02MB7899033E7E81EAF3694BC20AC4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/

 drivers/parport/parport_serial.c | 56 ++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index 11989368611a..e89585051fde 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -285,6 +285,38 @@ static struct pci_device_id parport_serial_pci_tbl[] = {
 	{ PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999, PCI_VENDOR_ID_SUNIX,
 	  0x0104, 0, 0, sunix_5099a },
 
+	/* Brainboxes UC-203 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0bc1,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0bc2,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+
+	/* Brainboxes UC-257 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0861,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0862,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0863,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+
+	/* Brainboxes UC-414 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0e61,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc414 },
+
+	/* Brainboxes UC-475 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0981,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0982,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+
+	/* Brainboxes IS-300/IS-500 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0da0,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_is300 },
+
+	/* Brainboxes PX-263/PX-295 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x402c,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_px263 },
+
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci,parport_serial_pci_tbl);
@@ -550,6 +582,30 @@ static struct pciserial_board pci_parport_serial_boards[] = {
 		.base_baud      = 921600,
 		.uart_offset	= 0x8,
 	},
+	[brainboxes_uc257] = {
+		.flags		= FL_BASE2,
+		.num_ports	= 2,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[brainboxes_is300] = {
+		.flags		= FL_BASE2,
+		.num_ports	= 1,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[brainboxes_uc414] = {
+		.flags		= FL_BASE2,
+		.num_ports	= 4,
+		.base_baud	= 115200,
+		.uart_offset	= 8,
+	},
+	[brainboxes_px263] = {
+		.flags		= FL_BASE2,
+		.num_ports	= 4,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
 };
 
 struct parport_serial_private {
-- 
2.42.0

