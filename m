Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D337705A1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjHDQIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjHDQIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:08:17 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E27B2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:08:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Str8ZEhnpo4JEuyTtCj20V29U8IFfr7PHZCaohF0psajwHR5eKhe/4olY3golYk7sQddpSuZoEBuBfq0UNOIwo87r84pSAx9Y3iD8YS/+sWAb0nMZkSYUdwdbbb3doWpYAgQ7tCPyJ7h5SpQpNMFrrnCUea9r2EuGweIBwp6n6C0zZqfESWQL2EJ3LRKo4pwcJP7pQ/os1JMnJcFDG2cc3VubVg2soBidUTyEc4G7MOZKHnw20+ZL5vcqUkMRYBkR5oUN6e4dttq8bUgVE6cqhf3KonK5MsHp9hhOEPJLylpBn3LpLvX6zZSxSlYK83JnlhOSoom8hOEMv/xt7L55w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHm0baJ/TLfvAsHOzpgcV+/4QXKAB7OgLfwdW3WHLBU=;
 b=Cjt3Hc6BrhCmkcIX6qSluhmsPDe76IQPfBGeju7A48+Okgl0rvLJtx26WEQvwByRDc0Mzunb3BY7DvSfSjC9dojf7utjVlDmlcrm5tInePzSt/msJDNdtqbUG75pSAgCNVw+uNGhYJNK0NX9+s6L34Bwga5Sh21leAiYYtu+bdZYOd9/W4Fvz/AbqVwCAuFwkQf7mOKPbuzeAnQU4s1eH8UAXynXGFZpz8SEbtzmgSGNzNzzWgDTw1jfA5XTXTS7NetnNJt+0gFhrACjd36qQdYgmLi9m01dsLvvg/ri+j48V/P2JMuIH8wWzyhdVohnLKamGA5ONM/7aj5GA3cohg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHm0baJ/TLfvAsHOzpgcV+/4QXKAB7OgLfwdW3WHLBU=;
 b=EDJoiCQjBULDzfIx4jswfLU4hq2J8aqA6wWPTOWLBpA5kjPkL4OO3bp9RDl3XTncYMuqYu9XWt9MCRCUe0Kw9BZBcXdVt6b/e2zGi6mJvREPDEDBAB7nanxys2Qbqz8a4IfQYm6UMnloUr+XIpSZ6z9ak9j2PcnOB9DGOX7Ta5cI4pfDk5gQiIUKnVEdJLw6CW2QkoWFnRuLe+yEHlfzVs6N31vP4oO3viyfg78mbmWF1WDQWu+GmDin0SKTHyb2P7hBY254ArUnnShy55dwmAAL0AVqaLdVPje37e4qihnFbc0Fs8rNWl2JgHxfh5I5wU7XWTHOlMdTmj5XNMU9ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA1PR12MB6114.namprd12.prod.outlook.com (2603:10b6:208:3ea::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.21; Fri, 4 Aug 2023 16:08:10 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e%4]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 16:08:10 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Byungchul Park <byungchul@sk.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel_team@skhynix.com, akpm@linux-foundation.org,
        ying.huang@intel.com, namit@vmware.com, xhao@linux.alibaba.com,
        mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
        david@redhat.com
Subject: Re: [RFC 2/2] mm: Defer TLB flush by keeping both src and dst folios
 at migration
Date:   Fri, 04 Aug 2023 12:08:07 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <A59E5AD9-11DA-435A-AD17-6F735F0C0840@nvidia.com>
In-Reply-To: <20230804061850.21498-3-byungchul@sk.com>
References: <20230804061850.21498-1-byungchul@sk.com>
 <20230804061850.21498-3-byungchul@sk.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_D6BC3C60-9C79-47F9-8A8F-42BDA782978D_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR0102CA0058.prod.exchangelabs.com
 (2603:10b6:208:25::35) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|IA1PR12MB6114:EE_
