Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA21C7DE52A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344823AbjKARRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344728AbjKARRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:17:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4C1111
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:17:01 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1GXnJB019136;
        Wed, 1 Nov 2023 17:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=GppQa1H4TowesdFoPRcn8EFhDFYYl23KeTE3xWcJ3uc=;
 b=efZZ+jRGASHXkPJwurZ/HYtSQKCdMBfdedhp/aSj+VsBqilZszgX0mSrwX8Afcq5M0kJ
 sTwhLtbEOxwGTgJGRCTQk2XBibpIp0gxHE+za4v5AAXLw28BCv3yo3HTg7d1Imm1FifZ
 ACSH7sYy+Fvi6+GUVyivP2f5NSP5JR75DuoS/d9jxBQ6+ZA8lbCaw0+yconeKfTTuL29
 bAuW+qQKdXrlMjKAaVhAXCThsLMKiNTEVnMUfzLFgpug7DqHekM0sCQ9oLAWB/flVKVD
 edKaQkA1FzSqhulk5JQnkkwUKK8u3AZCixGzwU6gLt9PHNT5/lYqYeG3++YLI+J0bMwg 8g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0swtr1wp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 17:16:54 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1H5Ckf009234;
        Wed, 1 Nov 2023 17:16:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u14x774p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 17:16:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OK4AHXw9AggqvpKvPLlEg5xs6oR6GxP8GTF965lY76D3svoe6Q2QyjJHEcQEKIUwkqKuJj3bbY+pdYI27FmwDXHrAQPegVq3WtgmQvJ9Jkf6pAneq48DLUEJBhRE8NSmKERForLdEhmR/c3PxqspWOzh3kSVhT3qPpBd95WDD+xgVhFF1qK8BF4sKK4/6ULFrZfG+CtkokDPyms2zHSKNSRgvzefrZnGG+4n/l/Gg2PETTnIow+bM9YNMxwpf1KuXoYmgYIr/z5Cw4WmXbNYFuB+vPqTcptztrtKHmyVzoWlyB0dpH2EIN1ELxXn8c94AqKeP4Z1F5+ssCD/RWc/iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GppQa1H4TowesdFoPRcn8EFhDFYYl23KeTE3xWcJ3uc=;
 b=Uz8PQwvK0gW7ahuR8bagpL94AhZ03888+X/02UOYfKrmRsYTPRhsctYrc1EzeWOvQzX3T5tt4PaLGWmuVHu+lwF6NW+Naqao4Nuj3Nbj8iN9jBVcjzxeO8oFyXi9w1NyolxyZBofWp3bMl9SVbMiZzoSWqnPTz2+DPG+DGaiVljo8MoxjzChQYhxYDEWHTq3rtA9EgMhI7s6jREVv+OPwE6XVM3lAp+yXOunA9mOBEyWxiyv49MsI7MC3Pm1mQOB2hpeK8/gZbb/9s3k9CWtpxvLxukHugtFkd3cFVOAvTDXCAPZ7seWdHVuJPCXCsSE+bM8QUpOV6KGlefISAB/ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GppQa1H4TowesdFoPRcn8EFhDFYYl23KeTE3xWcJ3uc=;
 b=vSupVR1aB5N0A95O1o6ZzWdrq+ty6niuYblzud9NVnzNr4D4653/x0SAEHhJYKUIuhlviM1E+YauRU82ZJTG3pzSYc6aLu/K4GWLlaGr6PvXKfXbvWeCNVPrGLOqRnkw/hZArjUPAgfJxS4O4e9qOes1Qg1TKXX+By+mbvo5bHA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB7684.namprd10.prod.outlook.com (2603:10b6:806:38e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 1 Nov
 2023 17:16:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6907.025; Wed, 1 Nov 2023
 17:16:44 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 04/12] maple_tree: Add end of node tracking to the maple state
