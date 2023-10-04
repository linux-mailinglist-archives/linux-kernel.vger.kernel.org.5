Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F76A7B8A8D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244446AbjJDSgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244444AbjJDSgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:36:18 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2091.outbound.protection.outlook.com [40.92.75.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0AE98
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 11:36:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVEPslkQ7UEPGaOGPuy+qtl4zCL+OVaFwBcImR22nUKDYsrcIktSsZW6itoCBeNIxSCV2VZ54LJkOmIk6cr2iWxW+rBnVtTbtSrL4EKgh2rp1rOlNztNW4lIY82QoOeJodgHq8DHuwMFXu28wCs/ulY5XJxEqT4fnF+3lklaarByqWoQqUfx2FY83exPzVcbg/ETiTbPDO9mWlOHxUJPrJorgrd5G1FHFS8rrgdDodXSQUli9iynQPcKkoqPf1x1ZjOLiDaHszFeXSPZ64ks4RnDFp25b/x8L8zRnguo/dCrxbYkOBUPu9dPyXkk2xsZ9nnUPfWNOqCCaRk1NMvVSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7J6szbLbROjTLbQP/hP41WOqbGIVY8FQI//Gs8PnN4g=;
 b=ZSA78GBoIY4Df9oRcpJP2shjNXNB+8RixLbovKAAuhfrPzjbNA90M+HTyEpH3b4kx0/s7n/fZt5DoOlgkDDBEKwabwNOfO8wNjkMa44vaQ3SRj7/EB3XVqM7uCpTKrBCZNq6WHgS9aHz5gAwxOerk+qzXVse8uYKBo/dGUGw0U5GKpaNoF6Lwm+BZhmFRPoD6LeoXqhqPPnjQNprl7E6a9OcWPZMmTjPPrc3Zn3Qx95xEFSHSEoYm381vgAPu5zZn05UKc69daAzNZj1vlqBWZ1uxBWDaxna4yprN+O3HnIEtotNppKgA7kJzgiqh48x+VI/VO8on9NQPDq9prJNDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by DU2PR02MB10447.eurprd02.prod.outlook.com (2603:10a6:10:49d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 18:36:12 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 18:36:12 +0000
Date:   Wed, 4 Oct 2023 19:36:09 +0100
From:   Cameron Williams <cang1@live.co.uk>
To:     sudipm.mukherjee@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] parport: Add support for Brainboxes IX/UC/PX parallel
 cards
Message-ID: <DU0PR02MB7899E7932292E7366920C303C4CBA@DU0PR02MB7899.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [dirSlwgG3okYuAn55WoNHCPikX2XJKSL]
X-ClientProxiedBy: LO4P265CA0008.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::16) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <ZR2wmYs7G0mlIJ8O@CHIHIRO>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|DU2PR02MB10447:EE_
X-MS-Office365-Filtering-Correlation-Id: 2daaf15c-57f6-4fad-9d39-08dbc508c86c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r/AtqQqd9MFUlq3BAsR/5IcbjMwWU2STZk+fEcfITqSEuWoFfsDAFtqVnqwOQnnlh3q5uXT+ygEmGAC8xfYiTQcuvg8meYOSZnvwstjuTDqmvsSE9V0gbLlcRxSyk+9ofPmFj0S81/zuzok3hwPd2PPbn9E/m6xvr6LtnhLZmXK5o6cTtrnoiDz7/wCMeGzD4PXwcIyo591yDupBfwfCnjabstcWp5uwh0QXtMgu8ks8N2snyBpxlEQe9I5eHB1zKiZVOswMgkAe+IiHhgO3xgW9pJEDlDYXxejg/hanIza2qJhehpdK7NVoRx6CaIcGtl3eYItHFerwtYcatoGAstbcnsUMI90aCwnboWQxDJzFJM3pnQ82vTnNF1XwBfcbNYvm6D504/V5gPrA/mHVJjX4DkG8G/ASlPFX2WsxL0mKX49nBFVQnqqfQqhrrKTkCA7IUmhH9O/qlcWnwXhjccI5rOHujDh+xQnHxXjsQP/Ud4F+5auuyob6F3oII2o/g/oOxUqlihQiSqZ15uePpmQUIhPTn/02eduSe0QEhQU=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e3NPi8jBHJ/wReeec1u+zvBNu6fhbEc7m5PMmWaG0eI2LzZSCmBL58wrEMDj?=
 =?us-ascii?Q?pM5vipu93A9g0udGp0w7FbTsWLXiiAjO2gX0EAfj79fUkCUBzUXUyn6wj042?=
 =?us-ascii?Q?Ek7MqOW9QxOpPkG5XCXD4/04BqNG3Wn5zD+H/bARPC5OzoWXAVbf4Tdap9Da?=
 =?us-ascii?Q?Rd7TXhD5h5FO6MQIHYZRemgeZhY02wXdaomfpd6eZ497YVmlFF4Y0YNrLNsI?=
 =?us-ascii?Q?6fT86qcL3vvx/2NpQ/2ObgTv3sAysp4bJyGQaPjGm5ekZoOAUbiYYuo6VvO0?=
 =?us-ascii?Q?+7y2WMqWVGroEdvGN9F50L9Wb7TtPx6ouRRI8cxpbfR92VF75TkLkV4Kssqr?=
 =?us-ascii?Q?0TxjY1dyUZIq29Fxl3+aFshlhfkpMZskysCtacGKHTC371cu+3GSi61RT6sh?=
 =?us-ascii?Q?lp4bUqoAIOhqzMk/GqDyiG9+5kAAoJYNLU+YXRxXyAGUexfrHcQRHdjgSqLw?=
 =?us-ascii?Q?gyxWh1DpffFfduqUmi9DRQ06RvA+ozdz/rny2d8X5/+//saNmNr5M7LTPCG+?=
 =?us-ascii?Q?ibfOFJrlYmbAt/mGwP57f2/SL/znnFPiois+i0Twd2HfnTY093ES8plm2P35?=
 =?us-ascii?Q?jRW5zNs/ASh79BC+8k6zPF6SWti6T25uu/KYNNSHuLF4fuyYtVJRLm+XQ52n?=
 =?us-ascii?Q?FbW8lFmmOSSYwY22hmahr6BNmvM9brx2hSwcRGykJbNVBNHrn/kRu97qIWDW?=
 =?us-ascii?Q?y764CN+gj4pv0Y2hEjBTPg186NMjHeXu6HlbU3CLCGBC+Zw1j4t4JAlfww9D?=
 =?us-ascii?Q?eFmEknjxZ8RrAG/b1wxwaPUUNCK+50bsdQUS1d2w46A8tUh2IxTWsOho1GqL?=
 =?us-ascii?Q?m/cL3n3fzsB/pk1PYpPsqRN4PmtaMdtpGmFdiejfsXF58lTBMyFjdxrXmEkN?=
 =?us-ascii?Q?L/W1q6+k2Fjgh4vgCIP05fIkTvsw/GTlO/XYvoP3SivryEIvtLmvtuGF1BoT?=
 =?us-ascii?Q?m/FF2I76wuxYUAKZiGlV0b/pHq6ZGKyl75l702sEUYexC5bbuq+6FoUFNmcu?=
 =?us-ascii?Q?h+r5KGw7pQ1AHOPRcJVAQhPD6Bcfo6p5P1OvR30e94N1bcYRflFBtdiVhbmE?=
 =?us-ascii?Q?hWHEqWwoWOBFxqau2UX+VdJsy9ZY8iDKyxvYMDppmcaHO6vBNqwiI3dOdwTD?=
 =?us-ascii?Q?tpV45LyrGhUiI2kMoJ8kkDC3wYbIX6fXvCBw3koXqgwpv6XaKPFe5hLYuALl?=
 =?us-ascii?Q?PJ8evl/bbNRie8grFu5ngZohjSgLe684LnCO6Q=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2daaf15c-57f6-4fad-9d39-08dbc508c86c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 18:36:12.2019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR02MB10447
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for Intashield IX-500/IX-550, UC-146/UC-157, PX-146/PX-157,
PX-203 and PX-475 (LPT port)

Signed-off-by: Cameron Williams <cang1@live.co.uk>
---

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
+	/* brainboxes_uc146 */		{ 1, { { 3, -1 }, } },
+	/* brainboxes_px203 */		{ 1, { { 0, -1 }, } },
 };
 
 static const struct pci_device_id parport_pc_pci_tbl[] = {
@@ -2833,6 +2837,23 @@ static const struct pci_device_id parport_pc_pci_tbl[] = {
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, quatech_sppxp100 },
 	/* WCH CH382L PCI-E single parallel port card */
 	{ 0x1c00, 0x3050, 0x1c00, 0x3050, 0, 0, wch_ch382l },
+	/* Brainboxes IX-500/IX-550 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x402a,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_pcie_pport },
+	/* Brainboxes UC-146/UC-157 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0be1,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc146 },
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0be2,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc146 },
+	/* Brainboxes PX-146/PX-157 */
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

