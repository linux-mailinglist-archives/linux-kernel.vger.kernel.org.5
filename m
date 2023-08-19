Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AB6781629
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 02:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243902AbjHSAxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 20:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243434AbjHSAwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 20:52:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A5C44B1;
        Fri, 18 Aug 2023 17:44:22 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IFo0SD027850;
        Sat, 19 Aug 2023 00:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=feqk/SDhmjpE1eHojcZ94OQImeurSY23yvCAzDKLIqg=;
 b=uSTOPvYWI7PY4Tl3G0QrxfLTiYwWzMUQiBUN62Q+h11lLUCx4xCi3RsjOEN7ehU7lUr6
 7vuWnyjl+u0+ITbI3qv+zNFaZDAALHcwHIoNd9yDkHXz5piuBWVl6nTWMtB0M87PWAmW
 Z9dTCUaIcU77yNHO4J3MEa3Nhg+lMYId8RvYypSDl5ZKLB82J3qL37wGOWy0fxjadPFj
 eb4Luyc12kMag+kY7MD9CDf8hMrLwdfqcMLcdvdb8YJjLFxN4n4WVueSmW1TP/UGKnME
 t6tWV9UsJHcbm0+J+rngcaA3ueO5li9Pzku0aBZFDhq2d1qdy2Pr8dJqxbvpiJ1HQ85a mg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se349n03m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Aug 2023 00:44:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37ILdQ4h019891;
        Sat, 19 Aug 2023 00:44:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey412sfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Aug 2023 00:44:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i33u7vxHqaW9JRFd7bpZSdNp6H1r14Tj8qMUv3gfobHuch09Bg9XVdf/iTHKIS4Bsc7oxr8O88K+sCNsaUeXW7gjrh40z0a3K1PZC9M/PRisT+BXPirdG9OboFYLkulCQIhu8XjYPGazzVpWWV9B1yg+dEniY5ZlZNXhUOv+F6uw9sTcv7o3blenog3qli1gs4Izs6z0iynbOiKma+SoPNlvpOP5WhOUug3TPV5Sz9X0ekqR2Lwxo453TDZirakeKkZZGvR8TiRsTYJiv4izx8J63d1bI0Qn1ot+Le0N5z+buuWxClEwk6sDoYhLxInxEf7EYEdVRoUz1Net4LumtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feqk/SDhmjpE1eHojcZ94OQImeurSY23yvCAzDKLIqg=;
 b=WKEElb4wxXmfvPyKrGz4zYtHSJQlDAZuS6rFRP6nyZpFbwJGsTuG4nESWtNa9wVY7cmv6Bv+1MAl9ZKZRG06xqC7OwThKOcwQUeyzD3uQLp6PKrhuc5ZamsF8nu4szOSvIZJrYGI6lKsG6xoTijpIdIdcupMAEtMYk4N3vYYonJCcKgyNhhHVgad7CZqlzsV5Wc0/2XyudV49NiDtkaXTux0jsljyYpoOcI1DDLmeUUU7+0EXIQINmKILyY7o7bFrxtHEKoE4KPIWWbfGkVX0IwMoTQGsgdW4KLZ7ZaNbcbA9EQC14Joyr7n00jyC0Eb3wqMTaOwGDYmwflRMOO+iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feqk/SDhmjpE1eHojcZ94OQImeurSY23yvCAzDKLIqg=;
 b=iiiAUDHfaaXalCgpEzoOuo+oFho+smlJbHSCpZJDgqqCGSAHK6nNLAgDl9pzm+DIY7zQvdf7Nz/qAfXm+QNsiOo81uGPaO3BhyrJeAWwnyTsn5IOA9zs9+FxYFzuIA2v/jzJfDWNp0rrf0CKrwclapXxJqPtVOFPtSwKdNZ4274=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB7167.namprd10.prod.outlook.com (2603:10b6:208:3f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sat, 19 Aug
 2023 00:44:07 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6678.031; Sat, 19 Aug 2023
 00:44:07 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, stable@vger.kernel.org
Subject: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other readers are possible
Date:   Fri, 18 Aug 2023 20:43:55 -0400
Message-Id: <20230819004356.1454718-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230819004356.1454718-1-Liam.Howlett@oracle.com>
References: <20230819004356.1454718-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::12) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: 10880033-9e6d-45a6-0b2e-08dba04d653b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A3G7MPfEkmh4iiKPN9LARMD+gN9Ime8lwwebWJ7KAy9s+XibYDQ53Ojmf0TaaiCqOn7bNdZ6At0j6ZbXz1YqzBHBaOQCMBYfqWNzdSiNmrW82l6VnbuD7tywLOpJu/LE8G8X6jd2ftKxH6Cka4Xcwbdjxdt+go9gfm6r0DpZzijlEPYuZreg+20ftoMwW2KlIVZPuWM4c9LcLO99DnNlkio40LJcauDp9XiOPFMYCOKEwUZsovwbW32vOuLaI8hIOBn0xLDmKL4y+XZwfFtN1RRsa2HLjGTNDuHGjoUt//MmcO+tLO5Bx5TFjJCGZQrvYL2pZscf4RmgmALuf+cQf6fewKjcEEGNFEPOo0ghG0ahRZukQ43IKusNM0oSPnGij3FAKE670RdAQpzlD6FyOA3z4awgJk9qvDwM88ABFgUaoT/laGr6zh0yoPXvZjGdsm1xtQARvp4xWaFOCwgCY5gGRbap8eGwE7MqPGZGQ3HL+rjcUPmChnMntW4+Rut/fmEfvJlQbumYDoVgSTmH0Wdq3fs6qnoVoP3LD8LINJZ5IDyH3uvTd41QS0x1TcqS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(396003)(376002)(1800799009)(186009)(451199024)(6666004)(6486002)(6506007)(38100700002)(6512007)(1076003)(83380400001)(36756003)(26005)(2616005)(66556008)(316002)(2906002)(6916009)(66946007)(66476007)(41300700001)(86362001)(5660300002)(8676002)(8936002)(4326008)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3i8tBJ/8LP3YZ5RXMQU3BDutkswK1FUKT/t2uB3FFKeHpTII9PcIEQZXvH50?=
 =?us-ascii?Q?s6IhmLebwynDGgNtbgjPpjmKheVmQuP1i21kr1RvCYNOj30C2ZbYFGtZa5tR?=
 =?us-ascii?Q?M39dt/E6Cb/ftdgnhmktvYoUyA3kmhawvgZQRlXLNtMbPw22NH4Pdg61pw/5?=
 =?us-ascii?Q?yOgDERUJBcfRyOTo2PfTyMovyr5scIiDU/YDRJhyphFrlm1Xm3BzKqnXDSej?=
 =?us-ascii?Q?D+afdas+0yGhT5CLvspYeRn7R1Kp8F2/b8PvcTlgjkMyniAPh1nUSyWz0ovf?=
 =?us-ascii?Q?E0bK0d6VB+lODqVmxIT2WSHTpKmVzVoLBPxwkZDFozi19hRNzw/D6j4fQzoA?=
 =?us-ascii?Q?hLyNdETvnMNWxpK2XmrdIHOI6FWnivk+jFHxOHJrIS+T/jxv7fJd1yz+W8Wz?=
 =?us-ascii?Q?l0BjGWCOKNaQs3mXmYk5v372/oPQU7p8YSgqZPXFupnaWDTUBNbZIsvBCASN?=
 =?us-ascii?Q?VwZ1e8SVRS7rrMfAW0uYtdJo7//GBvCAhl+cPdSbiThbP8alluvK/TuTcHe/?=
 =?us-ascii?Q?zmWkoZut1OWw0FSfWpvJFlgCbeJ6SzYQk6u2PrPtyY0rZ00FUF6k9YceoKUf?=
 =?us-ascii?Q?yxnnUAQ9xPXI72jaAJ53FFV4dHDDp3Ex964Ud8aJIQ9AcwSnlK5vEY2idInj?=
 =?us-ascii?Q?JkobDbKgt2jH2jstaqNyk0/0i2CwkucOSLqVO8YMBA6yPPx1tJsQ9FkzZD6C?=
 =?us-ascii?Q?AS94OUkh4cpD6jiiycd4zewYewcBvZ9zNrauMExheJ9QEPzbaub0arcGALDH?=
 =?us-ascii?Q?p0RJd05ybsGFWCsH5K8LTV34A5ifwOt410C8CKXU9ftR1P0J3rYoFmg2/85n?=
 =?us-ascii?Q?gqVi1dXl5qgGhrCfmspd1fcS224NMnLl1qVB5d/6NvDiZPpALk/RtKPs0pzT?=
 =?us-ascii?Q?MBHZw29P5Vhv6BmkMQt6Af21uvMNf+Ixc9MCUZP4cUeKKtuNIrVlsxmB7KTC?=
 =?us-ascii?Q?5nDy9WCvINwUi2UXqhUnH8qyKd2y41x/K1EqUTzNPDbK+esr0KJkcjhAmMra?=
 =?us-ascii?Q?85kH5atrNi5o4UhwtkPJnrfc0Ks5aG/MrXXFrqahi0F8gSwUv05fnMgyBCF8?=
 =?us-ascii?Q?3dmM121OYVyNzWnAOBSjLzSacXHO2yESX6KWU/KGWaQE/l11mKlTG+ckODJb?=
 =?us-ascii?Q?7yhZuVMWqqveB1gKmM0+zSf2UC4aD08liBXIwmZIm6/jn77hxB4eqVLz0H7c?=
 =?us-ascii?Q?CKE3CgM6B/zTwgD+NzhcrJyFreGtMDOLtoz9nmiViMEXsd0QWO0n5CrJ4IRx?=
 =?us-ascii?Q?7xDqZsr5kMIgADeIMSp5bR+Np5/vosnGlue72gkVSI1LMXK3s/ZrssU77bEP?=
 =?us-ascii?Q?mEBUKaptvAjNcrh+aDC7DCHRb/WDf2hAkI/xBgtc/8ANrQd6OVAF/Q5RFBiq?=
 =?us-ascii?Q?RMlacU6Jv60MlqUk8GkagUE9rlaBULa9+XKLzx080Tyw4tGtJP09o7bOG4/n?=
 =?us-ascii?Q?q1zAUvkH5TLzdm2wr/GT5GCRIcTaPBCz51Sb1M2j4UuVY4GElBr4WTWDZVGE?=
 =?us-ascii?Q?C4Xz5cm0DogIiF4dpZSakXDutRDMn5hGvOJbnOtlTN++/ubjDb5mXjsmWgK5?=
 =?us-ascii?Q?RIsI1OLf1dIJdjljGsxf807TBjPRj86cFuJ1O2uL2r3NWbv7MBwBRTzMisun?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QnwiQRVfitle3WAqE+bo6sSTNHkn4JZUcBZcZh4kMI5oLDmWwR63HjR3zsbIWfODvL8ExJMtx1CdURCMFfdCRdBywr8TS9IbURlje56nBI8cgjO0ZzJGASDysNwiadzz3y/9sI5ThDuE7HQPb6n//kvlCCd64zbBrSpPIadvSe4wtfOPLsfJVifz2kSO1eE+YqSgLy2WVoEnquEMimdTjUOu8tS3gvlMJgedDs/AdYuBCzMqilhBxN9SVPmyR4jD2ylnerQoNg/f7c8zJ3Hf5jSO2n2qv/Rt4T8P1uTTfO39xYEhAGbgFwsbQyREIl9Iqp6Mwl3zPwCH2I9CCsS4ZQs8DSOY9jgTkundesJSNQn48S4G8Q0yJe38CAl78Uor/tHPjWYc6gka69NNlhQBFnj1es5ftcrHXP1SvszOfQLFGOxZt7RqVdQkCPyUMq/x/AHXL/8FCfsDVHYna/NiGNnW2ErvIs3lT6ncYD5NcUs7LsVSvDLIpUtn9cBakUsMNMgadVOZeKVFkVqDEsGKOYE5jyPhu/mdOzEEaG6zG7BGjsoP9XbHsuPhJX54fXhkTCq1S11C8I/yIIRBQf9J8HsNkAopb3YUxwDTioT87691/st3474RgRlK7wwArH95ojTSTZlkwMK63mJJulFrArreqV1EC2XRitbIh05v6dHxwj+teaj6AADf97rzvSx6H51BNIgN110exBzmfXH0cRulf9J3ri0V9aKEWFf7c5CchKsXfEFzF0CV21JBr86zo6hF8DQbqnKq62Zm0lpnzYV+puVIIPypSK/ciw2ZWkxY7uQMlDFDBeKbQHVmo+zmk50KFNrZ1ArTzVEs6pvWqjeffRtA7oo3sebEK8xwGXVCiWkb3CTcFSmSpTUUrT0c6TZoh8TR56Xmp84S56cqBg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10880033-9e6d-45a6-0b2e-08dba04d653b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2023 00:44:07.5592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJZbeLVPQa2L8XMYXKo0YCMKArfWHdm3ASFSX/gOGa0yb32eLfD1qgOjrtyTmzK337yo0P2qBqN8F3sljQXUZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_29,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308190005
