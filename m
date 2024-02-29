Return-Path: <linux-kernel+bounces-86854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E1C86CBBF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B8C287C66
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A754413A868;
	Thu, 29 Feb 2024 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ics.forth.gr header.i=@ics.forth.gr header.b="SDLN/OI2"
Received: from mailgate.ics.forth.gr (mailgate.ics.forth.gr [139.91.1.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4337913A24A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.91.1.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709217542; cv=none; b=ZzCwu29qgA5z/Mq6lARr1aLrdDxR8muaQyOr3mB0VgynuFsB0fORC9sfdj4pdQ8kQYC7gFj7ZN8LHkJjbulbG/f1DtVWAzdCP4tDRBjXdTmE6ym3ryyVCzQg+ikIb4qKhGtO/WhKvALR7dHDhQZTmDgU+DJGemX6hH4ss65g1hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709217542; c=relaxed/simple;
	bh=2AP36O4Q237gvx6XJTGzq6ubQkJU6MDVVUBj66241MQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=D8d6HGyhDhwWUkT8O1nR9DUyd9CXuEOEWEt+Lf4szJkqvvNYKij1EKMafZO3fzKrpZdzR/jm8akaKHsBs2Y0bog6ePhTof4mRMpQLRoC4z/rTodW5FzBcn0D+oCkS/P5Pw7ex7K0aB9SR3rCT/V4/N6wVH//D3Pi1LbdRx/CfoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ics.forth.gr; spf=pass smtp.mailfrom=ics.forth.gr; dkim=pass (2048-bit key) header.d=ics.forth.gr header.i=@ics.forth.gr header.b=SDLN/OI2; arc=none smtp.client-ip=139.91.1.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ics.forth.gr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ics.forth.gr
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
	by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 41TEcnnY003038
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:38:49 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
	q=dns/txt; i=@ics.forth.gr; t=1709217524; x=1711809524;
	h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2AP36O4Q237gvx6XJTGzq6ubQkJU6MDVVUBj66241MQ=;
	b=SDLN/OI2xDX4iAwWgKj4Qy1whzd5dUHAigjwL/yaMJVTK0vEBn/+3OssC8LzZ2rU
	o+KFcUjY8rYNOccxgDvN0fVVrECnAtANXnRXHlg/VOAPFM9EOoEeFdZD5PsjbbPE
	I60NQyHDAOQ9v9u8SecCVQ2hHiStR+g4/BszaPmMQBvN2B0NoDNSC8uoF7cW6SKC
	yJ1x2spyL68Pg9tFTnLz6kRR55hEzETkC9e7pJ24Z5FfHSz2gWtmf613bD0pdHRo
	Jvg0Hx/IGoKSE+G7BFgFXNjgD2gHmnH5G3kWgB10KPt2tlJPSC7wyJ0Xo9XAvbp/
	cKZSRbs5QtKU/Dmqz7NJlw==;
X-AuditID: 8b5b014d-a17eb70000002178-e1-65e096f4feaf
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
	by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 67.EC.08568.4F690E56; Thu, 29 Feb 2024 16:38:44 +0200 (EET)
X-ICS-AUTH-INFO: Authenticated user: dvlachos at ics.forth.gr
From: Dimitris Vlachos <dvlachos@ics.forth.gr>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        palmer@dabbelt.com, alexghiti@rivosinc.com, paul.walmsley@sifive.com
Cc: clameter@sgi.com, akpm@linux-foundation.org, rppt@kernel.org,
        arnd@arndb.de, mick@ics.forth.gr, csd4492@csd.uoc.gr,
        maraz@ics.forth.gr
Subject: [PATCH -fixes] riscv: Sparse-Memory/vmemmap out-of-bounds fix
Date: Thu, 29 Feb 2024 16:38:33 +0200
Message-Id: <20240229143833.107724-1-dvlachos@ics.forth.gr>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsXSHT1dWffLtAepBnt3iVvMWb+GzeJx43FG
	i7+TjrFbrG9cx26x5mmIxeVdc9gstn1uYbOY0f+f1aL53Tl2i5eXe5gt2mbxWxxZv53Jgcfj
	969JjB6fLv9i8Xjz8iWLx8NNl5g8Nq3qZPM4MeM3i8fmJfUeN2ZFeNy9/pLJ41LzdXaPz5vk
	ArijuGxSUnMyy1KL9O0SuDK+ntvEWHCEq2LNwQVMDYw/OLoYOTkkBEwk3l4/zghiCwkcYZQ4
	MdcXIm4rsXfBcSYQm01AT2L9/D3sXYxcHCICExglfr0/zAziMAvMYZS48aqbHaRKWMBN4vO5
	D2CTWARUJVrutrOB2LwC1hKNN/YBNXAATZWXWPxAAiIsKHFy5hMWkDCzgLrE+nlCIGFmoIrm
	rbOZJzDyzkJSNQuhahaSqgWMzKsYBRLLjPUyk4v10vKLSjL00os2MYKDntF3B+PtzW/1DjEy
	cTAeYpTgYFYS4ZURvJsqxJuSWFmVWpQfX1Sak1p8iFGag0VJnPeE7YJkIYH0xJLU7NTUgtQi
	mCwTB6dUA9NREy2jmIOZ7dyqp4Ii1Fia7Or5bnxoq/v0oG7z3dasqYdYyhqV/65sbpdWvcoU
	1F6//K3aixcxf/y+vRR29bzD+4VpRofJjVvGymnSDUzrfP4Ve7AkKJbF3a1dbR/h385W/Eyq
	2+GoRCX/j2fMbS4S+U+60+9Lmx9wn2CVWMFRd55XRW9Pc1ES7+FniZnx+9n0jl1at7iNf/l7
	ZZtdyVJ8b4Ji2+VVzjVMd9E5uivO+Yj2pCgmjg/NOyY+bIrNn7GpqFl/i1pr28U+ia2hLq7f
	eff8fWZ8c3n87+UvPupa7JksM/XHrv+1j7bkiZqr2sYIxX+8ofve9UBV2a6lpwQcLp2qbxFa
	HlKj97lKiaU4I9FQi7moOBEAp+Zj+OkCAAA=

Offset vmemmap so that the first page of vmemmap will be mapped
to the first page of physical memory in order to ensure that
vmemmap’s bounds will be respected during
pfn_to_page()/page_to_pfn() operations.
The conversion macros will produce correct SV39/48/57 addresses
for every possible/valid DRAM_BASE inside the physical memory limits.

This is the link to the relevant conversation and bug report.
Link :https://lore.kernel.org/linux-riscv/20240202135030.42265-1-csd4492@csd.uoc.gr

Co-developed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Dimitris Vlachos <dvlachos@ics.forth.gr>
Reported-by: Dimitris Vlachos <dvlachos@ics.forth.gr>
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


