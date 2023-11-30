Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822257FEBDB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbjK3JaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjK3JaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:30:10 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D428F;
        Thu, 30 Nov 2023 01:30:16 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3330fd19820so477788f8f.1;
        Thu, 30 Nov 2023 01:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701336615; x=1701941415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YuNTtw2jvQuN4PhWTyrra/q1irsKXH/DVcQCJL0iMU8=;
        b=A5y2F7Pf1S/HONNiXrAK86jZe3N0SOoE0ONtsedAbsiHvs9L74N5zUq8qQThQmLewt
         nUIoBcDKPvgnROW8NtM5gKmbngCeCPcgXyy1qsasf1E2K9pbA/pC6+PXD0uLpebDWt71
         FYVLy+FGUrZ5MaQhmjO6aq8PSUDoHtBSzFmqTjU0LF8VH4yTMXHkQFmRitGcSlq+EgRJ
         zupk3WddIoIyb/B/XXNhqLbBcEflXJ+UliAWsYnhvsYNBuR3kSKH1rzV1DWPscRuT7oZ
         QfURIePypK+AKvalyFDh2o695IBC6XLQET3E7z8NsOROZ3/JCmW6qmQZ5c9KSBgTgvQi
         ZjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701336615; x=1701941415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuNTtw2jvQuN4PhWTyrra/q1irsKXH/DVcQCJL0iMU8=;
        b=oJLN2pmu9MHiCl4i193svxQOdkLvoXUxF3t0UXQ4aNzLVsjDmIDvfmWm/2TaYdbNab
         Fw6zO/Dfu/gKAOfXBufySoKZS9vGvy2QM4OInq2eWI/yAxlGeVf0Hr8wiVLnM7MyHPgR
         mSohZreZik0rvMgfiY2Ca4vWcEm8tSGK1r0r9u0RLPgf7+tE+Geuz1843HOVFDt4OP2Q
         u32JZkjWsG9YXlSfm9tmnJBDKAy+IVsFw8DD6SlktqtXw+WwIH5AE16kuSf8TmAVPPnd
         PEL18Tly4XC7jwpAkkyAiz1PP26wSR1MD3y2n9S6f97/s5+b2HBxQQD4Le0nOqt2hGag
         Jtvg==
X-Gm-Message-State: AOJu0Yycr885N2g/frdsGR3C0Wbk6NtrWIjZanz1fdcqzXBncWmJUiLf
        OdiwQFM8PoKojqxTyrd9HG4=
X-Google-Smtp-Source: AGHT+IFAVSELyNE3gO5IZKHYWynOhknEH6eayw8ijvtfgxPELrwyf3opc19adLXw5KJhk7G47spEdg==
X-Received: by 2002:adf:f588:0:b0:332:eb19:9530 with SMTP id f8-20020adff588000000b00332eb199530mr14011097wro.32.1701336614960;
        Thu, 30 Nov 2023 01:30:14 -0800 (PST)
Received: from gmail.com (1F2EF55A.nat.pool.telekom.hu. [31.46.245.90])
        by smtp.gmail.com with ESMTPSA id r13-20020adfe68d000000b00333040a4752sm995326wrm.114.2023.11.30.01.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 01:30:14 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 30 Nov 2023 10:30:11 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Ashwin Dayanand Kamat <kashwindayan@vmware.com>
Cc:     linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
        bp@alien8.de, brijesh.singh@amd.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, jroedel@suse.de, stable@vger.kernel.org,
        ganb@vmware.com, tkundu@vmware.com, vsirnapalli@vmware.com,
        akaher@vmware.com, amakhalov@vmware.com, namit@vmware.com
Subject: [PATCH] x86/sev: Fix kernel crash due to late update to read-only
 ghcb_version
Message-ID: <ZWhWI2GvfleyGKsa@gmail.com>
References: <1701254429-18250-1-git-send-email-kashwindayan@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1701254429-18250-1-git-send-email-kashwindayan@vmware.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ashwin Dayanand Kamat <kashwindayan@vmware.com> wrote:

> From: Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>
> 
> kernel crash was observed because of page fault, while running
> cpuhotplug ltp testcases on SEV-ES enabled systems. The crash was
> observed during hotplug after the CPU was offlined and the process
> was migrated to different cpu. setup_ghcb() is called again which
> tries to update ghcb_version in sev_es_negotiate_protocol(). Ideally this
> is a read_only variable which is initialised during booting.
> This results in pagefault.

Applied to tip:x86/urgent, thanks.

Tom: I've added your Suggested-by and Acked-by, which appeared to be the 
case given the v1 discussion, let me know if that's not accurate.

I've also tidied up the changelog - final version attached below.

Thanks,

	Ingo

============>
From: Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>
Date: Wed, 29 Nov 2023 16:10:29 +0530
Subject: [PATCH] x86/sev: Fix kernel crash due to late update to read-only ghcb_version

A write-access violation page fault kernel crash was observed while running
cpuhotplug LTP testcases on SEV-ES enabled systems. The crash was
observed during hotplug, after the CPU was offlined and the process
was migrated to different CPU. setup_ghcb() is called again which
tries to update ghcb_version in sev_es_negotiate_protocol(). Ideally this
is a read_only variable which is initialised during booting.

Trying to write it results in a pagefault:

  BUG: unable to handle page fault for address: ffffffffba556e70
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0003) - permissions violation
  [ ...]
  Call Trace:
   <TASK>
   ? __die_body.cold+0x1a/0x1f
   ? __die+0x2a/0x35
   ? page_fault_oops+0x10c/0x270
   ? setup_ghcb+0x71/0x100
   ? __x86_return_thunk+0x5/0x6
   ? search_exception_tables+0x60/0x70
   ? __x86_return_thunk+0x5/0x6
   ? fixup_exception+0x27/0x320
   ? kernelmode_fixup_or_oops+0xa2/0x120
   ? __bad_area_nosemaphore+0x16a/0x1b0
   ? kernel_exc_vmm_communication+0x60/0xb0
   ? bad_area_nosemaphore+0x16/0x20
   ? do_kern_addr_fault+0x7a/0x90
   ? exc_page_fault+0xbd/0x160
   ? asm_exc_page_fault+0x27/0x30
   ? setup_ghcb+0x71/0x100
   ? setup_ghcb+0xe/0x100
   cpu_init_exception_handling+0x1b9/0x1f0

The fix is to call sev_es_negotiate_protocol() only in the BSP boot phase,
and it only needs to be done once in any case.

[ mingo: Refined the changelog. ]

Fixes: 95d33bfaa3e1 ("x86/sev: Register GHCB memory when SEV-SNP is active")
Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Co-developed-by: Bo Gan <bo.gan@broadcom.com>
Signed-off-by: Bo Gan <bo.gan@broadcom.com>
Signed-off-by: Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/1701254429-18250-1-git-send-email-kashwindayan@vmware.com
---
 arch/x86/kernel/sev.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 70472eebe719..c67285824e82 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1234,10 +1234,6 @@ void setup_ghcb(void)
 	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
 		return;
 
-	/* First make sure the hypervisor talks a supported protocol. */
-	if (!sev_es_negotiate_protocol())
-		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
-
 	/*
 	 * Check whether the runtime #VC exception handler is active. It uses
 	 * the per-CPU GHCB page which is set up by sev_es_init_vc_handling().
@@ -1254,6 +1250,13 @@ void setup_ghcb(void)
 		return;
 	}
 
+	/*
+	 * Make sure the hypervisor talks a supported protocol.
+	 * This gets called only in the BSP boot phase.
+	 */
+	if (!sev_es_negotiate_protocol())
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
+
 	/*
 	 * Clear the boot_ghcb. The first exception comes in before the bss
 	 * section is cleared.
