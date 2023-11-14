Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD707EB536
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 18:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjKNRA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 12:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjKNRAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 12:00:54 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206B911D;
        Tue, 14 Nov 2023 09:00:51 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c79d8b67f3so64643591fa.0;
        Tue, 14 Nov 2023 09:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699981249; x=1700586049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aQal8qUMEmhK7Dkdqvrsuy8gJSftsXg0qDExwqH+0QI=;
        b=dzLiiK1kOBV1tbNT+t7ndRYhKTf/rz5Y5rabfXCLPrMpO5XNGEeuOj8NYFnxlPMA9x
         uyuHE3u2vTZz3M37CYtzRSBJMOljQzx2OLN5a+uvLkGabbo540Av7b+ReaGqO97yHICa
         QFBq/At/u9j5prQe8Cm0z+UNljLE+ysDWdYf3d5OYSgmryh2XnWxkLlZRVvIrCAczEPJ
         JNeu64XZfjMKEM4bR6aTzsXOPIkX87W8HofEVjz1du/3lz9swS0z/+oBvlrARQS1HpLb
         Fp9m5TOm9RHxyJCEwD06CNrp4bikqPbHdhsKHrpO9tZt8eDo08gOMGBzhaBp1BhLsyVN
         SEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699981249; x=1700586049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQal8qUMEmhK7Dkdqvrsuy8gJSftsXg0qDExwqH+0QI=;
        b=hS4Rc9YJEKLm8fcqneem7dXVNlhAcMMzxezDsW1i76++Dp5xQvfaDBiQgOo3OslS43
         EE3TPZDMuztV0Qy/dJ5oZPUREZRcHf/c+6nb6k9ssiUtpi0roLBMaM8/i/kh47ao5GmA
         hl5n4aKgbg1bzL3OD8njn3PD8rP7Z2LOd3yPdpftZNgdJf1qMs8aQUvgfVDrG2/xsvHg
         3toA2IB9CDisgrX5Kwirr4lLEGJA8nhI6qS8J1mqa+C+j3aP6uyjN1EwUzj23BK6mkpo
         J1gg4awUUiSoMqmo1tihA6/IhrXnEzqVzaRW8wKakw9UmyuNWGgTrgpQBW7MUOykiwvl
         YmNw==
X-Gm-Message-State: AOJu0Yz4+9MKvl64UZgXbO2LFqdpN0dYBcTBc9/T9mkimpPLamB0QNnn
        N1iNwzNwIEWvNa2SqZFx5xyJWqaVbR9rEFuB
X-Google-Smtp-Source: AGHT+IE43F05uSclNDiqjUQ8LYaXrlPhIM2NjgZ7lD7gFNTvFeAy5QF9GarxjRKA5/arhUEpos+Eqw==
X-Received: by 2002:a05:651c:2204:b0:2c5:52d:c9ff with SMTP id y4-20020a05651c220400b002c5052dc9ffmr2432095ljq.10.1699981248844;
        Tue, 14 Nov 2023 09:00:48 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0040a5e69482esm2465315wms.11.2023.11.14.09.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 09:00:48 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-hyperv@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/hyperv: Use atomic_try_cmpxchg() to micro-optimize hv_nmi_unknown()
Date:   Tue, 14 Nov 2023 17:59:28 +0100
Message-ID: <20231114170038.381634-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Use atomic_try_cmpxchg() instead of atomic_cmpxchg(*ptr, old, new) == old
in hv_nmi_unknown(). On x86 the CMPXCHG instruction returns success in
the ZF flag, so this change saves a compare after CMPXCHG. The generated
asm code improves from:

  3e:	65 8b 15 00 00 00 00 	mov    %gs:0x0(%rip),%edx
  45:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  4a:	f0 0f b1 15 00 00 00 	lock cmpxchg %edx,0x0(%rip)
  51:	00
  52:	83 f8 ff             	cmp    $0xffffffff,%eax
  55:	0f 95 c0             	setne  %al

to:

  3e:	65 8b 15 00 00 00 00 	mov    %gs:0x0(%rip),%edx
  45:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  4a:	f0 0f b1 15 00 00 00 	lock cmpxchg %edx,0x0(%rip)
  51:	00
  52:	0f 95 c0             	setne  %al

No functional change intended.

Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e6bba12c759c..01fa06dd06b6 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -262,11 +262,14 @@ static uint32_t  __init ms_hyperv_platform(void)
 static int hv_nmi_unknown(unsigned int val, struct pt_regs *regs)
 {
 	static atomic_t nmi_cpu = ATOMIC_INIT(-1);
+	unsigned int old_cpu, this_cpu;
 
 	if (!unknown_nmi_panic)
 		return NMI_DONE;
 
-	if (atomic_cmpxchg(&nmi_cpu, -1, raw_smp_processor_id()) != -1)
+	old_cpu = -1;
+	this_cpu = raw_smp_processor_id();
+	if (!atomic_try_cmpxchg(&nmi_cpu, &old_cpu, this_cpu))
 		return NMI_HANDLED;
 
 	return NMI_DONE;
-- 
2.41.0

