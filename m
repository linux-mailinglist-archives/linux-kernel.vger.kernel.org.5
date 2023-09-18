Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006A67A5258
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 20:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjIRSuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 14:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjIRSuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:50:04 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BACF7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:49:58 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 54C0B5C01E9;
        Mon, 18 Sep 2023 14:49:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 18 Sep 2023 14:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1695062995; x=1695149395; bh=GC
        XTb1jWNrkSvBUMw1jlbEFNJJNh08VrOT3LyJE/IuE=; b=dI2VU9B4pM2Ef8PrUX
        4Y62eVvCS43pIHAkoKiRteuIsTmEjUOsbLzsfpLt2KtAeR1RRmiEKJfyCSlBmslK
        4y+5z3NAtELpOYWw/FWbHclhgtEx7YciyKaUaXRFEzoeJoL2Oscwua1pxJP+q7gI
        J93jjccN3xyO1+QjBZucOrBXMVY+fXU/DL/zDtcjpkxC8YhtXka+ns7aKZoVy0ho
        aJIKIKE9kI7P399oukmlSs0Y9ZLeWidfQsGr/GTz/9XNkHbUASVpNDLqW58wCtTa
        T5U/R0JFOT4GVFZMrtR9wurs+6JZgiNzjPlK5PVYjkjdnYWHCdNM50WZinL2C8wc
        Tk7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695062995; x=1695149395; bh=GCXTb1jWNrkSv
        BUMw1jlbEFNJJNh08VrOT3LyJE/IuE=; b=V3XJ5sC+hGOCRXQazHAQjgzHZEC4H
        03I82mzu+StO45MHTrz0gY5Yetqc0D8oCkSKUK4LwKHBwjkfBLMgjmtKbOusveFe
        8oowhWEosmOyGeRRyAIn4g3U2T+PLriIQv9hNvFSx4knNVm/7ukFvEmKjSOB+zXa
        xj3lQ7vz3JcNj00QBXXMoaCWu8H2Lis4bZV616ThU+pg8nJxZ5k7bdU2dFLx0Wjt
        IsmnTVBmI+73ubm66DCCh5pVbOl7yzpW4cHix/1Naw0oEhNdPXlREjcHpuU19Oay
        LsVwNKlW+hu4bDm3qI9FSDlHqbQZp0aHcJY+q/QCvePJQ4bkKu57wSZOg==
X-ME-Sender: <xms:0psIZVLIYOdDZChslgsDjJFHoi69A_YSK_dmDAKOrWsId88JqS341w>
    <xme:0psIZRITvYf_rKFFL9O3QsGY2q-BvJgGRh56Js5g5zPVRuv3rd56xOgDeZ61NH94H
    WqCCr9h_6WmJU9-YME>
X-ME-Received: <xmr:0psIZduim9KCA9U1T-WJQvS-VV3WNMaDjZPSiU2qaLYKfp_HsyZNf2-tc_8ZKbDCpXCtz_5HG014SIBDdM2qaB_-sEbnrNK6udrA5b0cxIOl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejkedgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfhgfhffvvefuffgjkfggtgesth
    dtredttdertdenucfhrhhomhepufhtvghfrghnucftohgvshgthhcuoehshhhrseguvghv
    khgvrhhnvghlrdhioheqnecuggftrfgrthhtvghrnhepveelgffghfehudeitdehjeevhe
    dthfetvdfhledutedvgeeikeeggefgudeguedtnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepshhhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:05sIZWaFXNEGrvpKZaR29SMGFSIE8TVmBYjOIt-wzy_rSRI_q5Ilpg>
    <xmx:05sIZcY0iu4S_t4Id2SzF11h9y4qsBv65ByV02BiaA2kHfgo3wMIXw>
    <xmx:05sIZaD4sJf5ezquqZjWEIpzbZjokO-1uiCzMkwGKPe2z3ibxqnk6Q>
    <xmx:05sIZbzZ_7aSEJKO80mlAIR2lsykZ4KIgGN5rdGLwBSl3CKq_D2g5g>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Sep 2023 14:49:54 -0400 (EDT)
References: <20230912175228.952039-1-shr@devkernel.io>
 <20230912175228.952039-2-shr@devkernel.io>
 <20230913140750.616d3d87fe986a74d870b71f@linux-foundation.org>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-team@fb.com, david@redhat.com, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 1/4] mm/ksm: add "smart" page scanning mode
Date:   Mon, 18 Sep 2023 11:47:57 -0700
In-reply-to: <20230913140750.616d3d87fe986a74d870b71f@linux-foundation.org>
Message-ID: <qvqwa5tjb9km.fsf@devbig1114.prn1.facebook.com>
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


Andrew Morton <akpm@linux-foundation.org> writes:

> On Tue, 12 Sep 2023 10:52:25 -0700 Stefan Roesch <shr@devkernel.io> wrote:
>
>> This change adds a "smart" page scanning mode for KSM. So far all the
>> candidate pages are continuously scanned to find candidates for
>> de-duplication. There are a considerably number of pages that cannot be
>> de-duplicated. This is costly in terms of CPU. By using smart scanning
>> considerable CPU savings can be achieved.
>>
>> This change takes the history of scanning pages into account and skips
>> the page scanning of certain pages for a while if de-deduplication for
>> this page has not been successful in the past.
>>
>> To do this it introduces two new fields in the ksm_rmap_item structure:
>> age and skip_age. age, is the KSM age and skip_page is the age for how
>
> s/skip_page/skip_age/
>

Fixed in the next version.

>> long page scanning of this page is skipped. The age field is incremented
>> each time the page is scanned and the page cannot be de-duplicated.
>>
>> How often a page is skipped is dependent how often de-duplication has
>> been tried so far and the number of skips is currently limited to 8.
>> This value has shown to be effective with different workloads.
>>
>> The feature is currently disable by default and can be enabled with the
>> new smart_scan knob.
>>
>> The feature has shown to be very effective: upt to 25% of the page scans
>> can be eliminated; the pages_to_scan rate can be reduced by 40 - 50% and
>> a similar de-duplication rate can be maintained.
>>
>
> All seems nice.  I'll sit out v1, see what people have to say.
>
> Some nits:
>
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>>
>> ...
>>
>> @@ -2305,6 +2314,45 @@ static struct ksm_rmap_item *get_next_rmap_item(struct ksm_mm_slot *mm_slot,
>>  	return rmap_item;
>>  }
>>
>> +static unsigned int inc_skip_age(rmap_age_t age)
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
>
> "inc_skip_age" sounds like it increments something.  Can we give it a
> better name?
>
> And a nice comment explaining its role in life.
>

Renamed it to skip_age in the next version and added a comment.

>> +static bool skip_rmap_item(struct page *page, struct ksm_rmap_item *rmap_item)
>> +{
>> +	rmap_age_t age;
>> +
>> +	if (!ksm_smart_scan)
>> +		return false;
>> +
>> +	if (PageKsm(page))
>> +		return false;
>> +
>> +	age = rmap_item->age++;
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
>> +		remove_rmap_item_from_tree(rmap_item);
>> +	}
>> +
>> +	return true;
>> +}
>
> Would a better name be should_skip_rmap_item()?
>

Renamed it to should_skip_rmap_item().

> But even that name implies that the function is idempotent (has no
> side-effects).  Again, an explanatory comment would be good.  And
> simple comments over each non-obvious `if' statement.
>

Added more comments to the function to explain the different cases.

>>
>> ...
>>
