Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883268070AF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378446AbjLFNOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378416AbjLFNOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:14:21 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1259E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:14:27 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d075392ff6so6773925ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 05:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1701868467; x=1702473267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6m8NNJ96xoL22f3J2mj0pcMGx/C1e265J+kyF1R2z8o=;
        b=Gg2/jy1+p8R4muds1hZSZcq3WS5KKs0cqJ6ED+0J+4oPq06qEg541yX1/G/FvX3Sg7
         8DGob7E1cliKdQsSzs2GbhrUxLNw/NqNwlEgtfaN3FyusyvX71hTil3nvjbAw5+UjzOf
         xg6fi0bXHOETZS00eWBrcymewYve4qYkoepjNEjwKrtMbtuS+QpGmGU4NCYJm4G36/BD
         PbRNOS7e9erHcGbSKVw6YFcV+OmApdJ5p12dwyV8JKjJGn0CymvfQPCZCHVO0GZ24Idp
         IYg2Cto7CpPpIkTE1fQzC5G2NBxlobCv624YU1tx8vxK/lbyosg6foSjQuXMzUUAakTq
         d4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701868467; x=1702473267;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6m8NNJ96xoL22f3J2mj0pcMGx/C1e265J+kyF1R2z8o=;
        b=WvUhsfijYPefRyDwOwdl72ohiu6FgmliB+qRkvLHgi5gffzWm7hd5DPDjCVbUN2wOC
         F1zKWCHB6i+H6DFOSek0IBHAn6UwnGHcENVaAbkzJCXUiNMXXbotj+tlVO+SvFubUgcw
         b30qw3zH0rqPSMaxDZHNLLasqzzPz+hDQN7AH4e3qG1/5meBv6vx+ljvip63lZnnjKjQ
         wjwMZdyAcil1ZuoiYUCI3WUuNOp9aRyLpxoLpdSBBlmb45cO1bYCpSw4etnlIbBS4EaC
         FcxclXPhSbNaa1AWXd35A+CNOjD27S627hl/lHXsLMsMAAPfOA66M60rsfewHYqyW0w2
         W5FA==
X-Gm-Message-State: AOJu0YxKdMQb32IwfALicgHMlHRIxiOsLRdHpRLQSErKbdirRS5U5zB7
        8/Zi9U3dDjUQnbgBzqeL7ge8qA==
X-Google-Smtp-Source: AGHT+IGta2bhw+7qIoVXmqExA48kB41RdGIfu5QAI9yipmpTWRjYPKmvmMdYnIurBqPfmflvyEFyTQ==
X-Received: by 2002:a17:902:dac4:b0:1cf:59df:23e with SMTP id q4-20020a170902dac400b001cf59df023emr1270027plx.12.1701868467222;
        Wed, 06 Dec 2023 05:14:27 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id p24-20020a170902b09800b001b86dd825e7sm12082582plr.108.2023.12.06.05.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 05:14:26 -0800 (PST)
Date:   Wed, 06 Dec 2023 05:14:26 -0800 (PST)
X-Google-Original-Date: Wed, 06 Dec 2023 05:14:24 PST (-0800)
Subject:     Re: [PATCH 0/2] riscv: Increase mmap_rnd_bits_max on Sv48/57
In-Reply-To: <20230929211155.3910949-4-samitolvanen@google.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        akpm@linux-foundation.org, keescook@chromium.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        samitolvanen@google.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     samitolvanen@google.com
Message-ID: <mhng-f0a257c6-a1f5-41db-b1c4-c178a77a79e9@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2023 14:11:56 PDT (-0700), samitolvanen@google.com wrote:
> Hi all,
>
> We noticed that 64-bit RISC-V kernels limit mmap_rnd_bits to 24
> even if the hardware supports a larger virtual address space size
> [1]. These two patches allow mmap_rnd_bits_max to be changed during
> init, and bumps up the maximum randomness if we end up setting up
> 4/5-level paging at boot.

Sorry for missing this, I'm just poking through old stuff in patchwork.  
As far as I can tell this is still relevant, the discussions are just on 
the mmap() bits (but we'd already screwed that one up and have since 
fixed it).

So

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

in case someone else wants to take it, but I'm OK taking that MM patch 
with Kees' review.

>
> Sami
>
>  [1] https://github.com/google/android-riscv64/issues/1
>
>
> Sami Tolvanen (2):
>   mm: Change mmap_rnd_bits_max to __ro_after_init
>   riscv: mm: Update mmap_rnd_bits_max
>
>  arch/riscv/mm/init.c | 6 ++++++
>  include/linux/mm.h   | 2 +-
>  mm/mmap.c            | 2 +-
>  3 files changed, 8 insertions(+), 2 deletions(-)
>
>
> base-commit: 6465e260f48790807eef06b583b38ca9789b6072
