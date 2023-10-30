Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0907DBF90
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 19:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjJ3SQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 14:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJ3SPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 14:15:52 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377EABD
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 11:15:49 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-27db9fdec0dso4129757a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 11:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1698689748; x=1699294548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XmnI5qBbSMZl1OWF9Q0rVzehwSZZifS0Ca/lJsm0aEQ=;
        b=WkuxvrbT/NEPCGxNewpViuN5VI1z0AhZfB0kMGvPLMw9O0hoejiz7hLrJq5IZ/xCn8
         tscLj4fSnAxU8jXvcLJwXx0WNkmoUH7mEHvaJoWAWuFtn06kCYF/GoEuRfBH1rfaxW2F
         /mDj5eY4Fx6JzG20eCP8Q9loogAkVM9N+Oz7cCLklVllPqWvxPE0E1VM7Ha1emrOTD6t
         5+LuxaUzc+NfpzkQTlfJHL5Na0OnEw2YSQQO76koa6ai4H/XHSIWiDP0iTRiNl2JVHX+
         c1EGiPfld/93JGgAucnvtXEWSUTvtgaHpwVVBivOtNXPx/RB4QqJ76Yq5+IHXohmiyT9
         Teng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698689748; x=1699294548;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmnI5qBbSMZl1OWF9Q0rVzehwSZZifS0Ca/lJsm0aEQ=;
        b=iEvEoPYAtsKJS2+39NzuSQZtMcQK5+QQ4BDNoMQ9UI9EMw/Jox3MPSATRi03DUQo3J
         5wC+jQe1VnDkBbBgtFTyiO+tWRjIHpj0KcBUvHSJgovRc383pPPCx4Wqvra1ekr23CxM
         /LgWc0TABnmYgY2iBarMG9gKbO3VWZTntjb4iFOh4+U3T9A1rAmTBKrzKFT1M5KB7k7e
         1JRWNA5VaGfEjL6ycdxz8P0vnUAltCDdXk60D4OXerMPo2AGeqfATIfhcZSewRdlMETG
         1ID8vyWf/yPEbe6N13iDKCjyzwbdkZgQCXeqjaC2KRFO0pCja23QjLhH2KpmTST9x2Bi
         C9Lw==
X-Gm-Message-State: AOJu0YyjQFYmsR7psTmvdCfhAd1TbvtVDpEI0I1KzpesPwUWjtgY9hjV
        CT3INyTwSmFkpBe6+qYozsKAgaWY/xpAYvfkBz8=
X-Google-Smtp-Source: AGHT+IGzIk0q5DFc6SUvyh4xXFBWbmnMc4JsWCwcwGkrdSnNztaLRGrwg2NHM7rmwQPW9TuA2n5hrA==
X-Received: by 2002:a17:90b:23d7:b0:280:29cd:4802 with SMTP id md23-20020a17090b23d700b0028029cd4802mr5034310pjb.3.1698689748510;
        Mon, 30 Oct 2023 11:15:48 -0700 (PDT)
Received: from localhost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id d88-20020a17090a6f6100b0027e022bd3e5sm6257471pjk.54.2023.10.30.11.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 11:15:48 -0700 (PDT)
Date:   Mon, 30 Oct 2023 11:15:48 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Oct 2023 11:15:44 PDT (-0700)
Subject:     Re: linux-next: duplicate patches in the risc-v tree
In-Reply-To: <20231030075629.0296f072@canb.auug.org.au>
CC:     Paul Walmsley <paul@pwsan.com>, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <mhng-b6345abb-81b3-450c-ae11-deed854821dc@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Oct 2023 13:56:29 PDT (-0700), Stephen Rothwell wrote:
> Hi all,
>
> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):
>
>   767423658d53 ("riscv: kexec: Align the kexeced kernel entry")
>   fe2ed36d419f ("riscv: Remove duplicate objcopy flag")

