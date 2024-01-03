Return-Path: <linux-kernel+bounces-15722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E1E8230E6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86EF71C238F7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823B81B288;
	Wed,  3 Jan 2024 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fTvmohkT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDF11B27B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704297650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kntl/nAgkMTrS0b6uVdfD+vMpj63I1IJoYMsR9G9+XQ=;
	b=fTvmohkT27M9sZw0hhTut1xP5PGfQE+wpIaIBeTzUiyqH3yGd2LgwviBMsRX6VtqxEmxOc
	3h6fgGvs6alUyUd7WzBwNIT0VpQDc74knxTlCIyYBiYQT+Q1tfdY0zDuWN1ebNNmcty1nc
	FTXTNgIAQPNdcRzP1YXFPpDuVohPme4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-bcQ_eT6XNmSPz8nYL4ORrQ-1; Wed, 03 Jan 2024 11:00:48 -0500
X-MC-Unique: bcQ_eT6XNmSPz8nYL4ORrQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-28cb44ab1cbso2250209a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 08:00:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704297647; x=1704902447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kntl/nAgkMTrS0b6uVdfD+vMpj63I1IJoYMsR9G9+XQ=;
        b=d8IzJmYuJ26CeXaIDM8VkCXudVSJ/Y8VjvFpzqAR73WTlGWc2C3loywixorxOA3E/u
         EqiEUJW2NHFBP+p/Nsu7uZvQ5vW5BI4WcWRUGcs3kI1ih7KLjah+c+g86UGL+yQy/5sz
         8VvXVbkJ8IawfNsFG6z4w9zFatIR70gIdBXbjVfLXMqIWqSoJiXTy3cv41PlDqqgo5Lf
         P1M2DpZMKEgPtvyLC5ab1qw8EnROtiTRaZ4VgHI1wTeLwyYDDdYdAhToWWXYFjO5wKTI
         1oKSUyNz6WgVaERJiDMNhPJV8CVKdljGYh7b0F2jq5bvaoctpJ92oKAIvCRhx5JE6mKv
         x0aA==
X-Gm-Message-State: AOJu0YwJ+6uTi1I1fcZswkLxdbo47woQmkIxuAmv3PtJwxSEIvE0qo1N
	wYysTAZxTJnW8bR83GL/JQNaWePX9t5bLE671GhFdaT/411agFW4vRPwnVXTg8unRM2wWJ0/GfP
	Tc8ao0KeXYzZT1wMmeSyiWp9LPD1B+aZq
X-Received: by 2002:a17:90a:8904:b0:28a:cbce:71ab with SMTP id u4-20020a17090a890400b0028acbce71abmr6468977pjn.13.1704297647430;
        Wed, 03 Jan 2024 08:00:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEt/3y+tufgltM/XFXS9WiJx4E8Mcef48BephLcAK7LUU4REFf4sxMOI/5885O5oAW116hzaw==
X-Received: by 2002:a17:90a:8904:b0:28a:cbce:71ab with SMTP id u4-20020a17090a890400b0028acbce71abmr6468965pjn.13.1704297647085;
        Wed, 03 Jan 2024 08:00:47 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7ec:911:6911:ca60:846:eb46])
        by smtp.gmail.com with ESMTPSA id qc8-20020a17090b288800b0028b1fce7c01sm1922253pjb.37.2024.01.03.08.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 08:00:46 -0800 (PST)
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
Subject: [PATCH v1 0/5] riscv: Introduce compat-mode helpers & improve arch_get_mmap_end()
Date: Wed,  3 Jan 2024 13:00:18 -0300
Message-ID: <20240103160024.70305-2-leobras@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I just saw the opportunity of optimizing the helper is_compat_task() by
introducing a compile-time test, and it made possible to remove some
#ifdef's without any loss of performance.

I also saw the possibility of removing the direct check of task flags from
general code, and concentrated it in asm/compat.h by creating a few more
helpers, which in the end helped optimize code.

arch_get_mmap_end() just got a simple improvement and some extra docs.

Changes since RFC:
- Fused with other patchset:  Improve arch_get_mmap_end() macro
- Renamed from "Introduce & Optimize compat-mode helpers"

Leonardo Bras (5):
  riscv: Improve arch_get_mmap_end() macro
  riscv: Replace direct thread flag check with is_compat_task()
  riscv: add compile-time test into is_compat_task()
  riscv: Introduce is_compat_thread() into compat.h
  riscv: Introduce set_compat_task() in asm/compat.h

 arch/riscv/include/asm/compat.h    | 19 +++++++++++++++++++
 arch/riscv/include/asm/elf.h       | 11 ++---------
 arch/riscv/include/asm/pgtable.h   |  8 +-------
 arch/riscv/include/asm/processor.h | 16 +++++++++++-----
 arch/riscv/kernel/ptrace.c         |  6 +++---
 5 files changed, 36 insertions(+), 24 deletions(-)


base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a
-- 
2.43.0