Date:   Wed,  1 Nov 2023 13:16:21 -0400
Message-Id: <20231101171629.3612299-5-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231101171629.3612299-1-Liam.Howlett@oracle.com>
References: <20231101171629.3612299-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:408:94::39) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ed4287-7ff8-486f-ddfe-08dbdafe524f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MrDd7fmwzac8mXivfV8S16sN03O2Zwec5peKmvtWTYszXtIKsyFkCRM3XYLsspzz5V35EztuyoRZGQIp0SvqCTvtC9pMjdWfXcRedPmRJazGHR+GeqYnKnJxAVhLJPK6Acfn7EdRTyOJ7pPKJeiyMbXj1xbAic/VmXFRp/fieRPv/Jxu6gjqCp9jtyIiMdSKFdmlt2iqtNyD1e/4ENQI81eU8CdA1OJbCmDQfqQ2zzSMfEtHkh5qeifSzyJEbZRItovOE+vAbIAkWYE4Cg8eSMOVTP8/pdVA15oLl2r9OIkmGN6cMTQ7QyChUcLqwzjRXrL6vSCFmPW9I0l0GIfZ1j3yHe2mpmOeJ/S8BlP/D6ymWSg2ff/pAE5qMhdVF16elignVq0LjD2p8eVgbpykwPj2RV4S0bFprvYFyN/XZTpKzstBveNhO0CugX9b/6UP0YNDacJRDvfCUSkIxejS3+dWmidmCbb2UdAHYETcLcd+kai2+MUEeoqxMVgGKo6qK2HtQO6bCQ7Dz+gDSq+Cj6OqpwlMhD0G5xdvK7wNjWoldxCHk4JzP8DCGY534dib
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6486002)(8936002)(2906002)(4326008)(41300700001)(8676002)(5660300002)(6666004)(6506007)(66476007)(107886003)(83380400001)(1076003)(2616005)(36756003)(26005)(6512007)(38100700002)(316002)(86362001)(478600001)(66556008)(6916009)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3DDvnOln5hNmnwKU3+A+10lx9Acr9SkUCED+92Ae6lDnq0+2gVMzqUB6WM7l?=
 =?us-ascii?Q?YLU4UzgzdxiB2SRwIbQaGkwAbZX7EIBrItGzC26NjXW5tMt4J+pA39HaZBsg?=
 =?us-ascii?Q?yfgtaZ8zzW5PbtUVJJQsISN6So5ajcdnLkmy+VV5BOJeVz3szg0qpXdY+BrV?=
 =?us-ascii?Q?0pKUl15qRyAJaUN9NGJJdeczH7R7xZRNBxuRZ0LoPDmxZ3Tv7y68DNJyLAIM?=
 =?us-ascii?Q?s3CUO1o30UOTjTIk0G71DB+mKkqyMRHzZXaAVVumfVeHBaeaQqbVeD+OghJ7?=
 =?us-ascii?Q?mvesmPbCc4+dljjbew9ikIT271cEKFt3VKoyt8EVbe6c34f7T0C8j5j7x47Z?=
 =?us-ascii?Q?PnvUrraQXqTZl1Zi1IRs8l5Vlnx0JE9lvQynO+bbcWmBYrdgrB035wREWWRL?=
 =?us-ascii?Q?ScjLBBqEIrWqGIRrviuPcwSNF/rVF5KUnIwY5dTmNvRBPVKXJlf9RJRr9+hX?=
 =?us-ascii?Q?ynlDVzwoP6XFiAMxnmiPvWE8gP7zCAocvTqmByrRsMjyke9ssD8wpx8Ua1ML?=
 =?us-ascii?Q?R0BMg/npRb3nMKYAkatnPCq4zZoon51QW6S7uCWJ2T93Vm4FVnQjT/5OH3HJ?=
 =?us-ascii?Q?gUvDuekCXPWpiNcxyT2N5Z7wfryXTBN0MJcGZulATzlOz14KzDN2XZ3r1qo5?=
 =?us-ascii?Q?rBq/tPUdjj1g0uuoYlVuTmu1jYQMt1yCtvN1J5UPzdKCRiS5azNTb54cpDu9?=
 =?us-ascii?Q?CgcSm6mNqlf6Rw0O5/jBpQz5kfW1IZnjFVFlgw5s3s/02b13VRgc72lLcbzw?=
 =?us-ascii?Q?oFl8jF3F4f3UW02NzvP68/3W+R2jTBqCkbSm+DKjlMNqh7IEHF3WFErIe45X?=
 =?us-ascii?Q?8k3IuzaWCyO4EoEHzXoZgY6Jn+3yqSo1qhbhr5xyMNemdg9D8Qz0dZsgdVEN?=
 =?us-ascii?Q?LGQS1zDUCLjV8vczJ5QT/koSTNRC0K7lTXP7rvVizF2PF9TFxlmAyH8HxDjz?=
 =?us-ascii?Q?N2IkgbR/Hm3jaFCvizeyZFgrSoOASmrtWR90Vtl1u72vrcwHGgjauV5j3Zdo?=
 =?us-ascii?Q?eR1q4c+FLDCWJShj9HkmJ0W4zRLQHDva4y0THVg1IH8Jc18dJmFIjR/nn4Wh?=
 =?us-ascii?Q?7vfmhSlnFZxm0WVjD7xmy9C1gA1zIwnIJTzGhRjVeHRMFZVgMDFPZc5RhHnw?=
 =?us-ascii?Q?j5AkaEw6lp2mcqbM9OPCi4mWaBf4Jy97M9dWIpHvf+csb3fzHjlp+Ia7LNKv?=
 =?us-ascii?Q?JgAM4mRq4S9aYrc94A6/QKw1RaQTHsk4agVAfvLnYsDTWwSaFncv96NSW8eG?=
 =?us-ascii?Q?+be4uwA7yX0TpXF0Nqq9oM407Td21I3R/5EI1m26DTq3W2ijSO9XLSUvVY80?=
 =?us-ascii?Q?SHUnb280Bu7jvq7y0T2NtU2GLj10InJ0/9HnkYZxI7tOqAB+BvDEA3U5suj1?=
 =?us-ascii?Q?irBe5au+6f7BsQPNl0sN2J6kEUWrdW1McRRitWsF0fFEben+Mzt9+tEV9DOp?=
 =?us-ascii?Q?f04hOY0rAikLzpI0B6cLCbEDBjjjUOMW/2oJmM7a1LFSJN+dnL3q4isuziuU?=
 =?us-ascii?Q?Mu/UwinMNZ4YeUwVq8A/rOs2/BrwJgK6UNMJZ0KLysFLpbRIlHs6fGvooHV/?=
 =?us-ascii?Q?HM51gIqzfpwcZWiUFEE4Mk5Cn/FyO2Cl5cQpGhf4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Y09GF0puNYscXJoQiscny8gWrY/006qKoS+8lVl8veugZi2QqfbjZTE3NLkcEhgszGOwDFLc4QSxyUzLl86cESIWPWf472kdmWXFPGGIdrvggOiaEz4goK5cPTMlkmIkl1mtA992ltzxZwbWU3ccLQ8FHA/B1o+yrqc6fvrGpW41w9ZWYkpfhAsCAkit95NM17Z4MfW2xa6NS1tLqkgBdasS8Pw3H82ZqP9t2H6IDr2CYXnzDxEuyYtTdxrfDX64Mbls2EC1T3tmW689cIFZ8Yu5zBOS4crJF+i28kadkc2mQ3ehPSUuLu8iFj5zLKuGgy9lTtVf53dXJHKkrWQLPYkfOfq4jgqcl14i6z6B3NGblIeZD91M7LF45lN+d5gg37S6OsqucrZ/kJNMjrRNFCpP7+qLIpiV1aWeIjqx6pSJ9Xhn1dPBI3LO7mbv3NUVx5WvQW1ioKc2CehuhyDhkmPMXHB+x2t+i+yn7+3J9jG8fTqsr6FngP86vT1kXZtQ8xELzg32x+ha99cJSoguy4cpJRp7xZ2yfTULf8xsVTAvx2ybkvAR2qwtwX5qjmvqH0YgwHSAjV2cQ4vu1N+4N44i01AUkUd0hb6Jkzjht/evv8nS7uUVllB6SWrAeFQLmn1Jfs1blrro4oEGgrKTSZZCFegoRBwQMNCjyd6+IZTxqnAqZ1a76z/rYutd++GFz3uSVroNXCCSUDIGg4zSSAyD6oWBPjs6EdA8X3rmaZnt3DwsWRB+4MUxjAgheUaXRzEdzwBWnR0FStnWgy2guo985ir++JjCswnQFhIK7m2mpsDC+heEjmXWS2omtewYUXkm6QSZYJuoz6IANfgdPeJTXSlCX5VM9C0bNqAzsxHZbsTE6U3WrILLhavQaF/UiKhONhMd3JHkJUg7oOH1Bg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ed4287-7ff8-486f-ddfe-08dbdafe524f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 17:16:44.1757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c2tsotqjw+udSt2YPS2WJbP+P1VNo3+C/XU2J1jnp5Q2Vmi/quRdgM8gJQ/mYFzpkVlZiJbFWHdD56AA/jOayg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7684
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_15,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311010134
X-Proofpoint-ORIG-GUID: -ueVWP9Ovf6FeZr49UWmsVYrr3cKZniZ
X-Proofpoint-GUID: -ueVWP9Ovf6FeZr49UWmsVYrr3cKZniZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Analysis of the mas_for_each() iteration showed that there is a
significant time spent finding the end of a node.  This time can be
greatly reduced if the end of the node is cached in the maple state.
Care must be taken to update & invalidate as necessary.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h       | 1 +
 lib/maple_tree.c                 | 7 +++++++
 tools/testing/radix-tree/maple.c | 1 +
 3 files changed, 9 insertions(+)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 82a6bf5fa969..97a6adedb376 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -388,6 +388,7 @@ struct ma_state {
 	unsigned char depth;		/* depth of tree descent during write */
 	unsigned char offset;
 	unsigned char mas_flags;
+	unsigned char end;		/* The end of the node */
 };
 
 struct ma_wr_state {
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index b6b2d7031cae..6634594c770a 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2829,6 +2829,7 @@ static inline void *mtree_range_walk(struct ma_state *mas)
 			goto dead_node;
 	} while (!ma_is_leaf(type));
 
