Return-Path: <linux-kernel+bounces-160702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990778B4150
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A902E1C216A8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6452F3613E;
	Fri, 26 Apr 2024 21:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hAThJjbd"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A29436126
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714167430; cv=none; b=MN4zxjT4McMu5TkU9RwnHSOnTnH9j5r8ITrDPaPFfSClYbfBuyxHjIXzFDyYd+uquJyLB88sM1jg2Xat6B1+jkLqOQ+2ajlEBN6BHZpy4M5bx2/2aRYe5SIp2tfH0UHAKpCHNCqxHhCWB17BIBjGsJxaI4/ytRYz3vYSHd8UrVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714167430; c=relaxed/simple;
	bh=wcB/ebDhkfkPBVDQxoUt3AjUlhzpSXzz59SF5DkeLyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O21d+uAnAu0AC8J7MIONfDUzdmCeYsbPU9fKUrX+i4LNh9s2RlZRb7w89ICXiMU3GsUYpOV1o2wxv9RrGt3ehnD1ja4y4R6cRtlVwZ7HkPjgsCVHppxJriOqaOisuw0IDrmw34PAZzZOVgnwh/DHyKA+7We4FAM/3Xg9ZNWFFeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hAThJjbd; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e9320c2ef6so19435105ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714167429; x=1714772229; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bC8+jsiLZWKY+UGyCwiSu3stdoXyccUkl5+IF/7wAA4=;
        b=hAThJjbdzufjf6zis7Ev542chPEnh4fy37zYW0oiKZv7lmJifbM8xvMQdK4UtcLBC6
         xxpRNOeeTj37eSzUr1wjcY+9g4K3Ago+p7pIsZ1YavKbVBbTpjXVOtEdA14C8KIOSFQt
         dCfiI7Q/JhEkyFAymGTKmaLp8j0FPjxLTnzU/ba2he7KrGPTGiF0MGDCLJ6aIP8GsOby
         ZX+AJ50shtQlzg5HbHr7/cf20Rv5QAbT06NibR07t6YwWwPOUNzedNErb+T0Vpk65O+K
         xBrgdWWe2MVr4aOSuVe3paWRQIW/kI2KTGj9xOrFWJqxdixSl8gt24mI9Q+ovUvmLD+o
         Edqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714167429; x=1714772229;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bC8+jsiLZWKY+UGyCwiSu3stdoXyccUkl5+IF/7wAA4=;
        b=IBBoQ8XkNde/izE+yA7R672UZS/bBgxW9O4PCnOVd3Scfz+HVczlDS/6+0KI1KJ3En
         8zHYOWV+xAVvHLR1bZospsQ6it74Ii2kDZrfBXYgL4NPcIksQ3rtrMhHYGKliAZAjsGs
         SzZ7KoGgoLEjA9r8ZGe6EEh9T9tXRqAfSatFc4JK3LOc4oeBVSg2ew62mYCCVdNRiNXI
         X6ZDzCxbYrRPL7IpdcYf3nMAe7mycIoJuuAzRkxFbTb2/5JTIK/B6KBMrChDWo70pFwr
         0+HuW8J/dpyObL1QCDRooamRdGxav4xvptRNQMpPWCl0Zl9Ac86XNuJ6qN+ZYr7OFx+Z
         HG9w==
X-Forwarded-Encrypted: i=1; AJvYcCV8wKztG+TlxuRQxIh4enemxhXU/5VUWtXIGatgqhcubVH6UTtU7rRyha15DJlGsDLvWc7VmTYpcVwWxSLv9u4BZ72W3RO/y3AQfJfb
X-Gm-Message-State: AOJu0Yw8TSkzwuifsNZWwpFdymoJxqkiAIzSbxW0OFGL+PsaxORqlJSg
	Ru41IPW6vLCaJfG5+lF1AyHQR5xTt9E3Xh3bNS3BKLqDOfc/6Og5m0EiWCFlN+s=
X-Google-Smtp-Source: AGHT+IHl0deFI+kKqJJSXtEo4lw1f4JLDe4eTcjXBFfcgornPJnmm+jN4W99Vb/Ph2g2fe8Xsa+lCQ==
X-Received: by 2002:a17:902:f684:b0:1eb:51a4:3685 with SMTP id l4-20020a170902f68400b001eb51a43685mr382124plg.52.1714167428813;
        Fri, 26 Apr 2024 14:37:08 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id k4-20020a170902760400b001e2936705b4sm15935701pll.243.2024.04.26.14.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 14:37:06 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 26 Apr 2024 14:37:04 -0700
Subject: [PATCH v4 09/16] RISC-V: define the elements of the VCSR vector
 CSR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-dev-charlie-support_thead_vector_6_9-v4-9-5cf53b5bc492@rivosinc.com>
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-5cf53b5bc492@rivosinc.com>
In-Reply-To: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-5cf53b5bc492@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>, 
 Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714167425; l=954;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=C7F1c584ODJM4qF9TPT5kMoM8fDlOPYyEMw6010Mea8=;
 b=+Ym/PXnw1qoA/TfJUg74ll2FQ3kDna0sfz28N0zMDelkAV0Bsm9v3B7NR0DImwTgQCifbv+07
 7SqQy9BhbS9DwC8AiBlZXnX+89Wsr6daBED+F73ctZ18G6TF8mNQWu/
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

From: Heiko Stuebner <heiko@sntech.de>

The VCSR CSR contains two elements VXRM[2:1] and VXSAT[0].

Define constants for those to access the elements in a readable way.

Acked-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 2468c55933cd..13bc99c995d1 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -215,6 +215,11 @@
 #define SMSTATEEN0_SSTATEEN0_SHIFT	63
 #define SMSTATEEN0_SSTATEEN0		(_ULL(1) << SMSTATEEN0_SSTATEEN0_SHIFT)
 
+/* VCSR flags */
+#define VCSR_VXRM_MASK			3
+#define VCSR_VXRM_SHIFT			1
+#define VCSR_VXSAT_MASK			1
+
 /* symbolic CSR names: */
 #define CSR_CYCLE		0xc00
 #define CSR_TIME		0xc01

-- 
2.44.0


