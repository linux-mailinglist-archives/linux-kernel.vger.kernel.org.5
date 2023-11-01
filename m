Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8A37DE534
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344793AbjKARRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344870AbjKARR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:17:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8093412A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:17:07 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1GYeTB004737;
        Wed, 1 Nov 2023 17:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=iUuMeVyiSM8cgrYenfJCqLYrjI5fIrOBba65Y8avBwo=;
 b=2tmTGx9V7dGKGbN9dKJkisvwZXX2zClMvhY7XdoWQKgTshasGeAz3kaoHKGQlhgtPx1u
 0ViCpa+75ApAFX4TfVgPqVJKi41L04AK5RvVnZ1sDMnjpQLHxPc7J3dawtnOJMi/RQln
 V9X2On6xEIWsv2/LqrRNkdvQobe3St1/t/2+Up418Pt7GdNR6pAOrt2grJp+q7L/8KtX
 bz/lSxq0cQPyV/zhqe3FF5fqQ2OU35gKlPA5fV3YgXzF1dfNVA/KvrgO1mgNj+6Wr1w8
 3uNJ7DesJ4s+8/q9pN7FGL1vziIy28flUdTfzK3lhflETiRvjvjeE7fuVi1vqg5dgD6p Pg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0tuufuex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 17:16:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1H7nw7038146;
        Wed, 1 Nov 2023 17:16:54 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rrdjy1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 17:16:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qtr2j8DsO5n9AgmwqF/yn2fM08KLjmbLgC/A5F2uzpur1Nl40zeJ9dCFe4iYqE+fTxN2xzEahRHUjdo2siTKgz+jhkew5cJKRkt0SnUyf/3teyvcsI4SZhu3kcVz2q0o4EhjpCSmf7xi1xQA0R8qS2e6gLt0WpMYd9uXBsMb3gUHjE1bvHSJ2pdjLIlU/zhM1YiLtSH3cSudnlI8h7YlavAOQt9SxbFqK24Ub1PRgZoJAitVH/HAgWO/hCA76bkE6HcUt1m2pjQV0VPGmFj8IdSmUu1VrUtLFxnijo+HoV+xxMMG3/ino84fZ9qbkZdz78kG4oR6/jlbdcfWznMKLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUuMeVyiSM8cgrYenfJCqLYrjI5fIrOBba65Y8avBwo=;
 b=HUca+udS8RS1V0szcwIDHyNTKx2/nT7udVduGkgRPLqU4DZCiJYkQheqt+Om1XtIu64xaRciPISmt5c/2X2B+h6bQHYF3sqds0eHltwqWnIRakVBTgAhUtuaaFuASzJgnmvBpadLbx+LbdciwpfxMIrIyxUj515Ly5TAWdhKm/pgyOvE0pa10LGrnDDjf18Ur3iSXiXPey9zOjIsLYmZumFxuU1jKW9kNhGTZ0BDKw6aIyz9cvZq5h1bI0Lcft2euI1f8+YOBem3pv4Lfclw4pW2ijJuj0OGS40tcV2zSd/IDVNjtC1aicSduQYlbHOLZQcCdDrq7CZ6+Uu9ewQcMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUuMeVyiSM8cgrYenfJCqLYrjI5fIrOBba65Y8avBwo=;
 b=KHc9gk478rQ73Ejx0JxswbJhOykQkqjwd7VnzCDEKH6wYY1g46ubL9RWWBg7V97lr4E8dQtnNFyDlgyPaV3yMegqAVMqe+R/MLMWdc6k+doRYKx1Aad8LUDs2jB8AO75wsy5bqMQc+Lxs71qx0P7jR+JhjOaNgQILqawqCOKpnM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB7684.namprd10.prod.outlook.com (2603:10b6:806:38e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 1 Nov
 2023 17:16:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6907.025; Wed, 1 Nov 2023
 17:16:51 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 08/12] maple_tree: Separate ma_state node from status.
Date:   Wed,  1 Nov 2023 13:16:25 -0400
Message-Id: <20231101171629.3612299-9-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231101171629.3612299-1-Liam.Howlett@oracle.com>
References: <20231101171629.3612299-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0132.namprd03.prod.outlook.com
 (2603:10b6:408:fe::17) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c6a70d-1038-4b46-bee8-08dbdafe569f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f9CRoJwu6dlmHlpm1CWFGCBofO2sK8Uid7iraQAaafDEYwiCiyjMHFT6+lqhBx4qr5GLZMrpBy1iTqQxrcj8Ow+H6K51pRqrboHtgISuS3y7gGMoFnx10upiJZTVXyR+H+8a4R3INVw8jdW4Fnn9yXs25HjytzaMjXqqvU6ydVVgXJW2GOpFZAkc65ZAgL2bGbOPad7JnJttubY+NCDsxoF/4L04lPskaq1eJ1NnnynWw3x2yhkUo3tdFDdce0xwW+pBZ7txKDxc3UyVIxvCSAZv8vCG3JdigIF43/USSid7EvjzU6yvKXeQWYix1ZokDD0dqrTD9/M8TJobXewrZEsvKNadA6YH1f6LtJ13MFLfwio/0NaTZOyH8xHDA76pRBakyQlx6L7S+OesGKQ7Zbq16CRaFH5gzjSGMCVKzilNJ0hITQ1GPLOvpA7WPx4agFg1b96/cvx5LxfqHVE5jChKU10dUv7JlGMRuPQcuSewRYKwAybAsgvRsWDftbkDR9/oe/ejGKXEF7hGCg6/FSRvtNjX0TORVScK2qmTOmoChspoouwZrU+Hz81j6a8i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6486002)(8936002)(2906002)(4326008)(30864003)(41300700001)(8676002)(5660300002)(6666004)(6506007)(66476007)(107886003)(83380400001)(1076003)(2616005)(36756003)(26005)(6512007)(38100700002)(316002)(86362001)(478600001)(66556008)(6916009)(66946007)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g09pnp2kLGAK9uBNFvq78UNSUIIeTlNk/OAX84Zlyvv1L6KJRjgTBY4ZAqFK?=
 =?us-ascii?Q?sa+ICdmEn/+1fV28VVCH+a+5aTsYAekxgzSEjxceEAbyBAFII2O7Lt7BaSmg?=
 =?us-ascii?Q?PAMs1c0R/9PCicuvI9IPykFQFVCDmGo0qQ4CaGsjz68oVgaINBZYNx10ATer?=
 =?us-ascii?Q?RLYbo+J5bBAViXKjn3f4xNgl9yO6WaNQxtdsNh6Or7wiFCGlluejqpx7sNON?=
 =?us-ascii?Q?z02il+qBBXhX7lW7z92cKZGux6zGY0ZJe9XZzhhXYe6gblno15702rgAOKnh?=
 =?us-ascii?Q?Im4hM4BRHR3H83hKW5zFfd9EiZbrjNRoVIrMtJ4+6nFLmehLwNk0Sqnc8Lk+?=
 =?us-ascii?Q?q/vu0ExEiGO8a+02klp7UxGrKFRLXcwhGKbYM70ETql87n0gCB40JeukAZHG?=
 =?us-ascii?Q?JRwMsWCbF7gXCceYOEeP13Ghg5aZyMInc209vnkNzpYIiP6BjmOtiFcUg+46?=
 =?us-ascii?Q?/lndyC1V5np9amW+7EKb9qlBNCAwnZ3hvMCiB7VsZZu/N1rQsw8CdhD45T+e?=
 =?us-ascii?Q?afATINspHQcCzsG1jhvo12A3TpVBklj8gU6wKG6MWxSFfEzM84ScNxUlKuH7?=
 =?us-ascii?Q?44cz75eOFVst5bAKSOARqGBusseJOc4Wbyl5e4GRd9E+eNvBGUOuFZIOWNHI?=
 =?us-ascii?Q?q7C/qiRQp02NN7xJv/xLjePZbMnnj/zFUXSA3J+xtx+x/EXi0b7wrpIuQY5f?=
 =?us-ascii?Q?w7rsv6rgzeLGVicOH+sjCHam6GIrN2lWnNDoYWc4c+BU2Dl2/K+hOjxVahIV?=
 =?us-ascii?Q?aBotKX3EdfrrD0+JsCdLBGditNBHdR5zn1hYDO9TzaVwnBRvCH5gDK+caMCv?=
 =?us-ascii?Q?rjP+YfJtmPPxvkDq5bmCIw9SeoEG6xWHyrL3iQ1g0KSLClMt4NUC6+Klva9g?=
 =?us-ascii?Q?wooOnvZ6vABnHZLGlftKzEZFwyYKcSxZGXux03xhOvyb3ZDGDBDUBxI+7FIb?=
 =?us-ascii?Q?ccoJfIpsW7zZVWczuIdPabq69KXCWo9MtT2z9rd607xCBrG9i24KnB9Z2f1S?=
 =?us-ascii?Q?idAwndO3SluNZNU+8jNXlzimiunGh5/kIykPB+pJsK9W4sm+1ue4v0eFSnNp?=
 =?us-ascii?Q?s2o0efdfY9Bw3IINsE5IoBKMIQpRqn4LB/lzIoTQfL19znVJTBFE2Ukxq6S1?=
 =?us-ascii?Q?rk1F4HN1W90ElpEEWWzSg5jpTtlpY7RT8IolCM0q3/Ooh4plL+7YmvgZIlO3?=
 =?us-ascii?Q?KVj+VCtMbDrjvealgf+LIMbcLjpJwBtkWv1QPdqopTKqbS+0cVr2wErcLCNr?=
 =?us-ascii?Q?gYykHo2ZodpXDERLD01czAfwmEyAlniflnnK6BpdQ2H6iyCIlq/aijRlsUyA?=
 =?us-ascii?Q?1fxHp0qzq4xJyILo4aIFt2c1KuZ+1qX2C40EJlOyicvpZeRKq9YwYzki+GM1?=
 =?us-ascii?Q?kBjqo+wZzu3liFandS5y0k88Ntfic2UQ8+zC5JY3njaikKwpY+U8cSPCGmnc?=
 =?us-ascii?Q?ZEEp8+DGXkwbOriF/mZgratsxSYodWnSfwYKv5ounS7aBGS1OpMUDadKzkVf?=
 =?us-ascii?Q?FH720Tq3PwhDM69rr+yVbrGLuhVw38BjJHguji0fMjaukziybiEbL3nS0wE9?=
 =?us-ascii?Q?DdFAR8jHJyfecMfdCHrOHZiebMGBorQHeIcyCWVDoylmEfKPODdFCeVEzuQa?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5RSrrUU4uy2YTCjxYP+UUjjq18cQN37+ilcb34NgBobo4tmqiwqUu2rjVV4Gz1ARRfJORkMkIfyUFrh3ivMwNxBgbT1TS6DhAv37zbukmwIi+YV5ba619fs7LF5GsqV1hZ7lHim9+ym+D2LN33XX6amGSLjbIlwgp+Lt9G3A0ybZ2+QeFOzIZbv/qxWn/XR45ZvWt3oiJ0SbYPozkhiGoB+pW4sERIT7+uQuGPGC4iDH35zoIVlHNjy3XYX6TK8geqjmvClznQzUYWTG5ls37tj/svItx8Yvki4gSTfbWqwhPeXOEnFJ5MraPRfjsXRoZZr3Hr7xeeR99+UeVwbKo3G5TCe0TxCyZhNSUsvzXZcRiIXNSEWSKt6gMRm+CHFSm+oSfnweD1YOQwYk4+Yj9oizVUzeR1NxRTKiz8Gvp/xlPQ6Vu54rWbnCxPpnsN0nvoIkJ3CBB6qov+glyx4NU80Z+CoIRoG8ZHOIXRGzuxEBJSGT46U5IHY7+bkUoHCO5NSY2H2N/KhHB1Hqj/YXlKxk5+amZYQhzkDINVPxXE3sI7Sgj1WHbs2NRK7F8La0OuQ0zowQqtB80otdulz+MZnwBPeop1l6SNrlZb2o/ZFqPbKSnLZpaWlPoNrb8hALQPJsVhJVFkYG89g67OXkgR8lgfeVHra+ocjzDvRoMgQwPHWd66ispKsCsRswFQ3325fk6TFCI3lxlwROJtikgyR9u4U6GNpvgDjwMpNtxdZ3f0UMO6odDoBNi2q3B+ioZe9SpZph2K8p3bLvB6/6FkH/RPVtPM2RC3qd/yeD/XMVDoHTQVr1hmhAcq/E20sLKSOqaZUfzHHfIpEOXMV/63GTZIZprEqvjg4RMXn3ZTb5CBcSO++I+jWoCwKx1WkyPEEU7nRSqvWTCSzOX0ILhA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c6a70d-1038-4b46-bee8-08dbdafe569f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 17:16:51.4795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Y2tBS/Lazmz56PN0/TDobJEfDJ0RBH6Haq7G14NRRo8NuhbPeu/x4Jsl/FJ9PWlmN+qL+vX3czJGUFIOGK/hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7684
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_15,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311010134
X-Proofpoint-GUID: MEUG7Yg0TZEvfVWMcvefqNqG6U647Wxe
X-Proofpoint-ORIG-GUID: MEUG7Yg0TZEvfVWMcvefqNqG6U647Wxe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree node is overloaded to keep status as well as the active
node.  This, unfortunately, results in a re-walk on underflow or
overflow.  Since the maple state has room, the status can be placed in
its own enum in the structure.  Once an underflow/overflow is detected,
certain modes can restore the status to active and others may need to
re-walk just that one node to see the entry.

