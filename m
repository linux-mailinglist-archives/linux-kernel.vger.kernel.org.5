Return-Path: <linux-kernel+bounces-9463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8C181C5EB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9225285248
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BC217735;
	Fri, 22 Dec 2023 07:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjqhbIJk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2163D168BE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 07:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703231219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJKdTz0fBLuk4zNW5VLOm1jY/M0/StXJiYDFTohFsJw=;
	b=DjqhbIJkAZIEPaWhWuFyQGNUdeYwTj0hTQnUIVtDgcPkeXJ7bfsoTz8icwKLhT6ie39ZuG
	wvx1GILBYCAOYG23jDPEj450wV1cmzb+Nl1p7Nwz9rG/XHL+ZqIUyYrGr7PEbNaaagr9sP
	r8+rAeNnjZ3zom/0YACulcoYrF04SNs=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-XAa0y1LIPzytKDxcP7-IuA-1; Fri, 22 Dec 2023 02:46:55 -0500
X-MC-Unique: XAa0y1LIPzytKDxcP7-IuA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6d7e5d286a1so1180982b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 23:46:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703231214; x=1703836014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJKdTz0fBLuk4zNW5VLOm1jY/M0/StXJiYDFTohFsJw=;
        b=i1Bl+5T455m0DeJuHcgKsa7lMxa6Vqd53sLJFu9bp1RuA6JaeW5ptp28tfy+Y/7kfi
         qeH85Qu8cRmqlPeJRjLieyOUK05um8OtmzT+T5dE9u/Ab4zWT3PE9sRoC/d3FeUI9Ufb
         aHbDlVf8wGkajcrx8ATRm47fEHNahDh1GXpeMkWvdjkgdDjJOHmWOzFWmOW6eWvzCfHK
         Sfbjr3BW2LnLUFN4nuSfLczlXGF9JWRZMhKs/xIKY9io5qwqNb4gltIGgrEpKF3yJ+BW
         iaG8rNcq0pe0L185/25cOGoXCF05luZ7KJtUwAIycT1FnLCgOofoHUMjErXDgwGO3A+e
         y1dw==
X-Gm-Message-State: AOJu0YxD2XX4AjnK9cOtPlAEMlDweM5KewcL1k9mc9j3Y7rDleGIpB3z
	qq04yLOmNLr4EKWx8JWh0CnGi3qvnEr4boqVOwdf6BdncB1QFv0qoKIM585Tts5ko6p+32W4aHu
	Lno9sw9ikzjG9f0DM+FG5EwIHOwQv5Z9P
X-Received: by 2002:aa7:9104:0:b0:6d9:3659:5419 with SMTP id 4-20020aa79104000000b006d936595419mr998852pfh.21.1703231214628;
        Thu, 21 Dec 2023 23:46:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMFmEyFRjwKSQRTyr1Tjdg/8FK7+G5rpG28wVcUI80rZUZeycJ9jxcUGtZ0nSOM5ugBFakSg==
X-Received: by 2002:aa7:9104:0:b0:6d9:3659:5419 with SMTP id 4-20020aa79104000000b006d936595419mr998837pfh.21.1703231214349;
        Thu, 21 Dec 2023 23:46:54 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a802:7496:88a7:1b1a:a837:bebf])
        by smtp.gmail.com with ESMTPSA id m2-20020a62f202000000b006d97eaba6cesm1527015pfh.21.2023.12.21.23.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 23:46:53 -0800 (PST)
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
Subject: [RFC PATCH 4/4] riscv: Introduce set_compat_task() in asm/compat.h
Date: Fri, 22 Dec 2023 04:46:04 -0300
Message-ID: <20231222074605.452452-5-leobras@redhat.com>
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

In order to have all task compat bit access directly in compat.h, introduce
set_compat_task() to set/reset those when needed.

Also, since it's only used on an if/else scenario, simplify the macro using
it.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
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


