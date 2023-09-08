Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CC3798E56
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjIHSkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjIHSkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:40:16 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CE3CE6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 11:39:39 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68e3083aa1dso2248929b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 11:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1694198311; x=1694803111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eQTNsRDuZ6Ep4/wu6ObBNkw0OLnVXd0NXLoJ9HJgOe4=;
        b=ng0O5p+5BRfsOV02sPYv15I2ck02NsYCuYO2AKf4UKvTJZrhQtr92RnYlBfv1nMeHL
         RuTxRMnTrn5D1ret1qexa47+7vZJCsiocLFBo26FmXVIat5xEylRIjXzhMi+qCsAQRFQ
         Yi2Cjf4Hd9RHQg283TQG4OxTTYHOXAEFCLY3UvfdU91f2BhSDanGbJRXPR19/EoFPJzh
         fo42k+Rg7u55xj1R7psnWNO+7ftJuMFWzKIveA/xmsT9RzHqC00utNTyS07EzFEpJYOd
         zzvA0D2fPrK5xzymquYpEF6bl6yP/jO8HprYEml0X+HVi96bZJy3MPfUmqvLzXNG56hA
         9IyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694198311; x=1694803111;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQTNsRDuZ6Ep4/wu6ObBNkw0OLnVXd0NXLoJ9HJgOe4=;
        b=QDppmnFMkoUCVd5bEP7Ih+1ug4gaMEu7dQaK4DS/gZiyDIXIkQBzeuGT1SZuwRFK6T
         RyC3e945T8agEIqybHetOJKVqvoPHmwaha/jFhm7IJJOMo8+qdl9R+ZigyGCfseM4VNB
         iASeSqifbD5OByxvAX5H+wgtKz5aFjWU7nARpWKE1dtRAOvH19kHB/femiWueHrtIQJA
         Rd4C8mtY9QLDLLT/b52MddCO6ZbK6xEeT5HBQTZSZp8ypn9OEAb9pTnJDCAMtrMTvsG1
         EXYQqtX79EAZNfMIEynYWjL5YOX3hY3F2viCgy0jhWLjy6dIcgaZSdEErANgWx3J4v9s
         4tkg==
X-Gm-Message-State: AOJu0Yy5RKMUJhPQoSOoevjZDX/PFwJrGo6TQed2zDK5ul9wbWF/SISv
        1T+Zlj5zzSzQvBsStnyi8IqgZpjt9M8K51pi2rs=
X-Google-Smtp-Source: AGHT+IFYUsR+dZlkmGKkLsioB+RXkT7Wbw2dW7AN7eckaTJwtgcrNabW1cYWsEP8/xpMfzdDQno9tA==
X-Received: by 2002:a05:6a20:914f:b0:f3:33fb:a62b with SMTP id x15-20020a056a20914f00b000f333fba62bmr3927014pzc.9.1694198310698;
        Fri, 08 Sep 2023 11:38:30 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id x22-20020aa79196000000b0068bc014f352sm1612799pfa.7.2023.09.08.11.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 11:38:30 -0700 (PDT)
Date:   Fri, 08 Sep 2023 11:38:30 -0700 (PDT)
X-Google-Original-Date: Fri, 08 Sep 2023 11:37:39 PDT (-0700)
Subject:     Re: [GIT PULL] RISC-V Patches for the 6.6 Merge Window, Part 2
In-Reply-To: <mhng-32285c56-bd5b-49de-a971-e3b3628bbd39@palmer-ri-x1c9>
CC:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, akiyks@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     akiyks@gmail.com
Message-ID: <mhng-efbeb114-26c3-4f83-b8e5-00b2dcbd67ab@palmer-ri-x1c9>
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

