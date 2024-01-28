Return-Path: <linux-kernel+bounces-41607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D097383F54F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 13:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89BC12823AD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 12:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26E52033F;
	Sun, 28 Jan 2024 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dPJcKUCk"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A6A208A4
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 11:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706443199; cv=none; b=FaKBlbKY3xrKQEQPmz7/4Ax3sKRKQ02odDhqwasIOWVqj1VscXJ4Pt/Nu6Bl1/ZzL/EGzfuAT936CjREUT0x1l78skTsKmr+k7KDNHhoqeJvOebX4a016mSphZE8z1pESk4vZbchoM1uXzc5tEkeTFLV0YeeKOTRA/Mo/mnh2wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706443199; c=relaxed/simple;
	bh=0ffhvTdDYQDhO2l90fSWowkyG+ZwAk7i6+0vQmQ16yI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XFB7wwQ9VCdDHRc/IfAt6BTIrCEhyqtsCF4e8SqucHNMCUhYx0EikQNLIncStW9imL7+2x4X1n8Qnt4B7gklDTSBZEMux9oQmarn7rI+tM5W8VZFao54A7EWxTmaH9nZNlAyR1go075WQNWaOQ+QN4UBtif0MXAvf68T3vvdDPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dPJcKUCk; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e76109cdeso30813695e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 03:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706443195; x=1707047995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iQXpMM6MssEsk2oLvh57e4djnu+gVgpIUXXI62pyybA=;
        b=dPJcKUCk4Oy/7pmAsQRxP1yN7QQ9N4jMzPEMHRodOJiWvY1WAndADQnJt3QNu/bVsy
         Lu9FOhPWzD1sQBY134hReSC2ezEyIy/F6qwJbqMx1HRQocvUlHUpUTNG6R6yNhaZBWbQ
         ElJBvzAyhF2OyHkHbjJdFUPLY49enNDk7w3luagk4tQqk1YgbHavcpFEYO3ybOdsh9ys
         3Qsm/VFyNyiH9zgk3eRDkbjusyxYLwaSS6oV7Fg9Snq4cXRohc6iF4QE/+X9egYQ4DY7
         Qoon7BY/FcCI9wzctsrfc4+F8d850H+l+q4QN+2aTS9FZcylEpo23XWztwpMjQ64olq/
         oVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706443195; x=1707047995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQXpMM6MssEsk2oLvh57e4djnu+gVgpIUXXI62pyybA=;
        b=Ua6rPEroT/715Thm0gd8WyedP9LgaG/ISaxYTo2TRk/ewGXXDqZgNsi+RPgZSESFxm
         TeFoduJlcd3tdLgfAW6yfurjTnwKg3uBLSgsRtqwTnv00fEjf2AfaNnvi9BAyGc52XbE
         H7f+aRmnLU1e+vbLVs5K3MY4ay+/NZMm/j0Id7QlIqZhyRTkfeoVwg4wBeOfp8FtPkD6
         bhseC2igvUDvRO0KN3RAzyuUbtzn4dtFOfYPUfGQAQEWR87NPrRLv1fh6JAjedll0iJE
         4oQE6yc20y5R9T8+NRxu25XZq7Fu5LnXwpTOp+JbsqHi4sDqDu6ImzQgt0H4M3PkJb/h
         vBUA==
X-Gm-Message-State: AOJu0YxI5Reav0220SlRTmxVN74ifr2phKaD4sRwiQ3t408bzuMyjOkX
	v6yaOdIaeBHvos/54alHMPwK0ObTO9UVS22g2TAqWMflqcGhjJXPywzHUJbX6/Q+YBuPjWjTuUn
	1
X-Google-Smtp-Source: AGHT+IGma6x2uAQftFRw+t34Rigv73YGbVESS515n/ezSqGLzQ60pjQMjIRMC7yGXXA7fqpMBZw0GQ==
X-Received: by 2002:a05:600c:19ce:b0:40e:f6f5:9398 with SMTP id u14-20020a05600c19ce00b0040ef6f59398mr6888wmq.24.1706443194612;
        Sun, 28 Jan 2024 03:59:54 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id q13-20020a05600c46cd00b0040e89ade84bsm11101843wmo.4.2024.01.28.03.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 03:59:54 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH] riscv: Implement pte_accessible()
Date: Sun, 28 Jan 2024 12:59:53 +0100
Message-Id: <20240128115953.25085-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like other architectures, a pte is accessible if it is present or if
there is a pending tlb flush and the pte is protnone (which could be the
case when a pte is downgraded to protnone before a flush tlb is
executed).

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 0c94260b5d0c..3b46677827f6 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -353,6 +353,19 @@ static inline int pte_present(pte_t pte)
 	return (pte_val(pte) & (_PAGE_PRESENT | _PAGE_PROT_NONE));
 }
 
+#define pte_accessible pte_accessible
+static inline unsigned long pte_accessible(struct mm_struct *mm, pte_t a)
+{
+	if (pte_val(a) & _PAGE_PRESENT)
+		return true;
+
+	if ((pte_val(a) & _PAGE_PROT_NONE) &&
+	    atomic_read(&mm->tlb_flush_pending))
+		return true;
+
+	return false;
+}
+
 static inline int pte_none(pte_t pte)
 {
 	return (pte_val(pte) == 0);
-- 
2.39.2