X-Proofpoint-GUID: 3e8ybFcaa1jTjk_lx8iRuzf6pqXGUY86
X-Proofpoint-ORIG-GUID: 3e8ybFcaa1jTjk_lx8iRuzf6pqXGUY86
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation of append may cause duplicate data and/or
incorrect ranges to be returned to a reader during an update.  Although
this has not been reported or seen, disable the append write operation
while the tree is in rcu mode out of an abundance of caution.

During the analysis of the mas_next_slot() the following was
artificially created by separating the writer and reader code:

Writer:                                 reader:
mas_wr_append
    set end pivot
    updates end metata
    Detects write to last slot
    last slot write is to start of slot
    store current contents in slot
    overwrite old end pivot
                                        mas_next_slot():
                                                read end metadata
                                                read old end pivot
                                                return with incorrect range
    store new value

Alternatively:

Writer:                                 reader:
mas_wr_append
    set end pivot
    updates end metata
    Detects write to last slot
    last lost write to end of slot
    store value
                                        mas_next_slot():
                                                read end metadata
                                                read old end pivot
                                                read new end pivot
                                                return with incorrect range
    set old end pivot

There may be other accesses that are not safe since we are now updating
both metadata and pointers, so disabling append if there could be rcu
readers is the safest action.

Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Cc: stable@vger.kernel.org
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index ffb9d15bd815..05d5db255c39 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4107,6 +4107,10 @@ static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
  * mas_wr_append: Attempt to append
  * @wr_mas: the maple write state
  *
+ * This is currently unsafe in rcu mode since the end of the node may be cached
+ * by readers while the node contents may be updated which could result in
+ * inaccurate information.
+ *
  * Return: True if appended, false otherwise
  */
 static inline bool mas_wr_append(struct ma_wr_state *wr_mas,
@@ -4116,6 +4120,9 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas,
 	struct ma_state *mas = wr_mas->mas;
 	unsigned char node_pivots = mt_pivots[wr_mas->type];
 
+	if (mt_in_rcu(mas->tree))
+		return false;
+
 	if (mas->offset != wr_mas->node_end)
 		return false;
 
-- 
2.39.2

