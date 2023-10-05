Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D317B99B4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 03:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243789AbjJEBk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 21:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbjJEBky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 21:40:54 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2081.outbound.protection.outlook.com [40.92.53.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BBECE;
        Wed,  4 Oct 2023 18:40:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FW1/Ygb1D4xjD5SzKwfUahZMI0xGBBNjYBsHvf911fkvNjrMT8zTIn/vBX/mDKRTBabaF2yMw4QMv9qcNGIKjrjKCASbcgmczRyL9fcpxE8j+vfifCVwcfUhvRptfSXs6/Q+rZXq8Kh5+7LLySIsDNyPiGEXPVW9p7ZMdz91wpraC23kwP3TtxiNzsZ6HV3LSKfrQRT/oaG/QpE+EmncWEXIV14MbNYCnplfHmmLV3a0D6XP0c//70EgPi2SVP2tmBio5aHuEGstozTTIpMqeuAZjFTFtj3ZpXd/uGi0aP9ZPMNTN8Z6VWa6lbcVjhN/1A1oSSoZUsbf+uVzecScwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JE+YhNgyTVGBvdewGW7XCv66LLCuS9dXG9+veP5O4Y=;
 b=HlnzpWKKHYMo3uB/GX00j3ICvqaUQTxZyZM5ssz84TQtnK/bt4Re6TrvPMOp2IFk/QKBchTkCsMKST74PjnjwQ5qSKPSzcGs+SBIc/H1fKIViZAeeZpg2rlYoFjAGMHqnJJz9NNn/OvZ1L/i4+8Rq3kRUUY9Vhe0hhhnuM710rgi49wF0P2tU7uTkF9zVgq9Q3wEe5kuqXWJM/2+Vk+oDR/8P0GOVg1Sbmub4q6qjSx7g+5J63hDv2DiTuU2+JrAjUB2sOZJCr1jnV2YkS1aTkpxgwptKa3d68UdEpT5qxmIaYDkutPCNCixCqLX/DL3qJ4xbfjwcaZ+AiszDs8KlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JE+YhNgyTVGBvdewGW7XCv66LLCuS9dXG9+veP5O4Y=;
 b=k3q9yTwkrsJMSkBN0q4kHVlhpfnR2kZG/tkO8jUPf6H87iI5OA0/nOp0FWS8u4MbjL1kbIKYNFR+9mdKKe3OQlge3LyAmQrMVm1WGN0WLOb6/TJfDyu7XA0CTPFaZONJvQkbNMiQKXduy0/rGGu2HCQg/qJ23g2hXIVRfmK/+3oQWxARXLuMldr0IIWNf6BrrBHukJO/iuNcVyDsnKGVwuwif9sq393h9wLOM+B+Mt+mcGrFAyAK/rP2v9IBzHQjxuNtL6O2WJ4zyFnwtnFmvmCaOW9NrQc15YAQ08ek0lOZeuTxVe2YJtDJj/u+FaxoNLt9jNO1eFEBHedPuR2CwA==
Received: from KL1PR01MB3809.apcprd01.prod.exchangelabs.com
 (2603:1096:820:41::14) by SEYPR01MB4854.apcprd01.prod.exchangelabs.com
 (2603:1096:101:c1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Thu, 5 Oct
 2023 01:40:43 +0000
Received: from KL1PR01MB3809.apcprd01.prod.exchangelabs.com
 ([fe80::2f73:985:641f:399a]) by KL1PR01MB3809.apcprd01.prod.exchangelabs.com
 ([fe80::2f73:985:641f:399a%7]) with mapi id 15.20.6838.030; Thu, 5 Oct 2023
 01:40:43 +0000
From:   Ken Lin <ken_lin5@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     groeck@chromium.org, Benson Leung <bleung@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Reka Norman <rekanorman@chromium.org>,
        Stefan Adolfsson <sadolfsson@chromium.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, chrome-platform@lists.linux.dev,
        linux-media@vger.kernel.org,
        "rasheed.hsueh" <rasheed.hsueh@lcfc.corp-partner.google.com>
Subject: [1/2] media: platform: cros-ec: Rename conns array for the match table
Date:   Thu,  5 Oct 2023 09:38:40 +0800
Message-ID: <KL1PR01MB38096300BE18095E51FB7A5BAECAA@KL1PR01MB3809.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [GJu9pDCbTuWJcNbWrVW/QVLVLNCzwt4M]
X-ClientProxiedBy: SG2P153CA0026.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::13)
 To KL1PR01MB3809.apcprd01.prod.exchangelabs.com (2603:1096:820:41::14)
X-Microsoft-Original-Message-ID: <20231005093804.1.I63e353b5d722f212d2979e0b9af36f08680898a7@changeid>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR01MB3809:EE_|SEYPR01MB4854:EE_
X-MS-Office365-Filtering-Correlation-Id: d9fe534d-7474-4a6e-b1b6-08dbc54415cf
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RP9c7HaleIr45VgY/VqeTCDaQwRXHfZOwB5pqaq+9Gbv2SheD/Vn9+cSL9hRLFRk26MlxXv6cKzaAWl8XBQZzAeC9ZPj8qeKF6qY+mrfWkCVHVvHpRo4ARSpe2DJkxUePJgipOByOmacLKxBbUplUzyEvoWNB9Yz36I9sU/wmqPJUpaz0MDhf3VlJHJFrXTPU5dUJTuAUEMgyK5BhI1G5F2X1tc7aXYThXuVxRk1t0bTy4xGZrvBuXeZFd+5cXA+kDfVS7sq+XUKent012vMzBISP6lOVgvILxujZo7htGiKRIOWPMppdNF3OJu7GQAvyZMzI8cWZ9egIQ7zqZzXnF6FEsMnfM+3XIM40EVHQ8cFsTeHCNsWUWJamsM4dB23kuIT6rz394AkuUi6QznqFL//896Nos3g4kNnreovyx16EV1HBhLfFgyOyjqZw6RWeCRpaoS07gKoflbx979DDPOyZNdcMOdIs9vFCukso8gfH2MoaIz3P+Yki3aos5jVnLpuavBJNB5EDt2iyJJkJr6DVQzFYP+PXjj89O4g+1N+W5tTcUDXwOBBveb9WSkD
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xKooNBdTt9Bc6Pu1rFQ7EXYsQ1dd2/eo8SyEsjtkYP7gZoFr+NC1sbznn74U?=
 =?us-ascii?Q?DKnmPVyMjfbZJBv1RkmxbMV34IbJ+dtapFw9F9OgWCiNF9zxp2F3b+hpUdYB?=
 =?us-ascii?Q?uWykKwpW3zi3yO69NDpobJ7UGjdQobuRi5PZ48MrCA4W+8083texRPOnXZyx?=
 =?us-ascii?Q?0aGaa4qdngVTCf5lh5469RSXn+XtWmJgKS0rD05zsNoUsGe92fIFiiLdRf1g?=
 =?us-ascii?Q?KYTvTOfTa8d8T58FolrrG7+Ntdm8Ap0Tvzwbj0ub3lFmHHQfXuRPactyKDN+?=
 =?us-ascii?Q?Q+iMSIlBRex6zTmAabTMxXnH6rnGKQ8krnW8b6gAxSYASHqvMc83sWD4ch/O?=
 =?us-ascii?Q?FPtb84TljzJWq7CFabEWR7R03Wzr/a6P1w9CaH+X29iHt4FpxvO8Fv7mhXFG?=
 =?us-ascii?Q?tocCnTjVLGr4Dv1ycRzQWD85C1AI2kgTst9uGOmJcEDk2rTq+1bOuZ6gsfcE?=
 =?us-ascii?Q?TiMdTcH3UxB3R2FafgvZNdmk40IMySKUHs4KPThYPKjQUysvbeAgWekXDGut?=
 =?us-ascii?Q?K35zOazltktzKXYxbP0JrT7Xl6z7ymUQ49M/xw+H76V/ROzBx8NwoUzJ4d8/?=
 =?us-ascii?Q?oHgUvCVSjhIikTcrvvw5OT6SJ0rcBzuD5Mftufg5AerfYl59rNwz5C20jDnX?=
 =?us-ascii?Q?RfUAA3Av/sCpDESTndHl/74TR23x4TuguEuJYo3cTsgFyJIOkkNa/+srRjb2?=
 =?us-ascii?Q?yIbrKjkt7D3cV5Y6Y/E3aQtSZR/G8m0/QMC9XGRGWnlAAr7VctM8xKgl7Y1B?=
 =?us-ascii?Q?wj2ulbaB/V/cTSA7SIkFHaikrW3AeK4VjNintWZgHX7hJEnSK7hMwbah0wX9?=
 =?us-ascii?Q?/6UgQMypRhvmcCHwfIsuiEH8nYhxz+GAeFXZJfnZ6UOufbzhaGI6X0gVkKex?=
 =?us-ascii?Q?b1/JcQ3LVq3/zQPwocbFttgGSm45/Y500oupmH1nemCErKPwAF0H9tqiwx+M?=
 =?us-ascii?Q?YcA0bb51SpnINj1FMbjHWs4+GOfB6cDfgQ74cBpTjstCGHjr7P7ufhmQzXCu?=
 =?us-ascii?Q?ho89wsfOQmUhaZtIuyJZy+DjT5uwBmW+SEABiA8MS3qK5HWPK1oH/FAb+4ZR?=
 =?us-ascii?Q?oA3LGkoWSLXdo93n1wIj4xHW3tRXcCFvFtBjLg3MQAfPWxj8LXyHYL0EC+FB?=
 =?us-ascii?Q?+QTwkI7LaQAv/rJaR9eqEDcbG03nDE12kSM+6C0tWQMDtZrwv3/UJR/DQ+ll?=
 =?us-ascii?Q?yfhxhvhuHPGECzCsTkrgMs30DPnq5UyS2QZNBg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-d8e84.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fe534d-7474-4a6e-b1b6-08dbc54415cf
X-MS-Exchange-CrossTenant-AuthSource: KL1PR01MB3809.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 01:40:43.6669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB4854
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename conns array to port_**_conns, ** is the ports which support cec.
ex: dibbi_conns support Port D and B will be renamed to port_db_conns.
Make it much cleaner and readable.

Signed-off-by: Ken Lin <ken_lin5@hotmail.com>
---

 .../media/cec/platform/cros-ec/cros-ec-cec.c  | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index 920aed0d1929..dbee25b138ff 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -294,34 +294,34 @@ struct cec_dmi_match {
 	const char *const *conns;
 };
 
-static const char *const fizz_conns[] = { "Port B", NULL };
-static const char *const dibbi_conns[] = { "Port D", "Port B", NULL };
-static const char *const constitution_conns[] = { "Port B", "Port A", NULL };
-static const char *const boxy_conns[] = { "Port D", NULL };
+static const char *const port_b_conns[] = { "Port B", NULL };
+static const char *const port_db_conns[] = { "Port D", "Port B", NULL };
+static const char *const port_ba_conns[] = { "Port B", "Port A", NULL };
+static const char *const port_d_conns[] = { "Port D", NULL };
 
 static const struct cec_dmi_match cec_dmi_match_table[] = {
 	/* Google Fizz */
-	{ "Google", "Fizz", "0000:00:02.0", fizz_conns },
+	{ "Google", "Fizz", "0000:00:02.0", port_b_conns },
 	/* Google Brask */
-	{ "Google", "Brask", "0000:00:02.0", fizz_conns },
+	{ "Google", "Brask", "0000:00:02.0", port_b_conns },
 	/* Google Moli */
-	{ "Google", "Moli", "0000:00:02.0", fizz_conns },
+	{ "Google", "Moli", "0000:00:02.0", port_b_conns },
 	/* Google Kinox */
-	{ "Google", "Kinox", "0000:00:02.0", fizz_conns },
+	{ "Google", "Kinox", "0000:00:02.0", port_b_conns },
 	/* Google Kuldax */
-	{ "Google", "Kuldax", "0000:00:02.0", fizz_conns },
+	{ "Google", "Kuldax", "0000:00:02.0", port_b_conns },
 	/* Google Aurash */
-	{ "Google", "Aurash", "0000:00:02.0", fizz_conns },
+	{ "Google", "Aurash", "0000:00:02.0", port_b_conns },
 	/* Google Gladios */
-	{ "Google", "Gladios", "0000:00:02.0", fizz_conns },
+	{ "Google", "Gladios", "0000:00:02.0", port_b_conns },
 	/* Google Lisbon */
-	{ "Google", "Lisbon", "0000:00:02.0", fizz_conns },
+	{ "Google", "Lisbon", "0000:00:02.0", port_b_conns },
 	/* Google Dibbi */
-	{ "Google", "Dibbi", "0000:00:02.0", dibbi_conns },
+	{ "Google", "Dibbi", "0000:00:02.0", port_db_conns },
 	/* Google Constitution */
-	{ "Google", "Constitution", "0000:00:02.0", constitution_conns },
+	{ "Google", "Constitution", "0000:00:02.0", port_ba_conns },
 	/* Google Boxy */
-	{ "Google", "Boxy", "0000:00:02.0", boxy_conns },
+	{ "Google", "Boxy", "0000:00:02.0", port_d_conns },
 };
 
 static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
-- 
2.25.1

