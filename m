Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE8B7CA667
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjJPLPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjJPLPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:15:00 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147B7B4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:14:59 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9adb9fa7200so902052266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697454897; x=1698059697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SzUmRy//RDHdVSKv4lb0r/0JXORo2co7Q+ttFZAYJA0=;
        b=CIO8cUG84T4KT0iiNBl4qcjHtxmcBEb0J90njykPVEqazPEcwEOpYJfFBTlSy1KrqV
         dIcy6YVIWscDxLdl9e9mE6nL61wtbRwiX7wD+VoEI4IQaHUOs0lT4rDeq3+/KjBKpFIM
         HtRhV8HDSG96r6zwr66zwatwf/Cs+fE5+/ZX6f/yBmGytQcRv0ZcMY93ETEHQ2VbIUjl
         LK1UKeD9Igndei3aUdzidAXFa1cMB7LpKAKXJYeh5h5JLuFZo7nhs+kHnzkR5g2m4+af
         D+hrYGY9kn/smG6u21+Rm+kKbE2Ki6FnRy20DE45p0KSnvLErqLQ4x+ZQq2FAIDNIY6d
         xE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697454897; x=1698059697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzUmRy//RDHdVSKv4lb0r/0JXORo2co7Q+ttFZAYJA0=;
        b=dZAmyVODjorXW21X5ATspyKYIDQiN+PB2h4xceqUBjIUUcJV5w/a3OPyVvH3nNHHwV
         dkSJzUF5YTGeG6r24/GTiLwhaErtgaPNml3linl7kmJ6X/vudRqongmcmHITylYLvea/
         QkgT6fbydM4Kk01tJgrP790BecCh0aMxCA0bAL5As/E63joQBf+SQNaLn90m9CaCdO6T
         inl/prwXxP+9LTzj/C/YiBpA9WkjCDYxytnOw3OEtUJHiAVmFALOF8SZBFjf/aP0XorD
         yjJGzU5GeJxqU/DDUw/CcCUdz7MVXBsNrYA4ha72Wx3qigcpQRmvJ3OqrSjoEbPjdWiE
         0eFg==
X-Gm-Message-State: AOJu0Yw+Gc0oNl/ksgjl/LGlp8oBKYyPwswYSRqvXNDtA5lKY8wbBtq8
        r1TZE/w3jI1J4DEYr0dPvvs=
X-Google-Smtp-Source: AGHT+IEXeN9iWVFmnPQXSNXHhS9aGAWff1FHoFKp8Ovu4zJZDQyJfOHIOsuUuuhFAfdChU8Fqr8oOw==
X-Received: by 2002:a17:906:c10c:b0:9bd:81c3:2a85 with SMTP id do12-20020a170906c10c00b009bd81c32a85mr5637689ejc.32.1697454897298;
        Mon, 16 Oct 2023 04:14:57 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id 30-20020a170906009e00b009ae587ce135sm3842482ejc.223.2023.10.16.04.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 04:14:56 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 16 Oct 2023 13:14:54 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH -tip 3/3] x86/percpu: *NOT FOR MERGE* Implement
 arch_raw_cpu_ptr() with RDGSBASE
Message-ID: <ZS0bLvcC46tHjM/G@gmail.com>
References: <20231015202523.189168-1-ubizjak@gmail.com>
 <20231015202523.189168-3-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231015202523.189168-3-ubizjak@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Uros Bizjak <ubizjak@gmail.com> wrote:

> Sean says:
> 
> "A significant percentage of data accesses in Intel's TDX-Module[*] use
> this pattern, e.g. even global data is relative to GS.base in the module
> due its rather odd and restricted environment.  Back in the early days
> of TDX, the module used RD{FS,GS}BASE instead of prefixes to get
> pointers to per-CPU and global data structures in the TDX-Module.  It's
> been a few years so I forget the exact numbers, but at the time a single
> transition between guest and host would have something like ~100 reads
> of FS.base or GS.base.  Switching from RD{FS,GS}BASE to prefixed accesses
> reduced the latency for a guest<->host transition through the TDX-Module
> by several thousand cycles, as every RD{FS,GS}BASE had a latency of
> ~18 cycles (again, going off 3+ year old memories).
> 
> The TDX-Module code is pretty much a pathological worth case scenario,
> but I suspect its usage is very similar to most usage of raw_cpu_ptr(),
> e.g. get a pointer to some data structure and then do multiple
> reads/writes from/to that data structure.
> 
> The other wrinkle with RD{FS,FS}GSBASE is that they are trivially easy

[ Obsessive-compulsive nitpicking:

     s/RD{FS,FS}GSBASE
      /RD{FS,GS}BASE
]

> to emulate. If a hypervisor/VMM is advertising FSGSBASE even when it's
> not supported by hardware, e.g. to migrate VMs to older hardware, then
> every RDGSBASE will end up taking a few thousand cycles
> (#UD -> VM-Exit -> emulate).  I would be surprised if any hypervisor
> actually does this as it would be easier/smarter to simply not advertise
> FSGSBASE if migrating to older hardware might be necessary, e.g. KVM
> doesn't support emulating RD{FS,GS}BASE.  But at the same time, the whole
> reason I stumbled on the TDX-Module's sub-optimal RD{FS,GS}BASE usage was
> because I had hacked KVM to emulate RD{FS,GS}BASE so that I could do KVM
> TDX development on older hardware.  I.e. it's not impossible that this
> code could run on hardware where RDGSBASE is emulated in software.
> 
> {RD,WR}{FS,GS}BASE were added as faster alternatives to {RD,WR}MSR,
> not to accelerate actual accesses to per-CPU data, TLS, etc.  E.g.
> loading a 64-bit base via a MOV to FS/GS is impossible.  And presumably
> saving a userspace controlled by actually accessing FS/GS is dangerous
> for one reason or another.
> 
> The instructions are guarded by a CR4 bit, the ucode cost just to check
> CR4.FSGSBASE is probably non-trivial."

BTW., a side note regarding the very last paragraph and the CR4 bit ucode 
cost, given that SMAP is CR4 controlled too:

 #define X86_CR4_FSGSBASE_BIT    16 /* enable RDWRFSGS support */
 #define X86_CR4_FSGSBASE        _BITUL(X86_CR4_FSGSBASE_BIT)
 ...
 #define X86_CR4_SMAP_BIT        21 /* enable SMAP support */
 #define X86_CR4_SMAP            _BITUL(X86_CR4_SMAP_BIT)

And this modifies the behavior of STAC/CLAC, of which we have ~300 
instances in a defconfig kernel image:

  kepler:~/tip> objdump -wdr vmlinux | grep -w 'stac' x | wc  -l
  119

  kepler:~/tip> objdump -wdr vmlinux | grep -w 'clac' x | wc  -l
  188

Are we certain that ucode on modern x86 CPUs check CR4 for every affected 
instruction?

Could they perhaps use something faster, such as internal 
microcode-patching (is that a thing?), to turn support for certain 
instructions on/off when the relevant CR4 bit is modified, without
having to genuinely access CR4 for every instruction executed?

Thanks,

	Ingo
