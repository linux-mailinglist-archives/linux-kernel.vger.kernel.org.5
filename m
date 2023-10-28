Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8057DA6BE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 13:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjJ1LgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 07:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjJ1LgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 07:36:09 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B446FF4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 04:36:06 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9c3aec5f326so846521466b.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 04:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698492965; x=1699097765; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qwDC7NVEY/qYthbLeaOG/eFgqeQvLS7qgyFuHOZWAJ0=;
        b=DYbNUYAtBdwsEc+eVh+Tafg4ulcdNY2uQGysOBh29DVYATjLNzEZdaJoemaQSc5PHw
         eqAZrRRcKSSzDBcxIdJHvcIPGajPa/Mxln+08XkVHYO4NgOSORoXKHgOX772t5fCaBT4
         5XxG/dIUwfLcGayGtaoBm5LQGIJr9CitZzmFqT89O6gwwW/YQEb87sMLjPwWvdMaB9sk
         ZfgYgOt7j2iXgnQuV6ZnNQ0Inx9WS3O+Oo3xmIIO+GpgotB6Ckac+IW8SLnvzcbD5vO+
         uHP9OiSHKiEgBb7SkIgTLNoJpWC+V/452xA+pT3qqv0emvP/0WHLg7NWd7r6jOBU4RCP
         Cl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698492965; x=1699097765;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwDC7NVEY/qYthbLeaOG/eFgqeQvLS7qgyFuHOZWAJ0=;
        b=iPG18qV5yAUzoFN0+PhOWnNkSyZD+hO/LqIKdV+c0b4bs9PUWV8OfVnmGGueQQuH9/
         tHAKIg+aKNosLoAe48U3lOdjtbm8pGT4ri7nqzaDJojcFxBj6YOAEWBIPD6VTm23VPyK
         kO2AcEYgNZxIbnmhQWptXKSzxNC8KldtZ/nZpVOd/YPE8K2qScZbRubHE4lQgRW7yfNZ
         J4Vd2AQlYbmgGN6IcXMUv0TFf5lQwxX7DgviulL4aWWEmIclDL6RL0ax+Hg+9Obk7evv
         o2X4cSzOXeqACO8IWHSEDWaQT094Fedb21uFYUfbCn6oWdS+T+F9rai0Pfp+zI8HjEFC
         Jr/A==
X-Gm-Message-State: AOJu0Yy/tvvxC3tnpFLmmHexEkpQBRlAZA+Bi6uSPvamO/OY1mouwnZJ
        0VROtKPEHUlKqodwB/oN3ZE=
X-Google-Smtp-Source: AGHT+IEPSm+M7HeAHd3E/7L5eplWVMqrARlCy3N8OJ5wJ2hlbgerY+8mEQawKYey/kLYQ3fab5yA2Q==
X-Received: by 2002:a17:907:c10:b0:9b2:b37d:17ff with SMTP id ga16-20020a1709070c1000b009b2b37d17ffmr8207654ejc.19.1698492964797;
        Sat, 28 Oct 2023 04:36:04 -0700 (PDT)
Received: from gmail.com (1F2EF1E7.nat.pool.telekom.hu. [31.46.241.231])
        by smtp.gmail.com with ESMTPSA id r23-20020a170906365700b009aa292a2df2sm2645867ejb.217.2023.10.28.04.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 04:36:03 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 28 Oct 2023 13:36:01 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] objtool changes for v6.7
Message-ID: <ZTzyIWSElIo0KZzD@gmail.com>
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

Please pull the latest objtool tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2023-10-28

   # HEAD: 60fd39af33d3f63c4c94bd06784ebdf0d883f5c9 scripts/faddr2line: Skip over mapping symbols in output from readelf

Misc fixes and cleanups:

 - Fix potential MAX_NAME_LEN limit related build failures
 - Fix scripts/faddr2line symbol filtering bug
 - Fix scripts/faddr2line on LLVM=1
 - Fix scripts/faddr2line to accept readelf output with mapping symbols
 - Minor cleanups

 Thanks,

	Ingo

------------------>
Aaron Plattner (2):
      objtool: Propagate early errors
      objtool: Remove max symbol name length limitation

Colin Ian King (1):
      x86/unwind/orc: Remove redundant initialization of 'mid' pointer in __orc_find()

Fangrui Song (1):
      x86/speculation, objtool: Use absolute relocations for annotations

Ruan Jinjie (1):
      objtool: Use 'the fallthrough' pseudo-keyword

Will Deacon (3):
      scripts/faddr2line: Don't filter out non-function symbols from readelf
      scripts/faddr2line: Use LLVM addr2line and readelf if LLVM=1
      scripts/faddr2line: Skip over mapping symbols in output from readelf


 arch/x86/include/asm/alternative.h   |  4 ++--
 arch/x86/include/asm/nospec-branch.h |  4 ++--
 arch/x86/kernel/unwind_orc.c         |  2 +-
 include/linux/objtool.h              | 10 +++++-----
 scripts/faddr2line                   | 24 +++++++++++++++++++++---
 tools/objtool/arch/x86/decode.c      |  6 +++---
 tools/objtool/elf.c                  | 14 ++++++--------
 tools/objtool/objtool.c              |  4 +---
 8 files changed, 41 insertions(+), 27 deletions(-)
