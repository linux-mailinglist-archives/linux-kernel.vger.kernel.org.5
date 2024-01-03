Return-Path: <linux-kernel+bounces-15729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C6E8230F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890291C23A61
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B4A1BDE1;
	Wed,  3 Jan 2024 16:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DA8lGtqs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACD01BDCC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704297693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tvTrIj9bDaC7vtXATJc2+i25LfcfP+uiCW+wrXL+g5Y=;
	b=DA8lGtqsZYEhlB5B9qVRX4IVKuxRn3pacj7wem5SFbrMQshBrkoaaa33/zTkhWuBrl18Pp
	tGM6Q7XmMzCSZj4YNNpm9zYd1b+tKQh8kFyDCvCLHoKGLUhe0uhy0InLwMytFAoFNS62pK
	ma1djOkg6LyfMjj/4cTVYEey0AcEhDw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-6jOogsRsP-SjKK1rp-kEzQ-1; Wed, 03 Jan 2024 11:01:31 -0500
X-MC-Unique: 6jOogsRsP-SjKK1rp-kEzQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5ce142d9192so424000a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 08:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704297690; x=1704902490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvTrIj9bDaC7vtXATJc2+i25LfcfP+uiCW+wrXL+g5Y=;
        b=r6ddQKlW4zdNQQO1XQxGitI8vx8VLh207qWMENBaM3fRv1rGZAqw4n23FHEt81Ap5u
         Lf21wXg7Ky1j1oNfMmH2Klqer39TsCpyGrpRqVanmZ1iGrFzujresUnQxSZlukaxH4z/
         C6eMdOxjx3YE8nXd8tdermlOf7c+DwLpa+8QUB/JEA/rHw2OSYPhlOtxeWRcZDoPWEZL
         AVSOE83VqjzX2fXmJAa7RgdoOityUWLXmg63L8KjNObHwv+djH5BowRcxK2+0V0Wi5/5
         JppodcStAegDnnX76t9artAZ3JwN3eVdO8+wTFms8S7UfKA4do5biokaML6czvwKLFXA
         gLog==
X-Gm-Message-State: AOJu0YxGkYRztapDnDH87O7bdkx3pSf1jldeRemZw7z4yrq87VbW5K8D
	dlOJ3iJVjfcvhYYRFsPItM1XZUZPKNHaFlGR2hghNZsrqwxnGCt2cK/WRZ8sTXmScUTgolriXps
	/3gXk4YFY17byJW2zDXy9h1M6FBkEFtC3
X-Received: by 2002:a17:90a:6c41:b0:28c:8db3:deee with SMTP id x59-20020a17090a6c4100b0028c8db3deeemr1641809pjj.7.1704297689921;
        Wed, 03 Jan 2024 08:01:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLk0qBowIms70OWWZMDrR0eSOerzAwBSl15cF1uRBrdZRmyJm9IRzrY9G6FK4FX/myhaWIiQ==
X-Received: by 2002:a17:90a:6c41:b0:28c:8db3:deee with SMTP id x59-20020a17090a6c4100b0028c8db3deeemr1641790pjj.7.1704297689594;
        Wed, 03 Jan 2024 08:01:29 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7ec:911:6911:ca60:846:eb46])
        by smtp.gmail.com with ESMTPSA id qc8-20020a17090b288800b0028b1fce7c01sm1922253pjb.37.2024.01.03.08.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 08:01:29 -0800 (PST)
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
Subject: [PATCH v1 5/5] riscv: Introduce set_compat_task() in asm/compat.h
Date: Wed,  3 Jan 2024 13:00:23 -0300
Message-ID: <20240103160024.70305-7-leobras@redhat.com>
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

In order to have all task compat bit access directly in compat.h, introduce
set_compat_task() to set/reset those when needed.

Also, since it's only used on an if/else scenario, simplify the macro using
it.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/compat.h | 8 ++++++++
 arch/riscv/include/asm/elf.h    | 5 +----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/compat.h b/arch/riscv/include/asm/compat.h
index da4b28cd01a95..aa103530a5c83 100644
--- a/arch/riscv/include/asm/compat.h
+++ b/arch/riscv/include/asm/compat.h
@@ -28,6 +28,14 @@ static inline int is_compat_thread(struct thread_info *thread)
 	return test_ti_thread_flag(thread, TIF_32BIT);
 }
 
+static inline void set_compat_task(bool is_compat)
+{
+	if (is_compat)
+		set_thread_flag(TIF_32BIT);
+	else
+		clear_thread_flag(TIF_32BIT);
+}
+
 struct compat_user_regs_struct {
 	compat_ulong_t pc;
 	compat_ulong_t ra;
diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index 2e88257cafaea..c7aea7886d22a 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -135,10 +135,7 @@ do {							\
 #ifdef CONFIG_COMPAT
 
 #define SET_PERSONALITY(ex)					\
-do {    if ((ex).e_ident[EI_CLASS] == ELFCLASS32)		\
-		set_thread_flag(TIF_32BIT);			\
-	else							\
-		clear_thread_flag(TIF_32BIT);			\
+do {	set_compat_task((ex).e_ident[EI_CLASS] == ELFCLASS32);	\
 	if (personality(current->personality) != PER_LINUX32)	\
 		set_personality(PER_LINUX |			\
 			(current->personality & (~PER_MASK)));	\
-- 
2.43.0


