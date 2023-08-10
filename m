Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128FC778113
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbjHJTNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbjHJTNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:13:46 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A869F270F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:13:45 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 5C5353200936;
        Thu, 10 Aug 2023 15:13:42 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 10 Aug 2023 15:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691694821; x=1691781221; bh=RL
        oA66OEzr5j7s1fTq2C967jgX1/gDQUaNF6pTqud2A=; b=X7p4bA7ghfOeXQMoZE
        BbwfAySgF8oA+TU4Yng28o8m75BZ+55wM+m/MIaOsk+R4SUmwSn4d9H+uml2zVW5
        d2PS15nA3v/0lXAf6OecXGLe+3l6rw6O4czRGihtW4xcwZVhtgVuIAbiC6pTFlwv
        2D9nGdvOMmPGXo18+qrvuVQ5wBDzK6jjEvX29LCdNqdJVzqrN2rKm4ITkxDQu87z
        02hvfZ9S9x7PlhLPxFBwHJssC4KTpW/oRWZRvMpGC/YdSzzlsHNikM4IBmQJ5xhQ
        FKXYLB9EFZB6MflBa91MIYvD4TKWO03W0LKEtSrdqIC/giyM3PtbyeJjiOorrEKf
        6apw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691694821; x=1691781221; bh=RLoA66OEzr5j7
        s1fTq2C967jgX1/gDQUaNF6pTqud2A=; b=HnW4PD/9KPXfo1AB1CIjhaYBfN9Hr
        MSmZyBXAulgDKCW4uynPhIN/0XBEXD7N5u7rdYbyOPUF2xPQpnUx7SJzSlHlibCE
        eRgupu1sIb+TgnSRFp8fZb+bZMT0VojRrWPceovlCaxL7LEgMhnPBGgKGpdZjH1a
        qwVVAlnZQ0gyqTaIH9rbGIQOu3SCwSSiFYRULCs1ZRIbqs9cypV1sOyfkR6GKq8i
        GP/AqA7rmCqQCQx6CQQ0JU5i9tdY9+Hm5HRknd3xYrSULGpyhTv20sFEAhxC5JVx
        6ajePuivMs1CVNwFrpChC3Mizgpgvwat0PFcV93DvUbfpnUqmWviRs2tA==
X-ME-Sender: <xms:5TbVZED9gVk8hsAvZXtGLThJAS0kUiGQDwLvuNfkw7CF12tEAnpMlQ>
    <xme:5TbVZGhw1iTsDnZFnvQslTPTLXK6UI6gGfyladsNFGfeywc2npqrPEcXV2yVKqQMv
    Gm6n91sWls_OzrzwlI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleeigddufeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:5TbVZHmkix-R8Q046mTPFDneTX4FN3my2VnbvjXmLMfXSgKDmoTdCg>
    <xmx:5TbVZKwpqbbVtIs1KADLi6tOgHDI25fbV4CjToeL4ap4Yv53ynAyBQ>
    <xmx:5TbVZJQKS5CL3wHmJ68GjS-M-w671wMEMDuKpIeVrUZMVWwzrPZc2Q>
    <xmx:5TbVZOJpmRRKOmRR_6-ed7I2NdeHNjzNTa5CiPlRd8a_4zMMVz-aDQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 49095B60089; Thu, 10 Aug 2023 15:13:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <ad9b8e41-5897-4ad6-8113-2812301c0c93@app.fastmail.com>
In-Reply-To: <mhng-92f37526-d36c-48c0-8fbd-7676df1b6086@palmer-ri-x1c9>
References: <mhng-92f37526-d36c-48c0-8fbd-7676df1b6086@palmer-ri-x1c9>
Date:   Thu, 10 Aug 2023 21:13:20 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Palmer Dabbelt" <palmer@rivosinc.com>,
        "Leonardo Bras" <leobras@redhat.com>
