Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65717DE52F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344755AbjKARRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344700AbjKARQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:16:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CBD110
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:16:55 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1GXuud011814;
        Wed, 1 Nov 2023 17:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ZdX1fiC+1NdK24ymn8z7XPYiVF/UCpV2tVDYA6xfIto=;
 b=K9y7BguLRYf34FIlFl0ACzpwqi9cDKA8BYISk/Gf6eAF3vHKMnUDK1BuPgVpA4s5Po39
 qqvp+nzhfhB4fM8XLne0zD+UK4jxz81E07DYAimYmA4rId5YMH9qczNsGUaZqMOrHh8j
 pTxSa7ZmwEU1ZvsdsDeuvY37DXJgIul53vGnVGm2BxK9NRSsrarXHNVhEFwnJOhwInvM
 M0i1bv6BCxGZK8akmyMVlabadcPOV9fEvje98LdzHwurSRUKNF/moSSU+KzWTruB1hPS
 8LZjW05yrlcHYKKUByoeAFbWc4BLllhGMpNKb0N9Ch5dKZMl/7tv+JwkQPsvfSJFEPXk wA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s34044s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 17:16:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1H5Ckg009234;
        Wed, 1 Nov 2023 17:16:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u14x774p5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 17:16:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7fOPkDASTfcIWU9UTZkBkoP5sS5t18Z7nKIgxD1KDhHaiLf2Ws1ag2d1d2caCNBgDuCvog0EaG+ciL8bEnY2OMRvggWf1ByvyFykSuVbNtdonPCKIH8P5eM4r/KcbSQ44MEgXPCJQUE7G3DzXgB/kgq8pcfd+B3t1heiMqshNQ7329BikLuAaE7gu7rX7+vj3ydifgJhwxg5VerDngpthctqFfRiEZm+I7oRNy/MAHDXIMtJ3LCAtlSXFdMketZg6CaMlcaGp2mB6gKYr+b161UdQdri8ThV5gInpiJ9A8zQBKYQQNwDyREezsGA2tMkgY+7i4/3F/2iAWp28QdGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdX1fiC+1NdK24ymn8z7XPYiVF/UCpV2tVDYA6xfIto=;
 b=N+HQUiVWYPAstSDF5Fv0T2nd1o2Fuq+U2zTNBJdxlKfeTtgHzVkPKPlEGwAkuz6nHPAjoEGQSriigH/hGjDgn0VmzushpRTvIG0/MbyVzdhawyTNqTV2u+YeEXvGx3FpFoYNc5r4kfdoThOZCFCOL8ZyIK3rCCRa8QmHQUqqMlvhAoVO68a1UI4giIKWIZ1/2YUbfDuPmpkHfrfFODMRhdYJ1+YQghAhYdrGfkfgL0r48uS1JaNfjRHbNOO8YjNPHsE3zd7isW/pXhYEPZMUaDIzII4vmBq6ziablCrM3CZXpgHzSA9VVbvvAHhoWQUdmGxgJkgx9+Ie8LSWxnjxng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdX1fiC+1NdK24ymn8z7XPYiVF/UCpV2tVDYA6xfIto=;
 b=g7fKOE7bqoPYD4ITPQWae9Z9heMpt1Nw1zcMgiC8MwgLhGAdkFsoRrf9lqqJMc5VKYbvD8wjS29BK7yrMhKgr6aRWvwKODdmNJ6QgnSpVvUwokI8aSdWwFXFPJLm6qEkMJFyOnDcQjos6764PMgR8CJRimAv05Nn5ZD/aZLHNPk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB7684.namprd10.prod.outlook.com (2603:10b6:806:38e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 1 Nov
 2023 17:16:45 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6907.025; Wed, 1 Nov 2023
 17:16:45 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 05/12] maple_tree: Use cached node end in mas_next()
