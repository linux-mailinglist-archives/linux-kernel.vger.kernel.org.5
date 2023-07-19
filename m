Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B5D759CFC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 20:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjGSSAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 14:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjGSSAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:00:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1D41FC4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:00:20 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JFOhmX022370;
        Wed, 19 Jul 2023 17:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=YtDp3sgfoAD1bDqnXsk/05Amf2WqHZORgkvlNwXd8Ck=;
 b=oJEezSh+RQorvRn1eQjk2/c2xblRXBaX4srM+qzSK3hmmBfRT3cL7JbhgKptnlr2kV9o
 m6sUmS00d1q7tpSRdNPNf03QO5vUoySr3Eul5kp8iMtS6YQuP2vLcd7G6QBrqFwTVlrj
 1epHGiTbu4ztJBAZ5pdnHzTm27IEBNgcDdD58HU3zOUsxkQ3wxlijdtXLdJxOkI6AUND
 woi+5aFzBEXch4wCwzburNhJdzYgC3r/LKdCixC06KF31/nb2AKAXDa3bX7aXffvVisS
 b+FMw4KYg4WfPo6dqcuRC2hMawIqNN8e9EzE4wwu4j8S9tqZQXociNeC1s0lnjJerUbS 5A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8a85hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 17:59:54 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36JGHcNC038179;
        Wed, 19 Jul 2023 17:59:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw77w25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 17:59:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4iu66p3LY4lMPNOqxrvvLIORctsEOJbE7MA0+vQmvdSSyKu6aqMBxAzeAYHPssgL4iVDzF0g5ThCNcLfu49HNe6vc557oh25LFgoVKkvB71xz6aDEeLoualrUuLnoZbqmSbA2xYMzbZW1wAoASXQx9ijTtUJSUzUiHD18Nx1AZVX0fpmY3FwHZV4U2mAkzpJfJ6vKA/cBUgfNtKJPkYWPvulxCjAoHiFQJUDyNeDcHdf2zv9SVtvGmd0F+5QAZjr1h8PwsaGBn6uScQntxJ2tadvCd/4HQ1Dk7n6YPOUS93CBTPb/6Ut2YeXLJNMLvLwVAdUlabLHAMdNOi7a0FsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtDp3sgfoAD1bDqnXsk/05Amf2WqHZORgkvlNwXd8Ck=;
 b=dpr7zBn4gmcfIUP5N+VnSI/qF+HbzGZXYNcVY7jVeLbnAD9Tlr/6Znp3ufmb5so3Fu6IQB/4MIXDqKiZsgLJImKGkw5e0fo6exg+ti9SzdZ6kmfZzQcl00A+bijyEC35TD9fyCJ+fspsbvmw9a3p2LIRxG9tlmnX6fEkUnJgL4Rzo0+wR8MrKxXLTcUL9PtldIry4PD+DDVWhukiZL3eL/F7+HCidZo4I12njDkSMZmXRVKrXRDqXQzLL/59V8dyuP2FKJ0XGXrFhOj4zKEDi6bWyJ1rmzejI+Wx82GBOLNoWtWwNRjrYE6aMybVum2bZARXOadlaX0RzTthuGCQ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtDp3sgfoAD1bDqnXsk/05Amf2WqHZORgkvlNwXd8Ck=;
 b=LbCEMeEBDQbkBUHFl7tcf0ggNHjc21g/l0IRX1r2E3aMfstQawgq1lvBapxLqobCmGjKcJqJNBDtC+AyYhkicl126IxJLaZKZ4XgEvn2Hm8A5WRYAwTqrvrTAv8/kh0t1dLEGoqzhXKCu+n2YTLnxjCn+7I3VmmOz9bqk+DQXnM=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH7PR10MB6355.namprd10.prod.outlook.com (2603:10b6:510:1b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 17:59:51 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6bff:7715:4210:1e52]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6bff:7715:4210:1e52%7]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 17:59:49 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH] mm/hugetlb: get rid of page_hstate()
