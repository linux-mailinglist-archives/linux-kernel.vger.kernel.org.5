Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790747DE531
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344811AbjKARRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344719AbjKARRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:17:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF4810E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:17:01 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1GXn3K019139;
        Wed, 1 Nov 2023 17:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=mG9RlDDmqoAmtnbXoAb5zAW9QwFYUfKiAAAiAkf8akQ=;
 b=l/b3ZAYkHX9ilV5xXm9dslofKmKuRUaAM7khgS1NUR+jx9gtHBhAOAZkLPZFoIY65HMv
 xtc6XRspHNGcSPIopEtB/a1fjuMY1AyI/xnyyEXjrd5xGk6edinSpQO3IBJ6L3WMMu2P
 9S2onmxDXmkCoOxTSkmB4Y43K11dhi0EThaBZH27kLnhWx12BNYw0aPdifnKmnZeoxrP
 E5P60HzzoiFMe4FudIQc9qI40wIp44g9cybh4fVE3TT31mcv8esxsU8aKWyGjYdwukKI
 uIDxJm8R2UXNdrZKfutW68kcxrwrqLu+JZfvB3MtHo6I7EejR563iiD3PcdgcOTPmjca 1A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0swtr1wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 17:16:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1H2fU9020060;
        Wed, 1 Nov 2023 17:16:52 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr7d2qe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 17:16:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwV3J6fFURQv3kWTtLpbcn1fzOpNr79URc3wxHyI01tPeHAA/neCRAwX4rAiTUyQepPtBohJf7IK6Hpzanihsxnab7Tbfh9Kljz/AcKNojfOYWJTnQm++1R77Rbgu8im5eZ72E7QJP3Utc50nJNRKrnhfFcBeqDCtmGJc3ORET+7wYTa0OhgaZadftl4d/QZcgPZrIEvoD1pZ1UtfrnUbBLSfigNXuFztza1+ko2mgz0pkAdw2C6HSk3LSLqoPu9rcGgu46t+AQc/uujMvFDs8KuZolEMvyuaXYEg0U1GaGutBO6d8YG3Ar5jekNzZmZRYO8C2gVYNVqbw45SRZpXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mG9RlDDmqoAmtnbXoAb5zAW9QwFYUfKiAAAiAkf8akQ=;
 b=iaWFPdaeDZ72UwuUgshco6+My1hQfcPkN1rTHejhsh84A/d7ouzhnvyh6XJHC47cCkMoSUYQ1V7WLQNYELuG2IFy1smkIvjm66/zvJlWqfcPyKgF+sJVsffZi4OWfg5kHuRejncGThe0zhJrlzK6FPg5hNclmA+i30N9/sWGvD31uzpiHWVSLPwuWemj66vr25Bd23+q+mwY2EIxVw+AL/mK3DqcgNekBaFuBhdmW8P9I3DL1iQOJJHFN8vU9Ody1NTBbUknKrlKm2Z5Pz+v/UOGnrR0NPAkdIUenLAqZJmNBqWL+uW3vfA8t5e6VRvK4pSm1X1oj8A5MdnaJ1mrmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mG9RlDDmqoAmtnbXoAb5zAW9QwFYUfKiAAAiAkf8akQ=;
 b=Gg1BqwJK42y2zlmtYrl0D3wGfWChy7m/OGuGbBQ9vnggvX11e1r8480g+rF4z7bGFplfJLtsIiryTq056E3+Qq7t477yssCQ7r37QFlQEspxY8h15XxM6BLPqlQ+dE6hpj1Z7M76z9qqDxk2HRzVkK22CIjdF4XpGlkT3r88RI4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB7684.namprd10.prod.outlook.com (2603:10b6:806:38e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 1 Nov
 2023 17:16:49 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6907.025; Wed, 1 Nov 2023
 17:16:49 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 07/12] maple_tree: Clean up inlines for some functions
