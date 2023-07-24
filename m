Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72C175FF1F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjGXSdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjGXSdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:33:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEE410EF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:32:50 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OFOGX5028655;
        Mon, 24 Jul 2023 18:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=jb7Q4wFykVRBPqbXxG77tiTVnbM5aOsSsuwyyo25DaE=;
 b=NG6LMv6hAKWZqjy8K/YLx830bQvl9lsre7DlP8caUbR3fBjejn+A1MXUFYSZcAYsJzE2
 QZAHsnHI38hmLn6zoJrXk5VGZZ2mhYtJUhJ5fYEng9NrzBDx1ivxSdSPjcvKZOT2IUko
 DbtbJEDCbRbFPAvyl7jGhIMiExWjpidFMGW6RXK0LxAapzBpTE07JBV2DB57C+iP+4xE
 jO7w5huqy67yfNWfTavgWb3gHggqJWMJm9QIGAofqJ0S1gdJadKfaj55uY5Ai78u5YDk
 Z7cjF8UOjh4lYyda+WNROb+rq2Z+ij7n6t2dOkr2g16papuNgBkl31zjRs6ErAZoXtBN UQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05q1ufb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36OH3MQ1028215;
        Mon, 24 Jul 2023 18:32:39 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05ja25e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xyj0K/3MGOXhROXZG9HapnhP38pvaeoE9QkzBaKoylCiUY8Hsrdu3kGDhVeAELmRSCWJb8C/7IR1xN1GnvEmLtH3erftSdNnx2x6vPxH8qGVhBcXVZy+H894RiPrswQWmCQnHYvRYZDSzVX/b6Vu+93h2m2WJ97vg4SzA5ncxdNrzgzARBamWqsMjxrORYT52vyWJnTYePmLHfBpSsRDQ4eftVoo9lVm/ZAgB4JeCeAODFq5kyB+MrqhSw+r601krLugnO5LEwBPq3rLdsjKlo4UV/5gYx+/ETLIJbLol6CS5/VKBVDfL831tz5yp/gD7oWEdTHPfKIeqQMjpCCKeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jb7Q4wFykVRBPqbXxG77tiTVnbM5aOsSsuwyyo25DaE=;
 b=fL++KLMfRnXB3+GYgD3xa7dGWfsmF7OZwu9o15T2eyhI0fAp7uAU3i9anGuJ3EOxGk6ibt6JzWwsHxYCf3Iw0LpadEBFlWfchNLAaCtCiS1f3LyJtTh1mmNf4rp3Bb697Fb8o8xMR3taIWFmXKXu0B3cW/Px78stNt5SikZpIxB/M9vam3BIxUsJmt+YLvPLchGQDqCExuNBNEEboQEYHV4jXi3p17+FTW6gA/J8OEHp4RA2sCytPk4RN+nPvreUHvQZafTmguDg1AWUbVDSNc7cx33aBRrbnlG2jY7as9BWkTNBM05tUdYXHJD8m4NfJ2xzSK4DmKl1gTscYcMeQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jb7Q4wFykVRBPqbXxG77tiTVnbM5aOsSsuwyyo25DaE=;
 b=t+N4rKSjih++wyTSdMswejyKqgooJs6zXnFmPTjfJcPDWSni7AooBMdSxmU62uCGdQcxxPmf6KrfSbi5bqELCGdBilQqQhqPgOKBf/5PWXfVhXOEi2Mzd9fr8mHmtMwGyS2D0cTVOnh/YKeR0+1H67XoUHFPROLlak09IDbKnoM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB6654.namprd10.prod.outlook.com (2603:10b6:303:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Mon, 24 Jul
 2023 18:32:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 18:32:35 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 07/15] maple_tree: Re-introduce entry to mas_preallocate() arguments
