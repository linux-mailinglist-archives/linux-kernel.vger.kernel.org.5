Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCE97A9652
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjIURCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjIURCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:02:05 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20621.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::621])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225A41BEE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:01:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sr1chrbSX5xXCVs8QGN7EZkz5BgXEheTlZOJCs7iA8E22bB+X2rHkFC9kq4nh4zHyP9ICwSOGO9Iit7acFeQkcDxquNX5NkqPN2w6Mg7kqQbY/wjavNeVh+8IQNI0H+Veo4C+L2vor5J5Jh51ALGinXo14+GOMvF7Q2cGRP8SZtvurdQEswFEen+S0hYyoDVhbmzGToR8KWADzTI6lnz/AuFXjUbqBQgYOqM8f/dcho/Tkr8nSCIVVJnVooyN9WwowPIjy5V3THwxhvxfXfyORU4miLmgxwxOyFPYbJWQjgHOctR194hpuhpsOGddmNE0HqHZB8Vbo9iWVOIO5sk5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAxdiemL9ALE2T5cw2zVd2S9bFZ5b+bFw0Ye6sNp4ek=;
 b=SqvoqFRHKQCTakA+FnYmsX0ZGYhvw+tT0uLOXZRHQFqjWeqjeEHodGJt7lGtVlwie3HrRssp8c/0FZU5A1aLtd348psKeu+S5ZSb+TqO4k7TmLf8L54rxRqt+ug2qZZpyjXMh3RxJ8QrpPDh2HYDilMo/NTCSs0BpIs0dYFibeVu5P/5lFpScNpLX0PzPPFdbZRuLg7PhqTvTC85ktTiyGwM33UQPkjG5JO622b11g/5RNshsCmOc6JkyHD4scokxN49ES2/l4pRlMRYRHMqVTScjyyrl7XCU4H8QlgQI9+JxOtoxAz4lPCXx8PaH8gGgb0uvGAXjmbqsqfc8Ey2dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAxdiemL9ALE2T5cw2zVd2S9bFZ5b+bFw0Ye6sNp4ek=;
 b=J44Flfz2v91MciXVgMSgZjuvwAsaVAWkj9M8cObx90WCp+qPQos4zJmcRmWERfHuWzyL7ny1ObBSskj+p5tNK52jkxuGOGjBliSyNmcAJymN3Pwyb5cB0YxdG0kbGJqQ35x2YVKo8EMCRbBcMmjS9Yo/XL2n4E7ApW16d+RxvbbwXqYJ7L456V0o4QqOAcLcYcJpDp61jY/Ka4aSxHXGV8PU1b73GSJ3Yav/aC4/5MlL3cq9WlTiggwGcRuU9O1OxuRm8AJTJ8xiizdsoOyuyz4j5vEAfsvLaj6dyrMV/ddPj5yCT+abQCCbkTBLc7PM1g4QD5h5B1amWMXt5BrRDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.28; Thu, 21 Sep 2023 14:47:26 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 14:47:26 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/6] mm: page_alloc: freelist migratetype hygiene
Date:   Thu, 21 Sep 2023 10:47:23 -0400
X-Mailer: MailMate (1.14r5984)
Message-ID: <4466F447-43D3-43CD-8930-FBE9A49028BA@nvidia.com>
In-Reply-To: <505e7f55-f63a-b33d-aa10-44de16d2d3cc@redhat.com>
References: <a88b7339-beab-37c6-7d32-0292b325916d@suse.cz>
 <20230918145204.GB16104@cmpxchg.org> <20230918174037.GA112714@monkey>
 <20230919064914.GA124289@cmpxchg.org> <20230919184731.GC112714@monkey>
 <C416A861-44D3-46E7-B756-63DA3731FC1E@nvidia.com>
 <20230920003239.GD112714@monkey>
 <149ACAE8-D3E4-4009-828A-D3AC881FFB9C@nvidia.com>
 <bc4bd049-1e29-0f23-cca6-493abb5e774f@suse.cz>
 <20230920134811.GB124289@cmpxchg.org> <20230920160400.GC124289@cmpxchg.org>
 <762CA634-053A-41DD-8ED7-895374640858@nvidia.com>
 <D4F59724-61EB-4DA5-94DF-59E79F0F1FB3@nvidia.com>
 <505e7f55-f63a-b33d-aa10-44de16d2d3cc@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_7E985CA9-4D60-4CCD-A67E-47FBE228E5CB_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL6PEPF00013E04.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:19) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DS7PR12MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: dcaa22fe-27de-40ca-c406-08dbbab1ac19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vh7Go5nQWYk2ZXcZ9xATgRW41Vavr4xgDVJ63HJKhI7kyo//gigxuMLROnq++w+y2ZjLOl2M/P75+OsAW1pNdj4mfxVRqp2Pe2NNfbInoBWO7rcs1TN7SSjGcjCX6BZlxV8DRw/uzgc8bll4FU+WueRElJrvgF7nfLh6KF98buN+tfI43thcrw6kO3dYXwt5F/ZlwJsrWWXN6XpQ5l8602p3vMzTmfYK77zmhASjdNNcKdJodH/xvYczLEJVcUsKZENGiz595LIzyfnEe/mx1tZpIavt2rYWG8m0bVbI90FD1SodPRoISG1eyKIJrZWLdGOYBKyDHZeYN2PIHg1u5IeQLGm6rP+2cbU0yF7k7mOisAuw0XcXjlaxHSsD9nnSo3JetJ7WKqQnQzLyr3ohqqnAc5kWZ1B7QMnC2snfquLOVkAClj2KeOdqo4AsCkGQY1R2COTjMLFBvLg6WsmflNqc2JT7E7I8wx0VmbBXTvqsxIXXfbf3m+NNAOYbo0+dKzKYTD2w63eWO2lyslagMKY0869faXq5caKO6JRwxP8AYstTX6jvnsyBm+UgBwKdqrzXX5j+BN5dW4LSNN//lmHaFyJyIRT6dv7ya0zeJN9te5XDEpfTNuJkQKvMrkXm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(396003)(136003)(186009)(1800799009)(451199024)(6486002)(6666004)(53546011)(6506007)(478600001)(83380400001)(33656002)(36756003)(86362001)(38100700002)(2906002)(2616005)(41300700001)(26005)(6512007)(4326008)(54906003)(8936002)(66556008)(235185007)(5660300002)(7416002)(8676002)(6916009)(66946007)(316002)(66476007)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AnKv2GbeczUmINCEvtJqcK0bZAHAZ6CjkCR4NHrxEnZKtlWcqH9l9Fjvz+4F?=
 =?us-ascii?Q?Vi61GfSzko5bvy+jh3cM3vPSCPVOA7FN1MsQfPHGNet9s91CEq9tn89kcpWQ?=
 =?us-ascii?Q?44P5IdJW4cVCxxqz3ik0S8Yv9q9fTGc1VAgh+rkYoaYQsrQLF8QuQOisZuy3?=
 =?us-ascii?Q?MPrszRvnSeI2dC1E19uVN54969GxsusnoK06r2DZz11pUvIVh13IFLnJkpJA?=
 =?us-ascii?Q?r5qIA02caY8gZh1mM6LAeCu0X9EtWtl/o3Cs9sFgiDhvDCzeL7qPzDcobyl2?=
 =?us-ascii?Q?hTRRJ5gGUUUeWLgkoJWVBVnIZ3t0yZ2cnZGyw0sZEt+LONjn1KgjhCCcvWts?=
 =?us-ascii?Q?IYFDmwYKT8qKf16FsShtJ+8Hpmd1TvvNuSBGSdXpSa657s4C0CnViJ+bvSRW?=
 =?us-ascii?Q?pIWlpiZYJc7qIvxWNsbzJb7gz4phkYSBDAD4Ry9iJ/jSdLcpvUonn2gVeUol?=
 =?us-ascii?Q?ZLtZhE/5j0dTEMxC03zc1p5ooeOxAcocfWBwBTCTPSBtrnbqyjej7F97yfie?=
 =?us-ascii?Q?JF0GQL9PSVnb9Y2VurgezA178GBybFZmUkYwsEnadE/6iRFnWtkq+tnqucwJ?=
 =?us-ascii?Q?IV/k6JHWmGEVtuMFFO53ebYRK9Igr62QqXszlDITvDKcSxov7lhewVqfq2i6?=
 =?us-ascii?Q?qNJRjUtCyOPILvMQA5BTX9DST/UgWk+439IsI1w2YrmbNFVrY4O45tei9WCU?=
 =?us-ascii?Q?2fRnIYKgfhJkAc/PKj+E9MYre1KL7GxGmZxLST4c+CgcCHwlCRN6SzhzU5fM?=
 =?us-ascii?Q?ziyJzIki722MxFG662bfxNgKEBkU3D4LruZDu8AU6fVgEHhZI73Ji1dtjvnq?=
 =?us-ascii?Q?TU2D0jXtPvH/gNiFzHK+rD+yRysdkNYsSaTHe+hVyAakAl2wc2gNMmLnVouL?=
 =?us-ascii?Q?ZGdPayxLYhzdg6TbAoq7TWp9PP2zBf+ggVAzGlnz5NKkEueRGMJc804BxD07?=
 =?us-ascii?Q?SuIDq9A9jG7Tjoixmf+rA88qLO10y33vHrGFffz/w26NjFjida68GRugb4No?=
 =?us-ascii?Q?ST/n5Lg5vkpOarQk8sOWJcfcVNZvoP05YAG3sfrBLvIuo7NgqKe86nINCXNk?=
 =?us-ascii?Q?3yfUUsD7sHzuBn4Pz31eUbHE5zVp5az5wTpEGGxad0KIwdeXjjd8UzoihKSf?=
 =?us-ascii?Q?pIjx5I97LN6P9rRKjIruOlHKlqM+zefXjsRMM1Vvv4PcHwoCzJOxeWWJhSAj?=
 =?us-ascii?Q?j3GrtmCdwTiafV3BegwxjOYcY0/APcOlh6vm+Tzzy5DCp+NE8xX0NDbuIiKD?=
 =?us-ascii?Q?LPPo12jDrkkaPwnwAnYAVGtYAYgoocLUw5p9VK+c+rk0VCVcMdehoDBSEpXR?=
 =?us-ascii?Q?/69MoUUlrXzwyUFbAgi/9S0YBofFSD8h/M0sDMywGcE1s4yJPiTwx9ivQZf3?=
 =?us-ascii?Q?BSE3dQduxD/IM+jL217rHZpKe7APyGrNzfwMYwu0TvzN/YSl8qhP4pw6eo0O?=
 =?us-ascii?Q?7hGRYbqjHx9rjKGaPkZP/7v36hlMBW6HYU0TqHhyh7bIVJeKPEatxS9MqDhA?=
 =?us-ascii?Q?ArFdW/wqep6+UPzZ4oQGdUtezdmlHYpBnvwa9E/NOwSkP/zRh3K0yimPAom8?=
 =?us-ascii?Q?2PedrZkJml5xua1G1lU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcaa22fe-27de-40ca-c406-08dbbab1ac19
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 14:47:26.3552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 059o1p0tZgrvwQdjAE7ddhZBNAOErM4+F1GKtP69K1mi1H3+fPgS56RkOInE/69R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_7E985CA9-4D60-4CCD-A67E-47FBE228E5CB_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 21 Sep 2023, at 6:19, David Hildenbrand wrote:

> On 21.09.23 04:31, Zi Yan wrote:
>> On 20 Sep 2023, at 13:23, Zi Yan wrote:
>>
>>> On 20 Sep 2023, at 12:04, Johannes Weiner wrote:
>>>
>>>> On Wed, Sep 20, 2023 at 09:48:12AM -0400, Johannes Weiner wrote:
>>>>> On Wed, Sep 20, 2023 at 08:07:53AM +0200, Vlastimil Babka wrote:
>>>>>> On 9/20/23 03:38, Zi Yan wrote:
>>>>>>> On 19 Sep 2023, at 20:32, Mike Kravetz wrote:
>>>>>>>
>>>>>>>> On 09/19/23 16:57, Zi Yan wrote:
>>>>>>>>> On 19 Sep 2023, at 14:47, Mike Kravetz wrote:
>>>>>>>>>
>>>>>>>>>> 	--- a/mm/page_alloc.c
>>>>>>>>>> 	+++ b/mm/page_alloc.c
>>>>>>>>>> 	@@ -1651,8 +1651,13 @@ static bool prep_move_freepages_block(=
struct zone *zone, struct page *page,
>>>>>>>>>>   		end =3D pageblock_end_pfn(pfn) - 1;
>>>>>>>>>>
>>>>>>>>>>   		/* Do not cross zone boundaries */
>>>>>>>>>> 	+#if 0
>>>>>>>>>>   		if (!zone_spans_pfn(zone, start))
>>>>>>>>>> 			start =3D zone->zone_start_pfn;
>>>>>>>>>> 	+#else
>>>>>>>>>> 	+	if (!zone_spans_pfn(zone, start))
>>>>>>>>>> 	+		start =3D pfn;
>>>>>>>>>> 	+#endif
>>>>>>>>>> 	 	if (!zone_spans_pfn(zone, end))
>>>>>>>>>> 	 		return false;
>>>>>>>>>> 	I can still trigger warnings.
>>>>>>>>>
>>>>>>>>> OK. One thing to note is that the page type in the warning chan=
ged from
>>>>>>>>> 5 (MIGRATE_ISOLATE) to 0 (MIGRATE_UNMOVABLE) with my suggested =
change.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Just to be really clear,
>>>>>>>> - the 5 (MIGRATE_ISOLATE) warning was from the __alloc_pages cal=
l path.
>>>>>>>> - the 0 (MIGRATE_UNMOVABLE) as above was from the alloc_contig_r=
ange call
>>>>>>>>    path WITHOUT your change.
>>>>>>>>
>>>>>>>> I am guessing the difference here has more to do with the alloca=
tion path?
>>>>>>>>
>>>>>>>> I went back and reran focusing on the specific migrate type.
>>>>>>>> Without your patch, and coming from the alloc_contig_range call =
path,
>>>>>>>> I got two warnings of 'page type is 0, passed migratetype is 1' =
as above.
>>>>>>>> With your patch I got one 'page type is 0, passed migratetype is=
 1'
>>>>>>>> warning and one 'page type is 1, passed migratetype is 0' warnin=
g.
>>>>>>>>
>>>>>>>> I could be wrong, but I do not think your patch changes things.
>>>>>>>
>>>>>>> Got it. Thanks for the clarification.
>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> One idea about recreating the issue is that it may have to do =
with size
>>>>>>>>>> of my VM (16G) and the requested allocation sizes 4G.  However=
, I tried
>>>>>>>>>> to really stress the allocations by increasing the number of h=
ugetlb
>>>>>>>>>> pages requested and that did not help.  I also noticed that I =
only seem
>>>>>>>>>> to get two warnings and then they stop, even if I continue to =
run the
>>>>>>>>>> script.
>>>>>>>>>>
>>>>>>>>>> Zi asked about my config, so it is attached.
>>>>>>>>>
>>>>>>>>> With your config, I still have no luck reproducing the issue. I=
 will keep
>>>>>>>>> trying. Thanks.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Perhaps try running both scripts in parallel?
>>>>>>>
>>>>>>> Yes. It seems to do the trick.
>>>>>>>
>>>>>>>> Adjust the number of hugetlb pages allocated to equal 25% of mem=
ory?
>>>>>>>
>>>>>>> I am able to reproduce it with the script below:
>>>>>>>
>>>>>>> while true; do
>>>>>>>   echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepa=
ges&
>>>>>>>   echo 2048 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepa=
ges&
>>>>>>>   wait
>>>>>>>   echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages=

>>>>>>>   echo 0 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepa=
ges
>>>>>>> done
>>>>>>>
>>>>>>> I will look into the issue.
>>>>>
>>>>> Nice!
>>>>>
>>>>> I managed to reproduce it ONCE, triggering it not even a second aft=
er
>>>>> starting the script. But I can't seem to do it twice, even after
>>>>> several reboots and letting it run for minutes.
>>>>
>>>> I managed to reproduce it reliably by cutting the nr_hugepages
>>>> parameters respectively in half.
>>>>
>>>> The one that triggers for me is always MIGRATE_ISOLATE. With some
>>>> printk-tracing, the scenario seems to be this:
>>>>
>>>> #0                                                   #1
>>>> start_isolate_page_range()
>>>>    isolate_single_pageblock()
>>>>      set_migratetype_isolate(tail)
>>>>        lock zone->lock
>>>>        move_freepages_block(tail) // nop
>>>>        set_pageblock_migratetype(tail)
>>>>        unlock zone->lock
>>>>                                                       del_page_from_=
freelist(head)
>>>>                                                       expand(head, h=
ead_mt)
>>>>                                                         WARN(head_mt=
 !=3D tail_mt)
>>>>      start_pfn =3D ALIGN_DOWN(MAX_ORDER_NR_PAGES)
>>>>      for (pfn =3D start_pfn, pfn < end_pfn)
>>>>        if (PageBuddy())
>>>>          split_free_page(head)
>>>>
>>>> IOW, we update a pageblock that isn't MAX_ORDER aligned, then drop t=
he
>>>> lock. The move_freepages_block() does nothing because the PageBuddy(=
)
>>>> is set on the pageblock to the left. Once we drop the lock, the budd=
y
>>>> gets allocated and the expand() puts things on the wrong list. The
>>>> splitting code that handles MAX_ORDER blocks runs *after* the tail
>>>> type is set and the lock has been dropped, so it's too late.
>>>
>>> Yes, this is the issue I can confirm as well. But it is intentional t=
o enable
>>> allocating a contiguous range at pageblock granularity instead of MAX=
_ORDER
>>> granularity. With your changes below, it no longer works, because if =
there
>>> is an unmovable page in
>>> [ALIGN_DOWN(start_pfn, MAX_ORDER_NR_PAGES), pageblock_start_pfn(start=
_pfn)),
>>> the allocation fails but it would succeed in current implementation.
>>>
>>> I think a proper fix would be to make move_freepages_block() split th=
e
>>> MAX_ORDER page and put the split pages in the right migratetype free =
lists.
>>>
>>> I am working on that.
>>
>> After spending half a day on this, I think it is much harder than I th=
ought
>> to get alloc_contig_range() working with the freelist migratetype hygi=
ene
>> patchset. Because alloc_contig_range() relies on racy migratetype chan=
ges:
>>
>> 1. pageblocks in the range are first marked as MIGRATE_ISOLATE to prev=
ent
>> another parallel isolation, but they are not moved to the MIGRATE_ISOL=
ATE
>> free list yet.
>>
>> 2. later in the process, isolate_freepages_range() is used to actually=
 grab
>> the free pages.
>>
>> 3. there was no problem when alloc_contig_range() works on MAX_ORDER a=
ligned
>> ranges, since MIGRATE_ISOLATE cannot be set in the middle of free page=
s or
>> in-use pages. But it is not the case when alloc_contig_range() work on=

>> pageblock aligned ranges. Now during isolation phase, free or in-use p=
ages
>> will need to be split to get their subpages into the right free lists.=

>>
>> 4. the hardest case is when a in-use page sits across two pageblocks, =
currently,
>> the code just isolate one pageblock, migrate the page, and let split_f=
ree_page()
>> to correct the free list later. But to strictly enforce freelist migra=
tetype
>> hygiene, extra work is needed at free page path to split the free page=
 into
>> the right freelists.
>>
>> I need more time to think about how to get alloc_contig_range() proper=
ly.
>> Help is needed for the bullet point 4.
>
>
> I once raised that we should maybe try making MIGRATE_ISOLATE a flag th=
at preserves the original migratetype. Not sure if that would help here i=
n any way.

I have that in my backlog since you asked and have been delaying it. ;) H=
opefully
I can do it after I fix this. That change might or might not help only if=
 we make
