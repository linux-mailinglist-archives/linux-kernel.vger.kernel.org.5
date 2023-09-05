Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7A5793132
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236883AbjIEVqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjIEVqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:46:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87291CEE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:45:38 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385LAurb028694;
        Tue, 5 Sep 2023 21:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=kRYBSglqq8cl8D8SZbgGK19NxyywhgoGbNK/s4vGIc8=;
 b=Gg4cWPhSrIeGPRDeV9iDl7kBDNRQJRBd66QnhsCOyjS7vwlCupwf5iBV6yTE1SE8yA29
 wGKPnc6Mv8uIIHOXdt6yXaLT3dJUbhmG5+zqnt7+BAST+mQ8LRVbR+kacT0xhQR/iz8e
 nOUVCs6H7+sbEMJkaSCetEVosjeFO5A/javR5Eh2iYstKCy9jCtHFqRsCuro2Hm+p5Vq
 CqeJVFCczPWM0afNfDuHm0HtwPVU/AbKu0HjxLY3FvFqEg1eSt/PGs3AX7WwTq6P8f1c
 S3nrSCenBe+JD3x8Ox9D7HR1QeHtaxqDOS9Gr8V3ftbjr2CCpi+ai6qjnVarRGCh4FHu 0w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxc0sr1qf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 21:44:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 385KKIJv007701;
        Tue, 5 Sep 2023 21:44:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suug5c6ur-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 21:44:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEYqLj0R/Dwd5VldT8JlMCTV+F79ttlqUUzSPO0J4Bl3h/g6XFhqz2M/XnEPGHrINhUpH3bI0trKUcyhsMLsdNCrrg72g8u9bkiMMoaqD76u94Hgc5jCRs3iHPgF3+yMDHWRFucpeGlKcFVEbDkxAI9udW0vhwq8LY1wnvJIMmDojKWbFttcNiwu8dA0lJUBNhc+q4Qw0ocuVXu5qnUFQKU2nmsob3wqsJBm+UmajeF2qx1Xk/dGYWArOfsNjQgJswxXF4Lo90BDchOS//MVm6iOcC57CDeWPv+9iVx+42ZZV6hbEM2w3pW3idSuKEc2fuYSJMQe6cRhZIxp7R+t8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRYBSglqq8cl8D8SZbgGK19NxyywhgoGbNK/s4vGIc8=;
 b=Hz+xpn56Mmomzb4CVQR4Fy4QFensbDIGZLGD4JtdmB2IP+4m2QBOvtwnoPomgrSL/CttDE9f6i+NhDb0pziDLBnq8FcXPaTHJFKwN4t2p5nWwS+TAnBNiJetL+PcM7mvj9ymFbFIMPXQZ2qodqFSFqUtFNVcXSmnQEeiBS1SAEyZmYds6hrPO6xedqEhZPCp9mzeqoQ70L5lUxbckD0scXu44aXfr3i0Q585krGjlbYP86RxCdk7XaULxLhCn5A/R2A18onVBkYfiWFIPxI8wi1tA+jy2fynvwTfTCxgz5+l6/IB1y849mL3F6wkT2Ko48rRCm8QsheHGpq3uAJJkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRYBSglqq8cl8D8SZbgGK19NxyywhgoGbNK/s4vGIc8=;
 b=0L6cHcMwXpOCeRdQBFBW176i4fcyYU9cAcYhcWHISfchX5vOhiVimDycImJ8VYcjL6RXs48WpRWoI8qm88RoL1uWxEzZSWa6v1WHjSTCLXXY9opLb/fivF8fWAUh1Zf7O73+oJBLaq/TjA5SgZd62ufVspMUDx2TR/9gXnl4Anw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB6395.namprd10.prod.outlook.com (2603:10b6:303:1ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 21:44:35 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 21:44:34 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 05/11] hugetlb: restructure pool allocations
