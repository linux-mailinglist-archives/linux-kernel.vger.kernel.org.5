Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0707989F9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241052AbjIHP2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjIHP2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:28:05 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EFB1BEA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 08:28:00 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bc0d39b52cso17512315ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 08:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694186880; x=1694791680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISx/id5dNxIJh+29FXmKcEhK6YchpdLSErhaK4D3qNY=;
        b=puUQeUsE9KvLZInkH4RSJ15VKZOf+Oq222katUPXfmbQT/5fSACGTAS5RnZPEXTLkx
         vZAeivmeCMFfvd/E3Q4QW90ePXBpKap/6BTrCqnR3gBGnYMniC9OQCXF9QlVOFL2KqQl
         svq4t7jSxQQVsZMiNsHkNh4cdCQxEG7T/VDFMRhj2Lj+p5C6N6zdQ5gfT6tlAUEXkjlm
         31zokZUsNs3VQF4YIgmZOYdHwG7VrHzSsL3kkgvUOEvvVLthBlvEC9bJLukbLl33IUno
         IHzWG+S9/fGTJFHZAL94ys9wPmscfgzpXOsDQxBjp3l9PXHSGsRjoAe9Q4cceDyNcHWr
         i4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694186880; x=1694791680;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ISx/id5dNxIJh+29FXmKcEhK6YchpdLSErhaK4D3qNY=;
        b=qzaOAA79t0vxxYoeMEjnpZ7tjS0rcEZQC6qM+i9Xc1PXpNmlcx6QP8hvqo2IcCrAqf
         J46MUPqQNgyCL7NtF1rGFcGZ2GaETGHHAyYVu6qatMotkTDa8et68Dwx6mijxX6mCQ7q
         JVkR0UQ/wcE2mVe0nAI+Cc8B5LaVqtSNQ0tL29uY7NNDBaAdVx0YJz2xeQ8cTZN3s3Q4
         elslGFt/30tEHD1S9pZvi0HHK2t8xOft0cZ4cdNqtXjQQlDQJGH2lknrYQo/MWSML/dy
         BCxu6ThSPLvL2tmz8AgfN3pqMfulv+lRmlQ7ctsJgzBWONXuG4eKZTxrsOnX51tXu4jr
         ksWQ==
X-Gm-Message-State: AOJu0YyW2k5qgog74mZjfbe1tWYsddCB0nAyrCKg1APC7pvlf3vh4sfC
        lFE+rjW/eLM3PNW6SrnZRBk=
X-Google-Smtp-Source: AGHT+IF9MIfnm3S/SpaSMf0cVr1lXP/iCqKNvT3gWWfIFlFwPRdCTkW7qTgIYcvFtTQTVhn6+m7UGg==
X-Received: by 2002:a17:902:6906:b0:1c0:aca0:8c2d with SMTP id j6-20020a170902690600b001c0aca08c2dmr2600278plk.67.1694186880104;
        Fri, 08 Sep 2023 08:28:00 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id iw21-20020a170903045500b001b39ffff838sm1737554plb.25.2023.09.08.08.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 08:27:59 -0700 (PDT)
Message-ID: <a21c80c1-533c-5167-8b0b-a6bc4953eec8@gmail.com>
Date:   Sat, 9 Sep 2023 00:27:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
To:     palmer@rivosinc.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        torvalds@linux-foundation.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Akira Yokosawa <akiyks@gmail.com>
References: <mhng-f4556557-af4d-4b6a-aa89-de77f7dacf2b@palmer-ri-x1c9>
Subject: Re: [GIT PULL] RISC-V Patches for the 6.6 Merge Window, Part 2
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <mhng-f4556557-af4d-4b6a-aa89-de77f7dacf2b@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Sep 2023 07:55:57 -0700 (PDT), Palmer Dabbelt wrote:
> merged tag 'riscv-for-linus-6.6-mw1'
> The following changes since commit e0152e7481c6c63764d6ea8ee41af5cf9dfac5e9:
> 
>   Merge tag 'riscv-for-linus-6.6-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2023-09-01 08:09:48 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.6-mw2
> 
> for you to fetch changes up to accb14aa1e699d11b8172283e8cb82a695b96c85:
> 
>   soc: renesas: Kconfig: For ARCH_R9A07G043 select the required configs if dependencies are met (2023-09-06 07:20:13 -0700)
> 
> ----------------------------------------------------------------
> RISC-V Patches for the 6.6 Merge Window, Part 2
> 
> * The kernel now dynamically probes for misaligned access speed, as
>   opposed to relying on a table of known implementations.
> * Support for non-coherent devices on systems using the Andes AX45MP
>   core, including the RZ/Five SoCs.
> * Support for the V extension in ptrace(), again.
> * Support for KASLR.
> * Support for the BPF prog pack allocator in RISC-V.
> * A handful of bug fixes and cleanups.
> 
> ----------------------------------------------------------------
> The shortlog looks correct here, but the diffstat includes all sorts of files I
> wasn't expecting.  I'm not entirely sure what's going on here, but I have a
> little bit of a complex set of base branches here as the BPF changes have a
> dependency on some arm64 BPF work and IIRC that sort of thing sometimes makes
> diffstat go off the rails.  So hopefully that's just it.

Hi Palmer,
It looks like you have ignored Stephen Rothwell's kind investigation at
https://lore.kernel.org/linux-next/20230908082625.487d39c4@canb.auug.org.au/.

Excerpt of Stephen's analysis:

> Actually, it looks like the merge
> 
>   2bf3c0292f35 ("Merge patch series "RISC-V: Probe for misaligned access speed"")
> 
> in the risc-v tree was resolved very badly and dragged a lot of stuff
> back in.

[...]

> When I redid that merge:
> 
> $ git diff HEAD^..HEAD
>  Documentation/riscv/hwprobe.rst      |  11 ++--
>  arch/riscv/errata/thead/errata.c     |   8 ---
>  arch/riscv/include/asm/alternative.h |   5 --
>  arch/riscv/include/asm/cpufeature.h  |   2 +
>  arch/riscv/kernel/Makefile           |   1 +
>  arch/riscv/kernel/alternative.c      |  19 -------
>  arch/riscv/kernel/copy-unaligned.S   |  71 ++++++++++++++++++++++++
>  arch/riscv/kernel/copy-unaligned.h   |  13 +++++
>  arch/riscv/kernel/cpufeature.c       | 104 +++++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/smpboot.c          |   3 +-
>  10 files changed, 198 insertions(+), 39 deletions(-)
> 
> So, the risc-v tree needs to be cleaned up.

Palmer, you are requesting pull without the suggested cleanup.

I'd really like this to be cleanly sorted out.

Of course, it's up to Linus whether or not to pull as it is...

        Thanks, Akira
