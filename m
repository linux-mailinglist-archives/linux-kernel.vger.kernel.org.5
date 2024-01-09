Return-Path: <linux-kernel+bounces-21275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A87D828CE7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85765B2316A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2BF3C6A4;
	Tue,  9 Jan 2024 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Pv3kSkEQ"
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C20C3C482
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1704826207; bh=DmGo0slP1Ax+f+6LBWpdzqWeIFagteLk84bt6YYhxSo=;
	h=From:To:Cc:Subject:Date;
	b=Pv3kSkEQeCoe/kbuOwwDLcE41Dri9PZGznv+HZJFaLmTep0IhJgqbNy14+/CEk2sY
	 B55M3XBASH0UxdDapwauyn/cafUqFeVgzbVoaMFmEvB2wW3qZruENj8mqevEDlP/V2
	 i5btftN7KqbRPJ0sJw/EvH/bnGB3qvtAjBSFy6ZI=
Received: from cyy-pc.lan ([218.70.255.58])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id C803E83D; Wed, 10 Jan 2024 02:50:00 +0800
X-QQ-mid: xmsmtpt1704826200t8xep9519
Message-ID: <tencent_6D851035F6F2FD0B5A69FB391AE39AC6300A@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjwbIh/j+boLSJHX0auiYjrweTADFbG4MJ95HYOrcj5mqN5GslSk
	 gur438jdm2YbxWUFSONaraHqL/MaWpfDIWZuc8uzkHLeOjY5S+OwSlAlVJPOnKDQhPzgFqbEYYu6
	 WC1XzwINxKL0fGO1huOKjvNV9SJMgyyzzmbTGsvYhqi4UT00fNw6YI5lMDP0L2pWsFz+ir5PPFBl
	 NtXjpodLTGipJkpi7kGWufV/XQ+e3HhWeDq4TwOkEHi7fuouDx4WApcFVVO2FG9w7yPo5LeKRZRy
	 fI1V/siWgnTj0nDO+fxYksksU6Mv0AdHK8F9Hhihe6NkHcrNDKnUfkpX1l2lYjupn1xXWgKuHFHR
	 0fBadkJoPP85v/n2ha588yKqIly+6+9B2qCFvwQxqwaoQKNoZQy1VzyUrqlRReAZTDPqFw6abMjB
	 HC6xogbgGlnuHYnNioCYESuem3yQzmRd9EWmcjx8NmWcBqSNW1DqXQrsTKMmOOYcrTFHq9ZUM76H
	 D2HZACHyM8k6Z1xIzXYDAI8M4u6YFVd3TVVPDDQC9WXW7bkDiXdqDAgwE2t2ncYZ7S3IU/IzVAgx
	 oL3CNFWOrtVoRt1guvlKqyvfEedvydfvLW1BCceFB4vu1kROuJ/2DAjX5RbZRtftbeOWlbxgJ7GS
	 PsozfzUN9ICbAHq7Jor5ej0PAb/oE2urUL+dqYEV1Cf8FRkeI5ICzgXt8n5DuQml7B0J3t6i2HFB
	 lTR+VjG/bAZISOJNbTKHxTeA3u8jEVgiY+TsIaG6yKrawmsCcWg1kYuU1PZVh2YTnK8C40D0s3xL
	 JHoxQjcl24d8eT8bPebaFqX0uSRQZM7ETOlMqQ7V43NiWWicN7k3J9AjF9bEUSQHiFSVZ+sBTKL/
	 chv0IM6P0Egm04RrIIIG1cFJXvghlGmRGP7web+cfzx3B09sbOLSySdmUkuD2k9Wh/oUiCfFEUsr
	 Y1v2LJ0NSy+wdKEP01LD/AX3iKTDkmAXDAkp11mTaYNM7OmSOJ31oRab19Yp6XoAlT8v9NRQk=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Andrew Waterman <andrew@sifive.com>,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH] RISC-V: only flush icache when it has VM_EXEC set
Date: Wed, 10 Jan 2024 02:48:59 +0800
X-OQ-MSGID: <20240109184859.379050-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As I-Cache flush on current RISC-V needs to send IPIs to every CPU cores
in the system is very costly, limiting flush_icache_mm to be called only
when vma->vm_flags has VM_EXEC can help minimize the frequency of these
operations. It improves performance and reduces disturbances when
copy_from_user_page is needed such as profiling with perf.

For I-D coherence concerns, it will not fail if such a page adds VM_EXEC
flags in the future since we have checked it in the __set_pte_at function.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 arch/riscv/include/asm/cacheflush.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index 3cb53c4df27c..915f532dc336 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -33,8 +33,11 @@ static inline void flush_dcache_page(struct page *page)
  * so instead we just flush the whole thing.
  */
 #define flush_icache_range(start, end) flush_icache_all()
-#define flush_icache_user_page(vma, pg, addr, len) \
-	flush_icache_mm(vma->vm_mm, 0)
+#define flush_icache_user_page(vma, pg, addr, len)	\
+do {							\
+	if (vma->vm_flags & VM_EXEC)			\
+		flush_icache_mm(vma->vm_mm, 0);		\
+} while (0)
 
 #ifdef CONFIG_64BIT
 #define flush_cache_vmap(start, end)	flush_tlb_kernel_range(start, end)
-- 
2.43.0


