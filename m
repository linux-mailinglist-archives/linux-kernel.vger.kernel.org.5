Return-Path: <linux-kernel+bounces-9500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1612781C697
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8CD1F263A2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3645A1CFAE;
	Fri, 22 Dec 2023 08:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RiywPMpZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B590D1A5A3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703233657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aLqkaq/CNNYt4l8d0bCD03noyF1tDxxEcTb0gpcUAAQ=;
	b=RiywPMpZQARBrLVYkN3o8tCgIYE6U7xjOnY8McOr0cy17svyPRfzvy4+76OumWfOaXtLmS
	ajtPyWHMtnsapIuqWKn6LetMZBKSEGY31be9cCpx31q4tYqxaza2Hz57Nh8Hq+v+l/kiRg
	1QRa92VLYSW9t7l8gvhpE7DA6vuza6E=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-whQPAGq3N42jUlvY3BYlvA-1; Fri, 22 Dec 2023 03:27:35 -0500
X-MC-Unique: whQPAGq3N42jUlvY3BYlvA-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3bb87fc010fso743337b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 00:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703233655; x=1703838455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aLqkaq/CNNYt4l8d0bCD03noyF1tDxxEcTb0gpcUAAQ=;
        b=WpFMW2qr72O279wHxrr2v2OciFCjM0B0sD27WzNr6H1CjufYiA4+6icYvaCb35mxeZ
         qzNbusBX3QU5LXGM67hc8PWO9oSGBzv0nJVeepEiO4fFpbYsel0uGJmfcdnMDLW0yP5Z
         aRrQnatobKxOaUBXApu8PyyZJYBWqv41mqrgvo81BmaBdhKvcVr0oCVadR83JTiK6IEC
         82hsueIOp65bYlYVTkYO5ToX47rNttHGGzj0uENJPGzqRWouJ+5Y/hcI99xDAFOSjPMU
         LxHOwzbdwfxxQmu40f78CmOLipVVgJB2w++HAz/GRTAzlnwCr0MLm9dXu4nFBJPRkRgE
         Ai8w==
X-Gm-Message-State: AOJu0Yw9nRnXlz53TStanK7A7wlbLXR0sYtsaxqXBcohg6ohv904iW2n
	Lz24ZuGufRrlxykdH/0hZ0fzrjz0FMusOXuLZXzNStD9VaYrB1Yjd5DPJ7kIv8WDSdxyAkmbYQz
	zpXB5+JV+geeX1hUEpp7OVH0x3H5dv+cU
X-Received: by 2002:a05:6808:d4f:b0:3b8:9025:57d7 with SMTP id w15-20020a0568080d4f00b003b8902557d7mr974247oik.3.1703233654973;
        Fri, 22 Dec 2023 00:27:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGXA84hVEKQncls1irexm/1G3Mh7Drn2jkvk32WK/o/u+YrtMDJC7riH+R2H6QuE0XXKePmg==
X-Received: by 2002:a05:6808:d4f:b0:3b8:9025:57d7 with SMTP id w15-20020a0568080d4f00b003b8902557d7mr974235oik.3.1703233654771;
        Fri, 22 Dec 2023 00:27:34 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a802:7496:88a7:1b1a:a837:bebf])
        by smtp.gmail.com with ESMTPSA id i10-20020a056a00004a00b006ce273562fasm2871150pfk.40.2023.12.22.00.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 00:27:34 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Vincent Chen <vincent.chen@sifive.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Leonardo Bras <leobras@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Guo Ren <guoren@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/1] riscv: Improve arch_get_mmap_end() macro
Date: Fri, 22 Dec 2023 05:27:10 -0300
Message-ID: <20231222082711.454374-1-leobras@redhat.com>
X-Mailer: git-send-email 2.43.0
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