Date:   Tue,  5 Sep 2023 14:44:04 -0700
Message-ID: <20230905214412.89152-6-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905214412.89152-1-mike.kravetz@oracle.com>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0230.namprd03.prod.outlook.com
 (2603:10b6:303:b9::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 70df22fe-df4f-4df5-4cc6-08dbae594ba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T3QwQ13jOEcQg71N6od3CcjLB7pg1n9FicAXY+8jiMaqkqva2oFL30OlU2mT08vbeay9vD2V0asedKFukILpheamoQgLV3ehkNlbnfSmsQiJ1qmglgIMoZE/ul2yy7Q1Sg3INPq5xjCgnztuj8P+k9T4T0qMvwlYC8miNkW/8IWeW0FDe72Dpn5+sniNAuTxyDAwHJDX+ktUvksvjRUTc0qAhm24+JrMc5X0z4i/YVFtMqT6BvOIEAY3yq1xwwJNYWlKaxTOKTDm8KbLiy6DJkogDbBwQvmDwRKQcMNfL5Zl5zafMikU5ykr7y1SXF68a+QSf44MDpVhtxIJTBi1FMQ6Ge6MEte4EhM8kZvptz2XMqNh4UdRHEaqSgdU3QCRaVdJgMeWmHBgqN3oxW8Yb14vKMj5lKNRIMitYzHMtWLS15onJghMjG7EuvVSpN0d9vqI6nBAohyGku9bNgFERLgNFJ8XFYwxIA0I3t8iTAfGULOGPa7PACU4bxAxT1WjzZWxWQGP6htWSANNQ6mJrfz6+5T1esXXlX6UKXgsWClptmx1wpKjKdK6MN2f0mNn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(396003)(136003)(186009)(1800799009)(451199024)(6666004)(6486002)(6512007)(6506007)(478600001)(38100700002)(2906002)(7416002)(107886003)(1076003)(2616005)(26005)(83380400001)(86362001)(30864003)(36756003)(66946007)(5660300002)(54906003)(66476007)(66556008)(316002)(44832011)(8936002)(8676002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QNJdy3t0Qk60UekGctIlx5RhmKcGrMx9+1OVKPvRkJ3nfgAz43GrVvI7ECsw?=
 =?us-ascii?Q?pezqP/4ABUDy2x75ug1mIS02taA7Cj2rdb1o+HMABImc3Cr3ukSmK/yi8i+n?=
 =?us-ascii?Q?VJGvxQ3zHJORhGqCQg0JV66nkZxkgeRy0smW9KCXVprU/urnnOa/rxXZ1KOK?=
 =?us-ascii?Q?WGtOGfMHggA1S2loxL2CQ6ekq4B6z7jscnKy3UqZp/ejTkF8keWPQYozIPrd?=
 =?us-ascii?Q?C8WgzjM98JC+tEzAsOk9sIiBY2FARcvKnV12G4jvyzgykRxA3OFotwkHjw+D?=
 =?us-ascii?Q?9xXojQ62021W0Du7aGasa3aNUOu3slJBFSCNjMRXvlreW7Gkw4oxG6JPMwrH?=
 =?us-ascii?Q?Q57QEISk8/7+yqb3KbWV4PMlJ+x0cHl18KPkpV1gCXAmGgIpqOoca90rsA9u?=
 =?us-ascii?Q?NtyKu9v50UpkedOjSY+56O1zJPiMLwST+CCK/igO3eaHrNs0G5U6T7TFTtBk?=
 =?us-ascii?Q?XwQuUAsroVaBF25XITgLzp1QlSipMBqzUEXir1RYYvSSHMk3NkaP4X0ikRQS?=
 =?us-ascii?Q?4yHMnekm/vlN8ajs+PFBn1mPWubcz9wj+GTzebxAGRdy9pHT3vJOt/wcTClE?=
 =?us-ascii?Q?8Hfx0L3z/7PiZBNDD5Nskwh1NTrQkfgAtXKO0apfNDUWY/TUwrMdUsCPOvxK?=
 =?us-ascii?Q?FRY1j3aeR5OrPt4Yztt9y2OUvMhMbOS2kzEL5+wNwMFziz1nxQjoV/YTy9NF?=
 =?us-ascii?Q?OSZuWiJiYn5DFT9uMKgGmEtsr/1i5Mu/trSpwRbLbuznso4ZSZer9q3ipaYW?=
 =?us-ascii?Q?gBxUKReMyJJmkDh/zJVX40A1Ce41K5VRZ71YLW3BtxYF96G2BJvIqWu+u0oZ?=
 =?us-ascii?Q?ZcaSTo7r8a3Whb3V8NwGu+OK4QW0koiwi+P2KgMOW+7d937QEMMU5LqcUEDz?=
 =?us-ascii?Q?emdUul3kDYblzWY7hqKNJAdwgBtNq3DV5Ev4qlglJG2KvYs1FvM63/3zPJZw?=
 =?us-ascii?Q?bCTXlWkR0HTCl0x0cIVzGFFf2bkUqE3uMaub/cH1D7i0bEZZGuvCemeAufYR?=
 =?us-ascii?Q?UnfnoaCvky+N+1Uu3O9e4WLPFEQ71QxjK5M2NX5PGXmk3ZPOPZVWFlqSGSIv?=
 =?us-ascii?Q?PTyP8I4A8E+OIAIStjHdbyR9ex5tArWkbby4dwloD/hg+zPtycZ5E6ktBKuV?=
 =?us-ascii?Q?su3wkeGa/Spkm0i7+5q7ru0OUWjcJRO34OID6YlZkNZZ4xLukoPOpGvnV5lO?=
 =?us-ascii?Q?W0R6A+463ptzIKsqoBFToXlf+148VrN6bo7vLg9onlWgC/iN4WTRyY+hZAh3?=
 =?us-ascii?Q?KeJc/dolXdM5WolDglD+frE+zou4G9bQ+1kwzR82grLCDjUe1LjK/gsYWMKD?=
 =?us-ascii?Q?i1V8oP664ciaNR4IHQEdB7jgDV5Pm2rgVUULIgp67O2zBIObaSD+iHhInS4f?=
 =?us-ascii?Q?P0EgwoOPtgWsDTG9EfavVdOMyvLQtp4Iqoiy6WmuXJV2ueq6qMMLOptSe0sk?=
 =?us-ascii?Q?cAhDlb3RdkSwkDOVBEn6xqmfQlKzif9yhDn1cr2dY1QbtChRl1kOggvTiSl2?=
 =?us-ascii?Q?A8u7EZMYFCajk3sRf1Ugd5oHDczcxsvdvRaCD+wJTND0aHpMtNhrTojK8YAS?=
 =?us-ascii?Q?RMzNtWNXvGZ7lUbqnChyzVs9NjqEpmNxqn+PKaxe4e+Va+yblU+tgN9vqA9b?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?W1kNVxB1Ge6CIE4JstOLMA9tDF87Urokeu0q6MuZ10aSYbA+E/V4idmbLQPM?=
 =?us-ascii?Q?4gmjDxRxephB36oNqAkLue6XG792I9rjC4TdCpzXWlCY1Opdhlsrg5y+RQPU?=
 =?us-ascii?Q?xPvPyoyun8gOpkXcFCNRdJU1n9d91cgxJWdaTrccZO3jiFKpZTeJzoGkghvx?=
 =?us-ascii?Q?qb1v0BilcEBpIigcqFYoTInEcfW5kpMZZKn8T5SCmZyzxajlxgYKgmxb+/dX?=
 =?us-ascii?Q?L3USOz7DCSvv371Di5e3TJHPWHnmOdojxyoflMB0E2rguhQdcH2iBieNej5p?=
 =?us-ascii?Q?NKXGVIPPTQKjqxmBKH8bGTGevnzNGzfduweJhhRlb9F4V2u4fwcsV+F+ET04?=
 =?us-ascii?Q?TqAYH4wtAJPApZfgpXXsQ6ffPXyFKiSXPOvbu9nUM/RjYc/+xrQr352/YG6j?=
 =?us-ascii?Q?rdnfaN9MJxPkowVCzmU7NumJIUVlNKs0v7NHfzKWMwiVnCgAhQN1kBQ5pkDe?=
 =?us-ascii?Q?95Ph+ynH9BncyfZbkgFsBSyFbqwj1Gr5F57UJKy2xsmaOBzxE+N35YgGqAoB?=
 =?us-ascii?Q?j9xljXXlGq9kY0koA5GjuYCoBJCs80uBNeUlhSyB48A0GIDwOaDA+MsSOXtl?=
 =?us-ascii?Q?eIkxuzqydMh8uoc9vaPZgui8RMWbYVqNaV3UurwE+XUdcTJfzrJzj1W+eNOz?=
 =?us-ascii?Q?5Qdac0R1d4Wk2q9tFmEFrZTDUZquEray4qh4aVhrfzDmvCtwqLVDRfbcY9f5?=
 =?us-ascii?Q?Bpf2giyY9Dm1kIRRivq97n+uOwyZVL+r3SrKpeKb8zQIRkVwmLkKcprE1uqY?=
 =?us-ascii?Q?0QDxFyEVf5b9mv+XmD4awBBYVHrAt9uBO4YLpGNZxMkjgz89jhQj1ZVTMP6u?=
 =?us-ascii?Q?qKeKORVTxHn9Mm8NKjtEWLwrNMvpmH4dmUosGMoNYjVWcarNZ8leKHsE512Y?=
 =?us-ascii?Q?3W2vxsgaBiem6KIzQz51rjsLgmLu0vrezrJManXu8crDCGy6YsEY8eM0jJ9Z?=
 =?us-ascii?Q?U9GWd68K86WiVtnNqm0MXqnSboZ5IeG3Qb28rcWLtYPu9xjksCxICy4Sol8k?=
 =?us-ascii?Q?TQGc5MxTxvwUQ8YGxBuXsCMNSwcR1lRlGZ8CGiuYHgMxyyYXba9sP+oN0fKE?=
 =?us-ascii?Q?J6u4lJq+E/McrczLJqoyP3z3IOE6AevPdmgcTs4DQmYMFp55ZjSUjHhiTQhR?=
 =?us-ascii?Q?KKaXE+3CmP/B?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70df22fe-df4f-4df5-4cc6-08dbae594ba4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 21:44:34.8997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XN6uRjvbLQdu0MpwdzbkEv+mTvGqH9hcBvRqHq2nHUbbOhf8/fbiMpBx92+oVlr2NzBfrLqTn0hxQyNZgYcWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050189
X-Proofpoint-ORIG-GUID: UmqdcnAC9xJdyR6zNSnR2WrcSTmwkqL8
X-Proofpoint-GUID: UmqdcnAC9xJdyR6zNSnR2WrcSTmwkqL8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocation of a hugetlb page for the hugetlb pool is done by the routine
alloc_pool_huge_page.  This routine will allocate contiguous pages from
a low level allocator, prep the pages for usage as a hugetlb page and
then add the resulting hugetlb page to the pool.

In the 'prep' stage, optional vmemmap optimization is done.  For
performance reasons we want to perform vmemmap optimization on multiple
hugetlb pages at once.  To do this, restructure the hugetlb pool
allocation code such that vmemmap optimization can be isolated and later
batched.

The code to allocate hugetlb pages from bootmem was also modified to
allow batching.

No functional changes, only code restructure.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 183 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 144 insertions(+), 39 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 278c8ae6a36c..d1950b726346 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1931,16 +1931,21 @@ static void __prep_account_new_huge_page(struct hstate *h, int nid)
 	h->nr_huge_pages_node[nid]++;
 }
 
-static void __prep_new_hugetlb_folio(struct hstate *h, struct folio *folio)
+static void init_new_hugetlb_folio(struct hstate *h, struct folio *folio)
 {
 	folio_set_hugetlb(folio);
-	hugetlb_vmemmap_optimize(h, &folio->page);
 	INIT_LIST_HEAD(&folio->lru);
 	hugetlb_set_folio_subpool(folio, NULL);
 	set_hugetlb_cgroup(folio, NULL);
 	set_hugetlb_cgroup_rsvd(folio, NULL);
 }
 
+static void __prep_new_hugetlb_folio(struct hstate *h, struct folio *folio)
+{
+	init_new_hugetlb_folio(h, folio);
+	hugetlb_vmemmap_optimize(h, &folio->page);
+}
+
 static void prep_new_hugetlb_folio(struct hstate *h, struct folio *folio, int nid)
 {
 	__prep_new_hugetlb_folio(h, folio);
@@ -2151,16 +2156,9 @@ static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
 	return page_folio(page);
 }
 
-/*
- * Common helper to allocate a fresh hugetlb page. All specific allocators
- * should use this function to get new hugetlb pages
- *
- * Note that returned page is 'frozen':  ref count of head page and all tail
- * pages is zero.
- */
-static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
-		gfp_t gfp_mask, int nid, nodemask_t *nmask,
-		nodemask_t *node_alloc_noretry)
+static struct folio *__alloc_fresh_hugetlb_folio(struct hstate *h,
+				gfp_t gfp_mask, int nid, nodemask_t *nmask,
+				nodemask_t *node_alloc_noretry)
 {
 	struct folio *folio;
 	bool retry = false;
@@ -2173,6 +2171,7 @@ static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
 				nid, nmask, node_alloc_noretry);
 	if (!folio)
 		return NULL;
