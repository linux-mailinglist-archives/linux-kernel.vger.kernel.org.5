Return-Path: <linux-kernel+bounces-43681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 709D484179E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD6D1F23EC3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EB2364B5;
	Tue, 30 Jan 2024 00:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jRgejf4F"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DDA339AD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706575028; cv=none; b=LwelKgW8ZSWDXEdkogZB4v0v6Xcpt3JMLgZrd2gZClztAuEocGEejHwabMvDH8KL+/RqEXPaEeaygSDvQLJ3VAoFmKgxKhPFl6+pYF9we0Pe89Izu9Ryaepd2SNw75aEU4LUi3/0lwzoKOCvm2qXMNZI6tSh3xtH1U3VEJA7mLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706575028; c=relaxed/simple;
	bh=FRDzzVwyS7nuVapUvX+XBqyYOrJdFna/LWspy9EPMlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XFE/AqHDG55sYLBFfJXOhzta7+lqfMC3sZpCgW4m2+sWc2fNI+Btl0vlED0g8zbJP1ROtW9uBhJ2qmm+xU2Qt0xGNiOC0OtL6KAvI/AAsbbxKuRT3h+efu1kq7swqjbTNdbv2PWdIUH4xDroDVvnT43uIho0Dbk3QQdAcjBZpoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=jRgejf4F; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d8da50bfd9so8208975ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706575025; x=1707179825; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4k3XgG6Vs4V2eymg6847wUAtUHshLOeTHqeR5jZPT4=;
        b=jRgejf4Fm67TaLaPbz1k8X0JKl2WtK5NOycN43w2ds6hkoFebsE9+SmS0Y06OuiLA2
         L1z8aEFHW7cQIbiOb1hYF9cF3Qf9OXwGzxEHJyaC9FPuD9eEJnsAes8/Q++yf8fZ4NGk
         2fxO0DNkK9NDD4yI8EJ+IOZzWaPXhtaPxgcdJBBZloCv/6Wcgfxn3ZHHSLL6xuZfryOJ
         lgvAGrxZ9SQdqMmJ7OITQUqDu3cswcNWwnl8jjXP4i5PnPMQhHKDmeBHiJIvK9YLVnbc
         ggnBCpmnmv0zq8lD7PmXnVboKVzo0bDiMFik4PzkA4Kg64pTVoDdYXR9ikxnk5GhEXyA
         FljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706575025; x=1707179825;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4k3XgG6Vs4V2eymg6847wUAtUHshLOeTHqeR5jZPT4=;
        b=PyLOUE37lA89C8e/2NF2zqj3fp6XC5aXUg+ndVeEHsvoxLad6xaOyailGmhbvrTu73
         cCnHJtDJTlPCVU3+GlIa6uuVWSBE55kLFlvGmyZ3nd0N6M2658ndERXtTS2R4ZF/vAU1
         rc5LZr044ALo/EOfWiRccRE+yoRPII4A2zYUkfUSTqQ58R+bsvxkeENkU8ErBprujy05
         +Vw0k4iVNWH0BPnIiV3Ys9OMCRJQ5G1DuD5kjTYgsO3SuFCPJRxB9vvAot7hjBNm0AZi
         8tGIorsn5jNzmb3iyypjhv02DVbgAyxbpb4v1b2zOD3S7zTQ2G8iTqV9rQBXReaEZPDy
         xVtg==
X-Gm-Message-State: AOJu0Yx+8CqV+Gsm1SFnTJN33zD4vv1I6udbh6Jzx+4H5dPdvqHmY9Gt
	1KxAQUGre9ZcebZZ/aqya57ZZG1JCdUWwkfJZEiyIQ68+zEYdJUjC8C0POflvko=
