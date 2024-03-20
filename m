Return-Path: <linux-kernel+bounces-108259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED18B88087A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D2A2843A5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C75101C2;
	Wed, 20 Mar 2024 00:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIZVGkWp"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C77F9CC;
	Wed, 20 Mar 2024 00:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710893836; cv=none; b=m8hb8j4fevTjUSIYcjMGChVx6NrZS2siFkvIBjewOOysoso1i3HaaH61OnTulYH4BizC9I/TWjOXIG6F6hfFaViVio39gGWvOwGzO14VW0iZ8mkgr7ZUA8GrNq8QQoPo+H0YgNAWlb6Rpr2BfIFasBDVGticM7Tf4oUBG+U2mq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710893836; c=relaxed/simple;
	bh=VdoFpvA7x+42mN3b3PxvQ8HMy1WtS/Ev7hI1DtopmG4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MwuOduDyn/5gzphPkOSyG5Lk/rb20o3Xb0IHNRBsQLQM2SWa81p+m2NWEqsue5mxEbcHc+ktnmQpnYzNgYW0HtKa2YiFZr11SxXpZPHAjH1ceB4dZ+8Cyq2JCO+YCNbWP9s7ntaxd2Wnz1zKG95FguTSmXTn5UoTZqUnFlxffU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIZVGkWp; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e6b6e000a4so345489b3a.0;
        Tue, 19 Mar 2024 17:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710893834; x=1711498634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ewnx+qqOLD+CDSGBLXyslpAmGrwWU9vAAEvXADtuxMQ=;
        b=DIZVGkWp6myshvcxlhIBjdUs2mQ3jLq9S3/a+dfR3Zk3N6AJQpAMHwpmZ5kvmFQbD7
         iOp9FyZZoH/JluqsFg0FFOxT7fPDJNJ5VplRTEdxI+iatb7TJ2sbQSq/bo/rVB6bf06/
         XbvlGV4fx4AVZOQRMHrqN1OP3R+oxyEwiCwj8hd4IXx8dTZh0BKbSUIBnYhugc7nd59d
         3EQqq28gHF8K+LL10AAEnUFM+fo7kBeaXU9vkBDhD1kswkwxoEHEZya8nJ5b3GSPWL86
         x0PkoenLl5KRaJb/CKN1oDakiNEOuwU25piMnJp9DZrpPFENWJGPOoSuldjXtmvPQSaF
         /HYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710893834; x=1711498634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewnx+qqOLD+CDSGBLXyslpAmGrwWU9vAAEvXADtuxMQ=;
        b=ceDAKej0ovsckX0N/tjQoRAQXXckV/uyJklK11fMPj7/2RX/F/auX+yT3TYGn1QKKn
         Qua1v/HpME4bvdTNVX6wYpsj1dFR6ZM1fLd5D1lHScH1RvioNByFeCNmVMTIv3s1KYJx
         T2Sa24nPwUc9+cvmCOyKul9dO5cGwAIr1WfHVARDc6SIHu14mPEmhTAa8hFQOBtwARse
         I15ZCccTlW+MQTunTH/iTT87mbKQs1Z+nk2oOpmKwUc6h5fwl7zY/+IVJkEU5qRQQk8t
         qmjveL3FFaPSXBYiXSPf35c/psjrqv/i1oqyTpNaoMOl4q8DIMObBLx+sjqp7dyJkBCh
         xNKA==
X-Forwarded-Encrypted: i=1; AJvYcCUq2Oa8yYG4ydkghkfCeahhhc/q6+cy63m67i+QFH5oarFvE/lgiz19OhQEAu2ZQNSK4nDhTNDOE8KaW/S+/I3P5nSC49Z2GQIEhxUdjRgeGsyd18dAm9C0kX8jnYqBIiDPPJ2+
X-Gm-Message-State: AOJu0YxMaMjS0N0ZheAzodvvIcfNw0SXSghPlJjRSyxi4DEdxlhevVGv
	DsUhJsJ/svR/HIYFViDht2re4ReVb2O0m/+kF+Ps/BREWL1l7OA4
X-Google-Smtp-Source: AGHT+IFkw8SANeE+hvamksbiwMcerGQRkxwrCnaGIK3IcsW/cgQhZrncfPk6XuMbaMzseVpwBi9mkw==
X-Received: by 2002:a05:6a21:150c:b0:1a3:53ee:ce07 with SMTP id nq12-20020a056a21150c00b001a353eece07mr1240313pzb.28.1710893833766;
        Tue, 19 Mar 2024 17:17:13 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id ks11-20020a056a004b8b00b006e647059cccsm10357007pfb.33.2024.03.19.17.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 17:17:13 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: corbet@lwn.net,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Zankel <chris@zankel.net>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Guenter Roeck <linux@roeck-us.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] Documentation: coding-style: ask function-like macros to evaluate parameters
Date: Wed, 20 Mar 2024 13:16:56 +1300
Message-Id: <20240320001656.10075-1-21cnbao@gmail.com>
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

Let's have a guidance in codingstyle to ask for the evaluation
of parameters.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Huacai Chen <chenhuacai@loongson.cn>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Guenter Roeck <linux@roeck-us.net>
Suggested-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 Documentation/process/coding-style.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 9c7cf7347394..8065747fddff 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -827,6 +827,13 @@ Macros with multiple statements should be enclosed in a do - while block:
 				do_this(b, c);		\
 		} while (0)
 
+Function-like macros should evaluate their parameters, for unused parameters,
+cast them to void:
+
+.. code-block:: c
+
+	#define macrofun(a) do { (void) (a); } while (0)
+
 Things to avoid when using macros:
 
 1) macros that affect control flow:
-- 
2.34.1


