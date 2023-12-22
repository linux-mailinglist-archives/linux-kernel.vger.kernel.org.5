Return-Path: <linux-kernel+bounces-9462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8929D81C5EA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B35DB253E2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C9014A82;
	Fri, 22 Dec 2023 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMnEk8kU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C13812E6C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 07:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703231211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CivPyX79A0Z1hBiu+NIjR9u/sMwnUQBrdiWOV2RqYZw=;
	b=AMnEk8kUg/IEB2ajMx/nMXqXatiwWDNW6eL5FAG95fFqCzO+Kj5xjReD+EsIIFQLUBGFJn
	Bzl1VysEDs7JJ0evp1EW1XhhJJ3uij+oDKXgkVMLXviB+W2b96HqYPO/+Ne1J59gzNnWSd
	2buRqakCQ2Rvwa/DBfwPlUu0GJqW0UM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-PiVJaWRtPwOz4x9bUx9z3Q-1; Fri, 22 Dec 2023 02:46:49 -0500
X-MC-Unique: PiVJaWRtPwOz4x9bUx9z3Q-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6d398f0de98so934589b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 23:46:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703231208; x=1703836008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CivPyX79A0Z1hBiu+NIjR9u/sMwnUQBrdiWOV2RqYZw=;
        b=IR9/Fko9pedkzvA9GtKNHcMUrwX0mzpfBBp8EujkcjhlA7oaTKowxbvI+6UHvTmHQE
         avz5n9PlEK3BmiJaUboeU29orP+OU1rg8Ej8A8SKWYTg4qubRT5uOo0q6dRoGyjGSX7K
         YU8bRCvw75FncYmeer4K3Dy2xtx6Km3AxOIPLPp7833WIkk3MxCvuGZHhmH1/KnZlVYp
         Uibl+VGoA3hO9jbLdHPNKqn5os9k9HnOcgF5GtFvvJJP/2mEagwcF/MeHsDtnwNEvSnM
         2X4HLELKgOBkJKaHfd8fkd3ksgzT65A6fuSFR1sPSVRQSxrS5OYnRFCkirveiMcbmLvB
         vbog==
X-Gm-Message-State: AOJu0YzmNFKKr2mmEpY+Dwe+Uxtq6bf8f+JOHSXnPu1Ypy+OGPMjTmYT
	FQkKE8tylZMeEXqjikvRFXsEJ+9uLeidcS9wtdSL5mVdKdP3+zxUgA2N7fjaW7ov0e7DWNV4+FX
	UFA2kCK6+vFA1JLewc5FEfrLLjOF5YmxN
X-Received: by 2002:aa7:930c:0:b0:6d9:6261:919e with SMTP id cz12-20020aa7930c000000b006d96261919emr591296pfb.19.1703231208652;
        Thu, 21 Dec 2023 23:46:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3ju0vDAUEHX0GCDDvkiFL8Wq0IKN/wM1vpTmL1pxShU1txvq7JIxARGiDwyFtjeAX5+gIOw==
X-Received: by 2002:aa7:930c:0:b0:6d9:6261:919e with SMTP id cz12-20020aa7930c000000b006d96261919emr591291pfb.19.1703231208347;
        Thu, 21 Dec 2023 23:46:48 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a802:7496:88a7:1b1a:a837:bebf])
        by smtp.gmail.com with ESMTPSA id m2-20020a62f202000000b006d97eaba6cesm1527015pfh.21.2023.12.21.23.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 23:46:47 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Leonardo Bras <leobras@redhat.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Greg Ungerer <gerg@kernel.org>,
	Vincent Chen <vincent.chen@sifive.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Qinglin Pan <panqinglin2020@iscas.ac.cn>,
	Greentime Hu <greentime.hu@sifive.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Guo Ren <guoren@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/4] riscv: Introduce is_compat_thread() into compat.h
Date: Fri, 22 Dec 2023 04:46:03 -0300
Message-ID: <20231222074605.452452-4-leobras@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222074605.452452-1-leobras@redhat.com>
References: <20231222074605.452452-1-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

task_user_regset_view() makes use of a function very similar to
is_compat_task(), but pointing to a any thread.

In arm64 asm/compat.h there is a function very similar to that:
is_compat_thread(struct thread_info *thread)

Copy this function to riscv asm/compat.h and make use of it into
task_user_regset_view().

Also, introduce a compile-time test for CONFIG_COMPAT and simplify the
function code by removing the #ifdef.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 arch/riscv/include/asm/compat.h | 8 ++++++++
 arch/riscv/kernel/ptrace.c      | 6 +++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/compat.h b/arch/riscv/include/asm/compat.h
index 91517b51b8e27..da4b28cd01a95 100644
--- a/arch/riscv/include/asm/compat.h
+++ b/arch/riscv/include/asm/compat.h
@@ -20,6 +20,14 @@ static inline int is_compat_task(void)
 	return test_thread_flag(TIF_32BIT);
 }
 
+static inline int is_compat_thread(struct thread_info *thread)
+{
+	if (!IS_ENABLED(CONFIG_COMPAT))
+		return 0;
+
+	return test_ti_thread_flag(thread, TIF_32BIT);
+}
+
 struct compat_user_regs_struct {
 	compat_ulong_t pc;
 	compat_ulong_t ra;
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 2afe460de16a6..f362832123616 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -374,14 +374,14 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 	return ret;
 }
+#else
+static const struct user_regset_view compat_riscv_user_native_view = {};
 #endif /* CONFIG_COMPAT */
 
 const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 {
-#ifdef CONFIG_COMPAT
-	if (test_tsk_thread_flag(task, TIF_32BIT))
+	if (is_compat_thread(&task->thread_info))
 		return &compat_riscv_user_native_view;
 	else
-#endif
 		return &riscv_user_native_view;
 }
-- 
2.43.0


