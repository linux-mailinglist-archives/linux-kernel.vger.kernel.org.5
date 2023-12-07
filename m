Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BF280968E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 00:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444119AbjLGX0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 18:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbjLGX0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 18:26:11 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9C41719
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 15:26:17 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 37EDE3200B8F;
        Thu,  7 Dec 2023 18:26:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 07 Dec 2023 18:26:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1701991575; x=1702077975; bh=Bt
        llAeRuCcPTl4gOdGM/QH1NvWPxw+8wNvSb0SE/0x4=; b=EaAnBEEkCePGS88Kzt
        KeGILp5fDctSLpMJrATWla6rcjKJROlBbb/Jp9oa9HRF22ijq7D70YpIAPyX5Rn8
        ZqRjT14uc0F9df6Yk5Dk0kL7jaZT8OGuHt5LnC+kIIGQK1cu92FvaO9CfyC37let
        I0kkOoAEmaFHnxMtcejllHRadVW8jB59t0JfzOTte0jTjKxt8TqXjVtMNrWadT6N
        j/N9ZcwplQPVg83+JSsJQNq9P66OW4AzasD2Oh180NdMMfbOdO63QWhLivToRNOu
        55wO3jqKPxa6vIlP6bjvSGCm9MM4aU/HPadA4fTpxyJGX17vuZ+dLJQiwHF1yI3t
        R6oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701991575; x=1702077975; bh=BtllAeRuCcPTl
        4gOdGM/QH1NvWPxw+8wNvSb0SE/0x4=; b=SPimJHgega8xzRp7sPUJLqkbYjFmw
        CbHOvU5wtYJXA08x9q8+sTR7P1/oR7ZKDzGY5Vj2n6GeyDms/Ont5aOfybAyz5pN
        9cNNzw1WJk1xazjratCZ5NvtRoWP99b9278BWi7pZoQPHuk8MBifUuPHHZ/HLxnR
        DdDN4/yVb0AbQj7zf23utL/jd7i8DCpRML3ebSQIWAKdQ71PxXabsK4guInpooha
        r5btUwawqJ+/ZXhh1YFKdhlPKDgIAnxiC3IWSgNfkT/MFO79Pf0qt4tIXHEmCxdI
        MvVnyxwnLhXuxZTChA6hV3D+DXflHbs01BKcB3vbekQ7ypsJUDzIqPXBg==
X-ME-Sender: <xms:l1RyZXB9ColG3E4W4I7lmlDe_QYBgPYyzqlF8xUAV3R9vz3Nfx_NUg>
    <xme:l1RyZdgkYNF7_3v0hO2C-WFMTtbgcgVrPTo1wOHQjwd2r3f5H2p_jjX4tvhAAOoij
    7C6VbLFTlnmuzH6Oys>
X-ME-Received: <xmr:l1RyZSkYisWq3fVFcOZpgt4WlZz_EFBVAIP5tv-C8dSEwvVGpWrqeU8O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekgedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpehffgfhvfevufffjgfkgggtsehttd
    ertddtredtnecuhfhrohhmpefuthgvfhgrnhcutfhovghstghhuceoshhhrhesuggvvhhk
    vghrnhgvlhdrihhoqeenucggtffrrghtthgvrhhnpeduteejkefhueffkeekudffueeihe
    dukeeuteejvedvgeekhfehheektddtuefghfenucffohhmrghinhepmhgrrhgtrdhinhhf
    ohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehshh
    hrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:l1RyZZyLMEaPyPaIS8ozLA2EQJMegIE5vur9Jgxq71PQm5vijvFU7w>
    <xmx:l1RyZcRdLbj1TWQ8H94hwjmtFMO1TfHZy-0hSaCVZG1VHeb2g7mP4Q>
    <xmx:l1RyZcagJRcnxe80qsmRQHLga1PlLX08DFG2l3jWh-m1GYrhDKH_2Q>
    <xmx:l1RyZRLqcISa-kYJ4AMWKg9YmEu378VWxacZqqeU4MeFrYcTO2Ujpw>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 18:26:13 -0500 (EST)
References: <20231204234906.1237478-1-shr@devkernel.io>
 <20231205124610.ca70c47e880daa81a0f21f07@linux-foundation.org>
User-agent: mu4e 1.10.3; emacs 29.1
From:   Stefan Roesch <shr@devkernel.io>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-team@fb.com, david@redhat.com, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 0/4] mm/ksm: Add ksm advisor
Date:   Thu, 07 Dec 2023 15:18:27 -0800
In-reply-to: <20231205124610.ca70c47e880daa81a0f21f07@linux-foundation.org>
Message-ID: <87il59vbl9.fsf@devkernel.io>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton <akpm@linux-foundation.org> writes:

> On Mon,  4 Dec 2023 15:49:02 -0800 Stefan Roesch <shr@devkernel.io> wrote:
>
>> What is the KSM advisor?
>> =========================
>> The ksm advisor automatically manages the pages_to_scan setting to
>> achieve a target scan time. The target scan time defines how many seconds
>> it should take to scan all the candidate KSM pages. In other words the
>> pages_to_scan rate is changed by the advisor to achieve the target scan
>> time.
>
> Dumb question time.  Can this be done in userspace?  Presumably this
> will require exposing some additional kernel state to userspace.
>

