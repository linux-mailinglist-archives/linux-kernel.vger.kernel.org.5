Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF85F7DE52D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344987AbjKARRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344762AbjKARRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:17:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779E712F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:17:08 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1GYcQc015613;
        Wed, 1 Nov 2023 17:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=wPkuNnzWbEknTyqX5DrTTcv2VdbvwaVi2fFPE+7DsDE=;
 b=R+X7MlK40GrHXrusLviZhWeyAczFzxE69r1C4cSnpb6cTh+xdk4ryLhperaHyMk8z3h3
 xK/hUDSQDNmj0npi3ucGzL6JUX66c89sPL7YUPQNN1qzFb2yFB89Vxj5gmuyqM0lNZCP
 /+ZjtlKjbqibZas9pXs+nVxgLL8jCvlU4kkKpX5SQTnbVQsqzPctLTEk1ydsgZY/6eLi
 zkillnaFXwwwu+bXkvikDGDkFpkP36k29UnRmOTIH6LDhMnpzy6brutTwBp6xROsBjYo
 V5ESGF/5ejoHH8WX2YKZuCeMHfMUUJmxGfyGkDV2odqx9dhdEi+s8I5duwX5h1ySIODk HQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0rw27wn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 17:17:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1H3fsG020090;
        Wed, 1 Nov 2023 17:17:01 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr7d316-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 17:17:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4/s7ybPAYU03lUny17pYiKcbLfIAnY3KD4mFNASsf5kPjjigSEHp510W96zhLEdk0lz0muxakwKSmzBS2B74q9iT1Ow4SjsibfHm91O4aqOYo+rfZgj9xNCM2MjR57XpqmbharfMOAF8UJM4kunY2LGU0JqGHoBcGMs09HlIp3NkAL5iKNdlmDtp9PDpM3yKxkeuLTRq4JN0+lfueWvRKkd5VnguihMkCJ8STFivXQBhFUE8qH2Q9Ct/YPitXhTW+pWfZBM3Yzm/HstYy2f04IkuAT8DHXIlbtDseMl6UuPE2YmEz7U0XlUoJajKA6znhGYJMq/bqx5eSEhS+qp3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPkuNnzWbEknTyqX5DrTTcv2VdbvwaVi2fFPE+7DsDE=;
 b=jHKk6j/GIvh0EzzkdwTPA+lzQVg1v2L6h8tys7ZNI0V1HCPAKlG/JYKoKVbGiudDTM48woE1XTI3yphBStDePeYZXnyeSVbTCs5mFspmd0xuiHlIoJjT4FcZbriF546AJOhv7+nJtkbcTTDI399YPfO340hNkunbD5JEr7HKAAK+GEbtVxREDq58P4yNHaYFs6IOIyJexFIlMk4ZLSDn7ps+XaHag1nSr2WSJJJqZF3HqGx2l2sYbsBDEO+5EGvdDN2Xey+/vG6IqbyDrYdYYjV4RyvNk8hxzda2fAPLUkZdIZyleOQJpa7kWTA4HrwuC4pQvigvwOg94+jqBjZgWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPkuNnzWbEknTyqX5DrTTcv2VdbvwaVi2fFPE+7DsDE=;
 b=Pnoxu13Pq3oEeEBHXzCaNIIW5Vjn8bAeXIh3D1kmVG18GnQsQdRE+wTozLU7abWpZsoj2Ebfv+VAYWngxOXlywtU3bS61PSBElxSNmd+tn9VjJIryawfaYVRhKpdxqU5bPFwpWtHG5jiSmOEErCK1C17cHVTJE1mTwVNfAUAAPk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB7684.namprd10.prod.outlook.com (2603:10b6:806:38e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 1 Nov
 2023 17:16:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6907.025; Wed, 1 Nov 2023
 17:16:58 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 12/12] maple_tree: mtree_range_walk() clean up
