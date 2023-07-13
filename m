Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B91C751840
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 07:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjGMFiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 01:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjGMFio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 01:38:44 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2121.outbound.protection.outlook.com [40.107.255.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F84C119;
        Wed, 12 Jul 2023 22:38:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwU2I9OUlyYbWEX/06Dl6NfOCMSGcbLlWWu4TZodzoLDiVX2EtWSO1iyNGJPhrTuikqj0I9HwUwluRGuhtDxF1RglUGKNw9LBQTd0K2i/NaS61Upkj6T+YYSD9bU62PRd7PLHUws7BNrDYgUrRqfayDP2OFyjNg4o3HR9INrwcit7S3eyhtbcoLp1rdG8RONz+VSomEy/OcOmZJHHd+imE/gE3/Kc0P6+MSbMoMbcoxBFFFL+7xnOTYlfpXv5CeG5ufX0G53RWmEDUt/SKALimKnEwAntyK65qU0tBs39WpK93Svoa9GG/RRCsDjWHUaYfK1+GimXKWJrPbYDW9img==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkV1qdaSxHMqdyXxLsbHvZ6jgKQvsJxdRFXETnnm0Fw=;
 b=jZbKJ2/RNH74Fw06ClrSm+N+N9jyetkoUDCyVsuk4sbsIuGRILxqYQW37CIfv8eQOeRWb6g1fUsM+8RcysmTb/29fDNkL+0OYlYM4446xnSpL6GFAmb2SKJGRSdhi4ymsUOYDYpXNiV/GfQfjRpFH912gT4HTWd1uzoIiJWh9CD4wUhmnv83rFsb2o9u/6Srh/mVcnaB/02Ic1EjeHJWm38Q967V2bwnH1Q8nvBTkIwo2mJUYfWwXkebbYG9lDSH4/ubbLeTXH86x3nmQ+jNgyYynmEuvqYky6kPr6WFofLQIyXlpLiX774j7mcYCmsI9H87p4wtNhI9CcBfJT0dGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkV1qdaSxHMqdyXxLsbHvZ6jgKQvsJxdRFXETnnm0Fw=;
 b=BP6vG59/uMjOacxugyfHsUnD2uWiNlDagZfX4YVd6KLAM/QQ68kgre1u78Wdqr7Bo1w3s1WMj+aXF8+jcx/LlGk2H39yhsgl75XiI9QwEeKLE0A5gAHQJqi0cSjST/iU5WKRn9qrC+bALYE0Fyaxi2MOQIFW+1hB0E3rO8GffKso9bvY0yY9RhcG+HChOk6vx7avUkTFvl0mFlV3LC5Ypv5V0n3rsd139U8juJaFOQPqGXduAIz4rnNft2bv68OGZRvtTTGsdHp5vO3iHlpM/SsEMnNhHs78eIub5eKH8CazxUr9Av/n3R6oRf/IbSLES+lX0knW0J4sgDo015AdAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 PUZPR06MB5827.apcprd06.prod.outlook.com (2603:1096:301:e9::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.22; Thu, 13 Jul 2023 05:38:38 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 05:38:37 +0000
From:   Wang Ming <machel@vivo.com>
To:     Rasesh Mody <rmody@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krishna Gudipati <kgudipat@brocade.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH net v1] bna:Fix error checking for debugfs_create_dir()
Date:   Thu, 13 Jul 2023 13:38:08 +0800
Message-Id: <20230713053823.14898-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0029.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::16) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|PUZPR06MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a4d0f7-bda4-42d5-023b-08db836367b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Swn+tNxgBI2iGhhLyTDyC1NRtumSCgaqZhHsTwC+DQzFgbvWydDGdXJM0BJ+2wYfwA2O8MEsZVZqigrZurBsjZ/P350tzxce53M2izZV423T6BSaMfySwCa2MaluBSUajJcrLiQclvZiRnReqz9oi/JsAzIXaTUb+4AUUDHSymrapOW0Qfooh+0NrZ+khBcICvN1E7OcJnC+pJOO8QbEGiKqlIkQVH1R4bcxCse7gvaKIw1cogAr4Fa2jeE53kI/V3vLXX5aTPA27FI8QCpqJ4DpN6/dnqKdzBzgWInBg9AkdfgGXru6VaNhAchms30ZL0iObfEVuWJSqCRlCicw35+KnzipgrxEIy6n4mJj1Qk+wwnFElEWC7jLhMkk2VwcdGivCISWFYSrIXKzJM1NgXGIqcX1F/YM5M0/iMLvIiRMz6cNm6RMsb87sys6ghbEGrUB/j1iLa0GzoDYWdjyjW59qPhp5mMLCDu1xKBqLHkqwoEZR0nWgXMtoYH/7Q0dJ9k8IVm5iZoYrRanc8JAwurAiSnE9vqTn3jBRbSzY9MpkSJRiEXdvMWzw1rpwvA6z/RRoM+ldm2Jfj61DOGSBcCPsyH31/QF7MPkREcoLOcO2UxP4Pqv2tNJbqmGOgFw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199021)(41300700001)(316002)(5660300002)(6512007)(36756003)(26005)(107886003)(7416002)(1076003)(6506007)(8936002)(8676002)(38100700002)(38350700002)(83380400001)(86362001)(2616005)(2906002)(4744005)(186003)(921005)(110136005)(6666004)(478600001)(6486002)(4326008)(66476007)(66946007)(52116002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zv+qLkPiHOI32U2XpaCDn6yiVSxuOGYT0O9ECYrHzIPEnXphOm9LE1R9/f4R?=
 =?us-ascii?Q?b4mLvOjaV+OWd4USOyl4sr2sKZwJ4PHejy+XIVpEd+j9CLV1OS2W0mjolZ4K?=
 =?us-ascii?Q?Do4Djkxqjkxbrd/BUT1LW/b4zZI6MRJsCVslbFt06F04zTNpn1POPqaPJCr1?=
 =?us-ascii?Q?tpchBb4hA8GLGLnI4nMigU1dLBL4Vtra3Mbm+/lm5WTEkk/9+Wuk3VFyByVd?=
 =?us-ascii?Q?2aSaI+duESx+T58UQOqsE1XEfca5dJ0/Ego3sFyZSOW7IBQXEiImMyjYO/RV?=
 =?us-ascii?Q?nPZ84TZ6eepAzHtowm0al/5QBuNVLj+qMdgBRrSjRrb1JfUmGosPErVI0g76?=
 =?us-ascii?Q?JTz8a3hFY86AwcYVpc8U+vsGeWn8EOaZx/jgbSwk6waFRGEBpM7mqbVPjUa4?=
 =?us-ascii?Q?tloxSR7t6acgITDqHJNwiehvfVsHiXjs+og+zbIZtwKEPuiM3i31iGLAKAM/?=
 =?us-ascii?Q?ABqMydsVIybgP8x1+WBp/VFMnBO68qsZ6ve62MDWHlY14OU1C0a/aE0mPoe6?=
 =?us-ascii?Q?LJIBVW8vFWnKV3+NYXOeau8VFIg8JQBG7p41AK7qhoWfMp1YChrz6QuVLPkY?=
 =?us-ascii?Q?aRzmkey4SAOOEDyGCnrwcAXMTCAo4cumDlqBNJD25jkC6AN0hZCiZ4GdjfvE?=
 =?us-ascii?Q?KK9O/ODCDVGVMzG6XDj3CsJlHSLmFr5SAFLy73EPpi5uQPzolwyrWKvaeEO7?=
 =?us-ascii?Q?lGexHTa63cko933B7PSHzP5CqGp7g+rWfx6JhToiib+yaT06fZxZxq2EnCwZ?=
 =?us-ascii?Q?IYOpL4cgkOUcofZZN92YLbsZhpl+J0BPE4KXHw3YvQTziufLKnzUoKtD/zC0?=
 =?us-ascii?Q?m49PVNpgynhDCvtObus6ikf7ac+BR82XypVDC0pO46FFzKiZgmCglaZPGtSI?=
 =?us-ascii?Q?W6/n7+HTGOKzXADBWWcg1jvHMYFb+dg+RrTu/vElgSv308mJ7chOKFF7uo19?=
 =?us-ascii?Q?oXlD2npm93iiPviFNT+/ndaUi0QW0LCui+ApWy1OFR03UApqLPgmD/hbJhUg?=
 =?us-ascii?Q?DoW5nfYSqIGI0KUL5p7vKXRNgF5NB51W37/5wMlPAMdUperXMykN0r5oMfIU?=
 =?us-ascii?Q?x4TxneXWAAHnkBMIfHaMpscvsZ91djqGkpiPv5pIOblLQdmpH6jjSHUheUWi?=
 =?us-ascii?Q?c0olL/12jPHnPrj/uqi02Vq5YAjrZyaFdmSjpz3ZzzAm0cc/Y7mVGBxwDBZO?=
 =?us-ascii?Q?2JVv8aS33IZleZjdkG21icGjabAf/DDBYZwPxhVB9L9P7S1AKFOHXotLabSm?=
 =?us-ascii?Q?6GDw4gAEz0FKTZKj3f+n4QENPMng+BGpMFS34WyKw6NIvPxF6S696YvUh5uT?=
 =?us-ascii?Q?JZk/jMyDPV+qwrKD6arEsWLj0eCVk0viRQnHzH1if6tiilZ0wmsVw3XVesWe?=
 =?us-ascii?Q?zccJdwX6iJJrzNjXW6rpUsvSYU7SNWW4wp3B9ZXEB52aZkmcWtVx6OFbCCcX?=
 =?us-ascii?Q?qx/rQZ2bwrYupJ5V+gS17bb+TOS7mcnxdgO06p0mBzRTPjUm7dfzWSM5xNj4?=
 =?us-ascii?Q?qDe0HcgUGhRGUDdSZ0txX8jYW8hRHGvhVRPbjvsjS9YiaH3xXzbFIp+fqXdE?=
 =?us-ascii?Q?OYHtoOjrhvZtof68B4rDlrZwxkLxumFilBa7+TzH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a4d0f7-bda4-42d5-023b-08db836367b3
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 05:38:37.5823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fm9KqmDdcAWGwx+wKAkDW9If2rLMeksJAiPYI4r2WbsMDhNlpmsBkeE/+hDZfpST8xmfnkP3fiFm5Ciw7U26bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5827
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debugfs_create_dir() function returns error pointers,
it never returns NULL. Most incorrect error checks were fixed,
but the one in bnad_debugfs_init() was forgotten.

Fix the remaining error check.

Signed-off-by: Wang Ming <machel@vivo.com>

Fixes: 7afc5dbde091 ("bna: Add debugfs interface.")
---
 drivers/net/ethernet/brocade/bna/bnad_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
index 04ad0f2b9677..678a3668a041 100644
--- a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
+++ b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
@@ -512,7 +512,7 @@ bnad_debugfs_init(struct bnad *bnad)
 	if (!bnad->port_debugfs_root) {
 		bnad->port_debugfs_root =
 			debugfs_create_dir(name, bna_debugfs_root);
-		if (!bnad->port_debugfs_root) {
+		if (IS_ERR(bnad->port_debugfs_root)) {
 			netdev_warn(bnad->netdev,
 				    "debugfs root dir creation failed\n");
 			return;
-- 
2.25.1