The status being an enum has the benefit of detecting unhandled status
in switch statements.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h       |  87 ++++---
 include/linux/mm_types.h         |   3 +-
 lib/maple_tree.c                 | 425 ++++++++++++++++++-------------
 lib/test_maple_tree.c            | 180 ++++++-------
 mm/internal.h                    |   8 +-
 tools/testing/radix-tree/maple.c |  22 +-
 6 files changed, 415 insertions(+), 310 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 97a6adedb376..e3789b63388a 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -344,6 +344,36 @@ static inline bool mtree_empty(const struct maple_tree *mt)
 
 /* Advanced API */
 
+/*
+ * Maple State Status
+ * ma_active means the maple state is pointing to a node and offset and can
+ * continue operating on the tree.
+ * ma_start means we have not searched the tree.
+ * ma_root means we have searched the tree and the entry we found lives in
+ * the root of the tree (ie it has index 0, length 1 and is the only entry in
+ * the tree).
+ * ma_none means we have searched the tree and there is no node in the
+ * tree for this entry.  For example, we searched for index 1 in an empty
+ * tree.  Or we have a tree which points to a full leaf node and we
+ * searched for an entry which is larger than can be contained in that
+ * leaf node.
+ * ma_pause means the data within the maple state may be stale, restart the
+ * operation
+ * ma_overflow means the search has reached the upper limit of the search
+ * ma_underflow means the search has reached the lower limit of the search
+ * ma_error means there was an error, check the node for the error number.
+ */
+enum maple_status {
+	ma_active,
+	ma_start,
+	ma_root,
+	ma_none,
+	ma_pause,
+	ma_overflow,
+	ma_underflow,
+	ma_error,
+};
+
 /*
  * The maple state is defined in the struct ma_state and is used to keep track
  * of information during operations, and even between operations when using the
@@ -376,6 +406,13 @@ static inline bool mtree_empty(const struct maple_tree *mt)
  * When returning a value the maple state index and last respectively contain
  * the start and end of the range for the entry.  Ranges are inclusive in the
  * Maple Tree.
+ *
+ * The status of the state is used to determine how the next action should treat
+ * the state.  For instance, if the status is ma_start then the next action
+ * should start at the root of the tree and walk down.  If the status is
+ * ma_pause then the node may be stale data and should be discarded.  If the
+ * status is ma_overflow, then the last action hit the upper limit.
+ *
  */
 struct ma_state {
 	struct maple_tree *tree;	/* The tree we're operating in */
@@ -385,6 +422,7 @@ struct ma_state {
 	unsigned long min;		/* The minimum index of this node - implied pivot min */
 	unsigned long max;		/* The maximum index of this node - implied pivot max */
 	struct maple_alloc *alloc;	/* Allocated nodes for this operation */
+	enum maple_status status;	/* The status of the state (active, start, none, etc) */
 	unsigned char depth;		/* depth of tree descent during write */
 	unsigned char offset;
 	unsigned char mas_flags;
@@ -409,28 +447,12 @@ struct ma_wr_state {
 #define mas_lock(mas)           spin_lock(&((mas)->tree->ma_lock))
 #define mas_unlock(mas)         spin_unlock(&((mas)->tree->ma_lock))
 
-
 /*
  * Special values for ma_state.node.
- * MAS_START means we have not searched the tree.
- * MAS_ROOT means we have searched the tree and the entry we found lives in
- * the root of the tree (ie it has index 0, length 1 and is the only entry in
- * the tree).
- * MAS_NONE means we have searched the tree and there is no node in the
- * tree for this entry.  For example, we searched for index 1 in an empty
- * tree.  Or we have a tree which points to a full leaf node and we
- * searched for an entry which is larger than can be contained in that
- * leaf node.
  * MA_ERROR represents an errno.  After dropping the lock and attempting
  * to resolve the error, the walk would have to be restarted from the
  * top of the tree as the tree may have been modified.
  */
-#define MAS_START	((struct maple_enode *)1UL)
-#define MAS_ROOT	((struct maple_enode *)5UL)
-#define MAS_NONE	((struct maple_enode *)9UL)
-#define MAS_PAUSE	((struct maple_enode *)17UL)
-#define MAS_OVERFLOW	((struct maple_enode *)33UL)
-#define MAS_UNDERFLOW	((struct maple_enode *)65UL)
 #define MA_ERROR(err) \
 		((struct maple_enode *)(((unsigned long)err << 2) | 2UL))
 
@@ -439,7 +461,8 @@ struct ma_wr_state {
 		.tree = mt,						\
 		.index = first,						\
 		.last = end,						\
-		.node = MAS_START,					\
+		.node = NULL,						\
+		.status = ma_start,					\
 		.min = 0,						\
 		.max = ULONG_MAX,					\
 		.alloc = NULL,						\
@@ -470,7 +493,6 @@ void *mas_find_range(struct ma_state *mas, unsigned long max);
 void *mas_find_rev(struct ma_state *mas, unsigned long min);
 void *mas_find_range_rev(struct ma_state *mas, unsigned long max);
 int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp);
-bool mas_is_err(struct ma_state *mas);
 
 bool mas_nomem(struct ma_state *mas, gfp_t gfp);
 void mas_pause(struct ma_state *mas);
@@ -499,28 +521,18 @@ static inline void mas_init(struct ma_state *mas, struct maple_tree *tree,
 	mas->tree = tree;
 	mas->index = mas->last = addr;
 	mas->max = ULONG_MAX;
-	mas->node = MAS_START;
+	mas->status = ma_start;
+	mas->node = NULL;
 }
 
-/* Checks if a mas has not found anything */
-static inline bool mas_is_none(const struct ma_state *mas)
-{
-	return mas->node == MAS_NONE;
-}
-
-/* Checks if a mas has been paused */
-static inline bool mas_is_paused(const struct ma_state *mas)
+static inline bool mas_is_active(struct ma_state *mas)
 {
-	return mas->node == MAS_PAUSE;
+	return mas->status == ma_active;
 }
 
-/* Check if the mas is pointing to a node or not */
-static inline bool mas_is_active(struct ma_state *mas)
+static inline bool mas_is_err(struct ma_state *mas)
 {
-	if ((unsigned long)mas->node >= MAPLE_RESERVED_RANGE)
-		return true;
-
-	return false;
+	return mas->status == ma_error;
 }
 
 /**
@@ -533,9 +545,10 @@ static inline bool mas_is_active(struct ma_state *mas)
  *
  * Context: Any context.
  */
-static inline void mas_reset(struct ma_state *mas)
+static __always_inline void mas_reset(struct ma_state *mas)
 {
-	mas->node = MAS_START;
+	mas->status = ma_start;
+	mas->node = NULL;
 }
 
 /**
@@ -709,7 +722,7 @@ static inline void __mas_set_range(struct ma_state *mas, unsigned long start,
 static inline
 void mas_set_range(struct ma_state *mas, unsigned long start, unsigned long last)
 {
-	mas->node = MAS_START;
+	mas_reset(mas);
 	__mas_set_range(mas, start, last);
 }
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 36c5b43999e6..59de72d8bff8 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1014,7 +1014,8 @@ struct vma_iterator {
 		.mas = {						\
 			.tree = &(__mm)->mm_mt,				\
 			.index = __addr,				\
-			.node = MAS_START,				\
+			.node = NULL,					\
+			.status = ma_start,				\
 		},							\
 	}
 
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 5c4ab10ded3d..fa66c0c031d5 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -237,40 +237,40 @@ static __always_inline bool mt_is_reserved(const void *entry)
 		xa_is_internal(entry);
 }
 
-static inline void mas_set_err(struct ma_state *mas, long err)
+static __always_inline void mas_set_err(struct ma_state *mas, long err)
 {
 	mas->node = MA_ERROR(err);
+	mas->status = ma_error;
 }
 
-static inline bool mas_is_ptr(const struct ma_state *mas)
+static __always_inline bool mas_is_ptr(const struct ma_state *mas)
 {
-	return mas->node == MAS_ROOT;
+	return mas->status == ma_root;
 }
 
-static inline bool mas_is_start(const struct ma_state *mas)
+static __always_inline bool mas_is_start(const struct ma_state *mas)
 {
-	return mas->node == MAS_START;
+	return mas->status == ma_start;
 }
 
-bool mas_is_err(struct ma_state *mas)
+static __always_inline bool mas_is_none(const struct ma_state *mas)
 {
-	return xa_is_err(mas->node);
+	return mas->status == ma_none;
 }
 
-static __always_inline bool mas_is_overflow(struct ma_state *mas)
+static __always_inline bool mas_is_paused(const struct ma_state *mas)
 {
-	if (unlikely(mas->node == MAS_OVERFLOW))
-		return true;
-
-	return false;
+	return mas->status == ma_pause;
 }
 
-static __always_inline bool mas_is_underflow(struct ma_state *mas)
+static __always_inline bool mas_is_overflow(struct ma_state *mas)
 {
-	if (unlikely(mas->node == MAS_UNDERFLOW))
-		return true;
+	return mas->status == ma_overflow;
+}
 
-	return false;
+static inline bool mas_is_underflow(struct ma_state *mas)
+{
+	return mas->status == ma_underflow;
 }
 
 static inline bool mas_searchable(struct ma_state *mas)
@@ -1262,6 +1262,7 @@ static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
 	if (mas->mas_flags & MA_STATE_PREALLOC) {
 		if (allocated)
 			return;
+		BUG_ON(!allocated);
 		WARN_ON(!allocated);
 	}
 
@@ -1367,14 +1368,14 @@ static void mas_node_count(struct ma_state *mas, int count)
  * mas_start() - Sets up maple state for operations.
  * @mas: The maple state.
  *
- * If mas->node == MAS_START, then set the min, max and depth to
+ * If mas->status == mas_start, then set the min, max and depth to
  * defaults.
  *
  * Return:
- * - If mas->node is an error or not MAS_START, return NULL.
- * - If it's an empty tree:     NULL & mas->node == MAS_NONE
- * - If it's a single entry:    The entry & mas->node == MAS_ROOT
- * - If it's a tree:            NULL & mas->node == safe root node.
+ * - If mas->node is an error or not mas_start, return NULL.
+ * - If it's an empty tree:     NULL & mas->status == ma_none
+ * - If it's a single entry:    The entry & mas->status == mas_root
+ * - If it's a tree:            NULL & mas->status == safe root node.
  */
 static inline struct maple_enode *mas_start(struct ma_state *mas)
 {
@@ -1390,6 +1391,7 @@ static inline struct maple_enode *mas_start(struct ma_state *mas)
 		/* Tree with nodes */
 		if (likely(xa_is_node(root))) {
 			mas->depth = 1;
+			mas->status = ma_active;
 			mas->node = mte_safe_root(root);
 			mas->offset = 0;
 			if (mte_dead_node(mas->node))
@@ -1400,13 +1402,14 @@ static inline struct maple_enode *mas_start(struct ma_state *mas)
 
 		/* empty tree */
 		if (unlikely(!root)) {
-			mas->node = MAS_NONE;
+			mas->node = NULL;
+			mas->status = ma_none;
 			mas->offset = MAPLE_NODE_SLOTS;
 			return NULL;
 		}
 
 		/* Single entry tree */
-		mas->node = MAS_ROOT;
+		mas->status = ma_root;
 		mas->offset = MAPLE_NODE_SLOTS;
 
 		/* Single entry tree. */
@@ -2220,12 +2223,16 @@ static inline bool mas_next_sibling(struct ma_state *mas)
  *
  * Return: @enode or MAS_NONE
  */
-static inline struct maple_enode *mte_node_or_none(struct maple_enode *enode)
+static inline void mas_node_or_none(struct ma_state *mas,
+		struct maple_enode *enode)
 {
-	if (enode)
-		return enode;
-
-	return ma_enode_ptr(MAS_NONE);
+	if (enode) {
+		mas->node = enode;
+		mas->status = ma_active;
+	} else {
+		mas->node = NULL;
+		mas->status = ma_none;
+	}
 }
 
 /*
@@ -2545,13 +2552,15 @@ static inline void mast_set_split_parents(struct maple_subtree_state *mast,
  * The node will either be RCU freed or pushed back on the maple state.
  */
 static inline void mas_topiary_node(struct ma_state *mas,
-		struct maple_enode *enode, bool in_rcu)
+		struct ma_state *tmp_mas, bool in_rcu)
 {
 	struct maple_node *tmp;
+	struct maple_enode *enode;
 
-	if (enode == MAS_NONE)
+	if (mas_is_none(tmp_mas))
 		return;
 
+	enode = tmp_mas->node;
 	tmp = mte_to_node(enode);
 	mte_set_node_dead(enode);
 	if (in_rcu)
@@ -2591,8 +2600,8 @@ static inline void mas_topiary_replace(struct ma_state *mas,
 	/* Update the parent pointers in the tree */
 	tmp[0] = *mas;
 	tmp[0].offset = 0;
-	tmp[1].node = MAS_NONE;
-	tmp[2].node = MAS_NONE;
+	tmp[1].status = ma_none;
+	tmp[2].status = ma_none;
 	while (!mte_is_leaf(tmp[0].node)) {
 		n = 0;
 		for (i = 0; i < 3; i++) {
@@ -2612,7 +2621,7 @@ static inline void mas_topiary_replace(struct ma_state *mas,
 			break;
 
 		while (n < 3)
-			tmp_next[n++].node = MAS_NONE;
+			tmp_next[n++].status = ma_none;
 
 		for (i = 0; i < 3; i++)
 			tmp[i] = tmp_next[i];
@@ -2625,8 +2634,8 @@ static inline void mas_topiary_replace(struct ma_state *mas,
 	tmp[0] = *mas;
 	tmp[0].offset = 0;
 	tmp[0].node = old_enode;
-	tmp[1].node = MAS_NONE;
-	tmp[2].node = MAS_NONE;
+	tmp[1].status = ma_none;
+	tmp[2].status = ma_none;
 	in_rcu = mt_in_rcu(mas->tree);
 	do {
 		n = 0;
@@ -2641,7 +2650,7 @@ static inline void mas_topiary_replace(struct ma_state *mas,
 				if ((tmp_next[n].min >= tmp_next->index) &&
 				    (tmp_next[n].max <= tmp_next->last)) {
 					mat_add(&subtrees, tmp_next[n].node);
-					tmp_next[n].node = MAS_NONE;
+					tmp_next[n].status = ma_none;
 				} else {
 					n++;
 				}
@@ -2652,16 +2661,16 @@ static inline void mas_topiary_replace(struct ma_state *mas,
 			break;
 
 		while (n < 3)
-			tmp_next[n++].node = MAS_NONE;
+			tmp_next[n++].status = ma_none;
 
 		for (i = 0; i < 3; i++) {
-			mas_topiary_node(mas, tmp[i].node, in_rcu);
+			mas_topiary_node(mas, &tmp[i], in_rcu);
 			tmp[i] = tmp_next[i];
 		}
 	} while (!mte_is_leaf(tmp[0].node));
 
 	for (i = 0; i < 3; i++)
-		mas_topiary_node(mas, tmp[i].node, in_rcu);
+		mas_topiary_node(mas, &tmp[i], in_rcu);
 
 	mas_mat_destroy(mas, &subtrees);
 }
@@ -2700,9 +2709,9 @@ static inline void mast_cp_to_nodes(struct maple_subtree_state *mast,
 {
 	bool new_lmax = true;
 
-	mast->l->node = mte_node_or_none(left);
-	mast->m->node = mte_node_or_none(middle);
-	mast->r->node = mte_node_or_none(right);
+	mas_node_or_none(mast->l, left);
+	mas_node_or_none(mast->m, middle);
+	mas_node_or_none(mast->r, right);
 
 	mast->l->min = mast->orig_l->min;
 	if (split == mast->bn->b_end) {
@@ -2882,7 +2891,7 @@ static int mas_spanning_rebalance(struct ma_state *mas,
 	mast->l = &l_mas;
 	mast->m = &m_mas;
 	mast->r = &r_mas;
-	l_mas.node = r_mas.node = m_mas.node = MAS_NONE;
+	l_mas.status = r_mas.status = m_mas.status = ma_none;
 
 	/* Check if this is not root and has sufficient data.  */
 	if (((mast->orig_l->min != 0) || (mast->orig_r->max != ULONG_MAX)) &&
@@ -3409,7 +3418,6 @@ static int mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 		/* Try to push left. */
 		if (mas_push_data(mas, height, &mast, true))
 			break;
-
 		/* Try to push right. */
 		if (mas_push_data(mas, height, &mast, false))
 			break;
@@ -3525,6 +3533,7 @@ static inline int mas_root_expand(struct ma_state *mas, void *entry)
 	slots = ma_slots(node, type);
 	node->parent = ma_parent_ptr(mas_tree_parent(mas));
 	mas->node = mt_mk_node(node, type);
+	mas->status = ma_active;
 
 	if (mas->index) {
 		if (contents) {
@@ -3557,7 +3566,7 @@ static inline void mas_store_root(struct ma_state *mas, void *entry)
 		mas_root_expand(mas, entry);
 	else {
 		rcu_assign_pointer(mas->tree->ma_root, entry);
-		mas->node = MAS_START;
+		mas->status = ma_start;
 	}
 }
 
@@ -3789,7 +3798,7 @@ static inline int mas_new_root(struct ma_state *mas, void *entry)
 		mas->depth = 0;
 		mas_set_height(mas);
 		rcu_assign_pointer(mas->tree->ma_root, entry);
-		mas->node = MAS_START;
+		mas->status = ma_start;
 		goto done;
 	}
 
@@ -3802,6 +3811,7 @@ static inline int mas_new_root(struct ma_state *mas, void *entry)
 	slots = ma_slots(node, type);
 	node->parent = ma_parent_ptr(mas_tree_parent(mas));
 	mas->node = mt_mk_node(node, type);
+	mas->status = ma_active;
 	rcu_assign_pointer(slots[0], entry);
 	pivots[0] = mas->last;
 	mas->depth = 1;
@@ -4429,7 +4439,7 @@ static int mas_prev_node(struct ma_state *mas, unsigned long min)
 	if (unlikely(ma_dead_node(node)))
 		return 1;
 
-	mas->node = MAS_NONE;
+	mas->status = ma_underflow;
 	return 0;
 }
 
@@ -4443,8 +4453,7 @@ static int mas_prev_node(struct ma_state *mas, unsigned long min)
  *
  * Return: The entry in the previous slot which is possibly NULL
  */
-static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty,
-			   bool set_underflow)
+static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty)
 {
 	void *entry;
 	void __rcu **slots;
@@ -4482,8 +4491,8 @@ static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty,
 			goto retry;
 		}
 
-		if (mas_is_none(mas))
-			goto underflow;
+		if (WARN_ON_ONCE(mas_is_underflow(mas)))
+			return NULL;
 
 		mas->last = mas->max;
 		node = mas_mn(mas);
@@ -4497,12 +4506,15 @@ static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty,
 	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
 		goto retry;
 
+	if (mas->index <= min)
+		mas->status = ma_underflow;
+
 	if (likely(entry))
 		return entry;
 
 	if (!empty) {
-		if (mas->index <= min)
-			goto underflow;
+		if (mas_is_underflow(mas))
+			return NULL;
 
 		goto again;
 	}
@@ -4510,8 +4522,7 @@ static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty,
 	return entry;
 
 underflow:
-	if (set_underflow)
-		mas->node = MAS_UNDERFLOW;
+	mas->status = ma_underflow;
 	return NULL;
 }
 
@@ -4520,7 +4531,8 @@ static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty,
  * @mas: The maple state
  * @max: The maximum pivot value to check.
  *
- * The next value will be mas->node[mas->offset] or MAS_NONE.
+ * The next value will be mas->node[mas->offset] or the status will have
+ * overflowed.
  * Return: 1 on dead node, 0 otherwise.
  */
 static int mas_next_node(struct ma_state *mas, struct maple_node *node,
@@ -4536,13 +4548,13 @@ static int mas_next_node(struct ma_state *mas, struct maple_node *node,
 	void __rcu **slots;
 
 	if (mas->max >= max)
-		goto no_entry;
+		goto overflow;
 
 	min = mas->max + 1;
 	level = 0;
 	do {
 		if (ma_is_root(node))
-			goto no_entry;
+			goto overflow;
 
 		/* Walk up. */
 		if (unlikely(mas_ascend(mas)))
@@ -4593,11 +4605,11 @@ static int mas_next_node(struct ma_state *mas, struct maple_node *node,
 	mas->min = min;
 	return 0;
 
-no_entry:
+overflow:
 	if (unlikely(ma_dead_node(node)))
 		return 1;
 
-	mas->node = MAS_NONE;
+	mas->status = ma_overflow;
 	return 0;
 }
 
@@ -4612,8 +4624,7 @@ static int mas_next_node(struct ma_state *mas, struct maple_node *node,
  *
  * Return: The entry in the next slot which is possibly NULL
  */
-static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty,
-			   bool set_overflow)
+static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
 {
 	void __rcu **slots;
 	unsigned long *pivots;
@@ -4634,13 +4645,15 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty,
 		if (likely(mas->offset < mas->end))
 			pivot = pivots[mas->offset];
 		else
-			goto overflow;
+			pivot = mas->max;
 
 		if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
 			goto retry;
 
-		if (pivot >= max)
-			goto overflow;
+		if (pivot >= max) {
+			mas->status = ma_overflow;
+			return NULL;
+		}
 	}
 
 	if (likely(mas->offset < mas->end)) {
@@ -4657,11 +4670,8 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty,
 			goto retry;
 		}
 
-		if (WARN_ON_ONCE(mas_is_none(mas))) {
-			mas->node = MAS_OVERFLOW;
+		if (WARN_ON_ONCE(mas_is_overflow(mas)))
 			return NULL;
-			goto overflow;
-		}
 
 		mas->offset = 0;
 		mas->index = mas->min;
@@ -4679,20 +4689,18 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty,
 	if (entry)
 		return entry;
 
+
 	if (!empty) {
-		if (mas->last >= max)
-			goto overflow;
+		if (mas->last >= max) {
+			mas->status = ma_overflow;
+			return NULL;
+		}
 
 		mas->index = mas->last + 1;
 		goto again;
 	}
 
 	return entry;
-
-overflow:
-	if (set_overflow)
-		mas->node = MAS_OVERFLOW;
-	return NULL;
 }
 
 /*
@@ -4711,11 +4719,11 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty,
 static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
 {
 	if (mas->last >= limit) {
-		mas->node = MAS_OVERFLOW;
+		mas->status = ma_overflow;
 		return NULL;
 	}
 
-	return mas_next_slot(mas, limit, false, true);
+	return mas_next_slot(mas, limit, false);
 }
 
 /*
@@ -4883,7 +4891,7 @@ static inline bool mas_anode_descend(struct ma_state *mas, unsigned long size)
  * @mas: The maple state.
  *
  * mas->index and mas->last will be set to the range if there is a value.  If
- * mas->node is MAS_NONE, reset to MAS_START.
+ * mas->node is MAS_NONE, reset to mas_start
  *
  * Return: the entry at the location or %NULL.
  */
@@ -4892,7 +4900,7 @@ void *mas_walk(struct ma_state *mas)
 	void *entry;
 
 	if (!mas_is_active(mas) || !mas_is_start(mas))
-		mas->node = MAS_START;
+		mas->status = ma_start;
 retry:
 	entry = mas_state_walk(mas);
 	if (mas_is_start(mas)) {
@@ -4908,7 +4916,7 @@ void *mas_walk(struct ma_state *mas)
 
 		mas->index = 1;
 		mas->last = ULONG_MAX;
-		mas->node = MAS_NONE;
+		mas->status = ma_none;
 		return NULL;
 	}
 
@@ -5660,27 +5668,40 @@ static bool mas_next_setup(struct ma_state *mas, unsigned long max,
 	bool was_none = mas_is_none(mas);
 
 	if (unlikely(mas->last >= max)) {
-		mas->node = MAS_OVERFLOW;
+		mas->status = ma_overflow;
 		return true;
 	}
 
-	if (mas_is_active(mas))
+	switch (mas->status) {
+	case ma_active:
 		return false;
-
-	if (mas_is_none(mas) || mas_is_paused(mas)) {
-		mas->node = MAS_START;
-	} else if (mas_is_overflow(mas)) {
+	case ma_none:
+		fallthrough;
+	case ma_pause:
+		mas->status = ma_start;
+		fallthrough;
+	case ma_start:
+		mas_walk(mas); /* Retries on dead nodes handled by mas_walk */
+		break;
+	case ma_overflow:
 		/* Overflowed before, but the max changed */
-		mas->node = MAS_START;
-	} else if (mas_is_underflow(mas)) {
-		mas->node = MAS_START;
+		mas->status = ma_active;
+		break;
+	case ma_underflow:
+		/* The user expects the mas to be one before where it is */
+		mas->status = ma_active;
 		*entry = mas_walk(mas);
 		if (*entry)
 			return true;
+		break;
+	case ma_root:
+		break;
+	case ma_error:
+		return true;
 	}
 
-	if (mas_is_start(mas))
-		*entry = mas_walk(mas); /* Retries on dead nodes handled by mas_walk */
+	if (likely(mas_is_active(mas))) /* Fast path */
+		return false;
 
 	if (mas_is_ptr(mas)) {
 		*entry = NULL;
@@ -5690,7 +5711,7 @@ static bool mas_next_setup(struct ma_state *mas, unsigned long max,
 		}
 		mas->index = 1;
 		mas->last = ULONG_MAX;
-		mas->node = MAS_NONE;
+		mas->status = ma_none;
 		return true;
 	}
 
@@ -5719,7 +5740,7 @@ void *mas_next(struct ma_state *mas, unsigned long max)
 		return entry;
 
 	/* Retries on dead nodes handled by mas_next_slot */
-	return mas_next_slot(mas, max, false, true);
+	return mas_next_slot(mas, max, false);
 }
 EXPORT_SYMBOL_GPL(mas_next);
 
@@ -5742,7 +5763,7 @@ void *mas_next_range(struct ma_state *mas, unsigned long max)
 		return entry;
 
 	/* Retries on dead nodes handled by mas_next_slot */
-	return mas_next_slot(mas, max, true, true);
+	return mas_next_slot(mas, max, true);
 }
 EXPORT_SYMBOL_GPL(mas_next_range);
 
@@ -5773,33 +5794,45 @@ EXPORT_SYMBOL_GPL(mt_next);
 static bool mas_prev_setup(struct ma_state *mas, unsigned long min, void **entry)
 {
 	if (unlikely(mas->index <= min)) {
-		mas->node = MAS_UNDERFLOW;
+		mas->status = ma_underflow;
 		return true;
 	}
 
-	if (mas_is_active(mas))
+	switch (mas->status) {
+	case ma_active:
 		return false;
-
-	if (mas_is_overflow(mas)) {
-		mas->node = MAS_START;
+	case ma_start:
+		break;
+	case ma_none:
+		fallthrough;
+	case ma_pause:
+		mas->status = ma_start;
+		break;
+	case ma_underflow:
+		/* underflowed before but the min changed */
+		mas->status = ma_active;
+		break;
+	case ma_overflow:
+		/* User expects mas to be one after where it is */
+		mas->status = ma_active;
 		*entry = mas_walk(mas);
 		if (*entry)
 			return true;
-	}
-
-	if (mas_is_none(mas) || mas_is_paused(mas)) {
-		mas->node = MAS_START;
-	} else if (mas_is_underflow(mas)) {
-		/* underflowed before but the min changed */
-		mas->node = MAS_START;
+		break;
+	case ma_root:
+		break;
+	case ma_error:
+		return true;
 	}
 
 	if (mas_is_start(mas))
 		mas_walk(mas);
 
 	if (unlikely(mas_is_ptr(mas))) {
-		if (!mas->index)
-			goto none;
+		if (!mas->index) {
+			mas->status = ma_none;
+			return true;
+		}
 		mas->index = mas->last = 0;
 		*entry = mas_root(mas);
 		return true;
@@ -5809,7 +5842,7 @@ static bool mas_prev_setup(struct ma_state *mas, unsigned long min, void **entry
 		if (mas->index) {
 			/* Walked to out-of-range pointer? */
 			mas->index = mas->last = 0;
-			mas->node = MAS_ROOT;
+			mas->status = ma_root;
 			*entry = mas_root(mas);
 			return true;
 		}
@@ -5817,10 +5850,6 @@ static bool mas_prev_setup(struct ma_state *mas, unsigned long min, void **entry
 	}
 
 	return false;
-
-none:
-	mas->node = MAS_NONE;
-	return true;
 }
 
 /**
@@ -5841,7 +5870,7 @@ void *mas_prev(struct ma_state *mas, unsigned long min)
 	if (mas_prev_setup(mas, min, &entry))
 		return entry;
 
-	return mas_prev_slot(mas, min, false, true);
+	return mas_prev_slot(mas, min, false);
 }
 EXPORT_SYMBOL_GPL(mas_prev);
 
@@ -5864,7 +5893,7 @@ void *mas_prev_range(struct ma_state *mas, unsigned long min)
 	if (mas_prev_setup(mas, min, &entry))
 		return entry;
 
-	return mas_prev_slot(mas, min, true, true);
+	return mas_prev_slot(mas, min, true);
 }
 EXPORT_SYMBOL_GPL(mas_prev_range);
 
@@ -5907,7 +5936,8 @@ EXPORT_SYMBOL_GPL(mt_prev);
  */
 void mas_pause(struct ma_state *mas)
 {
-	mas->node = MAS_PAUSE;
+	mas->status = ma_pause;
+	mas->node = NULL;
 }
 EXPORT_SYMBOL_GPL(mas_pause);
 
@@ -5921,32 +5951,52 @@ EXPORT_SYMBOL_GPL(mas_pause);
  */
 static __always_inline bool mas_find_setup(struct ma_state *mas, unsigned long max, void **entry)
 {
-	if (mas_is_active(mas)) {
+	switch (mas->status) {
+	case ma_active:
 		if (mas->last < max)
 			return false;
-
 		return true;
-	}
-
-	if (mas_is_paused(mas)) {
+	case ma_start:
+		break;
+	case ma_pause:
 		if (unlikely(mas->last >= max))
 			return true;
 
 		mas->index = ++mas->last;
-		mas->node = MAS_START;
-	} else if (mas_is_none(mas)) {
+		mas->status = ma_start;
+		break;
+	case ma_none:
 		if (unlikely(mas->last >= max))
 			return true;
 
 		mas->index = mas->last;
-		mas->node = MAS_START;
-	} else if (mas_is_overflow(mas) || mas_is_underflow(mas)) {
-		if (mas->index > max) {
-			mas->node = MAS_OVERFLOW;
+		mas->status = ma_start;
+		break;
+	case ma_underflow:
+		/* mas is pointing at entry before unable to go lower */
+		if (unlikely(mas->index >= max)) {
+			mas->status = ma_overflow;
 			return true;
 		}
 
-		mas->node = MAS_START;
+		mas->status = ma_active;
+		*entry = mas_walk(mas);
+		if (*entry)
+			return true;
+		break;
+	case ma_overflow:
+		if (unlikely(mas->last >= max))
+			return true;
+
+		mas->status = ma_active;
+		*entry = mas_walk(mas);
+		if (*entry)
+			return true;
+		break;
+	case ma_root:
+		break;
+	case ma_error:
+		return true;
 	}
 
 	if (mas_is_start(mas)) {
@@ -5973,7 +6023,7 @@ static __always_inline bool mas_find_setup(struct ma_state *mas, unsigned long m
 	return false;
 
 ptr_out_of_range:
-	mas->node = MAS_NONE;
+	mas->status = ma_none;
 	mas->index = 1;
 	mas->last = ULONG_MAX;
 	return true;
@@ -5999,7 +6049,10 @@ void *mas_find(struct ma_state *mas, unsigned long max)
 		return entry;
 
 	/* Retries on dead nodes handled by mas_next_slot */
-	return mas_next_slot(mas, max, false, false);
+	entry = mas_next_slot(mas, max, false);
+	/* Ignore overflow */
+	mas->status = ma_active;
+	return entry;
 }
 EXPORT_SYMBOL_GPL(mas_find);
 
@@ -6023,7 +6076,7 @@ void *mas_find_range(struct ma_state *mas, unsigned long max)
 		return entry;
 
 	/* Retries on dead nodes handled by mas_next_slot */
-	return mas_next_slot(mas, max, true, false);
+	return mas_next_slot(mas, max, true);
 }
 EXPORT_SYMBOL_GPL(mas_find_range);
 
@@ -6038,33 +6091,45 @@ EXPORT_SYMBOL_GPL(mas_find_range);
 static bool mas_find_rev_setup(struct ma_state *mas, unsigned long min,
 		void **entry)
 {
-	if (mas_is_active(mas)) {
-		if (mas->index > min)
-			return false;
 
-		return true;
-	}
-
-	if (mas_is_paused(mas)) {
+	switch (mas->status) {
+	case ma_active:
+		goto active;
+	case ma_start:
+		break;
+	case ma_pause:
 		if (unlikely(mas->index <= min)) {
-			mas->node = MAS_NONE;
+			mas->status = ma_underflow;
 			return true;
 		}
-		mas->node = MAS_START;
 		mas->last = --mas->index;
-	} else if (mas_is_none(mas)) {
+		mas->status = ma_start;
+		break;
+	case ma_none:
 		if (mas->index <= min)
 			goto none;
 
 		mas->last = mas->index;
-		mas->node = MAS_START;
-	} else if (mas_is_underflow(mas) || mas_is_overflow(mas)) {
-		if (mas->last <= min) {
-			mas->node = MAS_UNDERFLOW;
+		mas->status = ma_start;
+		break;
+	case ma_overflow: /* user expects the mas to be one after where it is */
+		if (unlikely(mas->index <= min)) {
+			mas->status = ma_underflow;
 			return true;
 		}
 
-		mas->node = MAS_START;
+		mas->status = ma_active;
+		break;
+	case ma_underflow: /* user expects the mas to be one before where it is */
+		if (unlikely(mas->index <= min))
+			return true;
+
+		mas->status = ma_active;
+		break;
+	case ma_root:
+		break;
+	case ma_error:
+		return true;
 	}
 
 	if (mas_is_start(mas)) {
@@ -6087,19 +6152,20 @@ static bool mas_find_rev_setup(struct ma_state *mas, unsigned long min,
 			 * previous location is 0.
 			 */
 			mas->last = mas->index = 0;
-			mas->node = MAS_ROOT;
+			mas->status = ma_root;
 			*entry = mas_root(mas);
 			return true;
 		}
 	}
 
+active:
 	if (mas->index < min)
 		return true;
 
 	return false;
 
 none:
-	mas->node = MAS_NONE;
+	mas->status = ma_none;
 	return true;
 }
 
@@ -6124,7 +6190,7 @@ void *mas_find_rev(struct ma_state *mas, unsigned long min)
 		return entry;
 
 	/* Retries on dead nodes handled by mas_prev_slot */
-	return mas_prev_slot(mas, min, false, false);
+	return mas_prev_slot(mas, min, false);
 
 }
 EXPORT_SYMBOL_GPL(mas_find_rev);
@@ -6150,7 +6216,7 @@ void *mas_find_range_rev(struct ma_state *mas, unsigned long min)
 		return entry;
 
 	/* Retries on dead nodes handled by mas_prev_slot */
-	return mas_prev_slot(mas, min, true, false);
+	return mas_prev_slot(mas, min, true);
 }
 EXPORT_SYMBOL_GPL(mas_find_range_rev);
 
@@ -6171,7 +6237,7 @@ void *mas_erase(struct ma_state *mas)
 	MA_WR_STATE(wr_mas, mas, NULL);
 
 	if (!mas_is_active(mas) || !mas_is_start(mas))
-		mas->node = MAS_START;
+		mas->status = ma_start;
 
 	/* Retry unnecessary when holding the write lock. */
 	entry = mas_state_walk(mas);
@@ -6216,7 +6282,7 @@ bool mas_nomem(struct ma_state *mas, gfp_t gfp)
 	if (!mas_allocated(mas))
 		return false;
 
-	mas->node = MAS_START;
+	mas->status = ma_start;
 	return true;
 }
 
@@ -6687,11 +6753,11 @@ static inline struct maple_enode *mas_get_slot(struct ma_state *mas,
 static void mas_dfs_postorder(struct ma_state *mas, unsigned long max)
 {
 
-	struct maple_enode *p = MAS_NONE, *mn = mas->node;
+	struct maple_enode *p, *mn = mas->node;
 	unsigned long p_min, p_max;
 
 	mas_next_node(mas, mas_mn(mas), max);
-	if (!mas_is_none(mas))
+	if (!mas_is_overflow(mas))
 		return;
 
 	if (mte_is_root(mn))
@@ -6704,7 +6770,7 @@ static void mas_dfs_postorder(struct ma_state *mas, unsigned long max)
 		p_min = mas->min;
 		p_max = mas->max;
 		mas_prev_node(mas, 0);
-	} while (!mas_is_none(mas));
+	} while (!mas_is_underflow(mas));
 
 	mas->node = p;
 	mas->max = p_max;
@@ -7159,7 +7225,7 @@ static void mt_validate_nulls(struct maple_tree *mt)
 	MA_STATE(mas, mt, 0, 0);
 
 	mas_start(&mas);
-	if (mas_is_none(&mas) || (mas.node == MAS_ROOT))
+	if (mas_is_none(&mas) || (mas_is_ptr(&mas)))
 		return;
 
 	while (!mte_is_leaf(mas.node))
@@ -7176,7 +7242,7 @@ static void mt_validate_nulls(struct maple_tree *mt)
 		last = entry;
 		if (offset == mas_data_end(&mas)) {
 			mas_next_node(&mas, mas_mn(&mas), ULONG_MAX);
-			if (mas_is_none(&mas))
+			if (mas_is_overflow(&mas))
 				return;
 			offset = 0;
 			slots = ma_slots(mte_to_node(mas.node),
@@ -7185,7 +7251,7 @@ static void mt_validate_nulls(struct maple_tree *mt)
 			offset++;
 		}
 
-	} while (!mas_is_none(&mas));
+	} while (!mas_is_overflow(&mas));
 }
 
 /*
@@ -7206,7 +7272,7 @@ void mt_validate(struct maple_tree *mt)
 	while (!mte_is_leaf(mas.node))
 		mas_descend(&mas);
 
-	while (!mas_is_none(&mas)) {
+	while (!mas_is_overflow(&mas)) {
 		MAS_WARN_ON(&mas, mte_dead_node(mas.node));
 		end = mas_data_end(&mas);
 		if (MAS_WARN_ON(&mas, (end < mt_min_slot_count(mas.node)) &&
@@ -7231,16 +7297,35 @@ EXPORT_SYMBOL_GPL(mt_validate);
 void mas_dump(const struct ma_state *mas)
 {
 	pr_err("MAS: tree=%p enode=%p ", mas->tree, mas->node);
-	if (mas_is_none(mas))
-		pr_err("(MAS_NONE) ");
-	else if (mas_is_ptr(mas))
-		pr_err("(MAS_ROOT) ");
-	else if (mas_is_start(mas))
-		 pr_err("(MAS_START) ");
-	else if (mas_is_paused(mas))
-		pr_err("(MAS_PAUSED) ");
-
-	pr_err("[%u] index=%lx last=%lx\n", mas->offset, mas->index, mas->last);
+	switch (mas->status) {
+	case ma_active:
+		pr_err("(ma_active)");
+		break;
+	case ma_none:
+		pr_err("(ma_none)");
+		break;
+	case ma_root:
+		pr_err("(ma_root)");
+		break;
+	case ma_start:
+		pr_err("(ma_start) ");
+		break;
+	case ma_pause:
+		pr_err("(ma_pause) ");
+		break;
+	case ma_overflow:
+		pr_err("(ma_overflow) ");
+		break;
+	case ma_underflow:
+		pr_err("(ma_underflow) ");
+		break;
+	case ma_error:
+		pr_err("(ma_error) ");
+		break;
+	}
+
+	pr_err("[%u/%u] index=%lx last=%lx\n", mas->offset, mas->end,
+	       mas->index, mas->last);
 	pr_err("     min=%lx max=%lx alloc=%p, depth=%u, flags=%x\n",
 	       mas->min, mas->max, mas->alloc, mas->depth, mas->mas_flags);
 	if (mas->index > mas->last)
diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 06959165e2f9..b82c02f15380 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -53,6 +53,11 @@ atomic_t maple_tree_tests_passed;
 #else
 #define cond_resched()			do {} while (0)
 #endif
+
+#define mas_is_none(x)		((x)->status == ma_none)
+#define mas_is_overflow(x)	((x)->status == ma_overflow)
+#define mas_is_underflow(x)	((x)->status == ma_underflow)
+
 static int __init mtree_insert_index(struct maple_tree *mt,
 				     unsigned long index, gfp_t gfp)
 {
@@ -581,7 +586,7 @@ static noinline void __init check_find(struct maple_tree *mt)
 	MT_BUG_ON(mt, last != mas.last);
 
 
-	mas.node = MAS_NONE;
+	mas.status = ma_none;
 	mas.index = ULONG_MAX;
 	mas.last = ULONG_MAX;
 	entry2 = mas_prev(&mas, 0);
@@ -2166,7 +2171,7 @@ static noinline void __init next_prev_test(struct maple_tree *mt)
 	MT_BUG_ON(mt, val != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 5);
-	MT_BUG_ON(mt, mas.node != MAS_UNDERFLOW);
+	MT_BUG_ON(mt, !mas_is_underflow(&mas));
 
 	mas.index = 0;
 	mas.last = 5;
@@ -3026,10 +3031,6 @@ static noinline void __init check_empty_area_fill(struct maple_tree *mt)
  *		DNE	active		active		range of NULL
  */
 
-#define mas_active(x)		(((x).node != MAS_ROOT) && \
-				 ((x).node != MAS_START) && \
-				 ((x).node != MAS_PAUSE) && \
-				 ((x).node != MAS_NONE))
 static noinline void __init check_state_handling(struct maple_tree *mt)
 {
 	MA_STATE(mas, mt, 0, 0);
@@ -3044,7 +3045,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	/* prev: Start -> underflow*/
 	entry = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, entry != NULL);
-	MT_BUG_ON(mt, mas.node != MAS_UNDERFLOW);
+	MT_BUG_ON(mt, mas.status != ma_underflow);
 
 	/* prev: Start -> root */
 	mas_set(&mas, 10);
@@ -3052,7 +3053,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0);
-	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+	MT_BUG_ON(mt, mas.status != ma_root);
 
 	/* prev: pause -> root */
 	mas_set(&mas, 10);
@@ -3061,7 +3062,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0);
-	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+	MT_BUG_ON(mt, mas.status != ma_root);
 
 	/* next: start -> none */
 	mas_set(&mas, 0);
@@ -3069,7 +3070,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas.index != 1);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
 	MT_BUG_ON(mt, entry != NULL);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.status != ma_none);
 
 	/* next: start -> none*/
 	mas_set(&mas, 10);
@@ -3077,7 +3078,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas.index != 1);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
 	MT_BUG_ON(mt, entry != NULL);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.status != ma_none);
 
 	/* find: start -> root */
 	mas_set(&mas, 0);
@@ -3085,21 +3086,21 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0);
-	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+	MT_BUG_ON(mt, mas.status != ma_root);
 
 	/* find: root -> none */
 	entry = mas_find(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 1);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.status != ma_none);
 
 	/* find: none -> none */
 	entry = mas_find(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 1);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.status != ma_none);
 
 	/* find: start -> none */
 	mas_set(&mas, 10);
@@ -3107,14 +3108,14 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 1);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.status != ma_none);
 
 	/* find_rev: none -> root */
 	entry = mas_find_rev(&mas, 0);
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0);
-	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+	MT_BUG_ON(mt, mas.status != ma_root);
 
 	/* find_rev: start -> root */
 	mas_set(&mas, 0);
@@ -3122,21 +3123,21 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0);
-	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+	MT_BUG_ON(mt, mas.status != ma_root);
 
 	/* find_rev: root -> none */
 	entry = mas_find_rev(&mas, 0);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.status != ma_none);
 
 	/* find_rev: none -> none */
 	entry = mas_find_rev(&mas, 0);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.status != ma_none);
 
 	/* find_rev: start -> root */
 	mas_set(&mas, 10);
@@ -3144,7 +3145,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0);
-	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+	MT_BUG_ON(mt, mas.status != ma_root);
 
 	/* walk: start -> none */
 	mas_set(&mas, 10);