Userspace doesn't look like a good fit
- We need access to how much cpu the ksmd kernel thread spent during the
last scan
- We want to recompute this after each scan completes, so the new
parameter is in effect for the next scan and to avoid we have to
partially deal with new values in the middle
- When the advisor is active we want to disable that other users can
manually set the scan rate.

The scan advisor might be augmented with per page cost in the future.

>> Why do we need a KSM advisor?
>> ==============================
>> The number of candidate pages for KSM is dynamic. It can often be observed
>> that during the startup of an application more candidate pages need to be
>> processed. Without an advisor the pages_to_scan parameter needs to be
>> sized for the maximum number of candidate pages. With the scan time
>> advisor the pages_to_scan parameter based can be changed based on demand.
>>
>> Algorithm
>> ==========
>> The algorithm calculates the change value based on the target scan time
>> and the previous scan time. To avoid pertubations an exponentially
>> weighted moving average is applied.
>>
>> The algorithm has a max and min
>> value to:
>> - guarantee responsiveness to changes
>> - to limit CPU resource consumption
>>
>> Parameters to influence the KSM scan advisor
>> =============================================
>> The respective parameters are:
>> - ksm_advisor_mode
>>   0: None (default), 1: scan time advisor
>> - ksm_advisor_target_scan_time
>>   how many seconds a scan should of all candidate pages take
>> - ksm_advisor_max_cpu
>>   upper limit for the cpu usage in percent of the ksmd background thread
>>
>> The initial value and the max value for the pages_to_scan parameter can
>> be limited with:
>> - ksm_advisor_min_pages
>>   minimum value for pages_to_scan per batch
>> - ksm_advisor_max_pages
>>   maximum value for pages_to_scan per batch
>
> Should these be called ksm_advisor_min_pages_to_scan?
>

That's a good recommendation. I'll make that change and the
corresponding change for max.

>> The default settings for the above two parameters should be suitable for
>> most workloads.
>>
>> The parameters are exposed as knobs in /sys/kernel/mm/ksm. By default the
>> scan time advisor is disabled.
>
> Disabling it will reduce the effectiveness of testing.  What are the
> risks of defaulting to "on"?
>

Some users might have already tuned the values for pages_to_scan. So
generally turning it on might not be good. However we could turn it on,
it the default value of 100 for pages_to_scan hasn't been changed.

Any thoughts?

>> Currently there are two advisors:
>> - none and
>> - scan-time.
>>
>> Resource savings
>> =================
>> Tests with various workloads have shown considerable CPU savings. Most
>> of the workloads I have investigated have more candidate pages during
>> startup. Once the workload is stable in terms of memory, the number of
>> candidate pages is reduced. Without the advisor, the pages_to_scan needs
>> to be sized for the maximum number of candidate pages. So having this
>> advisor definitely helps in reducing CPU consumption.
>>
>> For the instagram workload, the advisor achieves a 25% CPU reduction.
>
> 25% of what?  What is the overall affect on machine resource
> consumption?
>

25% of the cpu consumption of the ksmd background thread. On a 32 cpu
machine this translates to 1 to 2% cpu savings alltogether.

However this is highly workload dependent.

>> Once the memory is stable, the pages_to_scan parameter gets reduced to
>> about 40% of its max value.
>>
>> The new advisor works especially well if the smart scan feature is also
>> enabled.
>>
>> How is defining a target scan time better?
>> ===========================================
>> For an administrator it is more logical to set a target scan time.. The
>> administrator can determine how many pages are scanned on each scan.
>> Therefore setting a target scan time makes more sense.
>>
>> In addition the administrator might have a good idea about the memory
>> sizing of its respective workloads.
>>
>> Setting cpu limits is easier than setting The pages_to_scan parameter. The
>> pages_to_scan parameter is per batch. For the administrator it is difficult
>> to set the pages_to_scan parameter.
>>
>> Tracing
>> =======
>> A new tracing event has been added for the scan time advisor. The new
>> trace event is called ksm_advisor. It reports the scan time, the new
>> pages_to_scan setting and the cpu usage of the ksmd background thread.
>>
>> Other approaches
>> =================
>>
>> Approach 1: Adapt pages_to_scan after processing each batch. If KSM
>>   merges pages, increase the scan rate, if less KSM pages, reduce the
>>   the pages_to_scan rate. This doesn't work too well. While it increases
>>   the pages_to_scan for a short period, but generally it ends up with a
>>   too low pages_to_scan rate.
>>
>> Approach 2: Adapt pages_to_scan after each scan. The problem with that
>>   approach is that the calculated scan rate tends to be high. The more
>>   aggressive KSM scans, the more pages it can de-duplicate.
>>
>> There have been earlier attempts at an advisor:
>>   propose auto-run mode of ksm and its tests
>>   (https://marc.info/?l=linux-mm&m=166029880214485&w=2)
