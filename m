Return-Path: <linux-kernel+bounces-68671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77369857E26
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3731B1F25B86
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2175F12BF37;
	Fri, 16 Feb 2024 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYstjYEp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C1F12BF24
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708091725; cv=none; b=Z2FpDvgGhdDxrizoU8Rjs7f3Y9ATj1q3e7OhW10ae0Vkq8CkQVYtTvbkXRC1WcWB/ne2j1pCEQB6U+41Zm3r8Qvb9aCfb0LL9s41921/CqlbSpLC1nfO4thDlMyG5XQRd/q6Rz9QaowXQxVfo9jPmabKyDETEvNwc3PoBkVoZCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708091725; c=relaxed/simple;
	bh=JYRadvk8epVLTennqJxblFfin4HjDeQtbPYeVdFZkTc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O+Xn5H4DP1QZOQs6qeJPHmcA6m2/GNdHpXvIcsV9uPrKeHRjxUh1vGu/47s9Ghb5v2AAvuFe477EJKBG0oPnzhz1Q3AMyCjJhxGhKj2q03IOZyKO8YkdFSUlrKNhdxT5SN7XAp5AFUI+NXI6x9v2WNXORtUc90kPwEk3jU3qyvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYstjYEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1C3C433F1;
	Fri, 16 Feb 2024 13:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708091724;
	bh=JYRadvk8epVLTennqJxblFfin4HjDeQtbPYeVdFZkTc=;
	h=From:To:Cc:Subject:Date:From;
	b=bYstjYEpD43jdQrvSD9EDleeWQBd8QQ3QVGDGvKpPEQNlpsXc6iJA55H/CJFOsD9n
	 cPAaiLLKMOQ3+sH6TBYOIWjaUZQYLxDSdYc6qBSMmWU34M+0xFis417Xawxz9wKhMV
	 cC6yqKHucIo2a/LMRM1DPwMnr3BjNm4aB9sitOzfpTw5XBOFTsZCzoVwGckGN9tGVg
	 s4iUPran2WXVNXUTh0Rzoaz7sGHOBq5yZArA87Lpjgza3Sc1cv3k6/tOXzfpnjEQAc
	 nVbehF86OK3ddbZ6SlgoKgp+AfuELIE8bnHzL4qr0/fdqsvXNCMcHI5KjAlG02H5bf
	 k4T6qGglqjteA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: remove unused *_syscall_64.o variables in Makefile
Date: Fri, 16 Feb 2024 22:55:17 +0900
Message-Id: <20240216135517.2002749-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ab1a517d55b0 ("powerpc/syscall: Rename syscall_64.c into
interrupt.c") missed to update these three lines:

  GCOV_PROFILE_syscall_64.o := n
  KCOV_INSTRUMENT_syscall_64.o := n
  UBSAN_SANITIZE_syscall_64.o := n

To restore the original behavior, we could replace them with:

  GCOV_PROFILE_interrupt.o := n
  KCOV_INSTRUMENT_interrupt.o := n
  UBSAN_SANITIZE_interrupt.o := n

However, nobody has noticed the functional change in the past three
years, so they were unneeded.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/powerpc/kernel/Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 2919433be355..72d1cd6443bc 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -191,9 +191,6 @@ GCOV_PROFILE_kprobes-ftrace.o := n
 KCOV_INSTRUMENT_kprobes-ftrace.o := n
 KCSAN_SANITIZE_kprobes-ftrace.o := n
 UBSAN_SANITIZE_kprobes-ftrace.o := n
-GCOV_PROFILE_syscall_64.o := n
-KCOV_INSTRUMENT_syscall_64.o := n
-UBSAN_SANITIZE_syscall_64.o := n
 UBSAN_SANITIZE_vdso.o := n
 
 # Necessary for booting with kcov enabled on book3e machines
-- 
2.40.1


