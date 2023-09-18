Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB907A50DF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjIRRXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjIRRXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:23:09 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF95116
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:23:03 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0AC3D5C0080;
        Mon, 18 Sep 2023 13:23:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 18 Sep 2023 13:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1695057781; x=1695144181; bh=jV
        QBYyUTJJ4XZImO4TIi7G98RVRFmRGFf34VYApWKsE=; b=DtNkukzIOJ62UAnf6C
        KwefgWfUIwqrKygEjFOrzSE3ooTaNAtV3WPx3IUoER9uDpPOU3K637wOPoNWRBTg
        /eA72QSO5wTidirja8BeVTr396neEnId0eb4BWPMtw7qB4h7m3r3LuHY9gJihqPN
        LsHfvGYDREabYoeLTqFMKzogxqu75tA1XxuTz+g7sVYv4aRdIFBOkHDRTgK3lRuo
        PrkmPZyeOtHA02FiVZk1S4p7KDohNX8vJU1wns/ixbvDdxJboHggxZZrvgOHIej7
        KvUC5wn5BzIncIjd24ezQTjG4vye+uMSjZd778L+Fd5BXr4QTeFQPxiGJ5M/UnUY
        sGig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695057781; x=1695144181; bh=jVQBYyUTJJ4XZ
        ImO4TIi7G98RVRFmRGFf34VYApWKsE=; b=LCR516+Mdbgg4foFRNqTUNuQXxt5C
        AmY0ru7m8gWXUjXtAy/GcW/7mdAm6F1jtfQh0UlGMXlI6u0vowkU4Bqg+SE7b7HV
        ZvXtm6QuTl/0BqdGp4Qdq3kaJKNWnRB8YSaKXFWRZgQG5UEKcljMvvmPmUA6KktS
        NElPWfSygEe/PYsT1lN899qYhZxSaXH7H74xoFhpiFQDKnf2/9+Yk7M+kwGiIEbH
        WOsPeqo8VGxzJqiQtai+sBmlzaw9phR/TXNCAm86QAAwBzwIKPyu82kcmB13jEgG
        0oo/33O02n/E9d4vbYX30A+CSkAKcWiLuo9PPGAzQHyqYe0aDCv8EkDNA==
X-ME-Sender: <xms:dIcIZUgO7JLkw9h0k3tpTZr9EuG0ZKuZqljbnDvi04IjLirO3eOutA>
    <xme:dIcIZdDgrIWoiPgQkJXhzHiM_qOwRWTV7dmOjpMzuvhCe0kOGWq24yC9Zi8GYPT4B
    0APNlBmak5GotYcXSE>
X-ME-Received: <xmr:dIcIZcHwttOI1ov-qsWakyh4SWT7uZvTZK82XqVA-MRKU4uM34b6--RtMRzMzkR-kX8RX5y95qZhMglJL2No-yuj4pTpFYM4qwVMgv22wLqG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejkedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
    fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
    htthgvrhhnpeevlefggffhheduiedtheejveehtdfhtedvhfeludetvdegieekgeeggfdu
    geeutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:dIcIZVRUARYMfMPjKdS8ZAJARlCM3fq9Ed96WBZlpj-SJmL7KvRJdw>
    <xmx:dIcIZRwkCGJQaePw1FOlw1z8poQ1Tt44TUnzO5t88Bbr0X1OyVb36Q>
    <xmx:dIcIZT4knyB4F43j12zRIH6YLK_lCf9tDadS3hNxfW7zXZEHXcYHWA>
    <xmx:dYcIZUrVvBbNl09OLqTWZDXQJ4BUWkDLHvcObiXQRdqTL-FmC8DOXQ>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Sep 2023 13:22:59 -0400 (EDT)
References: <20230912175228.952039-1-shr@devkernel.io>
 <20230912175228.952039-2-shr@devkernel.io>
 <6447ab02-1a22-efe4-68c9-4f595e2499fc@redhat.com>
 <qvqwled3jvq2.fsf@devbig1114.prn1.facebook.com>
 <5bf3e7ad-b666-ae88-449a-074f17a9cbba@redhat.com>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 1/4] mm/ksm: add "smart" page scanning mode
Date:   Mon, 18 Sep 2023 10:22:09 -0700
In-reply-to: <5bf3e7ad-b666-ae88-449a-074f17a9cbba@redhat.com>
Message-ID: <qvqwo7hz4cr3.fsf@devbig1114.prn1.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