@@ -3152,7 +3153,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 1);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.status != ma_none);
 
 	/* walk: pause -> none*/
 	mas_set(&mas, 10);
@@ -3161,7 +3162,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 1);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.status != ma_none);
 
 	/* walk: none -> none */
 	mas.index = mas.last = 10;
@@ -3169,14 +3170,14 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 1);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.status != ma_none);
 
 	/* walk: none -> none */
 	entry = mas_walk(&mas);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 1);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.status != ma_none);
 
 	/* walk: start -> root */
 	mas_set(&mas, 0);
@@ -3184,7 +3185,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0);
-	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+	MT_BUG_ON(mt, mas.status != ma_root);
 
 	/* walk: pause -> root */
 	mas_set(&mas, 0);
@@ -3193,22 +3194,22 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0);
-	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+	MT_BUG_ON(mt, mas.status != ma_root);
 
 	/* walk: none -> root */
-	mas.node = MAS_NONE;
+	mas.status = ma_none;
 	entry = mas_walk(&mas);
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0);
-	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+	MT_BUG_ON(mt, mas.status != ma_root);
 
 	/* walk: root -> root */
 	entry = mas_walk(&mas);
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0);
-	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+	MT_BUG_ON(mt, mas.status != ma_root);
 
 	/* walk: root -> none */
 	mas_set(&mas, 10);
