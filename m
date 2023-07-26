Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBA7763641
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjGZM0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjGZMZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:25:58 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2131.outbound.protection.outlook.com [40.107.255.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C2CE69
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:25:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5Il0WxgEcdELlEwNmpbfzXOKTMbu/zJJc1AX6wNhlkgi5QyOTIQponnC22ZkNgqrPFQnPcBdZZkBDKQqpx1l3hVRzf2nzsxjJMb8Gets3gOQ/ORZC6C1pWO92WIGXcIHDBeSGGteooawjIYiR2CYM3TA679oY8NXW/lDmFud/Qaz0hvS+O/qZsvG6g9zSYwizpzQll1I/tx6gbqWNtqKpiY24+uc4LLM9jaxGHL2drpj4WFmhNPiwcMKbxQK9BqkCCEyCcNxxlTSsjdKpPlxqDycZCZaNIp68TA8YtFifg2BkLP1bgVlvYqwa6whjykLMUDS2BukK6RID31LJeX+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uqz2bE7yp51gtj1c1rObEdF/SihET8pPG3OU0DbKpg=;
 b=TB028ADE3mQ271LvcE9u2eOMFNPu7M7YFM4NbMAMVSG3jsGgw62XdZe8G4bvxOIQGpY51calLvDX0pGnw2uU8FaTHSNkAL7LYNVLc7JUB87pI72YHVECbHeR9rPm6h2tErCrROqNmT8L27akZon4LIpBOIdwRTQYk/s0spN5xzytr+j10adCHij1oN8twilbwYSX4PzaKKfsvqAsYlY2DzTawULDLFacAHBQNvFT5Wb75M51UBr/SahebBP+Ow7g5J/v+JCbgwCnUMMFRVX3P3cW+hyGMWqjHR60Ek5ZeJWJCWJXm3Dh41F92p30QknG809BsyXBfEggX6At4QOoSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uqz2bE7yp51gtj1c1rObEdF/SihET8pPG3OU0DbKpg=;
 b=IUcquCdNe1M5bJB1DPZYBx09sY+m7+qkHv1iku/bT/PxUVYRVqIg4ohirxtp0ZfnHZqjKlH0wF2Ie/P8yOpzXYEmo1UecuuQvvue5fgqeneyKZIBHheFtn0Kv0yqpBcZCOGcp5/GH4l+YwKbsEryntndIifuhUC9GkDkbIAe1EFwEAvGqvW+9wc4DbXJoJi3P5du7C2hHgXkJiba/pOjlEoJUAqhB4KQxDfm256cv0w62PFHicKJXQsj6Vj69570LMyBnPFMxoFbxmiMu3uCe/CI05bx50JEUO61Tk5Atvfp3MnEJCM7gH/b7r0YC/6kCZvtHjOtHHidLLfDJjOaXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 SI2PR06MB5020.apcprd06.prod.outlook.com (2603:1096:4:1a4::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.33; Wed, 26 Jul 2023 12:25:54 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::535e:25af:a3bc:d600]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::535e:25af:a3bc:d600%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 12:25:54 +0000
From:   Wang Ming <machel@vivo.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v2] bus:Fix error checking for debugfs_create_dir()
Date:   Wed, 26 Jul 2023 20:25:32 +0800
Message-Id: <20230726122545.6930-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0149.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::17) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|SI2PR06MB5020:EE_
X-MS-Office365-Filtering-Correlation-Id: 24d644e9-e1af-499f-5d36-08db8dd3748c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aDOzhlW0KVf+8RWyI+QJym9qkJDeHJFs7IhqugPchtZ1tF7DwssTiNixnhsj1+IuBQIyZeo5bDC4m47ZAcAO1TK4aYN1dTChLs0d38gpAFF7COpWi7OeFmOvLWv7deFVmRhvLky6GbelG0uUAR0E4VOAlafnyVUoLRlAh7IAXnkmvrqumKKHEQo2fq1kzoRnfo3LrNBqFwv88osWPGmCfJyQqkJiVRKyZZw2b40trot/Drd61m3kSxueB31TrWJKeSSod0djD+wuWpPNpKdAOOljFXmWOUG7QHKB1iFHjeBtYMT+642pX1aoPhJeBzoIr6MMbSzxALpOsNLD2RKIOYEf+IhPW9wqhAXdW3LoaPlKP3QNTcxpzG0R9LfdI02t5xGHVFqHKFpmWByiDopCmGix2b0UffzuIY1oSQ3TKwLircwNPRKNk8EJgWw9eHvtpJmklsKj3h+8nnk8jzHXN2lUtCq9mYWT9tyav75jMH33XwhEeH9hXZEXKLm7mL9y7t3KyunDAFRsgKeFfXYEmonWHjkf9nWUckDjedqSxeT6KlshnDH3FbQfeF5wVrBoI1UKGkQj9/8cWkmHHpjdMA+DHEovkiESAzEsYxEt90erHqwX34zv6EdTjGzftAuV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(451199021)(1076003)(186003)(26005)(6506007)(52116002)(86362001)(107886003)(478600001)(6486002)(6512007)(6666004)(36756003)(2906002)(2616005)(83380400001)(66476007)(8676002)(66946007)(8936002)(66556008)(5660300002)(4744005)(41300700001)(4326008)(316002)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n7uwryanuUwUNZ5ZOqimrystFLLIrQY0gEKlbzbBxP35Gu5JC8tO+AaOl8CD?=
 =?us-ascii?Q?dig5oHEQks6mznnCKMXtMfEgX9Xx73ExvEgGKSZ3M4avA7YtS3IlUuP2wEuq?=
 =?us-ascii?Q?sLWP1ZYJ2twUHYJH13t9ehjnD+SY0c9V3xJs9q+EMzus3DfTB3JWT3hMohDG?=
 =?us-ascii?Q?ErZi3ihPnSH7MC3UTL6AZiIclZkHe0LBISHMI41PqI1ioyljJpyihuo+iBkM?=
 =?us-ascii?Q?y153yRGhcrYBTJAFONKVnQQBWH2am8tdezV0DzftosIwS+XS7nPXCEtDWiV8?=
 =?us-ascii?Q?Hu5AWUUezlQFhXNOFAUGRLSphnFD4halyo9yr0IpyDEZfa+M31v45BV0xd2s?=
 =?us-ascii?Q?zwAtiY/XunIJKehAwi0i4rqan/tR7pdwLhE3da+NCwoh9TX2BYnwLRJdD66d?=
 =?us-ascii?Q?XPN6BafAQcefOzBYq7AsR+UBKv89XypyaSapsA0J7TTlFTxqRZ58Ppwvospu?=
 =?us-ascii?Q?0y3GdAdckSHoWCLVr59s704khnqxe6idhH0Jwt9WdKRNLytz0Nj92KS8G97d?=
 =?us-ascii?Q?NgvwlU+zLp0qmovOaj7ooQW1xfr2CH2KpxLmQMWEaP1MlJ3hTML/vb0l/6nw?=
 =?us-ascii?Q?Pe05Y9fC6fSqsh38Lo6PBML4PlL67F8fUwmW1N9YihanlAhTFmkEj/uDIUst?=
 =?us-ascii?Q?TslQn4uay1lY16IK4TM2ZvGQ2sfm4bUmynscO8ccxFTGf1pauHOONtzWoBSe?=
 =?us-ascii?Q?iAZ+Tt604hw940qEvWRLn0jhBfJKMgaCPnDjGulRZXX09AYfMiftmDihrWWX?=
 =?us-ascii?Q?MXh+fxWomiY/2IPlkAwJHzCRWWwE0Eap8d/Jy6z84WDIqqkd4Y+M0b2wLc0o?=
 =?us-ascii?Q?E/W0sy0oBUFwOljggUYop5M9rYfxG/ZczBfBFH9wdYEV6HhqF9lHtTQAMoxe?=
 =?us-ascii?Q?sIHnpo6hR6y0YPU02zGnsaHByUgLlbNwgGOXT++t5ojPpDfiwdlM5edokUQV?=
 =?us-ascii?Q?lWUsQwLGcjBuY8XZbzKOwkwCZ+E3cXTXVncDefVgxxGN0xRPBQgYl6Ndb54Q?=
 =?us-ascii?Q?455gfsmweoH3aciI1Neyy/+avmYxCqEjf2nf6jeEiexyfyplaPNEAfmROWfY?=
 =?us-ascii?Q?sKI6xhYXdD0T/7Wt5ffG2347iJXMiLz1Vq4G2rYBUr5K0+TfkM0Pd1uf57Tr?=
 =?us-ascii?Q?mqKw6Q254dgI7NXR+oc/7Dp0W3sBis9iReaPWKdeks3JO5ze+dGjrLrJFucr?=
 =?us-ascii?Q?kQJD4m2Y5pVLE/GUChKOjaQ+pqZLQaS6Ddtsbt6kdsjMWnoOcIC0JjS9eRa1?=
 =?us-ascii?Q?gfdL92KvQ4uBQCIiB34EBwspjvum08fAVrBQSxgiqcU6FV5RUQ/ZwMZkbKth?=
 =?us-ascii?Q?OTHK3qGGFqxCaQTXqU/lfa/t/EVPj7ZyL5w4GGsCvkqKwumDQOr/wRYEvAHM?=
 =?us-ascii?Q?FEeqEzW/QZ/m+RZj2DZsc6UnCnQ3lnknGRcAqslW+m+Wlodzpxf5C2Lh/6u3?=
 =?us-ascii?Q?h0tO+CyBzbpI6GfV/BFIbQTZpfmVN3UqK9+cdQkACewnJPApKUWJM4b4cWPe?=
 =?us-ascii?Q?4yrmXqvhhMAyy7W5qhkC0AaglSdm7JkJtUNYtthRSxGN4g9uTDMSH8wS5IVl?=
 =?us-ascii?Q?3UKa3dlVER/hYoI9NEX22c9xbJaYzpyuln4wuQqp?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d644e9-e1af-499f-5d36-08db8dd3748c
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 12:25:53.8860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSE6Ik9ZbUH66AHJx2bKa3dnbrNI2ND6tUK3/pm0XlgDEUdUi/06yxLiXNAD+649BBVkjAGvnjCh7RFts8OYVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5020
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs_create_dir() does not return NULL,but it is
possible to return error pointer. Most incorrect error checks
were fixed,but the one in mvebu_mbus_debugfs_init() was forgotten.

Fix the remaining error check.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/bus/mvebu-mbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 00cb792bda18..4c514894cc1f 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -993,7 +993,7 @@ static __init int mvebu_mbus_debugfs_init(void)
 		return 0;
 
 	s->debugfs_root = debugfs_create_dir("mvebu-mbus", NULL);
-	if (s->debugfs_root) {
+	if (!IS_ERR(s->debugfs_root)) {
 		s->debugfs_sdram = debugfs_create_file("sdram", S_IRUGO,
 						       s->debugfs_root, NULL,
 						       &mvebu_sdram_debug_fops);
-- 
2.25.1

