Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C127DFBEC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 22:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377410AbjKBVLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 17:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbjKBVL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 17:11:28 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02olkn2012.outbound.protection.outlook.com [40.92.50.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD14A18B;
        Thu,  2 Nov 2023 14:11:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMLWWRTPxgnRLWma7zGP+ojfPN9Iq+rczOsZTwbZo53oVP399a92hE6YxkHvLVfIOyxm0gylEkm/BBAFTRowEmWxYfGZ3s27usgebXTRBrG/a9LUjIRyb8yaCwQMeLZiheOsL/haio0lw2svI7JzyIyo5KTmEaw9wTFpi4jJt4k5xvdT75xGHFqFFelj2UPfulk3mqTiszvHXDWww9wd8MtoyQs/YjU99XKTJpp7dv11EUbRGAIpN3jR9YZxbLLTZCiC5p48Lpbu/wm9gesvZrtKWrEvj2M39ncv/QiXyAHgJqPRjJhL9umH1tkF6xq1LdU95aOPU6FR+NUwUmsi4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfMl8OV1T+UQ9cwvjVcSSwYeOyEPjzIWy8qtc8zg4XY=;
 b=JAsPf0TsL/tUtCsGt5kQ7eb4wcRHzpVh0cDX0ALJqGLzJLGlpuDVVEsPc2bsrKt8QrVer4j2IsFx96Wd3GHSo4v5w4Efzicw9re8nku/tu/XXt1/xpYayS17PtMR6rXldsDCvP6CI6FatTKMB1cuog9WAzyJIpPRlssYpFB9mycE3VfGQFSCQtR7YY4A2btgNZMp9aea5aEjaWASRzpnLSyjPL2qZVHWNRujJaoyOmQMlN/v0I+nPd6GuBVWl/9ohwO4XkG0qCIDKVFZnjw81FQZZu03b7UkcCvywPP7Rw6D/AQmNfj0wWwb0+cI42+cBHgb31Y1dX1Xej+9S3g+QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS4PR02MB7903.eurprd02.prod.outlook.com (2603:10a6:20b:4b3::5)
 by DB9PR02MB7891.eurprd02.prod.outlook.com (2603:10a6:10:33f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 21:11:21 +0000
Received: from AS4PR02MB7903.eurprd02.prod.outlook.com
 ([fe80::a2ef:c7a3:facd:dc98]) by AS4PR02MB7903.eurprd02.prod.outlook.com
 ([fe80::a2ef:c7a3:facd:dc98%6]) with mapi id 15.20.6933.028; Thu, 2 Nov 2023
 21:11:21 +0000
From:   Cameron Williams <cang1@live.co.uk>
To:     sudip.mukherjee@codethink.co.uk, sudipm.mukherjee@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     Cameron Williams <cang1@live.co.uk>, stable@vger.kernel.org
Subject: [PATCH v2 RESEND] parport: Add support for Brainboxes IX/UC/PX parallel cards
Date:   Thu,  2 Nov 2023 21:10:40 +0000
Message-ID: <AS4PR02MB790389C130410BD864C8DCC9C4A6A@AS4PR02MB7903.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <BBParport>
References: <BBParport>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [rH2juAO+2rJZh1U1sVyH54ytqXONIpCG]
X-ClientProxiedBy: LNXP265CA0009.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::21) To AS4PR02MB7903.eurprd02.prod.outlook.com
 (2603:10a6:20b:4b3::5)
X-Microsoft-Original-Message-ID: <20231102211105.1150-1-cang1@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR02MB7903:EE_|DB9PR02MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: a449dca7-0010-400b-d3a7-08dbdbe84350
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EiM7Ewa5dptFlX+a4gTA+MdyAYCr/vM3A05ay22Lc7YBuArbmfDM2nDB/jO0nTUKhzVGvfzGvThxj1bN6djX02RBq6KsHqMcFLahhhWSYyFaTNgtSU5UHMxAel5dedbCAYf3cf8jdyxhZfBceaNtzCcgHnfeeG6ibOc64DBqPkUCjP8AXW5CJ8O4CF2cREbK34wqkuv8MOResdlHnfLXznqkdLZ9LtKQJOdLQbJp0wGiq42DHY8VZYgqkahXgPHfNckk2fQdsScacRRIqLrwMOCTjh3rMT6ppSF5913RB/xENdF6kg0COzUb64rCG8sjfAMYYa/3YpC3GfX+MX3Kc0T9/4Z149Obm8AsCsP8AzNfPZffBzhJAFJja8RXYboAetY1InkuZTemkRhR9aMg4P/WhWSa+in5irqXpYLVzz5xvrSu/kwqwqtbsCxN73f4wdq+4MSgfzqjw3dpalwflULGeV5FQgVjJ/M6fDxxNMKJ8J2cLtsQjUMmNlB4nuLAupIiMBCSdFLDVZhyshk1fMHqtB26B2Fiq5o20OdmBQyXffy7uIX1L8kpXHulG0DUCpdY0UWNq7f4m+S0egV3dI600OmA/vdEr0I+/dvGras=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OTdp/2jKw3ZJljDjKT40kPW6YmYnTZIvAXMddidIsXTVs1VYpmh8+gM/tjD/?=
 =?us-ascii?Q?6RjwsTphpYjj2iV6v+oN7UWfRDlEZUFlGU5XeUHcEBDb5HrIke3zgtRNQxsj?=
 =?us-ascii?Q?3nnxvZRl5TAj0cCWJG0rDo+8ps/RzI4DXbh+RfjeWdNP/6fZYoi51bYLABMZ?=
 =?us-ascii?Q?meuizw++a8uV4mi9Qre2WjXBpJq9SacEvWeMJbkYsSc2pEl3jBvYiXXs6VuL?=
 =?us-ascii?Q?C3Fic1jPdnO7YlUlncILItZ4HmqSyApY34RnLhXy9SMH2mlMGkcI/oBdJV16?=
 =?us-ascii?Q?DAklAcb6+PwpirNBAM07lGOOc9tS/IsIe1vfF9TDzGIYxsHZIGmmdnGFv+Xc?=
 =?us-ascii?Q?a6aBEhhaFSZXZw70nyLtfZCkBVZSYBhjsweP/w1Yj+I9V7XM7049qUptPDEp?=
 =?us-ascii?Q?pm8K/xS4j+zIZqXRtWMzalXf4hEiGwijpRGFoI67wmCC4ZNxreWA7Wp2fYJn?=
 =?us-ascii?Q?3bZiUAnZ7OUSw4cN7DWXS2gLe6DIsXxp8mfOgcaRDzx5b7rKykXcoNjSnTMu?=
 =?us-ascii?Q?BnTp9pQm44mJMizKIyES6oJRtTgWHsVj8ou4Y5Xq3II10J30So+Qlfck30Hb?=
 =?us-ascii?Q?3qW7NmR0htATkqf90G4rvrHJnpHchbK1pgc42qTb5OsEebBgFqtduL4NKJmg?=
 =?us-ascii?Q?pwuDwwO+UD5CnuSxbx7PPN4hOctHot40KL0nCiElXIn0KUQKD5mBdYwzTBsD?=
 =?us-ascii?Q?w0GM7ujKomeCrFWzoeRypgRWZBoVUnaE7V9QTHGsqquqweC7IdF8U3FxB4TW?=
 =?us-ascii?Q?cuGQhZgQq7jtlK7fkOh+d1cOyvsctQpsGzkUxboGA1aLFUM52LkOYtMS0rqi?=
 =?us-ascii?Q?RaFEcwNY4qTzTDtDbyILa4NrVDIgAqjejVhTOEEkQJL7Wv22WOw22awjI8BX?=
 =?us-ascii?Q?MzRVL7qZ6b14pdRu0qSF9nUe3MJ/68uBhzHrxSegZcHoJgGAHAbQLK6fXY9z?=
 =?us-ascii?Q?9IQ1nwgYvls1xUjf1H4wKra6AlACHElGD/N4B8yFGSLcd2YJKCuKTf3mqvYZ?=
 =?us-ascii?Q?boHER5sWSSDc5VRFcNAWocZf1aSg3SJow2LkD/GzPRqhFdSueddpY64tJ5O3?=
 =?us-ascii?Q?7cmkTJ9tqgKYgtCpyJvaCyc96zjZW5tFPUmqyAzwkH67+z2JgODW+5vAjBOB?=
 =?us-ascii?Q?dA0PGGeAex2jttyCiFPmMr0WxCndrUkM2/Xxkn6WYVR9mZHncKZaUdZWihwh?=
 =?us-ascii?Q?HwlrTjVud2ws1y1eLpvfV4oHXevRb7BTt0aGpg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a449dca7-0010-400b-d3a7-08dbdbe84350
X-MS-Exchange-CrossTenant-AuthSource: AS4PR02MB7903.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 21:11:21.5342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7891
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for Intashield IX-500/IX-550, UC-146/UC-157, PX-146/PX-157,
PX-203 and PX-475 (LPT port)

Cc: stable@vger.kernel.org
Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
I think this one fell through the grate. Copy in stable this time.
v1 - v2:

This is a re-submission for [1], instead using raw hexadecimal
IDs for the PCI device. This patch is also sent separetaly instead
of part of a series as was done previously.

[1] https://lore.kernel.org/all/DU0PR02MB7899DE53DFC900EFB50E53F2C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/


 drivers/parport/parport_pc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 1f236aaf7867..f33b5d1ddfc1 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2658,6 +2658,8 @@ enum parport_pc_pci_cards {
 	asix_ax99100,
 	quatech_sppxp100,
 	wch_ch382l,
+	brainboxes_uc146,
+	brainboxes_px203,
 };
 
 
@@ -2737,6 +2739,8 @@ static struct parport_pc_pci {
 	/* asix_ax99100 */		{ 1, { { 0, 1 }, } },
 	/* quatech_sppxp100 */		{ 1, { { 0, 1 }, } },
 	/* wch_ch382l */		{ 1, { { 2, -1 }, } },
+	/* brainboxes_uc146 */	{ 1, { { 3, -1 }, } },
+	/* brainboxes_px203 */	{ 1, { { 0, -1 }, } },
 };
 
 static const struct pci_device_id parport_pc_pci_tbl[] = {
@@ -2833,6 +2837,23 @@ static const struct pci_device_id parport_pc_pci_tbl[] = {
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, quatech_sppxp100 },
 	/* WCH CH382L PCI-E single parallel port card */
 	{ 0x1c00, 0x3050, 0x1c00, 0x3050, 0, 0, wch_ch382l },
+	/* Brainboxes IX-500/550 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x402a,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_pcie_pport },
+	/* Brainboxes UC-146/UC-157 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0be1,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc146 },
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0be2,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc146 },
+	/* Brainboxes PX-146/PX-257 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x401c,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_pcie_pport },
+	/* Brainboxes PX-203 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x4007,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_px203 },
+	/* Brainboxes PX-475 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x401f,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_pcie_pport },
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, parport_pc_pci_tbl);
-- 
2.42.0

