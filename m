Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FAD78D33E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 08:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239797AbjH3GR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 02:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239964AbjH3GR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 02:17:26 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216B1CD6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 23:17:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c0c6d4d650so41079565ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 23:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693376241; x=1693981041; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W1p+bOz4bWgBx0gBztPl4C9Y4dLhVMixMdbZewEnwno=;
        b=rhjBzVkgH2Hpzv0I17ideXu6vk6oBMXIqkYVKAD46XQC0W51LuaiAyUuIuRTD3Ytpw
         Uz3375WAL1LrQ0OVlhlCQ74JUrRSPrpbcWuqeB3g713WumrvGQuyyhnE/crOu7GIng9I
         5N2rbpKUlOljf+x9ApJALwU6As8HxqUNMeSByq3XGs+LXGYEWK7pCdqKwYG3hclEjVvm
         dNlUH9GvDs2cCIpVSDy9EJXppiOaYKSjgK25bXAif4dlSLWVfBUOb4p/kgSoqIs0e8S0
         tIsq51Y8lBbhXATCTNV9EzsHXbOkr3oi4LCMkqHXEKJ7BWrMRMVRrgq75RLeQII8FgYk
         Uqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693376241; x=1693981041;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W1p+bOz4bWgBx0gBztPl4C9Y4dLhVMixMdbZewEnwno=;
        b=Imia2qTJS7lDb6BEIZHmo83SIAq8Z92uCv2wYXWlHUnmOA77D3JCWejSHmFC5j4nNF
         oKj75GtyWOXfknXwEZ2sLmzfeABiHKUzuTfquKl9k4jyO8lfrb8hv+0P++C+KQkjs5Kj
         BWeaevD6xQYAbOnT0TkJlmHoeYOHo4/KP343dnf8Kc/LwRB9phPBs/eG+YPpHwRFWccB
         qAKaMs0p7QjeBmbMa7fRyPeepfkMHf+ZdyZqqn8NrF7CLapsQLzG6vYbdUu6ZgCrQzY7
         4QI/Gk0xB475S1VdS6xW9N6q5ItEPFZisobbZdSw234SKsg9PVGtI/Lt/+55bZ3wA0lp
         3WcA==
X-Gm-Message-State: AOJu0YxM+0yBRqsbUkcNcdC4hMrdogdijE3GAQEv2yqTXAffZkF4KLFY
        veyQy6UaD3T6OEa8rq4SycGwxA==
X-Google-Smtp-Source: AGHT+IHUpkWj0jMQVE2oYAAsYdpGkt9SXED76gIwBdRAjVYnH7Cdt2X2aNCpGV3hPrPQGkdCToAMDA==
X-Received: by 2002:a17:902:6a86:b0:1bf:4a1f:2b57 with SMTP id n6-20020a1709026a8600b001bf4a1f2b57mr1235180plk.13.1693376241475;
        Tue, 29 Aug 2023 23:17:21 -0700 (PDT)
Received: from leoy-huanghe.lan (211-75-219-203.hinet-ip.hinet.net. [211.75.219.203])
        by smtp.gmail.com with ESMTPSA id jg12-20020a17090326cc00b001b8b07bc600sm10340601plb.186.2023.08.29.23.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 23:17:20 -0700 (PDT)
Date:   Wed, 30 Aug 2023 14:17:16 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     scclevenger@os.amperecomputing.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        yang@os.amperecomputing.com
Subject: Re: About ARM64 Kernel Instruction Trace
Message-ID: <20230830061716.GC20080@leoy-huanghe.lan>
References: <ed8cea4c-a261-60ca-f4e1-333ec73cca8f@os.amperecomputing.com>
 <15c1cc81-c131-7abf-1680-0bbc968e638b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15c1cc81-c131-7abf-1680-0bbc968e638b@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 01:55:45PM +0100, James Clark wrote:

[...]