Date:   Mon, 24 Jul 2023 14:31:49 -0400
Message-Id: <20230724183157.3939892-8-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
References: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::17) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MW4PR10MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 086cda87-fa17-4652-399c-08db8c745a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MB6xKQ8K8jQ4UfVmvQ85N+1JvY9BnshqJcz2x65ihHZuqD476pS5nMJaRmLeStHdo4COxawx69Ugyf7iKAlcFeAFhdeC3wg8kerWyFexKd4Jqr2IDCBwx7SzbRS0WlbyjTFAJtxY/XzmpmZXjgvClHw6bO3TUG/mhKAamFH4KZ+ZaaeYU3f7Aw4CY5TcqVGsC+FSAQbcS9kOvT5DALU9pXKf5/z7+WzfI8QRz/wv6pi+yhuHTrOmy5LfF4fh2R0Zonje+5Ch+H/EgqqZr2pwwbgM8fMCbFSxjSUumDnw/P2HM/YgId1fF3ZhpELHE5u+iPaaaScql/N6OT+i2OCIQ3FwFOI6CaH+bkPu4QSVx83V7PyCVwX0HwqzkXzQd3C5rysa3DEWGE5xA3zLKi/jPtvOKJEdPZYYFpb4wmIg3Opl9sSamx+ZrQh9IsmLitZoT5wV/H9oVjvXLC3b3FIvns4oGUA2gfvyWljS1fbgkR0mJy+7nz73NWNc5BDgTmLXKxnD/Iw7aBud48owzm17wyiyoH7aucKPAliw07srmCkMinj114+vyM86OMbJTIhP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(2906002)(66946007)(66476007)(66556008)(6916009)(6666004)(478600001)(6486002)(6512007)(86362001)(54906003)(83380400001)(36756003)(186003)(2616005)(1076003)(107886003)(6506007)(38100700002)(26005)(4326008)(41300700001)(8936002)(8676002)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PDjQW1vyw7rTjusEixlyzE6CTphi9cbisCDyCDda7vFZW/duGBJkfi8mchzz?=
 =?us-ascii?Q?715LDGsT3mC8+aWeIBuyXC2y+H73c/A14cUJvuge0sVMsYlI/3mnQHEkcahw?=
 =?us-ascii?Q?ZvnvmcDYKtF9iER94hptTWWJYs4eCuLpVVrbHXgsfZeMySDRwdzaytU5M8SJ?=
 =?us-ascii?Q?e87GMPXzzxehYJubZZVvLj4E08QfezXAZ2fX1N2dC44iD6CuC3UNX1SDfMk8?=
 =?us-ascii?Q?LbOJHI9AY3VfQ1RjgQQoprlksAqVep4jjl0Ch+9axX/V02SPK2eAVG1IvGJz?=
 =?us-ascii?Q?EWEfXsY713lympwXDijF6y8R4l0zDz+uSsf8dUTVHdD/y1anc8pLn+3tdDNM?=
 =?us-ascii?Q?tu0Qwsp61E+ei6nsjenx7Zv2vu+nk8JqLTCLfKoPLhIY64X/RY85RP0m2Z9K?=
 =?us-ascii?Q?z2rjlm5lX8IbRqzGqzTIX2Vph3f4WO5MEpbKVCvoiHPe7jck8/+ZeCZ27AEJ?=
 =?us-ascii?Q?Sr8RbZfhg0nQJNG7FL3dMXsS1KJQXWGm7uTRScAhZ0nHJLeK2iC2Uh1w8XEk?=
 =?us-ascii?Q?SoQtAy8JR5pXnSx9BGstZAlDKOmX1DP91LQypN4KSTDFyp1xMK5zS0T5mNex?=
 =?us-ascii?Q?09RhtmLG5Ku0tadlKGu9/8UnCxiDO+ZeicFtmjmIZIizIF1zYzv8tdmI443H?=
 =?us-ascii?Q?Rmx0MoXyE/+KEjp0Q+3s2BdQ28OBIJMuK7YdaGJLHSCv3eM/P4nfQz/n5Olv?=
 =?us-ascii?Q?LWJEyMM/1iRDWAlgWAhbBSZzzKAZWNqNKyWAActs8jqOdv+Uo/JlWSPQi8PU?=
 =?us-ascii?Q?EVLLSGopg09PXw6R3mdAHcNc0D0HZJBSsCjHqbYooIwjaOE4y6tLIqNjoXSi?=
 =?us-ascii?Q?/cd95zvdAmsz7mXYGcfBonINfDYl2J9/pw0qZklCBx2NYw4TY+/g6bnwxsU0?=
 =?us-ascii?Q?aLqmOYAhYMtH18pD1Z8KYY9BSRiSLKwu96UV5n/TGtlb7E95jp/UMfEywSKI?=
 =?us-ascii?Q?9BUiWf2/k8qGNMouH2D4T612t+EyrIw7wQ2CVIlWK/uB5MiA72grOFxvdvIC?=
 =?us-ascii?Q?kqSG1hmKeg6Dv6dMkHhq9cgZEGyiYqaQ26XvuWCWhB3aqrgDCB/PkH9SusLD?=
 =?us-ascii?Q?rrIXk/Tm0x4c1ksOi4XlpcKfmbmZAv9060hhTa7wKvSSxiIzWp9t4CuvAbA9?=
 =?us-ascii?Q?4Xpb6F5rHPKP0y2YuoZ2xuFbXrCJYLZiXTgRlQOpb/lBGyAbj5h2Liyp2SIw?=
 =?us-ascii?Q?/1FoHBmkJF078tiOJccTRzdkD2mc5wDkMeWeQHhJPhJblk9S0FhBlc5vUMc8?=
 =?us-ascii?Q?9ihaIiugSJu6UQdefbvsiv6LosQur4t+qis0wZZWeyg2XayfInjT3+XKGlbF?=
 =?us-ascii?Q?IxxiNiWy1TTVzlZYJFlaA0MfZQQ6ygOqZGaNjmso7hQAePn5zrvv6Po94Mp2?=
 =?us-ascii?Q?FqKwfzMkgpIuSrDG3BErw6Jp1GYztZHWnvnj6HoRvsGBMHmxnDmElQzJvT+7?=
 =?us-ascii?Q?GlksrHDQRwY/uZAOt2y8q0gQJ2ibSg+ylBtSgwJtrfWzPe7qtmSgp+b6s9Qq?=
 =?us-ascii?Q?4NIM3PaqVyTc2cgYomG3qlWl8hGcPPbCez+1HHJXtboaiuVxeWd8Ms4+H7/n?=
 =?us-ascii?Q?MJGq1AzPMLRM6qIl2fuAdYgx9isFKUGg1/MhPw7+Td7+fAo9flpKS6iZNlEW?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wAbXptzWeIjQNBjffhvss4Csq6mJCF6RaV4Xz1nynZSEiPIeuv9UM4dYcPT9JqI1USecI78KB2xV4N6yQmP1/fyONXmublMkWK5x2R/LU0zqYlWPXElLjX6R7mdJe9bTJfV8Zm5CHXGqpyeYz8rje6mKQwPXX9CHi8VZSB10V9HUl3enP9KaVyZBv2LK1exgj6v2wqjkNzTmdw6w2IwFJ26pfhLaGJygbqmRIBjocq4lhquX36C2effiH7mRobWH51NpC3smoWdBZKA0aqndWAnUyDNB/mpSZ/Cy0jIJ/6cYculXxVbbOA+o7HUsL6he9ZSN8Pl4s5IUa4MpiHQqvCpWd7WLjCcIeWUoQ6kU8xTsKr7IZ9vg7wZFB6+2vfpG8x3SW4IbHZrs2ztajhKClRPzNdkc2uhCmOIAA0DHyRswj118epFjW980g9WHKKa+ADd3GV3DVAk0+hxUIAljm+ooxHrbx2eeDdiIinpclgqqwsAK26UZoE8V1S8HlW4tZtz523aSP9KaQ8S5D0HMdd6nzLDzaDjIZyvFbna8Qr7J5MFhGF29TvSQMdB1Sk29AIBSyxvMvRV0WtbbYu0KgnXc9uf0lphDAbLY7IAp57IQqqPcVZGxVGhIjU27fX/RZ6cV1ge8Rw9hbwvppB1Ag+ubIc74VEpBHXlLFrivKWrj5uokKJ06L6Hyy/v2dNzlD1T1osxSDqE7D1bRghOVMYbpc7/LVa2Qq5s4A9R+oZYrROg+ODfvPCrdhpns57C4yqGOzT/NiZyUFn1wulwfDshbBZRzBTOuJW+fO1UyyJXcBg10LdVI7Gg8GjKJnnD6AEMb4bU9rqWdlqZs0ax3dqVgRz5F05KaLG8NOAgec/GctBS+li5DpZkFY0nX3Br3GCtHRO7y687Y5tjyU4ttbdgipdaYiZ8uIeaSglIYCko=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086cda87-fa17-4652-399c-08db8c745a0c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 18:32:35.9103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncj7xurxNrkkKpKFgRkw0wjUaMeOU7n4dwfyxJZ38PbDKCcwWXT11VmLO9hr9VezTTMX4x99Y5Qs1OdYjSrvtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_14,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240164
