Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24B17E1094
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 19:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjKDSVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 14:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKDSVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 14:21:07 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C438D6;
        Sat,  4 Nov 2023 11:21:03 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4SN5Ds5dncz9xyt4;
        Sun,  5 Nov 2023 02:07:41 +0800 (CST)
Received: from [10.45.148.63] (unknown [10.45.148.63])
        by APP1 (Coremail) with SMTP id LxC2BwD35HRri0ZlgEUKAA--.9205S2;
        Sat, 04 Nov 2023 19:20:41 +0100 (CET)
Message-ID: <4f5228b6-839c-9e04-bf7c-34fb8e25fd13@huaweicloud.com>
Date:   Sat, 4 Nov 2023 19:20:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [isocpp-parallel] OOTA fix (via fake branch-after-load)
 discussion
To:     "Alglave, Jade" <j.alglave@ucl.ac.uk>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "davidtgoldblatt@gmail.com" <davidtgoldblatt@gmail.com>,
        viktor@mpi-sws.org
References: <b1634b24-4541-49c5-867c-7f24292a27bb@paulmck-laptop>
 <AS4PR01MB89662350CF351ADA124816B0ACA5A@AS4PR01MB8966.eurprd01.prod.exchangelabs.com>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <AS4PR01MB89662350CF351ADA124816B0ACA5A@AS4PR01MB8966.eurprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwD35HRri0ZlgEUKAA--.9205S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4fCrWxZw1kZw18WrW3Wrg_yoWrAw15pa
        yfKr47Cw4DXrn3Jw1DKr4Uua4Yv3yktr43Krs8G348Ar90kr1IqF1fKa1FvFyDJryYkr4a
        qF4jg3s2g3sxArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Jade.

I agree with the position you linked to in that the move is... unwise.

IMO, for a high-level language like C, if you need to outrule OOTA, just 
declare it impossible (Viktor, in CC, made this suggestion a while ago) 
by a "no OOTA axiom".

BTW, is there at least a proof that just making relaxed atomics ordered 
in this way rules out OOTA in programs that contain non-atomics?
Or can we have something like the LKMM OOTA example I sent around last year?


best wishes,

jonas


Am 11/3/2023 um 6:02 PM schrieb Alglave, Jade:
> Dear all, (resending because I accidentally sent it in html first, sorry)
>
> Arm’s official position on the topic can be found in this recent blog:
> https://community.arm.com/arm-community-blogs/b/architectures-and-processors-blog/posts/arm-technical-view-on-relaxed-atomics
>
> Please do reach out to memory-model@arm.com if there are any questions.
> Thanks,
> Jade
>
>
> From: Paul E. McKenney <paulmck@kernel.org>
> Sent: 27 October 2023 22:08
> To: Alglave, Jade <j.alglave@ucl.ac.uk>; will@kernel.org <will@kernel.org>; catalin.marinas@arm.com <catalin.marinas@arm.com>; linux@armlinux.org.uk <linux@armlinux.org.uk>; mpe@ellerman.id.au <mpe@ellerman.id.au>; npiggin@gmail.com <npiggin@gmail.com>; palmer@dabbelt.com <palmer@dabbelt.com>; parri.andrea@gmail.com <parri.andrea@gmail.com>
> Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-toolchains@vger.kernel.org <linux-toolchains@vger.kernel.org>; peterz@infradead.org <peterz@infradead.org>; boqun.feng@gmail.com <boqun.feng@gmail.com>; davidtgoldblatt@gmail.com <davidtgoldblatt@gmail.com>
> Subject: Fw: [isocpp-parallel] OOTA fix (via fake branch-after-load) discussion
>
> ⚠ Caution: External sender
>
>
> Hello!
>
> FYI, unless someone complains, it is quite likely that C++ (and thus
> likely C) compilers and standards will enforce Hans Boehm's proposal
> for ordering relaxed loads before relaxed stores.  The document [1]
> cites "Bounding data races in space and time" by Dolan et al. [2], and
> notes an "average a 2.x% slow down" for ARMv8 and PowerPC.  In the past,
> this has been considered unacceptable, among other things, due to the
> fact that this issue is strictly theoretical.
>
> This would not (repeat, not) affect the current Linux kernel, which
> relies on volatile loads and stores rather than C/C++ atomics.
>
> To be clear, the initial proposal is not to change the standards, but
> rather to add a command-line argument to enforce the stronger ordering.
> However, given the long list of ARM-related folks in the Acknowledgments
> section, the future direction is clear.
>
> So, do any ARMv8, PowerPC, or RISC-V people still care?  If so, I strongly
> recommend speaking up.  ;-)
>
>                                                          Thanx, Paul
>
> [1] https://lukegeeson.com/blog/2023-10-17-A-Proposal-For-Relaxed-Atomics/
> [2] https://dl.acm.org/doi/10.1145/3192366.3192421
>
> ----- Forwarded message from David Goldblatt via Parallel <parallel@lists.isocpp.org> -----
>
> Date: Fri, 27 Oct 2023 11:09:18 -0700
> From: David Goldblatt via Parallel <parallel@lists.isocpp.org>
> To: SG1 concurrency and parallelism <parallel@lists.isocpp.org>
> Reply-To: parallel@lists.isocpp.org
> Cc: David Goldblatt <davidtgoldblatt@gmail.com>
> Subject: [isocpp-parallel] OOTA fix (via fake branch-after-load) discussion
>
> Those who read this list but not the LLVM discourse might be interested in:
> - This discussion, proposing `-mstrict-rlx-atomics`:
> https://discourse.llvm.org/t/rfc-strengthen-relaxed-atomics-implementation-behind-mstrict-rlx-atomics-flag/74473
> to enforce load-store ordering
> - The associated blog post here:
> https://lukegeeson.com/blog/2023-10-17-A-Proposal-For-Relaxed-Atomics/
>
> - David
>
> _______________________________________________
> Parallel mailing list
> Parallel@lists.isocpp.org
> Subscription: https://lists.isocpp.org/mailman/listinfo.cgi/parallel
> Link to this post: http://lists.isocpp.org/parallel/2023/10/4151.php
>
>
> ----- End forwarded message -----

