Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606357AE44B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 05:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjIZDxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 23:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjIZDxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 23:53:05 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EA1DD
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 20:52:58 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 9D87D3200A62;
        Mon, 25 Sep 2023 23:52:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 25 Sep 2023 23:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1695700374; x=1695786774; bh=n5
        F6m7owvTyikPwb8qUq8E6SUtaRPWY4heCu/VudUyI=; b=xpr6rCnOy+rlnHBCVH
        iC3XmoPJ7a0Qe+xqvyxOhQz4pcCWQGE0apFZ4BnRu2KhgeuOrltfJN1AozXjsukT
        G7bU9HxYRehf1g/L5VdazF8WmkUphloNcHlXhXxNn4ck2Ec0hypXkFGYOAZgnvjJ
        rp130MFz6t+7v3GxhAi+k71QSHV+1hlJv4aIFmpVT1JL/Y8+kOx67phU8xyLLAzN
        WbRf8j5OY6cXWsIyQjpYoDmimJF3xd3RYpqhDuCuAwrHEYyK2Cm6y5hP3SXqSn53
        YqYkRon8hwtHIt7Q3QXjnqN+NXR1j77wnM5I9Gkkwi08y19qhzlnGDZaMQOyLN4R
        UJWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695700374; x=1695786774; bh=n5F6m7owvTyik
        Pwb8qUq8E6SUtaRPWY4heCu/VudUyI=; b=Doal7zx+qrN7JLg3BU7kNHBbpslwr
        Uu/xPJcuBMTzoMUkDBVUcAPs9TQAR0vCsO0UZJd8wlkf+99pTbjiWpvq2yT+sU93
        mAJyHpTbzGF8sKofb/A0IWQf5giUgnWe28z9RBUOIjqMzEx2jlbCrjP/eFiDe+TO
        p3pidDwbJ86wDMZovKsGphg0wTlD0brL2Ex+o3HbeI6HufgLWnTX4vQMpNgWGd3O
        2EJyHItMYcasvqhumLeGWgAL1Ow0eiEq0bJdKQQnlh7mKfGdJn1CnMDNmB/JYmHU
        6mZXnNPqfQOTcbDixV9kkLF6Z3QTw5foPEZbYI+/nDQxWUxDOuwnhhk+w==
X-ME-Sender: <xms:lVUSZcGNBCbpTqq3H7GBE9JjrscYWw0asMGSEkA-U_prjqm7eYVRlg>
    <xme:lVUSZVXdLZtNUA1qPhtMw2ahZepDy0D1976_qz27EXl7hN_XGHULH71UJDgRxP1ek
    lJckzhnMjLPWfmbyoI>
X-ME-Received: <xmr:lVUSZWLzHf9a49IKSNBDLCBDWIq1mRjPz34GhMglATsL5d-kBxSLnwwkS4j_6Thvt5zG9CX2d-nDr-ObhyMSuvUGJaeCwl4yvkd2XuzvThaf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelhedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfhgfhffvvefuffgjkfggtgesthdtredttdertdenucfhrhhomhepufhtvghf
    rghnucftohgvshgthhcuoehshhhrseguvghvkhgvrhhnvghlrdhioheqnecuggftrfgrth
    htvghrnhepveelgffghfehudeitdehjeevhedthfetvdfhledutedvgeeikeeggefgudeg
    uedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    hhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:lVUSZeEYpidBllSbDYpdXVY9ibpkVnptzhE0ZJ4IJRXPlObFp7S0pg>
    <xmx:lVUSZSWCwmW50xjFX-wrscMy9Z5QFBC92QYLKN-xnk1b5QZjnPH0rw>
    <xmx:lVUSZRNEwaW6hDbOmpvGGbfK-ZMbgijaoP6ope7A3krHbXUCsW_S6A>
    <xmx:llUSZUcE0S1c5fJrh0FH8dkdi5RgbpTcbT8LG8CcmRd5AYeTgKVzKQ>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Sep 2023 23:52:52 -0400 (EDT)
References: <20230918185816.1518366-1-shr@devkernel.io>
 <20230918185816.1518366-2-shr@devkernel.io>
 <b8d98257-ae01-4163-a4a7-ecd3dbee7325@redhat.com>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/4] mm/ksm: add "smart" page scanning mode
Date:   Mon, 25 Sep 2023 20:52:09 -0700
In-reply-to: <b8d98257-ae01-4163-a4a7-ecd3dbee7325@redhat.com>
Message-ID: <qvqwbkdp4mlq.fsf@devbig1114.prn1.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

>> +typedef u8 rmap_age_t;
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
>
> I *think* of you move that after "oldchecksum", the size of the struct might not
> necessarily increase.
>
> [...]
>
>>   +/*
>> + * Calculate skip age for the ksm page age. The age determines how often
>> + * de-duplicating has already been tried unsuccessfully. If the age is
>> + * smaller, the scanning of this page is skipped for less scans.
>> + *
>> + * @age: rmap_item age of page
>> + */
>> +static unsigned int skip_age(rmap_age_t age)
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
>> +/*
>> + * Determines if a page should be skipped for the current scan.
>> + *
>> + * @page: page to check
>> + * @rmap_item: associated rmap_item of page
>> + */
>> +static bool should_skip_rmap_item(struct page *page,
>> +				  struct ksm_rmap_item *rmap_item)
>> +{
>> +	rmap_age_t age;
>> +
>> +	if (!ksm_smart_scan)
>> +		return false;
>> +
>> +	/*
>> +	 * Never skip pages that are already KSM; pages cmp_and_merge_page()
>> +	 * will essentially ignore them, but we still have to process them
>> +	 * properly.
>> +	 */
>> +	if (PageKsm(page))
>> +		return false;
>> +
>> +	/*
>> +	 * Smaller ages are not skipped, they need to get a chance to go
>> +	 * through the different phases of the KSM merging.
>> +	 */
>
> Sorry, had to set some time aside to think this through. Wouldn't it be cleaner
> to just not rely on this overflow?
>
> Instead, we could track the page age (which we would freeze at U8_MAX) and
> simply track how much more often we are allowed to skip.
>
> Something like the following (which, I am sure, is completely broken, but should
> express what I have in mind)
>
>
>
> age = rmap_item->age;
> if (age != U8_MAX)
> 	rmap_item->age++;
>
> /*
>  * Smaller ages are not skipped, they need to get a chance to go
>  * through the different phases of the KSM merging.
>  */
> if (age < 3)
> 	return false;
>
> /*
>  * Are we still allowed to skip? If not, then don't skip it
>  * and determine how much more often we are allowed to skip next.
>  */
> if (!rmap_item->remaining_skips) {
> 	rmap_item->remaining_skips = skip_age(age);
> 	return false;
> }
>
> /* Skip this page. */
> rmap_item->remaining_skips--;
> remove_rmap_item_from_tree(rmap_item);
> return true;
>
>
>
> Would that miss anything important? Was the overflow handling (and scanning more
> often one we overflow again IIUC) important?
>

That sounds reasonable. I'll incorporate the two suggestions in the next version.
