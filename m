Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114077F4962
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344119AbjKVOwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344255AbjKVOv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:51:57 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9055F1B8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:51:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceoLE+r2xhpdXYQ2cE3ayxaK1BW2EWirUUffiKEfOoyOVQ24PFKVJ0iHV/gfemHAlaLxLp4akszDPkdqxqKkXR/an7rH883y5qe/md6cfmsQ03apx5WoF7t4YkKT9ziQLQ9xL/X69hQoY3GafObc0GnM+z4um8VhJzJ0IPpxbhZKOExix6m+my6PZupn5DmODWWJJ1I97EX4nrvD0L8vPHfpWbFsEyxZR0iK4oODLkkymdVZF461UG1RDn5y2Lt8OYrYEI6qEw4SN6GnDmKOgTWrr/H2L4wuCk9DOKOCth8cy41getmnIug52KhjC8q6qWZlhaxIhw5u4YFTDvjhTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s25QxNYVtawiJ3VaNYfhl/cCyvp1Fu1181QznpXnxak=;
 b=EOo0huaa1JsRXxYM9W3q8I3FqMzUQQ8fX/nLhBoTrFRzyJWr6A+nL8hrSgZ0+nHnH94FKxuEgoJbdBnBd1n3lbaGzbHCA2d8/Hua0/jAB7iQ3Or3F2DHVrABY796aiAfpIRfJMmNPYHK9WdUSQGSp29yQscLgf9JBVT4EuwOYzqqjPMi7poCKeTXvFwfjj3yyVqG6y8jQRmBBzF+DgZ38ABZm6iDqstViOKG0X1AVeKBwu1yyMhd+kI7e23bKY3QeWRFPGfwiyP3j5V5S0ko/qsH+lXoOVbUyN6mJrMQl4y5PD2XDLbI91p2RanjQideJnaNy1vJZkzkND7DnRg6IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s25QxNYVtawiJ3VaNYfhl/cCyvp1Fu1181QznpXnxak=;
 b=J0clCN2n+3ZH6dibxy+3kka1HoqeIK/fuh29OEyNnRV71uQJRqKc36b7pn0bWa0b13ZFRUa++5KsS0CLEVJydp/sIuOioMr6rg9aoEHO4/EZCiIvgN/W5O3JYAFNvO8oZeGqrWX2kMwxRKVnxDGgyeRc1pIfnGAEV4O9+Ltb/4DN80CIaNKI+3fkr3C0ArgFpnTPBjFmE/rl3k/epnRzHhbs6otM6PCObnjWz8VsVlZvIqDQFOkCNdnJVY4FXezHXZhn0hxaEI1mTlbsqkX7zLDgQqsObYhclFqQQbCRByTJYJ0xT/8x+AGOQMC2Yrs6SgE+B+nJNq5gk+wLBx9Oag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6174.namprd12.prod.outlook.com (2603:10b6:208:3c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 14:51:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7002.027; Wed, 22 Nov 2023
 14:51:47 +0000
Date:   Wed, 22 Nov 2023 10:51:46 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        James Houghton <jthoughton@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RFC 00/12] mm/gup: Unify hugetlb, part 2
Message-ID: <20231122145146.GN6083@nvidia.com>
References: <20231116012908.392077-1-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116012908.392077-1-peterx@redhat.com>
X-ClientProxiedBy: SN1PR12CA0108.namprd12.prod.outlook.com
 (2603:10b6:802:21::43) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6174:EE_