Date:   Wed,  1 Nov 2023 13:16:22 -0400
Message-Id: <20231101171629.3612299-6-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231101171629.3612299-1-Liam.Howlett@oracle.com>
References: <20231101171629.3612299-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0392.namprd03.prod.outlook.com
 (2603:10b6:408:111::7) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: c94c6aab-21f4-4c57-4930-08dbdafe533e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ym4aotpP6DWrCOOgPuQYgI957Xd/wFni7oC14PZ2HkZB01vOnUR+qYZaWwYcfW1CWWgjk1Fpn+7WIh73ZdMxolQgStMngqeobzUW3bLVbojndVkYmvvhmaaYzIUX4bOn1Z0iqRjMO6jKLMWpvB1OD1qO8I1a3NpoL6KBfskUq/HGTEydmKtaydRvy41+ADpGt2QMP6r/shJVds+WJj/jXt7O4grQecaVr977e+qYjMCMLkOHvpZTm0l7K4J+LmG52K3JGDKzSHQ8wDIQtj7dvYwjvefp8wAqeGG0gk1hmlmSwhPGisqssmboEEBbjNdQtLJS042RHy8BdwldMAFnbEO58kxJQxL0hCnml5rrCGg8iT1PHqKR2fzPL56lqz40MH1lJRlMP4g+zBWpgqs2gq6nUdYRy1jVBeBmTFNuJ4GWDOJ3/FT1ReHnkmXqD0WekpfEF0U8sarTiO1jFqlNMW/3WnUnTj9ayenI6L/NLZXOZQMTYui8qq8OrkzKaXsKHrNXV9XdPjL4pZWYpzObrPI1XSGoGyKDorvdW2gjE0Khfb28OrljJDjCjBx5OhN+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6486002)(8936002)(2906002)(4326008)(41300700001)(8676002)(5660300002)(6666004)(6506007)(66476007)(107886003)(83380400001)(1076003)(2616005)(36756003)(26005)(6512007)(38100700002)(316002)(86362001)(478600001)(66556008)(6916009)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Eu/Kulx13QZCHna/ZocWqr+/wOIjyO7FKtpRu31+70h0SQkdkliRb9CXRXmk?=
 =?us-ascii?Q?Zdltzc28Bs7WYYpKVvSTwHF12QMOsPB2yGMDRPzSW6aBDiAz/6CFWzZcDYCN?=
 =?us-ascii?Q?7RJOOBjDJDLZpju5sjUbqpWmIoJsvkKgU45FTASaKxxKyoIWeBMh5EU301by?=
 =?us-ascii?Q?ydia5JXkUR1pOpraLGxa4wOLCVemtVyDVCQnAAyiyN1GWXqrCWtGAe4p/f4F?=
 =?us-ascii?Q?Wp52JpC0qcmoOWTbumvAT127oi2tsCQdv6OnNS4xnYmlv7MKqrTpLLUKVT8t?=
 =?us-ascii?Q?RR5QwxvbEr7VLVs5PwLRNd5BBgaxSCRgLmsY8oGCOxAJzl85i1YVpvaBHSmI?=
 =?us-ascii?Q?7syEzT31z53T97JUrOsrnimrF70flET6ToLs4BPkkcxUNi47XStHSFMPgkBN?=
 =?us-ascii?Q?FnFl1/QeN+8Wq24SACgbQButQLCr+8t9lX1usbrXMWhdi66Snrkfp2qHWiM4?=
 =?us-ascii?Q?3dQzpdbJdK18gYo1H2sUHsd7SSa1a0tqU0+GDrpat1I//or0JbXyTw/PHcUl?=
 =?us-ascii?Q?2cNkOwPD2sHKKVM7aHIC7Yc6RuQXt4KGMScS808bQW0RIv+mphUZZgaIyxm+?=
 =?us-ascii?Q?fQ2rxWuqAmlnc5BavKg+mn/nq5V3DFi9ybJNgwn7sboAE1ST6V/Es6X1V2ui?=
 =?us-ascii?Q?Nu6xGk8y50MoqawX3+HOH/ETofdksrRGLsTQ0441X3OqQOGqG7lmhZ7fU6YF?=
 =?us-ascii?Q?OffQQHPtBVMOI9FDya/L7lamuNlIYRcQdwwUTkPnclrOnGZn4cWF7ImQoexp?=
 =?us-ascii?Q?9bO4ggi59Hx2n2dPleFlVWrVKMt3bwU8734j+UU+6bKU8V+Q2XnSO5RAEgAR?=
 =?us-ascii?Q?/O71IyoEwK//glnOPrU8+cWKKNJhXFXFJ1dVsHPYCdfOQ9nGdlNW6ubWQsJu?=
 =?us-ascii?Q?WZ+TULUPFGn6FzTyW4p7ee2ZX29oFFnfLuOaWCZ24QGXdlT7m2YCv3fpDz7g?=
 =?us-ascii?Q?EGnkJ46Vjf9IppWxPt6V464YynSMGOlFWvKlr8jrZJ4pYPjym/TtElT0JKbG?=
 =?us-ascii?Q?SnCfkg5j95o3ogNttcGVz3TrNgJpDd7LcVwCfEM8IEDKRyUb+mTjODDQarFP?=
 =?us-ascii?Q?0kyMQ1GdR9BGT7daUg8Xg9Jfq5OQwn6dgtvdlX42DIB4Tfs+jH+7LbY0tKLB?=
 =?us-ascii?Q?Es40VJXit6DYiKsPjKM/69qIyWjdiK2Q1BmFjtb1pl6zyUTifN2JpfFEnErj?=
 =?us-ascii?Q?siSDHWsMiPsZiiN2+d4/FyDy9JyE2SnUbNAIyR11nEzrb2w+eGRzoyR6ve3Q?=
 =?us-ascii?Q?TyLJqHta7eoxR/MK1VP4aS8LtBwOUmM3zA+LE4ivJ2NNm7SEba1vIAgQXcrl?=
 =?us-ascii?Q?t43haWGQneKZe8jN8GJr2fPvM+HJEcHCRg0LsYsbA/kOyCnoFLMnftR9xPBb?=
 =?us-ascii?Q?Jdwh/9YpCXLKjyDc4rqCWTcTS1W2RdBrd9rOKtmwD9VZoOsvZ0kQmKjvBgI4?=
 =?us-ascii?Q?nPHD3a+H1k/pLFvS3ANK/PGJ3UDLhZvXkrg4b1mMqhaKnqlo6229LQrRho09?=
 =?us-ascii?Q?gMYBStEPSFTEjE8dfQkb1018ky1MOYJcayCSfhInJzUuYSpApWKe5y1MQn1z?=
 =?us-ascii?Q?HKvUVHQj633iCfb5o4uSK6rEfifR4G/21fw4sBM0GsN2xkUjQtJZZEqvm+rO?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XB7lN1aTK4ie2UN5QUuEVeO4RuUtoJyyft4rkXkTOEWIQ+qL6bCRrNBxPkXuszNmhYDrTZi/sMvFHDTPAjt1BRtLwPdOZlh3B3Lsr6V9L6/oP//5oA60Q9Ex9G2DRb5fManz22xeMAvtXyk+BY0iTNvmFNMxbTu0DTPMQw5NTIWyrUvlNSNBKqF+wXRK1/FbZzbw06PCPaOgN+Q+XQUpuY9hyk1YhhYDZVNdQ+O+T5obdK8NWofg8spB+T8q9mBf0HXq9wXOoiSWvdXS/8LIADm3+A+kpq2WXj8gDvAzWkbN9HmLyUEvQXfIf+9UExyhFsAbGlhIAUDp7YP3f/LdU5R8DotMRuIJuE6ycUH76sn2XYi/iopqm1EDfx5vYlFFwtZd4iRMdvUaKT44X0yMrCIBZuc7bYYiODHW/9qAx9cnm2nHpG0BR4kSA7mSz5b+6iDItoBAMxW2TE5ekSs5uwJdN0gYmFF5D2H6H26L5gZbhekJYw5mnNhjl/jlP00mXlBZj6akN+v5C3gkrUi5MgcoZ55lJMUTVfff4MqImLDTNR23LWx+e01ZzrvvBdBuf9tqsXXEI6+rdEdqtffHr/l81+gsfbrjpRP4PjiOAzMBHEtaa4A7UbMazRjQ4AnwPnL4hc9FDqm/aUfoFYsUN3IpWv2Bp/RmqEhkDaegu3FHnI7ajPG7cua5ghc4fXi0tPtZvh09DqVH2tHSeK96oBrBIYt5mbx8P1bMrMOkqURH/hj4TadIo+xqpoC4972GJPm/Dl7brLgPY+9VZaf4sq2kAsjtXacRLHaB1m02C58UFITMK8NCKmOi75bZA+JgW+WLGl6nhJeIhbXX4+UKkWjlZC5VENn3ohfKoc6wK3iWC8eAIp5ZN8ZD1/7GL2r75O2SdbJkRBPmaXMK5f7e2A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c94c6aab-21f4-4c57-4930-08dbdafe533e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 17:16:45.6887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSKPAcg4SdN3Lz+AFJB9B+KwjsTN7BC8hRzUdA9u8hI9Aaf7js09m4uWg8mxSjOdAWujRwuP4h9Hgvp2t44cjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7684
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_15,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311010134
X-Proofpoint-GUID: LYREdPvwMBxsH7qpOZXLM-2NRLbw3hzV
X-Proofpoint-ORIG-GUID: LYREdPvwMBxsH7qpOZXLM-2NRLbw3hzV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When looking for the next entry, don't recalculate the node end as it is
now tracked in the maple state.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 6634594c770a..6c0ed71844e6 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4527,6 +4527,7 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
 	unsigned long min;
 	unsigned long *pivots;
 	struct maple_enode *enode;
