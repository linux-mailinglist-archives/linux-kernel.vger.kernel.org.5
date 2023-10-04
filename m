Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6686B7B8273
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242923AbjJDOfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242853AbjJDOey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:34:54 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA38C1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 07:34:49 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-406532c49dcso4962995e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 07:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696430087; x=1697034887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bnst9RFi2qMRMZzxH/03e6Z8hZKzXbR6dhcQes3Pvo=;
        b=s3t5CMDyr5NM0I+qnCl8zPxVhJp+pngvy1a6Wap53T+gUseW5c34wWzsDr/rMBVxpM
         yT353nUKiHwbhOK5clFQUNgmRBM8q0RKYgX5jNjQSSs0nIV2XagzWfnu509Ik1paNrLO
         YTMelTo7L3KGLtPEz8HITfHgn4vJQVGZg9xD+rI+mVL5oAYo5e5HZmURFEALUwBwvVBK
         22i8eJQcQvxT4/mSXwuun1axpsLUKVn71tu2cEh4cVGODiKJ9wk2nMriINI23QiZEaUn
         dA2PcXkWhv46Pp9TluEoaHTnh+Z4jWZMdWeKqk7j6Mp5W3XhFdhPcbq8UxlUqLTmNe9E
         umSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696430087; x=1697034887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bnst9RFi2qMRMZzxH/03e6Z8hZKzXbR6dhcQes3Pvo=;
        b=pfvLozKaTHoXaXQTlQNw1hYI8fyis53Dmz3+IvcM2WDTz479+zDlU3TVUrg+uQ1mUn
         gRQuxps96rgaIGkp0MkFJvnhq3IZJNnBF5Aj/rSdA7i/e71hxbF+e97XfVkFm9Urh9zc
         gB0w0qqIIwRgMIdBgH9rwTf03iACPAhRfZlugSvLpgaaDeLYav3m4eqZ3J0pLK12MJS7
         S5D/MT4KGkfqJKUH1LpQIzTVeR7JIOQA3zxAfGSiLFFMQv0e2EU2oLDbrDZQknNBUwN3
         SUnWZl9uAjHQ6jOBb8WpUhOL5/JRBgoPZh+kdQVNK98YCxplZ5T7H0YiaAd7xTjiJOiN
         9P0Q==
X-Gm-Message-State: AOJu0Yxo5axvANfHQWzwXZBgDM9dSCpsi3L7soxEwz2c4Zpsn/v3+pE/
        qDVy4cY11HOS5z0rlYiITc6+nQ==
X-Google-Smtp-Source: AGHT+IGv2rOkd9IY0oWDOdOvSePKsvDtHrwfyqoPkkf3uEq1UxzbLBZlJ1jVnRYu2m9ZWsFcjceIRg==
X-Received: by 2002:a05:600c:1d03:b0:404:7606:a871 with SMTP id l3-20020a05600c1d0300b004047606a871mr2511608wms.2.1696430086851;
        Wed, 04 Oct 2023 07:34:46 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:9474:8d75:5115:42cb])
        by smtp.gmail.com with ESMTPSA id t20-20020a1c7714000000b00401e32b25adsm1686205wmi.4.2023.10.04.07.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 07:34:46 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
Subject: [PATCH 3/5] riscv: kernel: Use correct SYM_DATA_*() macro for data
Date:   Wed,  4 Oct 2023 16:30:52 +0200
Message-ID: <20231004143054.482091-4-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004143054.482091-1-cleger@rivosinc.com>
References: <20231004143054.482091-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some data were incorrectly annotated with SYM_FUNC_*() instead of
SYM_DATA_*() ones. Use the correct ones.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/entry.S | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 64ac0dd6176b..a7aa2fd599d6 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -324,7 +324,7 @@ SYM_FUNC_END(__switch_to)
 	.section ".rodata"
 	.align LGREG
 	/* Exception vector table */
-SYM_CODE_START(excp_vect_table)
+SYM_DATA_START_LOCAL(excp_vect_table)
 	RISCV_PTR do_trap_insn_misaligned
 	ALT_INSN_FAULT(RISCV_PTR do_trap_insn_fault)
 	RISCV_PTR do_trap_insn_illegal
@@ -342,12 +342,11 @@ SYM_CODE_START(excp_vect_table)
 	RISCV_PTR do_page_fault   /* load page fault */
 	RISCV_PTR do_trap_unknown
 	RISCV_PTR do_page_fault   /* store page fault */
-excp_vect_table_end:
-SYM_CODE_END(excp_vect_table)
+SYM_DATA_END_LABEL(excp_vect_table, SYM_L_LOCAL, excp_vect_table_end)
 
 #ifndef CONFIG_MMU
-SYM_CODE_START(__user_rt_sigreturn)
+SYM_DATA_START(__user_rt_sigreturn)
 	li a7, __NR_rt_sigreturn
 	ecall
-SYM_CODE_END(__user_rt_sigreturn)
+SYM_DATA_END(__user_rt_sigreturn)
 #endif
-- 
2.42.0