Date:   Wed,  1 Nov 2023 13:16:29 -0400
Message-Id: <20231101171629.3612299-13-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231101171629.3612299-1-Liam.Howlett@oracle.com>
References: <20231101171629.3612299-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::13) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c144100-b373-410c-021f-08dbdafe5af2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lzwoaleFNLEd9kkVtOdkTWraLBCC5g/oKD3lmoQEIgcPXOjI4jYARjqwBSJ1fCxIdwoXJbJ7Qhnv2/g4W1I9wcFfYK87345mH0gOA6v8VM0F3D2ilvnBC51drYaUqGEXQU6biels3HVjBUpk7M2Mb4xihmCjiPhf6WaolwdbpW//pTYM2LlOXwpi8XLxxSb+sG76reBQ/oRABFvbz+WFQ0QgkN597Zd/6Wwh9k9bjSYyrJA68v3e6U8fzPS6VFYNs1K3gu8TO/Tgw3naVKQDqZ8dV01V+23DTGXZpjzu2QqyZPZfRdmHS1WmdkY4xVzze9o30z8p5CEnMJ7Hjp288VOK/s1ADfRgU/Qh/a3TTEtAHIxU+G4FIg83NM4HLto9MAD5GkdO4b+qJpVrEUVK+RBCkWBbduAUZhBqCrcB0FRFIm96PBJVUg4bJyBiXWjgTAnMFngGhaVjIF0gVRQ2W675pmcNLs/vxv7j7iWFgNwf67eHBwMcjPar3n71b2aFSc2S0FIkqXUqk1kYqxQ1x+AadSJNSGvkMFks3y9vWML2aUlnsO9bSG5ndp9rfFTt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6486002)(8936002)(2906002)(4326008)(41300700001)(8676002)(5660300002)(6666004)(6506007)(66476007)(107886003)(83380400001)(1076003)(2616005)(36756003)(26005)(6512007)(38100700002)(316002)(86362001)(478600001)(66556008)(6916009)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pahLqxWCI099x1hySxQEzARJBOF3YJBY9Eg4udVhr3tZTyRZ7aMFr8dxcQoq?=
 =?us-ascii?Q?lIcy6z8SV/O0XC5wtNRxYYTyBbl2OtMiZAGN1vn8/W56kxBasbZd+O2l591d?=
 =?us-ascii?Q?0wB+ZBmCFuKucJoVPu4/KP9VvfDg249Vq70LPrFRiZGrzGURNCo6ov6VE0Fb?=
 =?us-ascii?Q?4wwFjayXf8ofd+ge3ASatD4b623BNKky7UtWQX2j9u/8TUH7SFMkvr2Se+LS?=
 =?us-ascii?Q?26P4UhQMBu3mwnuNN5txoo+EwePO3Sulux+PXLD/ivHxExHAeZtOd+jVhejI?=
 =?us-ascii?Q?OrE12LHFgGXWfuSFT7lhB8JsFhF0mxjBsxe6dYj0D81pfq9hEOV9zJKfx/ZF?=
 =?us-ascii?Q?+S1lmInCbhIAUHPdpKz6DGQTMjLmZvkzbhu/7gfLBnK6zLxLACndPWykJdCh?=
 =?us-ascii?Q?WjQkuA4QtNP7acW9kdUARSUQ1UK7h/tk1IzPMnA3YQXgjtl6YTj5RkX0ZnUb?=
 =?us-ascii?Q?KyujunhDGGb2aAn2YjwwQ8D9YDnmJ0YdOMhH0pHkSErgOocgwSfF5gXZ0IlI?=
 =?us-ascii?Q?mfa3U7o/xqS1OS7I4DwoGCFK2GeIYSh1gagdT/cAE2JZBTtJGygBtGoiyoBd?=
 =?us-ascii?Q?VaJtsCPyFy051pYmkufOwYt3e0p4AgEM3v3HUuoe0xWAiX/OIdksS8mHHKLW?=
 =?us-ascii?Q?ipFHTQ2C/qlPt7C3C+ansoPxsuMysiSecSDJzc6INR7zeBjjsG0JqDTL3pai?=
 =?us-ascii?Q?mAQJq5njDUHQA4wUoMKy85nXOnvtRgEpGURhfaAW3BMNIED6a9MDo9SsBKni?=
 =?us-ascii?Q?CGJeig2CLVCrpuxjcr5Uizk5DwHx1jikdQjcl09VswQCbySs/l4U9CEnJ+BB?=
 =?us-ascii?Q?f6HKFxwyuuY37ZQtKKTzMJ30U8EibNhwboeC3QpO2y/ccvb1SMSVZaazRmrD?=
 =?us-ascii?Q?UUEup+NG4QYJ9BjRq7DJbzvaJvysCNw466uR9UMmDmRwOS4JWCPyYCrF7wk1?=
 =?us-ascii?Q?swqwS0RKhJUz6qGdfHaJ1q9zmgMG2NhPns0mVhWMqs2LCafeIk4BJ7mXeQwc?=
 =?us-ascii?Q?auBEpOCG9a6Mb0qToGC8x50yVAexkubDSykmCTl0x5LiJ0JKYiY7QVstmoBY?=
 =?us-ascii?Q?rxiK4DK/fOQJ+AOi0IHgxH6h+pEcTI4DF5VIYVWJh43xgMddwiS39GKu5Owp?=
 =?us-ascii?Q?gJl9U7M6IoLf6YxbdoIp73nkk3G9xksn/8t9brW2N8kOQNF5Q+ODHaxOVn8U?=
 =?us-ascii?Q?dVk2AY8ZoPRzxC+dfMPUHXB+1H02L5ZfMPHHnZ3h1nBPApUq/HcqkRKpHrxA?=
 =?us-ascii?Q?1+ABgoeobQKkHqhZcIgJwIJ2uXKcbl9NeGHVg8y6GGElVXV/u7+LQVHH2aSo?=
 =?us-ascii?Q?IPphUQTOTLVNHhCJkjKfG+aHNwmRb2HTXycrMKwvnN0OrAV8PqQILHDtUZKa?=
 =?us-ascii?Q?J7NnZl57dKBHcG4kn/P2PaQ4XIuwqxS1ktN7xPvvz7hubS8YyRSaBw5jA1eY?=
 =?us-ascii?Q?c0+NnzyDxwMwQ1m7Ax8X7pr/M7Z9SolcucJoqPupCGUzXB6Y/ondRDJV7FMO?=
 =?us-ascii?Q?kIUlNe0Patv2wMXA70tlAJmwkfe6EARDoYjPU3C2B+pbC/YsCHVwlkrQCGCp?=
 =?us-ascii?Q?5gB0/8MF6ZMXXzldl/9GUCxFXd/xgnRsbITLABB6xeBEiUBsEz+a+mXTo51x?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VEFy1vQKs9VHPfT7LbpukqA+HEgKE4o3X9roLYFlzxPiwnxQ7kGI51JbY9bNPW0YaNgWQlwuJ4QfWulPAGd3Qdvq3QjXH3RmczbDu/1HeDck6skXoxgVngInSqnnMAtPmezZzfwrX/4WfMoBDUIVKAF+1RzQo8T5UrYdtLz/5s9jWdqamrrq63KZIXdFBJMmTTkU6l4rmJTcLORD3y3RfrL1lf6BYyi70Le9guTDVKtPnZaglrycoywYNpsMbGHoOYG4UaPx0PRioRFF5/F9aGE6QJ2bqfK/N83pFs7MDKH3YtvWxZx2qQFJvPK1KwvxINm88OnGh3axfrcw0+96NgSv7SgXrBmZW29D+N0FsaozO8mlWgsmjXiDoatjnPDHdHvrYblpR/Inkg+poyv5RuZW15xaXaXP/k30KtHqDTGJacPK+anSctRciBmQx8O4i7CvOcuIahevCkbW85J3iNXEU2c259s3OroocHS1wCpJO4mRX8YAxLdVCzxTd9bN2qJlHYZg6pGtCLJqptnHCRZuFrQhiGXpnCKRvz/eV/nNAH/MlK06PlSGf+/TJeHEcUwr9dUGowNO5YnWiGyO99zhlDg9M14U1LSvDuhifGQn4tB9rrtuSWff6bDMi6HX7baHctR4GmemvoOQgnv+G3AwIao7j5ZOVuHHbYYdch1g4liUbtTeQKtcXsyoZvWsTLuPqBwykCrbgG8edcvvC861ZLK0xKi9A7BRFw1EZuy4i1xrJTU1XgOn4myR8f08IIxuxQR++eM4HIoZXUqqKCnxuYPqICCj2GxajsH+jCYAnoQPQFXb6dnvpa97jFbjfsa//ekzg4aqSM31A8konjYKAQYVmoGzqGMdGvRLQnE91mGk403LyaY0lIwAR5HanRGk6ozxuKuLLHHtAeJKyw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c144100-b373-410c-021f-08dbdafe5af2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 17:16:58.6094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5apUjXyESkK1DlG1QfIpUB3sHERjOIH9+onRmiJczK3Um/Zqsse7shYD83XKg8ZioFu2dg7YAhpD7owyBVO5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7684
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_15,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311010134
X-Proofpoint-GUID: Pd4JlmodrTGVuawo9VVTCDlHxG0dvDp-
X-Proofpoint-ORIG-GUID: Pd4JlmodrTGVuawo9VVTCDlHxG0dvDp-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtree_range_walk() needed to be updated to avoid checking if there was a
pivot value.  On closer examination, the code could avoid setting min or
max in certain scenarios.  The commit removes the extra check for
pivot[offset] before setting max and only sets max when necessary.  It
also only sets min if it is necessary by checking offset 0 prior to the
loop (as it has always done).

