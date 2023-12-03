Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A9B8028F2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 00:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbjLCXU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 18:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjLCXUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 18:20:25 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDADED3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 15:20:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYFf+Yw7UOjxwPIzBrJvbsLhiFe+KZhapOGi8gOVYxgE+jW6sMOan4OfM1RWT5M6Gmb9gFGUwjHeQ7ynTZgd99DYjP9pN/H7BpZgHCcFpkDCVADrX2c/QTx+ezNFiHNoPvTO1MmqKiRIHkP/sQ59WiFEKSeOjqLmXTx3pNP6ovu5xPv3nDUebL2budziSkTfPJN8lAQ1ByEK0MO81qBffWWrD8mIRGI3QfGclwaDrOVdJCs1lyex/gAKXkPIlJpvZPZEpvi7qMTzS2PpSWn1lTutOSwINsll+/NBAtbpiAp+13MDogxqCIYkun7eCLVOJ9RMcVZCbfQhG9jJHRXvoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhmiXubq6BgHJOohqUzgseLT+2D9AETxrXtipbD2Mms=;
 b=KdsE3Y8cu8feiMJAKg+edfTuGCT7afKGGqg0XPmHZcezkR5cWBx7O8B7Ynt+2SYwKWFpxBQTVNZaZkfDF4j9LWUwpf5gNN7fTghEygwSYGcqNJ03Eat9zyEC1hZdNFTQxe783KnoYy9byO34bCFmAAUHN5frH0BKtFIZ7ygwh4OSAtupQ4z/bPZaABmK2MJsjTZGx5NGGxD3bDUzT/hTN/4OdZElelwSmTKXLzs1Vrs/pxum7P+YL047t8OomaH3Xe6OAEwkIyVDB2+Y5DrKFCuQoDvzyVWSm8ntB009b2tMjQ91isKnntFhbvp+xkqqSbMWdT2Jo8xQKA0JBCcNRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhmiXubq6BgHJOohqUzgseLT+2D9AETxrXtipbD2Mms=;
 b=SqXe7oLJV+/pLqsxxpwOMtEj7OtJqcfpracBQCW04NWDLtVT3U+yE1pFwKfaclUM51PW1c7qegq3jaE2nYOh1T129qjMEx7N4Gkwfdq/b+gWg1D79ZfpBkcjyGrNKGnovnmhmHwrdgv6VJGmPAreF7H6HWZl9QzF5MPDfe2lfdd1feUcNGbQydQbFmJSxhCpnaqAgN6whyZCR0pdLmRyJno4F0teeBhO3csFSE221F7jQUO+u9JPMh9r37/5cjnRBz4EJtVkxpiC3sEjAwjLaFOVXGpwgzpC8UlVApHrY0OMLDEoMMQq/nD0h7rtEZpZV7Th1PsywMKTKZE/vUHYuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CH3PR12MB7692.namprd12.prod.outlook.com (2603:10b6:610:145::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Sun, 3 Dec
 2023 23:20:24 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6%7]) with mapi id 15.20.7046.033; Sun, 3 Dec 2023
 23:20:23 +0000
