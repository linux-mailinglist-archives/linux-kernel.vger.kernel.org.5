Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3587F6A30
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 02:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjKXBhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 20:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKXBhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 20:37:06 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC89FD5E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 17:37:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1K+vP2n0BWSe/uy4fgdwu3GJpBpWLmO0fl7A41aUZy0hO2HsuOSc8cLcXMEhWsVa296HUWDXlLRdxZrtNen922Gcd5hOAUIG8RgLrwB8IZkjiZSLQNfUlM1TtNsmHn4KnOoa/pH3f5dXeModFTdRSvYiAMj7d0U4aB9fvlE6VjvmOsh/EJkTwCispZMGPALbmk+ClcqPTYrGYW39tSirAQGzHUNUcGAGm0Huwqia9eoUF5fq7wFfmy/Im+8Unl7XUubHoofAe15qnEpaReFolt4QTUJ+nYtqcnYUHVy3Ik33v+K2hUBsFj/mqr5Ledi/IapIIP5v4f8I9xcGkUyxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvmbO4I2dympCT/mU1uktCBEszR0uPFg7gGkKrM5n50=;
 b=VUW2vwHrpjndRvM3FMhLXGOrAUgkhO0rQztxTfKu683DM4X/csMyuKHbEj1gP9GJxzf6kakXct8AJtBW6HFLzGmxALuGdqvsecgzj7/iPDslVnnIHcM6ix8CtJgcD9U2F25lRWiBKBFdfLjOQLhKZ7yfFK6b8+GuBrxYoN8qpYIB3W/nXi2tuoWvkxW+FG+wsW9eKnxP/LkxrmoEup+qTSJE0Y91P+ryHOoOyR7Hwkp8r6sC9KRdXl8Ox3vy9HOAIK2ESFks5xlQt3ZlFE+njNnb2LmiS+7b3NKGlNVIza+rpNFeYralYioxHgT1zmUq5w4UgvKRTbsFzSWe1ZcygQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvmbO4I2dympCT/mU1uktCBEszR0uPFg7gGkKrM5n50=;
 b=Da/Hlea0Aarg6gNMZpMBjDdA/cxRbmPLq5GHNqao6qlGReIjLN4pJhIQm1EvEFn9X7y68Xq1+dzwxwLlip1rEusv3Grf7qVTlngBMiQkqtoA/URm3AtizODFPRFicjSxE82WMI81zw8ktfsc7VzX0Dew0y3Kik4+FHhKJJBUqkeWgEeEZO8xLjZCbulyzbRd/dkmQosa9s3IsVZmvUvV+il4dtkqYnrYl8tud7Uqrb7rJsH26IgfJsE0ELk9ezVEdOS2xs7lpxTuxRhCLxKEiVVWJBbIHG+FDAp6l6tzGNJFK6LU8RJYxIQHhY70cPVIDQtj+NaFLzYAxlulYc8epw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CY8PR12MB8362.namprd12.prod.outlook.com (2603:10b6:930:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Fri, 24 Nov
 2023 01:37:09 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6%7]) with mapi id 15.20.7025.020; Fri, 24 Nov 2023
 01:37:09 +0000
References: <20231115163018.1303287-1-ryan.roberts@arm.com>
 <20231115163018.1303287-15-ryan.roberts@arm.com>
 <87fs0xxd5g.fsf@nvdebian.thelocal>
 <3b4f6bff-6322-4394-9efb-9c3b9ef52010@arm.com>
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
Date:   Fri, 24 Nov 2023 12:35:30 +1100
In-reply-to: <3b4f6bff-6322-4394-9efb-9c3b9ef52010@arm.com>
Message-ID: <87y1eovsn5.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0076.ausprd01.prod.outlook.com
 (2603:10c6:10:1f5::6) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|CY8PR12MB8362:EE_
