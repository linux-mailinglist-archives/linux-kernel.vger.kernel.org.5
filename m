Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47147A8FE5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 01:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjITXhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 19:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjITXhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 19:37:02 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2107.outbound.protection.outlook.com [40.107.237.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FE1C9;
        Wed, 20 Sep 2023 16:36:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lw3hErrs/lCsOo23xx9kAmhEhmmPQiwmIrnSZdC2yU8zOCix44rrfU+iQ3QGRWFB9Ir9i+yFWtZrEO7Qytk7BKQSVE0gkxs4x/VwvLkDi6Z3TPGI2xe1RDTGEko1Y7fZYo/iNIQjpkoz7RYd04AsZCw+XSoya+4jsH7ZsyFRPJIhPZaVK4vDUAwlgjKduD7x9Kggovq5wYVctj+dZBH28SEQ0Weg4Fju6XaGnVitJ2AVnWFIGb3zXstNQeqLqyPwQ5UBOjWOfB6jXFqvG6s8Sc2BKFScvvnyaj4yifxq3D62V0wrQl7xXaQr+utneSUZ9W0TDru8fHKPLzL+oQGwvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVR3sAt5G4gddB0r2BKr6RTM/Eo40DAbCK8tz+fH01g=;
 b=m+umrzUpt8SRkwBJ8hmz8e0ThbppVzBpYHl+UCRPhci/4fUq0mGSX00mq5uNkT+oYPuZENqZUrm5uNPeqwp8hmTQbT9LYf8hcECFcOfI7s8JJii4NLB9CTSOCV1wYQv7RZxlT2Qpvsm0NORFx5BxNcaYiIUWwYKhx3GnOWQ4sXdyFtct3fsE3ngVG5Tt2bD74PCARsErttH2GLd19pHMM2yGBoAvmcCcXWsREH+C16kaukSnw84/n+mCbl8fIG/xkb29Ca3/GjkZbXU6M/o/A9RBI+FZFwVMuTpN3dv6kFTwUpJejoOypBIUJpQhPnH1/nZHo9s/yHt/OMG8qOjW2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVR3sAt5G4gddB0r2BKr6RTM/Eo40DAbCK8tz+fH01g=;
 b=OiyaYI1eCYotWKDOnaqNxnNmX26C6/2spbDmoUPR5o/l9RF/BN3XOMB3OhRtj6epLNOkEW+/JUsWR6CH1uIJWe8JH1ICGC4JcNhvehJ3rZc1uq/obpc8EOlhVTVbKJ9I1XatIcZ7OUU1cr+KzQtzHGUfRqFlCB41VZlSVjpAR/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7492.prod.exchangelabs.com (2603:10b6:510:f3::6) by
 LV2PR01MB7862.prod.exchangelabs.com (2603:10b6:408:14e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.20; Wed, 20 Sep 2023 23:36:51 +0000
Received: from PH0PR01MB7492.prod.exchangelabs.com
 ([fe80::b6e2:2b48:ed1e:be72]) by PH0PR01MB7492.prod.exchangelabs.com
 ([fe80::b6e2:2b48:ed1e:be72%7]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 23:36:51 +0000
Message-ID: <0bd084b6-27be-4479-c22d-ba72923f1b78@os.amperecomputing.com>
Date:   Wed, 20 Sep 2023 16:36:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] mm: mempolicy: keep VMA walk if both MPOL_MF_STRICT and
 MPOL_MF_MOVE are specified
To:     hughd@google.com, surenb@google.com, willy@infradead.org,
        mhocko@suse.com, vbabka@suse.cz, osalvador@suse.de,
        aquini@redhat.com, kirill@shutemov.name, rientjes@google.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20230920223242.3425775-1-yang@os.amperecomputing.com>
Content-Language: en-US
From:   Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20230920223242.3425775-1-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::9) To PH0PR01MB7492.prod.exchangelabs.com
 (2603:10b6:510:f3::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7492:EE_|LV2PR01MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: d149cd7a-943a-4978-c499-08dbba327728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mVWr2CO6EZvD2+57fupAmN+zmvvUq9e2YS3UZ5A/iIfvURTFuIwH13bXSlq5+Ea50gF3ScLW3L0rUwz3v07zHohJST6RA8yOc1rY3rngDreauepBU7SlF5f8vBvdbdbSs7h35kuo00pjc7NXw9hpqstoxRJ8BuTdUOxo4bVGPVxm8KS3ELuD5UQKJuwpgWvliTfB1xMPgvjT5pFmz080huQcHOs4JilEzG6kiBkUPzKYjG5HymNgFT2INGi6WgvIYAxCilKzo5aKV6wFI6YCLJ2RpasbV0eq0LCHa2a9nxrhRVljvIRjL/F/1jOyG+EJDhyT05YYmOeZozb62/nJSM8yu3os4zxYbFyLptG2WquY+xkDNrF6ZFh0uKKgL0ke9Iez0nmbQ0HthhcHFR60e7da1PfJJuozyLHRvYQdkK1l4k56vDvqATFObuDqKAgEuCftTvP736iDB0uUGf4LIo57YPYIG7q0DM9omhXju6copkxk8cFGFJPaWxMjXMluYGO6w1g3III5MNtrAFvWDZ8nsum0C8v7rA4zmGUhnPOpFrkB3nOosSLI80StjmeCL3pLCfe3CWVu1nUKXNs00bVyfr9G4pA7QH8QpNa4XrQq5/11FGbDerdEeH/0wIys7TmlNqZ86FmLJQi9nu4IPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7492.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(346002)(39850400004)(1800799009)(186009)(451199024)(2906002)(7416002)(83380400001)(38100700002)(38350700002)(6506007)(6486002)(6512007)(5660300002)(6666004)(41300700001)(4326008)(8676002)(8936002)(52116002)(53546011)(31686004)(316002)(66556008)(66476007)(66946007)(478600001)(86362001)(31696002)(2616005)(26005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzFXL2t3OE12ZVZuanJYTHdSeTIvRTNSTmVNZkhoSVpqVXB4S2U0R0hkZ05q?=
 =?utf-8?B?Q1E5MkdVaENlcE9ZTUdyS2VTTUlxVWJRVmFZa25rWjhFV3RpWFVtZHdqR0c5?=
 =?utf-8?B?bysrZGh2RjBqS2JyK0gzTEZTNzZWWDhaNTNrc0RPNS9IblNYVjQ2cklBYlhv?=
 =?utf-8?B?bit3NTl3OUtBMk9sdzVYMGtMdEtSemVPQ2NRUEd3VmZJanpqaU9LSEhDWXB6?=
 =?utf-8?B?TG1DQWVhVFZQT05ieUtYSGdRcjRkNFhSMDZQTnNRTmNaMGh2WHBVMkhGSVBl?=
 =?utf-8?B?d0FZM0R1WlU1OTBRZEh6QWd5OXR4MHZZWU12eDR4cGowNzhISUowUDE0eHkx?=
 =?utf-8?B?T0JFZTZGK1M0dVhxNEFWTkNCcEtybDFma0NmQVNTbkhEQUsrRFovV3N5M1J3?=
 =?utf-8?B?Z0JYYjJrZzFFdk16dmVDMVo5SFpJejBSd2I0b2ZGeFVidmRITlFFcExCczNu?=
 =?utf-8?B?RTF2S1hmRGNkSEROZjlPUm5QOXI5MVJEVlBaR2ZMUGtORGI4ZHdKYlpZb2lY?=
 =?utf-8?B?NC9PV3ZDNEFLaUxzQUZmMzVPd2ZoQzFPWHZpa1RySUxmV3JxN3MxZWJuaG9h?=
 =?utf-8?B?cHZRWUZneFJ0UDBsdUdsd2VPNEplK0p4Z3AxYXFDdVBZWnpSbmNnU2x0NDVJ?=
 =?utf-8?B?QjN1V2l2aGhXV3ZLY0Zha0hseWQrWHFYbnFZcnRwc2kyMU41dnEvMldGVTl5?=
 =?utf-8?B?QlBuZTZNcXdENjlDdk9BS0xlM293bTZlamFYU1h6UmF3eFRsYWlGcTVVRmJu?=
 =?utf-8?B?SFdvT2tlTUM4cjQ3ZElaZVg5Z28xS3ZFUWpSbjdySWNVQjBJa0xsdTVSSjNS?=
 =?utf-8?B?b1hZZHdYbUxKRURGaHFqZGxuUWdTWW9abjRxSjZFczFSWWdPMjBtV3FQL0xI?=
 =?utf-8?B?cmdKTmZ3ZlVTckw2WFp5NmowUFoxRkpVOTZFaGozaE4wRVgvVEhZQlBJYXI5?=
 =?utf-8?B?T2dod2FIclpibUQvMkRQSVUxVWdHV3NYRFJlZTR2ZEl4TGVBWGQ1M0g2VkV0?=
 =?utf-8?B?cUFoMTVCd3hCZWNHOW5zdVFoZTNkZ0VYMHYwVDRhOCtFRXhXRWYzTVJqb0Yz?=
 =?utf-8?B?TUhjMzB3cHl5d2t2azdpZFAwQ3FRa2F2RnU4ZnJvRjZ0STVzbHBVbTRiSHFU?=
 =?utf-8?B?ZTkwVTNtSkpIK1NSajFYSEt3YXYzTUExYXBvMmM4RGw3STVVRTZkZ0d2LzUz?=
 =?utf-8?B?bWlibHFjMnUwMVZLYmtXWW93VzZsVG1vN0h1ZHJVazl1M0Zid0IvbHJWeWJP?=
 =?utf-8?B?Q0oxV05VV3JjZCtRNEFaR2p0MDFkcHZJdDhDcFAzLzM5K0h6U0YvS2ZndUhO?=
 =?utf-8?B?TlJYRm1PUGJXVXJ2U0Q1a1FCY3VwNGdxNVRBdHdDTGdNYmE0eUZGUjJybU5S?=
 =?utf-8?B?M0VrY01JUnR3K3hXazk3eHJMSG9uWThMZzNDOHhoYlNBa2ZTaytoS3IxRjRv?=
 =?utf-8?B?YmtKUmZsWUtsV295Y1Yrbm5vNmtab0J6dnIzZktLaHBMSTdUNmx1YzhWbXdO?=
 =?utf-8?B?RUp0MCtkVmJ6SktmTEZMYWpIMUZRclJuaE80U243b2xCalVZaEJIQW9WUzZ4?=
 =?utf-8?B?a1hVLzE0MXV3dzRrU1V3ZEZQa1FNenkxZGZIZGFma3lCbzl3QkJpQm04SEhV?=
 =?utf-8?B?RzFtYWZ4b1VZTHh1dzVzM0o4RUdveXI4R3RFcUswQS8wTFJlQitHZFJGcHJH?=
 =?utf-8?B?anJ0ODcxWjY2aHM3NjdhcFIweFZaalZIS21qVFFpbFkzTjJoWnNtTWV6TGJY?=
 =?utf-8?B?V0tjbDhYdEl6Q2QxdXBNRXRHNkFXaSt1YU4zTXdBWlIySzB6dHNNSXNmVGVt?=
 =?utf-8?B?cWY1azg5T1dUTzg3U2t0YksxY1JoUWlwSkIyTkVBU0d2WVhNcTVlMXhUWXhH?=
 =?utf-8?B?aXFzZFM5VDczQW5nQktKUTAzSU4ydURWNkUzbHQ0Y3IzNzNNY3N4dXZtVm8x?=
 =?utf-8?B?OW1UaTVNODQrQ09qWnBkZWNOSzllZm5VTVFvWGxsRE5aV3M2eERmUDg5TjZ4?=
 =?utf-8?B?bVpxRFFrRzBUTXpMVE9hTFFmK0ZYOGhnZC9NT2R6VVo1dFFNandwSFdHY2Rp?=
 =?utf-8?B?WVovT0Q0cjRod3k5dm0xeFBIK0xNZU81NDI4ZCtXTi90SmkxWkQvYTF6M3Rr?=
 =?utf-8?B?WGhxVDJ6TWg1YnQvcXpZdUpNUXhpZW9iZlovQmZDYWlReXd4dTVaQUp2Vmlw?=
 =?utf-8?Q?h8kRp0nHRX70JVlHiBZ8CyQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d149cd7a-943a-4978-c499-08dbba327728
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7492.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 23:36:51.4703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Idy2kIm8drOysklAfmDEWualR46kjHBkSIaDgy/o8z05cg9d52/nAlUa20xXqh043atEg0gu+Kckrh8+CSX+8DRpvNejywAKMzoxPoUcPo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7862
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/23 3:32 PM, Yang Shi wrote:
> When calling mbind() with MPOL_MF_{MOVE|MOVEALL} | MPOL_MF_STRICT,
> kernel should attempt to migrate all existing pages, and return -EIO if
> there is misplaced or unmovable page.  Then commit 6f4576e3687b
> ("mempolicy: apply page table walker on queue_pages_range()") messed up
> the return value and didn't break VMA scan early ianymore when MPOL_MF_STRICT
> alone.  The return value problem was fixed by commit a7f40cfe3b7a
> ("mm: mempolicy: make mbind() return -EIO when MPOL_MF_STRICT is specified"),
> but it broke the VMA walk early if unmovable page is met, it may cause some
> pages are not migrated as expected.
>
> The code should conceptually do:
>
>   if (MPOL_MF_MOVE|MOVEALL)
>       scan all vmas
>       try to migrate the existing pages
>       return success
>   else if (MPOL_MF_MOVE* | MPOL_MF_STRICT)
>       scan all vmas
>       try to migrate the existing pages
>       return -EIO if unmovable or migration failed
>   else /* MPOL_MF_STRICT alone */
>       break early if meets unmovable and don't call mbind_range() at all
>   else /* none of those flags */
>       check the ranges in test_walk, EFAULT without mbind_range() if discontig.
>
> Fixed the behavior.

Forgot the fixes.

Fixes: a7f40cfe3b7a ("mm: mempolicy: make mbind() return -EIO when 
MPOL_MF_STRICT is specified")

>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Rafael Aquini <aquini@redhat.com>
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Cc: David Rientjes <rientjes@google.com>
> Cc: <stable@vger.kernel.org> v4.9+
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
>   mm/mempolicy.c | 39 +++++++++++++++++++--------------------
>   1 file changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 42b5567e3773..f1b00d6ac7ee 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -426,6 +426,7 @@ struct queue_pages {
>   	unsigned long start;
>   	unsigned long end;
>   	struct vm_area_struct *first;
> +	bool has_unmovable;
>   };
>   
>   /*
> @@ -446,9 +447,8 @@ static inline bool queue_folio_required(struct folio *folio,
>   /*
>    * queue_folios_pmd() has three possible return values:
>    * 0 - folios are placed on the right node or queued successfully, or
> - *     special page is met, i.e. huge zero page.
> - * 1 - there is unmovable folio, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
> - *     specified.
> + *     special page is met, i.e. zero page, or unmovable page is found
> + *     but continue walking (indicated by queue_pages.has_unmovable).
>    * -EIO - is migration entry or only MPOL_MF_STRICT was specified and an
>    *        existing folio was already on a node that does not follow the
>    *        policy.
> @@ -479,7 +479,7 @@ static int queue_folios_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
>   	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
>   		if (!vma_migratable(walk->vma) ||
>   		    migrate_folio_add(folio, qp->pagelist, flags)) {
> -			ret = 1;
> +			qp->has_unmovable = true;
>   			goto unlock;
>   		}
>   	} else
> @@ -495,9 +495,8 @@ static int queue_folios_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
>    *
>    * queue_folios_pte_range() has three possible return values:
>    * 0 - folios are placed on the right node or queued successfully, or
> - *     special page is met, i.e. zero page.
> - * 1 - there is unmovable folio, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
> - *     specified.
> + *     special page is met, i.e. zero page, or unmovable page is found
> + *     but continue walking (indicated by queue_pages.has_unmovable).
>    * -EIO - only MPOL_MF_STRICT was specified and an existing folio was already
>    *        on a node that does not follow the policy.
>    */
> @@ -508,7 +507,6 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
>   	struct folio *folio;
>   	struct queue_pages *qp = walk->private;
>   	unsigned long flags = qp->flags;
> -	bool has_unmovable = false;
>   	pte_t *pte, *mapped_pte;
>   	pte_t ptent;
>   	spinlock_t *ptl;
> @@ -538,11 +536,12 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
>   		if (!queue_folio_required(folio, qp))
>   			continue;
>   		if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
> -			/* MPOL_MF_STRICT must be specified if we get here */
> -			if (!vma_migratable(vma)) {
> -				has_unmovable = true;
> -				break;
> -			}
> +			/*
> +			 * MPOL_MF_STRICT must be specified if we get here.
> +			 * Continue walking vmas due to MPOL_MF_MOVE* flags.
> +			 */
> +			if (!vma_migratable(vma))
> +				qp->has_unmovable = true;
>   
>   			/*
>   			 * Do not abort immediately since there may be
> @@ -550,16 +549,13 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
>   			 * need migrate other LRU pages.
>   			 */
>   			if (migrate_folio_add(folio, qp->pagelist, flags))
> -				has_unmovable = true;
> +				qp->has_unmovable = true;
>   		} else
>   			break;
>   	}
>   	pte_unmap_unlock(mapped_pte, ptl);
>   	cond_resched();
>   
> -	if (has_unmovable)
> -		return 1;
> -
>   	return addr != end ? -EIO : 0;
>   }
>   
> @@ -599,7 +595,7 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
>   		 * Detecting misplaced folio but allow migrating folios which
>   		 * have been queued.
>   		 */
> -		ret = 1;
> +		qp->has_unmovable = true;
>   		goto unlock;
>   	}
>   
> @@ -620,7 +616,7 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
>   			 * Failed to isolate folio but allow migrating pages
>   			 * which have been queued.
>   			 */
> -			ret = 1;
> +			qp->has_unmovable = true;
>   	}
>   unlock:
>   	spin_unlock(ptl);
> @@ -756,12 +752,15 @@ queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned long end,
>   		.start = start,
>   		.end = end,
>   		.first = NULL,
> +		.has_unmovable = false,
>   	};
>   	const struct mm_walk_ops *ops = lock_vma ?
>   			&queue_pages_lock_vma_walk_ops : &queue_pages_walk_ops;
>   
>   	err = walk_page_range(mm, start, end, ops, &qp);
>   
> +	if (qp.has_unmovable)
> +		err = 1;
>   	if (!qp.first)
>   		/* whole range in hole */
>   		err = -EFAULT;
> @@ -1358,7 +1357,7 @@ static long do_mbind(unsigned long start, unsigned long len,
>   				putback_movable_pages(&pagelist);
>   		}
>   
> -		if ((ret > 0) || (nr_failed && (flags & MPOL_MF_STRICT)))
> +		if (((ret > 0) || nr_failed) && (flags & MPOL_MF_STRICT))
>   			err = -EIO;
>   	} else {
>   up_out:

