Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4A17C012D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbjJJQGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbjJJQF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:05:57 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8544AD49
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:05:07 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.nyi.internal (Postfix) with ESMTP id 1F5085C0345;
        Tue, 10 Oct 2023 12:05:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 10 Oct 2023 12:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1696953904; x=1697040304; bh=LR
        mEqSI1v8tnpczO9tpOdCQmOVzZGNRUA1zFNRHlG4A=; b=aLZX01VoyGNxYqS25a
        L+z6C1EOK65j3yv/t5Hz/kO9ZusGEXX3+RneAwGD1da1wvjG106xYjxHE2tdjmVm
        9jGHYPKyoQpX6wOrTbAnCY1zeF6zfIKQmRvsNRsqRDfG3lugPW/tmvOuElII7auD
        aBoiAjYIGmdKmWBY3Zv8OcSc0fbxFT3/14upW0nHf6c/H4Wj1a7lq1uMRA0tlMZD
        +vxvffliAjaXwN9VPLLQO9R6Smh87lNQ+Yz/03diZkY/XWPEvBBPovsRB9aoiiX+
        Uk2vVRhguocgHrvLdtJnKILNJDG8T3TuMJhl63lulsg8jwevJ2II09D/kMYCxiqP
        dcXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696953904; x=1697040304; bh=LRmEqSI1v8tnp
        czO9tpOdCQmOVzZGNRUA1zFNRHlG4A=; b=OrqZmIXGRKEXdb5GXLkEgBGsgzgzm
        Q51aZV43gYC2BUEmnrxjNfllqR+uyqs1BTCOqb6cYszo4NRP2xte6B9IuEtAFXEZ
        pf/cvaxuEdgXc+l+GiWiF64wx+UJZbSAdqkR3RgkFvEEyaccYcw74U1Kn06K2gPr
        M6Zr3pYHXE3f26N9Iy/5pq7ZMgL8A5z8Q1O6JIUXndqPbQZKQfMJ+h8GSCkloeui
        S0Rz6cNVFQY6r3/j/57+9cjUZNFQMw2eQkFJmhdZHl4cSNg5tNUv/fIzjMtglndo
        S+aClrji4bJ+UnDu5nsYpCl/bbfDB7ebvCieMqIy7pbUbGnnCqyYFB2+A==
X-ME-Sender: <xms:L3YlZXv3t-DJ_ySC28v3CKqXpm0t_zbId7QL4zkLXEMKC4tDH9VbVw>
    <xme:L3YlZYf9Bg71Avq33pP4n7BjcECadF0ZB0Vd3RVUibGr5nC0o6xy2XcwrgjZp7ghj
    G9xRsQsEpVjpiIB74Y>
X-ME-Received: <xmr:L3YlZayUlQJSAve7BFtewxlbkM_TbsuNWbjDIgRqOvpe3-cncphsrHKv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheehgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgvfhgr
    nhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrghtth
    gvrhhnpeevlefggffhheduiedtheejveehtdfhtedvhfeludetvdegieekgeeggfdugeeu
    tdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehshh
    hrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:L3YlZWNBtvhIj_1StxFj79Z0UkRaIc2Bp0aKC18pqEqTH1BDu-rp1A>
    <xmx:L3YlZX-N4AHfGWT_toCt963sWFHWSbsby82zNzZXhYEZvrtXO5x9hw>
    <xmx:L3YlZWX1tp8tU2RmneKdFjMQvDp5HG5Ab1HsSbqyD22BGXRpYywoSA>
    <xmx:MHYlZSllQp-1U234jsAC46FZhFca6jT9JcbFXh57ocu1g6fpD3eFaQ>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Oct 2023 12:05:00 -0400 (EDT)
References: <20231004190249.829015-1-shr@devkernel.io>
 <4509a3b4-16a6-f63e-1dd5-e20c7eadf87d@redhat.com>
 <87fs2nhg14.fsf@devkernel.io>
 <d9e28b8a-dc03-42cf-a6f8-69b2d993cc8d@redhat.com>
User-agent: mu4e 1.10.3; emacs 29.1
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 0/4] mm/ksm: Add ksm advisor
Date:   Tue, 10 Oct 2023 09:02:38 -0700
In-reply-to: <d9e28b8a-dc03-42cf-a6f8-69b2d993cc8d@redhat.com>
Message-ID: <87bkd61n12.fsf@devkernel.io>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

> On 06.10.23 18:17, Stefan Roesch wrote:
>> David Hildenbrand <david@redhat.com> writes:
>>
>>> On 04.10.23 21:02, Stefan Roesch wrote:
>>>> What is the KSM advisor?
>>>> =========================
>>>> The ksm advisor automatically manages the pages_to_scan setting to
>>>> achieve a target scan time. The target scan time defines how many seconds
>>>> it should take to scan all the candidate KSM pages. In other words the
>>>> pages_to_scan rate is changed by the advisor to achieve the target scan
>>>> time.
>>>> Why do we need a KSM advisor?
>>>> ==============================
>>>> The number of candidate pages for KSM is dynamic. It can often be observed
>>>> that during the startup of an application more candidate pages need to be
>>>> processed. Without an advisor the pages_to_scan parameter needs to be
>>>> sized for the maximum number of candidate pages. With the scan time
>>>> advisor the pages_to_scan parameter based can be changed based on demand.
>>>> Algorithm
>>>> ==========
>>>> The algorithm calculates the change value based on the target scan time
>>>> and the previous scan time. To avoid pertubations an exponentially
>>>> weighted moving average is applied.
>>>> The algorithm has a max and min
>>>> value to:
>>>> - guarantee responsiveness to changes
>>>> - to avoid to spend too much CPU
>>>> Parameters to influence the KSM scan advisor
>>>> =============================================
>>>> The respective parameters are:
>>>> - ksm_advisor_mode
>>>>     0: None (default), 1: scan time advisor
>>>> - ksm_advisor_target_scan_time
>>>>     how many seconds a scan should of all candidate pages take
>>>> - ksm_advisor_min_pages
>>>>     minimum value for pages_to_scan per batch
>>>> - ksm_advisor_max_pages
>>>>     maximum value for pages_to_scan per batch
>>>> The parameters are exposed as knobs in /sys/kernel/mm/ksm.
>>>> By default the scan time advisor is disabled.
>>>
>>> What would be the main reason to not have this enabled as default?
>>>
>> There might be already exisiting users which directly set pages_to_scan
>> and tuned the KSM settings accordingly, as the default setting of 100 for
>> pages_to_scan is too low for typical workloads.
>
> Good point.
>
>>
>>> IIUC, it is kind-of an auto-tuning of pages_to_scan. Would "auto-tuning"
>>> describe it better than "advisor" ?
>>>
>>> [...]
>>>
>> I'm fine with auto-tune. I was also thinking about that name, but I
>> chose advisor, its a bit less strong and it needs input from the user.
>>
>
> I'm not a native speaker, but "adviser" to me implies that no action is taken,
> only advises are given :) But again, no native speaker.
>
>>>> How is defining a target scan time better?
>>>> ===========================================
>>>> For an administrator it is more logical to set a target scan time.. The
>>>> administrator can determine how many pages are scanned on each scan.
>>>> Therefore setting a target scan time makes more sense.
>>>> In addition the administrator might have a good idea about the
>>>> memory sizing of its respective workloads.
>>>
>>> Is there any way you could imagine where we could have this just do something
>>> reasonable without any user input? IOW, true auto-tuning?
>>>
>> True auto-tuning might be difficult as users might want to be able to
>> choose how aggressive KSM is. Some might want it to be as aggressive as
>> possible to get the maximum de-duplication rate. Others might want a
>> more balanced approach that takes CPU-consumption into consideration.
>> I guess it depends if you are memory-bound, cpu-bound or both.
>
> Agreed, more below.
>
>>
>>> I read above:
>>>> - guarantee responsiveness to changes
>>>> - to avoid to spend too much CPU
>>>
>>> whereby both things are accountable/measurable to use that as the input for
>>> auto-tuning?
>>>
>> I'm not sure a true auto-tuning can be achieved. I think we need
>> some input from the user
>> - How much resources to consume
>> - How fast memory changes or how stable memory is
>>    (this we might be able to detect)
>
> Setting the pages_to_scan is a bit mystical. Setting upper/lower pages_to_scan
> bounds is similarly mystical, and highly workload dependent.
>
> So I agree that a better abstraction to automatically tune the scanning is
> reasonable. I wonder if we can let the user give better inputs that are less
> workload dependent.
>
> For example, do we need min/max values for pages_to_scan, or can we replace it
> by something better to the auto-tuning algorithm?
>
> IMHO "target scan time" goes into the right direction, but it can still be
> fairly workload dependent. Maybe a "max CPU consumption" or sth. like that would
> similarly help to limit CPU waste, and it could be fairly workload dependent.

I can look into replacing min/max values for pages_to_scan with min/max
cpu utilization. This might be easier for users to decide on. However I
still think that we need a target value like scan time to optimize for.