Date:   Wed,  1 Nov 2023 13:16:24 -0400
Message-Id: <20231101171629.3612299-8-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231101171629.3612299-1-Liam.Howlett@oracle.com>
References: <20231101171629.3612299-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:408:fe::15) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 481a19ee-66e1-4e67-56b8-08dbdafe5573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ObeHqltP0d7FKVHLgPAzm4nRHaO7tgTa063vEhO7SghgK5EHw7vwsDgUKiDMIDG+b75h07ifajTX3ycjdI0fJ1CbLvZm9hEltIgeSIdXHEBd9AIg3BR9G09aUKAmfB2cvxdb7Gp4r4Q4AnkQdLnvb0bjydfwYMZ2KF0tizW1tmiB7VIsbelqx6hBFu7qy5f3cXvk2p3gd3nXlSakIAQwJ7cTFBGUJSjML8eIzSBcir2mQifCwR/91eO0yAib7YYGFpwjmPqqSfCd0Mh4pO6emmuTL/4HdlmMiLGqkRt/x0GMPlwKeuFSGEpg74HfCh5hl8W5PIoaN+zCx+E9jKdQyQzavpGpQkdqnXyd7cc0+vJeHertiyKO1GuI+en23qJ7UstUxoCqKhvu7BI0SlYXdBwSY+3NKCu9Vhb2B3bVXvAL0QA55qGZQXlEfjMWFpscWh7yd7bfKkMMf09LuhRPkQ9z9kRwdIMTOoireGM0NaolOuRjTkabhZVMJkNFQL1Tyv33Ru+K4vh3T3/P+osy1XzuC+pVNS5orfw2oGRJEgzYT1uA8wMtKAaGmo0WrnCBnOkVcKsPfYz67gr8Pqh3Dp2d8oRHPr1+pWXY3QRp0zNyJoqbZf5v3ahpCV/luusf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(230273577357003)(230173577357003)(186009)(451199024)(1800799009)(64100799003)(6486002)(8936002)(2906002)(4326008)(30864003)(41300700001)(8676002)(5660300002)(6666004)(6506007)(66476007)(107886003)(83380400001)(1076003)(2616005)(36756003)(26005)(6512007)(38100700002)(316002)(86362001)(478600001)(66556008)(6916009)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LuBYKW78iJBpWW2yEdxKhfl5ms1F4t/xAskO5H74muZRaSFlq80AZKWPMBvI?=
 =?us-ascii?Q?hoetqx8TcAmTTFuWx+vAN23BCxWW0Kuo0VXLFxlZBQIsdxSXtNVLitNfEOU2?=
 =?us-ascii?Q?ZWD9owqK27pCE6ZE5ROY9+FmKEj6JrEA28D9T5cdNW2QX5EvujDv/Freyaen?=
 =?us-ascii?Q?15zLXL7eRV67jho42XHI2iNpcsKVoR4tw0EoWJBidfBVg6oDEXmmarmsaN5b?=
 =?us-ascii?Q?1bSEkWym+fckBPBIak9cVmAJZLdbktqQQp7wPyHKJOaJUAZi9Vc6tOiSIyQK?=
 =?us-ascii?Q?m8r53OshDyT2ZXfiDfscqm+2WOQ7yfQ1XCPjo+65qFFtZAYizUfbhBqxhrB5?=
 =?us-ascii?Q?O+m7bKzOnKXUvTa5y60EAOLXCcNv/sX/sbaMmij3ZCh+fAPQcFe101RqwCo8?=
 =?us-ascii?Q?U8X+v+RSBHp9s7RqUIdTfyJLm2g+Ij0Y5jWwtLVstwQo7oocMyXi5QbtzohR?=
 =?us-ascii?Q?pGgaUpXiNHClcnOHZ+1IUua9+NS6KIHBRiOtBea8SuzZCBlJharNH+7XDVq+?=
 =?us-ascii?Q?XnhlhghDY1l1HE/+7N5g6Fh570mEEQY3xG1JyKj15FApJkmLE/An+3Vy8KsU?=
 =?us-ascii?Q?I8pOsNkUWZGwbY3obS+zZ25a6o0ojjm9TS79CL51Kpos0cqDL+OJLQhNVQ1t?=
 =?us-ascii?Q?gt0Nq4VmYZER+re8ZtVJvkixjAaK4bHaVkVTfzxNrTh5mDrNf2uJnstfG0Lb?=
 =?us-ascii?Q?t0TK+paMbICDZJXOHc1lrTWYhXJGdefmEQzLnPRf0zg8smC9u/AzSjrh48tK?=
 =?us-ascii?Q?ulw3rJ/w4u0goapXOcZQ4F2wOQ0ka9oU0fKr0o2tjddLlVR2EMO+qP7G89af?=
 =?us-ascii?Q?8uqNQp5k9xofkOtQC07VtKvepnzVkMWg+h8bSlcE+y+J9RZSpl20MnmTciQv?=
 =?us-ascii?Q?7D/OwIh4ou6LJDxBpPrID9DH8dunNsyrYma0PZxq2yQiAOYFTKwTsOSoq1jf?=
 =?us-ascii?Q?sUYanIqTY6Jf2DS6vGHU0fXPuMdm3FMr1adbAYVfCFXHP3reLheGMXdoDLw4?=
 =?us-ascii?Q?ENfSEmEsbWVno9SH8rtbx66jjElQ778o1q8TW42KOSThG8fz2kmxmkn11FCD?=
 =?us-ascii?Q?UlQVRxOyJF0D9KbuiY9NDoTFg0Mi/U1y6Cu/0jhT1aKmqIlphjQAHx4d3kv3?=
 =?us-ascii?Q?Mqw/mbrKQipUCq3v/Ns7Cc4jPIpnknNp9MRocA4nxmaJcKiFa00ntXG2ts7J?=
 =?us-ascii?Q?uAqJEv6uYjvoUwBABpR69mBFE2xMAVfse5pLkLhgVomxAo8AP9OzidImEecc?=
 =?us-ascii?Q?1VgzH3hg3E4sU/9yoYBz3+Y1queChwYrV3cmWHdFrnSnYRMA9RndqmcPO8zu?=
 =?us-ascii?Q?K1GoZfVBlGJHGdz3E86fJNyuJYHs5PbamsF2ok3BTl5/7hJ5ns4UYgW6lBwt?=
 =?us-ascii?Q?R3QV1QL2sFPip9AS7Qb+M2GT86kH9DRBdZzdl+PVefGSLT/sibFNrmE++i+I?=
 =?us-ascii?Q?Yad3JbYvBLK2kbDfbd7JUpl17W6nfrowabdKONPCW+DoWG6pEJiFe5JFg6zh?=
 =?us-ascii?Q?LcxTvw5lGDib7V9Loy9l2Y/2kogvywHUffCXA2GvHjZ3lbISQxnUMGyk0NDL?=
 =?us-ascii?Q?0hYDf7YGY4u4CJRnOA21SWJ0BNorn5aknCmlR/HV3Vk7P/0IMB7BYx/WJ4Yx?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0U89Pn7/UyTyXE+KYTr1gPIB7M1QjxHb0IfuVrtfcx6wq9NmlPRXAa74USpXifLnMjOjUUJVt829hzE519YU/d5UNxHkVSRTBfvmyMqFhoD9MTNxeohXopUVsvKbIjCpPwMSbo83nHYDPEGqKFACEzCvIC2d4202G/gu4yGHtpZcJ00LnQrRNH3b0x6q9TPc5xceqaxufeVuncPh3O4DrF8hKcH2lXd0w5dVoTRoTCAWArk5DxnEDuUKcb5KS0taMxLm/f/m1Sqq70fMjzrt5QfWWcLcPZfOpI7ihXWNrcm1v4MLXOm4CIuxIc5uG9wa9eeGsL2z5O2Ucl3vYyMAVfPH7ZrtVrhYnvco13MCM86ikLxjloecLmNhnAamtmam/KASbxTjCkpJrVSzv/FrZGcnanQh+GjI3dRvTPZAYykFJsDtFpdDFV6UXgbzCwj8fQLNJEcGY7PWTGDti46xa4wC6R9K0sUljskg2uq99K+h9jO0LDBfaSVwnuIJ8kCoCMvkGt5eF+ecWfkWpgsAzoK/+CNnOprgowAnB8wpz6xjQguQocW0wBO1rTFXVqEc25EuBXvhvyuNY5OgRD+w2ThL/k/Ep3PbjL+v97z1O4+fkF5VDCQ6tDAdRiXymrV89uoTobr5pVDoiWEnFf1niAt8nTAXONO0B4AHf3f8JXNKn17NTZADr/YA9JzR7I2oTUDm22ROBHY8bROtz16k/76R74IByuS/81pMpjm9e/RqS2zL0EuESidUgg68C1jFkcozD1FboQvThCd1/tmoJxNZNpHuqwVbaRDX0vDbPpWuW4ZcjzvgOBAUe8EyMoZWTLi/YXIXUbwTzNBOxyDv/iSBi+ojbIvKYBTXYcMGu7+Uhhx2H3EzCnU8qJ1jC5+HwnNnRtEuKN0HREB/JG4ObA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 481a19ee-66e1-4e67-56b8-08dbdafe5573
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 17:16:49.5275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzYgESSNWDiLsLM07XEKPipKuy496MeksDohawh0xiUmSDMT8yrmrCWlaH/A+BCvJNV0x8bLxbubEycAzSXUhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7684
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_15,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311010134
X-Proofpoint-ORIG-GUID: o_YMmhNlkT80PWcdjswQDHY1xiVRpgd7
X-Proofpoint-GUID: o_YMmhNlkT80PWcdjswQDHY1xiVRpgd7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few functions which were inlined but are somewhat too large
to inline, so remove the inline key word.

