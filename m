Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1037BEB6F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378624AbjJIURd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378545AbjJIURX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:17:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C85EAC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 13:17:21 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399EY2IQ011918;
        Mon, 9 Oct 2023 20:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=qirXWJvA8h9aKwndFTNsBebfC7irUS9otO/qc8bhdII=;
 b=EveeYi0PVsVERIlQAG5rqigbNlyOtIfDWCL7h5fHEwCFf3Eshrsf7nn3TDrSs26yLpjA
 qVZD/9iMKMSvJCJwoTyo3U8m/hlfq0t82X6fyRD1qrrNtG7jkHoouw/rTfY4+9nOjDDs
 /wBAQ+RRTXvVFnui3sDVwAQbDGDM4H3xr4t37TuaQvZgKhyg6ORwyJ4DKdjXy3g0bYOj
 bd7Kap+nYNoYgA0FuB3HRiSyL1SjMEvgXS9n7OM0/w8X39zywFQa6gOiNWtHIo+7j79L
 McNztdrL7GAAoYc7C6hL3/kyLRrA9YGvXY+x7Tc6zYNUyuJY3Q/VeH5euhgdOgW7YuZo lQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tmh89s0vj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Oct 2023 20:16:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 399JTbNC032075;
        Mon, 9 Oct 2023 20:16:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tmfhntnaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Oct 2023 20:16:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5asRYoVqCxJxRGeK2bA/fNQYk71/pUFwKYaO5x0xb0+8cdobjTF0/P5x6zb+ogVVgU691HppyineHemCm4e9w4+cLsW2Jw01mqCD6O0PhkLIXD4UYkTZL/MwyVODqWoE/c8lkC0D+Nbif327urg41h9hbVC57Pw2XnuNObFwJu8lfvm43dbHlAC8el2fLi/pAdQGBCnbSnaIpNg+Dhe/2/uHLG4xDe+2dUfCNLa9XiowCCRDnEvEPRQbpnqbPB9br3Xl0eMZtkeAclaDRZU30Lk/IRyLemPPHm3fdVWL0neKmL4xE7LkeBbzPOouTbzGc1rJFZuKr90MoTN/ORZiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qirXWJvA8h9aKwndFTNsBebfC7irUS9otO/qc8bhdII=;
 b=E4Mb5A7rLIxQ8qGfF2WdrE6fYXlsRZyst9oXkAwiSSZtt/PgkPz8PfO3R17HvhL7Vy7F3EMichreabseOwmaxfeZDKpvpqRZOjFZOC4ES3mOFK7oDF+FzB5kQJE4xEYK85MYt3Fq8my9w5DRqchovDjhe1yNVfOilFKXLFtjT9nrtl3Iu88MruNTkyG3kc8hnKA3aHVNqwnoVqC2Wx9Ka6x1m4+254fmPs5gTTo9qoImgAoGxUB97AQ0SJyMzIOQQTdAhoG1fdQR2o7M3t59MmuFNf/wo1FYHLxOSxHqXGJAceXg6XyMNBhdm1d0tn56YFbGamiO6XdvQUlv8uLDZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qirXWJvA8h9aKwndFTNsBebfC7irUS9otO/qc8bhdII=;
 b=l1d0BEQJMCnNQhqSE17zwA4l1cXb8R5dgiaEiWxQxVoxnFYbRO4sjIKKJcJlEEqaFnxVjBevCP6lt55x+GGdG+kkKBMHcubX++ty/pMYxsiDJDcox48J2qRWpfSm9d78KOsMGxAhbqXyYavYp/Nr63nd+m/eFvYUhsaSpGdG3mA=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SA3PR10MB6998.namprd10.prod.outlook.com (2603:10b6:806:31c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Mon, 9 Oct
 2023 20:16:50 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e391:f2a1:a9d:967d]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e391:f2a1:a9d:967d%6]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 20:16:50 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        liam.howlett@oracle.com, zhangpeng.00@bytedance.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 1/3] maple_tree: introduce mas_prealloc_calc()
