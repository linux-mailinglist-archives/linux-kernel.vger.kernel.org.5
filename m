Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588A2753FEA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 18:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbjGNQkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 12:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbjGNQko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 12:40:44 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CCC30EA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 09:40:42 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 2A2EB5C0145;
        Fri, 14 Jul 2023 12:40:39 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute1.internal (MEProxy); Fri, 14 Jul 2023 12:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1689352839; x=1689439239; bh=kQ
        J6nanw/Gf+ondUL1RERZfhMr2XYORbkVHQVTFcHys=; b=b5nXdElx1BlFo5UxTD
        DqeHWMQ5jm0nGq9ZxOMtgOd+iEIzORyNhMKs0+5FM17nWvo8pqk7Ox52WYEzXctl
        lZShhoo1Zo4bKASy2TIh/WHnEIbgFLHfx6w9rUUx9Qv140wxRzSsLBbstWFAUTFw
        W1BrI1gc455SZgMdFeNUoElAk5gfYL9McfUsiFEoU/tMhFg68uaX4h1aZ8nGFqXe
        tobU0OKEcsxbcn/WlHuprPXOuzp2Aye2dYRDpBZAypn3f9joVqXIkeG5i9fS+jU7
        Zr8KOiwWagfXvlmvfcfKggHUCxGbGPMbS6mwTJHG+rTt62f0vu8sqDUCaswzpU58
        KpgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689352839; x=1689439239; bh=kQJ6nanw/Gf+o
        ndUL1RERZfhMr2XYORbkVHQVTFcHys=; b=Bv2E6/nxnpFJFHn8kwCa3vJr9LTB3
        PErEf1quIZ64qg5tfBm4xwgAUAVY0MWE/346zH/RS9Vp2DtySzVKcMcL1DpaGv+w
        FJFGtj8uahUfC1iQIQd6gjgI/ZAvXlLlXhGNjJvoZlchN/2kK4V1iKiqHb3mxrJS
        7ML2lpVBOKjcpdjKSIiMv5HfiJir7VqXWxSdTECUBwNKiytR4Hm1L+ibb53cC4uw
        rHgaMNMXHHDsUlDhWu38/fjxz3k0MscVu56ooMPMzMGa31D5SGSTRciHmFp7w1HW
        CD2VF2vt5ZKiGjQ+XuIl2fyS8VDkMaNfSYe9jACqneRDKJ3sy9i5TKZKQ==
X-ME-Sender: <xms:hnqxZEEaqA8RymLNwfIFE18ufw3qiJZx4JQFkR65q7zGIuV0D_IRZw>
    <xme:hnqxZNWvC4xBGdzIHRV_-BF_wQ5yyTo_OxzSA86LRuNKwt9yazevVw3XCSU6UfxJ3
    w2mJFO_6-9-J0jA7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeeigddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufht
    vghfrghnucfqkdftvggrrhdfuceoshhorhgvrghrsehfrghsthhmrghilhdrtghomheqne
    cuggftrfgrthhtvghrnhepjeeuheegtdeuteeghfehjeejiefghfeifeejheduvdeugedt
    hfehvefggefgkedtnecuffhomhgrihhnpehinhhfrhgruggvrggurdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhorhgvrghrsehf
    rghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:hnqxZOKTr-YzB4sY7p5vqAEP6PiyBzQubHjxq1I3jhE2ZEckrkLHwQ>
    <xmx:hnqxZGFv2oyds4ocSivmJizKu-Ftiq_aK_WL1cVV2l361aheh6LFSQ>
    <xmx:hnqxZKVWwkArqhdKpsYtRNxORCktc6PEN9o-eS5DKz9M8Ihpi3lMaA>
    <xmx:h3qxZMKRxDrAVHS5F67S1emwAjZFt53y64LM2W3BrK3UeIOvUvPFeQ>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9F4EB1700089; Fri, 14 Jul 2023 12:40:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <0149f48c-57f8-4749-9c88-81937e30f6ef@app.fastmail.com>
