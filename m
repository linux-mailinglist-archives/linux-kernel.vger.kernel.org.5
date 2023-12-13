Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F9581203C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 21:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442659AbjLMUwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 15:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLMUv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 15:51:57 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B1CB0;
        Wed, 13 Dec 2023 12:52:03 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDKOLeq029627;
        Wed, 13 Dec 2023 20:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=IZ+IL7WJ9iUjJ6MIBGGyJdT+xwOarJ81VlaHr1i8yg8=;
 b=Y2w5xYp6i0Z0VXRI8fCgNae2oW07+OltbdQ3aJL7as0zm2dnsY2GFaQMVefszFQP6jv7
 YdyuLVlEc7lZdMzfIGX1a9UsApD4M/84ffVyGnZOfz3NtEarrJS16CovgkxDkpfQlriN
 Ki+s9LO4x8jgThEt7ixELGbInuaC8rHeqqUcBS5WHPCsOyrdnxR+s2YL2hzE8LENC4Rb
 r+DLacWjGzw+30Ujngy9bY2umtawbQWMLDNKHI2vMQUNOZtb+gKRCRS/WJUO2Ehj9wMO
 tVfyjWCni0MbwNYqlARqFWvaTaaGqYfZRRKQbC5RhZwNyvjYCqDKZOGJO/LvwhHdvOPB Zg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvgsuh8jh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Dec 2023 20:51:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDKbXYE008372;
        Wed, 13 Dec 2023 20:51:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep8wny2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Dec 2023 20:51:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMWRDUOzwzU3fHfYGmjoNKL41jgyVVHRE+SSzo9OnUVOzX6rzrQ0dUNZMHzfwIJltGANeexvJqjAYNJVxHsFLmU/RkyHgzBUUwlqTtpkBmJeHDR8A8atW8iZSR0soozm/50NhrLGG/s6V7GWzkfTWeER8nZl+TBJkCOF8hki93kkJwHZtn5q1aATNCrigAjOxtr/q9cg5PKP6tMdJ1G+dXLNynRsPYKtUtA80gDoGOkZ6clzgHxQKR5y8RKX0ixsF371mG8in53dOBH9K6QE4BOuZJ0hfHzPFQAfvtoaUy4RBNLiE358m44KycrNeUs5BvGlMdLfMZuaE/iujbZN9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZ+IL7WJ9iUjJ6MIBGGyJdT+xwOarJ81VlaHr1i8yg8=;
 b=nmLsXtGUNgCnVhgsGQKoWU9QOFkUe4fYkDYBCJ0U91K6+LF+cbQTlo0RmKeRlMUkawJ7q8+utKxZ+I/Ss0E2bC9JVhN0oNQj9/gUtIVxEQj2gPMVa9B1kK2GrZVMvQ5UYDEzW3WtIo8hn76NEQbTvsqp8nXEbG1yQyAdZ0Yy8NaQe2DFNPjC6NLEleWz8tY34aQWXuS/9GOKJLoLw6n5dec563IFXQEBAFecZEI0VLOaggfpMl1E/vZWvTTe5oydOKX3g1SnkLki0aAO4vdUTR5XRmD/GvwgLI7Z/99xhvCKRFwuyDkzADu482pRKOkUtu8rnBgcatCqLW/2ezH9Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZ+IL7WJ9iUjJ6MIBGGyJdT+xwOarJ81VlaHr1i8yg8=;
 b=zrTU5e4CuuvxuZjQ7N5sRDfBbdyYRihJzBsEy2/aRoCeGP7WYotP2W/OQpb1O8K3KvDK0le915Qdvfjdt91+mbIEd8n5sq1z5ItrD/q0VMpWN6zjAwOWnVxzKrOgUEqYowQR0Ovcv6jUJSvGET9VJRevWnAWYWB+Dj8ChaYOBAg=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SA2PR10MB4457.namprd10.prod.outlook.com (2603:10b6:806:115::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 20:51:30 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7361:23aa:7669:bcce]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7361:23aa:7669:bcce%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 20:51:30 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        liam.howlett@oracle.com, zhangpeng.00@bytedance.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        stable@vger.kernel.org