Date:   Wed, 19 Jul 2023 10:59:44 -0700
Message-ID: <20230719175944.292929-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0160.namprd05.prod.outlook.com
 (2603:10b6:a03:339::15) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH7PR10MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: e87fd482-2a23-4d21-df6f-08db8881f206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PukNL/LjMRadOBajsk4KuUbvdJJdaA2q1I1KiT+bSd7qWSX/FpRfbAcG+vncsrYTXyPwuUPGw+JkfWPN3WsEUJh6ehOC9l9GsshNkI4MPy+vhYRyK/R6iXsaP9XZSK/UUR0rf5Pl1plHb6Q0slaJe5zm2/WDNceUmjiiNzfCq6jNvSkOQ9/PI5vltDdhVj9CShKYBjAXBV4X54BmCI2XNoqo9g9ttM0vaYSo8EICKik5sPKFEga8iWlJpxm3XWgyFocdSIhqdndw70d1fEymvVwMSWjMFo4sJpI9w76qhv+R/NlsXAs0vYN7qBtlqETgw3Mt5KW0PxzhStMecbWDK8tEq5rO1GSzwXELt0efkkeu+owQYngT/8MXLfaEZsrj8NiyruEeuFTQTMjqzRjJMwZoZrjo8wtQdnL1HiM66a7j2BKaT2ojt52xMuS8swn/lkc5wmNIq+Klqbe7bO965NIjCmmaQvi3V6R2sNDPGFszrzdTwpFYVW2d3i7+IPtLBiPYDWTtiyxV6UajON64u+QMTBKs9XvkCgWdtlqQG3vHxFi5bdRjt9pctpucxP9bytxRnX8Kyj7g1TQwBXMqraZUMmXsGsE+kaNy4kNH6EU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199021)(2906002)(6506007)(1076003)(6512007)(107886003)(316002)(5660300002)(4326008)(66476007)(8936002)(66556008)(8676002)(41300700001)(44832011)(66946007)(36756003)(38100700002)(6666004)(6486002)(478600001)(83380400001)(2616005)(86362001)(186003)(26583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QQAAm7q2rXQAlg/dVstN2DuTl2QGqfP+tJTQPXMehz1++gf9JW13YrKQJDFs?=
 =?us-ascii?Q?jiAwmWcd+KEg/sqcqPPaD8hqo7DBbc0DeKCpmJrvmw7Ko9oBH7pUAXxWuwxC?=
 =?us-ascii?Q?BXJWBU/R+jbOuOBbgL8qrmnRKSrzxYpGa217EZOm21rgWWP/CK3PRWKOilso?=
 =?us-ascii?Q?ipU4RT3dgA6A+XBrblIGfGSOuhAHIYFR7Y0K3d7uhHC/jvnS0dxL//8sUsPq?=
 =?us-ascii?Q?v2glGX3euB9WyFRgyKWE/TetoQRIzBNsezGmxEWOCGBf+6krUp5A3iLPr1D0?=
 =?us-ascii?Q?PNQkMwmgLqr42qzY3zG71JgZJFMmW3O6jBEAqVg4jGcidjxZ9Xqq+OULJkdI?=
 =?us-ascii?Q?rhs8q/XCt5IBsfkzay/HaADS8IjIVxB3uhrcTIaKi2Bi32pVW8vU/ayPMaXi?=
 =?us-ascii?Q?JsylRM8Bi2XpEzWyT++0p6lgF+epv0bX/o1Rcv4muhaRUoeYnCe6sFzGOYxX?=
 =?us-ascii?Q?7gNV+zvwCk5V4Y7isqSG5midDRSJyByyQN5LhfwmJfGp8Eoeb3HG2V1/+ZEk?=
 =?us-ascii?Q?B62kGvOxj3etb2u3gZYA8jxg4WnIjlcKQVHKgZqECelChgtjlEAaE/TPYQi7?=
 =?us-ascii?Q?p7ZiAb9TaliR3pLNFpetX+jf5IkdANs5fmtcRveJis65O+Dg+TKBLERQAljU?=
 =?us-ascii?Q?Lbi9F65QlxxNd7H8jLC+0Y00ZvVrSdA4XS6aJhS6fT4r1/LqOU89tO55KswY?=
 =?us-ascii?Q?12eI7v6URBfKIe5QW36xy9VN5tV4FkIcnI0OPlnigTucmH9NfE3yo4BijRs/?=
 =?us-ascii?Q?yBnK4yl0R4W4xQvEl9sagE66o+uU/32MeXgMgbkyvTrGdJ/SNVmdMstRzeuV?=
 =?us-ascii?Q?h1UvxhuYDLOWUPQPZZ+0Q2voPfyjwzEMYyQY7vMtZh2PrnqFmsyMWda1fP8K?=
 =?us-ascii?Q?bmnR/3oXJdEwR00rifk65PcDLJVvZO5OuZWMWKJBTYrUe6Sa9CN4Z6dMjGYr?=
 =?us-ascii?Q?S/leUidhlOUWbi8r+oVrimF6NpH7rqALEbo5KM+hnQIK4lPR8CWHEz41TLyq?=
 =?us-ascii?Q?yalNDBDOgEe75aIW+UA3tbBpk0FFw0KSiwWGUXQBZPDSQ4xDLcfWDQu6ILv1?=
 =?us-ascii?Q?IABtL7hQGDXGqXZabL42F8dI0KIBbm4nWCybYiq6kBI2bWY5XeG0gN/ETAy6?=
 =?us-ascii?Q?JqPhWljTYfyw1JaJ9uN3rNBz5QhUz+WptKIf0YJVGJ67McLLoSODLOF3aHqI?=
 =?us-ascii?Q?3smBa/WVmfGPozCHWmIJSnVs41lnJv7cx4FPEVfuJ1qPhORjcLrhgfYA6uAV?=
 =?us-ascii?Q?k3eBaYuOZdZJqiDOwLpeOhV9Le6JN/wNScWX5vuJVE4eAQTQTjzacyVy/k2a?=
 =?us-ascii?Q?bWPxr3XcM7HHW82ZpkNZ1k8wdUIl0+xtx0TveKf3IfaFC44ASMfbG1G+yIHX?=
 =?us-ascii?Q?ECFjDjebol8AP02sk+hjjVRrRu24aBUtU7dlhr80BZQaAlrVXVkljILYY+pQ?=
 =?us-ascii?Q?DR73pLnwoJv7Ig+UvdrhHY3/llfjyZQj0SCZR5zsAX0KUowErKlJMmwH5uHa?=
 =?us-ascii?Q?wdKfP118Zibj74UJd340OrAvBRNvanOXFNGHyHruFXOph++h6Ip6OtmmF+XI?=
 =?us-ascii?Q?MCpIut8qw2sda1d3fYvz2qki6//Yv/Ekh1sRPpn7FLijBcwPZAAJ947BN1pp?=
 =?us-ascii?Q?Z9DCyvbEsBUd4yAa5OyrKqU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QzoCbaA4L2XiB9Si1lB62lhDd2P9L4L8uIfH8FY58lIp0bGLNPEddIJLMAHY6x2FuVSqzIK9l2soUwXMjNVZ3RPkzG2O6L/MJHOEGF1MieCqfHt4BRNNsw+0Af3o3hfQrounRG0MGwWCHTRw42KVLumzV5E0qoGu+0R6vyH/OKakL6tMaFlAWRzoOaMIC7GXJthvdvEnzErqzOfIahcbqMWhBcWHu66/oUWqUOlEVKnzd352/Pf/TOrqAYjR0SeMiT0Ne2eICtB9ZumtGh61Y8q5VOWfgMV5SEw/ePLd277TT+O2eUCebL7qLRXASsbsyxzm+wADt0hByQnTpBrvKRtAoLd+L5Endnkq+GyfbA8BL2N6/d2xLOx+ApTFNlyK4j+bxWg+L4QvWAydJ/HekTf7nqmpm4CCKGQqIjkribF7RxMPVblXiZRj/QM5b5/0VITNKs5zLjqhldJ6kH7vZrrKjrbvigbvw44+bMSVbwDlyUmD2n5uPMtbpAvsJXOw+UsA4Nj+62TD7m6+rnKv69MIc6nG1iCYeB2haNF12qWNkZMneCpxrOspFdHzQFzoGoFtIQgwvHw7VNgla4Sq169xrzthLCGjhpddWbjjDeiTWKGLUV1IE9+M1nngfSMsoB55326FqVt4WIyldgT4h0tLkGrX8cyuaouNryOJlYk5bLCNNkEKexkUsaTRrtmWiwNOCtpqKbkr+gqpaIZsI3Hp3a7/of411q36IJmp41T6IvmTxCgdYzi/Lfzuy9cGLQucUx/zhkzxKYKiZHbFzFtyMijHWQCJ9hceCQCMW3wC3ajymMc6g81m/XYZ8QsWTyOSKJJqB54R16xYLtPtta3YMxAmpyhVQr+QtolPoW+xd2iaYMWVfPKeVhoekEh6
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e87fd482-2a23-4d21-df6f-08db8881f206
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 17:59:49.7630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZBXwX5BsV3QwNtEpy8yXFSW1LqbdvRBtA0nZS+OrB+GBfJzIrj3rA0h7uWc6BYYVVxvP4X8C2B6yF0FH8donXb4ZQoP6vWuF3YTaY0lpHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6355
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_12,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307190162
X-Proofpoint-GUID: UQuWwiNeJ0JI2DDWUsRAglE3TOHzHkvZ
X-Proofpoint-ORIG-GUID: UQuWwiNeJ0JI2DDWUsRAglE3TOHzHkvZ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts the last page_hstate() user to use folio_hstate() so
page_hstate() can be safely removed.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/hugetlb.h | 10 ----------
 mm/hugetlb.c            |  6 +++---
 mm/page_isolation.c     |  8 ++++----
 3 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 57f21279c529f..3d4de9c7326bb 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -847,11 +847,6 @@ static inline struct hstate *folio_hstate(struct folio *folio)
 	return size_to_hstate(folio_size(folio));
 }
 
