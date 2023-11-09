Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C407E6EA1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbjKIQZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjKIQZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:25:40 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB0C3272;
        Thu,  9 Nov 2023 08:25:38 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SR6Mt62Bzz9xtTm;
        Fri, 10 Nov 2023 00:09:14 +0800 (CST)
Received: from [10.202.210.186] (unknown [10.202.210.186])
        by APP1 (Coremail) with SMTP id LxC2BwAXBXXkB01lxX1ZAA--.19877S2;
        Thu, 09 Nov 2023 17:25:18 +0100 (CET)
Message-ID: <ece7680c-630e-956d-ad9f-10614afa84a4@huaweicloud.com>
Date:   Thu, 9 Nov 2023 17:25:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Fw: [isocpp-parallel] OOTA fix (via fake branch-after-load)
 discussion
To:     paulmck@kernel.org, Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, j.alglave@ucl.ac.uk,
        will@kernel.org, catalin.marinas@arm.com, linux@armlinux.org.uk,
        mpe@ellerman.id.au, npiggin@gmail.com, palmer@dabbelt.com,
        parri.andrea@gmail.com, linux-kernel@vger.kernel.org,
        linux-toolchains@vger.kernel.org, boqun.feng@gmail.com,
        davidtgoldblatt@gmail.com
References: <b1634b24-4541-49c5-867c-7f24292a27bb@paulmck-laptop>
 <20231105230859.GH8262@noisy.programming.kicks-ass.net>
 <d18e0ce6-db9e-4590-a7ab-15e27b2c33f4@paulmck-laptop>
 <20231107095745.GD19790@gate.crashing.org>
 <bf18e3f7-f8be-4b11-b348-b784420bda16@paulmck-laptop>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <bf18e3f7-f8be-4b11-b348-b784420bda16@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwAXBXXkB01lxX1ZAA--.19877S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAry3KryfWw48Kw4DuFWDtwb_yoW5Gw1rpa
        y5K3W5Ka1DZFn7twn7Zw1xWF1Fv397JFy5Gr95Jr1vkrn0vr12gr4xt3y3KF93Cwn5Ww1j
        qrWYkr93Was8Za7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU1zuWJUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 11/7/2023 um 5:44 PM schrieb Paul E. McKenney:
> On Tue, Nov 07, 2023 at 03:57:45AM -0600, Segher Boessenkool wrote:
>> On Mon, Nov 06, 2023 at 06:16:24PM -0800, Paul E. McKenney wrote:
>>
>>> I am very much against incurring real overhead to solve an issue that is
>>> an issue only in theory and not in practice.  I wish I could confidently
>>> say that my view will prevail, but...


Where to complain to to increase the chance of your view prevailing?


>>                                                           If what you
>> are writing has a constrained scope, or a limited impact, or both, you
>> can ignore this "we'll deal with it later if/when it shows up".  But a
>> compiler does not have that luxury at all: it has to make correct
>> translations from source code to assembler code (or machine code
>> directly, for some compilers), or refuse to compile something.  Making
>> an incorrect translation is not an option.
> But in this case, it would be most excellent if compiler practice were
> to follow theory.  Because the theory of avoiding OOTA without emitting
> extraneous instructions is quite simple:
>
> 	Avoid breaking semanitic dependencies.


The problem with that is that C, unlike LKMM, doesn't use a ppo-based model.

So there's no notion of "breaking a dependency" that could be applied to 
define what it means "not to break" semantic dependencies.

But the solution is actually simpler. Just add the axiom (proposed by 
Viktor):

     There are no OOTA behaviors


> 4.	Semantics of volatile.	Perhaps the current state is the best
> 	that can be hoped for, but given that the current state is a
> 	few vague words in the standard in combination with the fact
> 	that C-language device drivers must be able to use volatile
> 	to reliably and concurrently access memory shared with device
> 	firmware, one would hope for better.


Is it really so bad? I think the definition in the manual is quite 
precise, if confusing. (volatiles are visible side effects and must 
therefore have the same program order in the abstract machine and in the 
implementation, and that's pretty much it).

There should just be a large explanatory note about what it implies and 
what it doesn't imply.


>
> 5.	UB on signed integer overflow.	Right now, the kernel just
> 	forces wrapping, which works, so maybe we don't really care
> 	all that much.	But at this point, it seems to me that it was a
> 	mistake for the language to have failed to provide a means of
> 	specifying signed integers that wrap (int_wrap?).  (Yes, yes,
> 	you can get them by making an atomic signed int, but that is
> 	not exactly an ergonomic workaround.)

What I don't understand is why they didn't make signed integer types 
wrap when they became two's complement.