Date:   Mon,  9 Oct 2023 13:16:37 -0700
Message-ID: <20231009201639.920512-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009201639.920512-1-sidhartha.kumar@oracle.com>
References: <20231009201639.920512-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:a03:74::41) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SA3PR10MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a0dccca-548c-4159-5d9d-08dbc904aba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/y61+ZAW3jxgv0dmNdwcCKFsZOQWY7xr2nxjukvf9pZHsYez7R38kFcfMHnabgI8q4gD1M+A5ODg8YfMh8Ex35QNW7v8p3xry60YP0wZ2VX8EXtqU8iZSXCb0FgprAqOzoz71bpNWyyJrM1DshivwfXSK94qHCjUngY7J30Gn5YFYhLIE0UoloAQOUCfPuhr8EEJ0WJyscGM3a6VM0VigpnWfYYSoM1QwZN2KoR8oeEAWB0sAd0Kdhay2TLS9dJNMBHtZBhOV35tYROX9ZjAK2PYSAYwIGfsosIxxv2h+7sbvHR4fEaH2ANEVSGtFgkXwMLgB3xUlgtQGzbWJt3qYo4iqTcgdTJhG/JvCR9VRH7270FGdIcubc3dhmze225iy14sHHfCXy2wQRHfQzgMjqAwL3hk8Yj2DWsx/8DssOHx6JUlCCFKcYALAQM+RwzNXwty3dFBil4kSPw4NSFEwRkgcxg4jkTbobDaaOx0V9CKinoJwvKa6QTQkLbe9GDSvHI6DgNmDGMEfRsWhBwPxvO3Y017jiuBJDrlplAOxFAxHd5wq8GuiNKDfiliNcO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(86362001)(38100700002)(36756003)(6486002)(6512007)(2906002)(6666004)(478600001)(8936002)(44832011)(5660300002)(41300700001)(8676002)(6506007)(4326008)(107886003)(83380400001)(2616005)(1076003)(66946007)(66556008)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PHrn/oGpVDfRLf6LgwB2mZSwCwbyH6VIcPYMw72IjnqunncrNx1OgCH8bzMM?=
 =?us-ascii?Q?S+PIemHjGU/cKVnHqbRCy5MsvTatP46j4Wz6y8P4m6CGE2KaNOUt2v9RMgMB?=
 =?us-ascii?Q?lYUUs/e1hOszScnEQkmUyz+ZwW/n0dU5pkZlPJQgV8sD1DWaSr/zRB7EG/CS?=
 =?us-ascii?Q?GWsI7qEgxNZYg/Tn/sXujofZQiXfnvIZ54gzQph9OeTQ1ruD1D2ttKxG8ext?=
 =?us-ascii?Q?dyeGHn6CN49f0xP83WRwiU1x+RzwgApjeZN0bxfoWNbJ/vwblGckEeuZqhJM?=
 =?us-ascii?Q?/B6yy9NbO83LfuxqVBLgvkZGZrGzOmLQOn8k636XclRL4gvEFa085wzagXNm?=
 =?us-ascii?Q?aqqV+J+BLQVYBQhT1Xzp6dYAIu8F5Iy1nqbvpe8g3WQrKTSaw5vNqlftsjev?=
 =?us-ascii?Q?awiAJiG7glcLn0RhAwCnKnrThqv7Kqkxs9NF8okf6HDJmB5xDgP+6qNk6jv/?=
 =?us-ascii?Q?RQTJaeva7d14YmUDhK1jBR/am36j3smn8Cw1QBH/3JhyHmagVAU8bNlNUKTo?=
 =?us-ascii?Q?F31RoXQCSbAf9WRk7cLQslJ2N1NoneJJIZSJUZE4LZWs/vZFSfdsfaYenOSE?=
 =?us-ascii?Q?pbyQj3M/wGZQvlZ+Wu7MmDn1vIsEbNoOT4BU5eZagqone84fmceAqHsRtXGy?=
 =?us-ascii?Q?LP6jxvQHVacy4VbhfDjIeAay7Erckbbw0l17EYOqI4yMdG+iePozX3N/gv0x?=
 =?us-ascii?Q?lYzuFmusrYWiWgGVpcbe4Goeg7/nFvXfIrp1AcGvaWvaQRWedY4kFcxGvQHl?=
 =?us-ascii?Q?7ib6qNJebwValaYCV+gvlj086+rYuxb8CXZIar39TGII3iHnV10OZD3aIZ9h?=
 =?us-ascii?Q?h3+FG7h0NOAEGk7lww2hanRTMLEQBDuTtBYK4gBV/korjtjYA5xmzUXSNwM1?=
 =?us-ascii?Q?TSZuZ5+gzCpAtAa5Qsaw6sOdxlIwIBGoXtW5PNaZZHiosVgH8eeAIN/zu+Kw?=
 =?us-ascii?Q?TcNWpaIHz4gWn9YT0aRZ692sgBRaTfMC9hv0gO5H7rE02a8p0ehy3MHGcd1U?=
 =?us-ascii?Q?uGCVedSM4kCHBmyZnV5SC5k+tKtQDNPu73ACAgSkG9sZQgsHqnTarQBZ39VL?=
 =?us-ascii?Q?WQWcnxR+OG5lNnpG6bJKGwCHibEj56xDSayHP7RtAPXdTdIr+8ZYG/wqDEYK?=
 =?us-ascii?Q?h/U+0aszR6ne9wwJfD4ZJ3scP+yU9fpxH0qfZxIwqsa63qH/2Ah9uUT4rsrX?=
 =?us-ascii?Q?0Z6P48plFuRfN66opm1FCtD5NmaKwB+7gsglPx96T+EdozTpT7yI7seNmQ2P?=
 =?us-ascii?Q?9JzBqbsFXa/sg4HfrTpVQCOud7g7PAD7mXj2aDih3qH+IqrycJ0ZyhgtqGpC?=
 =?us-ascii?Q?ssuQXZE3mAbt/F/V87vuZbUtEXDshtGhAv/5/HbIIaRM7+aKf3GYSCUbvsYZ?=
 =?us-ascii?Q?OJx7vH5n7vIw3E+c+HjCh8JX9IGTWi3Ne3+kxeTbkHILaCCad6wCbcRWcJRM?=
 =?us-ascii?Q?aEdY46qpoQfDc7u3VOGE0ysdoS0udVDhwyz72A7bALnlBkb3Rj/dV7Nq+w6u?=
 =?us-ascii?Q?qiLTr7ZvGng5XI0Fk3kYKp6Hychs9exNhL3t0BLdw2fXLwidWjLkMuP0JdAK?=
 =?us-ascii?Q?Fw1wKqg+eSLUHA+Yvr4tdHnYyD1sXD1ATYw8LRBjV/zj6mGDTaphDDklWotA?=
 =?us-ascii?Q?NI/qTKpkCEOtJtJiFoxbrOk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?DptAObLX1cHO2srMUWhRSJxUZUKueChK4kEuX8EukmhD1A5147A+O26nxP1a?=
 =?us-ascii?Q?kOMirhbxXHsmC80+XBpHyAnPcxLub8/bEIBLoYw1gxJUKEQJ+i9/LK1Elq/2?=
 =?us-ascii?Q?bC9m5CpLsMcqjIEApJwAYzv54XwsmJDIEYXNzYg/bt0bmPX51D1mY7WA6oX7?=
 =?us-ascii?Q?FFesvAApMA4e43QMnPT/8zjovvHYcKgt8g8sWOLNpzyY1uHxfv+M8Bzzx9pw?=
 =?us-ascii?Q?wj9Os0sZRPpDfqZC5CGmLIWQM3EGUQZDpKja11KK7FbwoR0mUU/p5K0jkhj6?=
 =?us-ascii?Q?NVUETnGgTqJ+RpylcIgABjPeYFpRVMw99m15NYr758luIaXpHVuLnLSbkdxk?=
 =?us-ascii?Q?lF1GIrrNiiZx+8SWqPLdCmDrW9TmAa3JwlbtP9GcBrfbkBB3ZOndDNYqtvne?=
 =?us-ascii?Q?szWxIRtpkqNzGTIVB9MZsktweY904X4e1KHn1Dv7nGKTdGQ07/4RU8oDyySQ?=
 =?us-ascii?Q?9YbgYANW0KALJEws0evnuXfgzlvSUP7KSdNcIdRKH8W7M2zZYZaL+NK8VK2t?=
 =?us-ascii?Q?2+fBs7Qct2MZX8bAI4GiSK3IbGmuDajIKY8An4twFJ5oUuKGMiCtpBXmuHga?=
 =?us-ascii?Q?hE4VkyKyPXkIOCaahNU5Q3vYGE2qiu1ld45YQGhJbCVutmN43wm4fSNGyuXV?=
 =?us-ascii?Q?NKq4TuvMYhZBCFdJcY5bgopQ+bS84IJlyxr9lVrtyRj+a7ShkKbJIrTbL/xp?=
 =?us-ascii?Q?KugSVehek2krg8mIe4FfjuKBi9M8ElT+WY153xVy6fx5hn9EyOmGv+hkRpTP?=
 =?us-ascii?Q?OzBTwn/wBuaK3nAoQ8RRHkp+9myC6FOhuF8K+8pzTCyYu32R7c/BS9t0w2+r?=
 =?us-ascii?Q?95wkMKYTQE0vzExmtc9NksY12/Ich7cxVLSKfyNYRbZTqbKlX/wHJ7LNGFFk?=
 =?us-ascii?Q?ht2y/XBZMxF2pERCqoHMFmhjHgbiGeXMNwWbIoj99Kk0RQQV259Ulbb21mTc?=
 =?us-ascii?Q?CVO3O/jzL45Ro2yoVAMqaA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0dccca-548c-4159-5d9d-08dbc904aba0
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 20:16:50.1200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvqlpW2FLWSjrN85OXYZe7RgOdQJqSrHXuuxxG10Ii4z0SpjIREhAtiJ406U6Rh4hvrkTcvA/47XsB5kQ5Hl2HxfMljtaiobIVjxR31q5DY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6998
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_18,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310090163
X-Proofpoint-GUID: tBPHSQ_DDvz0WgzcexM5jbV7pd205Ghk
X-Proofpoint-ORIG-GUID: tBPHSQ_DDvz0WgzcexM5jbV7pd205Ghk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Abstract the calculation used to determine the number of nodes needed for
a store operation into a separate function: mas_prealloc_calc().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 85 ++++++++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 35 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 0e00a84e8e8f..e239197a57fc 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5418,6 +5418,54 @@ void *mas_store(struct ma_state *mas, void *entry)
 }
 EXPORT_SYMBOL_GPL(mas_store);
 