> On 18.09.23 18:18, Stefan Roesch wrote:
>> David Hildenbrand <david@redhat.com> writes:
>>
>>> On 12.09.23 19:52, Stefan Roesch wrote:
>>>> This change adds a "smart" page scanning mode for KSM. So far all the
>>>> candidate pages are continuously scanned to find candidates for
>>>> de-duplication. There are a considerably number of pages that cannot be
>>>> de-duplicated. This is costly in terms of CPU. By using smart scanning
>>>> considerable CPU savings can be achieved.
>>>> This change takes the history of scanning pages into account and skips
>>>> the page scanning of certain pages for a while if de-deduplication for
>>>> this page has not been successful in the past.
>>>> To do this it introduces two new fields in the ksm_rmap_item structure:
>>>> age and skip_age. age, is the KSM age and skip_page is the age for how
>>>> long page scanning of this page is skipped. The age field is incremented
>>>> each time the page is scanned and the page cannot be de-duplicated.
>>>> How often a page is skipped is dependent how often de-duplication has
>>>> been tried so far and the number of skips is currently limited to 8.
>>>> This value has shown to be effective with different workloads.
>>>> The feature is currently disable by default and can be enabled with the
>>>> new smart_scan knob.
>>>> The feature has shown to be very effective: upt to 25% of the page scans
>>>> can be eliminated; the pages_to_scan rate can be reduced by 40 - 50% and
>>>> a similar de-duplication rate can be maintained.
>>>> Signed-off-by: Stefan Roesch <shr@devkernel.io>
>>>> ---
>>>>    mm/ksm.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 75 insertions(+)
>>>> diff --git a/mm/ksm.c b/mm/ksm.c
>>>> index 981af9c72e7a..bfd5087c7d5a 100644
>>>> --- a/mm/ksm.c
>>>> +++ b/mm/ksm.c
>>>> @@ -56,6 +56,8 @@
>>>>    #define DO_NUMA(x)	do { } while (0)
>>>>    #endif
>>>>    +typedef u8 rmap_age_t;
>>>> +
>>>>    /**
>>>>     * DOC: Overview
>>>>     *
>>>> @@ -193,6 +195,8 @@ struct ksm_stable_node {
>>>>     * @node: rb node of this rmap_item in the unstable tree
>>>>     * @head: pointer to stable_node heading this list in the stable tree
>>>>     * @hlist: link into hlist of rmap_items hanging off that stable_node
>>>> + * @age: number of scan iterations since creation
>>>> + * @skip_age: skip rmap item until age reaches skip_age
>>>>     */
>>>>    struct ksm_rmap_item {
>>>>    	struct ksm_rmap_item *rmap_list;
>>>> @@ -212,6 +216,8 @@ struct ksm_rmap_item {
>>>>    			struct hlist_node hlist;
>>>>    		};
>>>>    	};
>>>> +	rmap_age_t age;
>>>> +	rmap_age_t skip_age;
>>>>    };
>>>>      #define SEQNR_MASK	0x0ff	/* low bits of unstable tree seqnr */
>>>> @@ -281,6 +287,9 @@ static unsigned int zero_checksum __read_mostly;
>>>>    /* Whether to merge empty (zeroed) pages with actual zero pages */
>>>>    static bool ksm_use_zero_pages __read_mostly;
>>>>    +/* Skip pages that couldn't be de-duplicated previously  */
>>>> +static bool ksm_smart_scan;
>>>> +
>>>>    /* The number of zero pages which is placed by KSM */
>>>>    unsigned long ksm_zero_pages;
>>>>    @@ -2305,6 +2314,45 @@ static struct ksm_rmap_item
>>>> *get_next_rmap_item(struct ksm_mm_slot *mm_slot,
>>>>    	return rmap_item;
>>>>    }
>>>>    +static unsigned int inc_skip_age(rmap_age_t age)
>>>> +{
>>>> +	if (age <= 3)
>>>> +		return 1;
>>>> +	if (age <= 5)
>>>> +		return 2;
>>>> +	if (age <= 8)
>>>> +		return 4;
>>>> +
>>>> +	return 8;
>>>> +}
>>>> +
>>>> +static bool skip_rmap_item(struct page *page, struct ksm_rmap_item *rmap_item)
>>>> +{
>>>> +	rmap_age_t age;
>>>> +
>>>> +	if (!ksm_smart_scan)
>>>> +		return false;
>>>> +
>>>> +	if (PageKsm(page))
>>>> +		return false;
>>>
>>>
>>> I'm a bit confused about this check here. scan_get_next_rmap_item() would return
>>> a PageKsm() page and call cmp_and_merge_page().
>>>
>>> cmp_and_merge_page() says: "first see if page can be merged into the stable
>>> tree"
>>>
>>> ... but shouldn't a PageKsm page *already* be in the stable tree?
>>>
>>> Maybe that's what cmp_and_merge_page() does via:
>>>
>>> 	kpage = stable_tree_search(page);
>>> 	if (kpage == page && rmap_item->head == stable_node) {
>>> 		put_page(kpage);
>>> 		return;
>>> 	}
>>>
>>>
>>> Hoping you can enlighten me :)
>>>
>> The above description sounds correct. During each scan we go through all
>> the candidate pages and this includes rmap_items that maps to KSM pages.
>> The above check simply skips these pages.
>
> Can we add a comment why we don't skip them? Like
>
> /*
>  * Never skip pages that are already KSM; pages cmp_and_merge_page()
>  * will essentially ignore them, but we still have to process them
>  * properly.
>  */
>

I'll add the comment in the next version.

>>
>>>> +
>>>> +	age = rmap_item->age++;
>>>
>>> Can't we overflow here? Is that desired, or would you want to stop at the
>>> maximum you can store?
>>>
>> Yes, we can overflow here and it was a deliberate choice. If we overflow
>> after we tried unsuccessfully for 255 times, we re-start with shorter
>> skip values, but that should be fine. In return we avoid an if statement.
>> The age is defined as unsigned.
>
> Can we make that explicit instead? Dealing with implicit overflows really makes
> the code harder to grasp.
>

I'll make it explicit.

>>
>>>> +	if (age < 3)
>>>> +		return false;
>>>> +
>>>> +	if (rmap_item->skip_age == age) {
>>>> +		rmap_item->skip_age = 0;
>>>> +		return false;
>>>> +	}
>>>> +
>>>> +	if (rmap_item->skip_age == 0) {
>>>> +		rmap_item->skip_age = age + inc_skip_age(age);
>>>
>>> Can't you overflow here as well?
>>>
>> Yes, you can. See the above discussion. This skip_age is also an
>> unsigned value.
>
> Dito.
>

I'll make it explicit.

>>
>>>> +		remove_rmap_item_from_tree(rmap_item);
>>>
>>>
>>> Can you enlighten me why that is required?
>>>
>> This is required for age calculation and BUG_ON check in
>> remove_rmap_item_from_tree. If we don't call remove_rmap_item_from_tree,
>> we will hit the BUG_ON for the skipped pages later on.
>
> I see, thanks!
