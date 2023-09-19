Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2F47A6324
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjISMhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjISMhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:37:39 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7F8F7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:37:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebVfs1Cuo0LdeAX+EHp5LZHpHTFNloJkBvUw05AMX6iRww/Tybgl7Ln4vU54EcMDvcaHpEbWLWBVIPE0rFAQ0KkhMYUieAopvwSwSNKJyWg1WGetbtCxb3/huOaIhn7K0OPZajVv5tg0aJNS7Z4FU7vxytTF8zK3qR4Ijv/xbg2IdEnUzHf2sgOKew5w4jO+NHZZVZ9nKPfMTmvgahrPdY9LDUPY4rp0Rs5k1SsMo9M/xmpHhhGRlENdAqqPnt2Ywww5xNaJeWJR4PmHabvM0s0EKjrgp/t6NrGMFkVlhw9vVthaMhgLbudufn3Tw9cZ8xci2H/ChrqY03VlKX9zUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiioEg97JP8PsKf/aXbRk4bmYnFBjXD4TqmAmElCaMM=;
 b=Xb+LbCyLZSmY4c/gr1vsb96Wm9ODuTvdIimO+q2j8zoW6foc/Z/q4Im52ubii0AjpqkrTMQQFOsQ6Ys6x0riYZ4A/EqHr3VuTtHEf1QalURtn7MKw579NiDx9TR1m3gf/JyTeT4x0xZsbTLCj1tY7iQ0vyj+EG6CLuRbDhUh8exTTHhdnMMxX/ag6mCM9WtVWFH7OyCYizHNOI25ykgLJA6nQobJBbzc6DUsEdbcUb+D1JKTaDAlUgnEWwlCJspFyq9RknXV+sgKHcvMU2IQjmlp//L9kMamOxuOm5drWcgJ+rE3g+YJqli0g30X4vWEXa/wTKGRvP3BmqlGUqUU5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiioEg97JP8PsKf/aXbRk4bmYnFBjXD4TqmAmElCaMM=;
 b=gZBYzJDFrbaa2q35PHUjzEHLLDKbwPPz2Id+wu2YnAnVhCG84CAAx30Y/sC7rY1+Be63Fl831FQd6/4IFr1cflDVVhfKm7zVVK2BKgdevNFhAeOEkEp1u7c37GFRJduJV43SVY2NzXZClL7BUtrBEgbRyM7rKWQXRlrqjcvhv2BGRC0Y48DXcrLY2QMXeh/VlLLUvGc8CKT2v4OoEiE9FIYDHYrPDdgA6NVd0Zd8J8V2J7M7p8HJ1NvC+KZdBprrQWIUdGVcCx2djod86SUPc/Gbd+wNAfzOwOHj6eAfUJ4uiDhXrhg4eamZTZbmjaamA2BI6OHDPWGeK1d3AzSZPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DS7PR12MB6166.namprd12.prod.outlook.com (2603:10b6:8:99::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.26; Tue, 19 Sep 2023 12:37:29 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 12:37:29 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/6] mm: page_alloc: freelist migratetype hygiene
