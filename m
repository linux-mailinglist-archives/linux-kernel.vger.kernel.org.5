Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C155F7B3A12
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbjI2Sbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbjI2Sbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:31:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5511B0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:31:30 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TIJlB8014029;
        Fri, 29 Sep 2023 18:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=5nil0SxwBCPntCRyXfe7xa/INjPoi9AoymhBJu9NOEU=;
 b=t5jtwpR2VWFCDzEvo22hpoeWcepeS9QqsP2ycSgxAd60vdnTBTMoVTyq+4DBNCN/MquM
 5mB9L3dAR0f1knpVQw2JP4o3rQFg8H+kT1mFfOcOJqPD9I9/KcFqRlKssKexTyDsmPyV
 d+9iqPKEFIFZazKAPskmgI6qRjOZYB7Rkwe+S8VjhYQ/Zor+ncCDjTSjt8eHuAR26e3M
 DGCn6rrx1NBOZsZY0yMMFa200toJqh8ACfLq0KGAT2FThAhs+L5h2szKKVa6ic935Enh
 H+UMgqPXY1lVmQH6+/wE4lQui+Yp0INCzI6d2/Rh2JAo4grG9s/h9xIw9tyC2iQkutkv Kg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pxc7gu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 18:31:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38TI5Sut025499;
        Fri, 29 Sep 2023 18:31:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfhphv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 18:31:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SV7ZxLqPnabUm5DYiIEWx7olipSiq77EWyl/6NKD2r8L0QIJ+apdKtVBpfN1At9fRgadzC4nuUTOGtH6AprDe8okU6RwXK5tt5EeIDBKq3KMLHyrcQv+p2+q5BzZWqJe8/kRf40vMh6qmUSYqRmxtSKRqXBVHnxPSGcjq1ngDoBB8UsNxYe/8ljpMo8JqvNJcLHvGQof0ukbbEgvblJLlrisLfbnx4ZvQoPiEkyHvjNxgJ4WRCHmNq0+1AX+Fzf6Az/aOOFjAdklA5mOlujfTEvQeiGvuNaA3UQ1hUcVp0BQn6GaQC6Oww5M5RngnGEctWOauyRfw5Apzf766kUJXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nil0SxwBCPntCRyXfe7xa/INjPoi9AoymhBJu9NOEU=;
 b=fF7qWDvYn2QToDfHOlkX1iG1V4OveFr94zczp/eeEngqUsyJ6LL8HG2N/1YhRIk19PlCpi/Ofzhn1cAH60jAOCbEF6g3rIiHRe7pmjhpWcsMj6cM8yT7C26VOI4kXIEwhlLE0rRhkhS0Hzu5Jvapf3szI0ty3+a7RA5jLaBQW/y5VTHDzK8uG1F74E4bqplr3hFyVqvGDfV2l4BKMZc0ZoH9dHDfSXk0xQNaiDhtqD36V0Z98PABvRy85RwgQZq+XZh+b7Mx3/GOuVecKWpMl3UshHypi6T27eqj/4Py2zV+uexI60IRIKVpU1WglHBD6hONHPJL91D7Q4pXUGtILA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nil0SxwBCPntCRyXfe7xa/INjPoi9AoymhBJu9NOEU=;
 b=vi/EqlkfkpnJwKsUqSYTumEu4oJYf/nKJ6RmVuDZXdCJt+VJ7u6r46OUnzXlZNUTUP3ww7EiED7NIqVjjpm+JU1KziObzijg14O4jxaSziA/d/lKO9VZT7R0D0XkcQgYqiM7i0Vc8RAYq//qTuSLZSC7BwjCUYxSAy4tTefM+E4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB7482.namprd10.prod.outlook.com (2603:10b6:610:18b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.35; Fri, 29 Sep
 2023 18:30:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 18:30:54 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 3/3] mmap: Add clarifying comment to vma_merge() code
