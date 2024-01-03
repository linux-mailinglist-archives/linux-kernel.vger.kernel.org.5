Return-Path: <linux-kernel+bounces-15976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDAD82367D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077291F23B1E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3031DDDC;
	Wed,  3 Jan 2024 20:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="So4npkJ4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE30F1D6A5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d45f182fa2so56410265ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 12:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704313327; x=1704918127; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EcPZp/8DlGxkljJ2IULxF796JgdWAzcJATDANUPFHbg=;
        b=So4npkJ41GmU4sK6gZvgfKT6DgrLFhP1EmmXbRBj9NV0kRWFVAFpcgqgcqgHSQQCIo
         LZIDiUlzKJgyq0B6GI1ihtSGHJduvk7s/3tyELsbVoU9WizlNOoAVMwdwqQDW6B94pP9
         U8pI/793ONLMWAIljC8/nNm3hYGfJCjTNprhX2+LME//f0443SKOaPN/Q3nZERhwqJmE
         xGAvcrnwD4hCRm8RSAieFfn92rORHMZK8KCJRiCaF1X1f4vTSbUqvn6KNW98938qDzuR
         NyuWLeZxCLxQhLa+qP8yV9spDwKxPE4tVFTJpUHOqOUwTYcRdtItG9nt4CZd2BJ3FMu4
         Qghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704313327; x=1704918127;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcPZp/8DlGxkljJ2IULxF796JgdWAzcJATDANUPFHbg=;
        b=kxKIh2D5qUEKKMbnED6X/T2+/ptbh2y8HBM1aIGzUchpRXOyPnQeqbHlpdCPWx3c9u
         fM6QeC9wx5B6rkLSYglMu1UWvfCK5mcJctdgMikCZFnLhmKJQiiCSkCGIhyVjKWxAAqr
         ElyMic5cK1boAICzDsxD1aN+TJtzWrZcF2eNWTBL7DdtquM7wLYMXyFyJjMlfCtEMcVY
         Yq9/mOjwmRzUAy0YjrDw06oXP+OKT6qYE4mVgUo98CsM+ppi3eij4HiwxlxyQIJ7NGTh
         AVinae0cf9Pt2qmgOByHoC9hdw6OWB98+ht5raCCVktCH8Dtgi93KHRnOhbvJCXlGP0L
         r7hw==
X-Gm-Message-State: AOJu0Yw9QkOA7Y0kCD7zcfhXGFkWk/ShtHJKwT+9AQJ9oXHN4+9cfc63
	mbsO+VmEvatUb4g0WqS+W3JfkZchtHDz3w==
X-Google-Smtp-Source: AGHT+IHcWutJo6xSTujomFEKk6dSK8nUjnWN4ho0sIQ5KDgWpHxK2VZNM4O1sbbudAJfyt88IVHcOA==
X-Received: by 2002:a17:903:98b:b0:1d4:d0e8:f9d2 with SMTP id mb11-20020a170903098b00b001d4d0e8f9d2mr1463670plb.93.1704313327127;
        Wed, 03 Jan 2024 12:22:07 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d13-20020a170903230d00b001d3fa5acf71sm24278739plh.12.2024.01.03.12.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 12:22:06 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 03 Jan 2024 12:22:03 -0800
Subject: [PATCH v2 4/4] riscv: Convert relocation iterator to do-while
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-module_loading_fix-v2-4-292b160552c9@rivosinc.com>
References: <20240103-module_loading_fix-v2-0-292b160552c9@rivosinc.com>
In-Reply-To: <20240103-module_loading_fix-v2-0-292b160552c9@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 kernel test robot <lkp@intel.com>, Dan Carpenter <error27@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704313322; l=2036;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=/ulcCnMFIkQarQGjz3X7NHIbZYgPXF/TzHke91JiC70=;
 b=2fwTTwWMrRHS1yLamkUKZvd9RFwXcDTwRTA8f+jCiAzGbZeyRz8gSU1eE+TKXv6+1XNA9u1WE
 i2oJi82DcH9AhH3z6euJBaUPy3PMy9P/+ZV8YT9MxUbCORDtooywt6E
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Use a do-while loop to iterate through relocation entries to prevent
curr_type from being marked as uninitialized.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: d8792a5734b0 ("riscv: Safely remove entries from relocation list")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202312130859.wnkuzVWY-lkp@intel.com/
---
 arch/riscv/kernel/module.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index ceb0adb38715..581e425686ab 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -633,15 +633,31 @@ process_accumulated_relocations(struct module *me,
 					  bucket_iter->bucket, node) {
 			buffer = 0;
 			location = rel_head_iter->location;
-			list_for_each_entry_safe(rel_entry_iter,
-						 rel_entry_iter_tmp,
-						 rel_head_iter->rel_entry,
-						 head) {
+			rel_entry_iter =
+				list_first_entry(rel_head_iter->rel_entry,
+						 typeof(*rel_entry_iter), head);
+			rel_entry_iter_tmp =
+				list_next_entry(rel_entry_iter, head);
+
+			/*
+			 * Iterate through all relocation entries that share
+			 * this location. This uses a do-while loop instead of
+			 * list_for_each_entry_safe since it is known that there
+			 * is at least one entry and curr_type needs to be the
+			 * value of the last entry when the loop exits.
+			 */
+			do {
 				curr_type = rel_entry_iter->type;
 				reloc_handlers[curr_type].reloc_handler(
 					me, &buffer, rel_entry_iter->value);
 				kfree(rel_entry_iter);
-			}
+
+				rel_entry_iter = rel_entry_iter_tmp;
+				rel_entry_iter_tmp = list_next_entry(rel_entry_iter_tmp, head);
+			} while (!list_entry_is_head(rel_entry_iter,
+						     rel_head_iter->rel_entry,
+						     head));
+
 			reloc_handlers[curr_type].accumulate_handler(
 				me, location, buffer);
 			kfree(rel_head_iter);

-- 
2.43.0


