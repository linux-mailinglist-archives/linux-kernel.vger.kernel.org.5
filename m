Return-Path: <linux-kernel+bounces-7219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C6E81A35F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033C41C248E4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6907947A5A;
	Wed, 20 Dec 2023 15:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Z6iYwN3I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1A14653F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3367659c42aso56509f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1703087864; x=1703692664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZT3AkmSaqumQ97ecuZBaz7B+rLb1J+xdw7pERlw1ck=;
        b=Z6iYwN3I37Qg/yMkxLLrsXU9Lc6aPdB6HSwmf6Sj+FcrCaOyiRLYpRlSyzDWEit8GD
         PfKcIJ4IIXvs2Kt/TvtH/u0xhg7dkXkvnqV98aSqRY02e40zClOqAIIw0klXQB13Hjh/
         /4tYyNCyfrq1IgHA6E8+G8dLUH/dIDySzFVYNKW48hxXNaRIK/R5jvph7qASCEJduP0W
         4hgHwPb6C/z2yy7SoOKw5iSdfXjxTg8Ev+p0M2BxrrDc0tFV/4EAJk4/csXZBCH0Tjmt
         iaMLIGKxwYXrh0JPQk4+Xm7BL7DZgOQYgvHWAd2dj9xKhkzopmF/CwGVlF8CBiyQj0/X
         KNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703087864; x=1703692664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZT3AkmSaqumQ97ecuZBaz7B+rLb1J+xdw7pERlw1ck=;
        b=qd1sY2tuyzG1y5aI7ZlUgJUrS6seiLd3I4eXGgLKdeYWGu0/INIQLpTWuEgy1Xy2uP
         byLs5D1xyCAoDTuzjuAzbZPcwWP1oV/8B7LefWRj9wiJGYPMDDtKeLghPfmo8AKoUQpU
         bunh9QTjlotqLV9Z1psrmfXWpg7dQUGl0ceUcoqkCByKBgkZrkq6slGvhsjDoaw42zyC
         TYOi25v+2KXU6pSXuCpC6LylfLcqWdOZPZ1YxdgueBSx0cM0qDegKLVSk0LsXLo0ZXLy
         Is1x7CLXjOf87ipYvLp8QNCRoKI+QpHROCaEZn136OnLxaOqoiTJi97ey8rSB0brUHu/
         +oTg==
X-Gm-Message-State: AOJu0YxvmvCb9r9qJ4IwI/PYuwjvd0lPnz2sLngAhnQ75I0otaFeJNiP
	3hdqu/Nx69QF0r4K+PVDbxEP/VUXZUUlI7urSeB2DQ==
X-Google-Smtp-Source: AGHT+IEAqrHN3Za66t0NZjui8EhChki4mQcTMIh6RZgm58ClLt3lfkny0M8iVRzoKzGcB9ZORNH4uw==
X-Received: by 2002:a05:6000:18c9:b0:336:5c96:a3c7 with SMTP id w9-20020a05600018c900b003365c96a3c7mr7715482wrq.0.1703087864600;
        Wed, 20 Dec 2023 07:57:44 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:3eae:b70:f27f:7aa1])
        by smtp.gmail.com with ESMTPSA id h18-20020adffd52000000b003366af9d611sm7279693wrs.22.2023.12.20.07.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 07:57:43 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Robbin Ehn <rehn@rivosinc.com>,
	Gianluca Guida <gianluca@rivosinc.com>
Subject: [PATCH v2 4/6] riscv: add ISA extension parsing for Zacas
Date: Wed, 20 Dec 2023 16:57:20 +0100
Message-ID: <20231220155723.684081-5-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220155723.684081-1-cleger@rivosinc.com>
References: <20231220155723.684081-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add parsing for Zacas ISA extension which was ratified recently in the
riscv-zacas manual.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 3b31efe2f716..34f86424d743 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -85,6 +85,7 @@
 #define RISCV_ISA_EXT_ZVFHMIN		70
 #define RISCV_ISA_EXT_ZFA		71
 #define RISCV_ISA_EXT_ZTSO		72
+#define RISCV_ISA_EXT_ZACAS		73
 
 #define RISCV_ISA_EXT_MAX		128
 #define RISCV_ISA_EXT_INVALID		U32_MAX
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 3eb48a0eecb3..9a9d915b5bb2 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -259,6 +259,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zihintntl, RISCV_ISA_EXT_ZIHINTNTL),
 	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
 	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
+	__RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
 	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
 	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
 	__RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),
-- 
2.43.0


