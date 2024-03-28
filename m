Return-Path: <linux-kernel+bounces-122540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ACB88F928
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0352C298CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABF354BE7;
	Thu, 28 Mar 2024 07:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcVj1oRu"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA545380D;
	Thu, 28 Mar 2024 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612299; cv=none; b=s+hz7s8WCUJghEhZakYWmOeAQQy2tUIsxSLYho/bTH3nvLJxNywO5SLeNzvzGY+Simqq3+PMCzJBoT+UPWS5y8QWOAANtzCQjMsWnKmW49F+WReK+mtwSGyY6ybyGveVY3ajgvqxPvd/rQ6N1HpW6Vj0UQ2AbHh5yBdRvmd9/V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612299; c=relaxed/simple;
	bh=1u4ClC0nXJYWtLmcNlGJ9Evf3oh4cLDO6utJlz4b/+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jHamKHR6XA5k8dvzRKhJDuaj/5nSsSPSE+xYIwYZOviaqkCKyaHuQ9LYJlPJGQRceYwyIZ6O+SfeEnKTbYkLJ8Ia2wM0otNAMlcF6VpADZEvWBxKY+rltR1UOwaFC/DRmxODCw1QIdrtf4IUrvYVG7A/vmUEHB0FJL36w8gS2LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcVj1oRu; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2282597eff5so478301fac.3;
        Thu, 28 Mar 2024 00:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711612296; x=1712217096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kb+0BwtXCOHTxNecM62LX9dxsLjU1SobPdBfLYOqsoE=;
        b=fcVj1oRuCRVoGBClW2Kr66cb/PPnfdvEjmoYlR+lqG1c45efv+5Bs4iQOsZyxuZfcd
         WWtpvEg3KsSKpBWDOw9Gr9zDsb67TfcwhorDJ3e42tVTdchSwwVhzqWiORAUjNSr7umk
         EpKa4KZe70WUUuFNPzzyUih5BKM4QzGEfGVOwCZOru9BoeaBxZaWlSs0tNHl0AEcNtMw
         2Qxu6fgQ8Ph3WIHLY0S2Algtq+GVCye8QoKmFvY5xN/Xupu+VOfFvbEkJtJ0tW+4aA50
         hnWE/dDqTg+mwgNEkKloHMGiyHTC4uxVW+JH7QnfYQ3Djv57FQlscAf67ksw1lNUwIQQ
         7epQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711612296; x=1712217096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kb+0BwtXCOHTxNecM62LX9dxsLjU1SobPdBfLYOqsoE=;
        b=W5inbw0NmiJCeCMRX+XX76CLiJnTSiKvJG1jJwIADhteLIY5TnjzX9ySAE5YgkO924
         v+TBDg+7eyG0hiGFWazDHdGpwh4PS06voceE7NwJ9BLjGPN5hjmSz/WWHK0QrF4j4XhJ
         jmc8O8ZwynKy4FESLNvBrO9RgBG9URy/b9R8xpdfwQZbfvH30PVTsZzJC5gX+Q3Yl5HX
         AdwonZiy8DbG5nYIgSG9B5kLYLVhF9uyTDxVyGMEcsgcZrlpjMD75CNGtRaw5ucSQJGL
         aYFB/f+RYuUX/nGV1UA7AQykdIuLBaiwXiSODHBp9iWHl7fJhs3WV4IsIc3k6GCbmFQi
         DjCA==
X-Gm-Message-State: AOJu0Yyz4XEasFhK2FbBydwSHHf9fcmWahYb7Ak05H/uBHHOAqadiqTL
	nXLqpXNGtqLTi32fhoA/ISOQVEsyoUqzzTfA0lgjG7kxjDo+JPQcJcqpE/rg
X-Google-Smtp-Source: AGHT+IEzqMx8djm+FHmNWfNhehJ+tHqeZFhrJJCl/Hxw+o3WO/76dLEGu+gqfnycvOWAL9IbEKWnGg==
X-Received: by 2002:a05:6871:4406:b0:229:e636:921f with SMTP id nd6-20020a056871440600b00229e636921fmr2181447oab.49.1711612296343;
        Thu, 28 Mar 2024 00:51:36 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id e18-20020aa79812000000b006ea81423c65sm774667pfl.148.2024.03.28.00.51.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2024 00:51:35 -0700 (PDT)
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
Subject: [PATCH 10/10] x86/rcu: Add THUNK rcu_read_unlock_special_thunk
Date: Thu, 28 Mar 2024 15:53:18 +0800
Message-Id: <20240328075318.83039-11-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240328075318.83039-1-jiangshanlai@gmail.com>
References: <20240328075318.83039-1-jiangshanlai@gmail.com>
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
 arch/x86/entry/thunk_64.S          | 5 +++++
 arch/x86/include/asm/rcu_preempt.h | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index 119ebdc3d362..10c60369a67c 100644
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
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


