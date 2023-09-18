Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BE57A5234
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 20:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjIRSly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 14:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjIRSlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:41:52 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEEC10E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:41:44 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50305abe5f0so3417245e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695062502; x=1695667302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQ+q0T8YrB094CXnsCagarFzPUdIifnZ/onZKcaHCnQ=;
        b=glACbFBOKogNGkaDdj1L/41sjOX8RXDLQe8O+h7xjd2Y7MaywaxC03l1Gnp7593FMI
         tyd4m4Um1M6RRzg7kQV6v7Oavj/UYRAo+qj3jaxpREsKVryy7Dx+24HnTobZQ59Jak9B
         rXh3ncf8FhIDgMcSDQ4FrksG0MgdOaUDymWTi55WxDg3DVEAApq2rhExNBLzoiCC7lZE
         bjQO3uy35Vookei5rg2/IZ+zmXFtDxr8UAscOhheWGgMDN1bLifQl4SZLMl79uw1VLwc
         49qZU1VRrAvz5uPpQAxCKXEbEKxFfKHyUWqqqI4auMZyJGeZMT3qgkdBly6uVuFppgGY
         YLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695062502; x=1695667302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZQ+q0T8YrB094CXnsCagarFzPUdIifnZ/onZKcaHCnQ=;
        b=WyfRFQBta3hKzWcR84rvjvboFePrxl4Heih+NVGGQ80/zUJKyQ57ZWT8nZnxTputZy
         9Cy6KEfa3LKAA85cNpszFuKfvrM9u8uiDhpydAWQ3bzW2RwQPFzhJQfNncbJeB9eZ5Zy
         iukcTO2dC/8XsXwbp+bcZCwhoxPMtNL5X/2l+IC1gNQX9XqLjU4s5gwrZOr1wo6jeAZH
         yT7YCMHdD8UCbuslAqQLjQcTonKtn/+BqUQj9SlX7ZmXHOBTJL3t9soqHbD0T0hgtFVp
         ftVmkW4SSxPM2EUGytKdPNVs1586JUaONq9YqRM4H0yfoQxz/nfyC3B6hxESVxXQnoMX
         K00Q==
X-Gm-Message-State: AOJu0YzJDTX1jw954sJ77rMepUul6oTnf8Ufh6k19kh/mdb6fsQZ38CU
        cbC19eCVuiVDwW6frqFdpAY=
X-Google-Smtp-Source: AGHT+IHLtiI9VDh5PLrhIug65vRa9BduPqazf9acxvIyB4BB19xYEOugYKMu+oHeEV1GhgdqoFaMug==
X-Received: by 2002:a19:ca46:0:b0:500:8723:e457 with SMTP id h6-20020a19ca46000000b005008723e457mr7081720lfj.30.1695062501967;
        Mon, 18 Sep 2023 11:41:41 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id oq8-20020a170906cc8800b0099bc08862b6sm6952075ejb.171.2023.09.18.11.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 11:41:41 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RESEND PATCH v3] locking/lockref/x86: Enable ARCH_USE_CMPXCHG_LOCKREF for X86_CMPXCHG64
Date:   Mon, 18 Sep 2023 20:40:27 +0200
Message-ID: <20230918184050.9180-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit bc08b449ee14ace4d869adaa1bb35a44ce68d775 enabled lockless
reference count updates using cmpxchg() only for x86_64 and
left x86_32 behind due to inability to detect support for
cmpxchg8b instruction. Nowadays, we can use CONFIG_X86_CMPXCHG64
for this purpose. Also, by using try_cmpxchg64() instead of cmpxchg64()
in CMPXCHG_LOOP macro, the compiler actually produces sane code,
improving lockref_get_not_zero main loop from:

  eb:	8d 48 01             	lea    0x1(%eax),%ecx
  ee:	85 c0                	test   %eax,%eax
  f0:	7e 2f                	jle    121 <lockref_get_not_zero+0x71>
  f2:	8b 44 24 10          	mov    0x10(%esp),%eax
  f6:	8b 54 24 14          	mov    0x14(%esp),%edx
  fa:	8b 74 24 08          	mov    0x8(%esp),%esi
  fe:	f0 0f c7 0e          	lock cmpxchg8b (%esi)
 102:	8b 7c 24 14          	mov    0x14(%esp),%edi
 106:	89 c1                	mov    %eax,%ecx
 108:	89 c3                	mov    %eax,%ebx
 10a:	8b 74 24 10          	mov    0x10(%esp),%esi
 10e:	89 d0                	mov    %edx,%eax
 110:	31 fa                	xor    %edi,%edx
 112:	31 ce                	xor    %ecx,%esi
 114:	09 f2                	or     %esi,%edx
 116:	75 58                	jne    170 <lockref_get_not_zero+0xc0>

to:

 350:	8d 4f 01             	lea    0x1(%edi),%ecx
 353:	85 ff                	test   %edi,%edi
 355:	7e 79                	jle    3d0 <lockref_get_not_zero+0xb0>
 357:	f0 0f c7 0e          	lock cmpxchg8b (%esi)
 35b:	75 53                	jne    3b0 <lockref_get_not_zero+0x90>

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
---
v3:
 - Update commit message to refer to lockref_get_not_zero
   instead of removed lockref_get_or_lock
v2:
 - select ARCH_USE_CMPXCHG_LOCKREF for CONFIG_X86_CMPXCHG which
   is unconditionally defined for X86_64
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 66bfabae8814..1379603016fd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -28,7 +28,6 @@ config X86_64
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_SUPPORTS_PER_VMA_LOCK
-	select ARCH_USE_CMPXCHG_LOCKREF
 	select HAVE_ARCH_SOFT_DIRTY
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE
@@ -118,6 +117,7 @@ config X86
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_USE_BUILTIN_BSWAP
+	select ARCH_USE_CMPXCHG_LOCKREF		if X86_CMPXCHG64
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
-- 
2.41.0

