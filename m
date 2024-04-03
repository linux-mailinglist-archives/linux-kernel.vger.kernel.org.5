Return-Path: <linux-kernel+bounces-130698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D54A897BC1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5383B28B020
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC88156999;
	Wed,  3 Apr 2024 22:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAmF3Ogf"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECFC692FC;
	Wed,  3 Apr 2024 22:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712184208; cv=none; b=sicLEL2OyNnNih6FS+parjrI3yyeEzk105TM0yj1l2CDtiejgxb2bMORLfgEWb6pr6Mnb8azy47Y77qL8zc6cNiIegNTiRYGlaWtuGGIC84Pua/4b59MJBf0DlQCC4TL6q8wmDawJCZxJsRehlTr4zsSjetkD0IifmlCnrKMqOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712184208; c=relaxed/simple;
	bh=VM7uBtgDykOSCEFvxGZTHdHh834Ycngh2ZDz0aAHDjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oN8gi5izh2EeLYLoKMEM1tzhecD8H6rjop2W7aSncNj48YV0GBUK5Y8vCPEPNbLeIHfwQVNYiRDJ163AFlunJClAAvvBcU5DMO8X43Z6/WZGJMfBWbg2aWl5ercLyOV/edD3zUbN+V92shDd5JUIMCUAJFKPyAhY3Y5ny8iP+Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAmF3Ogf; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-22e811c1b8bso205046fac.3;
        Wed, 03 Apr 2024 15:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712184206; x=1712789006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1yoif+153AIw3iNaB4BG80MPHwUmzwez6HYhpKPz5Y=;
        b=PAmF3Ogf7JMSnEsKU5+AF9HR+VZxGl51SV4KvJOyyY9UBOjeHTGcpHRwYGmZU2Ffgv
         cR7UNnSqE0a2DNy2PezeqPVyoit9Fl7NDBWK/G8IsD1emHyJvjuIz1E2ymt/711TlUII
         ttdL4Td1BaPR7qpPmVx9w2vrPua1ltGBWQFmIZQ63X8a6vApIy5RY5NmNRnVWvyMuSr4
         DPpnqIMp0P7jAlEz5jOKpZLPavQTrlUkfygc+XkhCXsT0IQ0DLYY4lNWJCtpdDkHsKea
         lqCwZpQNAASlHvhUV0jGvwGe7uW8H70HiJIskN+Gsubqf3vCzYcPMqVxxzlujdCr7lo/
         VVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712184206; x=1712789006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1yoif+153AIw3iNaB4BG80MPHwUmzwez6HYhpKPz5Y=;
        b=es0ySRvsm8jPL3RNp7PdCGrg6TB3fgVOs4Wix6devmjhaGImfYWQYjU9yghm96qJmp
         PTEfvn6C7/eDaxF0jVoqKlVYaJVjSg8b/eJVAh4ivp63556lrag4sC3THIJU3HL4Ko0Z
         HFaq+RSQaC+b6O3M6Gc9i455dgoa0UJTwph769JeN30xj/4CIVnrl9b72f8/5uAv1Ypa
         T3TOKhwnHF5HD2raMtRj/8UvN8kGpEmFtFLI4S09+bRMHWFc34MC09j3ykarHouTq5dg
         QPhLCp7n2WjoqC3N2qqw0VCxmzbmC2XnO40hmXIF1hsAM0n0Y/CnXOiMVAkQ4QozPP1Q
         y82g==
X-Forwarded-Encrypted: i=1; AJvYcCWVRfxts+c3OUgxosS2n3VvWltiOJUBRBlvhpUQcEf1eDtx8PkAJH5unEYdu1SkQ5DwohTjzv1RRM5oANCEuhXevXSrHYUuXFGbPHn0mndlCB66Lrb3RWM4FYrdeGpVBYCAtx5iIyZ3HZeTQIo8pLt2D5mYZMitL09UXkTVldRyl5YT
X-Gm-Message-State: AOJu0YwOWlvxbALv8gv9tDlCw/qBXUNr+l61ySIqnnijsmrE04qeIRsT
	AaqwhT1dF1dcFY6KWDR8eOCsVWnJBMvy8J3lB8j+cvTUNzy+gPpR
X-Google-Smtp-Source: AGHT+IHljjRdXxyxUyWjPxf+9fNMiE9Z7dJHeuBaySgDHVwW/Sh05VzxU3JcWj3J2BksqTvbNd7bPg==
X-Received: by 2002:a05:6870:184e:b0:22a:8e3f:f6d8 with SMTP id u14-20020a056870184e00b0022a8e3ff6d8mr906275oaf.26.1712184205999;
        Wed, 03 Apr 2024 15:43:25 -0700 (PDT)
Received: from barry-desktop.hub ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id 13-20020a630b0d000000b005e840ad9aaesm12184383pgl.30.2024.04.03.15.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 15:43:25 -0700 (PDT)
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
Subject: [PATCH v6 1/2] Documentation: coding-style: ask function-like macros to evaluate parameters
Date: Thu,  4 Apr 2024 11:42:53 +1300
Message-Id: <20240403224254.10313-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403224254.10313-1-21cnbao@gmail.com>
References: <20240403224254.10313-1-21cnbao@gmail.com>
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
Acked-by: Joe Perches <joe@perches.com>
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
 Documentation/process/coding-style.rst | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 9c7cf7347394..7e768c65aa92 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -827,6 +827,29 @@ Macros with multiple statements should be enclosed in a do - while block:
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
+Due to historical practices, many files still employ the "cast to (void)"
+approach to evaluate parameters. However, this method is not advisable.
+Inline functions address the issue of "expression with side effects
+evaluated more than once", circumvent unused-variable problems, and
+are generally better documented than macros for some reason.
+
+.. code-block:: c
+
+	/*
+	 * Avoid doing this whenever possible and instead opt for static
+	 * inline functions
+	 */
+	#define macrofun(foo) do { (void) (foo); } while (0)
+
 Things to avoid when using macros:
 
 1) macros that affect control flow:
-- 
2.34.1