@@ -3216,7 +3217,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 1);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.status != ma_none);
 
 	/* walk: none -> root */
 	mas.index = mas.last = 0;
@@ -3224,7 +3225,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0);
-	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+	MT_BUG_ON(mt, mas.status != ma_root);
 
 	mas_unlock(&mas);
 
@@ -3242,7 +3243,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* next: pause ->active */
 	mas_set(&mas, 0);
@@ -3251,126 +3252,127 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* next: none ->active */
 	mas.index = mas.last = 0;
 	mas.offset = 0;
-	mas.node = MAS_NONE;
+	mas.status = ma_none;
 	entry = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* next:active ->active */
 	entry = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != ptr2);
 	MT_BUG_ON(mt, mas.index != 0x2000);
 	MT_BUG_ON(mt, mas.last != 0x2500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
-	/* next:active -> active beyond data */
+	/* next:active -> overflow (limit reached) beyond data */
 	entry = mas_next(&mas, 0x2999);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x2501);
 	MT_BUG_ON(mt, mas.last != 0x2fff);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_overflow(&mas));
 
-	/* Continue after last range ends after max */
+	/* next:overflow -> active (limit changed) */
 	entry = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != ptr3);
 	MT_BUG_ON(mt, mas.index != 0x3000);
 	MT_BUG_ON(mt, mas.last != 0x3500);
