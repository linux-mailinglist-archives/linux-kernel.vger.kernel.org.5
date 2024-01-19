Return-Path: <linux-kernel+bounces-31100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F7E8328D9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F18A31F246BC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCDA4E1DD;
	Fri, 19 Jan 2024 11:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CZxqI0Bd"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368454EB58
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705664109; cv=none; b=C16a2airERKybCjr7LgZsjCeESWHIpp0v407Wd/pO7SFOuGjAZGf2MMK+8/2aQWScSLw/tne/3ggXFWU2v6Kan+ajLIsbT+wMgexigW81CkmaXAlpl2WBe6800rzMfG4traw7UltdtpEyt3vZAJ1Uro68ly2dKxknv+H4nc6XU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705664109; c=relaxed/simple;
	bh=C5iRWOaVPvgyoKC+hI5XbA0WdGNDbqEUa5o2YyeO7Ao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ud+A6NAlC9xeCjqtnffd/4j0LRFrw0Gd5yEgOcF8A1+zlyOIFV7xq01lHewF98L0OQCLOk7V0X7EjRRK7xHRxXrxCRQt+6204ciMzHpt/n0TsZKUpb81k/xYOv7LxCxt4VLND///s6KayGydeyKBYyZpsIf94JfIumj+Qi607Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=CZxqI0Bd; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3606c7a4cb5so3291085ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 03:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705664107; x=1706268907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k38gzzXnRwc1LG01yYkdNKX2/4JudjETsypjyCoA1oc=;
        b=CZxqI0BdDTcoozSkR/a28LpSgR1gpMw5CRIoktrw+Zto+znxGyybJXV/utBlAoWCT1
         00oUQIfDtL4AGaXcmUa7Npz7nEo2fXU9KxToFA1bSnRvoRhp0XUmlTqfk3u2alw6ho9G
         u1wzteojoyKQEQlaO+QeoftlHWXAD2Q6xAeNNXlDQlH6CG/HCHs+8AOmR/b5y+GWouoG
         Vat48JJ5CYA/AHtJM7M63K+QRf463r9pRwjOzUFQGamAe/+bN9P9/M2xgF5SeEYWwBwf
         r1ZQo+cgXsD9C8Xfmiuo8VFlbchkS6xjWyzUr/ITUbYqn1EboaumF4nkQqPgZV3wCNjF
         5qMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705664107; x=1706268907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k38gzzXnRwc1LG01yYkdNKX2/4JudjETsypjyCoA1oc=;
        b=Vcs3V/xQVD7GYm4y/Xzzjpie5UIhiINmddLjjKgl8ktMyTfVWowJsU4boWxE0WWN+T
         /boV0PyFru1TqrATsrmqrmPGuwzF/sAlWXUekDymZmdtJwkqow/OE0WVf48BBmJ6qrk9
         yCUQx7ne1JDCHs54ELjiYxL9vN7evzloTuFH3xeGcT5IiqASbo0oi3HI0i3mVU9MaJ+n
         s7RTEq05OuOqOs7UfWEQFNDqIrTy9Ycw5aDrNfzvOiXRFLygI6v2XgG6xM+6zVzZX6sQ
         N/e3R2xFNwJ6MEetaKJbFEt0NgxZo1KACxIg+5JfD4RzK2UJqw2JgBXgXZopSAUO64fT
         C7Ww==
X-Gm-Message-State: AOJu0YwQEKH05ETa/JVawWwkMVAQCEtVtLw9t4OcTg0jSSR2vdhc9RR8
	72OPiodGces6zogx+UBW6dVHbpE7FQ8XnIwBb4oGTy9RX795BE8QdoluVJSB5K4=
X-Google-Smtp-Source: AGHT+IEFgxqp4c4BSC1SH5cF+VnXZrlQYZRwfL7NLGJ+2lwsht4p33YhmsPE8cnHExWItmf7lq/Yhg==
X-Received: by 2002:a05:6e02:80a:b0:361:981f:5b32 with SMTP id u10-20020a056e02080a00b00361981f5b32mr2364278ilm.123.1705664107212;
        Fri, 19 Jan 2024 03:35:07 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id a5-20020a92a305000000b0036062f40c51sm5347302ili.71.2024.01.19.03.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 03:35:06 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Conor Dooley <conor@kernel.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v6 1/5] RISC-V: Add stubs for sbi_console_putchar/getchar()
Date: Fri, 19 Jan 2024 17:04:45 +0530
Message-Id: <20240119113449.492152-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119113449.492152-1-apatel@ventanamicro.com>
References: <20240119113449.492152-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The functions sbi_console_putchar() and sbi_console_getchar() are
not defined when CONFIG_RISCV_SBI_V01 is disabled so let us add
stub of these functions to avoid "#ifdef" on user side.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/sbi.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index b6f898c56940..e0a8eca32ba5 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -288,8 +288,13 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 			unsigned long arg3, unsigned long arg4,
 			unsigned long arg5);
 
+#ifdef CONFIG_RISCV_SBI_V01
 void sbi_console_putchar(int ch);
 int sbi_console_getchar(void);
+#else
+static inline void sbi_console_putchar(int ch) { }
+static inline int sbi_console_getchar(void) { return -ENOENT; }
+#endif
 long sbi_get_mvendorid(void);
 long sbi_get_marchid(void);
 long sbi_get_mimpid(void);
-- 
2.34.1