X-MS-Office365-Filtering-Correlation-Id: 9302e390-e744-4b6f-36ad-08db9504ff3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KY5M0FOR4ca8S4F6tBs1NNmN2ykZpF1gsFqUldT7O/6f9BYo+HBMoWW9F3HbmdoyyvfQJfevlUVe8iIiERiCcSyj7kV+kiDGV/IEJoFDMvcU6g3shyez0CB5p1WNhbomODQBZ1ehEQPnbPaY9m9ivsfZ0beeVITYUuRVQ3pkkOSrgpNRsmLnDP1dM6wrrJnOccE7pMMGwiqkm70mKa7qoq1EJzcz8sys2BY+IpUEZPGnjR16/xBK1dhWP1yFb9p8bVXjcGhKn3xgXMWwsRIfR34zJ9p7y+BJsM89jKsipj1MsvGdIcgukGmsdiWPV8xgQ2vNBzjd4v+orkB/qZUuMLhyhCTKRSvGvKqRXsGuuA9Dknf/9IW5/sPCQT7rQP8jOHPS5eGDMff0W7jqM8/RJ3T0v1RrnLBb1mM/bqQv825ta6uCvKZHEzz/Uny5PAV+UxiCuN6xcSu/R/iKRvFxzwAa5CY2p1T+hvDTz8MIaQK+S71XxLVznyg9GeYbFf+nKfXqfa7S6Fya6b9hZeki54wdkS43iGCFVTYTPxYZMhj3kooHiffTmNdYc6w3LUthXjpWEVLHFdjOoYXSj6Ne6Gybwn+q4TURG5Ez2ZDR9yKrpihy3LK/djBzdVj1F2H+4haIvT4k5xoqE2TPCLztOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(451199021)(1800799003)(186006)(5660300002)(235185007)(7416002)(4326008)(6916009)(66946007)(2906002)(66476007)(66556008)(316002)(8676002)(8936002)(41300700001)(478600001)(86362001)(6666004)(6486002)(6512007)(38100700002)(33656002)(6506007)(26005)(2616005)(36756003)(53546011)(83380400001)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KLOseeSlV6s7XcZ/g9xfukOrWqZngJXwni066V7QCzn9blhCmZ1WWpCbsxXV?=
 =?us-ascii?Q?wXmReqp+A4hG1fzZR5HCAvQt3nZFFuRGjHKql4HZNJKEdNELCQXpyoshy856?=
 =?us-ascii?Q?1m/jjiy9nB/z6gUlFCm8rlJXkrwvmTns+p5xKRZiwEhTPEIxQEUiCekG+u5d?=
 =?us-ascii?Q?ze0HHjJJrFZZ0wNqtdbCy3wKjCpwL9vdcfmhJYXC2cy2NKE4kAVJmB2PybFx?=
 =?us-ascii?Q?GNrXIhEPS0AE0JZRzBzwK02o0prxKzUCDScOJd+MRpgMzxakSXdHw9DZV6uY?=
 =?us-ascii?Q?VK2kmF+OJOwVBNgMA0KEZkdTEBJQ/BkzShYb55fro27coLlWqtFVVJ3BqQcU?=
 =?us-ascii?Q?hosRh9qC3fcrrcwVvxBCyFwGZ0ooCICvTnJCQvRamRd+ytD7iCgGm9Ig5oIc?=
 =?us-ascii?Q?ulJ+TnWG6ASm3G5iergmlk0yJ48pAJGEoTUSizevVdpx7y4c55TcQNEolqQQ?=
 =?us-ascii?Q?ihtTxlFfpG33lsP+pNyi/c5odGahI5QQI8mnd7hip0dz88J/7TdoUKIphK4K?=
 =?us-ascii?Q?uOIbwZSZcHc9pCf3NSPnh1iCEshG4Bv3oCCk5gSRuW5irU975Lr87zRTqs1H?=
 =?us-ascii?Q?mfGbOaFyO8OvtI4B8gJWszqqspanLQLFnWzlp8t0czq8WPL/skTXnyh6ZNd7?=
 =?us-ascii?Q?FF9JXxoW1li0HuRQg++4WzkbHiimTfszic2akA2S9hE0P5bmbXCMDTzVkMLB?=
 =?us-ascii?Q?tHzc0xiOw9lNt082XocvasBvaDXOG/FVJ9BpCWbjbwG8PLlEknlDRzgcz+hf?=
 =?us-ascii?Q?OQjB9Iq0A+1PHyMaKUtcxloUocQqvieQEe/OtQ3ukEqhasoBI4YqK+TEG8fH?=
 =?us-ascii?Q?PGMsD9+QFqZHytgolq9iASfnjAAr/PeDLLAr34HRnfpcd3Xkp6dGM3N3r0sg?=
 =?us-ascii?Q?m12x1VufkwTrRmQlcMfG36QlmowcRZ7WhN2+6T0SO6qd+dPqEK5OBnFkWljF?=
 =?us-ascii?Q?p1F2+8w1qMj5kk1j0Z0ZN/FO+/GN/WX5I4LvjFdRnS7ev/LVzm9fQhCSMOSo?=
 =?us-ascii?Q?BNJfyshS/qSddoZwWb/+WobITwYHPVitBvJUj0uTtY7p1VULvWhqze45Z74e?=
 =?us-ascii?Q?Yj20H2bHiDF0tVlmAx8BMH3E4UqV9Ju9JCtMOdQ7zdHKJh0mhj5GPVdGwA97?=
 =?us-ascii?Q?xRo7Y2nQO0uxbkDJ50ihR1+XrMXuHGRrzcJTCVST+zlsf+x8VGn38lKCW7pa?=
 =?us-ascii?Q?DKYwmeEkEopjhd4h7Z8lEzS4Xv60+PneLubE+XdkjxnandVpIugEUMmOQDuO?=
 =?us-ascii?Q?MR42JV/PiWo9TVcs6crBWOFsFhQx/cV2FeQfVIkqB7u4S5gQUNdINN9ZYgqy?=
 =?us-ascii?Q?6rJReD6bEu3kpSglPNw2pccMzqdJT133lUkbC1SeWJRBAu+7tg9J3ZosHpwK?=
 =?us-ascii?Q?yU3AKiYaCOEQjYoFeDIVUQEVAOHD195op40sm1KM4DHkrfFxkRYCumsERaE1?=
 =?us-ascii?Q?0+damz9MeH9ifTTF3Ke06MOnxg98aMm0YKjTezkXKnTCLkt1hPHhSfCD+fZH?=
 =?us-ascii?Q?tzAGq/4kwjSqIB0FbgvUFvHLptZ5dgzbhf6sfB1ike9VV+tj/uMHSeaqbtut?=
 =?us-ascii?Q?bsgTdpJMnCQqhDI4h9A=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9302e390-e744-4b6f-36ad-08db9504ff3e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 16:08:10.0807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVfH0A4J7zmmZL6yw1aZwC3D370Wlo1614kQ4tqVbhCp+4/OVo+WiqbEj5m074yw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6114
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_D6BC3C60-9C79-47F9-8A8F-42BDA782978D_=
Content-Type: text/plain

