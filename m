Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA387CF734
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345358AbjJSLmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjJSLmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:42:24 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290A69F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:42:22 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 9FFE53200976;
        Thu, 19 Oct 2023 07:42:20 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 19 Oct 2023 07:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1697715740; x=1697802140; bh=U2
        gqYc9zqSX1Su7Bd7S3GZCjJ4GSS8Kq+u+LYXmTYRQ=; b=S9G5LX4fYsVuWGKoii
        mBG0HcarkUtMhdoal9QD1/AfKxCwoltpxDFNrn7mrHuEmd0E0SWDeXFoVfdsogVP
        p3MI1gej+pJ5un05zPJ3dXlBlpoVJrwjtJN37qpV3y/tnPmJeqlRjQueasGchLr1
        1bTWz5ZWmHB8zPZA9YjvoSfS48PV8ypwbBonhHL/7Herfy/aocZSsJc3GatUrnNl
        Qe2zP8m7t0eXIi4GLWrIP8NXsYV6ZuZedz0nPULxBt/37dgyYc7SP83B03p2wdU5
        ifruX6vfR8V9iT5NRI3wrhWD8Aif5s0LZOD/mCqZnFKxlXem15RGA8MQPOJlp4V6
        jUJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697715740; x=1697802140; bh=U2gqYc9zqSX1S
        u7Bd7S3GZCjJ4GSS8Kq+u+LYXmTYRQ=; b=CDBLOJycnB+uz4LLx5DvS/P01SjEA
        FAiRALNSsNQDpnRt39pgvZ/KlDtAo+caE+fOfTWTf2jSqU6tamHAK7VnWW0AUEMk
        t+I730RNrpZSgf0jF938D09y8N1+Jzu9svYkIy56++pQBOOuRcuX87Ux0RJ0XgfJ
        VURj3FjgIvhjTlZGaEgVVHslgkuz5auIgyIX50ABOi/j27abzxNp4ZmsYCVzW9KH
        EazCH8TnDTWpOJGqe7ltZEZKGRUfGNvouguWCPzggbmPVAuiPUTkupGF3uAx0Ak9
        Qb82rt0dSNlIuO99wX5X0vpVCoIKKaY3puq2XMGXslNrANLY/nZPaB+4g==
X-ME-Sender: <xms:GxYxZdk3O7B3Mp2Kx5uyeqcnR4udpan9Lrc5J1PDNau1X7jAKV62vw>
    <xme:GxYxZY3ZZS-iU5Y-5D-wootvjDVe_1P2Yaz_EHQVDrpDMXj65YC49Ugzz-nb11ITW
    0IYfI1FRccV-5VG_tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeeigdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:GxYxZTqnLnsQLCOFL-NC2o3KudcqCegiDi8KDwijx6HvKE5SK13hRg>
    <xmx:GxYxZdm7dhdz39mgXbdFmo7V5SKIGRFCPwNOE3MmKbJLr-cJBLBWZw>
    <xmx:GxYxZb21okDJ3JyvcTu_MwTzX9Vz0vj-38U5eMBzIjsLKlI1UPj9qQ>
    <xmx:HBYxZb-1aX_NFfG6Vu69nZIXBvGqZ3LdcpES1dpsgyeeQziDq28o0w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A6D0BB60089; Thu, 19 Oct 2023 07:42:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <6d3d4e4d-a2f6-493e-972c-a695efa37947@app.fastmail.com>
In-Reply-To: <ZTEKabxNdegsbxyv@apocalypse>
References: <cover.1697614386.git.andrea.porta@suse.com>
 <20231018122729.GA18556@willie-the-truck>
 <da4985cd-43db-4957-b841-7b8f6bf8f885@app.fastmail.com>
 <ZTEKabxNdegsbxyv@apocalypse>
Date:   Thu, 19 Oct 2023 13:41:59 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andrea della Porta" <aporta@suse.de>
Cc:     "Will Deacon" <will@kernel.org>,
        "Andrea della Porta" <andrea.porta@suse.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nik.borisov@suse.com, "Kees Cook" <keescook@chromium.org>
Subject: Re: [PATCH 0/4] arm64: Make Aarch32 compatibility enablement optional at boot
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023, at 12:52, Andrea della Porta wrote:
> On 14:44 Wed 18 Oct     , Arnd Bergmann wrote:
>> On Wed, Oct 18, 2023, at 14:27, Will Deacon wrote:
>> 
>> Right, I was going to reply along the same lines here: x86 is
>> a bit of a special case that needs this, but I believe all the
>> other architectures already guard the compat syscall execution
>> on test_thread_flag(TIF_32BIT) that is only set by the compat
>> binfmt loader.
>
> Are you referring to the fact that x86 can switch at will between 32- and 64-
> bit code?

No.

> Regarding the TIF_32BIT flag, thanks for the head-up. I still believe though
> that this mechanism can somehow break down in the future, since prohibiting
> 32 bit executable loading *and* blocking 32 bit compat syscall are two
> separate path of execution, held together by the architecture prohibiting
> to switch to A32 instructions by design. Breaking the first rule and embedding 
> wisely crafted A32 instruction in an executable is easy, while the difficult
> part is finding some 'reentrancy' to be able to do the execution state switch,
> as pinted out in https://lore.kernel.org/lkml/ZTD0DAes-J-YQ2eu@apocalypse/.
> I agree it's highly speculative and not something to be concerned right
> now, it's just a head up, should the need arise in the future.

There are (at least) five separate aspects to compat mode that are easy
to mix up:

1. Instruction decoding -- switching between the modes supported by the
   CPU (A64/A32/T32)
2. Word size -- what happens to the upper 32 bits of a register in
   an arithmetic operation
3. Personality -- Which architecture string gets returned by the
   uname syscall (aarch64 vs armv8) as well as the format of
   /proc/cpuinfo
4. system call entry points -- how a process calls into native or
   compat syscalls, or possibly foreign OS emulation
5. Binary format -- elf32 vs elf64 executables

On most architectures with compat mode, 4. and 5. are fundamentally
tied together today: a compat task can only call compat syscalls
and a native task can only call native syscalls. x86 is the exception
here, as it uses different instructions (int80, syscall, sysenter)
and picks the syscall table based on that instruction.

I think 1. and 2. are also always tied to 5 on arm, but this is
not necessarily true for other architectures. 3. used to be tied
to 5 on some architectures in the past, but should be independent
now.

>> Doing the reverse is something that has however come up in the
>> past several times and that could be interesting: In order to
>> run userspace emulation (qemu-user, fex, ...) we may want to
>> allow calling syscalls and ioctls for foreign ABIs in a native
>> task, and at that point having a mechanism to control this
>> capability globally or per task would be useful as well.
>> 
>> The compat mode (arm32 on arm64) is the easiest case here, but the
>> same thing could be done for emulating the very subtle architecture
>> differences (x86-64 on arm64, arm64 on x86_64, arm32 on x86-compat,
>> or any of the above on riscv or  loongarch).
>
> Really interesting, Since it's more related to emulation needs (my patch
> has another focus due to the fact that A64 can execute A32 natively),
> I'll take a look at this separately.

A64 mode (unlike some other architectures, notably mips64) cannot
execute A32 or T32 instructions without a mode switch, the three are
entirely incompatible on the binary level.

Many ARMv8-CPUs support both Aarch64 mode and Aarch32 (A32/T32),
but a lot of the newer ones (e.g. Apple M1/M2, Cortex-R82 or
Cortex-A715) only do Aarch64 and need user-space emulation to run
32-bit binaries.

    Arnd