References: <20231115163018.1303287-1-ryan.roberts@arm.com>
 <20231115163018.1303287-15-ryan.roberts@arm.com>
 <87fs0xxd5g.fsf@nvdebian.thelocal>
 <3b4f6bff-6322-4394-9efb-9c3b9ef52010@arm.com>
 <87y1eovsn5.fsf@nvdebian.thelocal>
 <8fca9ed7-f916-4abe-8284-6e3c9fa33a8c@arm.com>
 <87wmu3pro8.fsf@nvdebian.thelocal>
 <26c78fee-4b7a-4d73-9f8b-2e25bbae20e8@arm.com>
 <87o7fepdun.fsf@nvdebian.thelocal>
 <b4906e1e-8009-4097-8d17-642374a049fe@arm.com>
 <b6d4b33b-6224-444f-9542-d3cb95afd382@arm.com>
 <87leafg768.fsf@nvdebian.thelocal>
 <9631b5bd-1d10-40bf-b4eb-9df33b9a0680@arm.com>
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
Date:   Mon, 04 Dec 2023 10:20:10 +1100
In-reply-to: <9631b5bd-1d10-40bf-b4eb-9df33b9a0680@arm.com>
Message-ID: <877cluc1qi.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0192.ausprd01.prod.outlook.com
 (2603:10c6:10:52::36) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|CH3PR12MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a4dc1d-7852-4b3e-ff07-08dbf4566c73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HSiraMbw+7pcZH6Bm7zsFNaBdx5U49PiTAHHKjmnGwWQM11D3KhY+k0GZdELoWf1E03MlBW2YzK8JV5L748kZ9PpO4BkcLTjY43StPd4teBI5C13lYd3eWFOCY8fgCDtPRmFWYGbWAO0qpS2HsqGo34IfHWZPnBbyEIIdIexmvVg25H7ptmlDPUs7MIog//MzhN2/l0dPvsOjKHekRdjTLYDk5vXS3ZV5ran0EN8b+ql/TwVkShVyyglr+yjqiSB0Rtv0Jl0+IIgWl7wDes3PU56whf7OmrdQSu8NUZYBxxpXstvRdZjWT2sOlEkOkRzVa3hjbitL03YMKTDOT1zcqNdfKaBXPAxMfD9iRlP883xaCzfBa0jkQy5pubQuci1EWMY5ZvgWb4xliHZqsh7rav4kMR/vOg+DkYo8NNliNUZyqRaJPvhyW4riALsFAm2WxKwh/ctB5TphtdbI/faoCkm8mb7XLHpFkG22zcBABCUpmra8l1AsAQBXrCv/EgmEIn/DFomKZunsKGdikqESEqJ+bN71ZE+gVy3klCPkbRF1o9J0xU3a+WnCU1U971r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(346002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(5660300002)(7416002)(86362001)(66899024)(4326008)(8676002)(8936002)(2906002)(30864003)(41300700001)(6512007)(9686003)(6506007)(53546011)(83380400001)(26005)(6486002)(478600001)(6666004)(38100700002)(316002)(54906003)(66476007)(6916009)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mp0oByrHxxPnHIKTyJy7bZ6+DVAGhsaHa5uO/+MnsHN7nampWeDD4MyGh3m/?=
 =?us-ascii?Q?CHBW8EFOzb3oSTmFaloaWKG6WE+Tb89oN94uIFGYEOeKxUIrpiN4XsqcRnUU?=
 =?us-ascii?Q?IGkcMvTuHf185tvcMZThFQ9oRtqPtiGQSSMf17FXmscaaRF9W3aya9SH3ka5?=
 =?us-ascii?Q?Q7JF3V/nSYSC3fMnkK1OTBbi/TSBZozBeSRDUA9WZcqTyl0aulHnBSPfbns7?=
 =?us-ascii?Q?+Te2ULSm5HvV92YWKjCwsBR3wxxsKiCe8i64ei9EtwhCvOanYh7KWPzQwdTz?=
 =?us-ascii?Q?jaETPC4LrAuH1mtztfVshtHdw6E2rlEnaBPjB8eS3jTUEB5C03t9AwouaVm1?=
 =?us-ascii?Q?Rd7Tp1GclL/uzzZyniVP2Eook3wpCPGBjn3c9Mj5m6VtWOIjQqttgynAuE/M?=
 =?us-ascii?Q?2WLjikL4+3m/l03ukteTEsEja6n1Kxx8DoyXXng9/xKom/lNFt5DYP4D+T01?=
 =?us-ascii?Q?rs1Z0z6I+PVmpvrQWURs4IC3tEey8LbsW71Ce/w2PfKXD707zerCXh8eihYl?=
 =?us-ascii?Q?2maWkBcd3LP0fczJ4RE6Zxgiyx3xQtvrQZf7K+kHZklcZQSGdxxWSAHg0Lm1?=
 =?us-ascii?Q?unJ+w0fFYkq4smRcO46EeOalJXup4wmm9x8DodKRB3QmQYxMszX1BqZYSRH7?=
 =?us-ascii?Q?j1Z6ClrUEUBR/9ENFiMth0BbvAAZGK9gbDFmpbqAGGDdHvJXpeRqfkRnwQDn?=
 =?us-ascii?Q?yWsFS37q5M4i/WVtdU0hkzvLZRtQochxmuhtCzKbdMMmkH/1dKN4JvUhmNWB?=
 =?us-ascii?Q?g53gsb59uwRlMrk/Bty7SkhwYqly3eqjvseJTXWwQ/FktO9MHILvdSLFVfh0?=
 =?us-ascii?Q?ndZDogZHPxu1PzOrsaZfHzyzHSKx6ldZk8Rv7H1E+K1VFaXuJx0v8VJWowJI?=
 =?us-ascii?Q?B4nGhbY7lkP6fwyAmE0RKUSPZ7O1ohOnJTlwkS5GMiX6GaEY/3KXGuDFYCRG?=
 =?us-ascii?Q?6R2G6l0TIbx6Ts5uL4GTe/u4YyZJeWIp3+zLN6i5oyUbCYol90355I2A7b6b?=
 =?us-ascii?Q?MJZ5KA5kswJP57Nw3Hb6Rjc8bbyzdWbzv9G64FPzT4FtV8CRs3FBsQu5xC29?=
 =?us-ascii?Q?uYncWDykKeUwTdR9SEEWh1NBt8+WXmzj67WWhw3Tk6kXOp+kqiKRGfK4z/JQ?=
 =?us-ascii?Q?nnkBMfoWUQ/U+MnSe0/JKNPX7b2nQiz+EKFJg/g9ZWqXl1420qmX66ARtm6t?=
 =?us-ascii?Q?iYzL+NeyVlm+zaCab1tNeSosYr5MB6Z/gqnI3oInLC/jC0MK9Ad3his0yOaR?=
 =?us-ascii?Q?XaDWyZWse2y7vwMhBOWPYkXEJAEnQMw/72wgLeLTdOGAf3a8MVuPaVqKEO+r?=
 =?us-ascii?Q?l2cxWdzHE14h8ctk4JiWxnuUHnDQQnT5HYHl0F0p08FsshU2ooluW8VLH/MB?=
 =?us-ascii?Q?Ykexq/G/nBfcCKkw3+Jod9SuizchLaNewgqQ381/t6me3VcfeLLNHAEYACUW?=
 =?us-ascii?Q?D7FN9/HUwwHV47K686ywE6Et8nGyh+gbpc40oJVoSf+rRg+YiZLYyOrCTJZh?=
 =?us-ascii?Q?RhX5ju3F4piBUaVxo0KBVT7LdGf5p3/l83IVa+bO8qH0AbtXrSpRnKWZ/9Yh?=
 =?us-ascii?Q?pzOtEXlvt+R1Qlw0+aIdA2usEusOPNE7nZar5Lkx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a4dc1d-7852-4b3e-ff07-08dbf4566c73
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2023 23:20:23.5145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 866FeHVwqDYrVzeG3oeObtQdA3RrTMM6NE2XGDrWnvA56LjkYzpZAAe3A1MTGvbSSrUVADhPck5ILmrL825P2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7692
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ryan Roberts <ryan.roberts@arm.com> writes:

> On 30/11/2023 05:07, Alistair Popple wrote:
>> 
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>> 
>>>>>> So if we do need to deal with racing HW, I'm pretty sure my v1 implementation is
>>>>>> buggy because it iterated through the PTEs, getting and accumulating. Then
>>>>>> iterated again, writing that final set of bits to all the PTEs. And the HW could
>>>>>> have modified the bits during those loops. I think it would be possible to fix
>>>>>> the race, but intuition says it would be expensive.
>>>>>
>>>>> So the issue as I understand it is subsequent iterations would see a
>>>>> clean PTE after the first iteration returned a dirty PTE. In
>>>>> ptep_get_and_clear_full() why couldn't you just copy the dirty/accessed
>>>>> bit (if set) from the PTE being cleared to an adjacent PTE rather than
>>>>> all the PTEs?
>>>>
>>>> The raciness I'm describing is the race between reading access/dirty from one
>>>> pte and applying it to another. But yes I like your suggestion. if we do:
>>>>
>>>> pte = __ptep_get_and_clear_full(ptep)
>>>>
>>>> on the target pte, then we have grabbed access/dirty from it in a race-free
>>>> manner. we can then loop from current pte up towards the top of the block until
>>>> we find a valid entry (and I guess wrap at the top to make us robust against
>>>> future callers clearing an an arbitrary order). Then atomically accumulate the
>>>> access/dirty bits we have just saved into that new entry. I guess that's just a
>>>> cmpxchg loop - there are already examples of how to do that correctly when
>>>> racing the TLB.
>>>>
>>>> For most entries, we will just be copying up to the next pte. For the last pte,
>>>> we would end up reading all ptes and determine we are the last one.
>>>>
>>>> What do you think?
>>>
>>> OK here is an attempt at something which solves the fragility. I think this is
>>> now robust and will always return the correct access/dirty state from
>>> ptep_get_and_clear_full() and ptep_get().
>>>
>>> But I'm not sure about performance; each call to ptep_get_and_clear_full() for
>>> each pte in a contpte block will cause a ptep_get() to gather the access/dirty
>>> bits from across the contpte block - which requires reading each pte in the
>>> contpte block. So its O(n^2) in that sense. I'll benchmark it and report back.
>>>
>>> Was this the type of thing you were thinking of, Alistair?
>> 
>> Yes, that is along the lines of what I was thinking. However I have
>> added a couple of comments inline. 
>> 
>>> --8<--
>>>  arch/arm64/include/asm/pgtable.h | 23 ++++++++-
>>>  arch/arm64/mm/contpte.c          | 81 ++++++++++++++++++++++++++++++++
>>>  arch/arm64/mm/fault.c            | 38 +++++++++------
>>>  3 files changed, 125 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>>> index 9bd2f57a9e11..6c295d277784 100644
>>> --- a/arch/arm64/include/asm/pgtable.h
>>> +++ b/arch/arm64/include/asm/pgtable.h
>>> @@ -851,6 +851,7 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>>>  	return pte_pmd(pte_modify(pmd_pte(pmd), newprot));
>>>  }
>>>
>>> +extern int __ptep_set_access_flags_notlbi(pte_t *ptep, pte_t entry);
>>>  extern int __ptep_set_access_flags(struct vm_area_struct *vma,
>>>  				 unsigned long address, pte_t *ptep,
>>>  				 pte_t entry, int dirty);
>>> @@ -1145,6 +1146,8 @@ extern pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte);
>>>  extern pte_t contpte_ptep_get_lockless(pte_t *orig_ptep);
>>>  extern void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
>>>  				pte_t *ptep, pte_t pte, unsigned int nr);
>>> +extern pte_t contpte_ptep_get_and_clear_full(struct mm_struct *mm,
>>> +				unsigned long addr, pte_t *ptep);
>>>  extern int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
>>>  				unsigned long addr, pte_t *ptep);
>>>  extern int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
>>> @@ -1270,12 +1273,28 @@ static inline void pte_clear(struct mm_struct *mm,
>>>  	__pte_clear(mm, addr, ptep);
>>>  }
>>>
>>> +#define __HAVE_ARCH_PTEP_GET_AND_CLEAR_FULL
>>> +static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
>>> +				unsigned long addr, pte_t *ptep, int full)
>>> +{
>>> +	pte_t orig_pte = __ptep_get(ptep);
>>> +
>>> +	if (!pte_valid_cont(orig_pte))
>>> +		return __ptep_get_and_clear(mm, addr, ptep);
>>> +
>>> +	if (!full) {
>>> +		contpte_try_unfold(mm, addr, ptep, orig_pte);
>>> +		return __ptep_get_and_clear(mm, addr, ptep);
>>> +	}
>>> +
>>> +	return contpte_ptep_get_and_clear_full(mm, addr, ptep);
>>> +}
>>> +
>>>  #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
>>>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>>  				unsigned long addr, pte_t *ptep)
>>>  {
>>> -	contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
>>> -	return __ptep_get_and_clear(mm, addr, ptep);
>>> +	return ptep_get_and_clear_full(mm, addr, ptep, 0);
>>>  }
>>>
>>>  #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
>>> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
>>> index 2a57df16bf58..99b211118d93 100644
>>> --- a/arch/arm64/mm/contpte.c
>>> +++ b/arch/arm64/mm/contpte.c
>>> @@ -145,6 +145,14 @@ pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte)
>>>  	for (i = 0; i < CONT_PTES; i++, ptep++) {
>>>  		pte = __ptep_get(ptep);
>>>
>>> +		/*
>>> +		 * Deal with the partial contpte_ptep_get_and_clear_full() case,
>>> +		 * where some of the ptes in the range may be cleared but others
>>> +		 * are still to do. See contpte_ptep_get_and_clear_full().
>>> +		 */
>>> +		if (!pte_valid(pte))
>>> +			continue;
>>> +
>>>  		if (pte_dirty(pte))
>>>  			orig_pte = pte_mkdirty(orig_pte);
>>>
>>> @@ -257,6 +265,79 @@ void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
>>>  }
>>>  EXPORT_SYMBOL(contpte_set_ptes);
>>>
>>> +pte_t contpte_ptep_get_and_clear_full(struct mm_struct *mm,
>>> +					unsigned long addr, pte_t *ptep)
>>> +{
>>> +	/*
>>> +	 * When doing a full address space teardown, we can avoid unfolding the
>>> +	 * contiguous range, and therefore avoid the associated tlbi. Instead,
>>> +	 * just get and clear the pte. The caller is promising to call us for
>>> +	 * every pte, so every pte in the range will be cleared by the time the
>>> +	 * final tlbi is issued.
>>> +	 *
>>> +	 * This approach requires some complex hoop jumping though, as for the
>>> +	 * duration between returning from the first call to
>>> +	 * ptep_get_and_clear_full() and making the final call, the contpte
>>> +	 * block is in an intermediate state, where some ptes are cleared and
>>> +	 * others are still set with the PTE_CONT bit. If any other APIs are
>>> +	 * called for the ptes in the contpte block during that time, we have to
>>> +	 * be very careful. The core code currently interleaves calls to
>>> +	 * ptep_get_and_clear_full() with ptep_get() and so ptep_get() must be
>>> +	 * careful to ignore the cleared entries when accumulating the access
>>> +	 * and dirty bits - the same goes for ptep_get_lockless(). The only
>>> +	 * other calls we might resonably expect are to set markers in the
>>> +	 * previously cleared ptes. (We shouldn't see valid entries being set
>>> +	 * until after the tlbi, at which point we are no longer in the
>>> +	 * intermediate state). Since markers are not valid, this is safe;
>>> +	 * set_ptes() will see the old, invalid entry and will not attempt to
>>> +	 * unfold. And the new pte is also invalid so it won't attempt to fold.
>>> +	 * We shouldn't see pte markers being set for the 'full' case anyway
>>> +	 * since the address space is being torn down.
>>> +	 *
>>> +	 * The last remaining issue is returning the access/dirty bits. That
>>> +	 * info could be present in any of the ptes in the contpte block.
>>> +	 * ptep_get() will gather those bits from across the contpte block (for
>>> +	 * the remaining valid entries). So below, if the pte we are clearing
>>> +	 * has dirty or young set, we need to stash it into a pte that we are
>>> +	 * yet to clear. This allows future calls to return the correct state
>>> +	 * even when the info was stored in a different pte. Since the core-mm
>>> +	 * calls from low to high address, we prefer to stash in the last pte of
>>> +	 * the contpte block - this means we are not "dragging" the bits up
>>> +	 * through all ptes and increases the chances that we can exit early
>>> +	 * because a given pte will have neither dirty or young set.
>>> +	 */
>>> +
>>> +	pte_t orig_pte = __ptep_get_and_clear(mm, addr, ptep);
>>> +	bool dirty = pte_dirty(orig_pte);
>>> +	bool young = pte_young(orig_pte);
>>> +	pte_t *start;
>>> +
>>> +	if (!dirty && !young)
>>> +		return contpte_ptep_get(ptep, orig_pte);
>> 
>> I don't think we need to do this. If the PTE is !dirty && !young we can
>> just return it. As you say we have to assume HW can set those flags at
>> any time anyway so it doesn't get us much. This means in the common case
>> we should only run through the loop setting the dirty/young flags once
>> which should alay the performance concerns.
>
> I don't follow your logic. This is precisely the problem I was trying to solve
> vs my original (simple) attempt - we want to always report the correct
> access/dirty info. If we read one of the PTEs and neither access nor dirty are
> set, that doesn't mean its old and clean, it just means that that info is
> definitely not stored in this PTE - we need to check the others. (when the
> contiguous bit is set, the HW will only update the access/dirty bits for 1 of
> the PTEs in the contpte block).

So my concern wasn't about incorrectly returning a !young && !dirty PTE
when the CONT_PTE block was *previously* clean/old (ie. the first
ptep_get/ptep_get_and_clear_full returned clean/old) because we have to
tolerate that anyway due to HW being able to set those bits. Rather my
concern was ptep_get_and_clear_full() could implicitly clear dirty/young
bits - ie. ptep_get_and_clear_full() could return a dirty/young PTE but
the next call would not.

That's because regardless of what we do here it is just a matter of
timing if we have to assume other HW threads can set these bits at any
time. There is nothing stopping HW from doing that just after we read
them in that loop, so a block can always become dirty/young at any time.
However it shouldn't become !dirty/!young without explicit SW
intervention.

But this is all a bit of a moot point due to the discussion below.

> Also, IIRC correctly, the core-mm sets access when initially setting up the
> mapping so its not guarranteed that all but one of the PTEs in the contpte block
> have (!dirty && !young).
>
>> 
>> However I am now wondering if we're doing the wrong thing trying to hide
>> this down in the arch layer anyway. Perhaps it would be better to deal
>> with this in the core-mm code after all.
>> 
>> So how about having ptep_get_and_clear_full() clearing the PTEs for the
>> entire cont block? We know by definition all PTEs should be pointing to
>> the same folio anyway, and it seems at least zap_pte_range() would cope
>> with this just fine because subsequent iterations would just see
>> pte_none() and continue the loop. I haven't checked the other call sites
>> though, but in principal I don't see why we couldn't define
>> ptep_get_and_clear_full() as being something that clears all PTEs
>> mapping a given folio (although it might need renaming).
>
> Ahha! Yes, I've been working on a solution like this since Barry raised it
> yesterday. I have a working version, that seems to perform well. I wouldn't want
> to just clear all the PTEs in the block inside ptep_get_and_clear_full() because
> although it might work today, its fragile in the same way that my v2 version is.

Yes, agree a new helper would be needed.

> Instead, I've defined a new helper, clear_ptes(), which takes a starting pte and
> a number of ptes to clear (like set_ptes()). It returns the PTE read from the
> *first* slot, but with the access/dirty bits being accumulated from all of the
> ptes in the requested batch. Then zap_pte_range() is reworked to find
> appropriate batches (similar to how I've reworked for ptep_set_wrprotects()).
>
> I was trying to avoid introducing new helpers, but I think this is the most
> robust approach, and looks slightly more performant to, on first sight. It also
> addresses cases where full=0, which Barry says are important for madvise(DONTNEED).

I strongly agree with this approach now especially if it is equally (or
more!) performant. I get why you didn't want to intorduce new helpers
but I think doing so was making things too subtle so would like to see
this.

>> 
>> This does assume you don't need to partially unmap a page in
>> zap_pte_range (ie. end >= folio), but we're already making that
>> assumption.
>
> That's fine for full=1. But we can't make that assumption for full=0. If a VMA
> gets split for a reason that doesn't require re-setting the PTEs then a contpte
> block could straddle 2 VMAs. But the solution I describe above is robust to that.
>
> I'll finish gathering perf data then post for all 3 approaches; v2 as originally
> posted, "robust ptep_get_and_clear_full()", and clear_ptes(). Hopefully later today.

Thanks!

>> 
>>> +
>>> +	start = contpte_align_down(ptep);
>>> +	ptep = start + CONT_PTES - 1;
>>> +
>>> +	for (; ptep >= start; ptep--) {
>>> +		pte_t pte = __ptep_get(ptep);
>>> +
>>> +		if (!pte_valid(pte))
>>> +			continue;
>>> +
>>> +		if (dirty)
>>> +			pte = pte_mkdirty(pte);
>>> +
>>> +		if (young)
>>> +			pte = pte_mkyoung(pte);
>>> +
>>> +		__ptep_set_access_flags_notlbi(ptep, pte);
>>> +		return contpte_ptep_get(ptep, orig_pte);
>>> +	}
>>> +
>>> +	return orig_pte;
>>> +}
>>> +EXPORT_SYMBOL(contpte_ptep_get_and_clear_full);
>>> +
>>>  int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
>>>  					unsigned long addr, pte_t *ptep)
>>>  {
>>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>>> index d63f3a0a7251..b22216a8153c 100644
>>> --- a/arch/arm64/mm/fault.c
>>> +++ b/arch/arm64/mm/fault.c
>>> @@ -199,19 +199,7 @@ static void show_pte(unsigned long addr)
>>>  	pr_cont("\n");
>>>  }
>>>
>>> -/*
>>> - * This function sets the access flags (dirty, accessed), as well as write
>>> - * permission, and only to a more permissive setting.
>>> - *
>>> - * It needs to cope with hardware update of the accessed/dirty state by other
>>> - * agents in the system and can safely skip the __sync_icache_dcache() call as,
>>> - * like __set_ptes(), the PTE is never changed from no-exec to exec here.
>>> - *
>>> - * Returns whether or not the PTE actually changed.
>>> - */
>>> -int __ptep_set_access_flags(struct vm_area_struct *vma,
>>> -			    unsigned long address, pte_t *ptep,
>>> -			    pte_t entry, int dirty)
>>> +int __ptep_set_access_flags_notlbi(pte_t *ptep, pte_t entry)
>>>  {
>>>  	pteval_t old_pteval, pteval;
>>>  	pte_t pte = __ptep_get(ptep);
>>> @@ -238,10 +226,30 @@ int __ptep_set_access_flags(struct vm_area_struct *vma,
>>>  		pteval = cmpxchg_relaxed(&pte_val(*ptep), old_pteval, pteval);
>>>  	} while (pteval != old_pteval);
>>>
>>> +	return 1;
>>> +}
>>> +
>>> +/*
>>> + * This function sets the access flags (dirty, accessed), as well as write
>>> + * permission, and only to a more permissive setting.
>>> + *
>>> + * It needs to cope with hardware update of the accessed/dirty state by other
>>> + * agents in the system and can safely skip the __sync_icache_dcache() call as,
>>> + * like __set_ptes(), the PTE is never changed from no-exec to exec here.
>>> + *
>>> + * Returns whether or not the PTE actually changed.
>>> + */
>>> +int __ptep_set_access_flags(struct vm_area_struct *vma,
>>> +			    unsigned long address, pte_t *ptep,
>>> +			    pte_t entry, int dirty)
>>> +{
>>> +	int changed = __ptep_set_access_flags_notlbi(ptep, entry);
>>> +
>>>  	/* Invalidate a stale read-only entry */
>>> -	if (dirty)
>>> +	if (changed && dirty)
>>>  		flush_tlb_page(vma, address);
>>> -	return 1;
>>> +
>>> +	return changed;
>>>  }
>>>
>>>  static bool is_el1_instruction_abort(unsigned long esr)
>>> --8<--
>> 