There are also several very small functions which are used in critical
code sections which gcc was not inlining, so make this more strict and
use __always_line for these functions.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 78 ++++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 36ccb0ef9e69..5c4ab10ded3d 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -205,23 +205,24 @@ static unsigned int mas_mt_height(struct ma_state *mas)
 	return mt_height(mas->tree);
 }
 
-static inline enum maple_type mte_node_type(const struct maple_enode *entry)
+static __always_inline enum maple_type mte_node_type(
+		const struct maple_enode *entry)
 {
 	return ((unsigned long)entry >> MAPLE_NODE_TYPE_SHIFT) &
 		MAPLE_NODE_TYPE_MASK;
 }
 
-static inline bool ma_is_dense(const enum maple_type type)
+static __always_inline bool ma_is_dense(const enum maple_type type)
 {
 	return type < maple_leaf_64;
 }
 
-static inline bool ma_is_leaf(const enum maple_type type)
+static __always_inline bool ma_is_leaf(const enum maple_type type)
 {
 	return type < maple_range_64;
 }
 
-static inline bool mte_is_leaf(const struct maple_enode *entry)
+static __always_inline bool mte_is_leaf(const struct maple_enode *entry)
 {
 	return ma_is_leaf(mte_node_type(entry));
 }
@@ -230,7 +231,7 @@ static inline bool mte_is_leaf(const struct maple_enode *entry)
  * We also reserve values with the bottom two bits set to '10' which are
  * below 4096
  */
