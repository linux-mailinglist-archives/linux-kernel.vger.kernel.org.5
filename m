Return-Path: <linux-kernel+bounces-25540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A3782D20C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 21:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F268B20B2D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 20:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245C4134A2;
	Sun, 14 Jan 2024 20:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="q8Grhc12"
Received: from out203-205-251-72.mail.qq.com (out203-205-251-72.mail.qq.com [203.205.251.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B149112E5E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 20:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705262736; bh=MlO0W/6NOpgeBxiotyDe0grBFJ9Aiowv2TivzweCiL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=q8Grhc12ORLpBOmij99fTFLJJf/B5iL/kZ8OvxA25j9mun4ibCMSAI5zyDdAo2RXc
	 qxKBSgQZIAqsAsr49m84iAHCkDIfwe0pT1qtfFX5jc0doNTiJt7XHZyAHyGewnBCkn
	 csHPyBIJE+0wuNzKeqia6LVbQihQ0Lt8khLyvSGM=
Received: from cyy-pc.lan ([2001:da8:c800:d084:c65a:644a:13d7:e72c])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id ED316C15; Mon, 15 Jan 2024 03:59:19 +0800
X-QQ-mid: xmsmtpt1705262364tyk1oh493
Message-ID: <tencent_817CE182D5DA478E3FB85831A621778D0008@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3JupryUVYZhO01u8+NuEVFJOee/hDlQxpeUqxee53LFkxvr04h64v
	 quTsRC8m22OZ9dui7TryswLnwKqppyWMbZc3KtTnP+OLI9LY08U6SvYVZc205KspM+QtZYZGfHaa
	 lwtpbfXf5R84mmBP32A3he3WD/f8BesaWLBdSTP8ZGUj3AfEgV2LXavuJDV0sEq+6SUCucOyEBzL
	 hX1wvdhmJOMS6fgVjSIYiResaqA9BnhJblC4/CKfbfLAImS7WMdebSfegI17SIBI0qD2+XpNUBuz
	 44ONhn9kvqJclrQuWVDO+sNBUJibpYlZZbeJZ4nNu0p4jxizX8DyytnWi456I4KKl9+9663NE6tJ
	 n4BFwYwwz+n4rJmQiMskQ73laYeBAWhoGfM8lsuxzxpMX9ici9JO26uWirUKEbHTQeas0tIi/hrG
	 VgGZdzTsahDz3MA7+eF0kFbUACXEd/BsnRF5oNixHT4mDEac5/ZiCi2c5Et7P+98poUQwEfXXNs8
	 nQbg7fwhhpiuCcn1uDo8zlkfJ2Au9o8oYskPyPxDR+hpWhfB4n8A15MqXEDGcGRY/UdTAmMae8sG
	 6Y2jI5wAhSn9w0wloj4rU9S6pMhRNvvgl59wMVqTS/WkCmYOU0Zlw/jafiEvzX0pXk3fkGPNyn7d
	 lOt0YJIcBP12SZ8+hyKqWkzoxxAgR2ESn6M1LIyE7B3g3IjQxl5h2qtEJmHyMyv8WONC42Jl8RAL
	 YWovqVjmy9FB+0OIzBcN5bSTblQp34gQff4zgO4Z29iQchulRv4e/2s4bDDA9wAhpifd16P5Gafm
	 yG/X9jY7gu4vE0f8nvMbxi1s7p/YzmvjxCr3X8OMzXy+Jy6qywVztZ3O7xgk3qDIdLWEu8um3Abi
	 wONw9NTOw94ZAArDJ4584I1hXhhwpw/p+2cRA0Ftl/Z0rpDHf6CzIXgwaR64RLEJEi2yJ3goP25D
	 koCgMQM2Cg9RB07m8wweOFN2UMVzVOc4yLDWhM+k5+gH0Hz62J+UiET9cIqIwoS+PKyro5bBdGff
	 NGUBFdrQ==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Charlie Jenkins <charlie@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	Andy Chiu <andy.chiu@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH 2/3] RISC-V: mm: only test mmap without hint
Date: Mon, 15 Jan 2024 03:58:31 +0800
X-OQ-MSGID: <20240114195832.275982-2-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_F3B3B5AB1C9D704763CA423E1A41F8BE0509@qq.com>
References: <tencent_F3B3B5AB1C9D704763CA423E1A41F8BE0509@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original test from a patch violates the principle of mmap which uses
mmap hint address as the largest address space to use rather than where to
create the mapping. The address space in this context is either sv39, sv48,
sv57.

After fixing the correct behavior, only keeping the test mmap without a
hint is enough.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 .../selftests/riscv/mm/mmap_bottomup.c        | 12 --------
 .../testing/selftests/riscv/mm/mmap_default.c | 12 --------
 tools/testing/selftests/riscv/mm/mmap_test.h  | 30 -------------------
 3 files changed, 54 deletions(-)

diff --git a/tools/testing/selftests/riscv/mm/mmap_bottomup.c b/tools/testing/selftests/riscv/mm/mmap_bottomup.c
index 1757d19ca89b..1ba703d3f552 100644
--- a/tools/testing/selftests/riscv/mm/mmap_bottomup.c
+++ b/tools/testing/selftests/riscv/mm/mmap_bottomup.c
@@ -15,20 +15,8 @@ TEST(infinite_rlimit)
 	do_mmaps(&mmap_addresses);
 
 	EXPECT_NE(MAP_FAILED, mmap_addresses.no_hint);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_37_addr);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_38_addr);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_46_addr);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_47_addr);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_55_addr);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_56_addr);
 
 	EXPECT_GT(1UL << 47, (unsigned long)mmap_addresses.no_hint);