Date:   Fri, 29 Sep 2023 14:30:41 -0400
Message-Id: <20230929183041.2835469-4-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230929183041.2835469-1-Liam.Howlett@oracle.com>
References: <20230929183041.2835469-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::15) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a4db761-7c3a-4a21-a5c8-08dbc11a378d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZN7hMbEK4yJdt5qnh5dUT+t84eR8XaVXIPdKoX6LFHVPK8rWwK/KuDrAdnADIqQ4qZWbS1DKKc+GKL5PhTN0dSVAadtXEaoMRJC3EN33BeB3BXoS0jg5+81IPZmQmTzGAE0lasjABdNWclaU2qTQydDVaQs4EUfpiCR/JYVK7G7OkP3pBuB09VaUuYPLUbw+PYOPsAuvg6s+8/PGnnsujXZY+23Eww+G6jlaAwmQncX6bey2fPJszXnIYGR2jf5Gih+n0oIO9gguuduN5vKst53nne9kkXQZCwOszMi03r/vIsMfG+F/+od2IgSayh0ao94KYbvID+uZAQsie7xyygtv5fmrOG9PmNPAwhx526OBBh/14PkNzYNoiOItj2mF2L2YBMzCAL+njNkt/JVwrF9fzkZKaPOuudSRFAU69SZfwr621KUllc+VhHUVi1DWn8TIHIaouO/3Brdp0suQDmyQj/GveN34T/zzzd5/KyESItUlaRUwkeXj04hQe0QCk1PT0fWIjid+u+x79Pu0IfuhgIR2Q6fd2ox6G5fHV2cObyg3VhgWymbP4bHWp62LQXZ97cjShwsm4PclXUQ51/eexU5MsCrJtLY222LLMuU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(41300700001)(54906003)(316002)(6916009)(66946007)(8676002)(4326008)(8936002)(66476007)(66556008)(5660300002)(6666004)(4744005)(966005)(478600001)(6506007)(26005)(6512007)(1076003)(107886003)(2616005)(38100700002)(86362001)(36756003)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QCMbe91uvGZ6VIcPH/JNVWUmQdpwjLFl57rFdUvU5vVuaUPlm26fuehWM2Ux?=
 =?us-ascii?Q?+M4cQiaecBqBEKHgPd3+8DgZoziTzaEyIB1D1n2FS2GnwjIcpYP/VkRGgv3l?=
 =?us-ascii?Q?dV1E9aiRsL23OU/I+MNMYK4zRoBX425bUgs6Vvtw0wNt1wX3MppY9XSEWYEw?=
 =?us-ascii?Q?IfL38iUh+4Bi5Z7nrUNXgGkMOvCuDz3zoUwP5THAmOFdW6m4q25f8qxL73QU?=
 =?us-ascii?Q?jrUKZQ6hLRSvOn24vX5jEJ6r4s/9XLba2bzEL76oUPUvcv4/nSh5otz412gF?=
 =?us-ascii?Q?W5xSZdHhpJVYs9+vknjfcV1IBbWya5G61Quk/lUGWqSJQ9ha9Wvnk72O99H4?=
 =?us-ascii?Q?hD/ejgtbtXgYZnMGrPH6Zm0Km9PrIDTxQtY5erBRr37oWWDkQ5jb7cczRZAJ?=
 =?us-ascii?Q?o33AsWDFlqWlOJJGM0ApjhjasQTNhz76SrbEW9tOdk6s0N+mSCTdhozPalaZ?=
 =?us-ascii?Q?hW5kjAQXui2vssKakQkEsQ/ztIBxIWZge/W/+8pw4XC8dO8Zv3h2dfRVi31T?=
 =?us-ascii?Q?TCEKFBmI9x+A7wc4W5dL6sDveZv0E4ayU1VrnR8z0gTXYqfs1ca/CFmo9HIa?=
 =?us-ascii?Q?6UOy9zQ244TkLIIXLLT2ox5+3ugUGfaSXd73c5LcLqC3OkIOyJcXKcOI9ER1?=
 =?us-ascii?Q?PW6TTTAqvUBrnS5209G8LGjiv3hy73WA8v1ajxmZcC4vZeTwL/7XpcR7yZY5?=
 =?us-ascii?Q?hZGhQEdWvPcIT3SA/9aYlJ0KNwO4XijCXiHFqiZT20U4aeNc9Eog9rT9/Qc6?=
 =?us-ascii?Q?nzWC6JSUUXsaGIXW6K9hKvZyZKL1VLqnEN238Sk9O1n9Nj0Dbeh6uPJTzDVA?=
 =?us-ascii?Q?EMT9p6UCLwR5US6Q5xe/8iplWvC7XAvV8GnxWbdMQ3MRjQGPvbWo33j4gYnv?=
 =?us-ascii?Q?c6vG3Egta/mM0+KJ/8Vo1lCkNHAk7zpEx4qgYVj9oQDEAs1ypq9VAtfYMIXk?=
 =?us-ascii?Q?+OvmfEM2zcIhfhneYCYcCzULT/ai/AdsKCLI40b/0oB/ORhRhXAEzBAnQpw1?=
 =?us-ascii?Q?cEeSY7I40JZKSaca1ayaaruV7nM9rh/OihtwhDakBfeNn4Y+ykrmqcF5943D?=
 =?us-ascii?Q?n6mvYwfDmZderJFlZ9aOpNqRnnn7qTl+1EO3E3qVfb/uldr9sIWP1u0hmWOp?=
 =?us-ascii?Q?bpKtxVE+3RBBu8k8PcStUEmj1E7wzFIvHNMb6MNUn4kY/V2o5BlOlqrPN0Yy?=
 =?us-ascii?Q?RySppoluDxECLor9Zl+3sxZaFvXskPW999GEzTYls7S9++P8/97pCKdOP+Od?=
 =?us-ascii?Q?8lYG74WnHOgj4YQDoYsHRV97Xft3QTR5F2B3ya8Z+hX6RXnDCrfJrY7TtwAO?=
 =?us-ascii?Q?CKP6xP2cR4R+yF1aalnPgWk9XuggX88mcipqNxSr5dHanqjQJze/Xtj4X+Kp?=
 =?us-ascii?Q?yt+QpY8Y8bJ94ViPuab6Me4+nI4FVan4oxOhsMBtdyI7nUmtVfzQFCBmaaBS?=
 =?us-ascii?Q?MJr0STiWPKzMwzvWFpYm4PMTCD3uGYcnDZ3eHxalRCpL0Qk/W8GXN27Alzbn?=
 =?us-ascii?Q?x3rJ4WZYZJnwNrWDNkae5ru27QDR38sV6qM9OIfZO1L0r0r7Y8DyTujYY1Tp?=
 =?us-ascii?Q?xFsHbhORV6SDJRo/mUOga9SUH//TEvZkqN2HofIw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?WGHm2YKBV1X+loiI8abPoVnlspK9xDfjFBtIZeR+xNkleWmn/UOu8TkO1Xkq?=
 =?us-ascii?Q?pJG/9IRWtLdN+0R/jlKiaYp0NQO18iqb9MsT9w2NzDzMJw5fybAA2nfZg7yO?=
 =?us-ascii?Q?E1MsVASeXlmfoJTcU0P7jbCswMt2qteE6S3R8sJZDJI4A1q3O/JD3qwZltlQ?=
 =?us-ascii?Q?Vtcys8fTWf6d22oAQG28UXODMoseexgD7QoORfUv20CrCzziod8VkIaGaJVq?=
 =?us-ascii?Q?ORGnrywx/d0beIM/RX0MSBWugs4UHLKBF3kPL9PFujV4ZR4S9Xx4ecpkLKgh?=
 =?us-ascii?Q?IYwiQC8x8gQSwTsWhvxY5lXy3yaH22/E8gfUf/pbozkjz/3ZFF/OP9XSuwlG?=
 =?us-ascii?Q?lgl+/MKrinWe7c3tRYvemh/c+ovo0Q5euPnnYYIxKHYTscefmmiRQ9h2gfuI?=
 =?us-ascii?Q?SC+Q56PT/tjdt4hEhhqu5Fkr99p4KjkSU8nHArgnFreCSbYSQXs2wSsaEYDn?=
 =?us-ascii?Q?h0Rs8YcakGacpKlVBEsIqisVRWukVqtoJyeANTKLBxM/6Ki16tMv3AOTQ/oD?=
 =?us-ascii?Q?YkniEc6FClEbYP0ITDERDhAfHvMBVDddGcbfYSfXfgyLhpVtgrCj4NVa/Rbu?=
 =?us-ascii?Q?c2cTakTrPnTa5bLDBrzYQJWWFswdbtunYRYjpjDutNuWcS5Q14Hi1vCprL+p?=
 =?us-ascii?Q?GuKMgBL9LCrJ69muFDnzk4ISBzRBRE587yCMXV0Zw2IYBv0AnoQfB28Hb3RP?=
 =?us-ascii?Q?hgOllFo8CWpvbV6XTnbf4wik+xSHvo0C/HlG+sYHAtp8oelm4E7ArsAeHIUY?=
 =?us-ascii?Q?Au2EN7Bo4OJFojGDXnTbBeUcPLONAfrfWW/Vs4VdFQGC3/xP8b4w46WvcAum?=
 =?us-ascii?Q?Pk0z676eLnM8AZEzqlhrRAQUX0GO87SyBS4bHBioc1a9FQK5y7rl4K7su3OH?=
 =?us-ascii?Q?hJ9pnnichkGYHSFr9k/OwSgo6VFiNXwreTHAhccYaJNw5A00wkV/iD5t02Zp?=
 =?us-ascii?Q?3Iw2UgAjqb6JDtRuu/SyoA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4db761-7c3a-4a21-a5c8-08dbc11a378d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 18:30:54.9544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujGEhjsRzfrA3VhUzmqXLT9VdcFe3zQqMohGuxEet5ovlsW3+FY8hFHPLaRlydMHxpxE1XU1tpYex/lDCsJMFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7482
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_16,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290160
X-Proofpoint-GUID: T2udX_rXcYI9ZNWQXCW4brP5RmhRsUfJ
X-Proofpoint-ORIG-GUID: T2udX_rXcYI9ZNWQXCW4brP5RmhRsUfJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When tracing through the code in vma_merge(), it was not completely
clear why the error return to a dup_anon_vma() call would not overwrite
a previous attempt to the same function.  This commit adds a comment
specifying why it is safe.

Suggested-by: Jann Horn <jannh@google.com>
Link: https://lore.kernel.org/linux-mm/CAG48ez3iDwFPR=Ed1BfrNuyUJPMK_=StjxhUsCkL6po1s7bONg@mail.gmail.com/
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index f9f0a5fe4db4..9967acbd070f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -943,6 +943,11 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			vma_start_write(curr);
 			remove = curr;
 			remove2 = next;
+			/*
+			 * Note that the dup_anon_vma below cannot overwrite err
+			 * since the first caller would do nothing unless next
+			 * has an anon_vma.
+			 */
 			if (!next->anon_vma)
 				err = dup_anon_vma(prev, curr, &anon_dup);
 		}
-- 
2.40.1