In-Reply-To: <d25666da-8df2-dd6d-16cc-38b486c64f8f@kernel.org>
References: <20230711130754.481209-1-gerg@kernel.org>
 <20230711130754.481209-3-gerg@kernel.org>
 <31c4024b-3553-4117-a22a-b39259c8fea4@app.fastmail.com>
 <08905362-248c-e6af-d750-9d385ad543e3@kernel.org>
 <c5053fea-6ca2-4c8a-bf5f-1a59423e438a@app.fastmail.com>
 <d25666da-8df2-dd6d-16cc-38b486c64f8f@kernel.org>
Date:   Fri, 14 Jul 2023 12:40:18 -0400
From:   "Stefan O'Rear" <sorear@fastmail.com>
To:     "Greg Ungerer" <gerg@kernel.org>, linux-riscv@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     "Palmer Dabbelt" <palmer@dabbelt.com>, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, "Kees Cook" <keescook@chromium.org>,
        brauner@kernel.org
Subject: Re: [PATCH v2 2/2] riscv: support the elf-fdpic binfmt loader
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023, at 9:51 AM, Greg Ungerer wrote:
> On 14/7/23 00:26, Stefan O'Rear wrote:
>> On Thu, Jul 13, 2023, at 9:17 AM, Greg Ungerer wrote:
>>> On 13/7/23 01:12, Stefan O'Rear wrote:
>>>> On Tue, Jul 11, 2023, at 9:07 AM, Greg Ungerer wrote:
>>>>> Add support for enabling and using the binfmt_elf_fdpic program loader
>>>>> on RISC-V platforms. The most important change is to setup registers
>>>>> during program load to pass the mapping addresses to the new process.
>>>>>
>>>>> One of the interesting features of the elf-fdpic loader is that it
>>>>> also allows appropriately compiled ELF format binaries to be loaded on
>>>>> nommu systems. Appropriate being those compiled with -pie.
>>>>>
>>>>> Signed-off-by: Greg Ungerer <gerg@kernel.org>
>>>>> ---
>>>>> v1->v2: rebase onto linux-6.5-rc1
>>>>>           increment PTRACE_GETFDPIC value to keep it unique
>>>>>
>>>>>    arch/riscv/include/asm/elf.h         | 11 ++++++++++-
>>>>>    arch/riscv/include/asm/mmu.h         |  4 ++++
>>>>>    arch/riscv/include/uapi/asm/ptrace.h |  5 +++++
>>>>>    fs/Kconfig.binfmt                    |  2 +-
>>>>>    4 files changed, 20 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
>>>>> index c24280774caf..c33fe923ef6d 100644
>>>>> --- a/arch/riscv/include/asm/elf.h
>>>>> +++ b/arch/riscv/include/asm/elf.h
>>>>> @@ -41,6 +41,7 @@ extern bool compat_elf_check_arch(Elf32_Ehdr *hdr);
>>>>>    #define compat_elf_check_arch	compat_elf_check_arch
>>>>>
>>>>>    #define CORE_DUMP_USE_REGSET
>>>>> +#define ELF_FDPIC_CORE_EFLAGS	0
>>>>>    #define ELF_EXEC_PAGESIZE	(PAGE_SIZE)
>>>>>
>>>>>    /*
>>>>> @@ -69,6 +70,13 @@ extern bool compat_elf_check_arch(Elf32_Ehdr *hdr);
>>>>>    #define ELF_HWCAP	riscv_get_elf_hwcap()
>>>>>    extern unsigned long elf_hwcap;
>>>>>
>>>>> +#define ELF_FDPIC_PLAT_INIT(_r, _exec_map_addr, _interp_map_addr,
>>>>> dynamic_addr) \
>>>>> +	do { \
>>>>> +		(_r)->a1 = _exec_map_addr; \
>>>>> +		(_r)->a2 = _interp_map_addr; \
>>>>> +		(_r)->a3 = dynamic_addr; \
>>>>> +	} while (0)
>>>>> +
>>>>
>>>> This should probably be left empty for now; it will be defined by the
>>>> ELF FDPIC ABI when that is done, and shouldn't be used by normal ELF
>>>> binaries.
>>>
>>> True, not used by the ELF binaries themselves. But used by an ELF
>>> interpreter to do the runtime relocations.
>> 
>> By "normal ELF binaries", I mean binaries (executables and shared libraries
>> with nonzero e_entry, including statically linked binaries and the dynamic
>> linker itself) that conform to the psABI as it currently exists in
>> riscv-elf-psabi-doc.
>> 
>> These binaries don't use load maps because they aren't defined in
>> riscv-elf-psabi-doc yet.  At some point in the future, riscv-elf-psabi-doc
>> may define a FDPIC EI_OSABI value and rules for its usage; "FDPIC ELF
>> binaries" will not be "normal" and you will not be able to load them with
>> binfmt_elf or binfmt_elf_compat.
>>
>> "FDPIC elf binaries" which contain their own self-relocation code, including
>> the dynamic linker and statically linked binaries, will use the map and
>> dynamic addresses.
>
> Well, yes, none of that is specific to RISC-V though. Those same rules apply to
> FDPIC binaries on any architecture that supports it. FDPIC binaries can only
> be loaded by binfmt_elf_fdpic.
>
> The point I was trying to make is that with a normal ELF binary (with obvious
> limitations in the noMMU case - needs to be PIE, and not using shared libraries,
> etc) if those mappings are present a specially crafted ELF interpreter can
> use them to carry out the relocations and start that ELF binary. That ELF
> binary is not special and can be loaded and run by the the standard binfmt_elf
> ELF loader on an a fully MMU system (of course using the usual ELF interpreter
> on that system not the different noMMU one).

I agree with everything in these two paragraphs.

The point I'm trying to make is that the "specially crafted ELF interpreter"
doesn't need to use the load maps - all of the information in exec_loadmap and
dynamic can be obtained by scanning AT_PHDR and adding the an offset to all of
them such that the address of PT_PHDR is the value of AT_PHDR; all of the
information in interp_loadmap can be obtained using AT_BASE.

I believe that musl ldso is already designed to operate in this way and it
already has fallback code for read instead of failing mmaps, if you add
#define DL_NOMMU_SUPPORT 1 to arch/riscv64/reloc.h, although I haven't
tested it.  I do not understand the glibc or uclibc interpreters well enough
to make statements about them.

>> elf_check_fdpic will return 1 for binaries that use the FDPIC EI_OSABI and
>> use the load maps as part of either their own or their interpreter's
>> startup code.  For binaries where elf_check_fdpic returns 0, the contents
>> of ELF_FDPIC_PLAT_INIT is (harmless) dead stores.
>
> I don't follow. On other architectures that binfmt_elf-fdpic supoprts (so ARM,
> SH, M68K currently; historically some other removed architectures too) the
> contents of ELF_FDPIC_PLAT_INIT are always run if defined. Even in the case of
> loading a standard ELF binary. Those mappings are loaded into some registers
> and those appear in the running process on startup.

Dead in the sense that there is no way for a constdisp ELF executable, which
must run correctly with binfmt_elf, to make use of them - if I have understood
ELF_PLAT_INIT and start_thread correctly, RISC-V executables and interpreters
currently start with garbage from the pre-execve state in all integer registers
other than sp, so there is no way to distinguish "valid load maps" from
"nonzero values from previous image".

-s

>> We don't have an implementation of elf_check_fdpic yet, which means that
>> we cannot load binaries that actually use the load maps and the
>> ELF_FDPIC_PLAT_INIT is dead code.  Dead code which is unlikely to conform
>> to the future ABI, since the RISC-V psABI Task Group has yet to choose
>> which registers to use to pass the load maps.  Since the code is dead and
>> likely wrong, it should be removed so that correct code can be added at
>> the correct time.
>
> I understand your reluctance here.
>
> Regards
> Greg
>
>
>> -s
>> 
>>>> I'd ask if there's a reason it starts at a1 instead of a0,
>>>> but it seems idiosyncratic on all arches that have full FDPIC support.
>>>
>>> This comment in the crt1.S code of uClibc made me think that a0 already had
>>> a pre-defined use in the ABI:
>>>
>>>       /* The entry point's job is to call __uClibc_main.  Per the ABI,
>>>          a0 contains the address of a function to be passed to atexit.
>>>
>>> But I didn't dig any further than that.
>>>
>>> Regards
>>> Greg
>>>
>>>
>>>> -s
>>>>
>>>>>    /*
>>>>>     * This yields a string that ld.so will use to load implementation
>>>>>     * specific libraries for optimization.  This is more specific in
>>>>> @@ -78,7 +86,6 @@ extern unsigned long elf_hwcap;
>>>>>
>>>>>    #define COMPAT_ELF_PLATFORM	(NULL)
>>>>>
>>>>> -#ifdef CONFIG_MMU
>>>>>    #define ARCH_DLINFO						\
>>>>>    do {								\
>>>>>    	/*							\
>>>>> @@ -115,6 +122,8 @@ do {								\
>>>>>    	else							 \
>>>>>    		NEW_AUX_ENT(AT_IGNORE, 0);			 \
>>>>>    } while (0)
>>>>> +
>>>>> +#ifdef CONFIG_MMU
>>>>>    #define ARCH_HAS_SETUP_ADDITIONAL_PAGES
>>>>>    struct linux_binprm;
>>>>>    extern int arch_setup_additional_pages(struct linux_binprm *bprm,
>>>>> diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
>>>>> index 0099dc116168..355504b37f8e 100644
>>>>> --- a/arch/riscv/include/asm/mmu.h
>>>>> +++ b/arch/riscv/include/asm/mmu.h
>>>>> @@ -20,6 +20,10 @@ typedef struct {
>>>>>    	/* A local icache flush is needed before user execution can resume. */
>>>>>    	cpumask_t icache_stale_mask;
>>>>>    #endif
>>>>> +#ifdef CONFIG_BINFMT_ELF_FDPIC
>>>>> +	unsigned long exec_fdpic_loadmap;
>>>>> +	unsigned long interp_fdpic_loadmap;
>>>>> +#endif
>>>>>    } mm_context_t;
>>>>>
>>>>>    void __init create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t
>>>>> pa,
>>>>> diff --git a/arch/riscv/include/uapi/asm/ptrace.h
>>>>> b/arch/riscv/include/uapi/asm/ptrace.h
>>>>> index e17c550986a6..30f6d6537adc 100644
>>>>> --- a/arch/riscv/include/uapi/asm/ptrace.h
>>>>> +++ b/arch/riscv/include/uapi/asm/ptrace.h
>>>>> @@ -10,6 +10,11 @@
>>>>>
>>>>>    #include <linux/types.h>
>>>>>
>>>>> +#define PTRACE_GETFDPIC		33
>>>>> +
>>>>> +#define PTRACE_GETFDPIC_EXEC	0
>>>>> +#define PTRACE_GETFDPIC_INTERP	1
>>>>> +
>>>>>    /*
>>>>>     * User-mode register state for core dumps, ptrace, sigcontext
>>>>>     *
>>>>> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
>>>>> index 93539aac0e5b..f5693164ca9a 100644
>>>>> --- a/fs/Kconfig.binfmt
>>>>> +++ b/fs/Kconfig.binfmt
>>>>> @@ -58,7 +58,7 @@ config ARCH_USE_GNU_PROPERTY
>>>>>    config BINFMT_ELF_FDPIC
>>>>>    	bool "Kernel support for FDPIC ELF binaries"
>>>>>    	default y if !BINFMT_ELF
>>>>> -	depends on ARM || ((M68K || SUPERH || XTENSA) && !MMU)
>>>>> +	depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !MMU)
>>>>>    	select ELFCORE
>>>>>    	help
>>>>>    	  ELF FDPIC binaries are based on ELF, but allow the individual load
>>>>> -- 
>>>>> 2.25.1
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> linux-riscv mailing list
>>>>> linux-riscv@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>>
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
