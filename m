Return-Path: <linux-kernel+bounces-15728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 605B08230F1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B8C1C23A31
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2801C6B8;
	Wed,  3 Jan 2024 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xm6WA0Ko"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E455C1C6B4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704297685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UcuCCcEH82BE3ayeUzaJsR8GgVjZd2XA38iISRs+5EQ=;
	b=Xm6WA0Ko6YQOp97J34C6aARSlB7soYdluVgrTU3RPePtuToMRioEOR3CJvabfIsxvtKJz7
	t+MUuAyn2CUa0OHaQ+cken9FIo/UrRUFdOuP//dKjw7R80ENRI0/S1rZKubU+gIFImIJdn
	ao8Y0pKjPOidNSsbs+VpSXT8jqUXPqU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-RH-94J-CNbCvt2yZ144wXw-1; Wed, 03 Jan 2024 11:01:23 -0500
X-MC-Unique: RH-94J-CNbCvt2yZ144wXw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-28bbe965866so6293005a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 08:01:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704297682; x=1704902482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcuCCcEH82BE3ayeUzaJsR8GgVjZd2XA38iISRs+5EQ=;
        b=AYuSM9+zTA5gDE/fvK7aBbN+euew22n7nNrfZvrL2/I1ocCgIyFyC07thKKTT24Wle
         WdVmG4t6jfVPWxZAtDO0mkyIEPqQq/HZi8Ya8XJvZ0whpYounVa1uge3LukSeW7oO0YW
         BC0tOLx03GA5DeQQ8964tydwN500AEa2Af/epIN0fj9gGUTKvlcXWA/NUSClSFBtWoFw
         mEwfDAFno1WmNfL1tSokraYE9T5XnPnXEy7uRx1qGsxRQE9j5W8+1dRx5METTpx9f6/g
         KRo/nrXOHdFmB0J4FR+PdLK+XmZmZZfuTfHvwra2s0woAlTS5/Yrwv+v6nk8nwSIJJKv
         YTUw==
X-Gm-Message-State: AOJu0YxSQS0VL/OU1V1stDod83qNOp4garjLf8L7GbTcsFgyxcsYtCQI
	1dPfcYinneze6U6xq7FYLXIUMrzZ0qsiRYcHgcucdRujAPumNneKgHD7oCcDRHb6ZR/e1vPraI1
	dWFcnSv4wdWFpiIigkCUNqFt56iodjmNH
X-Received: by 2002:a17:90a:ac0f:b0:28b:2e19:70ad with SMTP id o15-20020a17090aac0f00b0028b2e1970admr6096707pjq.25.1704297682417;
        Wed, 03 Jan 2024 08:01:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWGQZgfdECo7Rqv5SvlFkPiOgIc2kjMq7oXKIwuu4xXAPoN6bd8DlcIBQPspVWHa4cRptl2w==
X-Received: by 2002:a17:90a:ac0f:b0:28b:2e19:70ad with SMTP id o15-20020a17090aac0f00b0028b2e1970admr6096675pjq.25.1704297681382;
        Wed, 03 Jan 2024 08:01:21 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7ec:911:6911:ca60:846:eb46])
        by smtp.gmail.com with ESMTPSA id qc8-20020a17090b288800b0028b1fce7c01sm1922253pjb.37.2024.01.03.08.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 08:01:20 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	Andy Chiu <andy.chiu@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Vincent Chen <vincent.chen@sifive.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Greg Ungerer <gerg@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Qinglin Pan <panqinglin2020@iscas.ac.cn>,
	Greentime Hu <greentime.hu@sifive.com>,
	Baoquan He <bhe@redhat.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1 4/5] riscv: Introduce is_compat_thread() into compat.h
Date: Wed,  3 Jan 2024 13:00:22 -0300
Message-ID: <20240103160024.70305-6-leobras@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103160024.70305-2-leobras@redhat.com>
References: <20240103160024.70305-2-leobras@redhat.com>
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
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Andy Chiu <andy.chiu@sifive.com>
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