-	MT_BUG_ON(mt, !mas_active(mas));
-
-	/* next:active -> active continued */
-	entry = mas_next(&mas, ULONG_MAX);
-	MT_BUG_ON(mt, entry != NULL);
-	MT_BUG_ON(mt, mas.index != 0x3501);
-	MT_BUG_ON(mt, mas.last != ULONG_MAX);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
-	/* next:active -> overflow  */
+	/* next:active ->  overflow (limit reached) */
 	entry = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x3501);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
-	MT_BUG_ON(mt, mas.node != MAS_OVERFLOW);
+	MT_BUG_ON(mt, !mas_is_overflow(&mas));
 
 	/* next:overflow -> overflow  */
 	entry = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x3501);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
-	MT_BUG_ON(mt, mas.node != MAS_OVERFLOW);
+	MT_BUG_ON(mt, !mas_is_overflow(&mas));
 
 	/* prev:overflow -> active  */
 	entry = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, entry != ptr3);
 	MT_BUG_ON(mt, mas.index != 0x3000);
 	MT_BUG_ON(mt, mas.last != 0x3500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* next: none -> active, skip value at location */
 	mas_set(&mas, 0);
 	entry = mas_next(&mas, ULONG_MAX);
-	mas.node = MAS_NONE;
+	mas.status = ma_none;
 	mas.offset = 0;
 	entry = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != ptr2);
 	MT_BUG_ON(mt, mas.index != 0x2000);
 	MT_BUG_ON(mt, mas.last != 0x2500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* prev:active ->active */
 	entry = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
-	/* prev:active -> active spanning end range */
+	/* prev:active -> underflow (span limit) */
+	mas_next(&mas, ULONG_MAX);
+	entry = mas_prev(&mas, 0x1200);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_is_underflow(&mas));
+
+	/* prev:underflow -> underflow (lower limit) spanning end range */
 	entry = mas_prev(&mas, 0x0100);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0x0FFF);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_underflow(&mas));
 
