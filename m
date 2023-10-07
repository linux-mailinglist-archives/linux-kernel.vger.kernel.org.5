Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D347BC9D5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 22:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344167AbjJGUnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 16:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344151AbjJGUnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 16:43:31 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F18E93;
        Sat,  7 Oct 2023 13:43:29 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 282563200A41;
        Sat,  7 Oct 2023 16:43:28 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute5.internal (MEProxy); Sat, 07 Oct 2023 16:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696711407; x=1696797807; bh=Jd
        6oPV1HwL3F0QLUt2/FiCFCe/IH/cVqDsjrmGPSj08=; b=PcbdYMujupkVriXQqs
        nxdE2yb0NKJK03O8nigY9gnDF4ryRVi81s4Ql7hIQoqL/oB9hIrWuL2fYkv+w7z+
        QWUSKwMTFJHKJV9yPM1kNsRkCqoHpTUBp/eBgb3L0mdfeQLlKZ/Q4BfBJvzcMs2h
        XwksBGE+sOPkPxsDHxaJZJfI7HwcThXLOGJWa1COswoS+CilKoP3QpILKAr1l3tD
        G0RjMroZmrZQHVOalenDRm0SvulC0D6v8SPkMBdKMu78J+bTH71p1BYsdWP4LN5T
        wqgw3J0IeUmQamPEfbCSRZWSTchHBBzmPmCZd1YLQhVVlh2OyzusrtD5fHQ+O6AC
        2XPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696711407; x=1696797807; bh=Jd6oPV1HwL3F0
        QLUt2/FiCFCe/IH/cVqDsjrmGPSj08=; b=G7pisHS29ez4Ol95QqqbusGJhoNNJ
        pAsabspLytCgj8DLReaWzIm37dEA+HPsgSttggb7GLGl0mKboZ6zRzEULwDd3BpV
        zU0XbPu8jQlg5wtgmxnlm4sZNGDuTC9mzt8Q7kcx2YSD20nukAkqv1tANMn1sVg+
        l3VfFEAfgiJ9zE5xSJvEgX1h/rjZ0y3l3zmiIluYmbgKsSvOTftV2Srzojzjunvr
        TCQr8SEa66GJf2clQ20rzgTJ/d4O+pJXQ/Jo9cP5edRK/oOX7lveK0iqyROT5RQE
        OlRI04Mdja+ylFoltGOmjA9mjgmrz0mHLXWFCL3I/P27Hn6/oDCBQAqug==
X-ME-Sender: <xms:7sIhZZFhBKHrMsWHLQ4zGOJ7owyyT2VbzInwF4N9e8urmVyfbKLAkA>
    <xme:7sIhZeXsJ3Z-HUsXQG1LJrUCEFX-RIHOvN8aytEev0Mj58M0Udsl9vfw_xWKKcfS-
    pwZBGrGaAiGWbPHSqM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeelgdduhedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:7sIhZbLzUR6vB6xPR6lsD7j2SIeliFn5jIIZqk2YAUv961Na_0i5Nw>
    <xmx:7sIhZfEa0tLbzsd_ByT8eBFtRMD3ba4hGhQpdAxedXwW-OL-ypRzHQ>
    <xmx:7sIhZfXCGZgPKR9acScDMctWGIvNOZaOxQ7-NwcS4l4jHu1akZrEVA>
    <xmx:78IhZchZnLA6eEMzNChcHlX-lvzo3H2Lj4kxnNBBTo0Cw5xXHwzmmg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7825E1700089; Sat,  7 Oct 2023 16:43:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <c289bdb9-a1ec-4929-9ebf-1713a0b38e33@app.fastmail.com>
In-Reply-To: <20231007132935.6276-1-falcon@tinylab.org>
References: <3a8f0d0a-25ad-49c3-9cd2-66db44a4a1e6@app.fastmail.com>
 <20231007132935.6276-1-falcon@tinylab.org>
Date:   Sat, 07 Oct 2023 22:43:06 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Zhangjin Wu" <falcon@tinylab.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, "Tim Bird" <tim.bird@sony.com>
Subject: Re: [PATCH v1 6/7] DCE/DSE: riscv: add HAVE_TRIM_UNUSED_SYSCALLS support
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 7, 2023, at 15:29, Zhangjin Wu wrote:
>> On Tue, Sep 26, 2023, at 00:42, Zhangjin Wu wrote:
>> > For HAVE_TRIM_UNUSED_SYSCALLS, the syscall tables are hacked with the
>> > inputing unused_syscalls.
>> >
>> > Firstly, the intermediate preprocessed .i files are generated from the
>> > original C version of syscall tables respectively, and named with a
>> > 'used' suffix: syscall_table_used.i, compat_syscall_table_used.i.
>> >
>> > Secondly, all of the unused syscalls are commented.
>> >
>> > At last, two new objective files sufixed with 'used' are generated from
>> > the hacked .i files and they are linked into the eventual kernel image.
>> >
>> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
>> 
>> As mentioned in my comment on the mips patch, hacking the preprocessed
>> file here is too much strain on the old infrastructure, the
>> asm-generic/unistd.h file is already too hard to understand for
>> anyone and in need of an overhaul, so let's work together on fixing
>> it up first.
>>
>
> Ok, I was thinking about using asm/syscall_table.h instead of 
> asm/unistd.h like mips.
>
>     void * const sys_call_table[NR_syscalls] = {
>     	[0 ... NR_syscalls - 1] = __riscv_sys_ni_syscall,
>     #include <asm/syscall_table.h>
>     };
>
> Therefore, we can generate syscall_table.h from asm/unist.h with a tool 
> like scripts/syscallused.sh
>
> Another solution may be firstly generate a list of `#define __USED_NR_##call 1`
> for the used syscalls from Kconfig symbol, and then change __SYSCALL() macro
> to:
>
>    #define __SYSCALL(nr, call)     [nr] = 
> __is_defined(__USED_NR_##call) ? __riscv_##call : 
> __riscv_sys_ni_syscall,
>
> `include/linux/kconfig.h` defined the '__is_defined'.
>
> This method may work for the archs with .tbl files too.

Right, either way would be much better than than your first
approach. For the mips version (and all the other
traditional architectures that use the syscall.tbl method)
I think I'd integrate the filtering in scripts/syscalltbl.sh
if we decide to go that way. For the riscv version
(and all the others using asm-generic/unistd.h), the
__USED_NR_## macro would be fine as an intermediate
step, until we manage to convert those to syscall.tbl
parsing.

On the other hand, based on the earlier findings, my
overall feeling is that we're better off not adding
the extra indirection at all, but instead add the
more Kconfig symbols to control the largest groups
of syscalls, with the hope of conditionally removing
additional code for each of these symbols beyond the
automatic gc-section logic.

      Arnd