> > Ostensibly, the ‘perf record –kcore’ option produces a representative
> > image of the kernel. But this option does not produce suitable output to
> > generate ARM64 kernel instruction trace. perf doesn’t disassemble ARM64,
> > so the arm-cs-trace-disasm.py python script is used with the native
> > objdump utility to provide ARM64 disassembly from CoreSight trace
> > capture. objdump itself requires an ELF/DWARF file image + symbols to
> > generate the symbolic (+ line information for mixed source) disassembly.
> > The linux vmlinux image + symbols file is typically used for this
> > purpose. The kallsyms file is not formatted for objdump use. As an
> > experiment, I patched the executable code sections in a local copy of
> > vmlinux with the corresponding executable code segments extracted from
> > the kcore image using an Ampere internal ELF patch utility.
> > 
> > This patch utility leverages the (MIT Licensed) ELFIO open source
> > library API. These were the commands.
> > 
> > 
> > [root@sut01sys-b212 kernel]# timeout 30s perf record --kcore -o kcore -e
> > cs_etm/@tmc_etr63/k --per-thread taskset --cpu-list 15 dd if=/dev/zero
> > of=/dev/null
> > [ perf record: Woken up 25 times to write data ]
> > [ perf record: Captured and wrote 88.053 MB kcore ]
> > [root@sut01sys-b212 kernel]#
> > [root@sut01sys-b212 kernel]# ls -l ~/linux/vmlinux
> > -rwxr-xr-x. 1 root root 390426912 Jun 30 12:54 /home/stevec/linux/vmlinux*
> > [root@sut01sys-b212 kernel]# cp ~/linux/vmlinux .
> > [root@sut01sys-b212 kernel]# patch-elf --help
> > 
> > patch-elf overlays the kernel image from a local copy of
> > '/proc/kcore' to the  corresponding (by address) ELF sections
> > in a local copy of the vmlinux ELF file.
> > A local '/proc/kcore' is created by:
> >     'perf report --kcore -e cs_etm/@tmc_etr1/k ...'
> > The local (patched) vmlinux copy is used by:
> >     'perf script -s arm-cs-trace-disasm.py ...'
> > See the CoreSight Hardware-Assisted Trace Application Note for
> > use of the 'perf report' and 'perf script' commands.
> > 
> > Usage: patch-elf <--verbose> kcore_file vmlinux_file
> > [root@sut01sys-b212 kernel]#
> > [root@sut01sys-b212 kernel]# patch-elf kcore/kcore_dir/kcore ./vmlinux
> > ELF File kcore Properties
> > ELF file class:     ELF64
> > ELF file encoding:  Little endian
> > Machine:            ARM AArch64
> > Type:               Core file
> > Number of segments: 3
> > Number of sections: 0
> > 
> > ELF File vmlinux Properties
> > ELF file class:     ELF64
> > ELF file encoding:  Little endian
> > Machine:            ARM AArch64
> > Type:               Shared object file
> > Number of segments: 3
> > Number of sections: 43
> > 
> > Patching section[ 2] ffff800008010000  17997936 bytes
> > 
> > Patching section[15] ffff800009a31000  20480 bytes
> > 
> > Patching section[16] ffff800009a40000  612372 bytes
> > 
> > Patching section[17] ffff800009ad5818  24752 bytes
> > 
> > [root@sut01sys-b212 kernel]# ls -l ./vmlinux
> > -rwxr-xr-x. 1 root root 390426908 Jul 19 11:14 ./vmlinux*
> > [root@sut01sys-b212 kernel]#
> > [root@sut01sys-b212 kernel]# timeout 45s perf script --input
> > ./kcore/data -s ../../scripts/arm-cs-trace-disasm.py -F
> > cpu,event,ip,addr,sym – -d objdump -k ./vmlinux > ./perf.itrace
> > [root@sut01sys-b212 kernel]#
> > [root@sut01sys-b212 kernel]# ls -l perf.itrace
> > -rw-r--r--. 1 root root  32142060 Jul 19 11:18 perf.itrace
> > 
> > Here is the representative kernel instruction trace using a patched vmlinux.
> > 
> >         .
> >         .
> >         ffff800008ab89a8:       1400000d        b       ffff800008ab89dc
> > <read_zero+0xd4>
> >               dd  8774/8774  [0015]         0.000000000  read_zero+0xa0
> >         ffff800008ab89dc <read_zero+0xd4>:
> >         ffff800008ab89dc:       9248f840        and     x0, x2,
> > #0xff7fffffffffffff
> >         ffff800008ab89e0:       aa1403e1        mov     x1, x20
> >         ffff800008ab89e4:       9418b6fb        bl      ffff8000090e65d0
> > <__arch_clear_user>
> >               dd  8774/8774  [0015]         0.000000000  read_zero+0xdc
> > ffff8000090e65d0 <__arch_clear_user>:
> >         ffff8000090e65d0:       d503245f        bti     c
> >         ffff8000090e65d4:       8b010002        add     x2, x0, x1
> >         ffff8000090e65d8:       f1002021        subs    x1, x1, #0x8
> >         ffff8000090e65dc:       54000104        b.mi    ffff8000090e65fc
> > <__arch_clear_user+0x2c>  // b.first
> >         ffff8000090e65e0:       f800081f        sttr    xzr, [x0]
> >         ffff8000090e65e4:       91002000        add     x0, x0, #0x8
> >         ffff8000090e65e8:       f1002021        subs    x1, x1, #0x8
> >         ffff8000090e65ec:       54ffffa8        b.hi    ffff8000090e65e0
> > <__arch_clear_user+0x10>  // b.pmore
> >               dd  8774/8774  [0015]         0.000000000
> > __arch_clear_user+0x1c
> >         ffff8000090e65e0 <__arch_clear_user+0x10>:
> >         ffff8000090e65e0:       f800081f        sttr    xzr, [x0]
> >         ffff8000090e65e4:       91002000        add     x0, x0, #0x8
> >         ffff8000090e65e8:       f1002021        subs    x1, x1, #0x8
> >         ffff8000090e65ec:       54ffffa8        b.hi    ffff8000090e65e0
> > <__arch_clear_user+0x10>  // b.pmore
> >         .
> >         .
> >         ffff8000090e65f0:       f81f885f        sttr    xzr, [x2, #-8]
> >         ffff8000090e65f4:       d2800000        mov     x0, #0x0
> >                // #0
> >         ffff8000090e65f8:       d65f03c0        ret
> >               dd  8774/8774  [0015]         0.000000000
> > __arch_clear_user+0x28
> > ...vec/linux/arch/arm64/lib/clear_user.S   34         ret
> >         ffff800008ab89e8 <read_zero+0xe0>:
> >         ffff800008ab89e8:       d503201f        nop
> >         ffff800008ab89ec:       1400000b        b       ffff800008ab8a18
> > <read_zero+0x110>
> >               dd  8774/8774  [0015]         0.000000000  read_zero+0xe4
> >                          /home/stevec/linux/drivers/char/mem.c     521
> >               left = clear_user(buf + cleared, chunk);
> >         ffff800008ab8a18 <read_zero+0x110>:
> >         ffff800008ab8a18:       8b14035a        add     x26, x26, x20
> >         ffff800008ab8a1c:       b5000360        cbnz    x0,
> > ffff800008ab8a88 <read_zero+0x180>
> >         ffff800008ab8a20:       f9400320        ldr     x0, [x25]
> >         ffff800008ab8a24:       cb140273        sub     x19, x19, x20
> >         .
> >         .
> >         .
> > 
> > This begs the question what perf enhancements could be added to make
> > ARM64 kernel instruction trace easier to use? The process I’ve followed
> > is cumbersome, but could be done behind the scenes by perf. The caveat
> > is it requires a vmlinux which might not be available to an end user.
> > Here are 2 options.
> > 
> > 1.	'perf report -kcore'could use the process I’ve used here
> > transparently in the background. The plus side is the objdump feature of
> > mixed disassembly is available based on the current vmlinux.
> > 
> 
> Hi Steve,
> 
> What you're saying makes sense to me. I think #1 sounds best, I'm not
> sure of the use-case where you wanted to make actionable decisions from
> the trace but wouldn't have vmlinux available? Maybe an end-user could
> be missing it, but I can only imagine use cases where you are actively
> building and developing the kernel.

Some inputs for this topic.

The doc tools/perf/Documentation/perf.data-directory-format.txt gives
hint that 'perf script' can use the kcore file for kernel data.  Based
on this, we might can explore the approaches provided in
tools/perf/scripts/python/Perf-Trace-Util/Context.c, so we can rely on
perf's DSO and map to dump instructions and source lines.

intel-pt-events.py (intel-pt trace dump script) uses above method to
dump instructions and source lines.

> > 2.	'perf report -kcore' generates an ELF + symbols file based on
> > kallsyms (and/or System.map). No vmlinux patching, so intermixed source
> > and disassembly wouldn’t be available. It’s a reasonable alternative
> > without relying on vmlinux.
> > 
> > It makes sense performance-wise to use an ARM64 disassembler directly
> > through perf. perf-script use of the arm-cs-trace-disasm.py python
> > script can be slow. I’m unfamiliar with the Intel implementation, but
> > perf-annotate uses objdump. Unfortunately, I can't seem to get annotate
> > to work for me. A patch operation is still be required if vmlinux is used.
> > 
> 
> We have had other reports about arm-cs-trace-disasm.py being slow.

Yeah, this is a known issue.  I can think about a improvement is that we
can dump the source and disassembly once for the whole kernel and save
into memory (e.g. save into a variable in python script or in the C
program), then afterwards we can just read out the info from the variable
based on the start and end address, this can avoid to call objdump for
every code chunk.

Before we proceed for this, I think it's good to see if we can use
Perf-Trace-Util/Context.c to speed up trace dumping.

Thanks,
Leo