X-MS-Office365-Filtering-Correlation-Id: 8738efca-cc10-4878-6f63-08dbeb6a8d88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: prVvL3PgEPXFTW76Uhq4nIsjrWM6g7T3JPYi1b0WE9IEEUfHEvXEJBE/3TvC2pDljHRkiKlrUvzj/QyexveWOraWMRuGfte4Dn6LJrBxDPGo7leecEBxatVATclUinJ6I+pRQhgFauB3r6KK8/bzHclXTehBoFC22A3QseX+FJZs82GUHcOpxm/1pzUU1/fwXEwKRFJ/ckJCvRMCJgZP/094F3PUUsOCYxXvtYzn6HxQmXkfpIDBdbJm2ikazpuABkOo0DcMV3k/Zxavs0mIoXn9vcvyXTnjDxWE5fHoatTL4WzsFgku06wqJhsbxbh/a8BIGV10roQNRdlOUDX5OhonrIhxmE/ALdBWY6kJuolfX/FyPYFoExr0JeNCAK6esfHdCsWLiSerGxpVfhLgSkWf8650dnAUiqzsVXH7gWMMjaNrcdECieS9A29BgkT4GwlhWOdxNw4QOBVAFWCVQfM8nSWvIMPHYto2NjT2TknzVZH1GaVoT4NvQa5DhVgg0GmhxDKoxdcADKw049WHOe5ag3LMy9rHTi46RyyGHRBgGk9P7DOcdPuMz52TBLppMcq9WU3jJ5rZKvWlQ7j3orEEkX8+LCnhv23/Omc5+1M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(366004)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(7416002)(5660300002)(2906002)(8936002)(4326008)(316002)(41300700001)(66946007)(66476007)(8676002)(66556008)(54906003)(966005)(6486002)(6506007)(478600001)(26005)(2616005)(1076003)(6512007)(6916009)(83380400001)(38100700002)(86362001)(36756003)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SqHUqgTpfVCfwLKinqDEw0rzGUk+VT6TkklKF/YHSeUasqIJEHTHtI38o6FH?=
 =?us-ascii?Q?qEt1FuNsFS9lNmVdMhFqdJJSvSH1Q6JpgamLc1gVDfFveoyCl92gL0QQh5wL?=
 =?us-ascii?Q?a+RnGKW3cCHTHYOJ3+B4LrpLVepTdIcsQv6T2hdXST82mj7eveffTZiAjrOL?=
 =?us-ascii?Q?uUXvTKS7hRpSTGc6B+5eBJsaRrnVmb6tKktKZSQE8qQw+jBxmoyFkGNon2Xk?=
 =?us-ascii?Q?EuCKEv7QQ7+Lu877NY3H9sywsjJQ9+M76Ih9mBU6RcXhZA8HfxJNY2W2cmJU?=
 =?us-ascii?Q?znTCYmM3iQJroSGI3ju8XO7hFN8lSJ3QD/p7jNr9KgAqGk73cEuDuKYZvibG?=
 =?us-ascii?Q?gEWptzXQKTUq95/RonptYhLJCMjmso0f0exkxdmzEEN0b1hr+Fpj3L02fi3i?=
 =?us-ascii?Q?e8Z3YR++ojHXh5YYwa4QQ+9/jYXHfkVawM59U8jp/R/ayPG9wvh0GfKtswe5?=
 =?us-ascii?Q?u24EMTxPRlG59gJzuCwwJCJN91weoaIFhklpyT5BVSnwguetnroGm6Qq2Mey?=
 =?us-ascii?Q?s+J4fSdajytzxvFG/tAXBMVNcP+W3+3iyaWg5NIZKuHR2aias1oWHH2+9gMe?=
 =?us-ascii?Q?scfI60R7vGHssQbYAX/sgFUa8l/NQqsS16JUTn7z+yH+K4gnhRTiwLT40XLx?=
 =?us-ascii?Q?wJIAEsNWJk6hYLdKeEIw2y4ETPfjh9PKS0mzWZKEM+1litY8yF2T9mu9cndl?=
 =?us-ascii?Q?UWbGjA7OnN8ajw5HqZ0+f7MyqzUamzl/+lZSijKW2GNgNjdoBQPq5tcN8Mti?=
 =?us-ascii?Q?NZZ8d9ob+hhPmOH5EFsLV0uxR/nnGpK996O3bFmt8gLT3b6+H7hRsnJTSbdn?=
 =?us-ascii?Q?FQDfd6EXK5VMq32lB9ExXMXL8GrH4d808CEl04TA1o9fD6EYa5UTomyjcmoZ?=
 =?us-ascii?Q?HZqkH1JfxVGdKLNlwXFwlfBGzVvG83MK/uDcepF7sA5CzfXSS05653ffsNIy?=
 =?us-ascii?Q?LY5hRScurxD4nyjImc7RvZ0YpcSxQ8s/DboSdXMgN3GLO/hjms6AZLMVIXYh?=
 =?us-ascii?Q?uVGMI4scIMDlLLNKA/hn6JJJw8pY1INDvpxCkZY3LpOH5l1RNT4sPo/th7wF?=
 =?us-ascii?Q?jwA5JvcH1MrIKQ/5g/SsaQf/YXPql20ohcV+1OXUY2VO4mSM+JP+pvclWf85?=
 =?us-ascii?Q?jFzUxxkXogGSt1Uc/P8OW37hX4J5zgj3L2fsiqvrt0KqfBEGQtNk81hCnvxI?=
 =?us-ascii?Q?4Uctw+vtqedgDuv4d2Ua9JLI4frLvPVMcyouMNxiByw/MgGIgfMQcxtPBmC1?=
 =?us-ascii?Q?/LLXDYdocYh7NUIkupHWSvT7ACmcmr3mo07kqH3rUzMobP7dBSZj9WMh+/gA?=
 =?us-ascii?Q?+mWHu0TF1yMQi+g4WGtUQnPvpl8pCJBQiv/K0vLMw03E4AGUSoJ0wVThu+lf?=
 =?us-ascii?Q?rA+u/DyNWdeGVCknODRO6yHt2dztD1qZ1H59Fq/Kpv9i5jr/XMLSSBp1c55c?=
 =?us-ascii?Q?FL7js25ylaVYUXL1gC8t1FbfPasRSXEv+ysa6IJNNqVOOgqoiMsVXqqbEc0Z?=
 =?us-ascii?Q?vSGkeDYWdUhmEVd/AfOXSPkrarHV9rWINzZmOjKorJ7Adg3WSeQEGISqTobx?=
 =?us-ascii?Q?q21y33x3x5n3NiM0pKzpVmVgMT9azDzfgoU4Qrkv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8738efca-cc10-4878-6f63-08dbeb6a8d88
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 14:51:47.8098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPbNH4co4CDqJojZtrmuOeuprJQNv9KR6Mir3f/VCfmVJ6t/IqhH9UchhPNhnGnc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6174
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 08:28:56PM -0500, Peter Xu wrote:
> This patchset is in RFC stage. It's mostly because it is only yet tested on
> x86_64 in a VM.  Not even compile tested on PPC or any other archs, it
> means at least the hugepd patch (patch 11) is mostly untested, or even not
> compile tested.  Before doing that, I'd like to collect any information
> from high level.
> 
> If anyone would like to provide any testing either over hugepd or CONT_PMD
> / CONT_PTE on ARM (before I reach there..), or RISCV over 64K Svnapot,
> that'll be very much appreciated.  I'm copying PPC, ARM, RISCV list for
> that.  It can be as simple as "./run_vmtests.sh -t gup_test -a" for now,
> making sure hugetlb pages can be allocated along the way; the non-hugetlb
> gup tests will guaranteed to be covered more or less, I suppose.
> 
> In summary, this is a continuous work for previous series:
> 
> https://lore.kernel.org/all/20230628215310.73782-1-peterx@redhat.com
> 
> And this more or less is my current take to move one more small step
> towards merging hugetlb code into generic mm code, as much as we can.
> 
> That part-1 series dropped follow_hugetlb_page().  The plan of this one is
> to further drops hugetlb_follow_page_mask().  The hugetlb GUP will use the
> same code path for generic mm after whole set applied.
> 
> It means the generic code will need to at least understand hugepd, and
> that's already done like so in fast-gup.  Fortunately it seems that's the
> only major thing I need to teach GUP to share the common path for now
> besides normal huge PxD entries.  Non-gup can be more challenging, but
> that's a question for later.

This is great, I looked through quickly and didn't have any profound remarks

Thanks,
Jason
