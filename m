Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3577B4671
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 11:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjJAJEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 05:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbjJAJEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 05:04:51 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F3BBE
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 02:04:49 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53447d0241eso13765282a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 02:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696151087; x=1696755887; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=tCQubX3bj24/pd34VGPitQRU/EDWOWODF22SQjv8bUA=;
        b=TIyjhfyO+s4BVgmH0KW1eORv0Bwx0QvWJOCvu1R/3Z+N+Zzv9VumwCN8SumYAJ4/QU
         uREv4cb0NuJ34f9jO2fIRmflq8bPPC3Ho9Qu/0tCLsBXXi/HsePoDpPEUPKyMXspb4qC
         3a5G5U2t7KEju8MCUfPfbwdhP9tx8PVHAR7KG28wMc6TzNeXDmzuAdGtUuL8oR4hkAzQ
         QToOGGCHB2QzSy2FVdN/QkiClFKNLWR2qXwTXUJ5yIKUZnyYgVDSFmyyLNQSGbVs2LEt
         W58DXGB7Q0WPrOLsirdnhZSRUSUbx6PKlYPW+I1U3FA07QWLnWE6Yjbyj/TdIca53bPY
         xSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696151087; x=1696755887;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCQubX3bj24/pd34VGPitQRU/EDWOWODF22SQjv8bUA=;
        b=qGwriB94crq19UdX5aZizrb+pDsFV7PM3iehUUyhOqPxtCnHjhI1KEnZywv81veAlT
         YDX+Kth0eQ2WbSeL3HHJJr5+S1WqdmK8Rf3oT0QfrUm+mv8XTS1MImTq3OqKKkxS3QKv
         befwcAFYIb/ilPjD2Dly9zSCKfjn88OUW0u+gHGmac9mpGVSnM0tkZOSJXmExReUAz6u
         D/3+cmm4XKz+x0gitvq8ZcU/oB4pu24qUNpu/puFfWIv58sPWe0TwijwsmzUKy/yk9Zj
         e1KNuB1cu4jAjdwaujEPAu7qcxWDfaraF32xHILWmrJcV2fut4zSLlDXqMXqM1eXx2ud
         jJpQ==
X-Gm-Message-State: AOJu0YwrKUTeXE21C1N4Zn2ej0UxYQ6fetgOxoTOJ1oMfSN8/EIznCeU
        wRoKgLPX3V4I5sAypKlhnaY=
X-Google-Smtp-Source: AGHT+IF5bvVSH8gi+xPyYlyJAX8Cca7rPJaBRp0wkaap05a/0gWhPvyY+w4yHCC07g3u2sKfRyOBSg==
X-Received: by 2002:a05:6402:d0:b0:530:ccf7:37af with SMTP id i16-20020a05640200d000b00530ccf737afmr7559936edu.12.1696151087490;
        Sun, 01 Oct 2023 02:04:47 -0700 (PDT)
Received: from gmail.com (84-236-113-123.pool.digikabel.hu. [84.236.113.123])
        by smtp.gmail.com with ESMTPSA id q3-20020aa7d443000000b0052576969ef8sm13678324edr.14.2023.10.01.02.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 02:04:45 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 1 Oct 2023 11:04:43 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [GIT PULL] x86 fixes
Message-ID: <ZRk2K2cwKUP0VcQr@gmail.com>
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-10-01

   # HEAD: c6c2adcba50c2622ed25ba5d5e7f05f584711358 x86/sgx: Resolves SECS reclaim vs. page fault for EAUG race

Misc fixes: a kerneldoc build warning fix, add SRSO mitigation for
AMD-derived Hygon processors, and fix a SGX kernel crash in the
page fault handler that can trigger when ksgxd races to reclaim
the SECS special page, by making the SECS page unswappable.

 Thanks,

	Ingo

------------------>
Christophe JAILLET (1):
      x86/kgdb: Fix a kerneldoc warning when build with W=1

Haitao Huang (1):
      x86/sgx: Resolves SECS reclaim vs. page fault for EAUG race

Pu Wen (1):
      x86/srso: Add SRSO mitigation for Hygon processors


 arch/x86/kernel/cpu/common.c   |  2 +-
 arch/x86/kernel/cpu/sgx/encl.c | 30 +++++++++++++++++++++++++-----
 arch/x86/kernel/kgdb.c         |  1 -
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 382d4e6b848d..4e5ffc8b0e46 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1303,7 +1303,7 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_AMD(0x15, RETBLEED),
 	VULNBL_AMD(0x16, RETBLEED),
 	VULNBL_AMD(0x17, RETBLEED | SMT_RSB | SRSO),
-	VULNBL_HYGON(0x18, RETBLEED | SMT_RSB),
+	VULNBL_HYGON(0x18, RETBLEED | SMT_RSB | SRSO),
 	VULNBL_AMD(0x19, SRSO),
 	{}
 };
diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 91fa70e51004..279148e72459 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -235,6 +235,21 @@ static struct sgx_epc_page *sgx_encl_eldu(struct sgx_encl_page *encl_page,
 	return epc_page;
 }
 
+/*
+ * Ensure the SECS page is not swapped out.  Must be called with encl->lock
+ * to protect the enclave states including SECS and ensure the SECS page is
+ * not swapped out again while being used.
+ */
+static struct sgx_epc_page *sgx_encl_load_secs(struct sgx_encl *encl)
+{
+	struct sgx_epc_page *epc_page = encl->secs.epc_page;
+
+	if (!epc_page)
+		epc_page = sgx_encl_eldu(&encl->secs, NULL);
+
+	return epc_page;
+}
+
 static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
 						  struct sgx_encl_page *entry)
 {
@@ -248,11 +263,9 @@ static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
 		return entry;
 	}
 
-	if (!(encl->secs.epc_page)) {
-		epc_page = sgx_encl_eldu(&encl->secs, NULL);
-		if (IS_ERR(epc_page))
-			return ERR_CAST(epc_page);
-	}
+	epc_page = sgx_encl_load_secs(encl);
+	if (IS_ERR(epc_page))
+		return ERR_CAST(epc_page);
 
 	epc_page = sgx_encl_eldu(entry, encl->secs.epc_page);
 	if (IS_ERR(epc_page))
@@ -339,6 +352,13 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
 
 	mutex_lock(&encl->lock);
 
+	epc_page = sgx_encl_load_secs(encl);
+	if (IS_ERR(epc_page)) {
+		if (PTR_ERR(epc_page) == -EBUSY)
+			vmret = VM_FAULT_NOPAGE;
+		goto err_out_unlock;
+	}
+
 	epc_page = sgx_alloc_epc_page(encl_page, false);
 	if (IS_ERR(epc_page)) {
 		if (PTR_ERR(epc_page) == -EBUSY)
diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 3a43a2dee658..9c9faa1634fb 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -695,7 +695,6 @@ void kgdb_arch_exit(void)
 }
 
 /**
- *
  *	kgdb_skipexception - Bail out of KGDB when we've been triggered.
  *	@exception: Exception vector number
  *	@regs: Current &struct pt_regs.
