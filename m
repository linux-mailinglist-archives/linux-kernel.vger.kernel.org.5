Return-Path: <linux-kernel+bounces-50733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80B0847D66
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C851C2149D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AACD12D75B;
	Fri,  2 Feb 2024 23:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3XXlubJS"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00B212C7E6
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 23:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706918098; cv=none; b=aOKWHFzDIjuhORNLpO0EXOchHnZ9BcEmlPcXHVwrbaRBpYcIfdRu7v4zRWuKuZJa8EKGWmDBVXAL1B0/K7nYofFmzbX62dhr7GGFXTOjE6QPVPswp0pE9tJejyRlxeYCwjDML+muOjggVulbB2S4CKWFfaflVRmtemhGufVhv6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706918098; c=relaxed/simple;
	bh=EJLAQjoAaveZcHBafYijrvolB9ZWj2bzuPRUhvoIegQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NidT828gOzyRO2qi7//Sg4SjAYfMmKLPcxca+66yxaPXw+EiTgVed/ET4PID9QchxNid6+lAkDiLd8T3msOjEEK0wZjId/Lt33Jru/2EIggaQsUYA9yJWGGKlfSfCO6MkvmVpSpGmUO3+VAq7vps5uSu250c4zkN8MMEl07AB3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3XXlubJS; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d751bc0c15so22925995ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 15:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706918096; x=1707522896; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1MLhuldF93A/E3O+pm9/YZf3cQu2JpI7YOHHh8M+ks=;
        b=3XXlubJSvxYOqf0Uymbuxh1wvk8Hedjsvw/3DukfOsr8TfPOjWnWmeiMLhWxgKD1v/
         drHtrX50HfYZ6lDr2EE92oYHgAvi+2s86uJQheyieTu2ZZ9AK0ZYKdtWpdzdPBljOEZr
         544JVNT3X7df232VO283qCBOLWnMrom34T0egMmB2TxomLmYsKxq6Qgsg+iebUtjSt67
         HqwqanKSw5UA6Wx/rx+bQrv7qDekLlb+lqwaqOuaZPezrnqAue9vzDETObWgTnmozTtH
         NlBdeIT7EKGmxuCfcw0FXOSjpkMQgJAGAKZn3Qpy7SUMZRZJmOlX9QeSSbSeKttSY0Sh
         q0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706918096; x=1707522896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1MLhuldF93A/E3O+pm9/YZf3cQu2JpI7YOHHh8M+ks=;
        b=ZB3++9EUQ3K9K/HdgrZZCAWGFjKtn4xTayOg2Z40L3yen5/rmPvxjgDmJ5n1RPCrLc
         JWULxGwOcA+6Hg2ZJ7XRXgExEHva3anbpycxvs1u32vXHUPBkXCkQxuMd8YcasfxOLGw
         R9MwMxh0zHjbYtvacEkPQdOzl5rC3vubLt4VIBc8XeKQg1e4/naZ0G9KE1dVp/48fy4a
         lUkawGKvHcTqw5TqYieoxtUEYqZ4RR4cVEpQ+LYFWC8uLsnUHLrcZiK7ITVAWeu74pXw
         ui1d1rlkb0EIeqYjHO8amRY8P3oNYIoHMvpI68yP/Pg3EDBXEKdek5ErfYYlkJx4pJPg
         d2+w==
X-Gm-Message-State: AOJu0YzEeAH211rqYTL9mBPeXd9zQ96kujjZVwklSTgZa/kUhdn89xMM
	m282MF7rZi8Iiup2XWTVxYaeywVkSc5QWy/2WNkMuZtt3dWMz/cR8vBgKjEMmI8=