Sorry, but I'm lost here -- I'm not sure if I've managed to screw up git 
again?  If it helps, I'm not seeing the same commits here:

    $ git show fe2ed36d419f
    commit fe2ed36d419fdae48a6850bdbe2d2e7543c3c389
    gpg: Signature made Wed 20 Sep 2023 02:51:59 AM PDT
    gpg:                using RSA key 2B3C3747446843B24A943A7A2E1319F35FBB1889
    gpg:                issuer "palmer@dabbelt.com"
    gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
    gpg:                 aka "Palmer Dabbelt <palmer@rivosinc.com>" [ultimate]
    Author: Song Shuai <songshuaishuai@tinylab.org>
    Date:   Thu Sep 14 17:13:34 2023 +0800
    
        riscv: Remove duplicate objcopy flag
    
        There are two duplicate `-O binary` flags when objcopying from vmlinux
        to Image/xipImage.
    
        RISC-V set `-O binary` flag in both OBJCOPYFLAGS in the top-level riscv
        Makefile and OBJCOPYFLAGS_* in the boot/Makefile, and the objcopy cmd
        in Kbuild would join them together.
    
        The `-O binary` flag is only needed for objcopying Image, so remove the
        OBJCOPYFLAGS in the top-level riscv Makefile.
    
        Fixes: c0fbcd991860 ("RISC-V: Build flat and compressed kernel images")
        Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
        Link: https://lore.kernel.org/r/20230914091334.1458542-1-songshuaishuai@tinylab.org
        Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
    
    diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
    index 1329e060c548..b43a6bb7e4dc 100644
    --- a/arch/riscv/Makefile
    +++ b/arch/riscv/Makefile
    @@ -6,7 +6,6 @@
     # for more details.
     #
    
    -OBJCOPYFLAGS    := -O binary
     LDFLAGS_vmlinux := -z norelro
     ifeq ($(CONFIG_RELOCATABLE),y)
     	LDFLAGS_vmlinux += -shared -Bsymbolic -z notext --emit-relocs

and

    $ git show 767423658d53 | cat
    commit 767423658d53d147409821e51e6d0bc12425b24f
    gpg: Signature made Wed 20 Sep 2023 02:53:30 AM PDT
    gpg:                using RSA key 2B3C3747446843B24A943A7A2E1319F35FBB1889
    gpg:                issuer "palmer@dabbelt.com"
    gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
    gpg:                 aka "Palmer Dabbelt <palmer@rivosinc.com>" [ultimate]
    Author: Song Shuai <songshuaishuai@tinylab.org>
    Date:   Thu Sep 7 18:33:03 2023 +0800
    
        riscv: kexec: Align the kexeced kernel entry
    
        The current riscv boot protocol requires 2MB alignment for RV64
        and 4MB alignment for RV32.
    
        In KEXEC_FILE path, the elf_find_pbase() function should align
        the kexeced kernel entry according to the requirement, otherwise
        the kexeced kernel would silently BUG at the setup_vm().
    
        Fixes: 8acea455fafa ("RISC-V: Support for kexec_file on panic")
        Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
        Link: https://lore.kernel.org/r/20230907103304.590739-3-songshuaishuai@tinylab.org
        Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
    
    diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
    index 5372b708fae2..9a81d6926ac6 100644
    --- a/arch/riscv/kernel/elf_kexec.c
    +++ b/arch/riscv/kernel/elf_kexec.c
    @@ -98,7 +98,13 @@ static int elf_find_pbase(struct kimage *image, unsigned long kernel_len,
     	kbuf.image = image;
     	kbuf.buf_min = lowest_paddr;
     	kbuf.buf_max = ULONG_MAX;
    -	kbuf.buf_align = PAGE_SIZE;
    +
    +	/*
    +	* Current riscv boot protocol requires 2MB alignment for
    +	* RV64 and 4MB alignment for RV32
    +	*
    +	*/
    +	kbuf.buf_align = PMD_SIZE;
     	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
     	kbuf.memsz = ALIGN(kernel_len, PAGE_SIZE);
     	kbuf.top_down = false;

>
> -- 
> Cheers,
> Stephen Rothwell
