Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D197DE533
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344936AbjKARRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344812AbjKARRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:17:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0762B127
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:17:06 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1GYm0O015703;
        Wed, 1 Nov 2023 17:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=1dAm2IY6S76iRSV2OMRaShLmUy/paB5xYnsJIyEkzYs=;
 b=wSAP3S5qbr1v4xMrT0Q2Cxsti2cRl2niYlb2C5Zc5DrsjDeODzuFi5oEBp45hekpvrxX
 I5cujvElo8hKAgNh+cmeO5aqsPeEt6pOfY3ih7iGmWZsl4xI0QDyf3KMFsT/7jR+XRfQ
 b3TU5wyaTvZJKdPtW3j/E6QBi8O43SqVsl77h7W7JAtDw6vN9FNS4qUOrqDS6aXuvW/1
 9gdMorIGCQbM7FLl55d0BPPspTNPCbmorMr/KVZSnAPLwrywq1C+W3d+HmkkBi0PUgtK
 RslWSs+8W3eIWPv+rD2Cf8JbGotyOnc4GTBgO97un6WnS1Iy5VI0BenztEiEF8U6JPom mA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0rw27wmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 17:16:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1FoQ7d020069;
        Wed, 1 Nov 2023 17:16:57 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr7d2va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 17:16:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uwcrp9j/P5ly5AsSO9D+R6X4Xhw6yUNUTXxoXrKjlbkwbX3v+sVvzZik0pmAMICHm9nT8QtfUQsNi0YYCjqcE91waE2xcYj/2M9S/gHoPqYHwYgMMTIOE+G8XzA0ElX3RGXYDOkXfT/tB3pKgt6JjI5nsnAAarUDp0HYgFnpcf0XhJKNX3HyFFdYvYPQGlNRj+RkjDNlpR+1FzlQ4LJE71FVEH1/MDoWq8qI3n8FEg58J9GoyToVgoWgCBFGgC+HD/eESo8FCieiL9V5tDURP4FyBforP2YDdpJ8FaHni7zhXAyNaA47I57bEG5mUq4XR6GgQuNw5qeqj5VSzce6og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dAm2IY6S76iRSV2OMRaShLmUy/paB5xYnsJIyEkzYs=;
 b=X9F+RPn9QbmMyrlkWEMwp1ExgsaV7ghFwadJxA7ODe2/NWi9VJzaw1k2RX2byPdtdabQjDyhVliBCg2cSqJGpA5meBZRdAH5Dqe6LLQQX1XMH+0FAzt90qCUvpznjPwxs8bFSHorweO5gtF+onxyV0CwjZHYgc2s/F8iD3/CSeftM5zzEgyLhB100QPtzxHH17QH0tgPTUl3+3MncTT9hc95QQSQKperUepdB7NRTPe5mwx2WN4Q8Ss0MyBUwZ1PuNBpsBFkvhogWNFIgjnP8Rq95AcQ5r4xKHauvYnQlS1cp4/u4LvjLXKXok6D1u7EeNEYMK6zfCoDi1fbIbeKaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dAm2IY6S76iRSV2OMRaShLmUy/paB5xYnsJIyEkzYs=;
 b=PJeXBIdcUuk52b/CgX/FvvjglaBilZ4Il78+z8UNkP1zQvaLVxOXoGJm1UMhd64CYY0HWlyMa+DR9YB3sjJhtDFYwNNadIxnJCoMOvoAvFgg+wvLRta+2GopTaxZGB6E2/vS+ByjAhcmRLvjWiNNKmEjU8aVu5/HvPbfdjb7I3Q=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB7684.namprd10.prod.outlook.com (2603:10b6:806:38e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 1 Nov
 2023 17:16:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6907.025; Wed, 1 Nov 2023
 17:16:55 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 10/12] maple_tree: Use maple state end for write operations
