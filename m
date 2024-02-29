Return-Path: <linux-kernel+bounces-87333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E41686D2F6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6341C2186E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638C8136994;
	Thu, 29 Feb 2024 19:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ics.forth.gr header.i=@ics.forth.gr header.b="gYOL+XtN"
Received: from mailgate.ics.forth.gr (mailgate.ics.forth.gr [139.91.1.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1606C134439
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 19:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.91.1.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709234266; cv=none; b=BVWOcg+7M819ZYaflbe846mte0f4tD8QuL/VzlxHDiUAL/GCMbWEqw/B2p7W9uAEePJc6ias3WXbHzYHLEepQYKRD+BYisNtfRgLJdPTCzzjXvxetSIfJ9HHf889BLYNPkPOS0ZEoXH48b8TLdBeNItsSwd50igXYuISjCFSUvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709234266; c=relaxed/simple;
	bh=rRXx9P2fyWPVK8sV8uJDbjnXN7ir2je1z7JiOtduc5E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=T2kwDMqH3AGiYNbibqbymUiJUPsBlcNIVIhRJUaOQIn/MNqGF/31yy5eTtX8GaxZqzSeVqJsNUxk2jR4p8O3jsEidj1EvaHRC3lgd0cqnev6blNPxm9iNssLxnKBsyVPNzuQgNTGepWsjCOKNvOd5JoLqJAWQbAx5Fugv+g9S2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ics.forth.gr; spf=pass smtp.mailfrom=ics.forth.gr; dkim=pass (2048-bit key) header.d=ics.forth.gr header.i=@ics.forth.gr header.b=gYOL+XtN; arc=none smtp.client-ip=139.91.1.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ics.forth.gr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ics.forth.gr
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
	by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 41TJHc52009359
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 21:17:38 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
	q=dns/txt; i=@ics.forth.gr; t=1709234253; x=1711826253;
	h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rRXx9P2fyWPVK8sV8uJDbjnXN7ir2je1z7JiOtduc5E=;
	b=gYOL+XtNrBpNzN3U4R08zOgYYjq7OJGSI0FAUc7Ds5BFAe1uGxztFtSq2Bf+t33+
	06AeFOtAPEcA6X4E59LB/CCSO5rVUBc0r87SLIb7CP2DH5+zPMH0OEJdd1e5ZYPh
	QEgpXuUa6nN2nEXffPI95/AR9lTtr+2sIOTSJAJ2+qGgLIObeBYPiWi0fNd9qWB/
	+6ZuNFwuBQSm+RQFT3Bi19TP81SBJm2Kk9zALrBY0aVggJkjc5512mnX7oRB+zGh
	vjxb8jw4Tb4zzqAvw3XI6ozac2gzIHg4it4Qub/CyDFRUDDfTaH4/Cf/de5s/ZQF
	FI+fK8HtKed5sCPuLMitJA==;
X-AuditID: 8b5b014d-a17eb70000002178-80-65e0d84d3c1c
Received: from enigma.ics.forth.gr (webmail.ics.forth.gr [139.91.151.35])
	by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 49.7E.08568.D48D0E56; Thu, 29 Feb 2024 21:17:33 +0200 (EET)
X-ICS-AUTH-INFO: Authenticated user: dvlachos at ics.forth.gr
From: Dimitris Vlachos <dvlachos@ics.forth.gr>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        palmer@dabbelt.com, alexghiti@rivosinc.com, paul.walmsley@sifive.com
Cc: clameter@sgi.com, akpm@linux-foundation.org, rppt@kernel.org,
        arnd@arndb.de, mick@ics.forth.gr, csd4492@csd.uoc.gr,
        maraz@ics.forth.gr
Subject: [PATCH -fixes v2] riscv: Sparse-Memory/vmemmap out-of-bounds fix
Date: Thu, 29 Feb 2024 21:17:23 +0200
Message-Id: <20240229191723.32779-1-dvlachos@ics.forth.gr>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsXSHT1dWdf3xoNUg+N3lSzmrF/DZvG48Tij
	xd9Jx9gt1jeuY7dY8zTE4vKuOWwW2z63sFnM6P/PatH87hy7xcvLPcwWbbP4LY6s387kwOPx
	+9ckRo9Pl3+xeLx5+ZLF4+GmS0wem1Z1snmcmPGbxWPzknqPG7MiPO5ef8nkcan5OrvH501y
	AdxRXDYpqTmZZalF+nYJXBm3dzYyF/RwV8x9vZK5gXEvZxcjJ4eEgInE/75mpi5GLg4hgaOM
	Ev+f/WCFSNhK7F1wnAnEZhPQk1g/fw87SJGIwARGiV/vDzODOMwCcxglbrzqBspwcAgLeEpc
	P+oA0sAioCrxu+kiC4jNK2AlsfXlUyaQEgkBeYnFDyQgwoISJ2c+YQEJMwuoS6yfJwQSZgaq
	aN46m3kCI+8sJFWzEKpmIalawMi8ilEgscxYLzO5WC8tv6gkQy+9aBMjOOgZfXcw3t78Vu8Q
	IxMH4yFGCQ5mJRFeGcG7qUK8KYmVValF+fFFpTmpxYcYpTlYlMR5T9guSBYSSE8sSc1OTS1I
	LYLJMnFwSjUwCVpGr3xR84O7+JyGQ5jcQtZ3U+ymBXxp4kni+v1f+tW99NVVDDpSXLtDPW5n
	Fv/ok+KYxTPpeol05GVBpz86NiIbJhR0M3exp70S3xinVqqw78GFnoxHvx69WRpTEZ4avZn9
	0wTDeaFy8/Rj5R8EL3j+NHPp+Q1FEWZvg7UZ06NvTHo8w1iuYJoz844DIeaGHyeVXQn2WxPW
	qPc2LTYydWeawJeK9xLGd9IvXXiWvO9k6stjWsV359vs/LZl2Uphbev62nmLntTKLyyvvHU1
	94pb/Zc0+3kBFjPs+GcmdWot/ZUd4V60JH/d9AMXr2ae+SoU9/jXDt9ZbqvcDlk2fDmpdy78
	vn7Fne7b1hwuSizFGYmGWsxFxYkA01WTUOkCAAA=

Offset vmemmap so that the first page of vmemmap will be mapped
to the first page of physical memory in order to ensure that
vmemmap’s bounds will be respected during
pfn_to_page()/page_to_pfn() operations.
The conversion macros will produce correct SV39/48/57 addresses
for every possible/valid DRAM_BASE inside the physical memory limits.

v2:Address Alex's comments

Suggested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Dimitris Vlachos <dvlachos@ics.forth.gr>
Reported-by: Dimitris Vlachos <dvlachos@ics.forth.gr>
Closes: https://lore.kernel.org/linux-riscv/20240202135030.42265-1-csd4492@csd.uoc.gr
Fixes: d95f1a542c3d ("RISC-V: Implement sparsemem")
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 0c94260b5..875c9a079 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -84,7 +84,7 @@
  * Define vmemmap for pfn_to_page & page_to_pfn calls. Needed if kernel
  * is configured with CONFIG_SPARSEMEM_VMEMMAP enabled.
  */
-#define vmemmap		((struct page *)VMEMMAP_START)
+#define vmemmap		((struct page *)VMEMMAP_START - (phys_ram_base >> PAGE_SHIFT))
 
 #define PCI_IO_SIZE      SZ_16M
 #define PCI_IO_END       VMEMMAP_START
-- 
2.39.2