-	/* prev:active -> underflow */
+	/* prev:underflow -> underflow */
 	entry = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0x0FFF);
-	MT_BUG_ON(mt, mas.node != MAS_UNDERFLOW);
+	MT_BUG_ON(mt, !mas_is_underflow(&mas));
 
 	/* prev:underflow -> underflow */
 	entry = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0x0FFF);
-	MT_BUG_ON(mt, mas.node != MAS_UNDERFLOW);
+	MT_BUG_ON(mt, !mas_is_underflow(&mas));
 
 	/* next:underflow -> active */
 	entry = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* prev:first value -> underflow */
 	entry = mas_prev(&mas, 0x1000);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, mas.node != MAS_UNDERFLOW);
+	MT_BUG_ON(mt, !mas_is_underflow(&mas));
 
 	/* find:underflow -> first value */
 	entry = mas_find(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* prev: pause ->active */
 	mas_set(&mas, 0x3600);
@@ -3381,21 +3383,21 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr2);
 	MT_BUG_ON(mt, mas.index != 0x2000);
 	MT_BUG_ON(mt, mas.last != 0x2500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
-	/* prev:active -> active spanning min */
+	/* prev:active -> underflow spanning min */
 	entry = mas_prev(&mas, 0x1600);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x1501);
 	MT_BUG_ON(mt, mas.last != 0x1FFF);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_underflow(&mas));
 
 	/* prev: active ->active, continue */
 	entry = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* find: start ->active */
 	mas_set(&mas, 0);