Date:   Tue, 19 Sep 2023 08:37:23 -0400
X-Mailer: MailMate (1.14r5984)
Message-ID: <10988935-A726-41FA-A254-70DFD98EA30D@nvidia.com>
In-Reply-To: <20230919064914.GA124289@cmpxchg.org>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230914235238.GB129171@monkey> <20230915141610.GA104956@cmpxchg.org>
 <20230916195739.GB618858@monkey>
 <a88b7339-beab-37c6-7d32-0292b325916d@suse.cz>
 <20230918145204.GB16104@cmpxchg.org> <20230918174037.GA112714@monkey>
 <20230919064914.GA124289@cmpxchg.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_E404CEFB-A3BB-49CE-964F-BD8440AE43AD_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: YQBPR0101CA0198.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::35) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DS7PR12MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: d875f1a6-474c-4b26-2f5b-08dbb90d2f9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ATlV42fA51AxvPcoZvA1MwwkGD9a4t+m0qmLtfnGn1fi5BwDT11t+/ruiUIdPQDOJufbeFoFPP7tnvXRZVlncVCUrfzCR2udyzyTxOdlR4/qguHtOLq0WQnDgM0q6xfPEL9rLP+w5sFgia/9mqcBwlW1g0WHqvyN5GNPkysbdv2/hXzWwg5Zj2OSaiqVPwIBWg0RHsOH/mnpd8/+GqQDPYtOc9VwDxN6K0quWGj4ZbnPNF9bbITDan7eQw21VWB5qakB+3YNDgegK8m9GNbT2ywwOZQ/ZD/COLsJ+pxi1BJwnAOCU8zP+PAAo0BAVYroyCL0OxzR5AhlBe7zWZvl7ZJ4d6n6w1zdgN3Lup4aLRRn+0M9mVkl662rKvkAqZUaEBnZrbbm6KoKUsB9pxbXws94HasjSBcTH8qlB8KUwpHC4c9+LF2Q4j5ETL0bl1ZpMevzS3Rj1qI7dG5YX2Sz/CMnWSxaJ4Hh9fn6lEabKBozl0Cww6OwZSM0RvmYXZ9wKoP0xJhByPprddz3pJHq6oq+AFFmnfVM+AcrG5RI3Kk0mB/9x7gwZDfGwgMH6JGiFmeqsxBDJMu+N8G0oH2xjBzZpgqkG51YZvr4FDIeuObrpImkJtTAgUeYgVGUDD8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(39860400002)(396003)(1800799009)(186009)(451199024)(26005)(2616005)(8676002)(8936002)(4326008)(235185007)(83380400001)(33656002)(2906002)(36756003)(86362001)(53546011)(6506007)(6486002)(6666004)(478600001)(5660300002)(6916009)(316002)(54906003)(6512007)(66946007)(41300700001)(38100700002)(66476007)(66556008)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fQjZaSb73wIk3ss7UzEPtdsx4yL8Y5NM/TOt2hd5HQx9S9/FyMWeritWMWPY?=
 =?us-ascii?Q?tmpISaj8dnxv6nStO8jNjBm+UVltNLiPx225SeAzVH4Vq8xivXiGP8EMQ5+y?=
 =?us-ascii?Q?lnlvUdP+m3yXTyP6yBs+yoC5mChdmwKHXGLDAb1i56/jIM/Vk8j0TvH3weej?=
 =?us-ascii?Q?Ff7D5CZA0v5SK6lCyJDOgABQ82CsOY5lVHByCFzJKm2QJfVIxV0WvN/YhY0J?=
 =?us-ascii?Q?oQ7K+faXtvN/mQg2zg+i7oydG8cEDi++YFfkcUfMjb0YKNuLfrZVFWGdlEza?=
 =?us-ascii?Q?tRKVMtYEwPuFizWCyj0Mqw/aeQ6AvxawCpFaJ9lR7fZmc3y0IqNXH+2JQK8G?=
 =?us-ascii?Q?OHOIAociduybh5Pe5bwzewFx2XXlym0h6iM4GdjYYMsD/5BtqT2XO3M5JFSR?=
 =?us-ascii?Q?b9MY/CjR+yJhNGZoF9W00VGjlGdjvM7fY+cwn4Q5MEByInj4pcndyNt0h/8R?=
 =?us-ascii?Q?nAUknOb1XzAqL8X/PTn9V9I9my35OHJagMypo1n+6TpbnqPvVfV9ndfq9mlT?=
 =?us-ascii?Q?5gqk56GE4pzIoNXnMIHFiG83MTMKp8pLtP0ykchf3/qF3i8DkB1qLOq8tx25?=
 =?us-ascii?Q?eoOTtPl22cNJNv+TnmTocXVpMWukzEQ7HEUOhRw4M2pHS15phr5P1RSJpRgh?=
 =?us-ascii?Q?dJ1fPXev3NRvOeAvo9f634CaipbwvVPEHVaLrQMfDXGfrDx4OCkaJrzy0aLr?=
 =?us-ascii?Q?qnjFwZW3okTeG/wnsu4eMZShrQSXN8YdskX+H9H1YAGKaVfdQACO5Xx+7qq9?=
 =?us-ascii?Q?yA20Ed74pOMay4zfmwSJlTE18AHVU+IDoXlSun75ziNPAb2njBSgB6PP5jBU?=
 =?us-ascii?Q?hO1bM6p2GdeU56VrTjxD6vGXDPYfrvcVbiye3zJBZ5GDd3gPRosgP0ZQdYdX?=
 =?us-ascii?Q?BtRNQpMJNIN1sOu/pNVTyJ/D4ZNoTToPfH5AMbTIszg0DQJBYYM9/IA6CBpn?=
 =?us-ascii?Q?DWTYl0Q51moXPt1U0zlLReK2MmkvOv4sK6puvl76fcSPD0OlpuOmGtLaTaO5?=
 =?us-ascii?Q?VtBYV1kjna6atMamtlSAhwPg/1ahzt8zf02RGyDzaN7NWc4LnKEsxUjZJAwn?=
 =?us-ascii?Q?bOAMFl+U9no84oOT7+Baj5BJro56u6gdMREKFPxAyjAnccgJL1sN4TLuYT0D?=
 =?us-ascii?Q?vBzwwvRX2V+CEtvTbmTbONH6LxOSyt0dSRXDLw8Nnx2jNs1Z3mF0EJgpyYOT?=
 =?us-ascii?Q?MXS8OSPibRZ36e4XI7xoEPtxtmWrWXiOvID+vHkjhX0P+rtnUcs9gJm/rt4Z?=
 =?us-ascii?Q?kpPpLs2oiQOP+tYzI98jm5w3NsPY+UOC8Z+dlXvcy/S78bj6eaGC0PNsjOp+?=
 =?us-ascii?Q?AmWK3lgeIq+gMexWmQjbpSUqJtgeRzQ4cIN4afAbQ6SMPnxqUTaRfcuM7ALi?=
 =?us-ascii?Q?7uELqLMGehUuTF8BdgyJStn/pNzRlnjzXN/U9fMdkpv9R+DwkGz7H1swG+aU?=
 =?us-ascii?Q?GR0lWeg7882K+kwsL8z7S86dKWJ/OVXAaFXa7q6NaxRt8qPC+nKx39X31E/6?=
 =?us-ascii?Q?Rjiu2BuuHXT/O2FJDq93vk1+XqgfXW2ojpilJFIHq/vMdzp6b0o7r005eAf2?=
 =?us-ascii?Q?Y9h+G/jt1u6OPpGuCKs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d875f1a6-474c-4b26-2f5b-08dbb90d2f9d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 12:37:29.0014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XjzrhcmpWW6rreTIOIj75ZUfc7I43Rm5mEHkBGQ0i/CxZ3jejXBh9KfDwDjVrvOd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6166
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_E404CEFB-A3BB-49CE-964F-BD8440AE43AD_=
Content-Type: text/plain

