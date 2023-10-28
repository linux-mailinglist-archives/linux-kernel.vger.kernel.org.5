Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430C37DA75E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 15:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjJ1Nns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 09:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjJ1Nnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 09:43:47 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EBF11B
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 06:43:44 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54041e33845so4541408a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 06:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698500622; x=1699105422; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=FeSH/1L4tOlbWkskU7CQ0rV9kqxc5jadtema2B1aPjE=;
        b=gLwr8vSVI6Fu/zMAs0HfnJFV/IW7gVgo7ndVwFxY4xaiwIQg5yIH/tC5ju0pfnO7gM
         bwWK5wIYO6E7x794xhJZwO2vvGE1cTGz8S2r9O/nbbVeifU25UhaNOJuyMGsq7vwe/8k
         Vl9hlib6PkCSxhUZE++Yth25gnTp7xD/fx/fFaaF8LlQ+9UoTFv/cUipG+LRfNdQRwr/
         GzQEhPUd1O8Dq3RfnMcIXpagXO6W5spd+RU+qXjKWxy7sA7QArT7Kmf9gNf8GbKDLeWh
         eUEBulVuk4tFB/+YE3N9V9Ex9Z+dXsGIl4SfzNWtxRrKJIMFeY14nPPWfMCjQGJFEYOr
         fh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698500622; x=1699105422;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FeSH/1L4tOlbWkskU7CQ0rV9kqxc5jadtema2B1aPjE=;
        b=ueKF0KdsRIubm2SUgfoGW30rfzUAyYW1AWw8uIGPt6/mKXatlvKdEdlnCYxVWwYMFz
         9B0zko+PDOq8OY7M64esk2qUM6p0tv7aqobxUILFSSOadcuiayRU9E8O4lyn6n09fXgC
         Lk1BmVzN1axNsFKP5iVKnjxzvEYsK0iGIUUAtrFtoHcSOH9oDV8hP9srmRk95ykStb2n
         hsGSr+dkePeUY9F9yz4/ZbZpXOqOc3oUymdhQhHGx2RXxdmF+/M8ZgPwtIBFHYsJ8zOW
         s31ABceePVs1qJPVEYsn5bJ3RBovrWWi+06CcHaYw1FjHep8aTA2drgugno0FiIt/gAS
         gVnA==
X-Gm-Message-State: AOJu0Yx7AmEaATs1GsLnIinfzbkbo2ybE85gIZETg6vM8t5FwlFzXarG
        AAAmXBuA+Q+1xiS8MJzRfmWLrJrK/z0=
X-Google-Smtp-Source: AGHT+IEGRVSsZSXB80mC17cGGVFFlrEHk741RBR9ikSC9ZbNo22R+lIDbblfRIhZ9eDknFw+cWo+Ag==
X-Received: by 2002:aa7:c6c9:0:b0:523:100b:462b with SMTP id b9-20020aa7c6c9000000b00523100b462bmr4910601eds.5.1698500622540;
        Sat, 28 Oct 2023 06:43:42 -0700 (PDT)
Received: from gmail.com (1F2EF1E7.nat.pool.telekom.hu. [31.46.241.231])
        by smtp.gmail.com with ESMTPSA id p5-20020a056402074500b0053e67bcb3e7sm2839754edy.82.2023.10.28.06.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 06:43:41 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 28 Oct 2023 15:43:39 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [GIT PULL] x86/irq change for v6.7
Message-ID: <ZT0QC/LQKl4xNji/@gmail.com>
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

Please pull the latest x86/irq git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-irq-2023-10-28

   # HEAD: f44075ecafb726830e63d33fbca29413149eeeb8 x86/nmi: Fix out-of-order NMI nesting checks & false positive warning

Fix out-of-order NMI nesting checks resulting in false positive warnings.

 Thanks,

	Ingo

------------------>
Paul E. McKenney (1):
      x86/nmi: Fix out-of-order NMI nesting checks & false positive warning


 arch/x86/kernel/nmi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index a0c551846b35..4766b6bed443 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -507,12 +507,13 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 	}
 	this_cpu_write(nmi_state, NMI_EXECUTING);
 	this_cpu_write(nmi_cr2, read_cr2());
+
+nmi_restart:
 	if (IS_ENABLED(CONFIG_NMI_CHECK_CPU)) {
 		WRITE_ONCE(nsp->idt_seq, nsp->idt_seq + 1);
 		WARN_ON_ONCE(!(nsp->idt_seq & 0x1));
 		WRITE_ONCE(nsp->recv_jiffies, jiffies);
 	}
-nmi_restart:
 
 	/*
 	 * Needs to happen before DR7 is accessed, because the hypervisor can
@@ -548,16 +549,16 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 
 	if (unlikely(this_cpu_read(nmi_cr2) != read_cr2()))
 		write_cr2(this_cpu_read(nmi_cr2));
-	if (this_cpu_dec_return(nmi_state))
-		goto nmi_restart;
-
-	if (user_mode(regs))
-		mds_user_clear_cpu_buffers();
 	if (IS_ENABLED(CONFIG_NMI_CHECK_CPU)) {
 		WRITE_ONCE(nsp->idt_seq, nsp->idt_seq + 1);
 		WARN_ON_ONCE(nsp->idt_seq & 0x1);
 		WRITE_ONCE(nsp->recv_jiffies, jiffies);
 	}
+	if (this_cpu_dec_return(nmi_state))
+		goto nmi_restart;
+
+	if (user_mode(regs))
+		mds_user_clear_cpu_buffers();
 }
 
 #if IS_ENABLED(CONFIG_KVM_INTEL)
