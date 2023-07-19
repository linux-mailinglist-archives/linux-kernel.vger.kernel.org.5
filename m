Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1280759DA9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 20:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjGSSmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 14:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjGSSmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:42:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C49F268E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:42:23 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JFOLws029558;
        Wed, 19 Jul 2023 18:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=ghk3FXcPT6g+J2Fp2fTvvoGqnsfb7o6hHXD3LfHDRrA=;
 b=CFdCdSFH7nFDAytXwfnVKr/xPNuFfMlJMI4T9lTM6DlFhakeJKgOShY4j2vKjMGzetxw
 IvxXW7kGfTRITOb1pg69EUMmZGMqhzM6lbpIfEUpGds+6BWhHmfpCFwdfNw7cnn9O1ry
 5V+w0g/QeSwRz82PWdTGLhdHBZfq9uzDA9t86LL8MEYoLNZRTs6gPjml4c1emdFGfsK5
 cZR6/g/j6/V5tCt3TUgSdO/v77m2+zqRGqIsl14jUaZRQxkWwDW9LaL2Iizfl7D32g0q
 cLpZMvnx9FZCuV+XU/YWX7qYancNp68TsL4WxHaORY06ZYyTaTbdb30Ub41B4qrrI9jU 5Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run88r89a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 18:41:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36JIFu3q007801;
        Wed, 19 Jul 2023 18:41:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw72mdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 18:41:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASfntmY175LUGcei4O55+P2kL8L8vZOkvqJ9D0/EdHGqKWA7BFVyUos76QHQFiiqelS1vtk30ANdl4klAPRId9yBPxAleh4+KPFzc4gbVXcH5YC+celpXq03nlLQTSQOWauUq9IPf2G8mZu8v27Mi/P8oaQlXflqvr2P0WZHlOqt58Ksbbn5p2AleHzP0Zcl0DePQnBQh08zJMatOnJ2r15t+E/4zCuUTNhAFEQlUBoKWT3NZDfI1QZYYZCSNJCrVGcTYpN6zeYhQW3Ni6l4HSUwYzoOSj0UehofBW5V33A0YQcyX5wO5JxqEdeFgLmYn0Q9e7EW37afCWFAxmwCtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghk3FXcPT6g+J2Fp2fTvvoGqnsfb7o6hHXD3LfHDRrA=;
 b=NpgzsPm14NzRJGUtZcB7gyXSlr6NRCMz0pgF9YhcchQCG2CvFF4nhA0FQhBZVtoCPfRTNujJBWrIaSINTQN6gde5H08xwn47TXy5CuvZpaijfwEYKGLiLmdDgVuuLqlz4/UqhgHOAIr7lJfBBXNptSMDkVmi8ePDbp80BF48cJjqXZix9/YesmwC9y3GuVq9Op+8KF36WKPQM5zxF5JWc8JaLqfZ2WdCOy6Khz+kWjSI5fv5ViDwzwgn/MDM54zKOGWOEtrNNE90P4pNUnih+xymPQl4g6MN61rO0X6HOJH/hp5muWnlio/78sEL//oWwLkY1sRr0zCGWExUlYgmtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghk3FXcPT6g+J2Fp2fTvvoGqnsfb7o6hHXD3LfHDRrA=;
 b=Js85qWEu/n5u2nkegRR1QAjdi00YTrtHHnX/l6ZvcVNVlOy2+aUI+rNZOz5kyw7UvLOo6Bk3rErseOrYXudPQTPVOBmgtcCRzJDJBuqWKvzVOJEoZYQULLeDLgiTxy38S0cNmY0fYcq252xcUc75v61fwv/zP50TButSlBSSar8=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH0PR10MB7536.namprd10.prod.outlook.com (2603:10b6:610:184::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 18:41:51 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6bff:7715:4210:1e52]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6bff:7715:4210:1e52%7]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 18:41:51 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2] mm/hugetlb: get rid of page_hstate()
