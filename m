Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C877DFBE7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 22:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377015AbjKBVIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 17:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbjKBVIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 17:08:45 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2010.outbound.protection.outlook.com [40.92.59.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FD9188;
        Thu,  2 Nov 2023 14:08:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6hY33IqJwD3piC2s1FveVvH+npdLyMY7LrIa1ZcGqQf1rNoKWC57WD/7oGC9qStVmbQbNRIuJQyDKOmkO5yN7nY58ZOJrvlS94XhHWxHJcV/2FPNSFSBbkCyp5pPt1WbAIOeOlnf1kMAiycOEfOzJ7GjB3iNjZxKwjJyf0i+eUk6kdmdrd9UmFyIdCsx+gr9mDrW2OMiS7ASRHpuFH6S5Ri7FfdL5G8zalnEz3dvAF/ik6zsfA7UYSS0x9Ueo3nfbMDJsfqfBlbmVxMlgLbSEKZ4NEfpV5CW1PV7ZG0lqwyKME00RO6yj30O+ZeUoRbJM0bLcBBVXwHaCHuFEXwIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7t/A3LlHHmpOCXZofq8DjyF8cPXvd0u0cAz6xEYlli4=;
 b=JTtmIMVa63IUjMxSD1qQKWuFY6btfZHZL/TY//ojLZdlGJ6u21idHgy+BQj1LYv1YgE7fycy9vm7KyrcQcnnh98oWQnXfRESsvY4W52WRnCXuAKn2VrC7VSARQnPAF06H6yJXKKbOm8FyvfGizMUtZ4qrcgYQ9iY/l1CdOxYwnbC9KVb+JjY0NHppWZWaZEmPUHHlwa8nWpPqz6AQxnFv4SQ/ke/7ES2jzhYG6C86gQPFqTDkwS0o+jpvK10RPFsXwL8iETK53lIUZKtuDg6CBvofD2XUtsXF3op3ZRMzD10GMeFiak8xVH26upXYhyQhJ8wdiIV5NC/vGgKqoZe3A==
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
Subject: [PATCH v2 1/2 RESEND] parport: parport_serial: Add Brainboxes BAR details
Date:   Thu,  2 Nov 2023 21:07:05 +0000
Message-ID: <AS4PR02MB79035155C2D5C3333AE6FA52C4A6A@AS4PR02MB7903.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <BBParportSerialV2>
References: <BBParportSerialV2>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [ygtFgGcHaK7jNtkEE6vJN5tOB4kkudhr]
X-ClientProxiedBy: LO4P265CA0192.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::20) To AS4PR02MB7903.eurprd02.prod.outlook.com
 (2603:10a6:20b:4b3::5)