On 4 Aug 2023, at 2:18, Byungchul Park wrote:

> Implementation of CONFIG_MIGRC that stands for 'Migration Read Copy'.
>
> We always face the migration overhead at either promotion or demotion,
> while working with tiered memory e.g. CXL memory and found out TLB
> shootdown is a quite big one that is needed to get rid of if possible.
>
> Fortunately, TLB flush can be defered or even skipped if both source and
> destination of folios during migration are kept until all TLB flushes
> required will have been done, of course, only if the target PTE entries
> have read only permission, more precisely speaking, don't have write
> permission. Otherwise, no doubt the folio might get messed up.

So this would only reduce or eliminate TLB flushes? The same goal should
be achievable with batched TLB flush, right? You probably can group
to-be-migrated pages into a read-only group and a writable group and
migrate the read-only group first then the writable group. It would
reduce or eliminate the TLB flushes for the read-only group of pages, right?

>
> To achieve that:
>
>    1. For the folios that have only non-writable TLB entries, prevent
>       TLB flush by keeping both source and destination of folios during
>       migration, which will be handled later at a better time.

In this case, the page table points to the destination folio, but TLB
would cache the old translation pointing to the source folio. I wonder
if there would be any correctness issue.

>
>    2. When any non-writable TLB entry changes to writable e.g. through
>       fault handler, give up CONFIG_MIGRC mechanism so as to perform
>       TLB flush required right away.
>
>    3. TLB flushes can be skipped if all TLB flushes required to free the
>       duplicated folios have been done by any reason, which doesn't have
>       to be done from migrations.
>
>    4. Adjust watermark check routine, __zone_watermark_ok(), with the
>       number of duplicated folios because those folios can be freed
>       and obtained right away through appropreate TLB flushes.
>
>    5. Perform TLB flushes and free the duplicated folios pending the
>       flushes if page allocation routine is in trouble due to memory
>       pressure, even more aggresively for high order allocation.
>
> The measurement result:
>
>    Architecture - x86_64
>    QEMU - kvm enabled, host cpu, 2nodes((4cpus, 2GB)+(cpuless, 6GB))
>    Linux Kernel - v6.4, numa balancing tiering on, demotion enabled
>    Benchmark - XSBench with no parameter changed
>
>    run 'perf stat' using events:
>    (FYI, process wide result ~= system wide result(-a option))
>       1) itlb.itlb_flush
>       2) tlb_flush.dtlb_thread
>       3) tlb_flush.stlb_any
>
>    run 'cat /proc/vmstat' and pick up:
>       1) pgdemote_kswapd
>       2) numa_pages_migrated
>       3) pgmigrate_success
>       4) nr_tlb_remote_flush
>       5) nr_tlb_remote_flush_received
>       6) nr_tlb_local_flush_all
>       7) nr_tlb_local_flush_one
>
>    BEFORE - mainline v6.4
>    ==========================================
>
>    $ perf stat -e itlb.itlb_flush,tlb_flush.dtlb_thread,tlb_flush.stlb_any ./XSBench
>
>    Performance counter stats for './XSBench':
>
>       426856       itlb.itlb_flush
>       6900414      tlb_flush.dtlb_thread
>       7303137      tlb_flush.stlb_any
>
>    33.500486566 seconds time elapsed
>    92.852128000 seconds user
>    10.526718000 seconds sys
>
>    $ cat /proc/vmstat
>
>    ...
>    pgdemote_kswapd 1052596
>    numa_pages_migrated 1052359
>    pgmigrate_success 2161846
>    nr_tlb_remote_flush 72370
>    nr_tlb_remote_flush_received 213711
>    nr_tlb_local_flush_all 3385
>    nr_tlb_local_flush_one 198679
>    ...
>
>    AFTER - mainline v6.4 + CONFIG_MIGRC
>    ==========================================
>
>    $ perf stat -e itlb.itlb_flush,tlb_flush.dtlb_thread,tlb_flush.stlb_any ./XSBench
>
>    Performance counter stats for './XSBench':
>
>       179537       itlb.itlb_flush
>       6131135      tlb_flush.dtlb_thread
>       6920979      tlb_flush.stlb_any
>
>    30.396700625 seconds time elapsed
>    80.331252000 seconds user
>    10.303761000 seconds sys
>
>    $ cat /proc/vmstat
>
>    ...
>    pgdemote_kswapd 1044602
>    numa_pages_migrated 1044202
>    pgmigrate_success 2157808
>    nr_tlb_remote_flush 30453
>    nr_tlb_remote_flush_received 88840
>    nr_tlb_local_flush_all 3039
>    nr_tlb_local_flush_one 198875
>    ...
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---

