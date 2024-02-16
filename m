Return-Path: <linux-kernel+bounces-68677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E6A857E43
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584EF1F2120B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA0112C531;
	Fri, 16 Feb 2024 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbegEhIP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3B212A17B
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708091905; cv=none; b=ADs/8LCM1esi6kvPj12zSHxNiNswR13qJEjGAQlRgjaD2gAl/AkrTEpkEti0M2Z85RE6tsW8czgjaYpEzD9El0IbY4v4QZE5VcYGd62QJw96DNVuDKzYHORCVAsPJT1ZLEwEL1OFp02DYjeyFj2WWift2TgF5U8rvlB45Ah5YK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708091905; c=relaxed/simple;
	bh=DYer1MDOjQctt3rMYGNc1SxWw+ODGSGiCUq1XcQAyLI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UuF7zTwoPAaKsk3wq96gNhDYHtLr/flhlC3fSZthZ7TTcFKM7wTQUkBdnU7oQqtaIni7suG6iDoV1YEWe5u3DbUsDvU8UKnqiuqhfvUzmA2r6TL7HixnSkesuWOfRT4l8C+zNAp2J/HLIManzXO21lrDW3Im7S38ZkpOdGR9sOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbegEhIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E302EC433C7;
	Fri, 16 Feb 2024 13:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708091903;
	bh=DYer1MDOjQctt3rMYGNc1SxWw+ODGSGiCUq1XcQAyLI=;
	h=From:To:Cc:Subject:Date:From;
	b=PbegEhIPANLIh7P1dBB/JNjJ59185jxfNRMHvnsacLeSzpDRXVRZQBjm15t74TRGq
	 tlDeM+Ez3MGhB5t3KdSj0BBuCzBv1i7QRhop0ejHLF8LTtVA13pWqU8GewwOfJuPGR
	 TySuyu/xmxiH7CTat4V5krMXjtc4OoTpt1wCs6G0bK2htVjF0JrP55HEAGWv4IzVcz
	 zeMorCM2Xu96x3QAoAJHBFxfGkC132JOou1mVzkQ2bQS5uJNO5hB2ahhdJY+N8dj7y
	 nfMOlQ9+hrvIUe0wQ+sjc5glbJPXFJTARLjz92gp/TwDK4VTANBlrjWDcK/PBFpeWm
	 RdMTIJdNGIDxw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: remove unused KCSAN_SANITIZE_early_64.o in Makefile
Date: Fri, 16 Feb 2024 22:58:17 +0900
Message-Id: <20240216135817.2003106-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2fb857bc9f9e ("powerpc/kcsan: Add exclusions from instrumentation")
added KCSAN_SANITIZE_early_64.o to arch/powerpc/kernel/Makefile, while
it does not compile early_64.o.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/powerpc/kernel/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 72d1cd6443bc..a6f9b53c7490 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -55,7 +55,6 @@ CFLAGS_btext.o += -DDISABLE_BRANCH_PROFILING
 endif
 
 KCSAN_SANITIZE_early_32.o := n
-KCSAN_SANITIZE_early_64.o := n
 KCSAN_SANITIZE_cputable.o := n
 KCSAN_SANITIZE_btext.o := n
 KCSAN_SANITIZE_paca.o := n
-- 
2.40.1


