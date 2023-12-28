Return-Path: <linux-kernel+bounces-12450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4B481F4F7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A977283957
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 06:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4026A611F;
	Thu, 28 Dec 2023 06:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSlMQYwa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C485666
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 06:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5918f11099dso3659707eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 22:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703744312; x=1704349112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rxIMVwBZrQhRU3eW4BYKC5oEBepRYtQLNSUTCCv8Ceg=;
        b=gSlMQYwadcqeIvx77BArzkLXF/PhoQvr3culKXsYIQ02JIqKTkz9dNKbQtTc4ylxtC
         XfzVYYXfPeQ9OP5LewDOrySqa5GgHQAwrD6NRgd6HQXKvn5isUI2RlkPXTLcH/Fnf8ga
         915Y2DuDawCmJtm2K9a54/olQcxALhLPzOXywPNwOuqExu7FXBD+Kh3nXvc6mQzq/oMz
         ZLSwC065cV7bj2trflPX+NUyO4qjQvJAxSzqW7EeAiEVKu6KwyrZkIQ7sWUiTJlr1t/T
         ySciw0DWM1t0p1T7VzMZ5OWm1llZjeXp/EH6+3DRNvq4M8Mxj6kpm43zTr/IUMv3eCWX
         et5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703744312; x=1704349112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rxIMVwBZrQhRU3eW4BYKC5oEBepRYtQLNSUTCCv8Ceg=;
        b=UoJyeONTzq7RN/VTw6eVm8QGmm2RcO8NkF9sXd2vb7hHdAFyc5xojgVYicUTmHpNiC
         F2CwTu7pPF2bVN2dXiXqh+TnpPkqlOdce1CFqoEr9iGG9Isg+uQCpgKk0oEypEDQ1wDn
         IjaeuHTUz0BN5II4fxel9n1TraeGhLNjoZ+D8J6US8AA4AU8wI01z8TukJK2Yd++Td8A
         yZ42Z+cfJzaF0i7CQRtPE3TiSoIxvW28GGFk1GkOJtyMuc8xt26GxIrittCF9DdK9bMb
         8/o5vTYP3k4HDZHh7C6njmwv3ltwVAAqB2BoI0odeCzcB0+MbIeeFJtrQmx43NsksigU
         rSUg==
X-Gm-Message-State: AOJu0Yw6hLvcBrZpqzk/Jwfm4vH3+ehp433bGJ4dy/WnM2JcSK/NodmT
	c/QfstcYrPItEgSy2TUYhgg=
X-Google-Smtp-Source: AGHT+IG+tTX6f1WO1cX43T6fpNmhAI3s17KwA+gQJPqBhzslegV4HyvyiGw2dLxLWXGZIUxSLVgzyA==
X-Received: by 2002:a05:6358:99a8:b0:173:227:39bb with SMTP id j40-20020a05635899a800b00173022739bbmr10415388rwb.0.1703744311997;
        Wed, 27 Dec 2023 22:18:31 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:29f3:58d2:d37b:3e03])
        by smtp.gmail.com with ESMTPSA id le6-20020a056a004fc600b006da0f15b31csm1611011pfb.97.2023.12.27.22.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 22:18:31 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
X-Google-Original-From: Barry Song <v-songbaohua@oppo.com>
To: minchan@kernel.org,
	senozhatsky@chromium.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	ddstreet@ieee.org,
	sjenning@redhat.com,
	vitaly.wool@konsulko.com
Cc: linux-kernel@vger.kernel.org,
	chriscli@google.com,
	chrisl@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	zhouchengming@bytedance.com,
	nphamcs@gmail.com,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH] mm: zsmalloc: return -ENOSPC rather than -EINVAL in zs_malloc while size is too large
Date: Thu, 28 Dec 2023 19:18:02 +1300
Message-Id: <20231228061802.25280-1-v-songbaohua@oppo.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the case the "compressed" data is larger than the original data,
it is better to return -ENOSPC which can help zswap record a poor compr
rather than an invalid request. Then we get more friendly counting for
reject_compress_poor in debugfs.

 bool zswap_store(struct folio *folio)
 {
 	...
 	ret = zpool_malloc(zpool, dlen, gfp, &handle);
 	if (ret == -ENOSPC) {
 		zswap_reject_compress_poor++;
 		goto put_dstmem;
 	}
 	if (ret) {
 		zswap_reject_alloc_fail++;
 		goto put_dstmem;
 	}
 	...
 }

Also, zbud_alloc() and z3fold_alloc() are returning ENOSPC in the same
case, eg
 static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
 			unsigned long *handle)
 {
 	...
 	if (!size || (gfp & __GFP_HIGHMEM))
 		return -EINVAL;

 	if (size > PAGE_SIZE)
 		return -ENOSPC;
 	...
 }

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/zsmalloc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index b1c0dad7f4cf..c937635e0ad1 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1364,9 +1364,12 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	int newfg;
 	struct zspage *zspage;
 
-	if (unlikely(!size || size > ZS_MAX_ALLOC_SIZE))
+	if (unlikely(!size))
 		return (unsigned long)ERR_PTR(-EINVAL);
 
+	if (unlikely(size > ZS_MAX_ALLOC_SIZE))
+		return (unsigned long)ERR_PTR(-ENOSPC);
+
 	handle = cache_alloc_handle(pool, gfp);
 	if (!handle)
 		return (unsigned long)ERR_PTR(-ENOMEM);
-- 
2.34.1