--
Best Regards,
Yan, Zi

--=_MailMate_D6BC3C60-9C79-47F9-8A8F-42BDA782978D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmTNImcPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUcjIQAKpU7fLl1ZQpmlL/un6vk09pFpAn8T2qeKLv
laFQLp6s/g93j5qYLFmS+XU/++wVEx9ISm5UnU5rzAW9/pRe6wonW8NMpHDcjfXi
VU1a+5xP5GbUy5JeztwzBIFT3w5LQzl1BXz7IVtEWleuwtodBMaS4AwH7JwafGgU
mJdnjidZf4gguy3ulOkZg6P9YjIfUr4ncQMX0ual8+LUZrPi7caDiZfTvhzvco19
E7TO5azhXJrYwztx+4jjd+OrMzKTJHQIxiSTzkdaZ9iJAi4MKZUFycaLCEZ95AYk
OnpMQLS0T2g1SwfBVe3x79E1sZGxAcYnxjiiFJLTk1udZ4vLqFAYlEmDYPF6cvbv
gG0dPGfOKU8lVhPZin8tw6biN7QOrQB0HgbF//W9AoGiKPV9rcp/LytVHG2p7NgT
0LHiqitgQwitX3VhLNTBuVJ8QZk2y4MKpzuUaW/2SxFRhiFF+2+22tiIGPuiucN6
ofyWdbdY2ozh8yWxJLHk68XN+7il3L6Brg8vVcuGCAZuJtECig6md1+7zN48JEhg
7Qt64+F5gV0uKKl0mWOlqr9ScrEbZf2XuzAXBT394FYSPudllrMOIU7hxe7Z+Ap5
b6TrZsebGH5dA1QFpzCE+W8zSNFretGiu6nSqbqKylEz61QEeKcqZt3R/29YpzDG
W6KF1UlH
=NtjJ
-----END PGP SIGNATURE-----

--=_MailMate_D6BC3C60-9C79-47F9-8A8F-42BDA782978D_=--
