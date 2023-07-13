Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88947517AA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbjGMEph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbjGMEpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:45:25 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2131.outbound.protection.outlook.com [40.107.255.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856A61FE1;
        Wed, 12 Jul 2023 21:45:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wbc2gvxdjkVyTsW0T+XMpIIEZ2txtDuX6k0nEspVmCvEGblbNEBgRJ+PN5liOgSe6tdW2wpklMVKv6p5jibjHqmwItzYiVUysRoIjkPcW922AAcQMm6+cI2/jTW1pUPDLDj/RypSDBkKSUqulX1Lmm+0Aosm7dotWeMmoAQq5S9Wx+ABZH9BG1sQ3VqKz60Ex4UpomHRluu2/dvwvVSTiio0EqR73TJGHZCOHaVYlWfEBMsuh2XBqH7bDePQvW/nzUdXGvBsf9xv5B/XA042NrvZ2z96RC1Kn2YWQA6evZYS7n+AnbdPVoff3SKdvvU1BmAlXJQtVSbtarYYuF5IMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DtoWOi/YOJRa7O/0BDuo7bEUlJKJJq+3DSOtwhf9uU=;
 b=RoFB+iLzaFCrHTw9Qvab5OOii+Pb2SYG71snkW1TfiTLvwGBr/lAJ6J9fHgANehHPbS3ROAPTxM8vFGuMWDVhXGYVrVFUtGxa7HjapjK/tj5gPf2iyWCxDwdPJ39I7/y3DtnqrER7p5GAyKt0LNl5W5va6wIBuo5wmGCJO+hz8O/iaRriCvIS/5oBhd8Ru50RJ68lgpWh5iC/VZP5iuHYAkrJJurU/E/drJFfM5HZI5srYXeRnT3TOyNAjvqlnLC/EfhQI8weNKdvy9XgCivj58B3HEiA0hBb6tFqXZRmMgMaVkhfse+lO18bOWQZ7g+KeR+GQiAtknfvcGCtHV6jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DtoWOi/YOJRa7O/0BDuo7bEUlJKJJq+3DSOtwhf9uU=;
 b=qEC8w/9CvXR+DNIntAdo1e/B9DUGKxkqWt2HHtuRpy8Wcn3uCOVOg130rimyVZ/A6q+9okd/glywJh3m9KLJBuJktZubIgooVb+lLBYzTINi6+YKbyymK+8RaX0KVrFS6DnVoUAphZfnEaYeNeBJ0zs5I3qrGOzMT8lkrljR+uWUktfOXLwQV3Zo2ST/cAlczy0EZPmNHUxwJXrJo/yhKwzJMN+KNv8AamLrOhwOrUohpeXaG3jI8wr9cxSToyPgW9Q/0C0t0fExAyBJ9/642+zPhqs9kQ7WctIV4c1uhqKg7hcHVwxL335Q59eWDC7eg0x7pfgEX9xdiP4w5QQ1Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 KL1PR06MB6651.apcprd06.prod.outlook.com (2603:1096:820:fc::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24; Thu, 13 Jul 2023 04:45:18 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 04:45:18 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org (open list:MARVELL MVPP2 ETHERNET DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] drivers/net: marvell: mvpp2: fix debugfs_create_dir() return check in three functions
Date:   Thu, 13 Jul 2023 12:45:07 +0800
Message-Id: <20230713044507.3275-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0050.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::19) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|KL1PR06MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d1f0fb-3f30-4816-5238-08db835bf523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HdRsiCJ1UTzAJsTl1Lf1hkzYkqEipZIP/Ad6xt4M3bRXo8speroSmo4GX0RbLiJ2dK+I+duPiBh8OCgj5lryTtzxhDfJCFVmsrnoQh3rC+f9DtXWnvdh+nx6t+fthMciVLKPRUW4/y6NNYHhUDj2HFmZr+jDsLA2URApv0ZaQAXs46z5hcKnkgOXdbCNc0GiMNzMsCSFdsPAWGQnvSGdEe9vDRtO2c1B+dTMBFjxWrT3JG9fEzQ35XHexNagjNHzKSA4xzpzdL1iPX7kW+/7Vx1eruKCL4kyhJiFM+RMtnDwzKmkmFKN4VzrJeEvs8ShEXraf86SYrxEwWrevCN4gT0BE3k6O2lPJ4D/YQUCeDve4nBvH1dt4fRJegIHJqEEzKNQG9vs5R7pQy4zIV15Lf1/hIc6+K7EQDJ2YE6+q9/3WuARuG79CDXq77FJlpt43aKneFJjKHSk480rKefM25xLRy4f08dWuOPR/whDQG2qsrFOlyGZo0hdRd+oDuVVQREtrPXoGSw5VZFMqZefejDJ2acefgBY1MGmTdlbyOmfrgJdR48ItOabAAUKU8paczvpdEnx7tw6FHEg5DHa2kFYkb+08erpCpRXnG0CNV/znJwLozWUDk6z67hu3XZR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199021)(2906002)(83380400001)(186003)(6506007)(26005)(1076003)(66946007)(52116002)(6512007)(6486002)(6666004)(66476007)(66556008)(478600001)(110136005)(38350700002)(38100700002)(2616005)(107886003)(86362001)(8936002)(4326008)(316002)(36756003)(41300700001)(8676002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NKi8YAHDGSIWLbl1x3nlle1R2Zcvzox3KrCVFnpIDz2MVWUTqT3RJRcKLVK6?=
 =?us-ascii?Q?zwZyCfSwInD7BK9CxqOIwkCdkcy8NRQ2smK8szazbDk/xx8eyuGs/AsGezVU?=
 =?us-ascii?Q?W+G2KgeFEpylTsTF8kRJUZHiJf+iXvEnpdJzYKY2ZxfHq4NXgmlEzoU/C7Is?=
 =?us-ascii?Q?ugCXWsaBp/TcocZZsL8Y3g72PxayfLGdcys0LmZldFRCPQH5JlzDVZX0xNlw?=
 =?us-ascii?Q?SMQ9Ucx1ZTumVgDIU8TcvcvDB2cx/J09KFAkXpzlqwusyl89FOjmeql8P+dg?=
 =?us-ascii?Q?/YR7qRpPQw/NFfQQkMSwF/GkwAdEZ27sIxauzcrCpdXUbKmYz3l1Xv0TwWTz?=
 =?us-ascii?Q?0HdM30bqVVwxGVKoqtI/G59LFsuMBWtX8Uo3NK9okiWpWI9FtYcCUwpGBlzq?=
 =?us-ascii?Q?5WbFTIiDtEHTt9iEFaXV3v6PakSC020zfaTeeh86LOddzpc7BeZB8wq70bkm?=
 =?us-ascii?Q?F1iYzxpWGZv0WISuzANOlNt19JRNAdLlMDZ13SeYrnHMycYxn4+kNu9skAxX?=
 =?us-ascii?Q?W8Mzc0wPSHD6Zo9JY+0R4LSnXmn6/sTv3wx1W9JDzaqyzn+f3aduGP2fOL95?=
 =?us-ascii?Q?jGGVuQmX3EqQH6bl7AJK+iwnJRNSJBpttw8OXlJP97bzZqf2F5FqzgGfMSrl?=
 =?us-ascii?Q?AvZKygDYWR7bXpWEBze46zuKXH4RJy5PqtmVYhjfze5JlW9BGOBrW4Dw1oad?=
 =?us-ascii?Q?8N3CSCv0oOOJQSsnGciYPtN5CdYKlqf5rAsQwdXmFJITrYE7a5zlqfS3v47d?=
 =?us-ascii?Q?KSSITPWc+0oFBqFF+DE9FGj9493yI4jvJGOhwgXHLynerwpWZkQxQxhbhIkS?=
 =?us-ascii?Q?P46ezc26NoO930ZBXcf9CgrayN15zDelDzoQZ4tc22I3C2L9LZgk5LhnAoFd?=
 =?us-ascii?Q?Pmc94gxFWSZYPaU8gJBcOlnD8mMkkFBhNPYMMUDpnq2GDZq4uh81q4xW9W3S?=
 =?us-ascii?Q?4JBJ9/ArtnPR4qxCRlfGxHLXPsrmExmQaZg8pH9FAZSJYFQLrf+2meDLp5PL?=
 =?us-ascii?Q?TFU2yxW84P08f50G1lR4urpqR2faY+rFh8YblmbQsXk4T7S/q93SqeobqjAI?=
 =?us-ascii?Q?PtgVfXzR74O1Jnp2haeqZWWF/5/jQmCjyVCYibleMiQOA/hvPGOr9KweV8QO?=
 =?us-ascii?Q?5Gwq1aKvvCnJD4xptPpxJrCJ16YM773wZnNQoUSX4AXDcs0FJK/iFM/EGSn1?=
 =?us-ascii?Q?Boe70/DoSrVmYSLojP1U7HEFlfgU0p7iggg25YpOkGl7savJ34/S14+xiTm6?=
 =?us-ascii?Q?UgWIEyk6mos3I9YwCKvJgVL51hKaSi2evNDqx3JGw17N6JlMGLBhPc9vcLaU?=
 =?us-ascii?Q?w13P9Tg6l5r7Uok+VuWgjxv/DUV5tGjQoHF1SeiB7DWx2a84SiIDdvwQ/Bey?=
 =?us-ascii?Q?dWG8hayRZhBiVORIoDPbK+eGwHoGt394X5TitKKy+qcpnAde0t3xc+Sc4KMk?=
 =?us-ascii?Q?+o0Y9Ug6ZS75qwjvCzSU1/H8bjs3y74MEQK+z+vZqiQ5RYCnchzZ+/lec0cP?=
 =?us-ascii?Q?7nWVLwRGS90aqBLaV8oLWd9Z45BQ+9f/3LU5zsbpj9mYuP5cuACA0iaatace?=
 =?us-ascii?Q?1XgZuQss5Md+rpHZXD+s5CjyUJpmLlX4+1THcxtt?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d1f0fb-3f30-4816-5238-08db835bf523
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 04:45:18.2965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: insJmeHjhukUHnDutOWW/GNapEuli/exdBGkGh1KTDZhn3NCxkMBx3CbHIjwDgzqD3CTTz1reStWgwIYYitAZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6651
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make IS_ERR() judge the debugfs_create_dir() function return
in mvpp2_dbgfs_c2_entry_init(), mvpp2_dbgfs_flow_tbl_entry_init()
 and mvpp2_dbgfs_cls_init()
Line 562 deletes the space because checkpatch reports an error.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
index 75e83ea2a..37bff3304 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
@@ -559,7 +559,7 @@ static int mvpp2_dbgfs_prs_entry_init(struct dentry *parent,
 			    &mvpp2_dbgfs_prs_hits_fops);
 
 	debugfs_create_file("pmap", 0444, prs_entry_dir, entry,
-			     &mvpp2_dbgfs_prs_pmap_fops);
+			    &mvpp2_dbgfs_prs_pmap_fops);
 
 	return 0;
 }