X-Microsoft-Original-Message-ID: <20231102210745.1107-1-cang1@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR02MB7903:EE_|DB9PR02MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca2b38d-243c-44e6-2dbc-08dbdbe7e306
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5F2NClSvlV0mWq1IvkDvKd6l5vusur8TK2D7SRRBtsuN3yLRH/bVcf7yYkUMdz3phB/ah5oJTNisTqQ3qKA/eFiVzOFy37D+QHq0D0EUf+HX9/Bazzx9x8wjkzM9eO5ggStqiTDx8WtS9VOVSGGIVRB2G5mzkuivZmtvHaV6hbxpVS27KqdVklm31Pk9XT/pbh4368SjLypFlpctR+5WkLei/uNbo+nQCV4xOcdEm6lVFlTfxANQKn0xCR7XBZLAwVwjoYd0O8wbrxSkDe5rv3VVIs7lsVHsmj65BanPG0RnSzw4D4SKvgxwRgfZdmo1K4tLZSKcOqnLJzGKF+0U5VpwAqJPr+fOcb1dpGgjx1rlTs3SKxJvYGm3JtLhMxtN73Ij1+GCG08UypvcvsxXbJKjDqQDFy2797/KgPXcpC7mtmhzG4QiYFefpDPRlN377JBKBUh5CbtIOuZnDs+CYygmZpHROk8x/Zf1DyjFFj3lFiYVqYYer6coqIpsfMPe+CS8TZpUU7ttjar1F2GmA1mHThCNjV0f/EOpSFQefSn1znfZFV1R8p/zV+8nvS3SoQF09WeEDhoDxmdXx5rr5J/hP2+eygay2YAd2RFp1Ws=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RcrWsiZnTTahr4Ss1u1VWAyFZ9gZLKG95Xs5YlM75LIL5vjpUxZcrra6Xreh?=
 =?us-ascii?Q?MyQmlzGLlnleJyzRGWwGfqeX7tBKxYaevYC8NWy1wPYm+rx7sz3FhOh4eoyL?=
 =?us-ascii?Q?4BzfAZAAGrr9a7uFFnveOJ8IeB4SFsMHcPntGppcHS2sUj4mnXUpdy9fvVGU?=
 =?us-ascii?Q?i7cEFl4tw30DmqqVCNwBn/ueUPqeAfX8YvBMPFpJkqZ4+RRp8Rlz7m29GpIM?=
 =?us-ascii?Q?zLL1ZVjH4+HxsGj+Im3ywX7wc5s1ri2zLHF86AtS5z+tiXywjmhVVWk42Rkx?=
 =?us-ascii?Q?s5CXOgTd0VGO2Zv0JQy+dJkQTpy1NncFqPilJdDu4zTyeJaWknHMNeye/M93?=
 =?us-ascii?Q?ZnX6ofMK64Mrx97YiROyFSRl9HPKTKk6ruNbQtWSBfWE8Jnc4lt5tX3iWn8H?=
 =?us-ascii?Q?/ldz82RjmACmaNlPjEYib8xt7Wk3GfQ4EOYsI6XsVfU4tE/7RKErh5ISDFXx?=
 =?us-ascii?Q?evE54ib6m3VFmUfWQ+gr4A1R0/y+4+Mo9AErHYgbVsCLGNhGaFeCsRhW6dIS?=
 =?us-ascii?Q?CSveL/wod+mghit15wZHUozZWK3S6R2Maz+QVzALkS6bR2O3NyyJyW1XD+fw?=
 =?us-ascii?Q?fy/kv77NLwe0PgxXusLosp5g4H+/GzER29qSDaYLgoAHV+Xl/gDx6A88xyn9?=
 =?us-ascii?Q?goFqCDvBYLZ/qBuJ2UqRJ/M2ZsRRY5zv54D9JiN2U5kwNaPlcnXsusiRLlcX?=
 =?us-ascii?Q?k77Ik3zb0T2mkJOfWRIaRNCaGbKS7ak1oxnmdLxFNNVw74McM9QDLp5Qg5Hq?=
 =?us-ascii?Q?Y2UqbooohclEOTIgNv/uIIe+F2hhcGyN2tD4C32s95mNlP5vupZChBoGgoxU?=
 =?us-ascii?Q?xT3+W9COwl+aM600aZnvAfuNtXM5VO8jL98mLFt/arpW3jh4pSyLSjJMpxuW?=
 =?us-ascii?Q?vcFO1mSEaQAxFbLOP7cw3Zl8V2AiZv8HqgtiwPM1Feya5tuuigcGABdroq/w?=
 =?us-ascii?Q?fxFAs8tIKn/tbrgVxPQSsROE9DOIySK/5ZO/VOfo95DyJeG/NtDDHS2JcqIG?=
 =?us-ascii?Q?M2mqx4uDtFVlMzAu6R4BdJluUvvzSBxERptY04sEYsVWzDomm+NQqlUuvHIb?=
 =?us-ascii?Q?KYc2hl8F70bWBabfeO6eoKfz6/0GWiYS64SGSyKYSux1Fx/TL566WqYnOyx/?=
 =?us-ascii?Q?V/WFb7xUMNmv52BNlEzwNG1Yxa1iuTCqagZsFlgaI3A0az4/rL03LiOb/5Up?=
 =?us-ascii?Q?oxZXT5oM3Dq/hlEXoBVCu5gcywnVlkGCt13iYw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca2b38d-243c-44e6-2dbc-08dbdbe7e306
X-MS-Exchange-CrossTenant-AuthSource: AS4PR02MB7903.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 21:08:39.9023
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

Add BAR/enum entries for Brainboxes serial/parallel cards.

Cc: stable@vger.kernel.org
Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
Looks like this slipped through the grate the first time. Cc LKML and stable this time.

v1 - v2:
This is a re-submission for [1] which splits the changes into two patches.

[1] https://lore.kernel.org/all/DU0PR02MB7899033E7E81EAF3694BC20AC4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/

 drivers/parport/parport_serial.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index 9f5d784cd95d..11989368611a 100644
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
-- 
2.42.0

