Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DDE789885
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 19:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjHZRzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 13:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjHZRyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 13:54:49 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B92EE50
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 10:54:46 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-307d20548adso1552421f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 10:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693072484; x=1693677284;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jYz9Ku4lLMgD3sQ8NBujiOp2+Shw9Ksj1jsnIiTXB7g=;
        b=QlJmi9W7NbNvpYdX8fLNFDF99utMISCrQWHdwTb9gJcmrNoSSnik+YtD3ykoQSbY24
         M7xiPgaaxFI5OJkp8E2qAC4zc31Y97lzBTMQTl+rY3wSPxLIfBupWVphs+nYWZ1pJjJN
         YSadDQSh8mrs3Hb8+SADz38GQUnNJkmyw2tmcm8CznOjf4gwuTXYgiieYAWsr/cubinj
         58FnSvUf4hrKa7cmA5/sPN8lqy6O3jkdvvp12Ny6jM14xFlvtL0GxFhgtdTzYrYXiD6J
         peaHu4Pmk6FqgiSR9RaD4wzfiTpLo1P+lI5RRBU50k5CZAJECZbRJNQ9T2MWrlCzlOMy
         lBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693072484; x=1693677284;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYz9Ku4lLMgD3sQ8NBujiOp2+Shw9Ksj1jsnIiTXB7g=;
        b=gUwUhF9XpNMAndmDpwrOJmq8OjViqb5+mWCjNFdILneb+sYbyKbxsyXjmLoTAn76iT
         PSyEES+mcrO/u3ORGaPB+CaFgoqA5Ig86vcqfd0iP6ep2mVeZES1oixGEsm2tL2D5310
         XOgPsam7TcJ21e+MeEW0nRljQ2j05cwBwS1fnA9yrdO6jEVILKsNXJ3uWNO1szsiv5T4
         2+yJhFoCYf/0ifnNMWYpGJHHZRW+6Lsn0Az9IRZWs3HXNVsRDj97nlEvtnDHenL6SyEh
         ptsPQxEidOKMcvchIRz1sSdV8/pazp/O6jSSTluOMQipN4VdKfyfCEESao7huMcZu/bb
         HvdA==
X-Gm-Message-State: AOJu0Yw4xFKB9WxGr7cMv2GnjtuFMqgzo0ql5k/TxKR3bqbMFZbjuULw
        eY8/sjVUZO2HkCyDwruYCAM=
X-Google-Smtp-Source: AGHT+IHWR78yDd9O5V12LA9SuOjrykFmuAO+i20ZhkYxu8wuSeH6gz5zOUvvCDx15J2QSuRuB6kMGQ==
X-Received: by 2002:a5d:414f:0:b0:314:17cc:31d0 with SMTP id c15-20020a5d414f000000b0031417cc31d0mr16749479wrq.34.1693072484108;
        Sat, 26 Aug 2023 10:54:44 -0700 (PDT)
Received: from gmail.com (1F2EF3C0.nat.pool.telekom.hu. [31.46.243.192])
        by smtp.gmail.com with ESMTPSA id l9-20020a056000022900b0031c8a43712asm1526894wrz.69.2023.08.26.10.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 10:54:41 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 26 Aug 2023 19:54:39 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [GIT PULL] x86 fixes
Message-ID: <ZOo8XxiWEKL+BJeB@gmail.com>
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-08-26

   # HEAD: 2c66ca3949dc701da7f4c9407f2140ae425683a5 x86/fpu: Set X86_FEATURE_OSXSAVE feature after enabling OSXSAVE in CR4

Fix an FPU invalidation bug on exec(), and fix a performance
regression due to a missing setting of X86_FEATURE_OSXSAVE.

 Thanks,

	Ingo

------------------>
Feng Tang (1):
      x86/fpu: Set X86_FEATURE_OSXSAVE feature after enabling OSXSAVE in CR4

Rick Edgecombe (1):
      x86/fpu: Invalidate FPU state correctly on exec()


 arch/x86/kernel/fpu/context.h | 3 +--
 arch/x86/kernel/fpu/core.c    | 2 +-
 arch/x86/kernel/fpu/xstate.c  | 7 +++++++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/fpu/context.h b/arch/x86/kernel/fpu/context.h
index af5cbdd9bd29..f6d856bd50bc 100644
--- a/arch/x86/kernel/fpu/context.h
+++ b/arch/x86/kernel/fpu/context.h
@@ -19,8 +19,7 @@
  * FPU state for a task MUST let the rest of the kernel know that the
  * FPU registers are no longer valid for this task.
  *
- * Either one of these invalidation functions is enough. Invalidate
- * a resource you control: CPU if using the CPU for something else
+ * Invalidate a resource you control: CPU if using the CPU for something else
  * (with preemption disabled), FPU for the current task, or a task that
  * is prevented from running by the current task.
  */
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 1015af1ae562..98e507cc7d34 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -679,7 +679,7 @@ static void fpu_reset_fpregs(void)
 	struct fpu *fpu = &current->thread.fpu;
 
 	fpregs_lock();
-	fpu__drop(fpu);
+	__fpu_invalidate_fpregs_state(fpu);
 	/*
 	 * This does not change the actual hardware registers. It just
 	 * resets the memory image and sets TIF_NEED_FPU_LOAD so a
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 0bab497c9436..1afbc4866b10 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -882,6 +882,13 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 		goto out_disable;
 	}
 
+	/*
+	 * CPU capabilities initialization runs before FPU init. So
+	 * X86_FEATURE_OSXSAVE is not set. Now that XSAVE is completely
+	 * functional, set the feature bit so depending code works.
+	 */
+	setup_force_cpu_cap(X86_FEATURE_OSXSAVE);
+
 	print_xstate_offset_size();
 	pr_info("x86/fpu: Enabled xstate features 0x%llx, context size is %d bytes, using '%s' format.\n",
 		fpu_kernel_cfg.max_features,