X-Google-Smtp-Source: AGHT+IEl+PVzBuK1MtOtugM8nPKpD3tRnNLknu/QZvQdEbvyOpEhCmeWCoWCedcxT6a8gteFbHIcYw==
X-Received: by 2002:a17:903:2452:b0:1d7:46a2:9383 with SMTP id l18-20020a170903245200b001d746a29383mr3732999pls.33.1706575025637;
        Mon, 29 Jan 2024 16:37:05 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id jb9-20020a170903258900b001d8ca3f5e3fsm3406375plb.295.2024.01.29.16.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 16:37:05 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 29 Jan 2024 16:37:01 -0800
Subject: [PATCH 2/3] selftests: riscv: Generalize mm selftests
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-use_mmap_hint_address-v1-2-4c74da813ba1@rivosinc.com>
References: <20240129-use_mmap_hint_address-v1-0-4c74da813ba1@rivosinc.com>
In-Reply-To: <20240129-use_mmap_hint_address-v1-0-4c74da813ba1@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706575021; l=8041;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=FRDzzVwyS7nuVapUvX+XBqyYOrJdFna/LWspy9EPMlc=;
 b=ReSkIvhXYwZAs7IYMAoCHsb+L26/KnPQEvQRVbbnRYXttmBETtcCnqZJ2gblNRVT9pMk3jCKU
 9pzOJxz037HBJDtu9MXwyiGLLQV3mIuzGyrpBsN5bEFrDDuIV57AWDE
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The behavior of mmap on riscv is defined to not provide an address that
uses more bits than the hint address, if provided. Make the tests
reflect that.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/testing/selftests/riscv/mm/mmap_bottomup.c | 20 +----
 tools/testing/selftests/riscv/mm/mmap_default.c  | 20 +----
 tools/testing/selftests/riscv/mm/mmap_test.h     | 93 +++++++++++++-----------
 3 files changed, 53 insertions(+), 80 deletions(-)

diff --git a/tools/testing/selftests/riscv/mm/mmap_bottomup.c b/tools/testing/selftests/riscv/mm/mmap_bottomup.c
index 1757d19ca89b..bad8e854263d 100644
--- a/tools/testing/selftests/riscv/mm/mmap_bottomup.c
+++ b/tools/testing/selftests/riscv/mm/mmap_bottomup.c
@@ -8,27 +8,9 @@ TEST(infinite_rlimit)
 {
 // Only works on 64 bit
 #if __riscv_xlen == 64
-	struct addresses mmap_addresses;
-
 	EXPECT_EQ(BOTTOM_UP, memory_layout());
 
-	do_mmaps(&mmap_addresses);
-
-	EXPECT_NE(MAP_FAILED, mmap_addresses.no_hint);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_37_addr);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_38_addr);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_46_addr);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_47_addr);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_55_addr);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_56_addr);
-
-	EXPECT_GT(1UL << 47, (unsigned long)mmap_addresses.no_hint);
-	EXPECT_GT(1UL << 38, (unsigned long)mmap_addresses.on_37_addr);
-	EXPECT_GT(1UL << 38, (unsigned long)mmap_addresses.on_38_addr);
-	EXPECT_GT(1UL << 38, (unsigned long)mmap_addresses.on_46_addr);
-	EXPECT_GT(1UL << 47, (unsigned long)mmap_addresses.on_47_addr);
-	EXPECT_GT(1UL << 47, (unsigned long)mmap_addresses.on_55_addr);
-	EXPECT_GT(1UL << 56, (unsigned long)mmap_addresses.on_56_addr);
+	TEST_MMAPS;
 #endif
 }
 