@@ -3403,7 +3405,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* find: pause ->active */
 	mas_set(&mas, 0);
@@ -3412,7 +3414,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* find: start ->active on value */;
 	mas_set(&mas, 1200);
@@ -3420,14 +3422,14 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* find:active ->active */
 	entry = mas_find(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != ptr2);
 	MT_BUG_ON(mt, mas.index != 0x2000);
 	MT_BUG_ON(mt, mas.last != 0x2500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 
 	/* find:active -> active (NULL)*/
@@ -3435,35 +3437,35 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x2501);
 	MT_BUG_ON(mt, mas.last != 0x2FFF);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MAS_BUG_ON(&mas, !mas_is_active(&mas));
 
 	/* find: overflow ->active */
 	entry = mas_find(&mas, 0x5000);
 	MT_BUG_ON(mt, entry != ptr3);
 	MT_BUG_ON(mt, mas.index != 0x3000);
 	MT_BUG_ON(mt, mas.last != 0x3500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* find:active -> active (NULL) end*/
 	entry = mas_find(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x3501);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MAS_BUG_ON(&mas, !mas_is_active(&mas));
 
 	/* find_rev: active (END) ->active */
 	entry = mas_find_rev(&mas, 0);
 	MT_BUG_ON(mt, entry != ptr3);
 	MT_BUG_ON(mt, mas.index != 0x3000);
 	MT_BUG_ON(mt, mas.last != 0x3500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* find_rev:active ->active */
 	entry = mas_find_rev(&mas, 0);
 	MT_BUG_ON(mt, entry != ptr2);
 	MT_BUG_ON(mt, mas.index != 0x2000);
 	MT_BUG_ON(mt, mas.last != 0x2500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* find_rev: pause ->active */
 	mas_pause(&mas);
@@ -3471,14 +3473,14 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
-	/* find_rev:active -> active */
+	/* find_rev:active -> underflow */
 	entry = mas_find_rev(&mas, 0);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0x0FFF);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_underflow(&mas));
 
 	/* find_rev: start ->active */
 	mas_set(&mas, 0x1200);
@@ -3486,7 +3488,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* mas_walk start ->active */
 	mas_set(&mas, 0x1200);
@@ -3494,7 +3496,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* mas_walk start ->active */
 	mas_set(&mas, 0x1600);
@@ -3502,7 +3504,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x1501);
 	MT_BUG_ON(mt, mas.last != 0x1fff);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* mas_walk pause ->active */
 	mas_set(&mas, 0x1200);