-static inline bool mt_is_reserved(const void *entry)
+static __always_inline bool mt_is_reserved(const void *entry)
 {
 	return ((unsigned long)entry < MAPLE_RESERVED_RANGE) &&
 		xa_is_internal(entry);
@@ -283,7 +284,8 @@ static inline bool mas_searchable(struct ma_state *mas)
 	return true;
 }
 
-static inline struct maple_node *mte_to_node(const struct maple_enode *entry)
+static __always_inline struct maple_node *mte_to_node(
+		const struct maple_enode *entry)
 {
 	return (struct maple_node *)((unsigned long)entry & ~MAPLE_NODE_MASK);
 }
@@ -360,12 +362,12 @@ static inline bool mte_has_null(const struct maple_enode *node)
 	return (unsigned long)node & MAPLE_ENODE_NULL;
 }
 
-static inline bool ma_is_root(struct maple_node *node)
+static __always_inline bool ma_is_root(struct maple_node *node)
 {
 	return ((unsigned long)node->parent & MA_ROOT_PARENT);
 }
 
-static inline bool mte_is_root(const struct maple_enode *node)
+static __always_inline bool mte_is_root(const struct maple_enode *node)
 {
 	return ma_is_root(mte_to_node(node));
 }
@@ -375,7 +377,7 @@ static inline bool mas_is_root_limits(const struct ma_state *mas)
 	return !mas->min && mas->max == ULONG_MAX;
 }
 
-static inline bool mt_is_alloc(struct maple_tree *mt)
+static __always_inline bool mt_is_alloc(struct maple_tree *mt)
 {
 	return (mt->ma_flags & MT_FLAGS_ALLOC_RANGE);
 }