+/**
+ * mas_prealloc_calc() - Calculate number of nodes needed for a
+ * store operation.
+ * @wr_mas: The maple write state
+ *
+ * Return: Number of nodes required for preallocation.
+ */
+int mas_prealloc_calc(struct ma_wr_state *wr_mas)
+{
+	struct ma_state *mas = wr_mas->mas;
+	unsigned char node_size;
+
+	if (unlikely(!mas->index && mas->last == ULONG_MAX))
+		return 1;
+
+	/* Root expand */
+	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
+		return 1;
+
+	if (unlikely(!mas_wr_walk(wr_mas))) {
+		/* Spanning store, use worst case for now */
+		return 1 + mas_mt_height(mas) * 3;
+	}
+
+	/* At this point, we are at the leaf node that needs to be altered. */
+	/* Exact fit, no nodes needed. */
+	if (wr_mas->r_min == mas->index && wr_mas->r_max == mas->last)
+		return 0;
+
+	mas_wr_end_piv(wr_mas);
+	node_size = mas_wr_new_end(wr_mas);
+	if (node_size >= mt_slots[wr_mas->type]) {
+		/* Split, worst case for now. */
+		return 1 + mas_mt_height(mas) * 2;
+	}
+
+	/* New root needs a singe node */
+	if (unlikely(mte_is_root(mas->node)))
+		return 1;
+
+	/* Potential spanning rebalance collapsing a node, use worst-case */
+	if (node_size  - 1 <= mt_min_slots[wr_mas->type])
+		return mas_mt_height(mas) * 2 - 1;
+
+	/* node store, slot store needs one node */
+	return 1;
+}
+
 /**
  * mas_store_gfp() - Store a value into the tree.
  * @mas: The maple state
@@ -5474,49 +5522,16 @@ EXPORT_SYMBOL_GPL(mas_store_prealloc);
 int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 {
 	MA_WR_STATE(wr_mas, mas, entry);
-	unsigned char node_size;
 	int request = 1;
 	int ret;
 
-
-	if (unlikely(!mas->index && mas->last == ULONG_MAX))
-		goto ask_now;
-
 	mas_wr_store_setup(&wr_mas);
 	wr_mas.content = mas_start(mas);
-	/* Root expand */
-	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
-		goto ask_now;
 
