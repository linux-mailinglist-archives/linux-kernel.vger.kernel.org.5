Return-Path: <linux-kernel+bounces-17179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E05824936
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D88B41C2227A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDFE2CCB2;
	Thu,  4 Jan 2024 19:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="t31Jxc6I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C83C2C6B9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 19:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3606ad581a5so2041095ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 11:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704397378; x=1705002178; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zwpW8R3xYRcFeijiUFHaM884VPc1V+tX+SXLWnbPyzE=;
        b=t31Jxc6IjDIDFuriAo29YKsXR8UshY8Ea20epAztUpL50/EIjoJhRdxFl+qaGaSJ94
         xFf5R0MWMeqIPpnCDJ64fFHmditFJbQuZ6vfkr622pixW1Y+12ogQUOEaD96+3pNw/A3
         ydU8mjfqkLV8nRitzO9F8Kp/PwAAibZqcWvE1pGXONNCGVQgzBt09pKAqaukSOK/74Ri
         X6LiRteCMfwFrTEnT5ET7U+JIm+BeHu0AN3nesadEa3WaQgZc/V2DfKmKHJEC1caWiat
         SfMA6EqYoHQNe6J3MEEXUmDEZm20FgynEG41Cg0yqC78oa+J5Cegskyq9L/Kcxuvd8va
         EdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704397378; x=1705002178;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwpW8R3xYRcFeijiUFHaM884VPc1V+tX+SXLWnbPyzE=;
        b=Gh9hirlbTGkkh3Fa+P7kAEq/iqlpfkfZ2YF4JWROV328jF8IsaE1lA6+LfX+pccUj8
         3nYUrUJkmvjWTLW9VKy9AiH0IDGPpchY79Q3QlGFcl7JiibJ8cY5FJFZ+JX+U9z1zdR9
         cuNElL2iJEZf36D6NBnMXH/G/Pu2pjiutv9LpHGKAf7JVB/Y0V4r6UkoQ/fBuakhAnMH
         IhTiZh7MYDis8l1krp/zVwLWUVwdShr8syMLyCvDLOkvbW4TnDcHviXAvjhqRAAFafTh
         btAKivjmfxTrjfy/8eaWRLqYXURb7rsOdRn+Y4ldiKjtB/FP2f9AvK+VuuEf0a2b/SNU
         aYjg==
X-Gm-Message-State: AOJu0YzVIi6I2th5O5ZI1YIvvoYzwdg9JGvgJPX6JBS+QWSdHphTEZsn
	RpcYPS2LTsLOxwSsuUJJ8XDMXzm/apFCtA==
X-Google-Smtp-Source: AGHT+IHT5RafxhxVkhoC7ZCG7auu1NWdb7RZx+i84274U3eQ2c8mka4bV5n112vi+aMJBdUfbRUZxQ==
X-Received: by 2002:a05:6e02:170f:b0:35f:ca3f:fa67 with SMTP id u15-20020a056e02170f00b0035fca3ffa67mr1224476ill.43.1704397378523;
        Thu, 04 Jan 2024 11:42:58 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o10-20020a92daca000000b0035d0da89a0asm19606ilq.6.2024.01.04.11.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 11:42:58 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 04 Jan 2024 11:42:49 -0800
Subject: [PATCH v3 3/3] riscv: Fix relocation_hashtable size
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240104-module_loading_fix-v3-3-a71f8de6ce0f@rivosinc.com>
References: <20240104-module_loading_fix-v3-0-a71f8de6ce0f@rivosinc.com>
In-Reply-To: <20240104-module_loading_fix-v3-0-a71f8de6ce0f@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 kernel test robot <lkp@intel.com>, Julia Lawall <julia.lawall@inria.fr>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704397374; l=1020;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=js9HmT4o7o8yl7lcSP3vcOE6sOgYhIQV9xZrhoMilzw=;
 b=oUTjSCnJ23EEXgoFiAFQOCyorLMnwVgQFC3OVXHU3L3GlTodRKu31Mb8jIU/r+O//70Beb63d
 HTFAbKyU+gjDCurro3YjGZ65fM4ysi2YV+LUAPTAIcM8RdGWr0teXfJ
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

A second dereference is needed to get the accurate size of the
relocation_hashtable.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: d8792a5734b0 ("riscv: Safely remove entries from relocation list")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/r/202312120044.wTI1Uyaa-lkp@intel.com/
---
 arch/riscv/kernel/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 32743180e8ef..ceb0adb38715 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -764,7 +764,7 @@ initialize_relocation_hashtable(unsigned int num_relocations,
 	hashtable_size <<= should_double_size;
 
 	*relocation_hashtable = kmalloc_array(hashtable_size,
-					      sizeof(*relocation_hashtable),
+					      sizeof(**relocation_hashtable),
 					      GFP_KERNEL);
 	if (!*relocation_hashtable)
 		return 0;

-- 
2.43.0


