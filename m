Return-Path: <linux-kernel+bounces-31595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A627E833089
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E059284C3A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9109D58AA4;
	Fri, 19 Jan 2024 21:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BI4Um1/S"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D41F56745
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 21:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705701457; cv=none; b=GRnvpwqc/nbg+YMSb3HxDUGAOOiAS2m79D+RUDlvx6EhjtoYtoRCzNn4QzjT5gSab7flGArP1yeN0JMzKou2rdiKjH9zSCrC+zBZ1+MiWI5Rsn9VExfv9FOEw8sFV1vWD5YJ2xC0IZiS/FlYDcwBZLbiHK0Vw7nRHjjPPvZsiiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705701457; c=relaxed/simple;
	bh=1uabMeCQFCqnSjbynu1nSiZj2Z/+KuVO23AFzHnc5p4=;
	h=Subject:Date:Message-ID:MIME-Version:Cc:From:To; b=aS8gakJJQZoGMSq6oetG81E+0hwq4nDly2qzaFcIL7Y3FgQZD8xBD+zumDNcOsm0vwPzOBF16UFNvOkTapi5O/lZU41jQ+GdO3M7WuypG3SPQPPGAepwASZviWT21a4mWYNLxRNXLx+qQjKNrCA4T/HPlvM3AztFumq3VmybtWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BI4Um1/S; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28be8ebcdc1so1033170a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 13:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705701455; x=1706306255; darn=vger.kernel.org;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=VVF/DXNkQrk84cprN3UAoU1BvvHEzT7JQOwOJshC+cA=;
        b=BI4Um1/StUQuP3okNZdHvigasCxKzIL7AonJZR7XacpA8XDsShyHm0Y5Lzfp5wbspg
         6gs27oWsPpKitdr/CHc5jXM2T9nNCEBavk5aJdUdLDy5Dkxp25EfBIaPWYbu2beez3BF
         7GINq5MfDOdcq2bduCWT+kkbRuM8XUqsjQYd/OuYekvqtr3vBBIxI5wYsaghyZigO/Pt
         W9aIyR8YSs0WAQiveA4ZC/wYAxF3GeAEspa7+5cotXJDxorll2gPS/TrH0SvcKkFmSZS
         tjXntR1te9ZkrhX8uhDtRV4mR9ZTStbTbucEiy7HPb3O3miu/YyYHMTfhiOTBRRBbITE
         kr4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705701455; x=1706306255;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VVF/DXNkQrk84cprN3UAoU1BvvHEzT7JQOwOJshC+cA=;
        b=gaWdMjsytxm9grUPUC1Kr2S/S6Em4Obm1imjtY9XsHVgr+0a2lLOhL4jgVZeGMsr46
         /HANpW/9B3UxXHx8HuCMIPmeMKrh5r/leuQ1We8e+ohgHywOS+XmqiVj4jkzOuSRG/SI
         Qo9LWU7OVLayTg6VL8vvurTdszJPOsZ0+DIzZzqE+T24+WNyeemkNHjMsFYXZ/mtmew9
         n/ViWhi1KXrCTlRapWts/D9T/Pi279IU+3x8zHFQUulOtTVJf/gKmOV/YnqGw54ILvmv
         F+ElLkw21pxvjVuFIj8qKOWIoZzWxXtZut3XreEHV8+/jS9IMOMIxbxd7ETo5FvmFZfg
         fEcQ==
X-Gm-Message-State: AOJu0YzLxYjAWHZzuduAx3hwaJ5JW9kfy/sAtbkg7jNW/kwt5RZHW/B0
	qNFGrW84n1dWT/AtJYmgI4NyC8clK0VioMHD5VBmKo5Eq1bw3rw6tC38+JS+OaM=
X-Google-Smtp-Source: AGHT+IGEZk6VnUzExADUhpg7c3wGkhyF5/eA70sllfT+Dl5sV1z44WbDQY05CVT8DUCcI4SCpe6SuA==
X-Received: by 2002:a17:90a:e547:b0:290:4140:1e43 with SMTP id ei7-20020a17090ae54700b0029041401e43mr396975pjb.80.1705701455437;
        Fri, 19 Jan 2024 13:57:35 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id db11-20020a17090ad64b00b002900eeada1asm4592473pjb.43.2024.01.19.13.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 13:57:35 -0800 (PST)
Subject: [PATCH] tty: hvc: Fix the RISC-V SBI driver for a refactoring
Date: Fri, 19 Jan 2024 13:56:13 -0800
Message-ID: <20240119215612.20529-2-palmer@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
  Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
  ajones@ventanamicro.com, Atish Patra <atishp@rivosinc.com>, apatel@ventanamicro.com,
  linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
  linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@rivosinc.com>
From: Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org

From: Palmer Dabbelt <palmer@rivosinc.com>

I missed the int->size_t refactoring in f32fcbedbe92 ("tty: hvc: convert
to u8 and size_t"), which causes the newly used ops in 88ead68e764c
("tty: Add SBI debug console support to HVC SBI driver") to fail to
build due to a

linux/drivers/tty/hvc/hvc_riscv_sbi.c:59:15: error: incompatible function pointer types initializing 'ssize_t (*)(uint32_t, const u8 *, size_t)' (aka 'long (*)(unsigned int, const unsigned char *, unsigned long)') with an expression of type 'int (uint32_t, const char *, int)' (aka 'int (unsigned int, const char *, int)') [-Wincompatible-function-pointer-types]
        .put_chars = hvc_sbi_dbcn_tty_put,

Fixes: f32fcbedbe92 ("tty: hvc: convert to u8 and size_t")
Fixes: 88ead68e764c ("tty: Add SBI debug console support to HVC SBI driver")
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
I now remember Anup pointing this one out, but looks like I forgot about
it.
---
 drivers/tty/hvc/hvc_riscv_sbi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_riscv_sbi.c b/drivers/tty/hvc/hvc_riscv_sbi.c
index 2f3571f17ecd..c08718be8e73 100644
--- a/drivers/tty/hvc/hvc_riscv_sbi.c
+++ b/drivers/tty/hvc/hvc_riscv_sbi.c
@@ -15,7 +15,7 @@
 
 #include "hvc_console.h"
 
-static int hvc_sbi_tty_put(uint32_t vtermno, const char *buf, int count)
+static size_t hvc_sbi_tty_put(uint32_t vtermno, const char *buf, int count)
 {
 	int i;
 
@@ -25,7 +25,7 @@ static int hvc_sbi_tty_put(uint32_t vtermno, const char *buf, int count)
 	return i;
 }
 
-static int hvc_sbi_tty_get(uint32_t vtermno, char *buf, int count)
+static size_t hvc_sbi_tty_get(uint32_t vtermno, char *buf, int count)
 {
 	int i, c;
 
-- 
2.43.0


