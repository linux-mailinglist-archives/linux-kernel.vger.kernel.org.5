Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18CD7DE532
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344849AbjKARR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344742AbjKARRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:17:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB604122
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:17:03 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1GYoW8011191;
        Wed, 1 Nov 2023 17:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=A558WsTvaSU/K3Z1XzDFTtaSK5lZeV05+s0FwlRXb0s=;
 b=ALKgumDZdCPaQjMDSod/IYZXZlc1vp1WymG6pzMNUSrteOouACiVtWtLV+zFnPDO0Rvn
 t6yzjocqNuqNz/RtnWitux6ulxYdqlf08qwTbUyaMhaWeB1c68BPvVG8+ArxBO6tVwps
 4iN8jada9laqvOiWpN4gTg7B6//3huYTgW/vhgKiPAYtHhxSXoz+DRhnmor0MicQTy18
 OOFwD6x5l1qulhao74Z20TAv682M9KJ17KOcirLgatyPUf2kIS7RT0GUB9sT3lmO6EWG
 3A72jCKdB8ONmUGTxqx7DKf3nlEwlSfZihR6ZwMGt+qMIV7G8YrFBCs1CdrqmOw/HkL6 tw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s7byxt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 17:16:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1H7nw8038146;
        Wed, 1 Nov 2023 17:16:55 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rrdjy1h-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 17:16:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogyQi3POz2j2rzZSFeQkBljvVRBglBJMi44OyytWZC7PCRan56AI3nH/Z74RTk16TLSnhFwwH8MHcGlpgcflL+SzVdUS3RXM4wa38msrtlObthdS1iiUC0NSUwRCh7TRjK1IOPvX9Xyeim8x8O054kWgi1ob887gKaJihHAFycKwC+2rD9k6GfEXkvzd+QCBxemweGeq+aDun/AVgYOd/lC2UmlJ+cdcp8ZBQnR0MGVlFmdLNqlpymBwQMkfbpu3KEAgmR39OOu9JkmjwFeAYAKKEfZvoPQyGLA3RtdiGy1jMWg6/BCoeXQwfdpPwpmL0q0BiPJ7ghL95a3s/llE5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A558WsTvaSU/K3Z1XzDFTtaSK5lZeV05+s0FwlRXb0s=;
 b=IDCCN1hXbb0o8xSfKH3YU+LXVgKaYSGnbzyISaUD3mzwc6fhW1weaXtDEW/wzjkBCKO9ksKK01dvCcflGfEkp24dGNF64xQ43x1JiRdSOLRf4wWi3q/qgcn6ZBb6XTL9Ol3H04kyqliVQ90yQYX6BPpLl/cB0pv6tfTo3Q8dHudb8qITivaLQaSrAfdqYFt/HGXBA4RBF7y9wUNDDEeW7L7jsEMJOcztcPFLwb3t7N6C8PRI48oM+RRMbEH0ke6HN8wm8CZ9at2iCfmdIt+GcpuuzLznUnnDSDqdWP8iwKtMDweI8ShgQtLrIQtg2U35A6UMlmy7fOceEcnXXnucAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A558WsTvaSU/K3Z1XzDFTtaSK5lZeV05+s0FwlRXb0s=;
 b=Ft7CJ6FN6nF7DxO+tGFJylSMnS5haQLh5Q5mk/KLb/61HHBD5YOfAXzQL5iWpDSZDpgry/ePICjc16kwurc4bshCYbxJwce23zDwuvjb0+5x+BqvUol04owbbuG7zST0Sn3raKChrWhWqNUjzhVttu7NyGmlRqFhL3VGoyhvsvE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB7684.namprd10.prod.outlook.com (2603:10b6:806:38e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 1 Nov
 2023 17:16:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6907.025; Wed, 1 Nov 2023
 17:16:53 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 09/12] maple_tree: Remove mas_searchable()
