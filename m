Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7267F9B16
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 08:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjK0Hni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 02:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjK0Hng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 02:43:36 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E0EE6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:43:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oH88dWPWA7IGmyY9iqrW6M5SD+GH/HvVzEaz3nyTayNQNTcRrFkwUhTpSllzkLGkm7hNvTpXTw13TeR/xJxgnfnG4JS9Fxkd/Z3aVSTz6spN+6WDRfvj6hYmFh6DhkeNP28yVHCLJ81jmTCGCTf+qI0oTjgpwdLGcl7hJke4qz/DHbgU0n4Vp1iyYPq6l+WSmHDtusrHSJvdl6+dDjMZa22M25Okak//pivYv2JYbQfWvpN845alhBPfL2nEryLUFn0ultJnRacbBTrttTca3Z/MNtM3NSfUBbyk1o+0/nbz/LkL9mTMuFOXWzKFGbryw8vOV1K0niS6CPTb3ykatQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DU5ogI/2ChVGTz2gnQKh7CvEmgVK9QjZszOoGWav3YY=;
 b=ChiZqhktqYzk8A2VQaMCQrP/9BXd0PzgzCvekjZje47ni8/eHbUW5zWp97C01SfxH21SziWEpIxiC73FRqxPqItV3KLxwPj55vL9F+XJkhDZAqDI1MQqShEneF2g1494l6uEaYIo8HGlJOFk1j7N7uh7W4HEnrzeorGZNJR1ilZd61hwloTiQsk0yMCk+gJc3Znufvb0X5vuox0rUnPlV22BTdoPUV5Bkmb/ED8Hor5/Su6mIvfzCihopV+71jhQVQdp2Bk/YyyJsvc7gsb5jmeibw+ekT+mYixSk4Z5aiQ7P8l0e0N/7u/Fge2W9cyD72dj/jNMEJgJLelga7HpLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DU5ogI/2ChVGTz2gnQKh7CvEmgVK9QjZszOoGWav3YY=;
 b=NFT+hh1gRtAaVQI8ngIKA0tpcPwrdhWXR48kvtW+Lm4AyPjDYfbOeONEeFOlRhsfF4J6wmWl9l/FMJ5wPqMK7ob+ULFaIUF7ojr5YJbT8nfmDDitQs9qeZ2XeykaK8KsYKbMdyTuWeW8PsfsEhWTDqP20aEE/ZyZ1zdNuKoacumvgbu6zqh4GvqZUR4LfNYEOVzfiqR7wPRjIfmyRZvgx2gJKJs2wBNwNrYbcQCKxgvqvTSwr7aeXOU1XiVhXtPy3tPTS3yudZnOgs1vv+243uKs28wbt5qPTvfwfLW2Liq8IL5EhUEqu4qw7It+Nv2+VYEpJutIxRiG9fivV2hojQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by PH8PR12MB6699.namprd12.prod.outlook.com (2603:10b6:510:1ce::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 27 Nov
 2023 07:43:39 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6%7]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 07:43:38 +0000
References: <20231115163018.1303287-1-ryan.roberts@arm.com>
 <20231115163018.1303287-15-ryan.roberts@arm.com>
 <87fs0xxd5g.fsf@nvdebian.thelocal>
 <3b4f6bff-6322-4394-9efb-9c3b9ef52010@arm.com>
 <87y1eovsn5.fsf@nvdebian.thelocal>
 <8fca9ed7-f916-4abe-8284-6e3c9fa33a8c@arm.com>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/14] arm64/mm: Add ptep_get_and_clear_full() to
 optimize process teardown
