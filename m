Return-Path: <linux-kernel+bounces-15724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F098230EA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C7C1C2399B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F19B1BDFD;
	Wed,  3 Jan 2024 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wtcz3uzK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B5A1BDE3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704297661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eW7Hp92xFvn0uEDHFJ5uhGV0bhy55HqDGviT7ReovF8=;
	b=Wtcz3uzKC/er7NCw58ksu7KphGGzvZED37jbkredXQ6qvVQWXnyKeOUmz3091NXvbjkU8h
	w9MapZvl2Tpls6SwqaFuuNtx6xrSA5ZpzlIc0LqoF/y0uzlAIAdUxflNpSPDkzhNE5lPy4
	3Mq+g9ptqnlbJfE1OvoKeJSnxhk4zFc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-WSNqCLb3O76-U4SFVt0yXQ-1; Wed, 03 Jan 2024 11:00:57 -0500
X-MC-Unique: WSNqCLb3O76-U4SFVt0yXQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-28bcf7f605aso485125a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 08:00:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704297656; x=1704902456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eW7Hp92xFvn0uEDHFJ5uhGV0bhy55HqDGviT7ReovF8=;
        b=Z3Fj9dEFsCmrz7e0hX3ssf9VlfYilJwGydpl1uH7MAMtGV4c8YlZrgpvTfBERMlGzs
         j7KEqNi05kNME7ISvWaQ0O+Ha9SZSl8P4LiwnvfI48NNAvf0TevOWRZ+EHL1ROzMroVC
         Bj5G6qrVAlNQWkpkCDhAcQ5JGdEHdYVDu5uPyAUQ3xH9aRjcgGuzdycpSPrqtZBB88zg
         YysE1dXFdxJUDl+JpD56ehPi47lqabMG4/doyRxU7eYf9U2hsqGpaGqqnrRs4D98fCJB
         FZO9LHw1S2SUb4ZltsE6cCRRHxr3+MYqYhWmr9WEba+iQyz+iYTHMItQhcr7s8GKtz2/
         tsHQ==
X-Gm-Message-State: AOJu0YwECQsJhgbzFPf9KJKj2aMfwAlCuALP6lPx8A4Oj7D5+v4vb8GX
	nKiZpHY81KGcxpq1vwYscUXdWXmp0toRljnak8NAY1jvGjdrXkrwiGiPq/N/lqCsfxBtb63CN4n
	YWiJXeIg3hEnrTxdqRXeNc7YbhQ9ru7nh
X-Received: by 2002:a17:90a:c245:b0:28c:eeef:aaca with SMTP id d5-20020a17090ac24500b0028ceeefaacamr705453pjx.4.1704297656088;
        Wed, 03 Jan 2024 08:00:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1Qw9aIClua9ds5Nw8/POsd9KwpDhXoK1ctp78/8BijwUvH1rwsQL+Vt2C/sTQWWAMNvcTuQ==
X-Received: by 2002:a17:90a:c245:b0:28c:eeef:aaca with SMTP id d5-20020a17090ac24500b0028ceeefaacamr705420pjx.4.1704297655711;
        Wed, 03 Jan 2024 08:00:55 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7ec:911:6911:ca60:846:eb46])
        by smtp.gmail.com with ESMTPSA id qc8-20020a17090b288800b0028b1fce7c01sm1922253pjb.37.2024.01.03.08.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 08:00:55 -0800 (PST)
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
Subject: [PATCH v1 1/5] riscv: Improve arch_get_mmap_end() macro
Date: Wed,  3 Jan 2024 13:00:19 -0300
Message-ID: <20240103160024.70305-3-leobras@redhat.com>
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

This macro caused me some confusion, which took some reviewer's time to
make it clear, so I propose adding a short comment in code to avoid
confusion in the future.

Also, added some improvements to the macro, such as removing the
assumption of VA_USER_SV57 being the largest address space.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/processor.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index f19f861cda549..2278e2a8362af 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -18,15 +18,21 @@
 #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
 #define STACK_TOP_MAX		TASK_SIZE_64
 
+/*
+ * addr is a hint to the maximum userspace address that mmap should provide, so
+ * this macro needs to return the largest address space available so that
+ * mmap_end < addr, being mmap_end the top of that address space.
+ * See Documentation/arch/riscv/vm-layout.rst for more details.
+ */
 #define arch_get_mmap_end(addr, len, flags)			\
 ({								\
 	unsigned long mmap_end;					\
 	typeof(addr) _addr = (addr);				\
 	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
 		mmap_end = STACK_TOP_MAX;			\
-	else if ((_addr) >= VA_USER_SV57)			\
-		mmap_end = STACK_TOP_MAX;			\
-	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
+	else if (((_addr) >= VA_USER_SV57) && (VA_BITS >= VA_BITS_SV57)) \
+		mmap_end = VA_USER_SV57;			\
+	else if (((_addr) >= VA_USER_SV48) && (VA_BITS >= VA_BITS_SV48)) \
 		mmap_end = VA_USER_SV48;			\
 	else							\
 		mmap_end = VA_USER_SV39;			\
-- 
2.43.0