@@ -593,7 +593,7 @@ static int mvpp2_dbgfs_c2_entry_init(struct dentry *parent,
 	sprintf(c2_entry_name, "%03d", id);
 
 	c2_entry_dir = debugfs_create_dir(c2_entry_name, parent);
-	if (!c2_entry_dir)
+	if (IS_ERR(c2_entry_dir))
 		return -ENOMEM;
 
 	entry = &priv->dbgfs_entries->c2_entries[id];
@@ -626,7 +626,7 @@ static int mvpp2_dbgfs_flow_tbl_entry_init(struct dentry *parent,
 	sprintf(flow_tbl_entry_name, "%03d", id);
 
 	flow_tbl_entry_dir = debugfs_create_dir(flow_tbl_entry_name, parent);
-	if (!flow_tbl_entry_dir)
+	if (IS_ERR(flow_tbl_entry_dir))
 		return -ENOMEM;
 
 	entry = &priv->dbgfs_entries->flt_entries[id];
@@ -646,11 +646,11 @@ static int mvpp2_dbgfs_cls_init(struct dentry *parent, struct mvpp2 *priv)
 	int i, ret;
 
 	cls_dir = debugfs_create_dir("classifier", parent);
-	if (!cls_dir)
+	if (IS_ERR(cls_dir))
 		return -ENOMEM;
 
 	c2_dir = debugfs_create_dir("c2", cls_dir);
-	if (!c2_dir)
+	if (IS_ERR(c2_dir))
 		return -ENOMEM;
 
 	for (i = 0; i < MVPP22_CLS_C2_N_ENTRIES; i++) {
@@ -660,7 +660,7 @@ static int mvpp2_dbgfs_cls_init(struct dentry *parent, struct mvpp2 *priv)
 	}
 
 	flow_tbl_dir = debugfs_create_dir("flow_table", cls_dir);
-	if (!flow_tbl_dir)
+	if (IS_ERR(flow_tbl_dir))
 		return -ENOMEM;
 
 	for (i = 0; i < MVPP2_CLS_FLOWS_TBL_SIZE; i++) {
-- 
2.39.0