Date:   Mon, 27 Nov 2023 18:34:57 +1100
In-reply-to: <8fca9ed7-f916-4abe-8284-6e3c9fa33a8c@arm.com>
Message-ID: <87wmu3pro8.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYAPR01CA0045.ausprd01.prod.outlook.com (2603:10c6:1:1::33)
 To BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|PH8PR12MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef893ea-c676-4d2e-5515-08dbef1c91a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VfMcrhHY3j/ckxFYUrG4N+Ur8TZW1UJnEofjC+jRHXt1mvI1Sn/n6KJqvFW+ZHgE7IE3jLClh0MO2UnDeB3lKiUjAZnblVhcGxLvOXkH9kOuB3YQidkmIyh2CLcP48RzBmw/23cighEWe36TY9n9ZxmnRhDVbNfeITNpnebUh+1mqlGdeFBjPUuw/E7u/oGQxARLc5Mcmt9t+cN1/cvPkrQbdp91u9nzCTQWfGUaax6sDvRUf+lhn81jD96nVxG3nBXSY+shnhJx2hHNVEx3kli1I6Mi8bLbXYLnTQB6Ee3IRQ/rjHCGCuSqcJCIR75oTsimkU7WTe9K2OR5rqmXrFVw6tE2gsYyJkCt9NZBoYm4Rkfh/0vuoARVtkVnqkxi5CAsrqcPqggY5kCgsu4iqGTPDUnP2f9o4WcSKPOpOpq5HKhx4EX+HSJG2NyxNk03SDBxXBxR4rXaXrkgTH6o5ciXNz8LuJTmBP7/0xt9pCH54CRcKE5i76wZpxdMUyOfPI1XaVrBK7M0VzOlBjqoTTH/rX5eAWd08sPN1Q3erRTWT+s3S0UZesRKMmQXBaPj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(376002)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(6666004)(8676002)(4326008)(8936002)(6512007)(9686003)(53546011)(6506007)(66899024)(66476007)(66556008)(66946007)(54906003)(6916009)(316002)(6486002)(478600001)(2906002)(38100700002)(41300700001)(86362001)(26005)(7416002)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IMl20EqO9cEeOU4p4603jygbSPIYBsMD9biagJAq4QN06o4r/uFDgXI2TeBn?=
 =?us-ascii?Q?tR11ItU5yCDRwEj2UBLimVpEHytlDYtD9Mi7kUhTlo+1pZ0BH9LslG9Mdxc3?=
 =?us-ascii?Q?NQHv10+PFAMRDnu1Jj36XtMvvbtUap5lnriIRzaE/BQwhG7rq17XfjxuWK2W?=
 =?us-ascii?Q?1+fOCe8ItFBWFHwyVfGuKyUY/9ApE3cY1ICorY6j3DkAOVerFYqEVd2hoobz?=
 =?us-ascii?Q?0n5zrONWI3poH2F3OsFgNQ9i3hRZdKwzH0vsCDYZYkoXMOJpYa2HwN9MF6lR?=
 =?us-ascii?Q?0YUg8a9Yw5m0yy3XBJEIDME1isxs5t3kXGRFXscSLH9Sknftq7v9W6VenWMw?=
 =?us-ascii?Q?cxx9WEV5KiDO0ttBvCwKrE/gxhGWLxkFTRpNF+Hl1CnIJYMSS4aPZBYDgJBS?=
 =?us-ascii?Q?+GyHyqJ1c8VRxGfH8BndtbP4F2mWceQGylK+X8qt9Zgeqg7FsLBvEKbdFaj4?=
 =?us-ascii?Q?Qt2jDWrhEoE8mFPcWI2+hHo4813VbwRh1zewUweRNpe5M2eH25DeF7LrCEea?=
 =?us-ascii?Q?7oNjR7bWGuPJF6NendpImQfTmLCxNMcn7NLV48WVFDT5xG8q7/KgehqY1Kvr?=
 =?us-ascii?Q?6W1JtukKo50ugo6XUav6HwNfgWzIyGmTaLSSekJDS6eDJc3Nx60GoSuYwBLe?=
 =?us-ascii?Q?e75IqoEy4WckRMYytziWjJe34sjTQnRtQPp4QRkK1B2znwTqkCPgckkqjRBZ?=
 =?us-ascii?Q?NVNmLjpa4kyhS7c+MY4i404qaERJN3yFc36XWcKTTC/hpSpKMeXluAWzstBK?=
 =?us-ascii?Q?KBsxrmwp7IdUPOkoWoE148fYDWZyl944A2lfmI+eWCHD2/GYT/rhVF/sZJsW?=
 =?us-ascii?Q?PMY0ZkyAzRp9J2Hocl+yKItOYZIQU4h8vXpCakilJ/H6LIqbTx5gPZ8lDyr0?=
 =?us-ascii?Q?DukprgYGxkEThJpdKyViOrbHfZ4peH5LrXfpR5+IVJ+K+gYonrxH7Lb8OFOS?=
 =?us-ascii?Q?2ot5/FyY6wmVCZScZ9ACKmEn/00XhXlbtFRFQaIPkvfEUE+5nmCe8NUyjVdz?=
 =?us-ascii?Q?bePM2C3IjCBdYxG47Aw35KIxR2OloEOG1K4r8IOItCB0nAKeXD8f+uz5Qiqr?=
 =?us-ascii?Q?Gdv5vXUuK/+RMJLdl8jMC0kEK86at0TI1vzCNa7RwTRV37XNdTUrUH89ngPi?=
 =?us-ascii?Q?VnGNlaoBwamutfqijceFXTKdvguraME6pSpfFIU/q+RKyZfyp7ur5ybqFiUJ?=
 =?us-ascii?Q?HW/LdK1T8YD00I7FXTKYnmYCkUdD21n5bNCciZ2DMEb6uHbKqrOFq4yvIIU8?=
 =?us-ascii?Q?KDXeaMq7iAF89fAEsf+GzfPC4IegOgqmRAFJmHV75Ev11Lq4J2aYz7dVKEa4?=
 =?us-ascii?Q?z0kkdbAEU3QaAY/kyZpnurl9C7rWEcgfcJiq0P5jW7ANx2C2HBH1leeSm6j8?=
 =?us-ascii?Q?l2iV0hZPysswrn62EgHS7ByiM0KG4bbq5ZRl/Nd5qpo4n5shqSg7M46gxjR2?=
 =?us-ascii?Q?ZpS+0k8tsoCS6zfmU9rMx+cShnVHS9ZAp50HGzCdjbxSrnBY7B2R/+ibt9ha?=
 =?us-ascii?Q?DXUSmdXYVQk4/VkDSJIgkZmnOSVNjvDnU+WzegFCTKGxD3yfDDJiSSGNRqLj?=
 =?us-ascii?Q?pMAAfYzglJUzvMQR6r5ZV7UOyW7RN0sMBJUM3RyC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef893ea-c676-4d2e-5515-08dbef1c91a3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 07:43:38.6292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KOCFdg/l9cu5qdZyczeiGnompPcoiSs/cuxakSRHcSijT/7I9dbWNC59ls2z+nbyM/vyD6V4U2TiEW9vQENMXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6699
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ryan Roberts <ryan.roberts@arm.com> writes:

