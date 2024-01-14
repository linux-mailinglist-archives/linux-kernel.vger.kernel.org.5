Return-Path: <linux-kernel+bounces-25535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EF582D204
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 20:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC1D281BC3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 19:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7A61642B;
	Sun, 14 Jan 2024 19:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="oI+726PP"
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034E616415
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 19:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705262368; bh=bW91QKtPixSjkvzUIDC/NRMCOn9djG8KyMIWb0DhB40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oI+726PPfg6AlAtqUl5YlV+233fvulx5t1KbNkzCY2qKXdjW5edxNlNQJTPvxuaUe
	 vWEx+qF2HUH/3UCoI6bBlaZxiYAwr2hsYoG0Shxxf0cBgMPNOB3ZJ9kuiNN/fC0CD+
	 p27AIiF0cz9a6iVQEOiqLWAz0bKNJgZTByVRVAGo=
Received: from cyy-pc.lan ([2001:da8:c800:d084:c65a:644a:13d7:e72c])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id ED316C15; Mon, 15 Jan 2024 03:59:19 +0800
X-QQ-mid: xmsmtpt1705262366tsm3s3k4u
Message-ID: <tencent_F9BC98A8109DC637BE27C12AED0C4703DC07@qq.com>
X-QQ-XMAILINFO: OPDQNGCUQ3qLE3EzwNsTeI1rDevk2LHjEp1zWhBmUPxhao00jMtJkdtguX48PB
	 hqRUz6cNW8Zz2AeKJAteFn2aDZDZJOoeGRNC5D8HiCdKAHRJNNhT9FV9CuqaDpw9i+aZh6t1slfS
	 B/s86ANpffq1e6asZfSKwuCVJj9675RVCn09kjAOJi9ZiHaA3zpcHcKlsTMg7IFD3vtyzyHChLty
	 WMtYx+sCFgef2JUX5q4CJknbpoNBmz7pDiyJ93tg17SBFA5zemirbvMP4bfuMgIRa3GSnpzBl7pF
	 UdnN/38EKVbfXRBt/I4NI/0R2X9R1LDqEHs5BBTmXVTwnuJUxrenCV9kDi6DaAN7FtjQ4gTpqj9b
	 vYXZNsF+0IzTFNZoYBDk4eq5f56BsDFDf8WOqk8Y1CG5xbGw4NMKNQ0Jrzml8QbPJywrtVZ52RBH
	 ZWwRMqyWsfwfJ33OtZ4J4dRfyRLPH3RKS3Z2heO/PSasM9t0n3CtjXpKMbvWpbQhHlMX3/q/Gslq
	 FfOu1Fjwbq5FWJvbDpMBccbCdvHoCBAIERd7qC+c0yr1n4E0rfgXFzU2e4/esd/yzuhf45NqYYmq
	 28e+RlEbnvQB6XWOXGNQmTQBOFVZ8JslVFpZavJUsP0tu+xz4drHdmmE92UJO8P5esU3JBQAk4yQ
	 PELOlChfPM5a2LmoTpRu+fB/yfd7j772l6BCOly/xviDfGpl7SgTkpGoSBuYRFbawPv+zCf8R4P2
	 sPANZy/5dgQVWpPaoSNNB54n+4MU8kURODyFfWfv7DxVN0q8+eCDbzUJewjn9Yrb7YSInMUELPR+
	 HURjC0ktR1X+As9ur3hHJaKcf0bTehQpwKz2fqbM3W0WGjv24QyDp9iYThbzufWtb/kZ4uyqclwh
	 ImHrZuK5A5gFq/Cb6IiOVMCXI1Wee3FlQtLkBEAgKTUksSIGKbtcMeOUH3FaShdjQ7j/wRPHlnWw
	 vluQTYyczQMZBTC1Zwu3LKHfAAIxJqLl9SXDvwt7FvB0cDDdscXHkvXSoA2MWNwr/jC/6o1SkJok
	 t/yW1ZUQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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
Subject: [PATCH 3/3] Documentation: riscv: correct sv57 kernel behavior
Date: Mon, 15 Jan 2024 03:58:32 +0800
X-OQ-MSGID: <20240114195832.275982-3-cyy@cyyself.name>
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

The original documentation from a patch violates the principle of mmap.
Since the kernel behavior has been corrected from the previous patch, this
documentation should also be updated. This patch migrated the
5-level-paging documentation from x86_64 with minor modifications to align
with the current kernel's behavior on RISC-V.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 Documentation/arch/riscv/vm-layout.rst | 48 +++++++++++++++-----------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/Documentation/arch/riscv/vm-layout.rst b/Documentation/arch/riscv/vm-layout.rst
index 69ff6da1dbf8..30e879dad6a2 100644
--- a/Documentation/arch/riscv/vm-layout.rst
+++ b/Documentation/arch/riscv/vm-layout.rst
@@ -135,23 +135,31 @@ RISC-V Linux Kernel SV57
   __________________|____________|__________________|_________|____________________________________________________________
 
 
-Userspace VAs
---------------------
-To maintain compatibility with software that relies on the VA space with a
-maximum of 48 bits the kernel will, by default, return virtual addresses to
-userspace from a 48-bit range (sv48). This default behavior is achieved by
-passing 0 into the hint address parameter of mmap. On CPUs with an address space
-smaller than sv48, the CPU maximum supported address space will be the default.
-
-Software can "opt-in" to receiving VAs from another VA space by providing
-a hint address to mmap. A hint address passed to mmap will cause the largest
-address space that fits entirely into the hint to be used, unless there is no
-space left in the address space. If there is no space available in the requested
-address space, an address in the next smallest available address space will be
-returned.
-
-For example, in order to obtain 48-bit VA space, a hint address greater than
-:code:`1 << 47` must be provided. Note that this is 47 due to sv48 userspace
-ending at :code:`1 << 47` and the addresses beyond this are reserved for the
-kernel. Similarly, to obtain 57-bit VA space addresses, a hint address greater
-than or equal to :code:`1 << 56` must be provided.
+User-space and large virtual address space
+==========================================
+On RISC-V, Sv57 paging enables 56-bit userspace virtual address space.
+Not all user space is ready to handle wide addresses. It's known that
+at least some JIT compilers use higher bits in pointers to encode their
+information. It collides with valid pointers with Sv57 paging and
+leads to crashes.
+
+To mitigate this, we are not going to allocate virtual address space
+above 47-bit by default.
+
+But userspace can ask for allocation from full address space by
+specifying hint address (with or without MAP_FIXED) above 47-bits.
+
+If hint address set above 47-bit, but MAP_FIXED is not specified, we try
+to look for unmapped area by specified address. If it's already occupied,
+this mmap will fail.
+
+A high hint address would only affect the allocation in question, but not
+any future mmap()s.
+
+Specifying high hint address without MAP_FIXED on older kernel or on
+machine without Sv57 paging support is safe. The hint will be ignored and
+kernel will fall back to allocation from the supported address space.
+
+This approach helps to easily make application's memory allocator aware
+about large address space without manually tracking allocated virtual
+address space.
-- 
2.43.0


