Return-Path: <linux-kernel+bounces-141898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342EE8A24D9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E31842818C1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52619481B3;
	Fri, 12 Apr 2024 04:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mA3Pl28C"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5FC45976
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712895111; cv=none; b=NzKgt+45Q5We9BxYgT+CUq8HQ6CHz1aUEwVsyMbBEzDO1SwTkriIHa/A5eOJ9yJ5sHYzo2aTKLscPBKXlVMCzCfqqCDJcs/zEwlfbJqpv9EfPc9FkvWU/Q3foGac2zTwfaeFPqTwcBx26AaF2MgltYHHGU9jKcdg8oo7kN+QsOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712895111; c=relaxed/simple;
	bh=AjSOqPvk8pDaNRWNo6bJjXE2EKHaQE5Z9yM7TIyqWv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WCsq2yBOceERFLfI7lpdUladKN5LRboAy25GT3Oo6AgcUrtO74UrELK3GNnVvzg+eI3sW1pgUOnfdE1bcqrA1eQh6MrQUZ5isnhNPW2WoxUvfw24UfcruS4zzSEVmCAkbOfp0dox5Ipz0BO/JsQ8d0X7ZU8kzOglX1ESPG1nrxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=mA3Pl28C; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6eced6fd98aso524815b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712895109; x=1713499909; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMPIuwt6cMnmpNq4lu1wiuX0ZLQRNI3Tbplv0ws9fgg=;
        b=mA3Pl28CT8NuF/dXG/B0k4PUWziefvhQy0bOI7zuAcXus97EBauwJbS2RDiDcsXiPO
         o/cc9qW4zJcKQ9B3k+/zxALQscSmf4oUyR4MDL7r4UNsx52lFWsM5c2aLVoOAQNrXuG9
         yD9YJB9yoyaIKhph9E2yEuSyROU8GDanrImwaTni+h4iaIP9/j8deB1DPhr9/ogUVBJw
         DGpmEJFn2zXD3vifFibFOe7uinwitldps9BEpG14AvEEgA3cwp04WJY5fW4G6WtjEDm8
         Jc/iDfwcdEe7NTHAumHj0mW2qE5umfI795IZ9B7sT/F4Wk7lySqN95f99jK4r/ZR90CZ
         nofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712895110; x=1713499910;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMPIuwt6cMnmpNq4lu1wiuX0ZLQRNI3Tbplv0ws9fgg=;
        b=aG1Y3/qsbn26g0Fr2dZfvxDRnHOBHCb6AVad5bFq5OWxBm7JGAEv/Zu23gtanBk0zv
         P/ix58BsoUfwG+KEH1VDPn6V0BvdKco7F0qOpw9K6KlFnAL8OjT4SCnamnmgpAA3ee56
         oUdqQpfTExFvTbKNZyFpizjM2ekEnIBvTlm9OIiLq79+6qXgJSqIv5VeBWZ/aD8SYSSU
         NKRatJ4JPc9VC1/PPGocGqbmUlYRwgqC3ZyomleH1NtNOgQ4HsRYZCEtFIR1+5+iHWe3
         l0WK705zw7DWGLJl83lD87Nk7eyZdLwF+ZyWlOQwP1J437dE/J9S2WWHsW7j8ieLSLqC
         qBQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgl9cp8oxNC7yLzZTYL7p90ZtSwBqzD7AlyKlwUUiGb4foBk1dx5nwrTrsMDCE0qyLkHaGPflle7pfFbB1ZZlpA0kdKAu64P0QUJBM
X-Gm-Message-State: AOJu0YyTNHIeQb3RWsHhvnVWUXZl8I9+fBopcWwlUvDxrig2QEXaE3oL
	aIWCGi3hojuUI2OutVN6XXCKJNGw2UJFYV+2owzOB/Z/ACRIbYGYp3EXc9QLICw=
X-Google-Smtp-Source: AGHT+IFCzy27N8mqtHUrUbUr0RUPxfjDtDbiINOHTo2v+uHwsCX7URxkFsS+GECfOE3fQY7tSLC35A==
X-Received: by 2002:a05:6a00:3d0f:b0:6ea:b073:c10c with SMTP id lo15-20020a056a003d0f00b006eab073c10cmr1638560pfb.6.1712895109632;
        Thu, 11 Apr 2024 21:11:49 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id ka13-20020a056a00938d00b006e57247f4e5sm1949712pfb.8.2024.04.11.21.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 21:11:48 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 11 Apr 2024 21:11:15 -0700
Subject: [PATCH 09/19] riscv: uaccess: Add alternative for xtheadvector
 uaccess
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-dev-charlie-support_thead_vector_6_9-v1-9-4af9815ec746@rivosinc.com>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
In-Reply-To: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
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
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712895091; l=855;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=AjSOqPvk8pDaNRWNo6bJjXE2EKHaQE5Z9yM7TIyqWv4=;
 b=rLdA0uDN/4SuDsKaNkE1B/5EQ3+8RUn38NFVGd7zgF1hdVuMZ9rnFvU8oAtWxXhpoFvN3XcS2
 AwLpS2uv0ZdD7oPmFrJym2AWAe7fYoEjhePpIuQeP49tGq9DoLHJSQU
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

At this time, use the fallback uaccess routines rather than customizing
the vectorized uaccess routines to be compatible with xtheadvector.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/lib/uaccess.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
index bc22c078aba8..74bd75b673d7 100644
--- a/arch/riscv/lib/uaccess.S
+++ b/arch/riscv/lib/uaccess.S
@@ -15,6 +15,7 @@
 SYM_FUNC_START(__asm_copy_to_user)
 #ifdef CONFIG_RISCV_ISA_V
 	ALTERNATIVE("j fallback_scalar_usercopy", "nop", 0, RISCV_ISA_EXT_v, CONFIG_RISCV_ISA_V)
+	ALTERNATIVE("nop", "j fallback_scalar_usercopy", 0, RISCV_ISA_VENDOR_EXT_XTHEADVECTOR, CONFIG_RISCV_ISA_V)
 	REG_L	t0, riscv_v_usercopy_threshold
 	bltu	a2, t0, fallback_scalar_usercopy
 	tail enter_vector_usercopy

-- 
2.44.0