Date:   Wed, 19 Jul 2023 11:41:45 -0700
Message-ID: <20230719184145.301911-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::33) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH0PR10MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a22b2d-c2b3-4dce-4c4f-08db8887d138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5QKG+eCB0MJIX305akb3fTBOo52oDQlJY1aJCQKIyBh+EcYb4bQYzfVZ6Hs1YXXczdkE+xGfQw3vTNS0Pgb+KcluqqqDzFoVjiEHflrGAtHfnAhHQsoj/0UDj8U5GSyC8B9hq6zdypHj4gZqaqCTvBqO5a6zJvZYMIYpH8MjykPwd0iV1Ggi47QW+270T1MSGfAWFalT5/YzNIWClebOY3TYBrLJPDAUoJdxXwnPNQppYgNYmRqEqLXtskow0rY/ujxLIgARAMlwyGNk7Zh0PApoX6dlypr5x6yaKE0iocrEbik3zFC/5f+vV1lHbTPlo93VfZvu9UGxJv1FNEANRllza3r8coK2J8ZTCNlUm4vzRwNyH+KsWZY8nHzJp6aAHNs/1/qK+8NV0C04dVM+wyt6pyPc9KdWP8/rLtMoWVU/1Z8mefHCf0r/erYDInIJebPj7ceJBGVOUwxL/N+YovC+5+khX6kbTdXyyMg/KPmfZzeUayx+W067FbeKpaC0jEZUxVBMOieTXq2UUx+PYGSUGOwlQp5yADNsJwogChIShZo+WRxreTQGR9jD4HuQ/yqqSd5g+s20NAHnjdHqQM7HRZwvk96aVstFjM1Wiuk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199021)(6506007)(1076003)(186003)(2906002)(6512007)(107886003)(36756003)(6666004)(6486002)(44832011)(38100700002)(83380400001)(41300700001)(8936002)(8676002)(5660300002)(316002)(66946007)(66476007)(4326008)(66556008)(2616005)(86362001)(478600001)(26583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QseRY9kFJSNBlP8yXNOKxj6OHKSmHWpqMlGHghv9OIUaCF9Y1kxplFsju5HW?=
 =?us-ascii?Q?IvCUlszNmL5luiiWTLu5uW7sd3jJ4jAosUi/iFw4VlwKbJbwAaGsghKoo84l?=
 =?us-ascii?Q?g/fi7M6xRLWIP3ukRpPONfoNlZzWFesQQJoUjAmr5A1JFpQROfsLUFpgdbb2?=
 =?us-ascii?Q?t6sahUTmJLgCo1czJFL88sStg2lcehKFYGrbk0NwAL/95V9XHYSxWDvP5nJL?=
 =?us-ascii?Q?4QiDMZEsOTNmLcSDzh2MBRxI1j3siYJ67kmNmG6iItffxNOWns5tS6oqbBqc?=
 =?us-ascii?Q?Z36uMWO3A2humH9fazJeE16I8RRuLJX56AiM8ydrGLiLtHSIr57quARA7nKm?=
 =?us-ascii?Q?JVxwoF93Ix+zIfQuo7mnSBqh8vLlOb1XdNAbE6RGk0yfOPabGzApiN4yy0rc?=
 =?us-ascii?Q?fftsOkfc6W5oAc8hRPFH40I3cgaE/z2xUq9opx+ziB0Ek6z9qYP8pIHiyIAL?=
 =?us-ascii?Q?zw1Cgo0BaTJw8mgtK9qnSoHJGDqffrXwK03xHYnaBy1MXz/44kxCHjGfgbV/?=
 =?us-ascii?Q?aYxU7iAJUO9O9vEerTSmdzq+1EIvAtWWBTfjeB7Ro5bvRosRwKc+j6Y6yKks?=
 =?us-ascii?Q?LUd1RekEYjL1GszGg6lj5oOSEgY7ACPsgnMKLBve+W+pOpaAbF7wH8Tsuogn?=
 =?us-ascii?Q?s2AHq7R/oLlGV+XnZMORpvvX38cf4qUWI2xZfx+9+7aZ3OpMlQi6dEvhpDb5?=
 =?us-ascii?Q?N75ib3xXPyqpYR7x3zYUWX96MEo2K1db96Mu+fwrBAjKnSJ6nD2D0aE7WLtI?=
 =?us-ascii?Q?O/ob71ixhCU5FB2iWFCiTW4sQU1+cGV95+7/bB6/RD+AOe8M6lW3hfO5ZsJk?=
 =?us-ascii?Q?o/WoSq3BfKzSTfeC0yPoPZvprYzTajJD+haWbkGzW0BD1QZWeyHyDcyr+GK0?=
 =?us-ascii?Q?MRuJD5kSsax4pSZV5K2cPMy4lWRe/Cn04xaIjXtoRW7vUlDoTJUJYoLdv/eN?=
 =?us-ascii?Q?s1p65rvttvZkYq+4aApGTdNviFmOWna0JjeY2cf/0YosxUf0kdll8VyKullA?=
 =?us-ascii?Q?7GIdAVVKDgyGJW6n1gg8vKVwY1NzUVxqJZNei64SU8N954ykARyAmRwBM1ci?=
 =?us-ascii?Q?pNQYJb4yqwjkrxsTxSp22SbLgzegcm7XaeNXBlk6ijkKKZbAq26N0zmhRAfM?=
 =?us-ascii?Q?OGfuTDdt5NjzuXAn5XTzFM1ysH6yEYFMPWcIJUgdM54tM7mdWw+FLmphYK+O?=
 =?us-ascii?Q?faxB+BhkGfyK4EwvS7DMxUsl+AH53ouQgpxNvj+PCIBBka/X4gdSkFeH3SgM?=
 =?us-ascii?Q?NHJKdmGSTUFeT03oRFzcNLyxX2pDRmLE1U4cq1MFcjSWZzNOcn6P1D88+Jd9?=
 =?us-ascii?Q?NO4O3kwWdhKNF0A5KdNVoTbPJCgZdPejNPyAbwgIg83XhGPB3/X+j0cbgIL0?=
 =?us-ascii?Q?vsuA68O7oJhdz5TxZlxoEtwI2UD1z+ot6t5nYAPYXKDlXuxQpazhhyVnaTi3?=
 =?us-ascii?Q?7Sp0ukKp1KQEMdP5rCkdJXVbgg03J4uHUxi0GTetSGz0bpqYYvVTzWGw2v2M?=
 =?us-ascii?Q?i2ZY6bnMTedaUuj8IxGHYoCrC/Of6bamj4nrQgeztdwb9WoO/X3eExTFpj9N?=
 =?us-ascii?Q?YH9G+34KtzbtY5cynUxTNSAmXXXcO/tIjN4f69d6UhJDFcW/XWZO9PW6q4bH?=
 =?us-ascii?Q?4gcMmVzPGvHThazS6nycazY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5EHLKpR3uGIUV/VnlggLLMEFW2M2GkAqXD35puPq/4PpjxdFwvY2H5wRcURcTa3DzCvrWMD06KfHFz3UammCk7bY71dtRWjfdFoXBXWzYLwjEQH287aSeDF8li405nlTQXpRSnQoib4I3NZu87vovuEPGudMof8JIj7NX5GnLNnBlaNASZPOKmS6cPi1ZkVYrO+jOHksc6s4FtUi1tb6brz00OYJF7z133Kp54m2I4FiS6PwSD+8liyRpMdLlmJUFthelOZsrSKZU0WHRyW6x2Jh3nfIt1E8hyaddWKqP37BcGQiLE22wGtL4YbcDNj+h6yTmafVCFBXnBp9U9MHzIvnaI8YWGApwet6NeZJyeCqRLCDTWZ9o32H14+5+0TtuHpCVw6mM9D8hlVfUnxqms9xVk4tEREL8bHatbWnpsnSKeO8X9DIoRKiH1Sz8cl1ghLPemmxXSs/RZu766o1oEr0G+e0pf7MhPhgrU0Zjq1yjen648V8sKP/Z74k5qXhjmsisyS7nejM70U5A6uB9h4KLo08Ug2rJX2HITN/X1KwVSlSQYuMrnwIdu2XzYoGsROjRZfcXy1aq0zw1TbcCyIkA9srbV6OvLKmvD+t8+vVUDhlqz/omL3AJOWHnLDzVvJEJ/fYCmudNRis1Wschnpww/glVeMiRtaAaa0AIhH7rTIvVcKD3rtvpb1av6mYuPwk2gc5gsfQfCOZ6GbDSJcNYBT9iPrE41dP9WOUHEWCrsunLwPzKD1oFmNhhhtDfZUHEIJWRZgI2aQYt2FJQ/7YSRfP06bUUQVwslfw5BAxXh5hTjljM+7P6WCCL9ZCYP83jSETFqs0IhDxyBHwdDM7PSh0itnso97zaL7dsBcl/EFQ9unGwMeO2bYTEt2+Ml+6s+Cd1E4KFbmjAmto9lutqWufLPO/1MbEXEWYVP8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a22b2d-c2b3-4dce-4c4f-08db8887d138
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 18:41:51.6935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rH3FtSTKfvTO0Bt9grmcnkuyeymdXH2Yvs0EXsQ6fsmb6zih+tQ7CukojlUfwuS0UJVh2JfkZJxrTnfGX3kxpJWi6UwCe0Pb2gdmoMlLJSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7536
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_13,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307190169
X-Proofpoint-GUID: 7FzzVbTnMOQUiR65dN2ngepHNyIrMb7o
X-Proofpoint-ORIG-GUID: 7FzzVbTnMOQUiR65dN2ngepHNyIrMb7o
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
v1->v2:
	-change (page - &folio->page) to folio_page_idx(folio, page)
	 per Matthew Wilcox

 include/linux/hugetlb.h | 10 ----------
 mm/hugetlb.c            |  6 +++---
 mm/page_isolation.c     |  8 ++++----
 3 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 9f4bac3df59e4..0a393bc02f25b 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -841,11 +841,6 @@ static inline struct hstate *folio_hstate(struct folio *folio)
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
@@ -1062,11 +1057,6 @@ static inline struct hstate *folio_hstate(struct folio *folio)
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
index e0028cbb86c09..154cc5b315727 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1812,10 +1812,10 @@ static void free_hpage_workfn(struct work_struct *work)
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
index 6599cc965e216..bcf99ba747a05 100644
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
+			skip_pages = folio_nr_pages(folio) - folio_page_idx(folio, page);
 			pfn += skip_pages - 1;
 			continue;
 		}
-- 
2.41.0

