Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F001756025
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjGQKLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjGQKL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:11:28 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2129.outbound.protection.outlook.com [40.107.215.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B247C91;
        Mon, 17 Jul 2023 03:11:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrT9SKL6gFm1XN0XTuGWK/9sSF4+f3n+HFMERa1f5/hpqz9wvZuf5t0D6nXy9ikMeypVyX+zoAGM6WVvP0oj/Pg8UoS6xp3k7VNyLufPIqMgkzR3Dw8/dvYikNP2I5BrGsbovHUMRWF6ZaFotAkMRRbuGLqHJtlky1nDeSZNh5Hs+tCFZCInmKKpic6XMWcBO2ZfYcZB6rXAAE1QSXIDLSWhMJTutXMY7r5oWU7sT2+YibQnCnMkUmFK1vI9qP9FIcQq1xBPuF/6ZnRZ0UOCOdVtBDeLBsdh7DmNKhfdTy9aRKLP2W9STN6vd3QvxkbBF0thn5qf65DZL4iAcog5gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5B2hiMta0IVLS0vR3ynw4Cp2FY0Ll3OEBCetJGfCuUA=;
 b=PBWTjLRO1AscqqOVN9uayk5zODTOT16VLiRPb4MeE291SGrw5hPuNWLlp3oVp908EBzWyqbH8yopDLS4Af2UX8blS/hs8/f8wqBeUH3j91GBwKO4FDVFGbnfDfqHdzM+hygprMk7GUlrS1oS6mSJjWlmO0S80BXz2P8vS5r0myudwXsshsEELI4SLbRYqtAuvVqWumL10HFzG6pBX/T7YWF7cpPHEjjFYjnwMUDlkn7/Q0/lJLnathyEZFHWce7KBk28pB/1wi3U7RPrueHefJFFNRlKDJwRs5kWQPKehB9UDvNRB3uSObgJDsHlJF9+jhg/1aOUOy0jFzAUNUBakA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5B2hiMta0IVLS0vR3ynw4Cp2FY0Ll3OEBCetJGfCuUA=;
 b=OYazJiVmPHvnYObVqiVVnBPhCZ+3CfxfCVWq505yLcQrEKnhlByak1HVYYWSuZs+kDF+j6ZVs3oyv9AzDkwFv43SxubgDzBWy5t/7qltTlcWCIuXRdRJ1TGg3VQwmzzL2a29sqKWWLtoaI/N6QTHuDN966usNsNu8J0KMXKsLgvHmHZljzQs1Qahp4egd6GRybyRoWsMpHKQFz822VA04KB+2Er6ElNWI5B9Y7ZO88fJPhlPYNE6Yaws6uWpNqP8F8loLsHLsMu3EIXFjsdfzoE+Hytjfv11u3iJbKEslTkrMvaPyuXqnMq15WPmY1U9Hp8Qdx9PNqQj6nRTuDJc+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Mon, 17 Jul 2023 10:11:23 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 10:11:23 +0000
From:   Wang Ming <machel@vivo.com>
To:     Mark Pearson <markpearson@lenovo.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v1] platform: x86: Use kfree_sensitive instead of kfree
Date:   Mon, 17 Jul 2023 18:11:02 +0800
Message-Id: <20230717101114.18966-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0201.apcprd04.prod.outlook.com
 (2603:1096:4:187::23) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|SI2PR06MB5140:EE_
