Return-Path: <linux-kernel+bounces-132997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA40899D12
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C3AFB21823
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3E913BC36;
	Fri,  5 Apr 2024 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7OO++ld"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A5F1E87F;
	Fri,  5 Apr 2024 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320445; cv=none; b=SOlA8kPv0RL3fVijCTkM9ZlBXTWSUEJTn1JtyBqb5Vp6hf8p89Q5D5fM7efT0F6CYELp+SWzZwezNDiQuG1oB+DhRrwGWOEIzD4t/j0CT6LgXI0OK9Kb/RwW0x2dCkykrNEmygeGWwiWgQ5XGNdc2ZXuF+ypqKxF7igQ0loH0kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320445; c=relaxed/simple;
	bh=PECncfpIj9KF2NL1qIow7qaBE8q+dGkyd5JVLY75BOg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rr4vzquK5N5qiEPuGyTkXVjDjW8bS2Hi5T3l8qbROokgytelZIBWxXwQPivccmcXKB+ypH217tpStOgeogFPLNOfvwDtuHM6pj1s963CHFzs77d0FFLuPdsKJ3NkJY2igu+UGy6WYOoxl1Y/6se4rUPVpLeVWtgTNFG8AT5osos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7OO++ld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF20DC433C7;
	Fri,  5 Apr 2024 12:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712320444;
	bh=PECncfpIj9KF2NL1qIow7qaBE8q+dGkyd5JVLY75BOg=;
	h=From:To:Cc:Subject:Date:From;
	b=f7OO++ldDAG5EvmYC/zNV61hMnNPLbuFpCPIFVPgvRCZ3MYgmFm8WHRO+XWL4WQ67
	 ePFkz+UQVYDfnUjZY8s6OsNrJOH63T2asc5L7yRbMSdNL53LOd3GWDcWDD5vyIz4pT
	 qHh+ZgTY43kwgrSlbxKaD4VCb4YJ1mUMQQlK57VJ7VLWLebLRjR6ecq28RvkVvglLH
	 GiC4bQx2PPqnuKVgr8BAH729yQS56FpSXMdB0S65D0Timy7W3InfO6SRenpmaHxcbu
	 0m2q2rs+x4g4XgRUC/xIq+SfeFpMsPjjZFqSKdtB1K+4ZvzAUHrMLpG8O0h2RseZEm
	 RBeYAPQuBl0TQ==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Pu Lehui <pulehui@huawei.com>,
	Puranjay Mohan <puranjay@kernel.org>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH bpf] MAINTAINERS: bpf: Add Lehui and Puranjay as riscv64 reviewers
Date: Fri,  5 Apr 2024 14:33:51 +0200
Message-Id: <20240405123352.2852393-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

Lehui and Puranjay have been active RISC-V 64-bit BPF JIT
contributors/reviewers for a long time!

Let's make it more official by adding them as reviewers in
MAINTAINERS.

Thank you for your hard work!

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 75381386fe4c..58ab032ad33d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3764,6 +3764,8 @@ X:	arch/riscv/net/bpf_jit_comp64.c
 
 BPF JIT for RISC-V (64-bit)
 M:	Björn Töpel <bjorn@kernel.org>
+R:	Pu Lehui <pulehui@huawei.com>
+R:	Puranjay Mohan <puranjay@kernel.org>
 L:	bpf@vger.kernel.org
 S:	Maintained
 F:	arch/riscv/net/

base-commit: c88b9b4cde17aec34fb9bfaf69f9f72a1c44f511
-- 
2.40.1