-static inline struct hstate *page_hstate(struct page *page)
-{
-	return folio_hstate(page_folio(page));
-}
-
 static inline unsigned hstate_index_to_shift(unsigned index)
 {
 	return hstates[index].order + PAGE_SHIFT;
@@ -1088,11 +1083,6 @@ static inline struct hstate *folio_hstate(struct folio *folio)
 	return NULL;
 }
 
-static inline struct hstate *page_hstate(struct page *page)
-{
-	return NULL;
-}
-
 static inline struct hstate *size_to_hstate(unsigned long size)
 {
 	return NULL;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 71d18bb76b4df..b15ae05819a8a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1785,10 +1785,10 @@ static void free_hpage_workfn(struct work_struct *work)
 		node = node->next;
 		page->mapping = NULL;
 		/*
-		 * The VM_BUG_ON_PAGE(!PageHuge(page), page) in page_hstate()
-		 * is going to trigger because a previous call to
+		 * The VM_BUG_ON_FOLIO(!folio_test_hugetlb(folio), folio) in
+		 * folio_hstate() is going to trigger because a previous call to
 		 * remove_hugetlb_folio() will call folio_set_compound_dtor
-		 * (folio, NULL_COMPOUND_DTOR), so do not use page_hstate()
+		 * (folio, NULL_COMPOUND_DTOR), so do not use folio_hstate()
 		 * directly.
 		 */
 		h = size_to_hstate(page_size(page));
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 6599cc965e216..cd36b9998483d 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -79,17 +79,17 @@ static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned long e
 		 * handle each tail page individually in migration.
 		 */
 		if (PageHuge(page) || PageTransCompound(page)) {
-			struct page *head = compound_head(page);
+			struct folio *folio = page_folio(page);
 			unsigned int skip_pages;
 
 			if (PageHuge(page)) {
-				if (!hugepage_migration_supported(page_hstate(head)))
+				if (!hugepage_migration_supported(folio_hstate(folio)))
 					return page;
-			} else if (!PageLRU(head) && !__PageMovable(head)) {
+			} else if (!folio_test_lru(folio) && !__folio_test_movable(folio)) {
 				return page;
 			}
 
-			skip_pages = compound_nr(head) - (page - head);
+			skip_pages = folio_nr_pages(folio) - (page - &folio->page);
 			pfn += skip_pages - 1;
 			continue;
 		}
-- 
2.41.0

