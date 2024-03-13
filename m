Return-Path: <linux-kernel+bounces-101107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 615AB87A27E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 05:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7EE1F22CEA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997351170A;
	Wed, 13 Mar 2024 04:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhCBzKKP"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8401DD2FF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 04:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710305461; cv=none; b=WTGO1IZmyreIkNzxUf0bmGv6n+Uk32b6fqJpONmWoFTGHokJUhjGIK5bwlnUocmlYJe+eH9FG14Uf5ywh44A/alvP6VmEPJxYrH+xOAYT6ZIt6mxAHnwd8EA7Mfl8TTwxF7wUn6syAK+z80BhhFdcBo77vtTdvJU/QQPt4mOvfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710305461; c=relaxed/simple;
	bh=0up+P6357wxJnmhhj/1DSZlJcRMFmijD1DOSan59UjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kbVNz3M+frhFhmNA0SPmfTzpW1j4p7CyZXlJTobzhXSqL74nLNpqvjx9/IRSBYtaunh5yGUnbjfSLX4hmuqEBoWpCZxSjk5MjUbor7SPZfdBc+lrFJZ9PIY4pWpTYviQ3EWtSIuKYRLi6MddanI8a+8iXE5PFESFbuqKDXI9hko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhCBzKKP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ddcec424a6so1669005ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 21:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710305460; x=1710910260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lX/+Ue7KhlYC6XaU1gURwyGMaHqvfNR8b8K3j40yg4o=;
        b=lhCBzKKP10X6V/3AQawcvifUa/T0kVBQb0zxqdMhWA4oIqlxCeHPZYDm7Ezo2/Hc6l
         zrBnpT/AOmox/eeSpQa/LP77s8WJrHQILjfFTkrD6rHlv0iK6MgZLBLY1Mnv4JmHTQZO
         lC839kI9U+D0xzoOHIkQb2mG32Is3VcBVQj/jjLirpL3T8rvr4dzj2om+PWWHlduDacA
         4jbCulh2KlwvSj5qUOaCUJzX07juGXTXrMx4fIFAR+pH+KoaeIVUjm51emjQLefUhM6A
         ASMK/NxJ01bB+9Sah2d/KLCAZkNrbBZvrNKlUQkCOqxBWMk06sNhsK1Le2gXmEaRdnNn
         D+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710305460; x=1710910260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lX/+Ue7KhlYC6XaU1gURwyGMaHqvfNR8b8K3j40yg4o=;
        b=c+2TtFcDW5KKnMbauL3QreFxL/odZDaEY/xgDp8ePL7F5iw3q04eop6TLpyKd/kOfI
         Y09wmWbVMkpjdsQFH9OBwuWTz+hTIW6qrXKv99U5ebdi/ClCT7Dagmi0pDI1QItf3oVl
         9b3OXniXSe1dQoIj8YxKbncLtPYx4VhzVCJ1zdH71wy693hD4RTsNLz3Mcx6womedNFJ
         XRkxTpxla5nfWpOrrn1CTFa3Gdt4jG9R/5nmck2ZlhizpLI5MO2kFWW0B1jNJzZedtu0
         SCoLFk5fh9U/tqH3fjeHsmCTWGg6GhLKpHR5cYdZtdu3eLwh/1Rqcv9ZHRyhF1GffF4J
         1Bbw==
X-Forwarded-Encrypted: i=1; AJvYcCXJPYEBgAaWlNzZsEPJbbJDe9Qoo6dwWQnE2Te0HDn59PpykHqxv0E+h1PD5U9LEaaftPH3IQg7tcxhs67BygyqyOh3UI5nDkL12zqj
X-Gm-Message-State: AOJu0YyHV8v0i4FqfyjhgWwalCtGg9ag0yq0KsSCoA8PmnUuMXLYHDOp
	POAFhNt+vMt4arTXr/9TBchMl0ch+Nbhd6RwnFC+ytmnNAbp2/JH
X-Google-Smtp-Source: AGHT+IHzGfnFPh27B4vzRj/ILZN2KVbQLVymFQL5DCr0U1MvzHrEXMv6DDFDywZLeeTjQhPwtn72bA==
X-Received: by 2002:a17:902:ec92:b0:1dd:7119:d7d9 with SMTP id x18-20020a170902ec9200b001dd7119d7d9mr12054203plg.8.1710305459687;
        Tue, 12 Mar 2024 21:50:59 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id u11-20020a170903124b00b001d8f81ecea1sm7617467plh.172.2024.03.12.21.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 21:50:59 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	chris@zankel.net,
	jcmvbkbc@gmail.com
Cc: willy@infradead.org,
	alexghiti@rivosinc.com,
	rppt@kernel.org,
	dennis@kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] xtensa: remove redundant flush_dcache_page and ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE macros
Date: Wed, 13 Mar 2024 17:50:36 +1300
Message-Id: <20240313045036.51065-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

xtensa's flush_dcache_page() can be a no-op sometimes. There is a
generic implementation for this case in include/asm-generic/
cacheflush.h.
 #ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
 static inline void flush_dcache_page(struct page *page)
 {
 }

 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
 #endif

So remove the superfluous flush_dcache_page() definition, which also
helps silence potential build warnings complaining the page variable
passed to flush_dcache_page() is not used.

   In file included from crypto/scompress.c:12:
   include/crypto/scatterwalk.h: In function 'scatterwalk_pagedone':
   include/crypto/scatterwalk.h:76:30: warning: variable 'page' set but not used [-Wunused-but-set-variable]
      76 |                 struct page *page;
         |                              ^~~~
   crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
>> crypto/scompress.c:174:38: warning: unused variable 'dst_page' [-Wunused-variable]
     174 |                         struct page *dst_page = sg_page(req->dst);
         |

The issue was originally reported on LoongArch by kernel test
robot. And Huacai fixed it on LoongArch, but I found xtensa
obviously has the same issue.

Cc: Huacai Chen <chenhuacai@loongson.cn>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202403091614.NeUw5zcv-lkp@intel.com/
Closes: https://lore.kernel.org/all/CAGsJ_4yDk1+axbte7FKQEwD7X2oxUCFrEc9M5YOS1BobfDFXPA@mail.gmail.com/
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 arch/xtensa/include/asm/cacheflush.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/xtensa/include/asm/cacheflush.h b/arch/xtensa/include/asm/cacheflush.h
index 38bcecb0e457..11efdc8eb262 100644
--- a/arch/xtensa/include/asm/cacheflush.h
+++ b/arch/xtensa/include/asm/cacheflush.h
@@ -144,9 +144,6 @@ void local_flush_cache_page(struct vm_area_struct *vma,
 #define flush_cache_vmap_early(start,end)		do { } while (0)
 #define flush_cache_vunmap(start,end)			do { } while (0)
 
-#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
-#define flush_dcache_page(page)				do { } while (0)
-
 #define flush_icache_range local_flush_icache_range
 #define flush_cache_page(vma, addr, pfn)		do { } while (0)
 #define flush_cache_range(vma, start, end)		do { } while (0)
-- 
2.34.1


