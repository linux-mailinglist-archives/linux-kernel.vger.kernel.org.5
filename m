Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F160A7B3B0F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 22:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbjI2UOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 16:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbjI2UOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:14:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708231B3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 13:14:33 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TK5bGX024213;
        Fri, 29 Sep 2023 20:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=B0vc8HXgGKSTS/btSb0FM7YS5/Uvr8tFcjGw0oLWAcI=;
 b=mAUS/jGEB6rGOEDhBblOVTOjCRrysfFkTXjURJpIJ5UtR/OnK+B1ksAXc+JT9KYAG+SV
 kH2wEF7+r8zrYU4pVraRh5QG3zN0AdJ4Ce/pjr9Kw2klf4A2zn40DEYWQpcFwDfEIGKV
 5OdTdaoDyeVbR9oL3ypE7KZFFj5j2M+KL3JIEp3JZyYVqRfnVYbcBKNCoVGGtzl9fPXn
 xMs90fiDsnCAKlhDiiQqlDPyNu2Q7aJq7rgYU7QakLB6GQS16jtEWs5cWNUQ9NPKyqDm
 P9mAYjmalmCOV/dkbQLlb9ZGka5aeiOp7MomT87ruJSGE24xzZ6RYrUAfPgXsdDez8Od GQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pm2fn4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 20:14:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38TJfh1s025439;
        Fri, 29 Sep 2023 20:14:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfhtm33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 20:14:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgNja/9MZQOPaB164CCoq0ve4eIx2m6+UYllkAx1Rf/fDrv9dLns+rfiqeHSHT0NkPedLOmsH+Fdc1WtJPo6T6vqCHQ98DjAb+kGRau2qFSgGdfOTavUMsWiUQa19sk2+kL+KXuRDFqYMwDC81JWxOQ0s6vLjtb0ggwJZeIHOBO76BUchVOPZFFckfV0Q0zYboAje0M0ipGziT4CvF3tSVSB1vxjD3ldXaxSsZavsHgEguk5Bm236RFAeHMQCsA8hwVyzoO11IzTEZLCW1h2t2uKOWZedq2mWs2/jqcqC5oEINUFSaubZODGZeLAzXYY5U139dGP6WLmn4JIRr4dHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0vc8HXgGKSTS/btSb0FM7YS5/Uvr8tFcjGw0oLWAcI=;
 b=aE2B1i27H6vjfZEFx160msZ82boo0c1oGX0G65zC7sT+yYkZZmHAGYCKGQLnN2SuWPLIt6IIHn93e0cFrezps/DBeNPHBOvdZAVUrAKxdBdf5g7FEI3kFVK+8jgny4QNDCaK9xJpUtBuWZaayxiceWbT52I0jND/RB3Eu9mxZIfmJ6O2AauxNnRs4U28FkfXOxfzjtOWd+T0GKJeM46fo8vupIwZxISC7hVbc81pppfcNTqXcdmPuNBSYFM9yfJuypnTKumDh0zxrBcDnDmTxIeWsshf/fDZBm/fW3VHCizjzyzrVZk6/GORe4Jmv/IqhW+Q98xdzEz1FFRNqX7Kqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0vc8HXgGKSTS/btSb0FM7YS5/Uvr8tFcjGw0oLWAcI=;
 b=GJiR58AYC+LWRG02FEApd0MwgiDXIXFVffD2s9pQxrW2l9GCrQRE8pVXozF0njoueXMGAw/N4CodN0jQRw3Sjkvp9L0kgpxtQf1SITHEpC+5FiZwIwEUXfyQGXIoJTBo/IirhNFIq3w2ZGPN7ixpLKI7HrdRPaOyrOEk4BM+kps=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH3PR10MB7632.namprd10.prod.outlook.com (2603:10b6:610:17f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Fri, 29 Sep
 2023 20:14:19 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 20:14:18 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] radix tree test suite: Fix allocation calculation in kmem_cache_alloc_bulk()
