Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB5C7DA75B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 15:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjJ1Nll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 09:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjJ1Nlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 09:41:39 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CD591
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 06:41:37 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507ad511315so4337475e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 06:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698500495; x=1699105295; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=mFZbIQdMKWTecSzh3n0+f7jkVef1j5b85sEyOwDKoqU=;
        b=lTyl3iTixUa8zwxLT3ZGfebyJMYEqNIYsHqjy29kE+Y7kwiLwyWCbL9C2q3lJ0kFLw
         I2MoKlkzxJMfpTWyDdN8q5ug8xDfhoi//PZjc3IOvAexd12vKFSO+vaPtQ1xHzmrmLx9
         rEOhz9S8NpAix0pB9Ftx2UjR00NVjmHSFdP93xdgkgparz2bz2SMEq2LrgNqG1ygdd/q
         2Av/IFdYFVOZE/o17+NPDXHONYmiy0EWp23sAZyE7dBdS5RJzpJ3LCdlG0vpRBLCdcUA
         tegz8BubUoZAVE1pEZtI5FH2NpH7b5E98O06egmq2+3UGvt0h1SVMTxB6F3kUl73Na3z
         4qng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698500495; x=1699105295;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFZbIQdMKWTecSzh3n0+f7jkVef1j5b85sEyOwDKoqU=;
        b=pqMsijxnI1gh+MydtoXp6dG0O7DxFsZeXHVUdnYATw9JN6EQIFJQM+SMq0yxBfaO7y
         irt6m2xyfRiNwNpoTGf5ej6rgGTbF5byeEJxoULZobaJgX3pQPAId0q4DYu0ehy4YLax
         vPHr0lXJWZXQBYjBaUUTDERR0MOuT7o/e86CqZGSpSeYle9XvgUuHGHTt8CKuL4kew+I
         Fzi2j2VVaS8o2PtzPiwisFaw7FfrfBdqQtXC5UVR9bYHNucRKsfpZ5DXN5+3pq0mKpiB
         i49G27Z9MHVCzoTf5jqEPb6JUqm+rv8/DuiOtqXWHqyHlwgjUgVvGY02pZqbpUeqTR3T
         YJmA==
X-Gm-Message-State: AOJu0YxN/xJA2lSnAmC3ZY6An4orQPMSfWYhiGonA7KrBptPoOJoygek
        maQphkevpMIRa3mzb3TF7TVK5yqn2dk=
X-Google-Smtp-Source: AGHT+IFUi2OSUd6NDAsPR4SN+PIZvDzked/RldPEXlgIYO0JQK6Op5fkBnK/yMcq3b1uftX1k4Oryg==
X-Received: by 2002:a19:ad05:0:b0:4f8:7772:3dfd with SMTP id t5-20020a19ad05000000b004f877723dfdmr3489893lfc.11.1698500494767;
        Sat, 28 Oct 2023 06:41:34 -0700 (PDT)
Received: from gmail.com (1F2EF1E7.nat.pool.telekom.hu. [31.46.241.231])
        by smtp.gmail.com with ESMTPSA id b38-20020a509f29000000b0053635409213sm2977800edf.34.2023.10.28.06.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 06:41:33 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 28 Oct 2023 15:41:31 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [GIT PULL] x86/headers changes for v6.7
Message-ID: <ZT0Pi/4pMwg9zm8u@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/headers git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-headers-2023-10-28

   # HEAD: 8b01de80306cbd914be9c45bce30206a49699141 x86/headers: Remove <asm/export.h>

Replace <asm/export.h> uses with <linux/export.h> and then remove <asm/export.h>.

 Thanks,

	Ingo

------------------>
Masahiro Yamada (3):
      x86/headers: Remove unnecessary #include <asm/export.h>
      x86/headers: Replace #include <asm/export.h> with #include <linux/export.h>
      x86/headers: Remove <asm/export.h>


 arch/x86/entry/entry.S               | 2 +-
 arch/x86/entry/entry_64.S            | 2 +-
 arch/x86/entry/thunk_32.S            | 2 +-
 arch/x86/entry/thunk_64.S            | 2 +-
 arch/x86/entry/vdso/vsgx.S           | 1 -
 arch/x86/include/asm/Kbuild          | 1 -
 arch/x86/kernel/ftrace_32.S          | 2 +-
 arch/x86/kernel/ftrace_64.S          | 2 +-
 arch/x86/kernel/head_32.S            | 2 +-
 arch/x86/kernel/head_64.S            | 3 +--
 arch/x86/kernel/irqflags.S           | 2 +-
 arch/x86/lib/checksum_32.S           | 2 +-
 arch/x86/lib/clear_page_64.S         | 2 +-
 arch/x86/lib/cmpxchg8b_emu.S         | 2 +-
 arch/x86/lib/copy_page_64.S          | 2 +-
 arch/x86/lib/copy_user_64.S          | 2 +-
 arch/x86/lib/copy_user_uncached_64.S | 2 +-
 arch/x86/lib/getuser.S               | 2 +-
 arch/x86/lib/hweight.S               | 2 +-
 arch/x86/lib/memcpy_64.S             | 2 +-
 arch/x86/lib/memmove_32.S            | 2 +-
 arch/x86/lib/memmove_64.S            | 2 +-
 arch/x86/lib/memset_64.S             | 2 +-
 arch/x86/lib/putuser.S               | 3 +--
 arch/x86/lib/retpoline.S             | 2 +-
 25 files changed, 23 insertions(+), 27 deletions(-)
