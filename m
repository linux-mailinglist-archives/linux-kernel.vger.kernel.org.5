Return-Path: <linux-kernel+bounces-108432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D61880A72
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 05:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2BAF1C213B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 04:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1046E12E48;
	Wed, 20 Mar 2024 04:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rg8145UC"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E140E17548;
	Wed, 20 Mar 2024 04:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710910069; cv=none; b=tG1vpZfwbAn3mkZqZOr0Vgoy66iFZS9utx96rxfJt8W/WOkdgdG/Ea3ii6Sq2/umbbDuRQUndJkJyNBiD1ASyHNUgiBc0Fs4Laj+UNzA0OD9tHrFxDqFMyW2kUh3t1swZjXOQRDNwVcabmkN+jWbsFR5ZgF6H8BzrFA1iNrjJhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710910069; c=relaxed/simple;
	bh=hZ9LI06WzRxbiXskd40G3Xe6ctWb+KfDJG0pwUMm4Go=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qvk/VmaPK3ltLQgbv5qs1mTnqfu6C5gNjNAxdFPUKSSGYPBZjVT/2f9D6lQZU3/HGe3qFrzmvI1XbxqizYcG5nS8jR96cwklWOJVrwkxZmP4a8rk8CPlXreDpQLQ0D1SWPKP5peNzoYKVd9CpuMlaU02O05HtBQSGKdrXqhSwiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rg8145UC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dddbeac9f9so43576535ad.3;
        Tue, 19 Mar 2024 21:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710910067; x=1711514867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tPbVgKP5amVDL/H/263LqoT3iBwntJ5V0hOrQ9MDAog=;
        b=Rg8145UCUBjkO6IwbgLYQHAj8ugQLIr3FEktTPRYtuUdYZPDYp2JeGt0wwSWnaXd1f
         4Yo3JP7Kf+JTEB5gftnQDdomw4LdM6pVbObwT7Z6N6QeNCsUBvEBaIf3qHZUddid+CAl
         PmUsLDbHjWXo2LUvajLD73lGU0vmvxBfI2cLPH6+j5mnJAJ6o77wHIMlGoFKdX/oIhbM
         YznjCi3wqq9XD8Ef9wqpyOouBQBfxAdZEj92k6TkQ2B0HTNRsvf+RHjStiaz0ExeJENK
         VtHpuz3LmZ9+Y8Z7zkVhTRv1CfpM9AYDBIbYnAfGhs8jG0Yx9+1oUwjkLbZ8UM0mnewW
         cZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710910067; x=1711514867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tPbVgKP5amVDL/H/263LqoT3iBwntJ5V0hOrQ9MDAog=;
        b=PBEF8qjcbei42U/eF63ecRZrezqfiqUNDmomldgql3fGjdt7lc0h1YDNzgPN1NKYq5
         GBuvklsla8YrjWglfqxzW2npkvYx2Sb4PZBL+KFphKaX2J0UGlJpBhA8UXc3/oI//tHb
         YrIufTS7Nj/aZU6qaWwlWsG3umEe11t2KuwfoQbrvd1DH4nV/g/Z9yE4gNvMHYnAk4dZ
         hGzCn/JVoQX65PalE0KyEmA4PjuxFwf1nNRAgaUqskKdDBaX2LcE8mjdnMt6HQq6jWD8
         aGzqYDGd869Fd4sVoydS3PTcSvnu6NhnKLZDmizwusFD+UBaljWy2t54a76fsNgsmd4T
         mdfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJI2EfgFqIg7lbjhU0FHcHlf4mVs2Jw19A3/Vc7oWyMXV/8dZ2F/m7MYeJGvyLAuUfLjCnt6yAIlkUkXIYphlCa2OuN2YTdeffHsqnAJK3l/T+P4am6t88bFz2Nsn5e9BhmC2W
X-Gm-Message-State: AOJu0YyiN7JhmnjEVeW/+glE0LXLYMab0OkHF0/g76P9Bw14qZlp/BAm
	AqZ1yIxa7J2R6mrMPS8QFgVOZbW4xAhFRqyzuHuFLs+HeVZmUHaM
X-Google-Smtp-Source: AGHT+IGso6XBduOtcsH7U/USd2uKswTE1mCfzG3kKmCcfr51IIK1twuTt76wlTTL1BidriRzSEwLTg==
X-Received: by 2002:a17:903:2450:b0:1df:df4:73e0 with SMTP id l16-20020a170903245000b001df0df473e0mr15298929pls.4.1710910067045;
        Tue, 19 Mar 2024 21:47:47 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id p20-20020a170902ead400b001dddcfca329sm12396465pld.148.2024.03.19.21.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 21:47:46 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: corbet@lwn.net,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Zankel <chris@zankel.net>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Guenter Roeck <linux@roeck-us.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2] Documentation: coding-style: ask function-like macros to evaluate parameters
Date: Wed, 20 Mar 2024 17:47:28 +1300
Message-Id: <20240320044728.20313-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Recent commit 77292bb8ca69c80 ("crypto: scomp - remove memcpy if
sg_nents is 1 and pages are lowmem") leads to warnings on xtensa
and loongarch,
   In file included from crypto/scompress.c:12:
   include/crypto/scatterwalk.h: In function 'scatterwalk_pagedone':
   include/crypto/scatterwalk.h:76:30: warning: variable 'page' set but not used [-Wunused-but-set-variable]
      76 |                 struct page *page;
         |                              ^~~~
   crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
>> crypto/scompress.c:174:38: warning: unused variable 'dst_page' [-Wunused-variable]
     174 |                         struct page *dst_page = sg_page(req->dst);
         |

The reason is that flush_dcache_page() is implemented as a noop
macro on these platforms as below,

 #define flush_dcache_page(page) do { } while (0)

The driver code, for itself, seems be quite innocent and placing
maybe_unused seems pointless,

 struct page *dst_page = sg_page(req->dst);

 for (i = 0; i < nr_pages; i++)
 	flush_dcache_page(dst_page + i);

And it should be independent of architectural implementation
differences.

Let's provide guidance on coding style for requesting parameter
evaluation or proposing the migration to a static inline
function.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Huacai Chen <chenhuacai@loongson.cn>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Guenter Roeck <linux@roeck-us.net>
Suggested-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 -v2:
  * add comment about the approach of using a static inline func,
    thanks for Stephen's comment

 Documentation/process/coding-style.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 9c7cf7347394..9e0507af6253 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -827,6 +827,22 @@ Macros with multiple statements should be enclosed in a do - while block:
 				do_this(b, c);		\
 		} while (0)
 
+Function-like macros should evaluate their parameters, for unused parameters,
+cast them to void:
+
+.. code-block:: c
+
+	#define macrofun(a) do { (void) (a); } while (0)
+
+Another approach could involve utilizing a static inline function to replace
+the macro:
+
+.. code-block:: c
+
+	static inline void fun(struct foo *foo)
+	{
+	}
+
 Things to avoid when using macros:
 
 1) macros that affect control flow:
-- 
2.34.1