Cc:     "Will Deacon" <will@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Boqun Feng" <boqun.feng@gmail.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Andrea Parri" <parri.andrea@gmail.com>,
        "Andrzej Hajda" <andrzej.hajda@intel.com>,
        guoren <guoren@kernel.org>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v5 5/5] riscv/cmpxchg: Implement xchg for variables of size 1
 and 2
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023, at 18:23, Palmer Dabbelt wrote:
> On Thu, 10 Aug 2023 09:04:04 PDT (-0700), leobras@redhat.com wrote:
>> On Thu, 2023-08-10 at 08:51 +0200, Arnd Bergmann wrote:
>>> On Thu, Aug 10, 2023, at 06:03, Leonardo Bras wrote:
>>> > xchg for variables of size 1-byte and 2-bytes is not yet available for
>>> > riscv, even though its present in other architectures such as arm64 and
>>> > x86. This could lead to not being able to implement some locking mechanisms
>>> > or requiring some rework to make it work properly.
>>> > 
>>> > Implement 1-byte and 2-bytes xchg in order to achieve parity with other
>>> > architectures.
>>
>>> Parity with other architectures by itself is not a reason to do this,
>>> in particular the other architectures you listed have the instructions
>>> in hardware while riscv does not.
>>
>> Sure, I understand RISC-V don't have native support for xchg on variables of
>> size < 4B. My argument is that it's nice to have even an emulated version for
>> this in case any future mechanism wants to use it.
>>
>> Not having it may mean we won't be able to enable given mechanism in RISC-V. 
>
> IIUC the ask is to have a user within the kernel for these functions.  
> That's the general thing to do, and last time this came up there was no 
> in-kernel use of it -- the qspinlock stuff would, but we haven't enabled 
> it yet because we're worried about the performance/fairness stuff that 
> other ports have seen and nobody's got concrete benchmarks yet (though 
> there's another patch set out that I haven't had time to look through, 
> so that may have changed).

Right. In particular the qspinlock is a good example for something
where having the emulated 16-bit xchg() may end up less efficient
than a natively supported instruction.

The xchg() here is a performance optimization for CPUs that can
do this without touching the other half of the 32-bit word.

>>
>> Didn't get this part:
>> By "emulating small xchg() through cmpxchg()", did you mean like emulating an
>> xchg (usually 1 instruction) with lr & sc (same used in cmpxchg) ?
>>
>> If so, yeah, it's a fair point: in some extreme case we could have multiple
>> threads accessing given cacheline and have sc always failing. On the other hand,
>> there are 2 arguments on that:
>>
>> 1 - Other architectures, (such as powerpc, arm and arm64 without LSE atomics)
>> also seem to rely in this mechanism for every xchg size. Another archs like csky
>> and loongarch use asm that look like mine to handle size < 4B xchg. 

I think you misread the arm64 code, which should use native instructions
for all sizes, in both the armv8.0 and LSE atomics.

PowerPC does use the masking for xchg, but I suspect there are no
actual users, at least it actually has its own qspinlock implementation
that avoids xchg().

>>>  This is also something that almost no architecture
>>> specific code relies on (generic qspinlock being a notable exception).
>>> 
>>
>> 2 - As you mentioned, there should be very little code that will actually make
>> use of xchg for vars < 4B, so it should be safe to assume its fine to not
>> guarantee forward progress for those rare usages (like some of above mentioned
>> archs).

I don't this this is a safe assumption, we've had endless discussions
about using qspinlock on architectures without a native xchg(), which
needs either hardware guarantees or special countermeasures in xchg() itself
to avoid this.

What I'd actually like to do here is to remove the special 8-bit and
16-bit cases from the xchg() and cmpxchg() interfaces at all, leaving
only fixed 32-bit and native wordsize (either 32 or 64) as the option,
while dealing with the others the same way we treat the fixed
64-bit cases that hardcode the 64-bit argument types and are only
usable on architectures that provide them.

    Arnd
