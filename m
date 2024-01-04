Return-Path: <linux-kernel+bounces-17178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6D4824935
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76BF91F23341
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C184E2C85F;
	Thu,  4 Jan 2024 19:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ippr5imp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7456B2C6A7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 19:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7ba8c218fe1so42871539f.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 11:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704397377; x=1705002177; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+J/P1s8879Vp+fzlyGqr2WWOHGZX3A10V1/imIkjd0=;
        b=ippr5impszhAyE88Isolx5kJ8Q3DYU3doweVByoLpHLaDLCFxasHH3aLGCZLMIjmkR
         xf9DAi3ztehOn2gSSrY1DMM5tUTjqN1+xpYzKcZf4ZF3dw5Zo2+3suKkhS+yxXOUy0Ve
         IW8yQYvfoXVvH3PRuN7QSAk1k9v0xcLMH0JQHKOozLY8Jwz7ACgQjBzTDuUXfMZqyRHX
         hQ2aea19lU0d+2vrJTktujzb3OpbL9S/PiOxSkQhPxGiMBrn2ATyKLsesv5mRs4WfRME
         AaBTOhRCMoI3qtZLJRJrJZUSyWcaBboH4HPXdygku8UimrmIObpRfzndKV7FcW2SrmGF
         ykQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704397377; x=1705002177;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+J/P1s8879Vp+fzlyGqr2WWOHGZX3A10V1/imIkjd0=;
        b=hd4shSdHAHxFGja8Gq1JX4wG3Duaus+RUgLau/g96M95yShOSGtb9dlPJKQLXDqhG4
         kDz3WLguLNrBQMcClilT0vrZB124S9eP33WGtk/jOYCg7N+I7yIXCkkpJ9KKOwCRrH9f
         B6hoPF79UUaA/RN44Ulr97kIA2epGDSN1/l0UFmBtn0o/89cv4zwWvYOJViZzvnWbnSZ
         NPTNup/8R5Yjdw0xeS3oUqCrimepZu9Kcl1USaZf48aX4ioSCjJvmPOi3tzexXgoUMbP
         yy2bHgR/YcfLguyvsK2orBMGNEvV8nAE8M2sm94N96zdLmNEvi0dvQLPYITbceImPet9
         urtQ==
X-Gm-Message-State: AOJu0YzrokgOhs7mVLNT/6QFSM/pOpdWNJDo4lIrIMrtgRyJ0TyFrgkU
	WZ1qjJFl+8wZpZbhb7VuZjM7bjrPW6tTGA==
X-Google-Smtp-Source: AGHT+IEcFdfob1Y4RZK+bTpddY/Z8yB4IPD/mUSajVsTBWGnio5958AQpFeVqy17OUHTBH8h9sJFng==
X-Received: by 2002:a05:6e02:b47:b0:35f:7d16:c92d with SMTP id f7-20020a056e020b4700b0035f7d16c92dmr934521ilu.44.1704397377439;
        Thu, 04 Jan 2024 11:42:57 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o10-20020a92daca000000b0035d0da89a0asm19606ilq.6.2024.01.04.11.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 11:42:56 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 04 Jan 2024 11:42:48 -0800
Subject: [PATCH v3 2/3] riscv: Correctly free relocation hashtable on error
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240104-module_loading_fix-v3-2-a71f8de6ce0f@rivosinc.com>
References: <20240104-module_loading_fix-v3-0-a71f8de6ce0f@rivosinc.com>
In-Reply-To: <20240104-module_loading_fix-v3-0-a71f8de6ce0f@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 kernel test robot <lkp@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
 Julia Lawall <julia.lawall@inria.fr>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704397374; l=2207;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=9/Y3gMnmhvp1aRf3YmkeyxHlGtG/ubuu7urxufGjwTE=;
 b=TmjQ+RDNWS877CIosFdTqru/YPzJhO1qbK90hdnM1iOCj2EuiBYwgA4iemJAzXyFiwoJGXHyh
 u7ieRn45cHtBbE8/eoFg2iQZWB5Lxtlqnoa83kDXjLsS1OHcL+boFcN
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