+	mas->end = end;
 	mas->offset = offset;
 	mas->index = min;
 	mas->last = max;
@@ -3495,6 +3496,7 @@ static noinline_for_kasan int mas_commit_b_node(struct ma_wr_state *wr_mas,
 	mas_replace_node(wr_mas->mas, old_enode);
 reuse_node:
 	mas_update_gap(wr_mas->mas);
+	wr_mas->mas->end = b_end;
 	return 1;
 }
 
@@ -3998,6 +4000,7 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas,
 	}
 	trace_ma_write(__func__, mas, 0, wr_mas->entry);
 	mas_update_gap(mas);
+	mas->end = new_end;
 	return true;
 }
 
@@ -4178,6 +4181,7 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas,
 	if (!wr_mas->content || !wr_mas->entry)
 		mas_update_gap(mas);
 
+	mas->end = new_end;
 	trace_ma_write(__func__, mas, new_end, wr_mas->entry);
 	return  true;
 }
@@ -4416,6 +4420,7 @@ static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
 	if (unlikely(mte_dead_node(mas->node)))
 		return 1;
 
+	mas->end = mas->offset;
 	return 0;
 
 no_entry:
@@ -5062,6 +5067,7 @@ int mas_empty_area(struct ma_state *mas, unsigned long min,
 	if (mas->index < min)
 		mas->index = min;
 	mas->last = mas->index + size - 1;
+	mas->end = mas_data_end(mas);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mas_empty_area);
@@ -5122,6 +5128,7 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
 		mas->last = max;
 
 	mas->index = mas->last - size + 1;
+	mas->end = mas_data_end(mas);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mas_empty_area_rev);
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index e5da1cad70ba..cb4e4a7cc7f5 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -945,6 +945,7 @@ static inline bool mas_tree_walk(struct ma_state *mas, unsigned long *range_min,
 		goto retry;
 	}
 
+	mas->end = mas_data_end(mas);
 	return ret;
 
 not_found:
-- 
2.40.1

