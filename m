Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31E47BBCB3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjJFQ2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjJFQ2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:28:17 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB999E
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 09:28:16 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6EB3A5C0213;
        Fri,  6 Oct 2023 12:28:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 06 Oct 2023 12:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1696609693; x=1696696093; bh=2d
        W/PhGhZL1Lh2ZgVhKfLyMXlLp6UoQWQqOjD8RsV10=; b=cLi8DYffjeojMfh1Dv
        q7uzxOznqANC6PyQjtD2xy0XKYoUTAAmVbCbHDViPAx00/jnYHwGguxdjF5+ri64
        INeocidXsISovnWWUeNxEVIKxSHG3IvOkfhMMU9gIBecbJPsUhCOWT8AMNRmqmtG
        f0HoviWT5o5QH18hV7of1rvChTp7FaN9tFmlfKmjVcLO4eYYtXQ3u0Txzt5fnhKJ
        4vCr4Z/mSL7+7ucHrW3FbO03Gafjdb0STCPTwGBLTIVt6ytxDD15Vl5q8i/ng1h7
        33DaOGTAV6EPnZtF40uRUN289PcprjcDMmhRiWRm7c/wpfah5DbCjxzy7ksVrtqw
        O58Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696609693; x=1696696093; bh=2dW/PhGhZL1Lh
        2ZgVhKfLyMXlLp6UoQWQqOjD8RsV10=; b=Sn4wefnFYw1VNTShs/wobCkjxEoCC
        gbzSmfmWPLa6z6GWTy8rGxSdUGWv7WUT1+kct7lnHFZNCWlZgBPgzn5gFDbnJOB/
        g9U+4L1iU2Dp01shyr0NtKkufhC27QI+XstLDR+fgm0allg8PUCWV0zDSjd6aLVi
        75dgJFiCuMsUGuhawuxMaNAL8c132JPPg9oHQ3KaGL9tVu1tNXbLY0gL4zZ7zTUm
        Go++o/o6yGUDz9C835qjzLAGxz8vQdAuG9OcA4KNKVt+A+M3LWaxcWNu6VCepsTx
        U5BDFruSBPl5TmzPl3+wMjAHOQBSbADnXQnSu+0PF2ipbzbs1R+CzWzHQ==
X-ME-Sender: <xms:nDUgZQJ_II6RYpWmGDGRGhrGQYmlVm3dxl5J7OUTj6ORyIQLzhvzzw>
    <xme:nDUgZQL8v8-MuCaC7MOvpRs3g0whbTlKy8L49RcokJbbtbwIcf6xW18cE-R78Nqnm
    ThvHSfS-TDljFegkKQ>
X-ME-Received: <xmr:nDUgZQtxYPbPc4zXr65mMQKmD7flbLQIdYwuZbduoYZPUrR_ptIhiKJJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeeigdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgvfhgr
    nhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrghtth
    gvrhhnpeevlefggffhheduiedtheejveehtdfhtedvhfeludetvdegieekgeeggfdugeeu
    tdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehshh
    hrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:nTUgZdZvp5E9pvvip9kaYvbbJ65Y-yKDNXqH9FWKeJXMwhtiG427rA>
    <xmx:nTUgZXamUFz77fgO3AjeHbb4IGTfZPpS87i27CPIzmxp1biLuDh6vw>
    <xmx:nTUgZZCAkw06_hYCXHdr3CY1mlIJBSYNXqtt99OyXjwNXmK6Z2bHww>
    <xmx:nTUgZSy5USzgvFaxN7cbQW8GqF2CjOQuVglKkfAIYTeHIrJAn1H8Aw>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Oct 2023 12:28:10 -0400 (EDT)
References: <20231004190249.829015-1-shr@devkernel.io>
 <4509a3b4-16a6-f63e-1dd5-e20c7eadf87d@redhat.com>
User-agent: mu4e 1.10.3; emacs 29.1
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 0/4] mm/ksm: Add ksm advisor
Date:   Fri, 06 Oct 2023 09:17:32 -0700
In-reply-to: <4509a3b4-16a6-f63e-1dd5-e20c7eadf87d@redhat.com>
Message-ID: <87fs2nhg14.fsf@devkernel.io>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

> On 04.10.23 21:02, Stefan Roesch wrote:
>> What is the KSM advisor?
>> =========================
>> The ksm advisor automatically manages the pages_to_scan setting to
>> achieve a target scan time. The target scan time defines how many seconds
>> it should take to scan all the candidate KSM pages. In other words the
>> pages_to_scan rate is changed by the advisor to achieve the target scan
>> time.
>> Why do we need a KSM advisor?
>> ==============================
>> The number of candidate pages for KSM is dynamic. It can often be observed
>> that during the startup of an application more candidate pages need to be
>> processed. Without an advisor the pages_to_scan parameter needs to be
>> sized for the maximum number of candidate pages. With the scan time
>> advisor the pages_to_scan parameter based can be changed based on demand.
>> Algorithm
>> ==========
>> The algorithm calculates the change value based on the target scan time
>> and the previous scan time. To avoid pertubations an exponentially
>> weighted moving average is applied.
>> The algorithm has a max and min
>> value to:
>> - guarantee responsiveness to changes
>> - to avoid to spend too much CPU
>> Parameters to influence the KSM scan advisor
>> =============================================
>> The respective parameters are:
>> - ksm_advisor_mode
>>    0: None (default), 1: scan time advisor
>> - ksm_advisor_target_scan_time
>>    how many seconds a scan should of all candidate pages take
>> - ksm_advisor_min_pages
>>    minimum value for pages_to_scan per batch
>> - ksm_advisor_max_pages
>>    maximum value for pages_to_scan per batch
>> The parameters are exposed as knobs in /sys/kernel/mm/ksm.
>> By default the scan time advisor is disabled.
>
> What would be the main reason to not have this enabled as default?
>
There might be already exisiting users which directly set pages_to_scan
and tuned the KSM settings accordingly, as the default setting of 100 for
pages_to_scan is too low for typical workloads.

> IIUC, it is kind-of an auto-tuning of pages_to_scan. Would "auto-tuning"
> describe it better than "advisor" ?
>
> [...]
>

I'm fine with auto-tune. I was also thinking about that name, but I
chose advisor, its a bit less strong and it needs input from the user.

>> How is defining a target scan time better?
>> ===========================================
>> For an administrator it is more logical to set a target scan time.. The
>> administrator can determine how many pages are scanned on each scan.
>> Therefore setting a target scan time makes more sense.
>> In addition the administrator might have a good idea about the
>> memory sizing of its respective workloads.
>
> Is there any way you could imagine where we could have this just do something
> reasonable without any user input? IOW, true auto-tuning?
>

True auto-tuning might be difficult as users might want to be able to
choose how aggressive KSM is. Some might want it to be as aggressive as
possible to get the maximum de-duplication rate. Others might want a
more balanced approach that takes CPU-consumption into consideration.

I guess it depends if you are memory-bound, cpu-bound or both.

> I read above:
>> - guarantee responsiveness to changes
>> - to avoid to spend too much CPU
>
> whereby both things are accountable/measurable to use that as the input for
> auto-tuning?
>
I'm not sure a true auto-tuning can be achieved. I think we need
some input from the user
- How much resources to consume
- How fast memory changes or how stable memory is
  (this we might be able to detect)

>
>
> I just had a family NMI, so my todo list is quite lengthy. Hoping I cna take a
> closer look next week.