+
 	if (hstate_is_gigantic(h)) {
 		if (!prep_compound_gigantic_folio(folio, huge_page_order(h))) {
 			/*
@@ -2187,32 +2186,84 @@ static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
 			return NULL;
 		}
 	}
-	prep_new_hugetlb_folio(h, folio, folio_nid(folio));
 
 	return folio;
 }
 
+static struct folio *only_alloc_fresh_hugetlb_folio(struct hstate *h,
+		gfp_t gfp_mask, int nid, nodemask_t *nmask,
+		nodemask_t *node_alloc_noretry)
+{
+	struct folio *folio;
+
+	folio = __alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask,
+						node_alloc_noretry);
+	if (folio)
+		init_new_hugetlb_folio(h, folio);
+	return folio;
+}
+
 /*
- * Allocates a fresh page to the hugetlb allocator pool in the node interleaved
- * manner.
+ * Common helper to allocate a fresh hugetlb page. All specific allocators
+ * should use this function to get new hugetlb pages
+ *
+ * Note that returned page is 'frozen':  ref count of head page and all tail
+ * pages is zero.
  */
-static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
-				nodemask_t *node_alloc_noretry)
+static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
+		gfp_t gfp_mask, int nid, nodemask_t *nmask,
+		nodemask_t *node_alloc_noretry)
 {
 	struct folio *folio;
-	int nr_nodes, node;
+
+	folio = __alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask,
+						node_alloc_noretry);
+	if (!folio)
+		return NULL;
+
+	prep_new_hugetlb_folio(h, folio, folio_nid(folio));
+	return folio;
+}
+
+static void prep_and_add_allocated_folios(struct hstate *h,
+					struct list_head *folio_list)
+{
+	struct folio *folio, *tmp_f;
+
+	/*
+	 * Add all new pool pages to free lists in one lock cycle
+	 */
+	spin_lock_irq(&hugetlb_lock);
+	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
+		__prep_account_new_huge_page(h, folio_nid(folio));
+		enqueue_hugetlb_folio(h, folio);
+	}
+	spin_unlock_irq(&hugetlb_lock);
+
+	INIT_LIST_HEAD(folio_list);
+}
+
+/*
+ * Allocates a fresh hugetlb page in a node interleaved manner.  The page
+ * will later be added to the appropriate hugetlb pool.
+ */
+static struct folio *alloc_pool_huge_folio(struct hstate *h,
+					nodemask_t *nodes_allowed,
+					nodemask_t *node_alloc_noretry)
+{
 	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
+	int nr_nodes, node;
 
 	for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
-		folio = alloc_fresh_hugetlb_folio(h, gfp_mask, node,
+		struct folio *folio;
+
+		folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, node,
 					nodes_allowed, node_alloc_noretry);
-		if (folio) {
-			free_huge_folio(folio); /* free it into the hugepage allocator */
-			return 1;
-		}
+		if (folio)
+			return folio;
 	}
 