Date:   Wed,  1 Nov 2023 13:16:26 -0400
Message-Id: <20231101171629.3612299-10-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231101171629.3612299-1-Liam.Howlett@oracle.com>
References: <20231101171629.3612299-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::9) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c7f1d8-3963-4aa6-8824-08dbdafe57ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f0jjbXudFquoMbRadOyC/J62O2th39I8EcC6m8byJfe7mxDcbU6sIcPY21sKgVbAVsbCpO9D7T7WEfLy4HXnGPtNsr3n819q48T/IU2rV0kcbsVuJcjX66SrGOSBeHAckvLd9hJ43QV9naJT9gIG7oX525YtAojY2nzZpbpeKndpWSOH7/bMPCEb/Mx5kJDuIwzm2ENwzNAo+cHruBeYzageB5IkQ4TnhKkSj6JfAxMCav1XQIawDkq/OB4KYfsYiLVEMSA1Kzh98QvkYDXjXTX9HgDFkloWmlQ3HGyECkezm8u9MvrSmHhnyF5F7qjzvCnL7lXoQKqYYAHdT27sPEB3bFmwmdVIcFYiLELnoIrbwKzhqcalwJRMGouJTOZrMJ40Dqh/UCl3WPnKFST0iNcGtzE+323TTEkHvIQC8UeFrKn3Ea3RKJ+34MOJRa34eWkdbBsCa/uThTJdT9pc2iSpqV9p7BND+YagRPvknrR6aRwZGgY6jsXyKasCy8hUU5JI+tF8M8bwxU0rs2kir39rcjGopkc1yyJG6vMsFtejLr5fCzaOeuaRu5eBStSo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6486002)(8936002)(2906002)(4326008)(41300700001)(8676002)(5660300002)(6666004)(6506007)(66476007)(107886003)(83380400001)(1076003)(2616005)(36756003)(26005)(6512007)(38100700002)(316002)(86362001)(478600001)(66556008)(6916009)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p2EB5fAuVCDp2DmqzHZ6tTUNoT0cQIrPXmRdIer8mN2Gb7TzrfzWaDjlBJgc?=
 =?us-ascii?Q?qJf1nnArx7AaqR7OX/8Al80tc2ngiwlLa/2iGHLE08GGsFoD+39My8UFo464?=
 =?us-ascii?Q?dbJjpbX8cqhlB/JIJZyKk7t3a2BhysQrXSJtls44vf1Cbs8X/MF0m4OZuwvz?=
 =?us-ascii?Q?ItW5pCbY9Ew6oP8OyLiEaXhnUi8Tw252XiR/hkGPB9dq+U0lt/MG/r4grE6G?=
 =?us-ascii?Q?JFQYF98ASBS10QfQyPBKNFhDgt4B5pQnIqafwgA1Hp6e3ZS0jxBuumx/dEiJ?=
 =?us-ascii?Q?6YKwOqNgN+wWEMLuBTmR483iP26HwEeQem63km8abfOuo/BATebMtQldzdVj?=
 =?us-ascii?Q?nZWPGOGRysjnUVrl7TSX0wtSS+TtF/Mw4Ir6ZM5Miuj8LHmsmcGadYVlJ/X6?=
 =?us-ascii?Q?0u7ZvpGAtywQSoZqlWnOsgJfYZyqUV+GONO7eQzGjzXIsFGYQZX+up4WgYWZ?=
 =?us-ascii?Q?wCYmD5GYshq82Q8/qcfhWqbv2piVyl/tJzjZVom1exKvh+3nmEU9/LcxWWZ6?=
 =?us-ascii?Q?O3k+2OMKZScKjVIrIOj3ScjXZRoqnIIrsEhskGZbST43Ht20fEageFlyzb1I?=
 =?us-ascii?Q?zRA3L9ulUg0GdMQK6RncYS+7JpNZcsf1ZBLj7mKT46BTRWYn8avvbN+9No+X?=
 =?us-ascii?Q?bLAbGXONfnOn50N0RxECVq62NbTQzC2AOUQ6XBUmB2ul1F0EP4pC1LDWUsa3?=
 =?us-ascii?Q?cVgP3TgWSwqtaNz37dAqmqAeLAQk3p1r1JX88lDMvHYNzQ+u9hqmyH8yMsTm?=
 =?us-ascii?Q?MpSwtAbn9tjYdsuVbhBdN75u0CnBBPIyj8knsMxB6W5dQgQFwidXlxjwtOU0?=
 =?us-ascii?Q?AjVXuf/nvtovzxS5igg0/bG5LVDsDxUX/Z2hkK/NxIBmAQbVqHflwNr7gCXA?=
 =?us-ascii?Q?h9L6Wi6KaToUeKCMnnPp0UFprZQiV9aDb5ekTqqNOLGYvksxEEG/CmprpHxh?=
 =?us-ascii?Q?xtWpmUV1gkWVjadH5ouuza/Qa1fx65RXKckPTUy5SDKFtNicJv2MpPaR3c+G?=
 =?us-ascii?Q?nxGj4GTL4vr3U+OTjcBtakPq/tpNEpRI9NwzPTzG/8Um8j1Ure1GpCozUCbR?=
 =?us-ascii?Q?NN/hHzqAouMe81I27tGHA/osKZhcqdpWzIV/4kPzHwEutOrfXlFKN7jHfsPc?=
 =?us-ascii?Q?dBVxI9hjqDFSIgwdj62ozyL/wL/zRvX0lZMAszZ4lv5T1pLjP/zUfJj3gklP?=
 =?us-ascii?Q?ZnKbOm6cerz5V2LOoo2C5pmdx3UWSH3AKUJ2MOLvgzc9vuwPiH1TVQ/6J93z?=
 =?us-ascii?Q?EWJs6NUDGdwht2WNLkh/SCC9TWJbPYry2/JlK5a8QNYuAQlelOKNudzxWTkX?=
 =?us-ascii?Q?/Dl8js+fVJhF9WXvwqq5bIn+blljmMKv9W1uBZcr6MYfsTsy+aNipVyfYky7?=
 =?us-ascii?Q?XilNGx/BtccyQediGTNhWDSHZx2amjDcFX00igTXgVk5s86z+h7cttVfdlTu?=
 =?us-ascii?Q?l3dHlfBQ2IfA89ifHEOhdy7W0t87I7iJ55iElcA6D45UQzb3fIJQtZ3/TOWC?=
 =?us-ascii?Q?y/nCWg5rg60MyYZeG+aRgVVaq6ajOs0W+r7WByMSquNSz0dV2bHoz2q9IWMs?=
 =?us-ascii?Q?15Iyzn+LlX+tnWf0S2BTnnkAfqSy456d3YDUzy8f8KEk5jUsHZtDIUl3mY/o?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +Iaf1Is1sIMGr4Ipdh/DEKAo4oqBS2w5zn8wdR113jogGDQN6l8NrAXaOXuRERX2VWnIj+cYhVMva10iHFdWu30COr+tBmdF9NpIm+PvIldPSTZz1HwXSxFYYn0nUMafUflmD5o998ZcIHNHXELxBwYcW/AD/yGw6sBmbBY8H7+p25VRzJaOxqobCes3fn8ZxlW7UkMRi0utkC+U0XUHIiQ7/1FawNyqMJ1X4FR9ctiIm2Uhpyvv9dQxbNenp+v0IJI/NE8sKD86xWMSPBn+5kEj3qRrx2oC2rOI+15l5k5Ctw4tBzmpPtJaIFhYlgfG15HHUGsYcTN3eZNNS10x1y3TN1WWfxlhI7W+dpUzeqm0dT2M/PC96O8hdBqTLsSMyroVuJVxaKUcLp26wOzubsYZPT5ggOFDcwF2Lp/kujlKx4qAuWRYurhciM2z4Y8InpolETpGPoy2EoY6h86r8+l4WpspMZgNzrTgMZ0SfaOtkYnTU5BhoVjaKtuNv7ivOVNzxmyKACyK0VW+XS7Ek/QLevSJSP09tWvCB8pX86xq4PnHGFGIn2mylzxTdfkNHcRFECC3CHDy0q1S598m3esQCGEF3myCENcLskZJBC0Vo+boL4Vz4cpTx7eIyWOT24T5xrUcKqLfCU+sp5yyTvW92EoRjue806WZFM6o3KrQchBCUR5eccNvYlLPFkzskUcNz9LeCldxePJG8bxy45tNqxThULKh7hZ+RI+Txeqs2aMAa1D/DEqOOmo9F615HQ2tv5DUvCPPTtCnrsYy19cPqsZj7/yImIrTc5YFr5ieV1xdX+BwpFhpoQQMhLeL9UzjEFKXu3WhkvO7qG3c9dG1eCxexOn1rUnT9G1xmytF1fT9RDkt8F5V6rJQfB1tiJROdVFiKX+m4u7rDY/pxQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c7f1d8-3963-4aa6-8824-08dbdafe57ed
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 17:16:53.5812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KzlXSaweo1sJQvLwTyhauETbc9eqTxM/E+6kUekm+TV9g8wc3NEtScj+ZFj04+X6ooH/UoQDr0JxkNSVwjMJhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7684
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_15,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311010134
X-Proofpoint-GUID: dtgsV7P-lI0VJJp83ZvP2tdniHwb7bHd
X-Proofpoint-ORIG-GUID: dtgsV7P-lI0VJJp83ZvP2tdniHwb7bHd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the status of the maple state is outside of the node, the
mas_searchable() function can be dropped for easier open-coding of what
is going on.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c                 | 66 ++++++++------------------------
 tools/testing/radix-tree/maple.c |  4 +-
 2 files changed, 19 insertions(+), 51 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index fa66c0c031d5..7518b3031b2b 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -273,17 +273,6 @@ static inline bool mas_is_underflow(struct ma_state *mas)
 	return mas->status == ma_underflow;
 }
 
