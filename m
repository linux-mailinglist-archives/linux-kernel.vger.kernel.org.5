Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258EA755FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjGQJqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjGQJp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:45:57 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2093.outbound.protection.outlook.com [40.107.215.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C67E10DF;
        Mon, 17 Jul 2023 02:45:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiYPa/4HBmdt5yttXKU3cy3D5oXFSknTuzFiuhsPa+6/Ou6AYcGFixBG9bP3HNtXEIc3gnrlJeWL6ujPQpQOK3scJRJ/lUCPu3ZLmQUdVvyhvmIXoiWyl5hOLhC9Y7emQ69A7XXA1l7NE99EQe+S8lZKUJYRaj0of1eQ7k3rKCvvvHbwjUbPrwoeme9SW+ATCwFlVVNFFrjhaoenYT6/M9F1WYwl9yhalK10f49+tbbhTN5UL/blPyN0M1BM++paRcW/JrifljtgmeU9spIMJf3ZC4QZHVG3TUYWWhePx1YJH1sdgOn6jJyp8rWAP3F1JeuHdqkIE8ivzFq6ROXGDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gOBMSoaFRL42fRxNox6CQjI0vRRa/AnK5OG9CdtoW0=;
 b=boTj2hiUgLLVHjaz6zYI+Fa/YI9x77nDm23YL+6FMDFw13W+IZ1PGgU9sI1wXWnUfeWAnLiKpPIj0qWbu72OfC1s0yc4446Y+BFOcOu7RrFmsDtcLCu/TI7brhcSToIOQeGhzej2bB0VWlGW7ezUViAr8polgqBMd3HyRiCH3zSmfaxd67glpLXExVf3rUFvPCoHlHUcYgHlpWPHMiE/gQsChuc4kX+wdKie4uWGM5b+sABjevlztNvatlViohKWutmH6pbactoZubB5Q9DjA+qwq0qiKe1CnyoQHzcb9QlfThmlVjOgu5VVlXjAGPGcWvITyRpLif28IGVm7ZbFbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gOBMSoaFRL42fRxNox6CQjI0vRRa/AnK5OG9CdtoW0=;
 b=PkmpWGTrqkEUjpWCiwXXQaKIG/u3hNJX6AGGBtNGf3Ev5SY+dO3MHDmQUlOKcfLvvYgThpFXoyg61xK/3eGwqPD9K5u5yw20Pess9y+HL9AVE3Lv42ItEkS0GF1dP4RrUHQ6t4Tx2ZQuCmgBmRWR6XnPWHvtGY1i4dFWpUhDXkj4NODNSG8LDvpJirGnI9Nl/369df1DsWHp+E96RWI7Z4lrWcERpGA6rs1W/I+DKmux/0XRY0StOi+N/OLvdJN15miQduYGzq6fjM5vM60gfspSFRTvUZ6P8/+ByXoqDB0rUjedcmAxWWAST5vTvxVzGoPZhQTgGTrWp4jLqE5JxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 TYZPR06MB5002.apcprd06.prod.outlook.com (2603:1096:400:1cd::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Mon, 17 Jul 2023 09:45:51 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 09:45:51 +0000
From:   Wang Ming <machel@vivo.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v1] arch: s390: Use kfree_sensitive instead of kfree
Date:   Mon, 17 Jul 2023 17:45:19 +0800
Message-Id: <20230717094533.18418-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR01CA0018.jpnprd01.prod.outlook.com
 (2603:1096:404:a::30) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|TYZPR06MB5002:EE_
X-MS-Office365-Filtering-Correlation-Id: a035b591-e75e-4073-72ec-08db86aa9ad5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WRhjkV2gpwoe16BWrPEqispuk2X2WN+nRPgvtfPT16cal1J5GTBOs0WyS4FURnGVprIUz17eyJOfohFHP18dmmly2yUK52cNMt69VFrp11wmEUf6+4PckYaJq7Nz6IfeUNF6roZBBis6pNezdjtg/fhftogXTf/LIjVD+XN4hsqbcS9oC+NfgFbXAuUxrAlHw2LDz+TjSbLimd/vTmIpOf/O14h/FRVh0YmYKISpT+NhKYP4V3B5DAiv3XlhTmOWjsiNEjcs61yIWhlkXXT0zW1epqyiJTv/8U/8OjPHUEGVAi6nHN0JaeBiZM1LA78cchat2XRYuMJbHvDJxQK9ySyn9fqzu4+OJgGcSRfsmBsrPdbSP+SA0ukMJS/osBodZ5fjIm8OL4Rj/x6s6qgraPnteVunewG9lgc8LsCtwLCJBpjJ3L3W+5cuRSeA1kadIps45+d1AP1crnXBx2BnVjlHrd0LMXI7DbjAnjhziq7Vig72aHA0dBxsI6F+bkkfQvKyT13xLfhWwycioeIsKcw6O7IgLpeZHHfvlkoYki9CzllBA35L0fS7nDT0navzVnF+y/ZIbKTIU5EMSQNklpZkdho0zSTfj1YGZO/b6XsNLXZ/zroVG53qBTsvVx6EIKGElokR6GZggCvwbCOKOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(39850400004)(346002)(376002)(451199021)(2906002)(110136005)(478600001)(6486002)(6666004)(52116002)(8936002)(36756003)(4744005)(8676002)(7416002)(41300700001)(66476007)(316002)(66946007)(66556008)(4326008)(83380400001)(38100700002)(86362001)(921005)(38350700002)(6512007)(5660300002)(1076003)(26005)(107886003)(2616005)(186003)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rdaMsDGKpokxV3I/lcz7Nmy2hyfysmErfEE8S6myb4sadXoi+Yi74CCyc4ns?=
 =?us-ascii?Q?vN+PGoCIo4LY2Y5BFHl1NAu6UBd65ItET3OeOMObS5cAqUNHTEVK78CnX7Om?=
 =?us-ascii?Q?6IqrXBfjcr7huw1hvnrxoqT++LSHWidDTt8QG7tueeD+tvlbmgzaXdJINTfW?=
 =?us-ascii?Q?GFLPsidIE2Z1JR4z/rmNUj9lgdk8yQa9WbRre4YuyRpJmhOu6OOidsGgjCRs?=
 =?us-ascii?Q?X4J5nMiCfuG13ELbPRugXdsEHdJWmgKiBC5Bd3V24vs5ZFTTQao0TBUIDTIc?=
 =?us-ascii?Q?4/ejuzXzHcxJKxRwJjluK4bMYdKgImnXIeMcwKqoJ6BjyyiqOsVNGuMspGuw?=
 =?us-ascii?Q?xv4DqMuvCAbcBKFXkeU49AVCJlhwh2Bqu7Wf1+y8s0FtrypgTKU9kqqkWT3w?=
 =?us-ascii?Q?neCO8awhHM2p8Pu9hXDp0gNoQE9X3Y1ME0pP0rrf31MpV/GovwG9ntT2LGh3?=
 =?us-ascii?Q?bmJlvIZsPoXzC97N3craW302Ff6p0rr7k/wMUob+aXwSptOUAhDxieCIZXfa?=
 =?us-ascii?Q?LRIN3C6chFG/8W3Ew18nVOqLPBh5/wNcPfbGTPkGwFUaspIE1+8Oz+zYKGHi?=
 =?us-ascii?Q?BySgRK4lyssaG6t4M36wXFQlUJfEBeAXtm5plqppK8vpq3hM/ZhSSDaUlqAu?=
 =?us-ascii?Q?jdRQ2bHHuKsiHmht1udQawQcvwy1vcLLiNri4ChkPD885m0xjo+4cYKW6+jp?=
 =?us-ascii?Q?q1NU+xsexBijyeBDne2JU4wIOSv3AX6E0feVEMy68fTW5n4FAoW+ROq3TSWN?=
 =?us-ascii?Q?lXCUwiIpMtueXH9YdK1tugdwg3pPT6194752UQmZZYJWRVcxHzyjJ8A/ntTK?=
 =?us-ascii?Q?M0jnsf1kDfyttQgRDeWLHTBnVB+MCLG/QRbzCAGlyJpKZtmK9LUPzBP5Uzw6?=
 =?us-ascii?Q?vBGbW6ivc4OprC7092hiWkfBoIdYuGsiHa87/TZVN83/zUbEoEb1ejSQ0PH0?=
 =?us-ascii?Q?ANeRm0zkZk8y/e3XdMBwa/DcDbrC0/wlMqym0pRdfUOdMLVbGcdRVqaaKe0g?=
 =?us-ascii?Q?19cV8aAMMJrfM7GRElsjeEWxUos6BZ/ACCgtlJMS8DFTUArCOffw+28RfkQS?=
 =?us-ascii?Q?gkYpoYQhtBPqcGkL79LSs6HsapI3AgcEArEH5m7n7iaZJdS9zm4Lz3nANmJP?=
 =?us-ascii?Q?VeaTlJDKzar929mMxGYW4aLJAqPyj5X22BMQp49Vowm88W6fhncAmZU+RsMu?=
 =?us-ascii?Q?JKkP5WxIH66pYXvbFOhC9EN8KFdSHLzqAKxfIB0KBEO2F7lLf4Ji35iM9LyU?=
 =?us-ascii?Q?y8gqySGemYFKUJSf3zt6qh0/s2zlefTvlh7lDWZQpJFfYg5M8c/7VQrQKwpI?=
 =?us-ascii?Q?fIi8Rrcui1bAfWmi+9Sum1buQvpq/4aEvVvlmD81mwrOVm7uca7+GalWgmhM?=
 =?us-ascii?Q?NNQMnUVALurTnp/KMMUPOa0nMvGeHoTAGWpGeRL3fF2WV5Bp92P8HVnmsaMN?=
 =?us-ascii?Q?7ayLDY9mMxg7Fz0Xalx7BYo4Kzbnls2boWPK+WFsFK8h9rm947mrZrrgKAr8?=
 =?us-ascii?Q?h7Cwhr24nuLmWPZawh1BhK5Q7OV6f3dOcCmxcwG50WlB5bEoUYzycoGgOrzW?=
 =?us-ascii?Q?S0qXWoY1l/B2ZsumlPVlXYr1DPKKusikPw7jVDeX?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a035b591-e75e-4073-72ec-08db86aa9ad5
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 09:45:51.1776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/QMi4luglGsj4NUJUcdvkw/mXbraSbyVda8QX7bgZA7jz6GuyN+sWsvtCpy5XUJ+/TAjlBThNXjBTUeh+Wx8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5002
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
 arch/s390/crypto/paes_s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
index d29a9d908797..38349150c96e 100644
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -103,7 +103,7 @@ static inline void _free_kb_keybuf(struct key_blob *kb)
 {
 	if (kb->key && kb->key != kb->keybuf
 	    && kb->keylen > sizeof(kb->keybuf)) {
-		kfree(kb->key);
+		kfree_sensitive(kb->key);
 		kb->key = NULL;
 	}
 }
-- 
2.25.1