-	return 0;
+	return NULL;
 }
 
 /*
@@ -3178,19 +3229,29 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
  */
 static void __init gather_bootmem_prealloc(void)
 {
+	LIST_HEAD(folio_list);
 	struct huge_bootmem_page *m;
+	struct hstate *h, *prev_h = NULL;
 
 	list_for_each_entry(m, &huge_boot_pages, list) {
 		struct page *page = virt_to_page(m);
 		struct folio *folio = page_folio(page);
-		struct hstate *h = m->hstate;
+
+		h = m->hstate;
+		/*
+		 * It is possible to gave multiple huge page sizes (hstates)
+		 * in this list.  If so, process each size separately.
+		 */
+		if (h != prev_h && prev_h != NULL)
+			prep_and_add_allocated_folios(prev_h, &folio_list);
+		prev_h = h;
 
 		VM_BUG_ON(!hstate_is_gigantic(h));
 		WARN_ON(folio_ref_count(folio) != 1);
 		if (prep_compound_gigantic_folio(folio, huge_page_order(h))) {
 			WARN_ON(folio_test_reserved(folio));
-			prep_new_hugetlb_folio(h, folio, folio_nid(folio));
-			free_huge_folio(folio); /* add to the hugepage allocator */
+			init_new_hugetlb_folio(h, folio);
+			list_add(&folio->lru, &folio_list);
 		} else {
 			/* VERY unlikely inflated ref count on a tail page */
 			free_gigantic_folio(folio, huge_page_order(h));
@@ -3204,6 +3265,8 @@ static void __init gather_bootmem_prealloc(void)
 		adjust_managed_page_count(page, pages_per_huge_page(h));
 		cond_resched();
 	}
+
+	prep_and_add_allocated_folios(h, &folio_list);
 }
 static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 {
@@ -3236,9 +3299,22 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 	h->max_huge_pages_node[nid] = i;
 }
 
+/*
+ * NOTE: this routine is called in different contexts for gigantic and
+ * non-gigantic pages.
+ * - For gigantic pages, this is called early in the boot process and
+ *   pages are allocated from memblock allocated or something similar.
+ *   Gigantic pages are actually added to pools later with the routine
+ *   gather_bootmem_prealloc.
+ * - For non-gigantic pages, this is called later in the boot process after
+ *   all of mm is up and functional.  Pages are allocated from buddy and
+ *   then added to hugetlb pools.
+ */
 static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 {
 	unsigned long i;
+	struct folio *folio;
+	LIST_HEAD(folio_list);
 	nodemask_t *node_alloc_noretry;
 	bool node_specific_alloc = false;
 
@@ -3280,14 +3356,25 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 
 	for (i = 0; i < h->max_huge_pages; ++i) {
 		if (hstate_is_gigantic(h)) {
+			/*
+			 * gigantic pages not added to list as they are not
+			 * added to pools now.
+			 */
 			if (!alloc_bootmem_huge_page(h, NUMA_NO_NODE))
 				break;
-		} else if (!alloc_pool_huge_page(h,
-					 &node_states[N_MEMORY],
-					 node_alloc_noretry))
-			break;
+		} else {
+			folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY],
+							node_alloc_noretry);
+			if (!folio)
+				break;
+			list_add(&folio->lru, &folio_list);
+		}
 		cond_resched();
 	}
