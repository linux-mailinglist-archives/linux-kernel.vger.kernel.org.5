Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4CE7A4EBB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjIRQZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjIRQZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:25:35 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF68E349C0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:24:09 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id AC5ED5C01C8;
        Mon, 18 Sep 2023 12:24:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 18 Sep 2023 12:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1695054248; x=1695140648; bh=mS
        h+6yFymk+8t2ZvCakjo09NaTouimMN6aRfOJjtXTE=; b=suQsiiInODnxE9PA7S
        Rw447444KT4+kyVy4fT1k+Y9x+j0UWihopl0k4iK1Nr+G+THl8T7TBjPtEBdYEZZ
        8Uc3JfuRZ3Nzll3TFtzHm2p2KLVlFe2e0bxPetiBEO7YHxdzoE9VgOkwe3YkZpfY
        byEdF5g0JF5/XJOeujwiVzHaL1MSSeH2XZXkf/2CpqYIEOtGyjDJqSX2ADBZlwrz
        UVm+evCZ6GWItwsLS9NW/MGJLZD+66h4C1ZJRZYjTxVH1VT/90vV0wKFb7DED4lk
        gD6NPYYejQYbKQ8mhpMDEL3qXFGbH7e3ZFIgzHSiT0YjcKarguBnZ4jR78i44OAf
        2THw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695054248; x=1695140648; bh=mSh+6yFymk+8t
        2ZvCakjo09NaTouimMN6aRfOJjtXTE=; b=b0/5UtVEwOwuG68kaA1K0GSKKaVAx
        e9mDDzS2lMc6e7fZ5Y0B4h9v263EIvtzcrTUNxh8jv9RDDszguD7mPu69FmbNBf4
        dSZtSRQrUmlDXyD+PyZjid7D0vn0wOkyz27HMLdGo1+gJ9HssgEN9L9HdiSjLyZ/
        ZXP1K7O7YpDGMjyyIL3vhd3F6YOfM71x+Pjt2kCk8qMAipg6qg4rDP56v2QZ+aZ9
        UD6HO27EnwwYlNaIZaieKGeVAFkG4XESvI83Y0EZ46zuUkxXmVZdtHpYDk5VW30s
        DX1Q8faMUBxdfcQ3BR+cpLWyznNsRYUS+EnHtTVVfhXA+GHIZn6TVFqag==
X-ME-Sender: <xms:p3kIZfDB4DOkhQX8ikPeMlMI1MS4q5bno1DR-TueK7iJRb23uCbQag>
    <xme:p3kIZVhPJjb0ZW92lJysbzp70qj6D8dhbjNW4usaW4nfkhtLz1tzTba5QeNtt1ZOV
    5MDN8TE56smt4F1UXY>
X-ME-Received: <xmr:p3kIZakwGeazJjDvDydcP9F1sMcO5w_tSGu-ixE2t12ByNSw3f9-OV57ZtnJyoKT_QyIkaxZNq0l9QgOBoJBgxQIwUofaHGeYefUpSI4x_1ckA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejkedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
    fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
    htthgvrhhnpeevlefggffhheduiedtheejveehtdfhtedvhfeludetvdegieekgeeggfdu
    geeutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:p3kIZRz6IEka-l_huQnuCfAppz9k3wNgLgZIB1_pvQh4GTOeuUbV6w>
    <xmx:p3kIZURq09krnLprQSDwvhMVXDNOSYY7Ai5me3RHuZc5gjvsf6YjnA>
    <xmx:p3kIZUbzEyCSXAsfhEmPyxo8HyZMQr9OzV6ibbgSHhdVN6V2_HnWgg>
    <xmx:qHkIZZIQPpopg1Tx9q8sVfi0AXdKZbLRcubwwqaGOlbb2Uf44qO50Q>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Sep 2023 12:24:06 -0400 (EDT)
References: <20230912175228.952039-1-shr@devkernel.io>
 <20230912175228.952039-2-shr@devkernel.io>
 <6447ab02-1a22-efe4-68c9-4f595e2499fc@redhat.com>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 1/4] mm/ksm: add "smart" page scanning mode
Date:   Mon, 18 Sep 2023 09:18:27 -0700
In-reply-to: <6447ab02-1a22-efe4-68c9-4f595e2499fc@redhat.com>
Message-ID: <qvqwled3jvq2.fsf@devbig1114.prn1.facebook.com>
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