X-Proofpoint-GUID: czvLbS_d8E8j2A2D_wfDbTfyB8fgUIJR
X-Proofpoint-ORIG-GUID: czvLbS_d8E8j2A2D_wfDbTfyB8fgUIJR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current preallocation strategy is to preallocate the absolute
worst-case allocation for a tree modification.  The entry (or NULL) is
needed to know how many nodes are needed to write to the tree.  Start by
adding the argument to the mas_preallocate() definition.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h       |  2 +-
 lib/maple_tree.c                 |  3 ++-
 mm/internal.h                    |  2 +-
 mm/mmap.c                        |  4 ++--
 tools/testing/radix-tree/maple.c | 32 ++++++++++++++++----------------
 5 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index e10db656e31c..c962af188681 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -466,7 +466,7 @@ void *mas_find(struct ma_state *mas, unsigned long max);
 void *mas_find_range(struct ma_state *mas, unsigned long max);
 void *mas_find_rev(struct ma_state *mas, unsigned long min);
 void *mas_find_range_rev(struct ma_state *mas, unsigned long max);
-int mas_preallocate(struct ma_state *mas, gfp_t gfp);
+int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp);
 bool mas_is_err(struct ma_state *mas);
 
 bool mas_nomem(struct ma_state *mas, gfp_t gfp);
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 3b6f8c8dac65..0d7e30c7d999 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5529,11 +5529,12 @@ EXPORT_SYMBOL_GPL(mas_store_prealloc);
 /**
  * mas_preallocate() - Preallocate enough nodes for a store operation
  * @mas: The maple state
+ * @entry: The entry that will be stored
  * @gfp: The GFP_FLAGS to use for allocations.
  *
  * Return: 0 on success, -ENOMEM if memory could not be allocated.
  */
