Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0361E75F846
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjGXN1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjGXN1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:27:44 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC000137
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:27:42 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666eba6f3d6so2437070b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690205262; x=1690810062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qe1WWOmOhwyGNUK/umivfemB/L6/ebTKyDycVpoI8eA=;
        b=YvdR+gZs+SBsvKp4JTeP+13nxYLoph3fZCusDTczzhYiUglTAz7SFT+bHHRkd5+Td3
         ouzaPB0MR9DMa5loZdmBYZv9OibL6SwWIJa0MzhT+AxqYV7VyMVsAaicBYX9nnxeVJFJ
         iud19b4IDh2b8VZJeThqo5Oj3+jUTtApVYjaQjskOp0mr53NjyuPXIz/NMClJk5U4eNv
         Q64iD2vHftwJ6+T0aFhNRrYBex2e8ehfQbtt1ZqINvfOGV/d5UGH5Lh7eRCvl8Mz2PWN
         lBiuR9RfxcITiPuBFD94tkk3NJjKej5jHaZpACo6ZuD6thAGgjgRDhyqky7mv/f5u3vt
         CTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690205262; x=1690810062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qe1WWOmOhwyGNUK/umivfemB/L6/ebTKyDycVpoI8eA=;
        b=O9vcWe6Gt0pj8sjLG/1jDQNOebfHblSeArSlwren/GdokIcARqA+zHL7c+H2NIZ8gb
         pTx7OxPqVcWxVnWiEeg2Zv3Rdv9QJ/D9cOYkDJ983Ye4MCEfoH79wnn1KUmiH/wfPDc5
         c/sA4y5E2xuyvTy0g+YmvcKMh2+LXbh9wAcRZfHk2FECnM+GBy4pR6f78V9Vje1+leGZ
         u/+zMZiov0Jr8c4mQT+vXkylwV++Lj+Ow3wt66weiR8JGidhhwJa0Ler27HBQDgtZ1rn
         dEfNw4DrNyZeZe8fPOzV48IH4HhVVsGNZKfH6zI0yV6/HRwe9a4DUMV542KHGRXT5j1t
         zGRQ==
X-Gm-Message-State: ABy/qLbbA22asSMDdJ1T5CkJn/Ri4qJcQ4lDTpy42YfzgQQvEFjqXY1g
        t8/eTbY2imoN35L8kEd9UOs=
X-Google-Smtp-Source: APBJJlHgTYF3JtTeWGHx5BDlx5lH37dxbu8R1gftf3UNN0LgQ/rlyAJO2eA4MU2Gx7mXCMB+EtCQIA==
X-Received: by 2002:a05:6a20:1d0:b0:134:8b50:47cd with SMTP id 16-20020a056a2001d000b001348b5047cdmr8801634pzz.9.1690205262234;
        Mon, 24 Jul 2023 06:27:42 -0700 (PDT)
Received: from n26-073-040.byted.org ([106.38.226.194])
        by smtp.gmail.com with ESMTPSA id w13-20020a170902d70d00b001b9f032bb3dsm8945763ply.3.2023.07.24.06.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 06:27:41 -0700 (PDT)
From:   "luxu.kernel" <luxujoy@gmail.com>
X-Google-Original-From: "luxu.kernel" <luxu.kernel@bytedance.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        luxu.kernel@bytedance.com
Subject: [PATCH] riscv: Fix local irq restore when flags indicates irq disabled
Date:   Mon, 24 Jul 2023 21:27:36 +0800
Message-Id: <20230724132736.124106-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: luxu.kernel <luxu.kernel@bytedance.com>
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

