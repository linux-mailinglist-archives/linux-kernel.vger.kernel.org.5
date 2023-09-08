Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CEC798AB9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 18:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244043AbjIHQhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 12:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjIHQhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:37:00 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5548719B6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 09:36:54 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c0ecb9a075so17953745ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 09:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694191013; x=1694795813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hha0R8WpwiNtISVJgyEcefuuZ1tW3gKFT2Wp4a2qgHg=;
        b=AduFgEsK4wzFep+9mOBycfdNpjJjFBBmQZkK3MKKvvvzLFOnNGX635xShAz9cJ4hsI
         tOwqA63keVuamH9XGvvtOIImy69zO7Q4HCaDtlUbEzM3X55AWim8tB5807bZmiWVe43C
         qGnwrx8qIBTkHKid5byWo92xdi0TTUBl8U+nU5UlFUPXIIc/X4xdsqkdeWQi1L9BbP7b
         /aaXzsCxlZQfZIVUUwyeymwZO5wUpGih+16P9iYvpCMA8uUc7O+62XIhSYpXqGwD/xRe
         bkf4X/c+/5Z0tSAEa2c9FpQvk7nL2BZug7O4hoQrB0KJU3ieoUPjdpILaErgQRTneFzf
         nmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694191013; x=1694795813;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hha0R8WpwiNtISVJgyEcefuuZ1tW3gKFT2Wp4a2qgHg=;
        b=eKgsP+ZEFtcpwTkIK0ep5ooXFAvov8f7lw+SODrmXq8uI7KoyERTj6LK1c3Vxs3/S+
         mGT2hd+yjvS1pda4DheOU3wiNzfXy/LJFZ30863PpeLcMWbMK0x7JH3q81DhtxLBJbo/
         /qxm+G8MQB/z9ZwC0bsZiLrnmFq+tiWgRzazIR6RNdHbY+B35URlcKajssmYzO4PRT/S
         N+tCU1Ktzhn6yU8USMEDIueWUA369p9FRqgXT0zUjJPzKML3Z+xs9d7Xw+zcLt8DZ5uy
         Y4YLAPzTcB4vh6rpprtqtOb8aY0h+nwzcAXenWOWWr7lu/1Da37nxUwAHxSFsHGLfrOB
         uFMw==
X-Gm-Message-State: AOJu0YxI9MKGSCkjzUq0ZoBikcPOvSX0oiTPvTVeNc49qEB1Te6DahX8
        IoXFlnqBO8d/8/ndmo3wwuzafSZRHJNPvvjsOto=
X-Google-Smtp-Source: AGHT+IG5z+BUmJdGSZCdLGShsVjcHK/gNeNfc83vbpPvBhGN58S9/wBG8y2536EHecqwGZcBQKH1eg==
X-Received: by 2002:a17:903:22c4:b0:1c0:b82a:b0d9 with SMTP id y4-20020a17090322c400b001c0b82ab0d9mr3534052plg.29.1694191013464;
        Fri, 08 Sep 2023 09:36:53 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902d30600b001bc6e6069a6sm1785499plc.122.2023.09.08.09.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 09:36:53 -0700 (PDT)
Date:   Fri, 08 Sep 2023 09:36:53 -0700 (PDT)
X-Google-Original-Date: Fri, 08 Sep 2023 09:36:46 PDT (-0700)
Subject:     Re: [GIT PULL] RISC-V Patches for the 6.6 Merge Window, Part 2
In-Reply-To: <72cb1319-e072-b3a1-8d1b-a86321b255b8@gmail.com>
CC:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, akiyks@gmail.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     akiyks@gmail.com
Message-ID: <mhng-32285c56-bd5b-49de-a971-e3b3628bbd39@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Sep 2023 08:32:37 PDT (-0700), akiyks@gmail.com wrote:
> On Sat, 9 Sep 2023 00:27:56 +0900, Akira Yokosawa wrote:
>> On Fri, 08 Sep 2023 07:55:57 -0700 (PDT), Palmer Dabbelt wrote:
>>> merged tag 'riscv-for-linus-6.6-mw1'
>>> The following changes since commit e0152e7481c6c63764d6ea8ee41af5cf9dfac5e9:
>>>
>>>   Merge tag 'riscv-for-linus-6.6-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2023-09-01 08:09:48 -0700)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.6-mw2
>>>
>>> for you to fetch changes up to accb14aa1e699d11b8172283e8cb82a695b96c85:
>>>
>>>   soc: renesas: Kconfig: For ARCH_R9A07G043 select the required configs if dependencies are met (2023-09-06 07:20:13 -0700)
>>>
>>> ----------------------------------------------------------------
>>> RISC-V Patches for the 6.6 Merge Window, Part 2
>>>
>>> * The kernel now dynamically probes for misaligned access speed, as
>>>   opposed to relying on a table of known implementations.
>>> * Support for non-coherent devices on systems using the Andes AX45MP
>>>   core, including the RZ/Five SoCs.
>>> * Support for the V extension in ptrace(), again.
>>> * Support for KASLR.
>>> * Support for the BPF prog pack allocator in RISC-V.
>>> * A handful of bug fixes and cleanups.
>>>
>>> ----------------------------------------------------------------
>>> The shortlog looks correct here, but the diffstat includes all sorts of files I
>>> wasn't expecting.  I'm not entirely sure what's going on here, but I have a
>>> little bit of a complex set of base branches here as the BPF changes have a
>>> dependency on some arm64 BPF work and IIRC that sort of thing sometimes makes
>>> diffstat go off the rails.  So hopefully that's just it.
>>
>> Hi Palmer,
>> It looks like you have ignored Stephen Rothwell's kind investigation at
>> https://lore.kernel.org/linux-next/20230908082625.487d39c4@canb.auug.org.au/.
>
> Aahh, Stephen used your email address at @dabbelt.com.
> Didn't you see the message at all?

It should go to both of them, but looks like something must still be 
broken with the email on my end.

>
> Akira
>
>>
>> Excerpt of Stephen's analysis:
>>
>>> Actually, it looks like the merge
>>>
>>>   2bf3c0292f35 ("Merge patch series "RISC-V: Probe for misaligned access speed"")
>>>
>>> in the risc-v tree was resolved very badly and dragged a lot of stuff
>>> back in.
>>
>> [...]
>>
>>> When I redid that merge:
>>>
>>> $ git diff HEAD^..HEAD
>>>  Documentation/riscv/hwprobe.rst      |  11 ++--
>>>  arch/riscv/errata/thead/errata.c     |   8 ---
>>>  arch/riscv/include/asm/alternative.h |   5 --
>>>  arch/riscv/include/asm/cpufeature.h  |   2 +
>>>  arch/riscv/kernel/Makefile           |   1 +
>>>  arch/riscv/kernel/alternative.c      |  19 -------
>>>  arch/riscv/kernel/copy-unaligned.S   |  71 ++++++++++++++++++++++++
>>>  arch/riscv/kernel/copy-unaligned.h   |  13 +++++
>>>  arch/riscv/kernel/cpufeature.c       | 104 +++++++++++++++++++++++++++++++++++
>>>  arch/riscv/kernel/smpboot.c          |   3 +-
>>>  10 files changed, 198 insertions(+), 39 deletions(-)
>>>
>>> So, the risc-v tree needs to be cleaned up.
>>
>> Palmer, you are requesting pull without the suggested cleanup.
>>
>> I'd really like this to be cleanly sorted out.
>>
>> Of course, it's up to Linus whether or not to pull as it is...

Let's just drop this PR, I'll go re-spin my tree -- and try to figure 
out what's going on with my email.

>>
>>         Thanks, Akira