On Fri, 08 Sep 2023 09:36:53 PDT (-0700), Palmer Dabbelt wrote:
> On Fri, 08 Sep 2023 08:32:37 PDT (-0700), akiyks@gmail.com wrote:
>> On Sat, 9 Sep 2023 00:27:56 +0900, Akira Yokosawa wrote:
>>> On Fri, 08 Sep 2023 07:55:57 -0700 (PDT), Palmer Dabbelt wrote:
>>>> merged tag 'riscv-for-linus-6.6-mw1'
>>>> The following changes since commit e0152e7481c6c63764d6ea8ee41af5cf9dfac5e9:
>>>>
>>>>   Merge tag 'riscv-for-linus-6.6-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2023-09-01 08:09:48 -0700)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>   git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.6-mw2
>>>>
>>>> for you to fetch changes up to accb14aa1e699d11b8172283e8cb82a695b96c85:
>>>>
>>>>   soc: renesas: Kconfig: For ARCH_R9A07G043 select the required configs if dependencies are met (2023-09-06 07:20:13 -0700)
>>>>
>>>> ----------------------------------------------------------------
>>>> RISC-V Patches for the 6.6 Merge Window, Part 2
>>>>
>>>> * The kernel now dynamically probes for misaligned access speed, as
>>>>   opposed to relying on a table of known implementations.
>>>> * Support for non-coherent devices on systems using the Andes AX45MP
>>>>   core, including the RZ/Five SoCs.
>>>> * Support for the V extension in ptrace(), again.
>>>> * Support for KASLR.
>>>> * Support for the BPF prog pack allocator in RISC-V.
>>>> * A handful of bug fixes and cleanups.
>>>>
>>>> ----------------------------------------------------------------
>>>> The shortlog looks correct here, but the diffstat includes all sorts of files I
>>>> wasn't expecting.  I'm not entirely sure what's going on here, but I have a
>>>> little bit of a complex set of base branches here as the BPF changes have a
>>>> dependency on some arm64 BPF work and IIRC that sort of thing sometimes makes
>>>> diffstat go off the rails.  So hopefully that's just it.
>>>
>>> Hi Palmer,
>>> It looks like you have ignored Stephen Rothwell's kind investigation at
>>> https://lore.kernel.org/linux-next/20230908082625.487d39c4@canb.auug.org.au/.
>>
>> Aahh, Stephen used your email address at @dabbelt.com.
>> Didn't you see the message at all?
>
> It should go to both of them, but looks like something must still be
> broken with the email on my end.
>
>>
>> Akira
>>
>>>
>>> Excerpt of Stephen's analysis:
>>>
>>>> Actually, it looks like the merge
>>>>
>>>>   2bf3c0292f35 ("Merge patch series "RISC-V: Probe for misaligned access speed"")
>>>>
>>>> in the risc-v tree was resolved very badly and dragged a lot of stuff
>>>> back in.
>>>
>>> [...]
>>>
>>>> When I redid that merge:
>>>>
>>>> $ git diff HEAD^..HEAD
>>>>  Documentation/riscv/hwprobe.rst      |  11 ++--
>>>>  arch/riscv/errata/thead/errata.c     |   8 ---
>>>>  arch/riscv/include/asm/alternative.h |   5 --
>>>>  arch/riscv/include/asm/cpufeature.h  |   2 +
>>>>  arch/riscv/kernel/Makefile           |   1 +
>>>>  arch/riscv/kernel/alternative.c      |  19 -------
>>>>  arch/riscv/kernel/copy-unaligned.S   |  71 ++++++++++++++++++++++++
>>>>  arch/riscv/kernel/copy-unaligned.h   |  13 +++++
>>>>  arch/riscv/kernel/cpufeature.c       | 104 +++++++++++++++++++++++++++++++++++
>>>>  arch/riscv/kernel/smpboot.c          |   3 +-
>>>>  10 files changed, 198 insertions(+), 39 deletions(-)
>>>>
>>>> So, the risc-v tree needs to be cleaned up.
>>>
>>> Palmer, you are requesting pull without the suggested cleanup.
>>>
>>> I'd really like this to be cleanly sorted out.
>>>
>>> Of course, it's up to Linus whether or not to pull as it is...
>
> Let's just drop this PR, I'll go re-spin my tree -- and try to figure
> out what's going on with my email.

I think I have this one fixed up, but given that I masaged to screw it 
up pretty bad I'm going to give things a bit of time to test and such.  
Unless anyone finds a problem I'll plan on sending a new PR tomorrow 
morning -- I know that's super late so no big deal if it doesn't make 
6.6.

Sorry I screwed this one up.

>
>>>
>>>         Thanks, Akira
