Return-Path: <linux-kernel+bounces-15973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C68B682367A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BC3A1F24772
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A171D6AB;
	Wed,  3 Jan 2024 20:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="FLV/hZyk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E561D52D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 20:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d3f29fea66so45576105ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 12:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704313325; x=1704918125; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+J/P1s8879Vp+fzlyGqr2WWOHGZX3A10V1/imIkjd0=;
        b=FLV/hZyki3DS42L108bYaVqELfYGcoo38cDngIFDoqnBaGHXW8JJH/KAZlPL+gqC+q
         ROkTAoHqB1Jd6qRDW1VEcWVjrz6pRBcM/HNiNSH0uXRK7izlEFaTozPsXBOdLbu5kiEp
         R1N9/tf9C+hD2JHLitFdbfmNcs/En99/rKKoK7G8WEApCBWxKyTIkvZem9P0khVsIZYR
         5HW8cFILBXlYKvQGxXzfjgGHYF3tjsIxdI0ojDJ3Fpdrxu02I/INzW0ugGI6OEW+yhZO
         bfYbpSKF+g8YUaQ6lUU4y0i46+uxCe8P+iKIef7lh8euEA/MfkOcE3t9JJuhyQ9IcK3K
         pDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704313325; x=1704918125;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+J/P1s8879Vp+fzlyGqr2WWOHGZX3A10V1/imIkjd0=;
        b=rMtSniqRx39s254Q8nV6QZF4IEVbfbi+h27L+W+wPYxV3/lzneW/1D3GFv3AMIKsKr
         Sn2KSjJaSf4r7vyc6pQ5bSGJgelSdB/Q2b+47uL/beta3r/uwC6Svu/fLtU+5xvofsoH
         7dFd8kGW5qhzVY389BaW8Ev/s5kewsEJNNvF9kBigQvkqZY5yhsM5ez7IT/m4mMhC4KN
         4o5u23Gglr9BUfS5dq2G/j8n6S946v0nvBRjeiOnptznQ4Mf5h0irTI/dayo2zc01AXi
         vdWKskun8webuB3VAY6yVZ8UVK6NuCoZM0t7uzr9xN4FJfPlvqRtwlzgG+kk16+m2vdI
         uytQ==
X-Gm-Message-State: AOJu0YwtpZT2gHbcMS/FgqBHok5g1ldoE0uhoHvtmlZlUxuz5htqJMS6
	NF+d4CLCiuMiOzanqY/OdkcxIc1pY4l7Bg==
X-Google-Smtp-Source: AGHT+IEDrbgjgNBUvvv9hWVeThqI6ijQ3EA3FWsa0h7uYxJIJYCUwnKf8WIXdqpmv94uscNsjpViJw==
X-Received: by 2002:a17:902:da81:b0:1d4:c2ad:8ff8 with SMTP id j1-20020a170902da8100b001d4c2ad8ff8mr2710218plx.34.1704313325161;
        Wed, 03 Jan 2024 12:22:05 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d13-20020a170903230d00b001d3fa5acf71sm24278739plh.12.2024.01.03.12.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 12:22:04 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 03 Jan 2024 12:22:01 -0800
Subject: [PATCH v2 2/4] riscv: Correctly free relocation hashtable on error
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-module_loading_fix-v2-2-292b160552c9@rivosinc.com>
References: <20240103-module_loading_fix-v2-0-292b160552c9@rivosinc.com>
In-Reply-To: <20240103-module_loading_fix-v2-0-292b160552c9@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 kernel test robot <lkp@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
 Julia Lawall <julia.lawall@inria.fr>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704313322; l=2207;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=9/Y3gMnmhvp1aRf3YmkeyxHlGtG/ubuu7urxufGjwTE=;
 b=oEe24hSZfsF4mLEENjvlrgBmLszzS6CujSYHcb5xYW5WEK65TSlLI3Drvqi0xuE88wUYf0yle
 tAaS12iJPF5DN1hbXifh/mprzWl2DKH2wdFUJ5myCBMAR510KON/qKu
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

When there is not enough allocatable memory for the relocation
hashtable, module loading should exit gracefully. Previously, this was
attempted to be accomplished by checking if an unsigned number is less
than zero which does not work. Instead have the caller check if the
hashtable was correctly allocated and add a comment explaining that
hashtable_bits that is 0 is valid.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: d8792a5734b0 ("riscv: Safely remove entries from relocation list")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202312132019.iYGTwW0L-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/r/202312120044.wTI1Uyaa-lkp@intel.com/
---
 arch/riscv/kernel/module.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 21c7a773a8ef..32743180e8ef 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -747,6 +747,10 @@ initialize_relocation_hashtable(unsigned int num_relocations,
 {
 	/* Can safely assume that bits is not greater than sizeof(long) */
 	unsigned long hashtable_size = roundup_pow_of_two(num_relocations);
+	/*
+	 * When hashtable_size == 1, hashtable_bits == 0.
+	 * This is valid because the hashing algorithm returns 0 in this case.
+	 */
 	unsigned int hashtable_bits = ilog2(hashtable_size);
 
 	/*
@@ -763,7 +767,7 @@ initialize_relocation_hashtable(unsigned int num_relocations,
 					      sizeof(*relocation_hashtable),
 					      GFP_KERNEL);
 	if (!*relocation_hashtable)
-		return -ENOMEM;
+		return 0;
 
 	__hash_init(*relocation_hashtable, hashtable_size);
 
@@ -789,8 +793,8 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 	hashtable_bits = initialize_relocation_hashtable(num_relocations,
 							 &relocation_hashtable);
 
-	if (hashtable_bits < 0)
-		return hashtable_bits;
+	if (!relocation_hashtable)
+		return -ENOMEM;
 
 	INIT_LIST_HEAD(&used_buckets_list);
 

-- 
2.43.0