> On 12.09.23 19:52, Stefan Roesch wrote:
>> This change adds a "smart" page scanning mode for KSM. So far all the
>> candidate pages are continuously scanned to find candidates for
>> de-duplication. There are a considerably number of pages that cannot be
>> de-duplicated. This is costly in terms of CPU. By using smart scanning
>> considerable CPU savings can be achieved.
>> This change takes the history of scanning pages into account and skips
>> the page scanning of certain pages for a while if de-deduplication for
>> this page has not been successful in the past.
>> To do this it introduces two new fields in the ksm_rmap_item structure:
>> age and skip_age. age, is the KSM age and skip_page is the age for how
>> long page scanning of this page is skipped. The age field is incremented
>> each time the page is scanned and the page cannot be de-duplicated.
>> How often a page is skipped is dependent how often de-duplication has
>> been tried so far and the number of skips is currently limited to 8.
>> This value has shown to be effective with different workloads.
>> The feature is currently disable by default and can be enabled with the
>> new smart_scan knob.
>> The feature has shown to be very effective: upt to 25% of the page scans
>> can be eliminated; the pages_to_scan rate can be reduced by 40 - 50% and
>> a similar de-duplication rate can be maintained.
>> Signed-off-by: Stefan Roesch <shr@devkernel.io>
>> ---
>>   mm/ksm.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 75 insertions(+)
>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index 981af9c72e7a..bfd5087c7d5a 100644
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -56,6 +56,8 @@
>>   #define DO_NUMA(x)	do { } while (0)
>>   #endif
>>   +typedef u8 rmap_age_t;
>> +
>>   /**
>>    * DOC: Overview
>>    *
>> @@ -193,6 +195,8 @@ struct ksm_stable_node {
>>    * @node: rb node of this rmap_item in the unstable tree
>>    * @head: pointer to stable_node heading this list in the stable tree
>>    * @hlist: link into hlist of rmap_items hanging off that stable_node
>> + * @age: number of scan iterations since creation
>> + * @skip_age: skip rmap item until age reaches skip_age
>>    */
>>   struct ksm_rmap_item {
>>   	struct ksm_rmap_item *rmap_list;
>> @@ -212,6 +216,8 @@ struct ksm_rmap_item {
>>   			struct hlist_node hlist;
>>   		};
>>   	};
>> +	rmap_age_t age;
>> +	rmap_age_t skip_age;
>>   };
>>     #define SEQNR_MASK	0x0ff	/* low bits of unstable tree seqnr */
>> @@ -281,6 +287,9 @@ static unsigned int zero_checksum __read_mostly;
>>   /* Whether to merge empty (zeroed) pages with actual zero pages */
>>   static bool ksm_use_zero_pages __read_mostly;
>>   +/* Skip pages that couldn't be de-duplicated previously  */
>> +static bool ksm_smart_scan;
>> +
>>   /* The number of zero pages which is placed by KSM */
>>   unsigned long ksm_zero_pages;
>>   @@ -2305,6 +2314,45 @@ static struct ksm_rmap_item
>> *get_next_rmap_item(struct ksm_mm_slot *mm_slot,
>>   	return rmap_item;
>>   }
>>   +static unsigned int inc_skip_age(rmap_age_t age)
>> +{
>> +	if (age <= 3)
>> +		return 1;
>> +	if (age <= 5)
>> +		return 2;
>> +	if (age <= 8)
>> +		return 4;
>> +
>> +	return 8;
>> +}
>> +
>> +static bool skip_rmap_item(struct page *page, struct ksm_rmap_item *rmap_item)
>> +{
>> +	rmap_age_t age;
>> +
>> +	if (!ksm_smart_scan)
>> +		return false;
>> +
>> +	if (PageKsm(page))
>> +		return false;
>
>
> I'm a bit confused about this check here. scan_get_next_rmap_item() would return
> a PageKsm() page and call cmp_and_merge_page().
>
> cmp_and_merge_page() says: "first see if page can be merged into the stable
> tree"
>
> ... but shouldn't a PageKsm page *already* be in the stable tree?
>
> Maybe that's what cmp_and_merge_page() does via:
>
> 	kpage = stable_tree_search(page);
> 	if (kpage == page && rmap_item->head == stable_node) {
> 		put_page(kpage);
> 		return;
> 	}
>
>
> Hoping you can enlighten me :)
>

The above description sounds correct. During each scan we go through all
the candidate pages and this includes rmap_items that maps to KSM pages.
The above check simply skips these pages.

>> +
>> +	age = rmap_item->age++;
>
> Can't we overflow here? Is that desired, or would you want to stop at the
> maximum you can store?
>

Yes, we can overflow here and it was a deliberate choice. If we overflow
after we tried unsuccessfully for 255 times, we re-start with shorter
skip values, but that should be fine. In return we avoid an if statement.
The age is defined as unsigned.

>> +	if (age < 3)
>> +		return false;
>> +
>> +	if (rmap_item->skip_age == age) {
>> +		rmap_item->skip_age = 0;
>> +		return false;
>> +	}
>> +
>> +	if (rmap_item->skip_age == 0) {
>> +		rmap_item->skip_age = age + inc_skip_age(age);
>
> Can't you overflow here as well?
>

Yes, you can. See the above discussion. This skip_age is also an
unsigned value.

>> +		remove_rmap_item_from_tree(rmap_item);
>
>
> Can you enlighten me why that is required?
>

This is required for age calculation and BUG_ON check in
remove_rmap_item_from_tree. If we don't call remove_rmap_item_from_tree,
we will hit the BUG_ON for the skipped pages later on.

>> +	}
>> +
>> +	return true;
>> +}
>> +