On 19 Sep 2023, at 2:49, Johannes Weiner wrote:

> On Mon, Sep 18, 2023 at 10:40:37AM -0700, Mike Kravetz wrote:
>> On 09/18/23 10:52, Johannes Weiner wrote:
>>> On Mon, Sep 18, 2023 at 09:16:58AM +0200, Vlastimil Babka wrote:
>>>> On 9/16/23 21:57, Mike Kravetz wrote:
>>>>> On 09/15/23 10:16, Johannes Weiner wrote:
>>>>>> On Thu, Sep 14, 2023 at 04:52:38PM -0700, Mike Kravetz wrote:
>>>>>
>>>>> With the patch below applied, a slightly different workload triggers the
>>>>> following warnings.  It seems related, and appears to go away when
>>>>> reverting the series.
>>>>>
>>>>> [  331.595382] ------------[ cut here ]------------
>>>>> [  331.596665] page type is 5, passed migratetype is 1 (nr=512)
>>>>> [  331.598121] WARNING: CPU: 2 PID: 935 at mm/page_alloc.c:662 expand+0x1c9/0x200
>>>>
>>>> Initially I thought this demonstrates the possible race I was suggesting in
>>>> reply to 6/6. But, assuming you have CONFIG_CMA, page type 5 is cma and we
>>>> are trying to get a MOVABLE page from a CMA page block, which is something
>>>> that's normally done and the pageblock stays CMA. So yeah if the warnings
>>>> are to stay, they need to handle this case. Maybe the same can happen with
>>>> HIGHATOMIC blocks?
>
> Ok, the CMA thing gave me pause because Mike's pagetypeinfo didn't
> show any CMA pages.
>
> 5 is actually MIGRATE_ISOLATE - see the double use of 3 for PCPTYPES
> and HIGHATOMIC.
>
>>> This means we have an order-10 page where one half is MOVABLE and the
>>> other is CMA.
>
> This means the scenario is different:
>
> We get a MAX_ORDER page off the MOVABLE freelist. The removal checks
> that the first pageblock is indeed MOVABLE. During the expand, the
> second pageblock turns out to be of type MIGRATE_ISOLATE.
>
> The page allocator wouldn't have merged those types. It triggers a bit
> too fast to be a race condition.
>
> It appears that MIGRATE_ISOLATE is simply set on the tail pageblock
> while the head is on the list, and then stranded there.
>
> Could this be an issue in the page_isolation code? Maybe a range
> rounding error?
>
> Zi Yan, does this ring a bell for you?

Since isolation code works on pageblocks, a scenario I can think of
is that alloc_contig_range() is given a range starting from that tail
pageblock.

Hmm, I also notice that move_freepages_block() called by
set_migratetype_isolate() might change isolation range by your change.
I wonder if reverting that behavior would fix the issue. Basically,
do

	if (!zone_spans_pfn(zone, start))
		start = pfn;

in prep_move_freepages_block(). Just a wild guess. Mike, do you mind
giving it a try?

Meanwhile, let me try to reproduce it and look into it deeper.

