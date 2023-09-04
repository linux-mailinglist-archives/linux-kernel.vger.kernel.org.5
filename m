Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD10791D8F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 21:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242526AbjIDTVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 15:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjIDTVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 15:21:05 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AFD18C;
        Mon,  4 Sep 2023 12:21:01 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40037db2fe7so18113465e9.0;
        Mon, 04 Sep 2023 12:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693855260; x=1694460060; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=owg0Qtie51BTtnNroNiyG6kzJsRANYmLXp0WowAkZOw=;
        b=SoQJSr7hcCV7IH9AF/BQNhl6AdXwI3bFCIHxGBkrz6BcZY8V6dxFcWMccS+KOzMK0p
         9rrOncxsMXzj7Vw819kjv7WIBrrcL2ElfBt4Ye7/cGTkicx41+5m4Js1M3K6FTst5bul
         Jg6jxCbs2m06cyCSsp/OOuHd0/M1mYRh4R7htACttxVOuarrcPQTeFxwohPPs6V9gnCn
         +SLbKGCn5BEmf6Y64/JhJSpy/HI3s6jqlVFbAeK8HRpCraBbR+2dwlEenv20tOfk1cCg
         FBJBQN4pEuPWd37IAtNYOJf8kD/3V90GNHWB1lLj1YErLIYZAIaOqyasupdou0efLL8W
         9L4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693855260; x=1694460060;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=owg0Qtie51BTtnNroNiyG6kzJsRANYmLXp0WowAkZOw=;
        b=k75ow0Pz9SL8eF/k40CXEo45G6V8R9mHKgOrYWyCF6tW6qVwdWNMV7Ywjbo/ftW/7q
         bIX2io4xx63abW9K30MsqVnts1qcqv0X/44kWb4q6g+qnXHQD4oHpM9k6eblkDNPJ0RR
         tSujz7Jt1G2Q3SDP1U3JZBxhstayo4j9j68kUFYReWhtAoGcZPDGqs49RrDpyoNp4H3f
         8A4fWTqqYV4o0aKb5bi4drrDOwU5dwrZ3WFu97faMofwA3l7+VBQOTnn4ubMuZmcsiOg
         M7tYTZ1l79f2+QhcD2RpK5DBxxVQifFH4rlVNwiUclPvp/iyjunQ+SMi62VGxw8Bhvh2
         EG+Q==
X-Gm-Message-State: AOJu0YwGpCjS0EXDT2Ipt5TLp4oiLFE+EE7JVTIaih8KcomvPOLsN4c6
        Q8ps2bfgI3WuZHN6KbKzDwzWcfsNwHM=
X-Google-Smtp-Source: AGHT+IEpAscyt5f5Hwwk69GbscOVVXW5Z03fLqqUyHqa6upqoF7Zg/V3e/4M/FiDm/F73DT8VFw5bA==
X-Received: by 2002:adf:f288:0:b0:314:ca7:f30b with SMTP id k8-20020adff288000000b003140ca7f30bmr6825696wro.54.1693855260029;
        Mon, 04 Sep 2023 12:21:00 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id x9-20020adfdd89000000b003196b1bb528sm15376825wrl.64.2023.09.04.12.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 12:20:59 -0700 (PDT)
Date:   Mon, 4 Sep 2023 20:20:58 +0100
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OpenRISC updates for 6.6
Message-ID: <ZPYuGlUw9K2PcShj@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Please consider for pull,

The following changes since commit 52a93d39b17dc7eb98b6aa3edb93943248e03b2f:

  Linux 6.5-rc5 (2023-08-06 15:07:51 -0700)

are available in the Git repository at:

  https://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to c289330331eb93bc6a3c68b9119ccd7d4285a4a2:

  openrisc: Remove kernel-doc marker from ioremap comment (2023-08-21 08:15:25 +0100)

----------------------------------------------------------------
OpenRISC updates for 6.6

Updates:

 - Fixes from me to cleanup all compiler warnings reported under
   arch/openrisc.
 - One cleanup from Linus Walleij to convert pfn macros to static
   inlines.

----------------------------------------------------------------

Note, there is one trivial conflict with the mm tree and my patch fixing up the
ioremap comment.

Linus Walleij (1):
      openrisc: Make pfn accessors statics inlines

Stafford Horne (8):
      openrisc: Add missing prototypes for assembly called fnctions
      openrisc: Declare do_signal function as static
      openrisc: Add prototype for show_registers to processor.h
      openrisc: Add prototype for die to bug.h
      openrisc: Include cpu.h and switch_to.h for prototypes
      openriac: Remove unused nommu_dump_state function
      openrisc: Remove unused tlb_init function
      openrisc: Remove kernel-doc marker from ioremap comment

 arch/openrisc/include/asm/bug.h       | 11 +++++
 arch/openrisc/include/asm/page.h      | 11 ++++-
 arch/openrisc/include/asm/processor.h |  1 +
 arch/openrisc/kernel/process.c        |  4 +-
 arch/openrisc/kernel/ptrace.c         |  4 ++
 arch/openrisc/kernel/signal.c         |  7 ++-
 arch/openrisc/kernel/smp.c            |  2 +
 arch/openrisc/kernel/time.c           |  2 +
 arch/openrisc/kernel/traps.c          | 85 +++++------------------------------
 arch/openrisc/mm/fault.c              |  4 +-
 arch/openrisc/mm/init.c               |  2 -
 arch/openrisc/mm/ioremap.c            |  2 +-
 arch/openrisc/mm/tlb.c                |  9 ----
 13 files changed, 51 insertions(+), 93 deletions(-)
 create mode 100644 arch/openrisc/include/asm/bug.h
