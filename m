Return-Path: <linux-kernel+bounces-160725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9528B41B4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9651F2293A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CA53BBD2;
	Fri, 26 Apr 2024 21:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JgYyt7u6"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473CA39FCE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714168754; cv=none; b=f0+/+4KDDNE8x1aMGtcbwNJ6uOH15OInj80AXEoV1SE+fenWDYae6WmeDXaVcYkZew7KiouLtaFXZfAJoL8j33hBSZZxMz9tZy0ILTghnSYW3J7IqFlFyfXR/AQWQXyArZ1NAX8n1MD2TN3mEYXb6BYDotZH4YHaYvZpsfrl5x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714168754; c=relaxed/simple;
	bh=zokeLGTCizecBJ0C/S5HawdecIVVpc4P0EAGzps9Dbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D3SPSuyKeSNso7thoV4sQf+Yzulhv5xeIGdx8kpiXn1bdOPr0bsKj940Tt1bbEuN2F4tq1xDg6cR/2F1+0OGtGOz6w+iyoZSs3DIMxun+LQkzPYLRwCPPkbjblYJYz7xpdO3VWbymxVdvhoBX3VU9KrKe6YHmmEBCZ50ja2nD6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=JgYyt7u6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e36b7e7dd2so23360195ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714168753; x=1714773553; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TchHp9iPU+jV41Lhl65NNSkSnBIWGzSHLYj+6EVTYis=;
        b=JgYyt7u6iiaIhbAnLkr1gUnYmeUXkI/aAVSfWn+m2FvFn/SoinEcKXtQX9CdioUryn
         oYJ88eIMSXvbaD69z3/gvw2FW+w9u2SrTnDyBPiG0UEyHE+Tsz9nhSapfOOoQoQ571It
         iw12OQkfZhEpYAFkFzRuee7Dyr4wzWJtwMOXKntA09v0XhztUDytcxRcgC6mDPVk3R1v
         CsxzHs+NBE2v93f4dDkUPxIlFUQktLq5QcpJKe8e0kLxoz0kuRXujP09CZ89EE2i4T4r
         bcHn8hQ/oZIjp88yaUNM9/XLsFlXuJfEeT9Mno79qNd14Vw22bdCEzZ8l4hUNsbFEieI
         rE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714168753; x=1714773553;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TchHp9iPU+jV41Lhl65NNSkSnBIWGzSHLYj+6EVTYis=;
        b=cMPLHs1Pq4rF/70LDLq864iwj/yWC7amBN2yNwA8zm++zV/EMVkyNNV+OYRor+T/cr
         V7ny5l1u8xIS/34mWr+EOwNkFawfLK/xNvyaZuEUJnnXAVDTOJ1ibBaCdvSzsV6IMynQ
         Uo4948UVrUg21Ui16v5njKJn9NLvA5WqoaddLdf03n/Xw33J2kt7yKQtKW59EYZvAJgy
         gfSV/loe5CUKJF7MH4mDQs4jhms7g5mgq5MbDHRD+p1RU6ZYRn6eYWTqDjvXb1Zv550N
         PjFMWnrUArTp0r+O8JTKiUK9yAr3z9wB91s8S4eib5m4DYCKe8l7AAGfbJWYQuXuzqJF
         UQvw==
X-Forwarded-Encrypted: i=1; AJvYcCWoA2tSeElSBo8zdnuXpwbl6o0MXw0qD5SlPfErdS9yPGxmiy4bWnXyQyq2wyAYnvG46m/v/ZGhcsj4yKD96WXfFxy9zSM/drjSZ1l6
X-Gm-Message-State: AOJu0YztuqfjT4aNlv05uJBtaPOu9GuG8uGLnCG0GhfG+nuCY7E+G3+Y
	UGsS8KVuZbKz+2WnXctvshy4VuzArAxFKo6eJChF7yhPcCaQOm2akIzuQkAt5Jc=
X-Google-Smtp-Source: AGHT+IET9MIfRPVLQ+q19JlPHtZ5UN13lMzn5RxDFBe+dFnHx+VBL/0Yu6aR/OhMxKkAebF8s3aZ0A==
X-Received: by 2002:a17:902:fc46:b0:1e0:119e:f935 with SMTP id me6-20020a170902fc4600b001e0119ef935mr1210821plb.15.1714168752781;
        Fri, 26 Apr 2024 14:59:12 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d2c100b001e2a7e90321sm15899787plc.224.2024.04.26.14.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 14:59:11 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 26 Apr 2024 14:58:55 -0700
Subject: [PATCH v2 2/2] riscv: cpufeature: Fix extension subset checking
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-cpufeature_fixes-v2-2-7377442b1327@rivosinc.com>
References: <20240426-cpufeature_fixes-v2-0-7377442b1327@rivosinc.com>
In-Reply-To: <20240426-cpufeature_fixes-v2-0-7377442b1327@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Evan Green <evan@rivosinc.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, 
 Andrew Jones <ajones@ventanamicro.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714168747; l=1173;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=zokeLGTCizecBJ0C/S5HawdecIVVpc4P0EAGzps9Dbg=;
 b=g6HQlFi2r2iw6uPy9CCrKLJWOVB7GKXPFTWeJwWyNyzIvj5uFAh15VfM1hFJcjfczUEmHFAe+
 Jow/gSE7KbxCHuTt6nkCaxYAJsqGghfDwuEHkI6U4tRBKzhfP7i8M/4
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

This loop is supposed to check if ext->subset_ext_ids[j] is valid, rather
than if ext->subset_ext_ids[i] is valid, before setting the extension
id ext->subset_ext_ids[j] in isainfo->isa.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Fixes: 0d8295ed975b ("riscv: add ISA extension parsing for scalar crypto")
---
 arch/riscv/kernel/cpufeature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 500a9bd70f51..e53deac701db 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -606,7 +606,7 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 
 			if (ext->subset_ext_size) {
 				for (int j = 0; j < ext->subset_ext_size; j++) {
-					if (riscv_isa_extension_check(ext->subset_ext_ids[i]))
+					if (riscv_isa_extension_check(ext->subset_ext_ids[j]))
 						set_bit(ext->subset_ext_ids[j], isainfo->isa);
 				}
 			}

-- 
2.44.0