Subject: [PATCH V2] maple_tree: do not preallocate nodes for slot stores
Date:   Wed, 13 Dec 2023 12:50:57 -0800
Message-ID: <20231213205058.386589-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:217::13) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SA2PR10MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: 5197c060-8019-4eda-ec3b-08dbfc1d485d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7bUDXCuNU76kGsFOD4FWXjfp3XqeFfMDUppriUxxi/w2o5hEKnP41dDQYRP3whDaa80qlMbkn0boMKxRLRtrCuMYvRYAJUozBQIuy25FNTk7JCs9PYfzt/JWBbo/Ol/azbJkw9enpemoWvLSbTB+5Rb0iSDxzQ9oRTcgG8SZKsy/BB1Z4T/CKMIwvscSIUEfni8zTuWel8iCodjJEa0/wp2DQIAlcCO+vld8IUiaSoGldgbfDqxFbbDkfGVZfm/XpjNOKEsk5w4ZAq0eio3/t+tGCTdRH0Q/I7CQngeNds+06AIX5rbpJV+bWptseMVVThy4juW+70aTNEMOu9gQn1kNm3PfdRPtSK5k6EtvWEyRWzpm+MTSJ0rauXL6P55QJNmuKfGwso/ZxVQLNu+Vqx5ahk2SsQpQHlTNOzwpIcjNm1q+VCIN/Gdhbr8DaEErnZEE+mHKziFlO767xpaSTwiaCNTODG9SbUTyOfJdWFZ8RY9s/HHibLitq9JqFx7wy5xlOlxlKFQBOG1C7docFv3x4toghpUPQyST0fFu3kziC7wIgxPa7QG6cMllFC/G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(376002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1076003)(2616005)(6666004)(6512007)(6506007)(86362001)(36756003)(38100700002)(5660300002)(4326008)(8936002)(8676002)(44832011)(83380400001)(66476007)(66556008)(66946007)(41300700001)(2906002)(478600001)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lbEMNcGfANH7VyryIBVINanWY/C5guU4pVUsbjYXpo1Nvew/kkHhynIu6Qwa?=
 =?us-ascii?Q?ewR3mTKqkWcvcTJvjg3pdoAD7xF4ofaeIODzx/9eFdQvjMrwvMhqnS0g02+8?=
 =?us-ascii?Q?hofxoDbSM2R1gBJmeAWJ8nrsMS/yXKGjP9D1QPC+4ywzafs+TK6lnt9VXz0k?=
 =?us-ascii?Q?mpMziiLSftES6Y9P6/5Yw5RqrSBlOSSa3gjMH/x1/DXwWB/m4c+w/1BZEJMA?=
 =?us-ascii?Q?6sz84BkxZzhH/Vl4A/cR0DMrteeNAMN3cjrgqAPY/himgBtF+7aSGPNHb92Z?=
 =?us-ascii?Q?X6NUH4Op2lazdWVnH1SP870R5K5lnAfXcpx6ie1C9wduMdVHeQhCN1cfOoqa?=
 =?us-ascii?Q?fJMBhwahH8IaPgThDBzbSs4hBHBdeRYbhtjz5gdIVBdFG6OlMvMH1IdvapaO?=
 =?us-ascii?Q?GFmU0kIflA9Ogw9qPu5fRAm69s0Z7aiPVcNL4n62B5h0o6v9JTe57O/gM1Dn?=
 =?us-ascii?Q?awlflArqtVvc0cwAdW1TKf/6AUUN2gx+yKJ0xdg312oirNqinIQ7pxtMFA6x?=
 =?us-ascii?Q?Z22+Z1hrGfQl+Lyq25RrMZhyNPJ9v5BefP+xaoqBtTZJnPgphuINIlhZ6hrr?=
 =?us-ascii?Q?+ZosMTcpZiME5a28nAaTDsV9H5sNxJfcOwhmEz8AMxHDz59ws268Sn72sJIV?=
 =?us-ascii?Q?DLmSg5rgA/GgdRj4PMhc6qVODZc0AbhzpojQEFaeoAz6iSNzQaEpdMuQktul?=
 =?us-ascii?Q?Ea/fQvC2AtHp2h83siBmtXplFPoEIhxTOlLNQPTTNQO6pzaU0bFnqJX3sffk?=
 =?us-ascii?Q?qDesu5/A+l/13SkeU8OfLmx5ZtlPPvh8DFeCVLbX5tiWE/p4IAXU01pyK9wH?=
 =?us-ascii?Q?fFlgS6yIqUZZuFw5uva9coDxxFw6E+OJ/OrpM2Z1k2Mbleww5CvGjizMBFlI?=
 =?us-ascii?Q?Ay2nDDAMKCWmpxK2X/7YsnRP4NJuPqUuXfvIQrPtuUq7NU3uqz/6ECRFx32y?=
 =?us-ascii?Q?+gGVTksQQxKBX4EYkDPQA0gfhgl+mCTxHfHsRaZKa5fHJGUa5we3IobupfSm?=
 =?us-ascii?Q?V6P8PaTB9o9jY6r82fojzy+khYmcNtAm7fYZA+vyh+rFpAGdwbpb6QoWIP9d?=
 =?us-ascii?Q?XCE+u7cYKRCJFywfUlBW8bpRjtQEvBPuIMJZANQMbbp1IeI0fgbRVyBEjZ9H?=
 =?us-ascii?Q?brR7PLaWVlYmkwJSknKrc/JeRRayCDcnMHyZfSZA/LrdaN3KYJQtKDWAZcUV?=
 =?us-ascii?Q?XW0zCyOaTfxJldMsYhyH7E7plLW4NnLhtNWRx2Igpwxnrn+ba/Rox2hyekoS?=
 =?us-ascii?Q?PXIB7v3vPPi+K2HMIt3koacrWCHcKPzJvRpUAoVp/Xn1nYwVn2ExzUR34TZQ?=
 =?us-ascii?Q?bF41e7Doh99VsrW+qv0X++G2J0OtuGYg3/Me3x7OodiDo7pntJ2wG5MEcosN?=
 =?us-ascii?Q?zWsRZbITnJh+mbxS9hs3ZYH0Hh5aF+62ZiW8Gn0Ql4PnXzBgH3uQvNKjjEkv?=
 =?us-ascii?Q?QozJ5CxWG9PDoL0qtqMhf03yM8xQBQyrPAGMBHFatpJcS1LdPITPThXVT3X1?=
 =?us-ascii?Q?yfIsYO7QcOYvRFA/8g8UtcQhDyI0wozCYgO50brHKRfmDg2ckI5Ey86qjW/0?=
 =?us-ascii?Q?dhk2UPv0IX+r0QpiBX8ePDSsY6yRmzep7ZZMV26YXMc1wW07R0skkh4GfpIX?=
 =?us-ascii?Q?dQgrGQ/MrXWtXWNkwitfKcI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: h5n02neaNrFvGsEZ8TmO3+9snOAznbZilMtDhYxEwQ33nSnU0MQt8fXpsOxHKIAFraI3SUVNlrpyVSuOswPLGwweVF0mfSG3rvGs0hWSmGzRbYo0pY3MYmQVVsnPQYIjjTsuD3GQ2yebqWxO4/fp6FK2rqPhSzCUI5qeFbGZ7hkv3lfb1dGgpFJ6ITaHSnS+Gg0boHJGdm+jA1fwUHAVUvGdLuefXLOQ1EniF/DCuBHKqy5h5hoWiAQnpWxryjdLJq2AWhAe/Al/sFKWsOmbniGgxbYL0WgIgec7dJRrW7U+y2SYw5SSYfjLeTr4UFchldD3hwUuDKJJt8djeURSlwVz2AlvDeS0IObY0H0SRyrFSOq1XwbFuMmfgDxePBTd9titGTbbLxdFe7qHfCgDzBeBp7DYjRq1vM+1l27wF1L8qCUAApocbyN1hUZXPF4XjK8bcD+gaF6xm/cN3OyvOtWcB6H5T8Eax0e394H3n+p2bokB2PFqRVZO7cHtX1p+wqy3iDICB4ggigLz8ibokgvlsycm7tq2H3YyejmHT8kB2MhSfbOPrARkmD8Y5U2l2UAgqPfkcAzyt4UNEWMlFE3uOfWpusrCEZ4QL86S5ek=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5197c060-8019-4eda-ec3b-08dbfc1d485d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 20:51:30.4103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7pJcx7oyErcB/wnMDfbqGJhMoQRabhCcFhGK6WOVHM2EioOf2ywsOJFkyVIBSsg6TQAE8pJFltFlnFQd3GJjQ/Z86jdkAat1zrC7YJJgMLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4457
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_14,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130147
X-Proofpoint-ORIG-GUID: ED5yN3-2kqLJG_LkWK5hcCERrN6R97Mb
X-Proofpoint-GUID: ED5yN3-2kqLJG_LkWK5hcCERrN6R97Mb
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mas_preallocate() defaults to requesting 1 node for preallocation and then
,depending on the type of store, will update the request variable. There
isn't a check for a slot store type, so slot stores are preallocating the
default 1 node. Slot stores do not require any additional nodes, so add a
check for the slot store case that will bypass node_count_gfp(). Update
the tests to reflect that slot stores do not require allocations.

