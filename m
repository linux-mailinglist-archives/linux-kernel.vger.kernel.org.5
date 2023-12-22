Return-Path: <linux-kernel+bounces-9459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E83281C5E7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C18284ABF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B231C2F0;
	Fri, 22 Dec 2023 07:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FquMzAHJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F33EC15D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 07:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703231192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8joa0SqsNw6lghVtjrUIlISHZyZgU8xVLriDEJzMbbU=;
	b=FquMzAHJ+zcTVfeUbtR9TY0Z38R7TWI89Y4Gb55kI9+8inWgXJqVgUiaq7Sg/dY21/ZCxR
	d7vUGz/t9k9MxfiocJk7AP5yZES9N7tXvejYMGG0+2Z5k0JAk4wwQ9Wzj+6W7YeIzMZDXy
	5A7dEllcNE57H2oSsG7o6yo/aEmrPQQ=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-2OpfMAr-OsmGJ4JhEwhfzA-1; Fri, 22 Dec 2023 02:46:31 -0500
X-MC-Unique: 2OpfMAr-OsmGJ4JhEwhfzA-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6dbb0a1c894so1769866a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 23:46:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703231190; x=1703835990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8joa0SqsNw6lghVtjrUIlISHZyZgU8xVLriDEJzMbbU=;
        b=ud0znSaTqON0CkA5qcyu17B+tnue1GYkhdsDCLT5pmy9XRwqxvHf0rhbh8a9wrOxRT
         CVVNDb12qbIHC6NuzsEUntJrgWS9O8YUwTLOKjj8CSUIqdx0C5ak3XByPDExl2u0BURS
         29/+soXZTpdKMlK3qTqBQdIzKqFXl7l5e6ieKNpCDzzf4Coc2rXhreO4s/plgc890fv2
         qxwwLwxJDbQcFRAlzXrny3PzP0WONoMwCdVsEZ9Bh5OYvrclA4PfNMx/TVSsbRptpv5X
         /MEjf072/VM/WoBiZS8DOZMTMjj4VvxfR/kVzXlleM2pAdjo67NecKpe1q4vsnWpt2sI
         ZFyg==
X-Gm-Message-State: AOJu0YzWFFw0ZbR2oXNI8S9kkoHfnIQUa5Irxgzkrg1YO6UT9tiNNlAP
	fhwHh8aTdeM6MKf4+hUNsGZMw4wF3JKiA4mct/WucioEXFsTIrkPWYHJQkyAvHDQ9eEO20Y5hyP
	15SdZMZ821wv5iqt/o/1P81PfidYShlt5
X-Received: by 2002:a05:6830:188:b0:6d8:7b83:b520 with SMTP id q8-20020a056830018800b006d87b83b520mr975571ota.22.1703231190621;
        Thu, 21 Dec 2023 23:46:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtPKXrNxbzqoFd8PBPnac2PBZhiVN9/33Wde7wZTDupuDnjdqviH8QQZhwIVNY+bNVq43CLg==
X-Received: by 2002:a05:6830:188:b0:6d8:7b83:b520 with SMTP id q8-20020a056830018800b006d87b83b520mr975547ota.22.1703231190419;
        Thu, 21 Dec 2023 23:46:30 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a802:7496:88a7:1b1a:a837:bebf])
        by smtp.gmail.com with ESMTPSA id m2-20020a62f202000000b006d97eaba6cesm1527015pfh.21.2023.12.21.23.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 23:46:29 -0800 (PST)
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
Subject: [RFC PATCH 0/4] Introduce & Optimize compat-mode helpers
Date: Fri, 22 Dec 2023 04:46:00 -0300
Message-ID: <20231222074605.452452-1-leobras@redhat.com>
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

Leonardo Bras (4):
  riscv: Replace direct thread flag check with is_compat_task()
  riscv: add compile-time test into is_compat_task()
  riscv: Introduce is_compat_thread() into compat.h
  riscv: Introduce set_compat_task() in asm/compat.h

 arch/riscv/include/asm/compat.h    | 19 +++++++++++++++++++
 arch/riscv/include/asm/elf.h       | 11 ++---------
 arch/riscv/include/asm/pgtable.h   |  8 +-------
 arch/riscv/include/asm/processor.h |  4 ++--
 arch/riscv/kernel/ptrace.c         |  6 +++---
 5 files changed, 27 insertions(+), 21 deletions(-)


base-commit: 24e0d2e527a39f64caeb2e6be39ad5396fb2da5e
-- 
2.43.0


