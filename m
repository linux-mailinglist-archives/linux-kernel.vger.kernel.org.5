Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264E8798A0A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244662AbjIHPcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244726AbjIHPcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:32:47 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86981BFF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 08:32:42 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bf6ea270b2so16647425ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 08:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694187162; x=1694791962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1fJFhjrxWu/l5FowZjv3FdaZf2QRbltLNGgcqvXRLeo=;
        b=G5zU51xjwtooXO5NnlUniNAT1reHQ0prefVwcwYKFNewqiVGzniFTIX1zfRF+6REh0
         F9QMeOfWw3kpKgmcxHj8RzytyH5hv3YIK9rhUuSwLWZAn7VSMGEucP8e5tD8nBGkREOT
         rjY28V4cCIkfLmcT+DtYCpRy81o9znNaniIstj1YO85tBafzUfXRX1J/tCBOqeS2GtVc
         tE9w6Yi6xmRdbqGeKvuYK58k9vgfOKSFnjdXObDgzVjHbejraXVHxRVjMl7UJYQNBaLD
         XzWBWQXLORHDZp7awsX/zmS07PNeFi2C6UHVcBUHKLyXYdesiutZ/sERWqlF/nj+LclX
         /Yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694187162; x=1694791962;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1fJFhjrxWu/l5FowZjv3FdaZf2QRbltLNGgcqvXRLeo=;
        b=aaZbsjhPCWk8ZWmj8+U4UaGfgUi7MX0lR8T9nTxUh0eSpCR9Tn01/4ylY1fTxUmTIZ
         0j/59i98Iw5+N8ozmG5nFvqA9ylYI4Idoi4Wk+6jaJRur47nKzwojuEfwabXg2zPy1Bg
         PEx+D9jfTTkfVqubfr8qVvGFgaPmKNBadORWNVrDEEQaI2T7rMkTWfd7CMeyRzDn/PBo
         CQ+qaEdWzmM1A+MBTQZTVrqctVpOwRvsFoA/ZryazVKihtRBZzI3zfd51Dmkiu1gvAm0
         pH+SrszI/tE6WBZ23vKpkpDAbLw+OxAXLIj0w+iAaC8iGFEp9p0nw0De1OXBqDgmJIrw
         6Jgg==
X-Gm-Message-State: AOJu0YyZr+WnE+mucjjn0EIfAHs1y5n+JRuh/MgMd6XfLqkr2tpi+qTd
        hgENwX10BNL5Un/vgLMwIl4=
X-Google-Smtp-Source: AGHT+IH3+ios7QYkB/ePkY1o/gFLMwga4Co0c7FzkRxPhpCKFic7dIhku6AP60ATToFAIPapz6syBw==
X-Received: by 2002:a17:902:c3c6:b0:1bb:ee1b:3cdf with SMTP id j6-20020a170902c3c600b001bbee1b3cdfmr2545496plj.67.1694187162171;
        Fri, 08 Sep 2023 08:32:42 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id c17-20020a170903235100b001b9d335223csm1733661plh.26.2023.09.08.08.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 08:32:41 -0700 (PDT)
Message-ID: <72cb1319-e072-b3a1-8d1b-a86321b255b8@gmail.com>
Date:   Sat, 9 Sep 2023 00:32:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [GIT PULL] RISC-V Patches for the 6.6 Merge Window, Part 2
Content-Language: en-US
To:     palmer@rivosinc.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        torvalds@linux-foundation.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Akira Yokosawa <akiyks@gmail.com>
References: <mhng-f4556557-af4d-4b6a-aa89-de77f7dacf2b@palmer-ri-x1c9>
 <a21c80c1-533c-5167-8b0b-a6bc4953eec8@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <a21c80c1-533c-5167-8b0b-a6bc4953eec8@gmail.com>
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

On Sat, 9 Sep 2023 00:27:56 +0900, Akira Yokosawa wrote:
> On Fri, 08 Sep 2023 07:55:57 -0700 (PDT), Palmer Dabbelt wrote:
>> merged tag 'riscv-for-linus-6.6-mw1'
>> The following changes since commit e0152e7481c6c63764d6ea8ee41af5cf9dfac5e9:
>>
>>   Merge tag 'riscv-for-linus-6.6-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2023-09-01 08:09:48 -0700)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.6-mw2
>>
>> for you to fetch changes up to accb14aa1e699d11b8172283e8cb82a695b96c85:
>>
>>   soc: renesas: Kconfig: For ARCH_R9A07G043 select the required configs if dependencies are met (2023-09-06 07:20:13 -0700)
>>
>> ----------------------------------------------------------------
>> RISC-V Patches for the 6.6 Merge Window, Part 2
>>
>> * The kernel now dynamically probes for misaligned access speed, as
>>   opposed to relying on a table of known implementations.
>> * Support for non-coherent devices on systems using the Andes AX45MP
>>   core, including the RZ/Five SoCs.
>> * Support for the V extension in ptrace(), again.
>> * Support for KASLR.
>> * Support for the BPF prog pack allocator in RISC-V.
>> * A handful of bug fixes and cleanups.
>>
>> ----------------------------------------------------------------
>> The shortlog looks correct here, but the diffstat includes all sorts of files I
>> wasn't expecting.  I'm not entirely sure what's going on here, but I have a
>> little bit of a complex set of base branches here as the BPF changes have a
>> dependency on some arm64 BPF work and IIRC that sort of thing sometimes makes
>> diffstat go off the rails.  So hopefully that's just it.
> 
> Hi Palmer,
> It looks like you have ignored Stephen Rothwell's kind investigation at
> https://lore.kernel.org/linux-next/20230908082625.487d39c4@canb.auug.org.au/.

Aahh, Stephen used your email address at @dabbelt.com.
Didn't you see the message at all?

Akira

> 
> Excerpt of Stephen's analysis:
> 
>> Actually, it looks like the merge
>>
>>   2bf3c0292f35 ("Merge patch series "RISC-V: Probe for misaligned access speed"")
>>
>> in the risc-v tree was resolved very badly and dragged a lot of stuff
>> back in.
> 
> [...]
> 
>> When I redid that merge:
>>
>> $ git diff HEAD^..HEAD
>>  Documentation/riscv/hwprobe.rst      |  11 ++--
>>  arch/riscv/errata/thead/errata.c     |   8 ---
>>  arch/riscv/include/asm/alternative.h |   5 --
>>  arch/riscv/include/asm/cpufeature.h  |   2 +
>>  arch/riscv/kernel/Makefile           |   1 +
>>  arch/riscv/kernel/alternative.c      |  19 -------
>>  arch/riscv/kernel/copy-unaligned.S   |  71 ++++++++++++++++++++++++
>>  arch/riscv/kernel/copy-unaligned.h   |  13 +++++
>>  arch/riscv/kernel/cpufeature.c       | 104 +++++++++++++++++++++++++++++++++++
>>  arch/riscv/kernel/smpboot.c          |   3 +-
>>  10 files changed, 198 insertions(+), 39 deletions(-)
>>
>> So, the risc-v tree needs to be cleaned up.
> 
> Palmer, you are requesting pull without the suggested cleanup.
> 
> I'd really like this to be cleanly sorted out.
> 
> Of course, it's up to Linus whether or not to pull as it is...
> 
>         Thanks, Akira