-static inline bool mas_searchable(struct ma_state *mas)
-{
-	if (mas_is_none(mas))
-		return false;
-
-	if (mas_is_ptr(mas))
-		return false;
-
-	return true;
-}
-
 static __always_inline struct maple_node *mte_to_node(
 		const struct maple_enode *entry)
 {
@@ -6010,12 +5999,11 @@ static __always_inline bool mas_find_setup(struct ma_state *mas, unsigned long m
 
 	}
 
-	if (unlikely(!mas_searchable(mas))) {
-		if (unlikely(mas_is_ptr(mas)))
-			goto ptr_out_of_range;
+	if (unlikely(mas_is_ptr(mas)))
+		goto ptr_out_of_range;
 
+	if (unlikely(mas_is_none(mas)))
 		return true;
-	}
 
 	if (mas->index == max)
 		return true;
@@ -6142,20 +6130,18 @@ static bool mas_find_rev_setup(struct ma_state *mas, unsigned long min,
 			return true;
 	}
 
-	if (unlikely(!mas_searchable(mas))) {
-		if (mas_is_ptr(mas))
-			goto none;
+	if (unlikely(mas_is_ptr(mas)))
+		goto none;
 
-		if (mas_is_none(mas)) {
-			/*
-			 * Walked to the location, and there was nothing so the
-			 * previous location is 0.
-			 */
-			mas->last = mas->index = 0;
-			mas->status = ma_root;
-			*entry = mas_root(mas);
-			return true;
-		}
+	if (unlikely(mas_is_none(mas))) {
+		/*
+		 * Walked to the location, and there was nothing so the previous
+		 * location is 0.
+		 */
+		mas->last = mas->index = 0;
+		mas->status = ma_root;
+		*entry = mas_root(mas);
+		return true;
 	}
 
 active:
@@ -6613,7 +6599,7 @@ void *mt_find(struct maple_tree *mt, unsigned long *index, unsigned long max)
 	if (entry)
 		goto unlock;
 
-	while (mas_searchable(&mas) && (mas.last < max)) {
+	while (mas_is_active(&mas) && (mas.last < max)) {
 		entry = mas_next_entry(&mas, max);
 		if (likely(entry && !xa_is_zero(entry)))
 			break;
@@ -6695,26 +6681,6 @@ unsigned int mt_nr_allocated(void)
 	return kmem_cache_nr_allocated(maple_node_cache);
 }
 
-/*
- * mas_dead_node() - Check if the maple state is pointing to a dead node.
- * @mas: The maple state
- * @index: The index to restore in @mas.
- *
- * Used in test code.
- * Return: 1 if @mas has been reset to MAS_START, 0 otherwise.
- */
-static inline int mas_dead_node(struct ma_state *mas, unsigned long index)
-{
-	if (unlikely(!mas_searchable(mas) || mas_is_start(mas)))
-		return 0;
-
-	if (likely(!mte_dead_node(mas->node)))
-		return 0;
-
-	mas_rewalk(mas, index);
-	return 1;
-}
-
 void mt_cache_shrink(void)
 {
 }
@@ -7266,7 +7232,7 @@ void mt_validate(struct maple_tree *mt)
 	MA_STATE(mas, mt, 0, 0);
 	rcu_read_lock();
 	mas_start(&mas);
-	if (!mas_searchable(&mas))
+	if (!mas_is_active(&mas))
 		goto done;
 
 	while (!mte_is_leaf(mas.node))
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 57964aec2122..182f4e4d9967 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -974,8 +974,10 @@ static inline void *mas_range_load(struct ma_state *mas,
 	if (likely(mas->offset != MAPLE_NODE_SLOTS))
 		entry = mas_get_slot(mas, mas->offset);
 
-	if (mas_dead_node(mas, index))
+	if (mas_is_active(mas) && mte_dead_node(mas->node)) {
+		mas_set(mas, index);
 		goto retry;
+	}
 
 	return entry;
 }
-- 
2.40.1

