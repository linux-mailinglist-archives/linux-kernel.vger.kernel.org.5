Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F65275F219
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbjGXKHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbjGXKGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:06:49 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A509583D5;
        Mon, 24 Jul 2023 02:59:18 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a3373211a1so2491743b6e.0;
        Mon, 24 Jul 2023 02:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690192735; x=1690797535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RDlfftCqHuUNq6LkkwKxzRiSDkmFGSCz0/vq6oh3T+s=;
        b=DSXykGWLjFrMqpPv66tlr93X7a0vmBHxz/80vR9k8v9lxYIlxldXX+1QWnvqrVQiPL
         T9Z0gIzVebVrJtp/2dD1t24vN029WXT4YJv6bfRGMsyfrY7Ev7oCdHj/SdtZ3eKyWxJ1
         qp1KSO0l/8QzlY8IcUxvUKiFg83LuDfw9+RP1+s/OGqqqy/Py0x9QGfKA9M186kkmNxK
         PsY/yS3fIWwz3Wa/OVWrLwpf8y9A0QALq0ODtl9acsl6mEWViFV/17vEYrEyFlXN0Mpn
         b5wly/Nqx3jOJrPhGkUvcatvS4JRzlZvhfIA4VyebxQJiDaXw3czDVbLLBv200CQBMbz
         S8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690192735; x=1690797535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDlfftCqHuUNq6LkkwKxzRiSDkmFGSCz0/vq6oh3T+s=;
        b=hlN12kPJz4SLuUOvrtSpXgWR52DyrWUq07zVdDOedyHFq2XwT+qdY/95eqTYvwrnkM
         Zf7QZ2vDqQSLTj6xO88vYWwNAdNd9KgyMMEWhApohKeds0+2tW3r1jRaVImkXIzmyd3c
         3zDwU9EPb+DpBsM7D9+AujCwGNyhhME3xPd6IE3amUr5umMcofas+boraY9BoMuDq0xO
         rrfPchQ0Iylo/rjnEEiZUsKOKSUHiX7+lv/6oZeJN5r2/AEOyJiDDC1fNZtjbgniZfXq
         CAyVybM/PwXFPaz+zHaNmj7l/GCi4FDcd62hNYRxmGn1PCNTVRWnbNEAENmLAq1he4ib
         kFyg==
X-Gm-Message-State: ABy/qLZPT2qStzSjldPCAItxc7AIGzQpF/zHgrywPXuvaXmL/T0qvN4C
        7Ev3QIhjK75gL3OUO3M1RcQ=
X-Google-Smtp-Source: APBJJlHa0gbcqcComJDdQw8zIzYrXjx/3orq1WOFxcJ0mjEKBVzrS5YHzxRQ/Nvge46RN553XCHzQQ==
X-Received: by 2002:a05:6808:98c:b0:3a3:7ecd:7d32 with SMTP id a12-20020a056808098c00b003a37ecd7d32mr9466634oic.30.1690192735254;
        Mon, 24 Jul 2023 02:58:55 -0700 (PDT)
Received: from localhost.localdomain ([58.240.82.166])
        by smtp.gmail.com with ESMTPSA id d12-20020a63734c000000b0055acfd94c20sm8174380pgn.35.2023.07.24.02.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:58:54 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        corbet@lwn.net, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, xianting.tian@linux.alibaba.com,
        suagrfillet@gmail.com, anup@brainfault.org, robh@kernel.org,
        ajones@ventanamicro.com, alexghiti@rivosinc.com,
        conor.dooley@microchip.com
Cc:     kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH -fixes 1/2] riscv: Export va_kernel_pa_offset in vmcoreinfo
Date:   Mon, 24 Jul 2023 17:57:44 +0800
Message-Id: <20230724095745.286695-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since RISC-V Linux v6.4, the commit 3335068f8721 ("riscv: Use
PUD/P4D/PGD pages for the linear mapping") changes phys_ram_base
from the physical start of the kernel to the actual start of the DRAM.

The Crash-utility's VTOP() still uses phys_ram_base and kernel_map.virt_addr
to translate kernel virtual address, that failed the Crash with Linux v6.4 [1].

Export kernel_map.va_kernel_pa_offset in vmcoreinfo to help Crash translate
the kernel virtual address correctly.

Fixes: 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
Link: https://lore.kernel.org/linux-riscv/20230724040649.220279-1-suagrfillet@gmail.com/ [1]
Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 arch/riscv/kernel/crash_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kernel/crash_core.c b/arch/riscv/kernel/crash_core.c
index b351a3c01355..55f1d7856b54 100644
--- a/arch/riscv/kernel/crash_core.c
+++ b/arch/riscv/kernel/crash_core.c
@@ -18,4 +18,6 @@ void arch_crash_save_vmcoreinfo(void)
 	vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
 #endif
 	vmcoreinfo_append_str("NUMBER(KERNEL_LINK_ADDR)=0x%lx\n", KERNEL_LINK_ADDR);
+	vmcoreinfo_append_str("NUMBER(va_kernel_pa_offset)=0x%lx\n",
+						kernel_map.va_kernel_pa_offset);
 }
-- 
2.20.1