Date:   Fri, 29 Sep 2023 16:13:59 -0400
Message-Id: <20230929201359.2857583-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH3PR10MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: 767f9c9d-e0cf-4b60-10f2-08dbc128a96b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8XBPrGm6gBuKb2x6yuXW3TBCgFSbO13NkwWmPimOr7qjUFxTChn2PM9hYjzrWImeE9lV2fTgTFwVZrN7R81cZN+wXlnJI+0yZ1X5QRy7JKoUxYreyHv6zHjazCEIPSaIuDllqoRNyS8jDjGPg+nBzlJiN/E0NfRdx4lL2lXcpG+68G37bnJQBmii8blWFyRFhwsusziqoy8MHrqUwmqqq0GObsvOEMZlUTzJlPSDbF3hxfrpjgo6d0PwGFqCqvLEJtm/qV4ZNzaCn8YY11WRywq/PW6ayn9vzJFncZU1+WG+rsciKtvIavBqTdHeDcPnuPLViAKemUJmQUS0o+SREd8JWdH3/doR7EQAGVa+lEu8/yRtQaMOmR+kZ4Fdwy86jCTZzBsU2ZAQzWfNyMfhF0HS7XLesZ1LaMM3n7cgl5m4HrAyFHlaiDIB6khVpedeisKsLlOSbeywkpGF976i+losfB0OiU2ffu5gsBatugvROcUKlreVQV9Snhp5YEx2vklRo/kDDDoDGX5QoPsZkDwW73T3P4ry5Bgr/XjpSHL3n/6Jcz9rYp/Sf9ZWkzMV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(36756003)(86362001)(6486002)(66476007)(6666004)(4326008)(66556008)(478600001)(66946007)(5660300002)(316002)(1076003)(8676002)(2616005)(6916009)(41300700001)(6512007)(8936002)(54906003)(38100700002)(26005)(83380400001)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VpuOaITcY1Owg9ur19wF3DBkK4y9aUP4GqFf9oa7iUl4jzDLJ5Oxto81640u?=
 =?us-ascii?Q?RjUHn0KQ9uCBmnzbcRxUkjC8yPjrGLqpp2OJbt16xGZllsCR5j1huej/bs1B?=
 =?us-ascii?Q?W5qpJewtwNVXN9zvLPPJmVO9Rw99SdC1uP/3ExHYmYbzV0p1gJw2B16U+FqT?=
 =?us-ascii?Q?K+HDC7GsGx06cvFrY7qbvcvtnKNvejfpzB8u5y+4vNQVLSzIDLEbK9LeCvQa?=
 =?us-ascii?Q?s0YAvfbZtLxj7v2hZViADLU8uVFgE8Mblgsb5q7uWRLyMKyuwwNwAhd5K+iZ?=
 =?us-ascii?Q?Un481vWmGm9KMle/B618ANX00zaUj+tw5tCnubOGL43+8C8bJmKxgxlGPsab?=
 =?us-ascii?Q?Ry4iuDA1d0K7k2kfqKssv84gNgChFE5pJhTbVQdpZAYY1607cnzDmAtBu78r?=
 =?us-ascii?Q?yZCuPrYqZXZZc9b5CMU3rGZXkoHlQzr/9+74v1S7h5AvxlewgI2By2j5ktQ7?=
 =?us-ascii?Q?cfFaO4qamIDXe4YuDDu6UFOzETVfBjg+68VwSEaR15keXl65IuXCMIcpYJ0s?=
 =?us-ascii?Q?JvcV8u5SeNhypoMA+8wkhGtT1GUB6v7SXHc9mmohR3pCUBUQEBTuifi2wPzT?=
 =?us-ascii?Q?nEhu54bdv1ug20tYOy528jrej+hZ45PWfCQqTEH69/hu134PptQWn00xDgqS?=
 =?us-ascii?Q?1F0an/Xc6QPk8zhy5rhMKhfUgxE7cpHV4bSfrMWAz6vFAGGNd3vaO7P22HOc?=
 =?us-ascii?Q?voI1pvfzTBgRkvG3XSgLmz00LNCVcTJoCgUih+GyPajYt1w/62KBstShgFII?=
 =?us-ascii?Q?MxyzXvOhyk0GpIxn+PXPYrOVV6bymqfCI3ucBTkbFFy7pJwpgp0qr5VkFz/H?=
 =?us-ascii?Q?rd2YDTPRYjHv8tRoKbi3EFdDaqB0vxzpa2NK1/ykZOTgfzP07JRAxKOZaSlv?=
 =?us-ascii?Q?KiBV3s2k0/AQZ0aF9m/3gb/xzo0HYC23PQTcsnKI/FAU3BdiSHNEuqagm5jo?=
 =?us-ascii?Q?GasZ+SNxB7XV1qDqVShvZYJpDtqxenAsR5C86HNI3Qfz+nGHf96WcZMRl15C?=
 =?us-ascii?Q?mC7F1HT3XKUL7N9lsRWxUvliGI4yprViffS1qYh/Rb2/4h71k2LJ/e57pNGX?=
 =?us-ascii?Q?anbscRhMm47VHJHPXzvPzgvc6TYg28/fQTR62xVI0twi0IG/YtUTiscxLtoc?=
 =?us-ascii?Q?sbYbgK1ebeaEev3T7O4AX1NtiMLHGVid7NpfhCmgpZq+XuUxN1yGZrKGfAfH?=
 =?us-ascii?Q?UVClENR5CT5nLS+bjGrOPntG6CEtEC8cKfGKuu9qLXV+cj6+dy4YZLrpT5XT?=
 =?us-ascii?Q?rCaIdGVbYkrFQkqvL7jFZuaqu4/tL8VMbCFqJuz3myqZjxPBSVTp5aFxOrQq?=
 =?us-ascii?Q?ar4tIDCLsf7qzv1wr3ysXsJn6kfvPpNOtM0EmrMPCYcF6NXcU24emXzoILqT?=
 =?us-ascii?Q?mvtrosAPPLJqFUbP4TKsZN0h8UibBzLVLxjdmRvVPnFOe9eUGay25BSr7sdu?=
 =?us-ascii?Q?Vu1sqXMAiLF5AWHaArtip1BHgvji/+BHRSv+y08IZTPQFtlRJ0XqYRUUOEO1?=
 =?us-ascii?Q?t8aWk558xltol1i5djKvro7lOcnf644qI6GBzkaOsidBph7IjVCL9glY3Cf8?=
 =?us-ascii?Q?QfxECD/1DOsAbybVU2Nrh9W72gN+eGTbduIL9cccxKDMZufkjwbqQTQ6mADI?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZuiyQFtZSuXKCl68s1USKsJg4AzakQKqN6zHhYc17DNFKUO0D4+NKuK6WgzusqiXhkDqSVy9SF9hr1gJmrj9A59D2HbTBQxRrv40kqB2nvOWq3qDEQ1FV2IVMht/+1AXS7KAhOTb5P21sIBkznToHHZJwT7mm1IvqTM0Zjg3JKu1h3AQn4WXVOAvII1FbHHausQcm31+9UjlJ0GgtyTIsr5J4k2jl9f9NGjMbWs/OyTEkJFVQbe/F1cRFhxCZ7Ma7RFppKCX5eeaG0xJc0dlx5huBtmuF3CMsfn8Hf5OOmX1SbIUI10ZAcaBiGjyxCqvQyvzONenYTvi4G7skAPCVriCVsna1l6QID/5wgCD8ELdA+POacHs0/aR0j0eHwZ7BB5rpY1XLS5eNL84oZ8eUaeNq+cgjXVGVNgqv816vfF/1z0FgKXfSQYj/MMYwPXT3NsvrP6oi+KdkribkDDuu9JSbKuqB6wBxweepqDPHYIhQmAA8PJ5Xr9d0UaBd72qWpIY/T38RyKgl1dRjO3CwWCaMAm1F02/A/xSZPwTJ2RyhZ4mMCtKRZudolOPpGg0BJbzAOy9eNGmoo+gC47U0LuFSODg9hf2qHXj3Wo2nvst9TgB2rTO0SFPxxeGwDa5j0xO2sXESylLvEinMU48Wh7OR7Qg+tQwJbNJdldYo4hoxNwnsCSNRW5mRe1yyNs/UkBAKilImZWqX5Uxqa7wCLVcndG8w25d13FmokqIp0/49cHwyChE0FGBzOIaGNsjQ8+/yMk/nLplK1Yb90v/IZqgdavzldT5td611BznghXT//Yp1y61RBrmfT22hlMsYcS1ArauOob+EMhD6Ch1aw9xFjZbbuMxzmzjdRSAZNme09MKKgHzDLlRlsw6jY5He37kd4JtYwGdL9989MJSF/qbWf2B08woI2NO1w3BMNc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 767f9c9d-e0cf-4b60-10f2-08dbc128a96b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 20:14:18.9176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mnsk4G3g3/DAipFqLoL8+j9C2TXRbaP+3JD9M7e2npjwyMR13tMd/0agPM8lPFSGhbcLSGG4Ymeud0M6noY0Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7632
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_19,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290173
X-Proofpoint-ORIG-GUID: ORhiWVTHclDtpXVZQG68CrNiLGf32f_k
X-Proofpoint-GUID: ORhiWVTHclDtpXVZQG68CrNiLGf32f_k
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bulk allocation is iterating through an array and storing enough
memory for the entire bulk allocation instead of a single array entry.
Only allocate an array element of the size set in the kmem_cache.

Fixes: cc86e0c2f306 ("radix tree test suite: add support for slab bulk APIs")
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 tools/testing/radix-tree/linux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/linux.c
index d587a558997f..61fe2601cb3a 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -165,9 +165,9 @@ int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t size,
 		for (i = 0; i < size; i++) {
 			if (cachep->align) {
 				posix_memalign(&p[i], cachep->align,
-					       cachep->size * size);
+					       cachep->size);
 			} else {
-				p[i] = malloc(cachep->size * size);
+				p[i] = malloc(cachep->size);
 			}
 			if (cachep->ctor)
 				cachep->ctor(p[i]);
-- 
2.40.1

