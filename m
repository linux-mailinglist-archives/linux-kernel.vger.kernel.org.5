Return-Path: <linux-kernel+bounces-126391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3AF8936B4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 03:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D811F20100
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 01:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69671362;
	Mon,  1 Apr 2024 01:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRddIT4U"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B9246B5;
	Mon,  1 Apr 2024 01:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711934515; cv=none; b=NeIYNxAFFTLUF9TXHoHOjOexr8q2bjCMBUI/G0R9LT28dEvP1JyXn0fCV+wOT18LPmlmbSytLSFzm+XIMgMN0KBWD7GKePblwEx1aJCTGpyjV+wKFxD72N0q+3unWSmIqE4xD7w0gKRNjD/UTHFtEBmcYxp6CykI5SOF/h+9GrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711934515; c=relaxed/simple;
	bh=0OWXMJ+nfoPG2U6D2lWpTASlzsVWSH/1XiZ8Ckg/xk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J9PAtSNXJO5R9s9z95Oy0whQCOk9Oa7i+oprw98MtAwSslnkrXcQLZgD96up8Wf9mlZi216kIUOMsZfx+V0X1qvAHohEBVwVg8nkDKJXxir8V8jQew30aKUzjttN3oEdauH9IFumzzbWSgiuBPqGMIqhLGucptcVbnAvP8tN4M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRddIT4U; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e0f2798cd8so28517525ad.3;
        Sun, 31 Mar 2024 18:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711934512; x=1712539312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWYvGOJqkm0rO3q3fSGDNrYx2gNWS9uAp/9tqY5SSZI=;
        b=XRddIT4UiYCGMszxW/ZHz9rXf4GIQfMwRuR92TLa+SVahM1c9d4dcIXl2Q6dlmN0VM
         Nrs0gSH44SaXz7KM5o4kWwBfUjaYGHWDgQVyAGbTXP9fEQAvj/MGiZhysIp9cVF/ROKo
         zXYeeAsTwCUZObvzsKFJiGNd3UskIIO4RJS57fOCsrUuU56P9gmjQHh5XfCy6mH84Ljg
         DDBtPYGydrHQVa2WKufhP3y0XgxoKGIC/1wqrufyyadfB/Smf+dx7nt9K7DXJ0snxOiU
         GSRWZJylQYqCRKNGPHJH6h4UPCslj/12sEPCdSW3hwn2rdBb/MUn1qIl8jWRsON1sJSt
         xQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711934512; x=1712539312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWYvGOJqkm0rO3q3fSGDNrYx2gNWS9uAp/9tqY5SSZI=;
        b=qKG1IHscb8Vp1xz69jvZyjFllojLvnkAWJYyFUJjAFUvft6bQga4Q2S305TQjVD6Yx
         l3P8xtQU34GTyC3OZOx+iZnTT5lT7i1fVjwkeBYQ1SZNo1b7WnzJn0mDqu9TIJPhn0pq
         M/TQOu8ItB1pmnFHVzZy/VdDQD6V+ayZkC6Wfzlh8TnbYh4Jhr6lCR7SPKo1TuN522ys
         lshc7dnS74sUJXduY0BK6OL2hbmUFmt+pRvueg5t0/PV58/NWCBM+PmsVfazAJez11Cf
         HKGKQnenMSNSYfnWfkupdxVVx7xt8H7wdmKwY3MaXrIuDLofBV5u6W3POkROxt/2467n
         1Srg==
X-Forwarded-Encrypted: i=1; AJvYcCWMl4zU49a3tNWbHUNc2nG6DOX0HNu65J9PfKY+mWa3nNiCnVyYq3IvNF3hXodgr6btDMRRL3R8O8mWDlbjs5Ws9o9BiYk+S/0YEYw7ZArGarQHuQvJtOIamfAU97U85YeLHA9nL0rk9fgKnVD2Gz9A13NCMQd3v3YaZo80SpcCfKk9
X-Gm-Message-State: AOJu0YwyY4zXpf+g0QdQPhNEFcVZ2nldRAmDJPVcyXNC9/9QnadRXD9t
	qJz53XL9HMUREwCGdt1HU3xJzKCXgy1p9A1vLzkgXZMR/wh00EnD
X-Google-Smtp-Source: AGHT+IGIaP1aI5nVaaLS4f5sE01hVUl8wsYNKqqxI7Py3TDT2Au5LWSTrc8zMJIiOKnUc+GJ6noKxA==
X-Received: by 2002:a17:902:ec81:b0:1e0:157a:846c with SMTP id x1-20020a170902ec8100b001e0157a846cmr8852375plg.55.1711934512292;
        Sun, 31 Mar 2024 18:21:52 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id e15-20020a170902784f00b001dde004b31bsm7694357pln.166.2024.03.31.18.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 18:21:52 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-doc@vger.kernel.org,
	workflows@vger.kernel.org
Cc: apw@canonical.com,
	broonie@kernel.org,
	chenhuacai@loongson.cn,
	chris@zankel.net,
	corbet@lwn.net,
	dwaipayanray1@gmail.com,
	herbert@gondor.apana.org.au,
	joe@perches.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lukas.bulwahn@gmail.com,
	mac.xxn@outlook.com,
	sfr@canb.auug.org.au,
	v-songbaohua@oppo.com,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v5 1/2] Documentation: coding-style: ask function-like macros to evaluate parameters
Date: Mon,  1 Apr 2024 14:21:19 +1300
Message-Id: <20240401012120.6052-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401012120.6052-1-21cnbao@gmail.com>
References: <20240401012120.6052-1-21cnbao@gmail.com>
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

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Suggested-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Huacai Chen <chenhuacai@loongson.cn>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andy Whitcroft <apw@canonical.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Joe Perches <joe@perches.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Xining Xu <mac.xxn@outlook.com>
---
 Documentation/process/coding-style.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 9c7cf7347394..791d333a57fd 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -827,6 +827,22 @@ Macros with multiple statements should be enclosed in a do - while block:
 				do_this(b, c);		\
 		} while (0)
 
+Function-like macros with unused parameters should be replaced by static
+inline functions to avoid the issue of unused variables:
+
+.. code-block:: c
+
+	static inline void fun(struct foo *foo)
+	{
+	}
+
+For historical reasons, many files still use the cast to (void) to evaluate
+parameters, but this method is not recommended:
+
+.. code-block:: c
+
+	#define macrofun(foo) do { (void) (foo); } while (0)
+
 Things to avoid when using macros:
 
 1) macros that affect control flow:
-- 
2.34.1


