Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71C876EA64
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbjHCNbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjHCNa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:30:59 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8884C1716
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 06:29:22 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686f94328a4so683977b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 06:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691069351; x=1691674151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ntEvLFlRpNT+qR6jlJekxZXF9ONqBaZB8tTPc8hJxHo=;
        b=aq/S7/aTPM+jsQtw76McH/TkFHY/hJfftBjXoaty8AFCiu52VNsFuIa2y/jT+iW6rG
         qY0TwLe48wBcbUlPMpFNxWv67kyywoGrwj8xJxu3AkhYZRAYf6Wfbt5RFwMpPf9VVQAr
         2pxdC+LjsS1A/x3VvS81QlMwp5FaNPh/y+PHOFG8GmogYfpQ9cA557fuxP9q4bHl+RkZ
         Qy1r5R3kh9wBgwX6cveOxF17KilSfhAlOXlWVBY29U2SIM5XLujru4yVDXHaGrGEYC9W
         25mnc+PIC+/ubhs+UNho4VDIdw+jaA/YTihXZ+CHEH4uwT+iRXdFShji4NOBpL+hopF6
         qyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691069351; x=1691674151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ntEvLFlRpNT+qR6jlJekxZXF9ONqBaZB8tTPc8hJxHo=;
        b=fUGLirT6aFRDKb4VsJj7E0QQZHmnbqCSS7c8eviFRr1qVdJt5su46Lx1Og/FpB9AoI
         Q4Cn5fsuG0L72LVDlndb/YKifl3alWPyRDOpeumqFudeXobWjQ4zj6V4r6e0Hu0F69OK
         zeR6VY2jCAGD23Jvaw6db8LBB5bKglwfP3IrlSftFdlyVNTo7M8owqAMrp8GUtoY5Kmi
         WGaRgVjHGwgM82kWdOkfjZMbvqKRkngu7V+SSToOLDvohqO/ZnjWy3GBwI0r6mVnojxZ
         h+UYZKfC0pfjz7N7J5Bu8tukTZJmxbj5WZdEoBMGCDxnq1Ch71mH9xWrd9p7Fv2pSbuo
         KUCw==
X-Gm-Message-State: ABy/qLZGUQVCpER2V8P5fztc3tOtd2+CJ2gKFw2gHZo+weMjmnE+8iwB
        +pC+1VkJX4YoGxLSmftLXzWMZ9Km0MZrERS1A8k=
X-Google-Smtp-Source: APBJJlHIzo4MqHS+k/JCdqgT16BcRk/5v7ytqHftiDKKZXbIZ4AikfQny7La+e94VmPdHMof8J0Wrg==
X-Received: by 2002:a05:6a21:32a1:b0:130:a400:1d65 with SMTP id yt33-20020a056a2132a100b00130a4001d65mr24223360pzb.14.1691069351683;
        Thu, 03 Aug 2023 06:29:11 -0700 (PDT)
Received: from n26-073-040.byted.org ([106.38.226.44])
        by smtp.gmail.com with ESMTPSA id q23-20020a637517000000b0055b4307963dsm6901376pgc.23.2023.08.03.06.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 06:28:46 -0700 (PDT)
From:   Xu Lu <luxu.kernel@bytedance.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH RESEND] riscv: Fix local irq restore when flags indicates irq disabled
Date:   Thu,  3 Aug 2023 21:28:18 +0800
Message-Id: <20230803132818.2092166-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When arch_local_irq_restore() is called with flags indicating irqs
disabled, we need to clear SR_IE bit in CSR_STATUS, whereas current
implementation based on csr_set() function only sets SR_IE bit of
CSR_STATUS when SR_IE bit of flags is high and does nothing when
SR_IE bit of flags is low.

This commit supplies csr clear operation when calling irq restore
function with flags indicating irq disabled.

Fixes: 6d60b6ee0c97 ("RISC-V: Device, timer, IRQs, and the SBI")
Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/irqflags.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/asm/irqflags.h
index 08d4d6a5b7e9..7c31fc3c3559 100644
--- a/arch/riscv/include/asm/irqflags.h
+++ b/arch/riscv/include/asm/irqflags.h
@@ -49,7 +49,10 @@ static inline int arch_irqs_disabled(void)
 /* set interrupt enabled status */
 static inline void arch_local_irq_restore(unsigned long flags)
 {
-	csr_set(CSR_STATUS, flags & SR_IE);
+	if (flags & SR_IE)
+		csr_set(CSR_STATUS, SR_IE);
+	else
+		csr_clear(CSR_STATUS, SR_IE);
 }
 
 #endif /* _ASM_RISCV_IRQFLAGS_H */
-- 
2.20.1