X-MS-Office365-Filtering-Correlation-Id: f7070b62-863e-48fe-289b-08dbec8dde9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lz+GN2mTRRc5SiWTEj5SqhUAj+3lotlMjVmNU7SX3Nct2HIiJE4qgySTkGJ0tV97vDYYOFrO1txofuFSQgWgQoMIucvL0np3YVtQHSPCrUZsk7kgNcaI9Et7RfpCewbpw8/KnoHlYTd/s0i/PVz19OrHOW8BKYuHI10v/96aZ+8fwOXjwZBEb8iqrX0xq/lhDuRNrpQz5eDa42itB67t6dnN/upzjNs3Lt/GqA68sFeRATQwsIEF+an47ihz0tQj1r6raNCHT+TVNr7Y4yadZXF1JJzFYrZo+lVcc3pTSPNtnpJZ/2misaUEuF3UHDQ/ONrQ8mxVLV84clbVHrbN5MXlcz6ruX2Bndu1xr4QSPuWHyJZcPG5CECSoU55z88MTICtM76D2IlpO/WrZ70Yqz0f7VAU1R+g3AVrsydBFpSyf0WRKhyH9OD9m+XH6/9OZPJzEBGPCvGS/ITKtypZ8nW1RMqCFB2jj2Fkts5j5/FT/JQxPHDKbICFmSEjFiGiYRhQyHINzmFbtrHRWdvmjm3lkCxmgbiWe9l6c48QqszBTSIEJM2vgOUA7ffSz0bS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(7416002)(6666004)(4326008)(8676002)(8936002)(2906002)(86362001)(5660300002)(41300700001)(38100700002)(66899024)(6916009)(26005)(83380400001)(6512007)(9686003)(478600001)(6506007)(53546011)(6486002)(66476007)(66556008)(316002)(54906003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M5tdhscV4DzKk6mfgj3aVbSuAvFtYBiRicsN65RHRO9RrUwqQ2p1tqeUcVIV?=
 =?us-ascii?Q?c8PuXL3BIEXm2yYlNQHEflAnqJjPzRW9hUq0DjxgJ+mpvvHOb9Vg3OBwz1/t?=
 =?us-ascii?Q?oc+uj+miRtPN32Ag16x2qnfdPtegVnlfKYobfrKgAcUojSRuCQc5aPz2sxxr?=
 =?us-ascii?Q?kq+CayRoB9Hnwmbws6EDTsXYulztHmgSJ2X0P5i8FKZBOLD6xu3TM1c9iBn5?=
 =?us-ascii?Q?ccDlT8ag+Gpk8BzRAY7VFaW1jHJpGNnZcf+6wdcgBQsvNH1FaEGgYVkEy395?=
 =?us-ascii?Q?k7uw/YwC0y6HDwjy7sCj2E7nA0TN4IkWyTBID8QKu1GMU2KN+JDNnb1wVLBg?=
 =?us-ascii?Q?hzBXzQitjvKIvQFj0yjft/JiRhT4UxfVU2ddSJgLxR56isG/Rsmq2tdZuuya?=
 =?us-ascii?Q?Lnz75nBWkjW+UsWBSCLaIFNivXWjfVgkq5hnoH2vZfAVG/LsCqm/SScdUaNH?=
 =?us-ascii?Q?WFe35vQt89FuGunCKtjSZBRRb3Jx0N6xLlnOKmyuKdUEPqoUxG/D7Qu9B7Tk?=
 =?us-ascii?Q?hMmhRYDw3Yr+NzD0IdXcOt3solWouX8wvPlS58wa1Wo+qO1W18+53QdD8SIA?=
 =?us-ascii?Q?3e7xF3OPva+1sQj4yFPHZr+/RAR1xCCZ2PEq5Q0Yq2jzjRk+LgFxbv4It4lm?=
 =?us-ascii?Q?C8vWNXQx/ljgCTjPzFfPeYfNojFT/J4pq8UyTQr4bfP3TqA6c2BXnEqp5qh3?=
 =?us-ascii?Q?DWgAaRVqah1BNHuZzowdtVOURoGAlb/5ecxcs7nXliKpNz3CBXcIK3HjEGC6?=
 =?us-ascii?Q?BNDA0GKnqtK0YtFz/cgizXznbp2rfMmsVtFVdS61cm6suJENzklpbQgKP2Te?=
 =?us-ascii?Q?fVvIXdhKmJivpynVXSTLb9vzBSDlfDw3pUam6Nwx3B6Suvhs6sVa2PZpxRcL?=
 =?us-ascii?Q?BrXMjdgT9XngtuKFe2Q9UkZKYrHyznd+jUsTIQjeC0aCOOzTLlT2bRB8U6R9?=
 =?us-ascii?Q?pFcToCWjCnTdltbxy8VFOX3aecG7hH+2zuQ+8zbztC1Tge+cB9M+8CI8GUjd?=
 =?us-ascii?Q?s+/slaPKb6Jhpgo1Q5eJXep0NxprK5nheHs40sr6TR4e6/5gSqX8XsO2MCKa?=
 =?us-ascii?Q?oL8a6CVr41xCxdfL+sQYkY4dBU06IEXO6HWIoWkg6K0zcDFPSkFHX18S0msV?=
 =?us-ascii?Q?Irdtg1i0s2zEfoCipAUE27Co0XZrmBJnGxedqosv8B5SIgYDlzN91sM+pA36?=
 =?us-ascii?Q?eh6fWJ3o2wta2iBvEfW4V8rVQXIHer7X6r21I3fx0DASboYFBuJaXEKkU2I5?=
 =?us-ascii?Q?1hd+6PI0MEvNtrPaXrqvlknOrKKW/BDGm6lxBx2vQjOvbVg/M2RQgt+LMZA7?=
 =?us-ascii?Q?pUbY/qpqK7zCkGrvMzAd62W5GOZKAGjpL/Ndz3p5ctV0pGxSNZUD/azmw2bb?=
 =?us-ascii?Q?OLrW3zFfJG5zLpJO68fmIIIXFtltuPyoRkGJotgGHP+9Y9ebdyLchx+Q8Iro?=
 =?us-ascii?Q?oV/qeDfjFeTZGk3BwQK79viHj94uhghOBrxMfilpy1qxa3cR+ObMCInviEYW?=
 =?us-ascii?Q?tgo6hhLDT1cyf525GWyRqIvoVmrB5GV6lHVWuHv8F3biKY2e+CgaXEAlDAdk?=
 =?us-ascii?Q?5D05LIc6Hg6L38bYxwZaim+OPsjORg6DpXaDqPy4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7070b62-863e-48fe-289b-08dbec8dde9d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 01:37:08.2080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/0sgeOzI+GGR6tVnH1IuH9SblclhlnIsMFmcopRAE9qoxjoN2T6p/XLbUvO+DTCSID2mK9npQdkYJ4l2GFPZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8362
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ryan Roberts <ryan.roberts@arm.com> writes:

> On 23/11/2023 05:13, Alistair Popple wrote:
>> 
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>> 
>>> ptep_get_and_clear_full() adds a 'full' parameter which is not present
>>> for the fallback ptep_get_and_clear() function. 'full' is set to 1 when
>>> a full address space teardown is in progress. We use this information to
>>> optimize arm64_sys_exit_group() by avoiding unfolding (and therefore
>>> tlbi) contiguous ranges. Instead we just clear the PTE but allow all the
>>> contiguous neighbours to keep their contig bit set, because we know we
>>> are about to clear the rest too.
>>>
>>> Before this optimization, the cost of arm64_sys_exit_group() exploded to
>>> 32x what it was before PTE_CONT support was wired up, when compiling the
>>> kernel. With this optimization in place, we are back down to the
>>> original cost.
>>>
>>> This approach is not perfect though, as for the duration between
>>> returning from the first call to ptep_get_and_clear_full() and making
>>> the final call, the contpte block in an intermediate state, where some
>>> ptes are cleared and others are still set with the PTE_CONT bit. If any
>>> other APIs are called for the ptes in the contpte block during that
>>> time, we have to be very careful. The core code currently interleaves
>>> calls to ptep_get_and_clear_full() with ptep_get() and so ptep_get()
>>> must be careful to ignore the cleared entries when accumulating the
>>> access and dirty bits - the same goes for ptep_get_lockless(). The only
>>> other calls we might resonably expect are to set markers in the
>>> previously cleared ptes. (We shouldn't see valid entries being set until
>>> after the tlbi, at which point we are no longer in the intermediate
>>> state). Since markers are not valid, this is safe; set_ptes() will see
>>> the old, invalid entry and will not attempt to unfold. And the new pte
>>> is also invalid so it won't attempt to fold. We shouldn't see this for
>>> the 'full' case anyway.
>>>
>>> The last remaining issue is returning the access/dirty bits. That info
>>> could be present in any of the ptes in the contpte block. ptep_get()
>>> will gather those bits from across the contpte block. We don't bother
>>> doing that here, because we know that the information is used by the
>>> core-mm to mark the underlying folio as accessed/dirty. And since the
>>> same folio must be underpinning the whole block (that was a requirement
>>> for folding in the first place), that information will make it to the
>>> folio eventually once all the ptes have been cleared. This approach
>>> means we don't have to play games with accumulating and storing the
>>> bits. It does mean that any interleaved calls to ptep_get() may lack
>>> correct access/dirty information if we have already cleared the pte that
>>> happened to store it. The core code does not rely on this though.
>> 
>> Does not *currently* rely on this. I can't help but think it is
>> potentially something that could change in the future though which would
>> lead to some subtle bugs.
>
> Yes, there is a risk, although IMHO, its very small.
>
>> 
>> Would there be any may of avoiding this? Half baked thought but could
>> you for example copy the access/dirty information to the last (or
>> perhaps first, most likely invalid) PTE?
>
> I spent a long time thinking about this and came up with a number of
> possibilities, none of them ideal. In the end, I went for the simplest one
> (which works but suffers from the problem that it depends on the way it is
> called not changing).

Ok, that answers my underlying question of "has someone thought about
this and are there any easy solutions". I suspected that was the case
given the excellent write up though!

> 1) copy the access/dirty flags into all the remaining uncleared ptes within the
> contpte block. This is how I did it in v1; although it was racy. I think this
> could be implemented correctly but its extremely complex.
>
> 2) batch calls from the core-mm (like I did for pte_set_wrprotects()) so that we
> can clear 1 or more full contpte blocks in a single call - the ptes are never in
> an intermediate state. This is difficult because ptep_get_and_clear_full()
> returns the pte that was cleared so its difficult to scale that up to multiple ptes.
>
> 3) add ptep_get_no_access_dirty() and redefine the interface to only allow that
> to be called while ptep_get_and_clear_full() calls are on-going. Then assert in
> the other functions that ptep_get_and_clear_full() is not on-going when they are
> called. So we would get a clear sign that usage patterns have changed. But there
> is no easy place to store that state (other than scanning a contpte block
> looking for pte_none() amongst pte_valid_cont() entries) and it all felt ugly.
>
> 4) The simple approach I ended up taking; I thought it would be best to keep it
> simple and see if anyone was concerned before doing something more drastic.
>
> What do you think? If we really need to solve this, then option 1 is my
> preferred route, but it would take some time to figure out and reason about a
> race-free scheme.

Well I like simple, and I agree the risk is small. But I can't help feel
the current situation is too subtle, mainly because it is architecture
specific and the assumptions are not communicated in core-mm code
anywhere. But also none of the aternatives seem much better.

However there are only three callers of ptep_get_and_clear_full(), and
all of these hold the PTL. So if I'm not mistaken that should exclude
just about all users of ptep_get*() which will take the ptl before hand.

So really that only leaves ptep_get_lockless() that could/should
interleave right? From a quick glance of those users none look at the
young/dirty information anyway, so I wonder if we can just assert in the
core-mm that ptep_get_lockless() does not return young/dirty information
and clear it in the helpers? That would make things explicit and
consistent which would address my concern (although I haven't looked too
closely at the details there).

> Thanks,
> Ryan

