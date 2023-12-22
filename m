Return-Path: <linux-kernel+bounces-9460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC75681C5E8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D203284B9A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8C8DDAB;
	Fri, 22 Dec 2023 07:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iq2zGoSK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2A4D314
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 07:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703231199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9dWOLJ/7H2GD4Bb9fMRINczeyfjJ7YRASwlhClz2V/8=;
	b=Iq2zGoSKQSWdk4hTQMf8ktPKTSupPZE5YmvnaZlmwddmDIexjuLYAcNO1od/0VTl8MFDFD
	L5Hy0OvpBDG5oaIgntWztH27Narxw1LVwZmClEQWCdTOvZwFwakmkglAGcbIdwuGMnu3Rc
	IVtVbSF5oB0h735hpIoX5Wfk63E74XI=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-fOCNbyuzNSGv0oZDyO8J8A-1; Fri, 22 Dec 2023 02:46:37 -0500
X-MC-Unique: fOCNbyuzNSGv0oZDyO8J8A-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3bb879ac903so690234b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 23:46:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703231196; x=1703835996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dWOLJ/7H2GD4Bb9fMRINczeyfjJ7YRASwlhClz2V/8=;
        b=V0330JZ6jl3/FJzkAmWi0pEKvPC1Bw4tbfhDnHbb84FxEMZi2UlBIM4Db8I4Umb0+8
         aup+uIdPab8/upOoefMLN8p9XIsUYZ4cBLll97OLbBxmwV9pV3ShKDeDt8NsO3Lzpm9w
         y7OvBGudO7Df+39T8g1DrvydWV633OKkfk6vSEgDKi0m6O/Ln3Zsuto+hZWk/SpRiCtV
         ynmOxF7LeErM5UgUU1CpnU35mrDs7qmdOzaLucyPphwZEYWj2JRHwdmDVi5mxAcq73jU
         xBeMyc0aS5dViiheVKC+9Vycww25HjCueuxhPxtqMgfwTCFtbTWQLOeFI36Ca2p0xO1/
         DSWQ==
X-Gm-Message-State: AOJu0Yy4GuAI+EBtney0fvfs3wa3aTc8teXYTPPxTfqfZ98rO4r5WGxX
	YmwrNBMCj2bLVfmQyHiGYV3rydkjTFfAm/3J4He1LW57hFOUzvngimlOeMJrJNx01k5S5TimgZC
	0FtCD9KTxAZe94FBA1HQTKTGK/bbd5/Wg
X-Received: by 2002:a05:6808:218e:b0:3a8:7c67:7cd with SMTP id be14-20020a056808218e00b003a87c6707cdmr1261191oib.24.1703231196634;
        Thu, 21 Dec 2023 23:46:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6noE7Pu5xAXvjh6CjMsnvaqxm6CqicXC5ZlFE2NmSpCIPLtETaqNzkTmN5ZP4z5PF3/bRXQ==
X-Received: by 2002:a05:6808:218e:b0:3a8:7c67:7cd with SMTP id be14-20020a056808218e00b003a87c6707cdmr1261182oib.24.1703231196440;
        Thu, 21 Dec 2023 23:46:36 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a802:7496:88a7:1b1a:a837:bebf])
        by smtp.gmail.com with ESMTPSA id m2-20020a62f202000000b006d97eaba6cesm1527015pfh.21.2023.12.21.23.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 23:46:35 -0800 (PST)
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
Subject: [RFC PATCH 1/4] riscv: Replace direct thread flag check with is_compat_task()
Date: Fri, 22 Dec 2023 04:46:01 -0300
Message-ID: <20231222074605.452452-2-leobras@redhat.com>
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