-	EXPECT_GT(1UL << 38, (unsigned long)mmap_addresses.on_37_addr);
-	EXPECT_GT(1UL << 38, (unsigned long)mmap_addresses.on_38_addr);
-	EXPECT_GT(1UL << 38, (unsigned long)mmap_addresses.on_46_addr);
-	EXPECT_GT(1UL << 47, (unsigned long)mmap_addresses.on_47_addr);
-	EXPECT_GT(1UL << 47, (unsigned long)mmap_addresses.on_55_addr);
-	EXPECT_GT(1UL << 56, (unsigned long)mmap_addresses.on_56_addr);
 #endif
 }
 
diff --git a/tools/testing/selftests/riscv/mm/mmap_default.c b/tools/testing/selftests/riscv/mm/mmap_default.c
index c63c60b9397e..f1ac860dcf04 100644
--- a/tools/testing/selftests/riscv/mm/mmap_default.c
+++ b/tools/testing/selftests/riscv/mm/mmap_default.c
@@ -15,20 +15,8 @@ TEST(default_rlimit)
 	do_mmaps(&mmap_addresses);
 
 	EXPECT_NE(MAP_FAILED, mmap_addresses.no_hint);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_37_addr);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_38_addr);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_46_addr);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_47_addr);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_55_addr);
-	EXPECT_NE(MAP_FAILED, mmap_addresses.on_56_addr);
 
 	EXPECT_GT(1UL << 47, (unsigned long)mmap_addresses.no_hint);
-	EXPECT_GT(1UL << 38, (unsigned long)mmap_addresses.on_37_addr);
-	EXPECT_GT(1UL << 38, (unsigned long)mmap_addresses.on_38_addr);
-	EXPECT_GT(1UL << 38, (unsigned long)mmap_addresses.on_46_addr);
-	EXPECT_GT(1UL << 47, (unsigned long)mmap_addresses.on_47_addr);
-	EXPECT_GT(1UL << 47, (unsigned long)mmap_addresses.on_55_addr);
-	EXPECT_GT(1UL << 56, (unsigned long)mmap_addresses.on_56_addr);
 #endif
 }
 
diff --git a/tools/testing/selftests/riscv/mm/mmap_test.h b/tools/testing/selftests/riscv/mm/mmap_test.h
index 2e0db9c5be6c..d2271426288f 100644
--- a/tools/testing/selftests/riscv/mm/mmap_test.h
+++ b/tools/testing/selftests/riscv/mm/mmap_test.h
@@ -10,47 +10,17 @@
 
 struct addresses {
 	int *no_hint;
-	int *on_37_addr;
-	int *on_38_addr;
-	int *on_46_addr;
-	int *on_47_addr;
-	int *on_55_addr;
-	int *on_56_addr;
 };
 
 // Only works on 64 bit
 #if __riscv_xlen == 64
 static inline void do_mmaps(struct addresses *mmap_addresses)
 {
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
-
 	int prot = PROT_READ | PROT_WRITE;
 	int flags = MAP_PRIVATE | MAP_ANONYMOUS;
 
 	mmap_addresses->no_hint =
 		mmap(NULL, 5 * sizeof(int), prot, flags, 0, 0);
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
 }
 #endif /* __riscv_xlen == 64 */
 
-- 
2.43.0