User visible effects of this bug include increased memory usage from the
unneeded node that was allocated.

Fixes: 0b8bb544b1a7 ("maple_tree: update mas_preallocate() testing")
Cc: <stable@vger.kernel.org> # 6.6+
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
v1->v2:
	fix coding style per Matthew and Andrew
	use wr_mas->node_end to fix build error


 lib/maple_tree.c                 | 11 +++++++++++
 tools/testing/radix-tree/maple.c |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index bb24d84a4922f..684689457d77f 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5501,6 +5501,17 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 
 	mas_wr_end_piv(&wr_mas);
 	node_size = mas_wr_new_end(&wr_mas);
+
+	/* Slot store, does not require additional nodes */
+	if (node_size == wr_mas.node_end) {
+		/* reuse node */
+		if (!mt_in_rcu(mas->tree))
+			return 0;
+		/* shifting boundary */
+		if (wr_mas.offset_end - mas->offset == 1)
+			return 0;
+	}
+
 	if (node_size >= mt_slots[wr_mas.type]) {
 		/* Split, worst case for now. */
 		request = 1 + mas_mt_height(mas) * 2;
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index e5da1cad70baf..76a8990bb14e8 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -35538,7 +35538,7 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated != 1);
+	MT_BUG_ON(mt, allocated != 0);
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 
-- 
2.42.0