@@ -3511,7 +3513,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* mas_walk pause -> active */
 	mas_set(&mas, 0x1600);
@@ -3520,25 +3522,25 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x1501);
 	MT_BUG_ON(mt, mas.last != 0x1fff);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* mas_walk none -> active */
 	mas_set(&mas, 0x1200);
-	mas.node = MAS_NONE;
+	mas.status = ma_none;
 	entry = mas_walk(&mas);
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* mas_walk none -> active */
 	mas_set(&mas, 0x1600);
-	mas.node = MAS_NONE;
+	mas.status = ma_none;
 	entry = mas_walk(&mas);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x1501);
 	MT_BUG_ON(mt, mas.last != 0x1fff);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* mas_walk active -> active */
 	mas.index = 0x1200;
@@ -3548,7 +3550,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
 	MT_BUG_ON(mt, mas.last != 0x1500);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	/* mas_walk active -> active */
 	mas.index = 0x1600;
@@ -3557,7 +3559,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x1501);
 	MT_BUG_ON(mt, mas.last != 0x1fff);
-	MT_BUG_ON(mt, !mas_active(mas));
+	MT_BUG_ON(mt, !mas_is_active(&mas));
 
 	mas_unlock(&mas);
 }
diff --git a/mm/internal.h b/mm/internal.h
index 812ba03224f8..db97bf5833ae 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1102,13 +1102,13 @@ static inline void vma_iter_store(struct vma_iterator *vmi,
 {
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
-	if (MAS_WARN_ON(&vmi->mas, vmi->mas.node != MAS_START &&
+	if (MAS_WARN_ON(&vmi->mas, vmi->mas.status != ma_start &&
 			vmi->mas.index > vma->vm_start)) {
 		pr_warn("%lx > %lx\n store vma %lx-%lx\n into slot %lx-%lx\n",
 			vmi->mas.index, vma->vm_start, vma->vm_start,
 			vma->vm_end, vmi->mas.index, vmi->mas.last);
 	}
-	if (MAS_WARN_ON(&vmi->mas, vmi->mas.node != MAS_START &&
+	if (MAS_WARN_ON(&vmi->mas, vmi->mas.status != ma_start &&
 			vmi->mas.last <  vma->vm_start)) {
 		pr_warn("%lx < %lx\nstore vma %lx-%lx\ninto slot %lx-%lx\n",
 		       vmi->mas.last, vma->vm_start, vma->vm_start, vma->vm_end,
@@ -1116,7 +1116,7 @@ static inline void vma_iter_store(struct vma_iterator *vmi,
 	}
 #endif
 
-	if (vmi->mas.node != MAS_START &&
+	if (vmi->mas.status != ma_start &&
 	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
 		vma_iter_invalidate(vmi);
 
@@ -1127,7 +1127,7 @@ static inline void vma_iter_store(struct vma_iterator *vmi,
 static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
 			struct vm_area_struct *vma, gfp_t gfp)
 {
-	if (vmi->mas.node != MAS_START &&
+	if (vmi->mas.status != ma_start &&
 	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
 		vma_iter_invalidate(vmi);
 
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index cb4e4a7cc7f5..57964aec2122 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -118,6 +118,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas.alloc == NULL);
 	MT_BUG_ON(mt, mas.alloc->slot[0] == NULL);
 	mas_push_node(&mas, mn);
+	mas_reset(&mas);
 	mas_nomem(&mas, GFP_KERNEL); /* free */
 	mtree_unlock(mt);
 
@@ -141,7 +142,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 
 	mn->parent = ma_parent_ptr(mn);
 	ma_free_rcu(mn);
-	mas.node = MAS_START;
+	mas.status = ma_start;
 	mas_nomem(&mas, GFP_KERNEL);
 	/* Allocate 3 nodes, will fail. */
 	mas_node_count(&mas, 3);
@@ -158,6 +159,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 	/* Ensure we counted 3. */
 	MT_BUG_ON(mt, mas_allocated(&mas) != 3);
 	/* Free. */
+	mas_reset(&mas);
 	mas_nomem(&mas, GFP_KERNEL);
 
 	/* Set allocation request to 1. */
@@ -272,6 +274,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 			ma_free_rcu(mn);
 			MT_BUG_ON(mt, mas_allocated(&mas) != i - j - 1);
 		}
+		mas_reset(&mas);
 		MT_BUG_ON(mt, mas_nomem(&mas, GFP_KERNEL));
 
 	}
@@ -294,6 +297,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 		smn = smn->slot[0]; /* next. */
 	}
 	MT_BUG_ON(mt, mas_allocated(&mas) != total);
+	mas_reset(&mas);
 	mas_nomem(&mas, GFP_KERNEL); /* Free. */
 
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
@@ -441,7 +445,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 	mas.node = MA_ERROR(-ENOMEM);
 	mas_node_count(&mas, 10); /* Request */
 	mas_nomem(&mas, GFP_KERNEL); /* Fill request */
-	mas.node = MAS_START;
+	mas.status = ma_start;
 	MT_BUG_ON(mt, mas_allocated(&mas) != 10);
 	mas_destroy(&mas);
 
@@ -452,7 +456,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 	mas.node = MA_ERROR(-ENOMEM);
 	mas_node_count(&mas, 10 + MAPLE_ALLOC_SLOTS - 1); /* Request */
 	mas_nomem(&mas, GFP_KERNEL); /* Fill request */
-	mas.node = MAS_START;
+	mas.status = ma_start;
 	MT_BUG_ON(mt, mas_allocated(&mas) != 10 + MAPLE_ALLOC_SLOTS - 1);
 	mas_destroy(&mas);
 
@@ -941,7 +945,7 @@ static inline bool mas_tree_walk(struct ma_state *mas, unsigned long *range_min,
 
 	ret = mas_descend_walk(mas, range_min, range_max);
 	if (unlikely(mte_dead_node(mas->node))) {
-		mas->node = MAS_START;
+		mas->status = ma_start;
 		goto retry;
 	}
 
@@ -961,10 +965,10 @@ static inline void *mas_range_load(struct ma_state *mas,
 	unsigned long index = mas->index;
 
 	if (mas_is_none(mas) || mas_is_paused(mas))
-		mas->node = MAS_START;
+		mas->status = ma_start;
 retry:
 	if (mas_tree_walk(mas, range_min, range_max))
-		if (unlikely(mas->node == MAS_ROOT))
+		if (unlikely(mas->status == ma_root))
 			return mas_root(mas);
 
 	if (likely(mas->offset != MAPLE_NODE_SLOTS))
@@ -35337,7 +35341,7 @@ static void mas_dfs_preorder(struct ma_state *mas)
 	unsigned char end, slot = 0;
 	unsigned long *pivots;
 
-	if (mas->node == MAS_START) {
+	if (mas->status == ma_start) {
 		mas_start(mas);
 		return;
 	}
@@ -35374,7 +35378,7 @@ static void mas_dfs_preorder(struct ma_state *mas)
 
 	return;
 done:
-	mas->node = MAS_NONE;
+	mas->status = ma_none;
 }
 
 
@@ -35833,7 +35837,7 @@ static noinline void __init check_nomem(struct maple_tree *mt)
 	mas_store(&ms, &ms); /* insert 1 -> &ms, fails. */
 	MT_BUG_ON(mt, ms.node != MA_ERROR(-ENOMEM));
 	mas_nomem(&ms, GFP_KERNEL); /* Node allocated in here. */
-	MT_BUG_ON(mt, ms.node != MAS_START);
+	MT_BUG_ON(mt, ms.status != ma_start);
 	mtree_unlock(mt);
 	MT_BUG_ON(mt, mtree_insert(mt, 2, mt, GFP_KERNEL) != 0);
 	mtree_lock(mt);
-- 
2.40.1