X-Google-Smtp-Source: AGHT+IEnHLkO32tQeIV/kkhU7yOafMeSu3lnsvbu9pYPIhhxQaTmXNS59xOikEhxTC0ZiRXCzzI1og==
X-Received: by 2002:a17:902:bb16:b0:1d9:7a79:c35a with SMTP id im22-20020a170902bb1600b001d97a79c35amr2200249plb.35.1706918096176;
        Fri, 02 Feb 2024 15:54:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWXRw1NDqFZj5R1OPn+mE5bcPhpsNgwjgE6bHW7KDP+lpfxY9uwZ4X1PpKnXjgcutHPAW7/V1cbJjc8baznAl/8B5GMjAFx78zCbu1+x+kc7EOesSZDlXdUdw0zg/dpcLGW3uoo9aBggOPILURQ9FvHsV1SlFPua43+txomnVGl//dA7WIBVJYygdJs8b7fiC8cja1KCesna0Tr1Qniy59mGsBEHpQKX+xSKF34KGwnh2xvS2i3ccBDMJAFy4fpBp7CN+Ra4lDi6lnpZmrZTwB7JtVeMn2VNWadSkTAsvhVRwih2bjoMLGubk/cm1egLYvutCT30w+qSQ==
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090282c100b001d8f81ece98sm2133607plz.104.2024.02.02.15.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 15:54:55 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 02 Feb 2024 15:54:52 -0800
Subject: [PATCH v3 1/2] riscv: lib: Introduce has_fast_misaligned_access
 function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-disable_misaligned_probe_config-v3-1-c44f91f03bb6@rivosinc.com>
References: <20240202-disable_misaligned_probe_config-v3-0-c44f91f03bb6@rivosinc.com>
In-Reply-To: <20240202-disable_misaligned_probe_config-v3-0-c44f91f03bb6@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Eric Biggers <ebiggers@kernel.org>, 
 Elliot Berman <quic_eberman@quicinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706918093; l=2638;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=EJLAQjoAaveZcHBafYijrvolB9ZWj2bzuPRUhvoIegQ=;
 b=PLwP0vQ99Z+7IGjRrd6DwcVhXXGqxnXdGfaaYbpjQXIm11Du3c0rwMO/IAoNkGCtIJCgwhfGo
 14cUsMbyb7LBWToiVkJFcuLp7tEVlDeIh2FEd6BBfXainkYwSh+K4RA
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Create has_fast_misaligned_access to avoid needing to explicitly check
the fast_misaligned_access_speed_key static key.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h | 15 ++++++++++-----
 arch/riscv/lib/csum.c               |  7 ++-----
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 5a626ed2c47a..eb3ac304fc42 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright 2022-2023 Rivos, Inc
+ * Copyright 2022-2024 Rivos, Inc
  */
 
 #ifndef _ASM_CPUFEATURE_H
@@ -28,8 +28,6 @@ struct riscv_isainfo {
 
 DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
 
-DECLARE_PER_CPU(long, misaligned_access_speed);
-
 /* Per-cpu ISA extensions. */
 extern struct riscv_isainfo hart_isa[NR_CPUS];
 
@@ -53,6 +51,15 @@ static inline bool check_unaligned_access_emulated(int cpu)
 static inline void unaligned_emulation_finish(void) {}
 #endif
 
+DECLARE_PER_CPU(long, misaligned_access_speed);
+
+DECLARE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
+
+static __always_inline bool has_fast_misaligned_accesses(void)
+{
+	return static_branch_likely(&fast_misaligned_access_speed_key);
+}
+
 unsigned long riscv_get_elf_hwcap(void);
 
 struct riscv_isa_ext_data {
@@ -135,6 +142,4 @@ static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsi
 	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
 }
 
-DECLARE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
-
 #endif
diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
index af3df5274ccb..47392a83239d 100644
--- a/arch/riscv/lib/csum.c
+++ b/arch/riscv/lib/csum.c
@@ -3,7 +3,7 @@
  * Checksum library
  *
  * Influenced by arch/arm64/lib/csum.c
- * Copyright (C) 2023 Rivos Inc.
+ * Copyright (C) 2023-2024 Rivos Inc.
  */
 #include <linux/bitops.h>
 #include <linux/compiler.h>
@@ -318,10 +318,7 @@ unsigned int do_csum(const unsigned char *buff, int len)
 	 * branches. The largest chunk of overlap was delegated into the
 	 * do_csum_common function.
 	 */
-	if (static_branch_likely(&fast_misaligned_access_speed_key))
-		return do_csum_no_alignment(buff, len);
-
-	if (((unsigned long)buff & OFFSET_MASK) == 0)
+	if (has_fast_misaligned_accesses() || (((unsigned long)buff & OFFSET_MASK) == 0))
 		return do_csum_no_alignment(buff, len);
 
 	return do_csum_with_alignment(buff, len);

-- 
2.43.0


