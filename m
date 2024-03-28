Return-Path: <linux-kernel+bounces-122324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B6D88F537
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57E71C2509A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F9925776;
	Thu, 28 Mar 2024 02:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjR78QTJ"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405B82D044;
	Thu, 28 Mar 2024 02:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711592519; cv=none; b=NBHbkjUGDvkA/1WckwcMkY0TnBFcuPmTscWvZBMTT0dwpdWr8q45TY2Mcj6ug9i8eZTtyakmVHo8oPyUCkxD87SXrTRJp2pVtjZYd570HnrsptpPJfCFottrI7L7VvlyXWjezFxTZsbVOHG/RHOJe0d7/ABK7dHHaetgSTRv/YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711592519; c=relaxed/simple;
	bh=0OWXMJ+nfoPG2U6D2lWpTASlzsVWSH/1XiZ8Ckg/xk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uJ+mwdPeeN9P5fnQS/aDXF79dZ9Jss0WbtBPrjjhZZwGOeAYJHZx/Q7xj1zDzVjEoM2OCjgJ1ftKE1VW3PTNpgjxtulh/orSUyg9jR+oRl3aell85FTPRMvHvpU/jLHjWQe0bwd7hnU8c1Hz64ULL4D6t7zuy7zRjHN5uNCF2WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjR78QTJ; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bbbc6b4ed1so281522b6e.2;
        Wed, 27 Mar 2024 19:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711592517; x=1712197317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWYvGOJqkm0rO3q3fSGDNrYx2gNWS9uAp/9tqY5SSZI=;
        b=WjR78QTJ1z5lk8bYreCbxsWoKiMgtKnSGdx9qPb5LVk7XWHxzudMpCb3wCCInoawVs
         JQWsNjb+TIXXUbmduWC11kemIdgzMlc39tKkcX/T2MrBTL/A3utOJCCwuGTpAggN1+Do
         R0RqgTfVrD3GwhIx1qkCOokYpNewOZ2teBBuGy8Ht0goELAkmSuo97nOduiJgsb58eMS
         ubtB0Ag+ImB1WsMPDrPRyl2RcnVxxo7SKU6QqhBBONR5uVdFLhQchWzDW2NHE46Mcqvp
         VfpRy1LjKQXi00+NrdWHZuFSpx9K5aih/G0lxaz65EBrJ1AJe8LaOS4cNWuJTcb/xS8u
         MHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711592517; x=1712197317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWYvGOJqkm0rO3q3fSGDNrYx2gNWS9uAp/9tqY5SSZI=;
        b=Fk5z46NG6aZjmT3janIvTSHUl+/58FifQSqYn/W/qvtQBMvbcLM+TlmGGKHDsbtEcg
         Tgk3MiyK4rNek0RbQhZF6FWBK0kSBcYzAF/u54fP4hdtojb7vWWxf6bmSIw2xwYb98CT
         Rvkw3jATakbZIh/Z6KFbmz0A+OTvC5c61etw1PIM1cG/hJu/RXsQ+OzMjDjHucZ0XK2L
         4MGg4IVcsAFPOIfo2Ebh9CAs+ySdFcMvRbMMkEeD69eunZFVnyO2LQioqfj5qC8cTLbz
         UlJvUL41an4Ua/2pvcWtOR/VlBKVXqS5kW6pkGS506ptLBXuCWUa9I/8Q6kGgaBhNK4I
         Bf2g==
X-Forwarded-Encrypted: i=1; AJvYcCWZfQ9ICC5u36fYeppvhtBH8xj5ay4tRQX0iDBcltLHHWmUmLW7xQqtemd7D843vrq3qN35YB/AiCbmPiH8vCg202RKzoKHfVTTgpFtNQFs8avmtSRWD5+Kbq9TqsbNCI7atlSSmf+EPa5NqLgp3nQHCE/ppef/9K0ytCwrLngcia8L
X-Gm-Message-State: AOJu0Yy+lJjExchnCDd62EyVjMaBFFx6qPqTnwXv5DzJSAyj4xoxsONl
	GAuPgb1XczbFnRa0mds8m2mzN6II5QoIMegBmcxoXs8r/jMdp1v7
X-Google-Smtp-Source: AGHT+IFhwoy74Mxg39SWizFElCkR1ejnVAQv+qYEHIVeLmh2VAGr8OMFtTu/ylf16PmqsRapf9IAlw==
X-Received: by 2002:a05:6808:1211:b0:3c3:e61f:dc03 with SMTP id a17-20020a056808121100b003c3e61fdc03mr849830oil.33.1711592517335;
        Wed, 27 Mar 2024 19:21:57 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d26-20020aa7869a000000b006eac233f5c2sm228113pfo.127.2024.03.27.19.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 19:21:57 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-doc@vger.kernel.org
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
	workflows@vger.kernel.org,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v4 1/2] Documentation: coding-style: ask function-like macros to evaluate parameters
Date: Thu, 28 Mar 2024 15:21:35 +1300
Message-Id: <20240328022136.5789-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328022136.5789-1-21cnbao@gmail.com>
References: <20240328022136.5789-1-21cnbao@gmail.com>
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