>
> I don't quite see how my patches could have caused this. But AFAICS we
> also didn't have warnings for this scenario so it could be an old bug.
>
>>> Mike, could you describe the workload that is triggering this?
>>
>> This 'slightly different workload' is actually a slightly different
>> environment.  Sorry for mis-speaking!  The slight difference is that this
>> environment does not use the 'alloc hugetlb gigantic pages from CMA'
>> (hugetlb_cma) feature that triggered the previous issue.
>>
>> This is still on a 16G VM.  Kernel command line here is:
>> "BOOT_IMAGE=(hd0,msdos1)/vmlinuz-6.6.0-rc1-next-20230913+
>> root=UUID=49c13301-2555-44dc-847b-caabe1d62bdf ro console=tty0
>> console=ttyS0,115200 audit=0 selinux=0 transparent_hugepage=always
>> hugetlb_free_vmemmap=on"
>>
>> The workload is just running this script:
>> while true; do
>>  echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
>>  echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/demote
>>  echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
>> done
>>
>>>
>>> Does this reproduce instantly and reliably?
>>>
>>
>> It is not 'instant' but will reproduce fairly reliably within a minute
>> or so.
>>
>> Note that the 'echo 4 > .../hugepages-1048576kB/nr_hugepages' is going
>> to end up calling alloc_contig_pages -> alloc_contig_range.  Those pages
>> will eventually be freed via __free_pages(folio, 9).
>
> No luck reproducing this yet, but I have a question. In that crash
> stack trace, the expand() is called via this:
>
>  [  331.645847]  get_page_from_freelist+0x3ed/0x1040
>  [  331.646837]  ? prepare_alloc_pages.constprop.0+0x197/0x1b0
>  [  331.647977]  __alloc_pages+0xec/0x240
>  [  331.648783]  alloc_buddy_hugetlb_folio.isra.0+0x6a/0x150
>  [  331.649912]  __alloc_fresh_hugetlb_folio+0x157/0x230
>  [  331.650938]  alloc_pool_huge_folio+0xad/0x110
>  [  331.651909]  set_max_huge_pages+0x17d/0x390
>
> I don't see an __alloc_fresh_hugetlb_folio() in my tree. Only
> alloc_fresh_hugetlb_folio(), which has this:
>
>         if (hstate_is_gigantic(h))
>                 folio = alloc_gigantic_folio(h, gfp_mask, nid, nmask);
>         else
>                 folio = alloc_buddy_hugetlb_folio(h, gfp_mask,
>                                 nid, nmask, node_alloc_noretry);
>
> where gigantic is defined as the order exceeding MAX_ORDER, which
> should be the case for 1G pages on x86.
>
> So the crashing stack must be from a 2M allocation, no? I'm confused
> how that could happen with the above test case.

That matches my thinking too. Why the crash happened during 1GB page
allocation time? The range should be 1GB-aligned and of course cannot
be in the middle of a MAX_ORDER free page block.


--
Best Regards,
Yan, Zi

--=_MailMate_E404CEFB-A3BB-49CE-964F-BD8440AE43AD_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUJlgQPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUJHoP/Ruxi62iB+IaTlHZFhf3ZlvMJp/WuPoM9Naq
nMvCK5Xa4P0mKY8S/hC/GL35+SvUThX2ZxrZ5d/mQhff1u621AY42ArRD1Mr3WpX
DysCzTdYNf8k+l6798UVbJn23CRiA/L++x2g/2osH47RV350AKHlXj0/5QTP7tEi
TFG4jlf4v9PpRhUQgh1ictqHVocojGkQsLUYIUIPFBJGiuo0cvgd4GY3klfjdojf
F2fqKOOuk/2CuR++dG2pmcfIcdXDvtxJiSb2FVyFwDsvhhp7/ANL3s98d80Pp6gF
g1jC+i/7a0ws6QrkTDTjUkimJfQSm2GkqdFJAfomNFgbn9SZzL/3Qqyfxe2Ya1IB
MFTTKngMVCjltS4xfvQxqZDp6U0eO36pJCJOXMjxHCY7FtLFimcUv/LhVi+Gct0P
Qygo9rctVkJJN//ln7Wx2PywlRaTLa6AZdyXQmSheO89EOqxza/C7Np0ckbndPt8
qyiPRxYw4bAUTGXdRoOPs2Sj0zbw9n35FQrbT+Rn4jAlYupkNSnbQf1cBW8b7rSb
VGHhNNpapyPW1kMkL8MR/TveewMk542M8GqHJtp5tYtQDQl0rbaZt6vA9NBcHMTD
iFt5Gxrim9sPvhob1M0x4vuQMaqZrbgcAv8GdlX5U0TOZ7Gt4N/fovdT5LRd+DHl
4eetyO9E
=j2Uj
-----END PGP SIGNATURE-----

--=_MailMate_E404CEFB-A3BB-49CE-964F-BD8440AE43AD_=--