> On 24/11/2023 01:35, Alistair Popple wrote:
>> 
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>> 
>>> On 23/11/2023 05:13, Alistair Popple wrote:
>>>>
>>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>>
>>>>> ptep_get_and_clear_full() adds a 'full' parameter which is not present
>>>>> for the fallback ptep_get_and_clear() function. 'full' is set to 1 when
>>>>> a full address space teardown is in progress. We use this information to
>>>>> optimize arm64_sys_exit_group() by avoiding unfolding (and therefore
>>>>> tlbi) contiguous ranges. Instead we just clear the PTE but allow all the
>>>>> contiguous neighbours to keep their contig bit set, because we know we
>>>>> are about to clear the rest too.
>>>>>
>>>>> Before this optimization, the cost of arm64_sys_exit_group() exploded to
>>>>> 32x what it was before PTE_CONT support was wired up, when compiling the
>>>>> kernel. With this optimization in place, we are back down to the
>>>>> original cost.
>>>>>
>>>>> This approach is not perfect though, as for the duration between
>>>>> returning from the first call to ptep_get_and_clear_full() and making
>>>>> the final call, the contpte block in an intermediate state, where some
>>>>> ptes are cleared and others are still set with the PTE_CONT bit. If any
>>>>> other APIs are called for the ptes in the contpte block during that
>>>>> time, we have to be very careful. The core code currently interleaves
>>>>> calls to ptep_get_and_clear_full() with ptep_get() and so ptep_get()
>>>>> must be careful to ignore the cleared entries when accumulating the
>>>>> access and dirty bits - the same goes for ptep_get_lockless(). The only
>>>>> other calls we might resonably expect are to set markers in the
>>>>> previously cleared ptes. (We shouldn't see valid entries being set until
>>>>> after the tlbi, at which point we are no longer in the intermediate
>>>>> state). Since markers are not valid, this is safe; set_ptes() will see
>>>>> the old, invalid entry and will not attempt to unfold. And the new pte
>>>>> is also invalid so it won't attempt to fold. We shouldn't see this for
>>>>> the 'full' case anyway.
>>>>>
>>>>> The last remaining issue is returning the access/dirty bits. That info
>>>>> could be present in any of the ptes in the contpte block. ptep_get()
>>>>> will gather those bits from across the contpte block. We don't bother
>>>>> doing that here, because we know that the information is used by the
>>>>> core-mm to mark the underlying folio as accessed/dirty. And since the
>>>>> same folio must be underpinning the whole block (that was a requirement
>>>>> for folding in the first place), that information will make it to the
>>>>> folio eventually once all the ptes have been cleared. This approach
>>>>> means we don't have to play games with accumulating and storing the
>>>>> bits. It does mean that any interleaved calls to ptep_get() may lack
>>>>> correct access/dirty information if we have already cleared the pte that
>>>>> happened to store it. The core code does not rely on this though.
>>>>
>>>> Does not *currently* rely on this. I can't help but think it is
>>>> potentially something that could change in the future though which would
>>>> lead to some subtle bugs.
>>>
>>> Yes, there is a risk, although IMHO, its very small.
>>>
>>>>
>>>> Would there be any may of avoiding this? Half baked thought but could
>>>> you for example copy the access/dirty information to the last (or
>>>> perhaps first, most likely invalid) PTE?
>>>
>>> I spent a long time thinking about this and came up with a number of
>>> possibilities, none of them ideal. In the end, I went for the simplest one
>>> (which works but suffers from the problem that it depends on the way it is
>>> called not changing).
>> 
>> Ok, that answers my underlying question of "has someone thought about
>> this and are there any easy solutions". I suspected that was the case
>> given the excellent write up though!
>> 
>>> 1) copy the access/dirty flags into all the remaining uncleared ptes within the
>>> contpte block. This is how I did it in v1; although it was racy. I think this
>>> could be implemented correctly but its extremely complex.
>>>
>>> 2) batch calls from the core-mm (like I did for pte_set_wrprotects()) so that we
>>> can clear 1 or more full contpte blocks in a single call - the ptes are never in
>>> an intermediate state. This is difficult because ptep_get_and_clear_full()
>>> returns the pte that was cleared so its difficult to scale that up to multiple ptes.
>>>
>>> 3) add ptep_get_no_access_dirty() and redefine the interface to only allow that
>>> to be called while ptep_get_and_clear_full() calls are on-going. Then assert in
>>> the other functions that ptep_get_and_clear_full() is not on-going when they are
>>> called. So we would get a clear sign that usage patterns have changed. But there
>>> is no easy place to store that state (other than scanning a contpte block
>>> looking for pte_none() amongst pte_valid_cont() entries) and it all felt ugly.
>>>
>>> 4) The simple approach I ended up taking; I thought it would be best to keep it
>>> simple and see if anyone was concerned before doing something more drastic.
>>>
>>> What do you think? If we really need to solve this, then option 1 is my
>>> preferred route, but it would take some time to figure out and reason about a
>>> race-free scheme.
>> 
>> Well I like simple, and I agree the risk is small. But I can't help feel
>> the current situation is too subtle, mainly because it is architecture
>> specific and the assumptions are not communicated in core-mm code
>> anywhere. But also none of the aternatives seem much better.
>> 
>> However there are only three callers of ptep_get_and_clear_full(), and
>> all of these hold the PTL. So if I'm not mistaken that should exclude
>> just about all users of ptep_get*() which will take the ptl before hand.
>
> The problem isn't racing threads because as you say, the PTL is already
> serializing all calls except ptep_get_lockless(). And although there are 3
> callers to ptep_get_and_clear_full(), only the caller in zap_pte_range() ever
> calls it with full=1, as I recall.
>
> The problem is that the caller in zap_pte_range() does this:
>
> ptl = lock_page_table()
> for each pte {
> 	ptent = ptep_get(pte);
> 	if (pte_present(ptent) {
> 		ptent = ptep_get_and_clear_full(ptent);
> 		if (pte_dirty(ptent))
> 			...
> 		if (pte_young(ptent))
> 			...
> 	}
> }
> unlock_page_table(ptl)
>
> It deliberately interleves calls to ptep_get() and ptep_get_and_clear_full()
> under the ptl. So if the loop is iterating over a contpte block and the HW
> happens to be storing the access/dirty info in the first pte entry, then the
> first time through the loop, ptep_get() will return the correct access/dirty
> info, as will ptep_get_and_clear_full(). The next time through the loop though,
> the access/dirty info which was in the previous pte is now cleared so ptep_get()
> and ptep_get_and_clear_full() will return old/clean. It all works, but is fragile.

So if ptep_get_lockless() isn't a concern what made the option posted in
v1 racy (your option 1 above)? Is there something else reading PTEs or
clearing PTE bits without holding the PTL that I'm missing?

>> 
>> So really that only leaves ptep_get_lockless() that could/should
>> interleave right? 
>
> Yes, but ptep_get_lockless() is special. Since it is called without the PTL, it
> is very careful to ensure that the contpte block is in a consistent state and it
> keeps trying until it is. So this will always return the correct consistent
> information.
>
>> From a quick glance of those users none look at the
>> young/dirty information anyway, so I wonder if we can just assert in the
>> core-mm that ptep_get_lockless() does not return young/dirty information
>> and clear it in the helpers? That would make things explicit and
>> consistent which would address my concern (although I haven't looked too
>> closely at the details there).
>
> As per explanation above, its not ptep_get_lockless() that is the problem so I
> don't think this helps.
>
> Thanks,
> Ryan
>
>> 
>>> Thanks,
>>> Ryan
>> 