X-MS-Office365-Filtering-Correlation-Id: 971a207b-1bbc-4924-c0c0-08db86ae2c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cfB9y2e0S9xy02cO3+XqxvUrLvPDy7E0zE3xB+gh5CAZKyJK+YXCpCJVcWjoODwlmcZHLem1Ei4u1RKYnY2B2uRApDPfY5b2frQ5JjKtfmmnygX4nAww2HU3C2thbk1vHD++du5FEE+10EaR4GTjOFLYmvpiWrgSfwssgrP4Htbt7fxYYg5RCf2jKYU0kxgWmNYiGbpDqhi5rz42tP4oz0ZJSv5bDXG+TMAC4CTNhPililCAd4gujl5jqtVjHgTJ3Hm/J2WZCVgkk/GMic5Hw9jTxmfppWzEwCVu55iHnDZyVpj3oet6VFC5AWTLSUuza07kJE0slhLIMHEbu8HaVgiyTdeS+cUG5jJEedzPzJ4iy6P6VZhrHb5Np80KzRtsOPz1g670K9lH5MhUcDatiB26KCnQJ7+ITWDmPOCNwD9laB3Yay65qrIWDZRlPDFqXYZ+ojFy0qZB9q73LrzCbUNuPZMwRbrOasxgmGEfKaYF58QH3wc5ISme0wa3SrOAhRnqnUV23uRVBWXRnmWbZZkDEioQdas/kBrTDJyFLeycJR6xdNv1QavUoeK0Ssbel++apzyC45HD2DPl7KJXZ5B5T26nPR0BvAlKUZbuluR+ls4hR0j5Tp/5KuigRANX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199021)(6666004)(110136005)(38100700002)(38350700002)(6486002)(52116002)(41300700001)(8936002)(478600001)(5660300002)(8676002)(66476007)(66946007)(316002)(4326008)(66556008)(2616005)(186003)(83380400001)(6512007)(1076003)(6506007)(26005)(107886003)(86362001)(36756003)(4744005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?THkD/wdBrhTmbRmVzdBKMcIjLPGT0BvhveA3P/J8btNqFdu7jWnnQQXg8V86?=
 =?us-ascii?Q?e45mPPpeyz7v9dOzI6UzKTmgFzatNaWkaG0BC36LQaoLabVNS6YYEnSpbOBt?=
 =?us-ascii?Q?4ZpGyEzAlqPqcewZvnk3em1Pygya82GR7M65Y1k6SUvTMzILFUO4RsUIied7?=
 =?us-ascii?Q?dAZfeAREPh5mZEfMt/MNJqP3IFiNHBeMfJBTRcxj/FUOpn1a6Fz3LbM/OOR4?=
 =?us-ascii?Q?r7KTNEy9JM6J8lhOOIXykR/lVf41h58yrw6ilbf0pQ9D6EFRXp/vGqUc7clg?=
 =?us-ascii?Q?Nuu6HJK8HyHozjfsD0mD/55NdIhuw0Zpj/coOcJfWmjxiU5fX4NkWrOk7Qud?=
 =?us-ascii?Q?dYXLRLKfFfI/rAQ8oEKw1zw9v30xEesvl6ff9G/P+HZ9gAEiExmt97BvdlU3?=
 =?us-ascii?Q?FDl0riKC1K77d9GlCri7OS37UUgjP8bZDvazs9FvMMW64QpTpkJaGhHSQf0O?=
 =?us-ascii?Q?rFaKgtBybV8V35GVtntwZfA+FPGCcUl+8FwSUf1uof1o6njcXAJh9rpf09ZL?=
 =?us-ascii?Q?wAzahEn56PziIJm2fytm+nlaWpHgtmodOAe7r4tEF8LmGY5mcdjzXFkc4XZo?=
 =?us-ascii?Q?stwOa4Pl8JUW+f8obDBuuTPpbQsioqUm3OH6JyiTusV0WdnU9Fmnw+CELyd3?=
 =?us-ascii?Q?9NQTrXHnZbgL2mfm7jBRty9gryfanKiGuQdfoZsvHwzf2Z9SbeQq7bV8h9h8?=
 =?us-ascii?Q?D5uqewPSMtyQpCOZt2UJrX/0DXzzhTrDU3msGO6BAFgw3mqBhu1CBzdeZ2fW?=
 =?us-ascii?Q?KfKefhxjEM0HL2R/7I12kDxpAunycm8FOSVNGozewUD4FF7QHqs7jXcQq3Pw?=
 =?us-ascii?Q?c1Wl0Gi8JjiSQDikFnyliZ/IvwV7WjytU4xGZJTAwcnshY3YMOzZelRxtExJ?=
 =?us-ascii?Q?StAf9zrAgkePudl9iszcjs/wavl3UeIzYBK41ftxM15zSskwaGqW8IIleHUR?=
 =?us-ascii?Q?uzs6oMIoLRQAASHVMb0kyy+N1PuJdR3ZnTf4lntEsPbY/MyxY758nrY2ZDAZ?=
 =?us-ascii?Q?xX6NEyrwwj9I6/gZcYo3+21OhS1dA0e64iLig9y1uFnk2VBYL9gsPuKFyqri?=
 =?us-ascii?Q?JGSXmNnx5z6F6qiTP3f4UJSYmIyqOLjXxe4gPah0Kn2qNn6WBXJOTBAOz96g?=
 =?us-ascii?Q?0y0Wg7DMNYZuAkg02aTOSrT1iM4to5gJcCk2pY5muCo5LnVawQ3crQoS1syK?=
 =?us-ascii?Q?Vixd3NOqznUZ5dpf9Luqbw1P9sEFo+LmBxMbFrsbFhiYWqU0ADZuY2ZJaLpf?=
 =?us-ascii?Q?l2rSA19ue1WSsGlmHAIdp5odJXiI899GOj3j588KePiiTm11ezgEotlW5o/K?=
 =?us-ascii?Q?IGw/gf+SdPS8sowYKnnMSmGJTAG3PxCjjtRr6MzaB3/ZLL8MguaIZnI9xSVQ?=
 =?us-ascii?Q?a4beTJJk8NxRcbPlNs/i3rwDsB1N9UCub1hpZo0/uAcggVgYXHgcnnsmfcC6?=
 =?us-ascii?Q?HcuFXsyjACqNGIp0B8x5mzP1x7YCjgvdAMXZDWq7vuCaVoR/RbIxnXY6rz66?=
 =?us-ascii?Q?Ae4H2+YzzSW0A4FiOfiW2CfXunso6FNhWpBBReKHZptZJVXBwLE6MTbmYd5m?=
 =?us-ascii?Q?Y4M1aD7NP8+1xcOIC+dNiT2ZWJrff2Uc7U3UH+W/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 971a207b-1bbc-4924-c0c0-08db86ae2c8d
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 10:11:23.4344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfIKI5PP6fDC9hfOewTs5uaGh5fbcMFmDZ0s3IrfvrnESwsSgPO1H6c+CcSL5NB5zdZvNg9Q8D4GB7JRRlH0dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

key might contain private part of the key, so better use
kfree_sensitive to free it.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/platform/x86/think-lmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 52d1ce8dfe44..79346881cadb 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -719,12 +719,12 @@ static ssize_t cert_to_password_store(struct kobject *kobj,
 	/* Format: 'Password,Signature' */
 	auth_str = kasprintf(GFP_KERNEL, "%s,%s", passwd, setting->signature);
 	if (!auth_str) {
-		kfree(passwd);
+		kfree_sensitive(passwd);
 		return -ENOMEM;
 	}
 	ret = tlmi_simple_call(LENOVO_CERT_TO_PASSWORD_GUID, auth_str);
 	kfree(auth_str);
-	kfree(passwd);
+	kfree_sensitive(passwd);
 
 	return ret ?: count;
 }
-- 
2.25.1