-	if (unlikely(!mas_wr_walk(&wr_mas))) {
-		/* Spanning store, use worst case for now */
-		request = 1 + mas_mt_height(mas) * 3;
-		goto ask_now;
-	}
-
-	/* At this point, we are at the leaf node that needs to be altered. */
-	/* Exact fit, no nodes needed. */
-	if (wr_mas.r_min == mas->index && wr_mas.r_max == mas->last)
+	request = mas_prealloc_calc(&wr_mas);
+	if (!request)
 		return 0;
 
-	mas_wr_end_piv(&wr_mas);
-	node_size = mas_wr_new_end(&wr_mas);
-	if (node_size >= mt_slots[wr_mas.type]) {
-		/* Split, worst case for now. */
-		request = 1 + mas_mt_height(mas) * 2;
-		goto ask_now;
-	}
-
-	/* New root needs a singe node */
-	if (unlikely(mte_is_root(mas->node)))
-		goto ask_now;
-
-	/* Potential spanning rebalance collapsing a node, use worst-case */
-	if (node_size  - 1 <= mt_min_slots[wr_mas.type])
-		request = mas_mt_height(mas) * 2 - 1;
-
-	/* node store, slot store needs one node */
-ask_now:
 	mas_node_count_gfp(mas, request, gfp);
 	mas->mas_flags |= MA_STATE_PREALLOC;
 	if (likely(!mas_is_err(mas)))
-- 
2.41.0