diff --git a/tools/testing/selftests/riscv/mm/mmap_default.c b/tools/testing/selftests/riscv/mm/mmap_default.c
index c63c60b9397e..a3874778d795 100644
--- a/tools/testing/selftests/riscv/mm/mmap_default.c
+++ b/tools/testing/selftests/riscv/mm/mmap_default.c
@@ -8,27 +8,9 @@ TEST(default_rlimit)
 {
 // Only works on 64 bit
 #if __riscv_xlen == 64
-	struct addresses mmap_addresses;
-
 	EXPECT_EQ(TOP_DOWN, memory_layout());
 
-	do_mmaps(&mmap_addresses);
-
-	EXPECT_NE(MAP_FAILED, mmap_addresses.no_hint);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_37_addr);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_38_addr);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_46_addr);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_47_addr);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_55_addr);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_56_addr);
-
-	EXPECT_GT(1UL << 47, (unsigned long)mmap_addresses.no_hint);
-	EXPECT_GT(1UL << 38, (unsigned long)mmap_addresses.on_37_addr);
-	EXPECT_GT(1UL << 38, (unsigned long)mmap_addresses.on_38_addr);
-	EXPECT_GT(1UL << 38, (unsigned long)mmap_addresses.on_46_addr);
-	EXPECT_GT(1UL << 47, (unsigned long)mmap_addresses.on_47_addr);
-	EXPECT_GT(1UL << 47, (unsigned long)mmap_addresses.on_55_addr);
-	EXPECT_GT(1UL << 56, (unsigned long)mmap_addresses.on_56_addr);
+	TEST_MMAPS;
 #endif
 }
 
diff --git a/tools/testing/selftests/riscv/mm/mmap_test.h b/tools/testing/selftests/riscv/mm/mmap_test.h
index 9b8434f62f57..93face2b3118 100644
--- a/tools/testing/selftests/riscv/mm/mmap_test.h
+++ b/tools/testing/selftests/riscv/mm/mmap_test.h
@@ -4,60 +4,69 @@
 #include <sys/mman.h>
 #include <sys/resource.h>
 #include <stddef.h>
+#include <strings.h>
+#include "../../kselftest_harness.h"
 
 #define TOP_DOWN 0
 #define BOTTOM_UP 1
 