-int mas_preallocate(struct ma_state *mas, gfp_t gfp)
+int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 {
 	int ret;
 
diff --git a/mm/internal.h b/mm/internal.h
index c5ba08f55deb..65f646c2ccf3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1054,7 +1054,7 @@ static inline void vma_iter_config(struct vma_iterator *vmi,
  */
 static inline int vma_iter_prealloc(struct vma_iterator *vmi)
 {
-	return mas_preallocate(&vmi->mas, GFP_KERNEL);
+	return mas_preallocate(&vmi->mas, NULL, GFP_KERNEL);
 }
 
 static inline void vma_iter_clear(struct vma_iterator *vmi,
diff --git a/mm/mmap.c b/mm/mmap.c
index f518e4c70a7b..625d7411d5a0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1959,7 +1959,7 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 		/* Check that both stack segments have the same anon_vma? */
 	}
 
-	if (mas_preallocate(&mas, GFP_KERNEL))
+	if (mas_preallocate(&mas, vma, GFP_KERNEL))
 		return -ENOMEM;
 
 	/* We must make sure the anon_vma is allocated. */
@@ -2049,7 +2049,7 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 			return -ENOMEM;
 	}
 
-	if (mas_preallocate(&mas, GFP_KERNEL))
+	if (mas_preallocate(&mas, vma, GFP_KERNEL))
 		return -ENOMEM;
 
 	/* We must make sure the anon_vma is allocated. */
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 9901ae821911..c6c1c5109deb 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -35458,7 +35458,7 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	for (i = 0; i <= max; i++)
 		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
@@ -35467,18 +35467,18 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	allocated = mas_allocated(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	mas_destroy(&mas);
 	allocated = mas_allocated(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
@@ -35487,26 +35487,26 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
 	mn->parent = ma_parent_ptr(mn);
 	ma_free_rcu(mn);
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	mas_destroy(&mas);
 	allocated = mas_allocated(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mn = mas_pop_node(&mas);
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	mas_destroy(&mas);
 	allocated = mas_allocated(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 	mn->parent = ma_parent_ptr(mn);
 	ma_free_rcu(mn);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
@@ -35515,12 +35515,12 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
 	mas_push_node(&mas, mn);
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated);
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	mas_destroy(&mas);
 	allocated = mas_allocated(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
@@ -35528,21 +35528,21 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mas_store_prealloc(&mas, ptr);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
@@ -35550,14 +35550,14 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 	mt_set_non_kernel(1);
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL & GFP_NOWAIT) == 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL & GFP_NOWAIT) == 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 	mas_destroy(&mas);
 
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
@@ -35565,7 +35565,7 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 	mt_set_non_kernel(1);
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL & GFP_NOWAIT) == 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL & GFP_NOWAIT) == 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated != 0);
-- 
2.39.2

