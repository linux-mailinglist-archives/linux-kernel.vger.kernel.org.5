Return-Path: <linux-kernel+bounces-15725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844008230EB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 259C0B23982
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9E91C2A8;
	Wed,  3 Jan 2024 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fx4uJPV6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DC11C28F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704297667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9dWOLJ/7H2GD4Bb9fMRINczeyfjJ7YRASwlhClz2V/8=;
	b=fx4uJPV68TmmMfotRmjkLGn+XevVdYX4GqNVsuLOmaLWAi6CrJF/OdeMugZ2ps0kogT6my
	l5ZnuPO+B9tyvzFHK608z6YTLAep+A3FjVl88wT88azm+kdCvJkfIWPjXQ0da+7yJZcy01
	kwNIaCdZcF1F36IK5NyhLuZXyOsFNtk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-MSnx8RpiMJSCM5tuaQfN7Q-1; Wed, 03 Jan 2024 11:01:05 -0500
X-MC-Unique: MSnx8RpiMJSCM5tuaQfN7Q-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28bbe965866so6292571a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 08:01:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704297664; x=1704902464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dWOLJ/7H2GD4Bb9fMRINczeyfjJ7YRASwlhClz2V/8=;
        b=fHVlTGhaZaDCuuiEubKo3VzI6dYSvrgXjdkxJAGTTJDgz9AnlYUDMRR0GIDUMqHC86
         ///A9XDt9vBnC3k/ALn6rFiFXopefr8gpQ/8h3CxSvfhU3Q03SxpCrDLiD/IGxVFAySK
         8IyFniTQO28MaGcb4UTtjj5DGSXRnFYKiwZPhNDGkLqc5lVu0C/KTiFtvrxKkp//QuEi
         y0WxlGrQG1OO2wqV+R8xGsxa9+WIQ+X13hmuo9wA6tWlFtDZG5dmvNbB1wJAcB+/yGna
         gDYR7GwbUZhBc6aDb3nxGDf2EH0zuG/F1xZhUZWk9K6koJjYaajCX/SjGlw1NYPmVJLt
         ctBQ==
X-Gm-Message-State: AOJu0YymyErTU68TySHLPIuZrAovU3R+p9b7jadRzxQbc0FG6syllSTj
	VoiPueoKa8bwRDnXM9FXi3sroZ2B6/vTzmbBGsDD1ECJLhS+TMcko+KiRE6MFynK7i7mdL3PJ41
	S2xcY4c2ID3JWulmbD232YB2YtXj01+J8
X-Received: by 2002:a17:90a:cc18:b0:28b:157c:e48d with SMTP id b24-20020a17090acc1800b0028b157ce48dmr6484899pju.78.1704297664231;
        Wed, 03 Jan 2024 08:01:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuVYYxexaKDE814y1fhNTdPHZYP8ZdcRM5q6bVvyRs+hK/lDTBPjjZPxt/iJQ3BUyAPZfgHQ==
X-Received: by 2002:a17:90a:cc18:b0:28b:157c:e48d with SMTP id b24-20020a17090acc1800b0028b157ce48dmr6484861pju.78.1704297663874;
        Wed, 03 Jan 2024 08:01:03 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7ec:911:6911:ca60:846:eb46])
        by smtp.gmail.com with ESMTPSA id qc8-20020a17090b288800b0028b1fce7c01sm1922253pjb.37.2024.01.03.08.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 08:01:03 -0800 (PST)
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
Subject: [PATCH v1 2/5] riscv: Replace direct thread flag check with is_compat_task()
Date: Wed,  3 Jan 2024 13:00:20 -0300
Message-ID: <20240103160024.70305-4-leobras@redhat.com>
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

There is some code that detects compat mode into a task by checking the
flag directly, and other code that check using the helper is_compat_task().

Since the helper already exists, use it instead of checking the flags
directly.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 arch/riscv/include/asm/elf.h     | 2 +-
 arch/riscv/include/asm/pgtable.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index 06c236bfab53b..59a08367fddd7 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -54,7 +54,7 @@ extern bool compat_elf_check_arch(Elf32_Ehdr *hdr);
 
 #ifdef CONFIG_64BIT
 #ifdef CONFIG_COMPAT
-#define STACK_RND_MASK		(test_thread_flag(TIF_32BIT) ? \
+#define STACK_RND_MASK		(is_compat_task() ? \
 				 0x7ff >> (PAGE_SHIFT - 12) : \
 				 0x3ffff >> (PAGE_SHIFT - 12))
 #else
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index ab00235b018f8..1d472b31e0cfe 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -882,7 +882,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 
 #ifdef CONFIG_COMPAT
 #define TASK_SIZE_32	(_AC(0x80000000, UL) - PAGE_SIZE)
-#define TASK_SIZE	(test_thread_flag(TIF_32BIT) ? \
+#define TASK_SIZE	(is_compat_task() ? \
 			 TASK_SIZE_32 : TASK_SIZE_64)
 #else
 #define TASK_SIZE	TASK_SIZE_64
-- 
2.43.0