@@ -514,11 +516,12 @@ void mas_set_parent(struct ma_state *mas, struct maple_enode *enode,
  *
  * Return: The slot in the parent node where @enode resides.
  */
-static inline unsigned int mte_parent_slot(const struct maple_enode *enode)
+static __always_inline
+unsigned int mte_parent_slot(const struct maple_enode *enode)
 {
 	unsigned long val = (unsigned long)mte_to_node(enode)->parent;
 
-	if (val & MA_ROOT_PARENT)
+	if (unlikely(val & MA_ROOT_PARENT))
 		return 0;
 
 	/*
@@ -534,7 +537,8 @@ static inline unsigned int mte_parent_slot(const struct maple_enode *enode)
  *
  * Return: The parent maple node.
  */
-static inline struct maple_node *mte_parent(const struct maple_enode *enode)
+static __always_inline
+struct maple_node *mte_parent(const struct maple_enode *enode)
 {
 	return (void *)((unsigned long)
 			(mte_to_node(enode)->parent) & ~MAPLE_NODE_MASK);
@@ -546,7 +550,7 @@ static inline struct maple_node *mte_parent(const struct maple_enode *enode)
  *
  * Return: true if dead, false otherwise.
  */
-static inline bool ma_dead_node(const struct maple_node *node)
+static __always_inline bool ma_dead_node(const struct maple_node *node)
 {
 	struct maple_node *parent;
 
@@ -562,7 +566,7 @@ static inline bool ma_dead_node(const struct maple_node *node)
  *
  * Return: true if dead, false otherwise.
  */
-static inline bool mte_dead_node(const struct maple_enode *enode)
+static __always_inline bool mte_dead_node(const struct maple_enode *enode)
 {
 	struct maple_node *parent, *node;
 
@@ -718,7 +722,7 @@ static inline unsigned long mas_pivot(struct ma_state *mas, unsigned char piv)
  * Return: The pivot at @piv within the limit of the @pivots array, @mas->max
  * otherwise.
  */
-static inline unsigned long
+static __always_inline unsigned long
 mas_safe_pivot(const struct ma_state *mas, unsigned long *pivots,
 	       unsigned char piv, enum maple_type type)
 {
@@ -800,20 +804,20 @@ static inline bool mt_write_locked(const struct maple_tree *mt)
 		lockdep_is_held(&mt->ma_lock);
 }
 
-static inline bool mt_locked(const struct maple_tree *mt)
+static __always_inline bool mt_locked(const struct maple_tree *mt)
 {
 	return mt_external_lock(mt) ? mt_lock_is_held(mt) :
 		lockdep_is_held(&mt->ma_lock);
 }
 
-static inline void *mt_slot(const struct maple_tree *mt,
+static __always_inline void *mt_slot(const struct maple_tree *mt,
 		void __rcu **slots, unsigned char offset)
 {
 	return rcu_dereference_check(slots[offset], mt_locked(mt));
 }
 
-static inline void *mt_slot_locked(struct maple_tree *mt, void __rcu **slots,
-				   unsigned char offset)
+static __always_inline void *mt_slot_locked(struct maple_tree *mt,
+		void __rcu **slots, unsigned char offset)
 {
 	return rcu_dereference_protected(slots[offset], mt_write_locked(mt));
 }
@@ -825,8 +829,8 @@ static inline void *mt_slot_locked(struct maple_tree *mt, void __rcu **slots,
  *
  * Return: The entry stored in @slots at the @offset.
  */
-static inline void *mas_slot_locked(struct ma_state *mas, void __rcu **slots,
-				       unsigned char offset)
+static __always_inline void *mas_slot_locked(struct ma_state *mas,
+		void __rcu **slots, unsigned char offset)
 {
 	return mt_slot_locked(mas->tree, slots, offset);
 }
@@ -839,8 +843,8 @@ static inline void *mas_slot_locked(struct ma_state *mas, void __rcu **slots,
  *
  * Return: The entry stored in @slots at the @offset
  */
-static inline void *mas_slot(struct ma_state *mas, void __rcu **slots,
-			     unsigned char offset)
+static __always_inline void *mas_slot(struct ma_state *mas, void __rcu **slots,
+		unsigned char offset)
 {
 	return mt_slot(mas->tree, slots, offset);
 }
@@ -851,7 +855,7 @@ static inline void *mas_slot(struct ma_state *mas, void __rcu **slots,
  *
  * Return: The pointer to the root of the tree
  */
-static inline void *mas_root(struct ma_state *mas)
+static __always_inline void *mas_root(struct ma_state *mas)
 {
 	return rcu_dereference_check(mas->tree->ma_root, mt_locked(mas->tree));
 }
@@ -1425,10 +1429,8 @@ static inline struct maple_enode *mas_start(struct ma_state *mas)
  * Uses metadata to find the end of the data when possible.
  * Return: The zero indexed last slot with data (may be null).
  */
-static inline unsigned char ma_data_end(struct maple_node *node,
-					enum maple_type type,
-					unsigned long *pivots,
-					unsigned long max)
+static __always_inline unsigned char ma_data_end(struct maple_node *node,
+		enum maple_type type, unsigned long *pivots, unsigned long max)
 {
 	unsigned char offset;
 
@@ -4332,7 +4334,7 @@ static inline void *mas_insert(struct ma_state *mas, void *entry)
 
 }
 
-static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
+static __always_inline void mas_rewalk(struct ma_state *mas, unsigned long index)
 {
 retry:
 	mas_set(mas, index);
@@ -4341,7 +4343,7 @@ static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
 		goto retry;
 }
 
-static inline bool mas_rewalk_if_dead(struct ma_state *mas,
+static __always_inline bool mas_rewalk_if_dead(struct ma_state *mas,
 		struct maple_node *node, const unsigned long index)
 {
 	if (unlikely(ma_dead_node(node))) {
@@ -4360,7 +4362,7 @@ static inline bool mas_rewalk_if_dead(struct ma_state *mas,
  * The prev node value will be mas->node[mas->offset] or MAS_NONE.
  * Return: 1 if the node is dead, 0 otherwise.
  */
-static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
+static int mas_prev_node(struct ma_state *mas, unsigned long min)
 {
 	enum maple_type mt;
 	int offset, level;
@@ -4521,8 +4523,8 @@ static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty,
  * The next value will be mas->node[mas->offset] or MAS_NONE.
  * Return: 1 on dead node, 0 otherwise.
  */
-static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
-				unsigned long max)
+static int mas_next_node(struct ma_state *mas, struct maple_node *node,
+		unsigned long max)
 {
 	unsigned long min;
 	unsigned long *pivots;
@@ -5652,7 +5654,7 @@ int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries)
 }
 EXPORT_SYMBOL_GPL(mas_expected_entries);
 
-static inline bool mas_next_setup(struct ma_state *mas, unsigned long max,
+static bool mas_next_setup(struct ma_state *mas, unsigned long max,
 		void **entry)
 {
 	bool was_none = mas_is_none(mas);
@@ -5768,8 +5770,7 @@ void *mt_next(struct maple_tree *mt, unsigned long index, unsigned long max)
 }
 EXPORT_SYMBOL_GPL(mt_next);
 
-static inline bool mas_prev_setup(struct ma_state *mas, unsigned long min,
-		void **entry)
+static bool mas_prev_setup(struct ma_state *mas, unsigned long min, void **entry)
 {
 	if (unlikely(mas->index <= min)) {
 		mas->node = MAS_UNDERFLOW;
@@ -5918,8 +5919,7 @@ EXPORT_SYMBOL_GPL(mas_pause);
  *
  * Returns: True if entry is the answer, false otherwise.
  */
-static inline bool mas_find_setup(struct ma_state *mas, unsigned long max,
-		void **entry)
+static __always_inline bool mas_find_setup(struct ma_state *mas, unsigned long max, void **entry)
 {
 	if (mas_is_active(mas)) {
 		if (mas->last < max)
@@ -6035,7 +6035,7 @@ EXPORT_SYMBOL_GPL(mas_find_range);
  *
  * Returns: True if entry is the answer, false otherwise.
  */
-static inline bool mas_find_rev_setup(struct ma_state *mas, unsigned long min,
+static bool mas_find_rev_setup(struct ma_state *mas, unsigned long min,
 		void **entry)
 {
 	if (mas_is_active(mas)) {
-- 
2.40.1