The commit also drops a dead node check since the end of the node will
return the array size when the last slot is occupied (by a potential
reuse in a dead node).  The data will be discarded later if the node is
marked dead.

Benchmarking these changes results in an increase in performance of
5.45% using the BENCH_WALK in the maple tree test code.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index a91adaf17306..56cc8278260f 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2796,32 +2796,29 @@ static inline void *mtree_range_walk(struct ma_state *mas)
 	min = mas->min;
 	max = mas->max;
 	do {
-		offset = 0;
 		last = next;
 		node = mte_to_node(next);
 		type = mte_node_type(next);
 		pivots = ma_pivots(node, type);
 		end = ma_data_end(node, type, pivots, max);
-		if (unlikely(ma_dead_node(node)))
-			goto dead_node;
-
-		if (pivots[offset] >= mas->index) {
-			prev_max = max;
-			prev_min = min;
-			max = pivots[offset];
+		prev_min = min;
+		prev_max = max;
+		if (pivots[0] >= mas->index) {
+			offset = 0;
+			max = pivots[0];
 			goto next;
 		}
 
-		do {
+		offset = 1;
+		while (offset < end) {
+			if (pivots[offset] >= mas->index) {
+				max = pivots[offset];
+				break;
+			}
 			offset++;
-		} while ((offset < end) && (pivots[offset] < mas->index));
+		}
 
-		prev_min = min;
 		min = pivots[offset - 1] + 1;
-		prev_max = max;
-		if (likely(offset < end && pivots[offset]))
-			max = pivots[offset];
-
 next:
 		slots = ma_slots(node, type);
 		next = mt_slot(mas->tree, slots, offset);
-- 
2.40.1