-struct addresses {
-	int *no_hint;
-	int *on_37_addr;
-	int *on_38_addr;
-	int *on_46_addr;
-	int *on_47_addr;
-	int *on_55_addr;
-	int *on_56_addr;
+uint64_t random_addresses[] = {
+	0x19764f0d73b3a9f0, 0x016049584cecef59, 0x3580bdd3562f4acd,
+	0x1164219f20b17da0, 0x07d97fcb40ff2373, 0x76ec528921272ee7,
+	0x4dd48c38a3de3f70, 0x2e11415055f6997d, 0x14b43334ac476c02,
+	0x375a60795aff19f6, 0x47f3051725b8ee1a, 0x4e697cf240494a9f,
+	0x456b59b5c2f9e9d1, 0x101724379d63cb96, 0x7fe9ad31619528c1,
+	0x2f417247c495c2ea, 0x329a5a5b82943a5e, 0x06d7a9d6adcd3827,
+	0x327b0b9ee37f62d5, 0x17c7b1851dfd9b76, 0x006ebb6456ec2cd9,
+	0x00836cd14146a134, 0x00e5c4dcde7126db, 0x004c29feadf75753,
+	0x00d8b20149ed930c, 0x00d71574c269387a, 0x0006ebe4a82acb7a,
+	0x0016135df51f471b, 0x00758bdb55455160, 0x00d0bdd949b13b32,
+	0x00ecea01e7c5f54b, 0x00e37b071b9948b1, 0x0011fdd00ff57ab3,
+	0x00e407294b52f5ea, 0x00567748c200ed20, 0x000d073084651046,
+	0x00ac896f4365463c, 0x00eb0d49a0b26216, 0x0066a2564a982a31,
+	0x002e0d20237784ae, 0x0000554ff8a77a76, 0x00006ce07a54c012,
+	0x000009570516d799, 0x00000954ca15b84d, 0x0000684f0d453379,
+	0x00002ae5816302b5, 0x0000042403fb54bf, 0x00004bad7392bf30,
+	0x00003e73bfa4b5e3, 0x00005442c29978e0, 0x00002803f11286b6,
+	0x000073875d745fc6, 0x00007cede9cb8240, 0x000027df84cc6a4f,
+	0x00006d7e0e74242a, 0x00004afd0b836e02, 0x000047d0e837cd82,
+	0x00003b42405efeda, 0x00001531bafa4c95, 0x00007172cae34ac4,
+	0x0000002732f06b2b, 0x00000012cbf8fd0b, 0x0000001fcc6af0e8,
 };
 
-static inline void do_mmaps(struct addresses *mmap_addresses)
-{
-	/*
-	 * Place all of the hint addresses on the boundaries of mmap
-	 * sv39, sv48, sv57
-	 * User addresses end at 1<<38, 1<<47, 1<<56 respectively
-	 */
-	void *on_37_bits = (void *)(1UL << 37);
-	void *on_38_bits = (void *)(1UL << 38);
-	void *on_46_bits = (void *)(1UL << 46);
-	void *on_47_bits = (void *)(1UL << 47);
-	void *on_55_bits = (void *)(1UL << 55);
-	void *on_56_bits = (void *)(1UL << 56);
 
-	int prot = PROT_READ | PROT_WRITE;
-	int flags = MAP_PRIVATE | MAP_ANONYMOUS;
+#define PROT (PROT_READ | PROT_WRITE)
+#define FLAGS (MAP_PRIVATE | MAP_ANONYMOUS)
+
+/* mmap must return a value that doesn't use more bits than the hint address. */
+static inline unsigned long get_max_value(unsigned long input)
+{
+	unsigned long max_bit = (1UL << (ffsl(input) - 1));
 
-	mmap_addresses->no_hint =
-		mmap(NULL, 5 * sizeof(int), prot, flags, 0, 0);
-	mmap_addresses->on_37_addr =
-		mmap(on_37_bits, 5 * sizeof(int), prot, flags, 0, 0);
-	mmap_addresses->on_38_addr =
-		mmap(on_38_bits, 5 * sizeof(int), prot, flags, 0, 0);
-	mmap_addresses->on_46_addr =
-		mmap(on_46_bits, 5 * sizeof(int), prot, flags, 0, 0);
-	mmap_addresses->on_47_addr =
-		mmap(on_47_bits, 5 * sizeof(int), prot, flags, 0, 0);
-	mmap_addresses->on_55_addr =
-		mmap(on_55_bits, 5 * sizeof(int), prot, flags, 0, 0);
-	mmap_addresses->on_56_addr =
-		mmap(on_56_bits, 5 * sizeof(int), prot, flags, 0, 0);
+	return max_bit + (max_bit - 1);
 }
 
+#define TEST_MMAPS                                                            \
+	({                                                                    \
+		void *mmap_addr;                                              \
+		for (int i = 0; i < ARRAY_SIZE(random_addresses); i++) {      \
+			mmap_addr = mmap((void *)random_addresses[i],         \
+					 5 * sizeof(int), PROT, FLAGS, 0, 0); \
+			EXPECT_NE(MAP_FAILED, mmap_addr);                     \
+			EXPECT_GE((void *)get_max_value(random_addresses[i]), \
+				  mmap_addr);                                 \
+			mmap_addr = mmap((void *)random_addresses[i],         \
+					 5 * sizeof(int), PROT, FLAGS, 0, 0); \
+			EXPECT_NE(MAP_FAILED, mmap_addr);                     \
+			EXPECT_GE((void *)get_max_value(random_addresses[i]), \
+				  mmap_addr);                                 \
+		}                                                             \
+	})
+
 static inline int memory_layout(void)
 {
-	int prot = PROT_READ | PROT_WRITE;
-	int flags = MAP_PRIVATE | MAP_ANONYMOUS;
-
-	void *value1 = mmap(NULL, sizeof(int), prot, flags, 0, 0);
-	void *value2 = mmap(NULL, sizeof(int), prot, flags, 0, 0);
+	void *value1 = mmap(NULL, sizeof(int), PROT, FLAGS, 0, 0);
+	void *value2 = mmap(NULL, sizeof(int), PROT, FLAGS, 0, 0);
 
 	return value2 > value1;
 }

-- 
2.43.0


