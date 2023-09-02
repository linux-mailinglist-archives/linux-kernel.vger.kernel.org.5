Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C2879074F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 12:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351976AbjIBKYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 06:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbjIBKYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 06:24:39 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6944610FA
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 03:24:36 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31c63cd4ec2so2375703f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 03:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693650275; x=1694255075; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=utfY2dAnWjR0VSpzfKne1BsqQhFvZeCZtLvgKHqB0U4=;
        b=A5NPX0pw2zzgbHuJjtzB7Y4Va1kKb0faQCqZ/ubKjgzJvzNU+3meuvWCTqwxvjOF9D
         UwXOnkC5F9kGan9qIEd+8IFQedDefcEP8pLQzBPQbQyrLmv7uyTKFsWb1RHpll7T1lj9
         5jrPFVuoSLHCmOnCdtvFS4rGyE36LsFxRpG4F7UwIeQVDwjnIaB9cKq2ms7rIej43SVj
         QXNdUDyZ1gMRNxAcJmDO1U79dTnFn0giKIfdjFHb1lIwGWaGTfjfNLxqL+dEL10qV+3s
         /EVqfryiavJwNL79d1oYShiZBl5OUJfGTNf24dPJ3qXx++8KiMLqtEjkYBDbxKjZi2wm
         8+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693650275; x=1694255075;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=utfY2dAnWjR0VSpzfKne1BsqQhFvZeCZtLvgKHqB0U4=;
        b=TDAD1t1KiPWAlZVvZr1hbUwhGQO3NBXmqqjEgdEjPU0n4JdLyj4bC9Oz+dNuH6z8+m
         co1lKfh7SHa3RG7XEjEgE6KdNzYAwdeI8Ih4tkxLNXtiYVs0B8MtVw18ZFhzYQ2BZ4bE
         hIHYE6PgDAoh70RBC3/MfRTl85c+JXvAlarf5bOqgUjOGTvX1uMHBuEvyBtDar9hiRma
         POWlT5qy90DgbbEJ6kvuyuhJQi5npZXz3oj5hypAYfgN0wBh5P/hHkdBGKrq20vlSLAA
         TL1WvIs8EG0pti4kiBguTR5r/N+PeKqZmcxjLeeVevlZuON0/eBypXkLdgWC5Wg9F/cr
         tnJg==
X-Gm-Message-State: AOJu0Yx1CbdAOyVaSag1XNjF7C70WSW/e4NIYg6nbIHPKTZ9AB7PBv+H
        Yf21KMt1z3Rtze4viq5Yd6A=
X-Google-Smtp-Source: AGHT+IG+oBZJaKjHCN6J9ZgFwfvBf8LmtK/DhQqoDGgZbAaYncffB2ln+OhZjlAI214RVZ3pba52Gg==
X-Received: by 2002:adf:f883:0:b0:317:727f:3bc7 with SMTP id u3-20020adff883000000b00317727f3bc7mr3858631wrp.17.1693650274663;
        Sat, 02 Sep 2023 03:24:34 -0700 (PDT)
Received: from gmail.com (1F2EF6A2.nat.pool.telekom.hu. [31.46.246.162])
        by smtp.gmail.com with ESMTPSA id bt12-20020a056000080c00b0031433443265sm2253538wrb.53.2023.09.02.03.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 03:24:32 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 2 Sep 2023 12:24:30 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [GIT PULL] x86 fix
Message-ID: <ZPMNXtbIPMdjdn3o@gmail.com>
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

Please pull the latest x86/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-09-02

   # HEAD: 6ea7bb00c1ba180f8bf8320b8d59b532501c5271 selftests/x86: Update map_shadow_stack syscall nr

Fix __NR_map_shadow_stack syscall-renumbering fallout in the
x86 self-test code.

[ Arguably the existing code was unnecessarily fragile, and
  tooling should have picked up the new syscall number,
  and a wider fix is being worked on - but meanwhile, let's
  not have the old syscall number in the kernel tree. ]

 Thanks,

	Ingo

------------------>
Rick Edgecombe (1):
      selftests/x86: Update map_shadow_stack syscall nr


 tools/testing/selftests/x86/test_shadow_stack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/test_shadow_stack.c b/tools/testing/selftests/x86/test_shadow_stack.c
index 2188968674cb..757e6527f67e 100644
--- a/tools/testing/selftests/x86/test_shadow_stack.c
+++ b/tools/testing/selftests/x86/test_shadow_stack.c
@@ -40,7 +40,7 @@
  * without building the headers.
  */
 #ifndef __NR_map_shadow_stack
-#define __NR_map_shadow_stack	452
+#define __NR_map_shadow_stack	453
 
 #define SHADOW_STACK_SET_TOKEN	(1ULL << 0)
 
