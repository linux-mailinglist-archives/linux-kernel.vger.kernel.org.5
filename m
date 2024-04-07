Return-Path: <linux-kernel+bounces-134288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49EF89AFF0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A202836CB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE171DDEA;
	Sun,  7 Apr 2024 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNnBC+JN"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF661B5A4;
	Sun,  7 Apr 2024 09:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712480668; cv=none; b=TyapFc+O78+4YbvM8pN8TSo3YDuKSN5Nqqi4VfG4Z1bt8n2Dx7Al6ZUbnws4FylWrdHz8CPGsW+lJMoeN6aJegBJjIG7bYcbY3bDqllyUryPxcHeICS6dEYsw8pyOQMplSmNsg7plc+cexYnpZa490uiujFehwrxExR1XC74gTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712480668; c=relaxed/simple;
	bh=IhZYosKK4YOMcbHez/fMmD2UL1qwCvnS6/0P7o8GM80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=djd9VTuemOWPpKuTNZuj0iTV5FdcitQx8w9fPvbpV0pFMS5oyaoPucgbujh3tGsTisanBwDKb7FltslT3Cx4mWCd52YhO8QJZIv5gE2woi+N10XO8P+YZKNnW71yrcPD+wuwSCcF4lYqHPsBkBpTYnuXwaoCyHpp/T8T8xRemCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNnBC+JN; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e3f17c6491so3927195ad.2;
        Sun, 07 Apr 2024 02:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712480666; x=1713085466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkIq2OM32fM/A9YPDdmXDhI8BJtLMOXuFU9dLok8GaA=;
        b=jNnBC+JNqzBiqk0HHJBE1z2R+nvrFM5al1tSFCs94uY77p9fwN8yUKfk7JPCI68d0x
         C1LTCiEB89E/CPxehd1VIQ/nrmkYPmH5Usuav/z5OmvP18AQY3AWD7ySue4dUstF4OIP
         tuiDgLocKVsn75i+TLtXuJRM6p61fP1ZTrpnvHPsSZUEG3EQgMwc5kUN0fbCBF81nfmA
         DhIX1h445S4SwdP2hdi3kw/Hdak+Yl8RanFX7UOboBk41CgaswE+gJ8yOzsuTLEM3jeS
         FskUviZ1kTZVsy7OQ1beVw/WYU/haDGiatZ76p4GILc/7rJ1sK39SBYXurMhOxusZjhX
         NdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712480666; x=1713085466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkIq2OM32fM/A9YPDdmXDhI8BJtLMOXuFU9dLok8GaA=;
        b=m45CIo3WESkRpGbwEKRqygujIxAUXwtOwaKttrFU5UGfWjHfKanSXEHF7hOFPJLEeJ
         T67jYwp74go/pM+bLRSLIcVs05XlqZSBqequlD3P+67n7/p4mhv3zVdoNeKnJv/yDJKP
         DTWM1X6j6VE6FIVBGDFhKzLDUQfc7Gag1wzxb7Duy0xORs1eLTGx89IO/3iK0rgv3D05
         AE/8PKf7FZGD7Lq24rbVhcNeMPcMGXITrRw7XXf/VYtd6x6JSKZblmE13+wdMTBNN22d
         Yww4PMSE6eQc1e45Tq3DL+bXf/j6cWv3MWkJ4Gs5d8yKqQ26QVBTIaaYzXtOyDhol4J+
         rNsw==
X-Gm-Message-State: AOJu0YyQ+fI6ukUTphnJObU/Sqfd8PniemmmtDuY5Iw9D0hH+IlbH49B
	8jD5hYeSt9Fo9jcBH4wSgv9348hJMIzz/VW8pusvea59kngZCA0KB6ExGKGJ
X-Google-Smtp-Source: AGHT+IF9PcRqZDnUhHy3vl6624twg2/Jp4GtKYwOmGa3ZycNF1LGiu6DrMU4VbWU9vWZoHd1u0jlIw==
X-Received: by 2002:a05:6a21:a5aa:b0:1a7:647a:420e with SMTP id gd42-20020a056a21a5aa00b001a7647a420emr710671pzc.3.1712480666154;
        Sun, 07 Apr 2024 02:04:26 -0700 (PDT)
Received: from localhost ([47.89.225.180])
        by smtp.gmail.com with ESMTPSA id fa12-20020a056a002d0c00b006e694719fa0sm2412840pfb.147.2024.04.07.02.04.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2024 02:04:25 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: rcu@vger.kernel.org,
	x86@kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2 11/11] x86/rcu: Add THUNK rcu_read_unlock_special_thunk
Date: Sun,  7 Apr 2024 17:05:58 +0800
Message-Id: <20240407090558.3395-12-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240407090558.3395-1-jiangshanlai@gmail.com>
References: <20240407090558.3395-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Add rcu_read_unlock_special_thunk(), so that the inlined rcu_read_unlock()
doesn't need any code to save the caller-saved registers.

Make rcu_read_unlock() only two instructions in the slow path at the
caller site.

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/thunk.S             | 5 +++++
 arch/x86/include/asm/rcu_preempt.h | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/thunk.S b/arch/x86/entry/thunk.S
index 119ebdc3d362..10c60369a67c 100644
--- a/arch/x86/entry/thunk.S
+++ b/arch/x86/entry/thunk.S
@@ -13,3 +13,8 @@ THUNK preempt_schedule_thunk, preempt_schedule
 THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
 EXPORT_SYMBOL(preempt_schedule_thunk)
 EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
+
+#ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT
+THUNK rcu_read_unlock_special_thunk, rcu_read_unlock_special
+EXPORT_SYMBOL_GPL(rcu_read_unlock_special_thunk)
+#endif /* #ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT */
diff --git a/arch/x86/include/asm/rcu_preempt.h b/arch/x86/include/asm/rcu_preempt.h
index cb25ebe038a5..acdd73b74c05 100644
--- a/arch/x86/include/asm/rcu_preempt.h
+++ b/arch/x86/include/asm/rcu_preempt.h
@@ -97,9 +97,11 @@ static __always_inline bool pcpu_rcu_preempt_count_dec_and_test(void)
 			       __percpu_arg([var]));
 }
 
+extern asmlinkage void rcu_read_unlock_special_thunk(void);
+
 #define pcpu_rcu_read_unlock_special()						\
 do {										\
-	rcu_read_unlock_special();						\
+	asm volatile ("call rcu_read_unlock_special_thunk" : ASM_CALL_CONSTRAINT);\
 } while (0)
 
 #endif // #ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT
-- 
2.19.1.6.gb485710b