+
+	/* list will be empty if hstate_is_gigantic */
+	prep_and_add_allocated_folios(h, &folio_list);
+
 	if (i < h->max_huge_pages) {
 		char buf[32];
 
@@ -3421,7 +3508,9 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
 static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			      nodemask_t *nodes_allowed)
 {
-	unsigned long min_count, ret;
+	unsigned long min_count;
+	unsigned long allocated;
+	struct folio *folio;
 	LIST_HEAD(page_list);
 	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
 
@@ -3496,7 +3585,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			break;
 	}
 
-	while (count > persistent_huge_pages(h)) {
+	allocated = 0;
+	while (count > (persistent_huge_pages(h) + allocated)) {
 		/*
 		 * If this allocation races such that we no longer need the
 		 * page, free_huge_folio will handle it by freeing the page
@@ -3507,15 +3597,32 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 		/* yield cpu to avoid soft lockup */
 		cond_resched();
 
-		ret = alloc_pool_huge_page(h, nodes_allowed,
+		folio = alloc_pool_huge_folio(h, nodes_allowed,
 						node_alloc_noretry);
-		spin_lock_irq(&hugetlb_lock);
-		if (!ret)
+		if (!folio) {
+			prep_and_add_allocated_folios(h, &page_list);
+			spin_lock_irq(&hugetlb_lock);
 			goto out;
+		}
+
+		list_add(&folio->lru, &page_list);
+		allocated++;
 
 		/* Bail for signals. Probably ctrl-c from user */
-		if (signal_pending(current))
+		if (signal_pending(current)) {
+			prep_and_add_allocated_folios(h, &page_list);
+			spin_lock_irq(&hugetlb_lock);
 			goto out;
+		}
+
+		spin_lock_irq(&hugetlb_lock);
+	}
+
+	/* Add allocated pages to the pool */
+	if (!list_empty(&page_list)) {
+		spin_unlock_irq(&hugetlb_lock);
+		prep_and_add_allocated_folios(h, &page_list);
+		spin_lock_irq(&hugetlb_lock);
 	}
 
 	/*
@@ -3541,8 +3648,6 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 * Collect pages to be removed on list without dropping lock
 	 */
 	while (min_count < persistent_huge_pages(h)) {
-		struct folio *folio;
-
 		folio = remove_pool_hugetlb_folio(h, nodes_allowed, 0);
 		if (!folio)
 			break;
-- 
2.41.0