+	struct maple_node *tmp;
 	int level = 0;
 	unsigned char node_end;
 	enum maple_type mt;
@@ -4579,6 +4580,10 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
 		pivots = ma_pivots(node, mt);
 
 	mas->max = mas_safe_pivot(mas, pivots, mas->offset, mt);
+	tmp = mte_to_node(enode);
+	mt = mte_node_type(enode);
+	pivots = ma_pivots(tmp, mt);
+	mas->end = ma_data_end(tmp, mt, pivots, mas->max);
 	if (unlikely(ma_dead_node(node)))
 		return 1;
 
@@ -4613,7 +4618,6 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty,
 	unsigned long pivot;
 	enum maple_type type;
 	struct maple_node *node;
-	unsigned char data_end;
 	unsigned long save_point = mas->last;
 	void *entry;
 
@@ -4621,12 +4625,11 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty,
 	node = mas_mn(mas);
 	type = mte_node_type(mas->node);
 	pivots = ma_pivots(node, type);
-	data_end = ma_data_end(node, type, pivots, mas->max);
 	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
 		goto retry;
 
 	if (mas->max >= max) {
-		if (likely(mas->offset < data_end))
+		if (likely(mas->offset < mas->end))
 			pivot = pivots[mas->offset];
 		else
 			goto overflow;
@@ -4638,11 +4641,11 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty,
 			goto overflow;
 	}
 
-	if (likely(mas->offset < data_end)) {
+	if (likely(mas->offset < mas->end)) {
 		mas->index = pivots[mas->offset] + 1;
 again:
 		mas->offset++;
-		if (likely(mas->offset < data_end))
+		if (likely(mas->offset < mas->end))
 			mas->last = pivots[mas->offset];
 		else
 			mas->last = mas->max;
@@ -4679,7 +4682,6 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty,
 			goto overflow;
 
 		mas->index = mas->last + 1;
-		/* Node cannot end on NULL, so it's safe to short-cut here */
 		goto again;
 	}
 
-- 
2.40.1