Date:   Wed,  1 Nov 2023 13:16:27 -0400
Message-Id: <20231101171629.3612299-11-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231101171629.3612299-1-Liam.Howlett@oracle.com>
References: <20231101171629.3612299-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:408:70::38) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 7382250e-056c-40de-8f8c-08dbdafe58f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ty7oezMiHR9l7bj5Plgi1NLy3omI52Tsb5YyzfLa5zNR+1LU4A46STSpSq3S922hj1Y/Zqi2Tzf8QspDbgerp3mWACmWpsfplVWXb4Gs3LlqbI5RPvuOrjCb2PxtIW7oDpuQ8ORcBNzVMTdGsoZC8ZkVf3MV3kFLDhoRbZDz/shhN8g7uEQHjXvI6vAQg+yA4zdit7Nib4MFnkZEkBWpbY2AReqPUf9K6xw2dXpgzwQ7kO4CbX1R/HLORhBY2SeXjWFQyFH2BXRm3e9KR8ivLNwvramSx7OzBaVI4qgeIMGuVS4J6nyYJfriyrVHuGFfYALd7Hr/Y74tDolpKvHNA8aP7dCraw7nonpjFDQJhZ5rMcbEEY/lYi0guMLTSSjKGn34JuC6GmQX0zZm+9cj8HtYdAU+dbZqAvx2EM+gtHZB5+W/o2+taOmKT3rAIkQKw2rGm+TdfPp1Uq3UpfWClq/EH8fNNjzjZZ5WI+3W5tggzziIbl9surlhUd4fKv5n9FJoYguLBJOJ2ayQF4GcGg6C9zEl7ISCmr4iEbjtY1mN7Iill6ZILAIdiG/tETnS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6486002)(8936002)(2906002)(4326008)(41300700001)(8676002)(5660300002)(6666004)(6506007)(66476007)(107886003)(83380400001)(1076003)(2616005)(36756003)(26005)(6512007)(38100700002)(316002)(86362001)(478600001)(66556008)(6916009)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PG0Kg0oqrWS6y0MINncurvE4Jcp/gKmOwTK5D9wUzc1APZBQ7cG8hG73LCUH?=
 =?us-ascii?Q?bIAs5+nnwJbPOj/hINH93FL5MxtGsgO8m+h4fhqYNm27tEznB3g4pi1ZBfEH?=
 =?us-ascii?Q?6FdcY3d45x5gKuxK0zP7X+LBkFUT+OuON1dGD+pC6OIMEYbIW+A83VySpqMm?=
 =?us-ascii?Q?XXxxqrVS4naxFs1UBLLAz2b7Df0I51rtX2i5aj6V8bn0aWfmpoqRl4Kd/dKG?=
 =?us-ascii?Q?XCKShkcJM2sLdXoFiPYxPzC6XxX+oVN2QGxrBfAUc5wIIVhYZY5BK3hImTgA?=
 =?us-ascii?Q?UIxBiItCoQO9RvwwAB/uXTdRd2m1OAWf2jqUAjWpt0YAnxVrzgOrjH5ox6Mk?=
 =?us-ascii?Q?G1QQXHO51cLlZ9xpZXNiCTSKyNRinDNZE3fv7WB71QbvwLA5mhWMdmfHuvCX?=
 =?us-ascii?Q?59Z0d2Va7h8aBBZN7RWWsvWQq0fW4un0smsNZ1wjHzEYckeqSES43mNNNj9U?=
 =?us-ascii?Q?faqewyhxkmh9F/JdRKrlo4TASTaqaEnHccxqpFsRHr18FlfHa0lVDgk3U41z?=
 =?us-ascii?Q?mR1CQfsKQwFGH6VuYVFQPPfqolf06d/6/MLK70c2JcB4yo+4e04RUWZvMOFz?=
 =?us-ascii?Q?mpYP4mYhdynKoU2oodYVL5PZ0PvndBxlqwv35nThKy5vWdLbokExz+vEpK81?=
 =?us-ascii?Q?eTGCc+rqaRy6vatezQoqPz7tv8UccWx/xvXBYEIItz0EARzByKwdUS7LeOom?=
 =?us-ascii?Q?+mUcNJN033GgGKXr8JbVNfQKj6f0OnxKw5J7U25kJyIGmA5Tc0WY0RLcyT+j?=
 =?us-ascii?Q?jF/YQGjB3bDXn8vg1ju+yO02N8WX9+m7ouWGFB7XErOP7Eievq+gMuZeh7Jr?=
 =?us-ascii?Q?3UtgPnhDOFwpm76kY4FDHUuXuZnwMqpcqOhJViiMms18paGNbnBVAxg9bRUm?=
 =?us-ascii?Q?iLEv1LHzLJf+Hw6vmTDoNPsWezuynU4wYM+w0YdvEv/S+7bp40BrR+MmqngI?=
 =?us-ascii?Q?PNFTjBNQ8iXzovgPSYfjE71msiDAEntJKe7+1y+o++AxhIXcsEggxqYdOrKo?=
 =?us-ascii?Q?uHuguat54/hLg519kq/noo2wHrtu7UPwHxpol27JO9iadUSg40jMYnqDcNHa?=
 =?us-ascii?Q?mhN3h/IfLLn+CavVgXfpwnA7IV+UHlmWJWnqraf7SELdpdSwSpMLe8OgPwzL?=
 =?us-ascii?Q?4NDqajylTYuDYX3pz5jYpjsrxz4LYgfoJac2fUOi/FonuP9ks8z/6hcbGKbG?=
 =?us-ascii?Q?UFb+Ks9uXIWz4KtoNsoZeTxyknLh6bp5rMyrpBjzcHRMnyrUG3nIiEL6nIZV?=
 =?us-ascii?Q?/SObEd8OlL9UwTsTXKev+CSoRDwuQbT82CNZZf+ECjNdF/4Hg2ZeUQ7owm+q?=
 =?us-ascii?Q?kz1Nmfc8+eViOBOycc4crP5Jg9XvzVOgYS331gGLTLcqjMl7j7a6cubdh8hi?=
 =?us-ascii?Q?naT/AOVy8h3p3Efup1HyDIeALV8UhXMkFj6BmLKKjO91JgPZLM0cP63/z+VZ?=
 =?us-ascii?Q?d6XztCKY+geAq0U+VBNSy7hcLvsEKjwS+jslsNYdP/Lo2WuelbDQzM8lPiy6?=
 =?us-ascii?Q?Rdme9fJD2YW/uA4ofeKIHWJjgBQ4Jn1DFwnGJRpR47sR4tdMPYrfM14q0S22?=
 =?us-ascii?Q?0PPQoe9XOmA6BV4CrpbshwLReDh+jLyHF+DBiRbvUnJitEmXwgW3oZc5EL7a?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qndgbBzZcEDoJckjehROKqNbuIHhqjyzqcwz3KIv7AeWF3cxQzjtS1cU/5v8HEQeA7Mc/7lKcMFqE9hfm4dwO738th73ExNKCwOX90sHBeJLvuHOJJWM+1r0/OTcoVgA79ouwCKKfZpmofR8DDMEVWf2MicPT2RGEt+tmg7BO76SvUFGAmwv17W1RxqfkJGZz4Ee/xDuIFNEKWUDWuef4g63MS4HWP0iTYvNnS7SDdRHZ+ZUrdzxm3KjGWjn0bDirS9UFeO3Oyb0vNuNKbkhXpWUjaYOdwLuLJKCxQr9DXOiVuAct4/FBoELL+5poIbo6F6zhXT5MCtDIosCIOzWEdSFKusc9la97bJIeuK/OMy2lw001ogv0NlB2B5/3uypYeZk3Mm2AyILXqdWD/ABEKtK+7u7oRQ9w9vSCJODSz+qY28Winen6FbrFfc9HHD3UHZK5pqpJyo4c4zMFtFY0MgyuX8oT22ftQfw2lQMCHHlUqRGM4ZjZFUrQY6apSlrlujSVP5b77MaGrFcggCvznt3SMUi5Y7GWfJSuJVmCnhGy99EudegXZsGNGurIPXOuz8P4gXVCueWTSPZX9ARuAZ9egkudviu/9zECYL49e/Mtnc9cdNW2g/ambTsXuNnOGfgMLkI03q6WaajoX1ztl4qcMScvwPzPHim47mQEUgDHbjaUZWy62LOqSCoqjo5lwGuxoVbWTQz1dkhMNyYr51H336Su4EuByH4XLEO3CPqbGKE0FT9Z+sgAjHXBFF3b0iPUmHDUYb07wDxuBUQLqyeROPgSIwvd8NWUD59YenOJiuwRt9a52FV/EcA+3DZ3LT+LAIPb05rXFW8t3pcX2kvkxAD1BcRpo+RNMkJ7hmLe69mYFYY/lzAlbNbJgGi1WTmD8OA3g/Ua2wHd3i9oQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7382250e-056c-40de-8f8c-08dbdafe58f8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 17:16:55.3241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQMUkBYL5gXsY+dL7NZ7ROASKaWPO+Tg884iXpUuQSu4xagfFOHOLqURQ4pQ5hxJ4iaPsIin4mQec37zOijVYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7684
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_15,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311010134
X-Proofpoint-GUID: BAgncjolK9pHNsyI42CSEnr1fJU4w6pM
X-Proofpoint-ORIG-GUID: BAgncjolK9pHNsyI42CSEnr1fJU4w6pM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ma_wr_state was previously tracking the end of the node for writing.
Since the implementation of the ma_state end tracking, this is
duplicated work.  This patch removes the maple write state tracking of
the end of the node and uses the maple state end instead.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h |  1 -
 lib/maple_tree.c           | 46 ++++++++++++++++++++------------------
 2 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index e3789b63388a..31ec1859e135 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -436,7 +436,6 @@ struct ma_wr_state {
 	unsigned long r_max;		/* range max */
 	enum maple_type type;		/* mas->node type */
 	unsigned char offset_end;	/* The offset where the write ends */
-	unsigned char node_end;		/* mas->node end */
 	unsigned long *pivots;		/* mas->node->pivots pointer */
 	unsigned long end_piv;		/* The pivot at the offset end */
 	void __rcu **slots;		/* mas->node->slots pointer */
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 7518b3031b2b..e45734676471 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2146,11 +2146,11 @@ static noinline_for_kasan void mas_store_b_node(struct ma_wr_state *wr_mas,
 	}
 
 	slot = offset_end + 1;
-	if (slot > wr_mas->node_end)
+	if (slot > mas->end)
 		goto b_end;
 
 	/* Copy end data to the end of the node. */
-	mas_mab_cp(mas, slot, wr_mas->node_end + 1, b_node, ++b_end);
+	mas_mab_cp(mas, slot, mas->end + 1, b_node, ++b_end);
 	b_node->b_end--;
 	return;
 
@@ -2243,8 +2243,8 @@ static inline void mas_wr_node_walk(struct ma_wr_state *wr_mas)
 
 	wr_mas->node = mas_mn(wr_mas->mas);
 	wr_mas->pivots = ma_pivots(wr_mas->node, wr_mas->type);
-	count = wr_mas->node_end = ma_data_end(wr_mas->node, wr_mas->type,
-					       wr_mas->pivots, mas->max);
+	count = mas->end = ma_data_end(wr_mas->node, wr_mas->type,
+				       wr_mas->pivots, mas->max);
 	offset = mas->offset;
 
 	while (offset < count && mas->index > wr_mas->pivots[offset])
@@ -3894,10 +3894,10 @@ static inline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 
 	memset(&b_node, 0, sizeof(struct maple_big_node));
 	/* Copy l_mas and store the value in b_node. */
-	mas_store_b_node(&l_wr_mas, &b_node, l_wr_mas.node_end);
+	mas_store_b_node(&l_wr_mas, &b_node, l_mas.end);
 	/* Copy r_mas into b_node. */
-	if (r_mas.offset <= r_wr_mas.node_end)
-		mas_mab_cp(&r_mas, r_mas.offset, r_wr_mas.node_end,
+	if (r_mas.offset <= r_mas.end)
+		mas_mab_cp(&r_mas, r_mas.offset, r_mas.end,
 			   &b_node, b_node.b_end + 1);
 	else
 		b_node.b_end++;
@@ -3939,7 +3939,7 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas,
 	if (mas->last == wr_mas->end_piv)
 		offset_end++; /* don't copy this offset */
 	else if (unlikely(wr_mas->r_max == ULONG_MAX))
-		mas_bulk_rebalance(mas, wr_mas->node_end, wr_mas->type);
+		mas_bulk_rebalance(mas, mas->end, wr_mas->type);
 
 	/* set up node. */
 	if (in_rcu) {
@@ -3975,12 +3975,12 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas,
 	 * this range wrote to the end of the node or it overwrote the rest of
 	 * the data
 	 */
-	if (offset_end > wr_mas->node_end)
+	if (offset_end > mas->end)
 		goto done;
 
 	dst_offset = mas->offset + 1;
 	/* Copy to the end of node if necessary. */
-	copy_size = wr_mas->node_end - offset_end + 1;
+	copy_size = mas->end - offset_end + 1;
 	memcpy(dst_slots + dst_offset, wr_mas->slots + offset_end,
 	       sizeof(void *) * copy_size);
 	memcpy(dst_pivots + dst_offset, wr_mas->pivots + offset_end,
@@ -4067,10 +4067,10 @@ static inline void mas_wr_extend_null(struct ma_wr_state *wr_mas)
 	} else {
 		/* Check next slot(s) if we are overwriting the end */
 		if ((mas->last == wr_mas->end_piv) &&
-		    (wr_mas->node_end != wr_mas->offset_end) &&
+		    (mas->end != wr_mas->offset_end) &&
 		    !wr_mas->slots[wr_mas->offset_end + 1]) {
 			wr_mas->offset_end++;
-			if (wr_mas->offset_end == wr_mas->node_end)
+			if (wr_mas->offset_end == mas->end)
 				mas->last = mas->max;
 			else
 				mas->last = wr_mas->pivots[wr_mas->offset_end];
@@ -4095,11 +4095,11 @@ static inline void mas_wr_extend_null(struct ma_wr_state *wr_mas)
 
 static inline void mas_wr_end_piv(struct ma_wr_state *wr_mas)
 {
-	while ((wr_mas->offset_end < wr_mas->node_end) &&
+	while ((wr_mas->offset_end < wr_mas->mas->end) &&
 	       (wr_mas->mas->last > wr_mas->pivots[wr_mas->offset_end]))
 		wr_mas->offset_end++;
 
-	if (wr_mas->offset_end < wr_mas->node_end)
+	if (wr_mas->offset_end < wr_mas->mas->end)
 		wr_mas->end_piv = wr_mas->pivots[wr_mas->offset_end];
 	else
 		wr_mas->end_piv = wr_mas->mas->max;
@@ -4111,7 +4111,7 @@ static inline void mas_wr_end_piv(struct ma_wr_state *wr_mas)
 static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
-	unsigned char new_end = wr_mas->node_end + 2;
+	unsigned char new_end = mas->end + 2;
 
 	new_end -= wr_mas->offset_end - mas->offset;
 	if (wr_mas->r_min == mas->index)
@@ -4145,10 +4145,10 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas,
 	if (mt_in_rcu(mas->tree))
 		return false;
 
-	if (mas->offset != wr_mas->node_end)
+	if (mas->offset != mas->end)
 		return false;
 
-	end = wr_mas->node_end;
+	end = mas->end;
 	if (mas->offset != end)
 		return false;
 
@@ -4200,7 +4200,7 @@ static void mas_wr_bnode(struct ma_wr_state *wr_mas)
 	trace_ma_write(__func__, wr_mas->mas, 0, wr_mas->entry);
 	memset(&b_node, 0, sizeof(struct maple_big_node));
 	mas_store_b_node(wr_mas, &b_node, wr_mas->offset_end);
-	mas_commit_b_node(wr_mas, &b_node, wr_mas->node_end);
+	mas_commit_b_node(wr_mas, &b_node, wr_mas->mas->end);
 }
 
 static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
@@ -4228,7 +4228,7 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
 	if (mas_wr_append(wr_mas, new_end))
 		return;
 
-	if (new_end == wr_mas->node_end && mas_wr_slot_store(wr_mas))
+	if (new_end == mas->end && mas_wr_slot_store(wr_mas))
 		return;
 
 	if (mas_wr_node_store(wr_mas, new_end))
@@ -5032,6 +5032,7 @@ int mas_empty_area(struct ma_state *mas, unsigned long min,
 	unsigned char offset;
 	unsigned long *pivots;
 	enum maple_type mt;
+	struct maple_node *node;
 
 	if (min > max)
 		return -EINVAL;
@@ -5062,13 +5063,14 @@ int mas_empty_area(struct ma_state *mas, unsigned long min,
 	if (unlikely(offset == MAPLE_NODE_SLOTS))
 		return -EBUSY;
 
+	node = mas_mn(mas);
 	mt = mte_node_type(mas->node);
-	pivots = ma_pivots(mas_mn(mas), mt);
+	pivots = ma_pivots(node, mt);
 	min = mas_safe_min(mas, pivots, offset);
 	if (mas->index < min)
 		mas->index = min;
 	mas->last = mas->index + size - 1;
-	mas->end = mas_data_end(mas);
+	mas->end = ma_data_end(node, mt, pivots, mas->max);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mas_empty_area);
@@ -7304,7 +7306,7 @@ void mas_wr_dump(const struct ma_wr_state *wr_mas)
 	pr_err("WR_MAS: node=%p r_min=%lx r_max=%lx\n",
 	       wr_mas->node, wr_mas->r_min, wr_mas->r_max);
 	pr_err("        type=%u off_end=%u, node_end=%u, end_piv=%lx\n",
-	       wr_mas->type, wr_mas->offset_end, wr_mas->node_end,
+	       wr_mas->type, wr_mas->offset_end, wr_mas->mas->end,
 	       wr_mas->end_piv);
 }
 EXPORT_SYMBOL_GPL(mas_wr_dump);
-- 
2.40.1

