Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070837AA2DC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjIUVg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjIUVgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:36:13 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2017.outbound.protection.outlook.com [40.92.91.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFB02D203
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 14:11:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUVwZPZSD68KbbsO3hbOxdGHvOojt/xrYji+PIl9TCcxdgBvrPdT3baw5rwQFkL7ANJeYQJtnVekzcjDIsiS0YGm9UTxXmfsc1+sbvunW3JNVAziNXDsZHDUqPVa66FfJZviRnxbHm+ih7jlO31Xk9tjO7wlGR2p9dQlvXslDHw8SlRpsKNfDDQXH0DlRXAHn/PE5WWhKyNE9n2+wlL5pLxHdUyi2Ke+oPvPxOTxA4pj3NufsY4UVVibUM183mdSFPF3OVV0+sIGjtrFbv9bmThTk2WewXu9ps79E9loxNDQCuFjnkAissSmLm1y/RZ8Ozd/ReQyJIIJ8uvvKNZoKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIlyqpJkU5sWmfNTFGqe4fqcaWfjdFGlGb2e8rFLlBg=;
 b=XKAddbzc/IoOiCrXrMIJgPDkbnuaT2ZTVz5mqwsU4faBQ9w2GsDUdnRkfpn7JwtjpSKwPcsXnSpuDHAR8pLTggeOnLGAH4mUF31QnvxgCqCMdQGWRUzsp4744gaSCOi+q/He1O8QfQNqrxZRgTSRmzcF3iKksZjbXZknmUNh22697voETb/zlGpOyhvKAoRSD+Q1QhG/oQAaMOMaysNVUDlsPAm59BMvpVNulOIj3Dr2doLrJT29bIBINYL/xj4BsOU/1qGplhYH3yEDWXYjo7NHztnP5+QANLBJcbQK+M/C9JyGiOPerCbPhMKshwWf/EJffjN/NAgj/HNj0gqZqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by PA4PR02MB7134.eurprd02.prod.outlook.com (2603:10a6:102:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Thu, 21 Sep
 2023 21:11:32 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 21:11:32 +0000
Date:   Thu, 21 Sep 2023 22:11:29 +0100
From:   Cameron Williams <cang1@live.co.uk>
To:     sudipm.mukherjee@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] parport: parport_serial: Add more support for Brainboxes
 cards
Message-ID: <DU0PR02MB7899033E7E81EAF3694BC20AC4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [i816d8oIl9IiNEGVMjERFHuYxf532k23]
X-ClientProxiedBy: DB8PR06CA0026.eurprd06.prod.outlook.com
 (2603:10a6:10:100::39) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <ZQyxgUQXUWHHRuI0@CHIHIRO>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|PA4PR02MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: 43912daf-33cc-4a16-2778-08dbbae75456
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JTISbUdEKbutVMtZXKe/Shdv4cl8FuFhemlsgVPV66+s9179WIFFQ8mKWzTFw5DBWg0EdbTAM8iKzHywxpzWcIaDRF9w7Leds9d8v5uzwz5/ZVoALFkJt4dbF+vTJFi21oq6kvk6CjII1XnlQ6HLRYewJ5Y42VCSJgdRfYMyisI8k9I5bui7ynpKFIzgwOsOmSDD5F98BXNtaXciToWU5fqYNynaAsNLHyE+DPOPUi0XnGAwiJiykWJgO0QgvEcDtcsViVM2UtrOC8RxQq4k6vWq5u0I5q0GsetArYb02hAKockpS9qUHlQ6zbOPs1p51L2r2I7mts5iPWX+/M1JQuZjMOy16QR0tCqC4MbDxMfH3JN3ySnvWI7osYNipPzhfmCX611AYp9MR5WyDbKJNybvtWx8PYoUArI4mfnq7iwZeP0qPIBZ1P7JXiAWndbxeHfvj8H+nlwtfvXAyOj2KZXbqO9vAGOdoVldnWpsYWC8hYxm/n5JWbaYQ17Ik1LZEpolB/asBbY0tJRpheGDXAch//UYSYe8mn32hnWDRLhMKa7EclbjDibiv2sWQW65
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4V8fPd3q9QOiVTF8IXIE8B3m6c7hUFy6hMKKIzhZmBBUwVHUcb0axSBKjVj2?=
 =?us-ascii?Q?jJgHQU0j4FFoO9aA3/n77eHWamQlSLsN5H4qoEoV7uZ60TIkoaPOPzhmNLsX?=
 =?us-ascii?Q?CPAjB3VqwxoopL6OESF+ERekNHRu8AjCvMROYzGmkmw6UqS9wCtq7gI+D8iT?=
 =?us-ascii?Q?mlOzzQ7jMbdv+AV0eJIU3SeIyVHo/LSMxvtFgLJbSmOQa0OEQrkVZPrqEbdy?=
 =?us-ascii?Q?UnJyscjDCMS32YvMGR8Zv0WptBEbGMkzw0OQz7SM8XC6XisIYe5mD986JyN+?=
 =?us-ascii?Q?u/+lHhlDIrN8m1GCW8qM62kc94OG+fdxgjbXybL2hVKy3JRqrfmM0grl5v46?=
 =?us-ascii?Q?XGJRldn6ukv810rLdVcBxFqKcOFAL5aj/I6Uqbmu9i/DZZNa+AP54WUSDeKK?=
 =?us-ascii?Q?nyWigt0qnQWbuT+tIYo0VMrfUa4nkOm7Vhecb1AD4egwSEbT3kq142PEF2AB?=
 =?us-ascii?Q?vBvUgGi2OC5MtE3rZnzcaiAC3ItRTgWM+hNAGu/dYaJyVkMsFwMHlh9VKXOT?=
 =?us-ascii?Q?Y7yLkNFgvQfKq/B3+/EApBxqqGfUatK1bnHvCcTNba+v8DGYAQEdLHNqCTFG?=
 =?us-ascii?Q?KHfKY/P3PDjaF/h3cygmO+cxfYsaJZ6qNNc4V/qhZeNGWQuGMapMy+BxnkyN?=
 =?us-ascii?Q?5ZKPNQU1hAuOIjhmHxJ/BjqFIRsI/N3C2ntQU/4ApOu5WWy4IIyifTKt0w9H?=
 =?us-ascii?Q?kBaAd8/t9DPtwg3FdLYG6EbUHDhbIfZko5GTpNO/uimaG2XLDZbKlLJRPmem?=
 =?us-ascii?Q?sW6hwygr8W84YfmntoZZy+gem4ij5pLN3OmGm0hj3pHBXgDiYYPdg6/1boQT?=
 =?us-ascii?Q?SV6WeKPvZmb3PgXDQUt7osM6wUpaBl1j5E94sPWcOBr4a2ZuNwrrVLtJgsu0?=
 =?us-ascii?Q?OcremcWg3gkTQ0dHk1BSB8rjW5ZADXK4a+UmyBQ0KNmOMMTRNkjNJmj8LW7B?=
 =?us-ascii?Q?s53Lot8VG+Jh0Mz3otDItYd6qEId0rBPxQaljj11W/Uj/qb7dyNCQ3JzDjOl?=
 =?us-ascii?Q?CJDMq0uUNIiQ6SgISOAHwLgrh/Ev5rnN3YyV3El5dmIvbBbq0ZsYW9pZTuBE?=
 =?us-ascii?Q?3/1ufuINC6NJQhd2SczHU752KOgOKp1GIKdNXOtbumb/w7E+o5F9heWRePof?=
 =?us-ascii?Q?mbagYtUxwmF+DvgtCdDq2IxFwV/h6V5caTTzrgsqJfRfgwtiF5pHSqZhXdnh?=
 =?us-ascii?Q?BdnlIKl1IzqzZNTaj7AVTrdzC3kZLJEGSKmhyw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 43912daf-33cc-4a16-2778-08dbbae75456
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 21:11:32.0588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB7134
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Intashield IS-300/IS-500, Brainboxes UC-203, UC-257,
UC-414, UC-475 and PX-263/295 parallel/serial cards.

Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
 drivers/parport/parport_serial.c | 64 ++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index 9f5d784cd95d..c6fbee528493 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -65,6 +65,10 @@ enum parport_pc_pci_cards {
 	sunix_5069a,
 	sunix_5079a,
 	sunix_5099a,
+	brainboxes_uc257,
+	brainboxes_is300,
+	brainboxes_uc414,
+	brainboxes_px263,
 };
 
 /* each element directly indexed from enum list, above */
@@ -158,6 +162,10 @@ static struct parport_pc_pci cards[] = {
 	/* sunix_5069a */		{ 1, { { 1, 2 }, } },
 	/* sunix_5079a */		{ 1, { { 1, 2 }, } },
 	/* sunix_5099a */		{ 1, { { 1, 2 }, } },
+	/* brainboxes_uc257 */	{ 1, { { 3, -1 }, } },
+	/* brainboxes_is300 */	{ 1, { { 3, -1 }, } },
+	/* brainboxes_uc414 */  { 1, { { 3, -1 }, } },
+	/* brainboxes_px263 */	{ 1, { { 3, -1 }, } },
 };
 
 static struct pci_device_id parport_serial_pci_tbl[] = {
@@ -276,6 +284,38 @@ static struct pci_device_id parport_serial_pci_tbl[] = {
 	  0x0102, 0, 0, sunix_5079a },
 	{ PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999, PCI_VENDOR_ID_SUNIX,
 	  0x0104, 0, 0, sunix_5099a },
+
+	/* Brainboxes UC-203 */
+	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC203,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC203R3,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+
+	/* Brainboxes UC-257 */
+	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC257,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC257R3,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC257R4,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+
+	/* Brainboxes UC-414 */
+	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC414,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc414 },
+
+	/* Brainboxes UC-475 */
+	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC475,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_UC475R3,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc257 },
+
+	/* Brainboxes IS-300/IS-500 */
+	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_IS300,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_is300 },
+
+	/* Brainboxes PX-263/PX-295 */
+	{ PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_PX263,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_px263 },
 
 	{ 0, } /* terminate list */
 };
@@ -542,6 +582,30 @@ static struct pciserial_board pci_parport_serial_boards[] = {
 		.base_baud      = 921600,
 		.uart_offset	= 0x8,
 	},
+	[brainboxes_uc257] = {
+		.flags		= FL_BASE2,
+		.num_ports	= 2,
+		.base_baud	= 115200,
+		.uart_offset	=	8,
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