some redesign on how migratetype is managed. If MIGRATE_ISOLATE does not
overwrite existing migratetype, the code might not need to split a page a=
nd move
it to MIGRATE_ISOLATE freelist?

The fundamental issue in alloc_contig_range() is that to work at
pageblock level, a page (>pageblock_order) can have one part is isolated =
and
the rest is a different migratetype. {add_to,move_to,del_page_from}_free_=
list()
now checks first pageblock migratetype, so such a page needs to be remove=
d
from its free_list, set MIGRATE_ISOLATE on one of the pageblock, split, a=
nd
finally put back to multiple free lists. This needs to be done at isolati=
on stage
before free pages are removed from their free lists (the stage after isol=
ation).
If MIGRATE_ISOLATE is a separate flag and we are OK with leaving isolated=
 pages
in their original migratetype and check migratetype before allocating a p=
age,
that might help. But that might add extra work (e.g., splitting a partial=
ly
isolated free page before allocation) in the really hot code path, which =
is not
desirable.

>
> The whole alloc_contig_range() implementation is quite complicated and =
hard to grasp. If we could find ways to clean all that up and make it eas=
ier to understand and play along, that would be nice.

I will try my best to simplify it.

--
Best Regards,
Yan, Zi

--=_MailMate_7E985CA9-4D60-4CCD-A67E-47FBE228E5CB_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUMV3sPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUEQ8QAKSi9HcR5gM6ZA890hm8JjxH2Ufw8/Fp3gqX
gqrMAxnIXk9M8thblHLkbD5wjMefVPixGDmsPzdX9VG9JuLC/snXcr6//9v00Uas
F3t+Z2HL5iyp70SDa91BCLrtZfLPNkgGGwdQze0uh5KDtzNgW7wd3A8UjgmvmIN0
/cDARmmLk0NkU98clejJ0x+VZy7WKM+uFhu61BXbdOagz+o8okJSCDFdw85vachp
EKPmSD2Q7Bfoh9Cy3EHo+rZYy1JDqB5uVn8niTN2DdYI66KPk+FZwQ5btAHbjoYh
HV3526iU0Ki7rqDpXV2JTe8bnY6KSt2rYNLNDZ+hpfE1Dff9Je8bL5sghngUBJIP
cdcFiez3gVh6lD+2R33lnyqdfVUhlerIjGAwRWBF5LmkKAbQ+Jqx5epfvuz1yTAy
q77fIojiG+agCsfJponExHzQ4yxIXLRumTUkE11VDKQuQY7q2yOgIOUuBrCvAE1o
WnCVd1+MpJFIguxLDJGEgYyMgdtJ/t2VJPhLla9ZYD6o8kEylMuLkvFvd87ZqF1v
FA7/hNQ7NgfkhB5Fbz1lI3U0IzRltR84jm7ZT7GbVnFfB1V3gKU0x6RSIprdB294
D1FbLxwTzNmtN+G3pXwWunuzs69krJ5wynuF/xmnogJBjM4u0o6a7QNsnbT4qqDL
czgo4byl
=PzJr
-----END PGP SIGNATURE-----

--=_MailMate_7E985CA9-4D60-4CCD-A67E-47FBE228E5CB_=--
