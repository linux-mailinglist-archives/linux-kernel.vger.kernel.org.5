Return-Path: <linux-kernel+bounces-15187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 756CC822815
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10544284E4D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 05:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64A117998;
	Wed,  3 Jan 2024 05:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apGR11sO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE08217981;
	Wed,  3 Jan 2024 05:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so2598546a12.1;
        Tue, 02 Jan 2024 21:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704259913; x=1704864713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8EF56Awke+XwfA1XTbGHCbaLEHxvYXZLhOGAQUZsss=;
        b=apGR11sOMq6u20+w6xkuQ4lKTed96tmES1x2XNEmRQ55c0FpTmqu14NWLHRaOUDh1d
         aGN3gytnviMA4KQ7ABowX6zmcIFp6dpIy5lIfr+81pC30gVwziv1zX7xCBMA2QNZTEyU
         GnjhW1BLDAhj+cspztEcMVGV1KHS+e5UBKhhpYCCJCe0uId2Nx/emsS1K87ytKzFnvoy
         ayxQRuni0RKeVENPXo95cQj4sPkT2q/fDIO+AYzaAR6xcO6QP4dFwlUV9N8DTAoBJvbE
         WWHdQ63Ntgn4ryBV0dQXHtX0HRhrdoBkaC90mvaOHd9qMhNTq2G3y7G08ukVzTXcY+Cn
         imkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704259913; x=1704864713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8EF56Awke+XwfA1XTbGHCbaLEHxvYXZLhOGAQUZsss=;
        b=CIsnuvIA09NqFIrWZI0YyRftmDMIJTUoCIHxwRj2BE1Cjtj674u698tC8hrF8L/O1U
         RTsn0+Kke8P7XVSjquK0pm7PStJ9zreKurMXffcNdnEmvHr+uH5PlA5dnKdc63MXE1pG
         J94O/3DUAsnVn86Oh7w4aJzRCXxw6Ks8yNfQVMg6ANWD0/NnQY+vyc2zpkpwNdEnwDeb
         0rpdMyyMFDYvfflWGnCpI7bapaZ9qTGCEN0BsV30Bv6dqdsWc/ykA+pU7n5Xpew/ba9k
         40Ie+4K1elzNUqWV/oswzeC6wFND1irk+TUQ2xNaMfzOzvM2CId1EXaQjuXQ5yiwHMQq
         2tmw==
X-Gm-Message-State: AOJu0YweV0QzqOd6L0Tbn9HeCFr0gIYcUnHmy9+l/IUxPiZIY3x82l9H
	dHSvq6K5ROzm3Yl22/Q4dZI=
X-Google-Smtp-Source: AGHT+IFCc/wIV6TxJsUS4zh9doG+Bj0rfKw5jQPtBPmClb1Odv3n75NqVqKfTtyxMLF8C2LcHTND4w==
X-Received: by 2002:a05:6a20:7291:b0:197:5045:d299 with SMTP id o17-20020a056a20729100b001975045d299mr1568700pzk.76.1704259912854;
        Tue, 02 Jan 2024 21:31:52 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:a7d6:f37a:9130:cd96])
        by smtp.gmail.com with ESMTPSA id 4-20020a631244000000b0050f85ef50d1sm21303808pgs.26.2024.01.02.21.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 21:31:52 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	zhouchengming@bytedance.com,
	linux-crypto@vger.kernel.org
Cc: akpm@linux-foundation.org,
	chriscli@google.com,
	chrisl@kernel.org,
	ddstreet@ieee.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	nphamcs@gmail.com,
	sjenning@redhat.com,
	vitaly.wool@konsulko.com,
	yosryahmed@google.com,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH RFC] crypto: scompress: remove memcpy if sg_nents is 1
Date: Wed,  3 Jan 2024 18:31:34 +1300
Message-Id: <20240103053134.564457-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5aff3bcf-ef36-45b3-8ac0-a4b19697419c@bytedance.com>
References: <5aff3bcf-ef36-45b3-8ac0-a4b19697419c@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

while sg_nents is 1, which is always true for the current kernel
as the only user - zswap is the case, we should be able to drop
these two big memcpy.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 crypto/scompress.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/crypto/scompress.c b/crypto/scompress.c
index 442a82c9de7d..d1bb40ef83a2 100644
--- a/crypto/scompress.c
+++ b/crypto/scompress.c
@@ -117,6 +117,7 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 	struct crypto_scomp *scomp = *tfm_ctx;
 	void **ctx = acomp_request_ctx(req);
 	struct scomp_scratch *scratch;
+	void *src, *dst;
 	int ret;
 
 	if (!req->src || !req->slen || req->slen > SCOMP_SCRATCH_SIZE)
@@ -131,13 +132,26 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 	scratch = raw_cpu_ptr(&scomp_scratch);
 	spin_lock(&scratch->lock);
 
-	scatterwalk_map_and_copy(scratch->src, req->src, 0, req->slen, 0);
+	if (sg_nents(req->src) == 1) {
+		src = kmap_local_page(sg_page(req->src)) + req->src->offset;
+	} else {
+		scatterwalk_map_and_copy(scratch->src, req->src, 0,
+					 req->slen, 0);
+		src = scratch->src;
+	}
+
+	if (req->dst && sg_nents(req->dst) == 1) {
+		dst = kmap_local_page(sg_page(req->dst)) + req->dst->offset;
+	} else {
+		dst = scratch->dst;
+	}
+
 	if (dir)
-		ret = crypto_scomp_compress(scomp, scratch->src, req->slen,
-					    scratch->dst, &req->dlen, *ctx);
+		ret = crypto_scomp_compress(scomp, src, req->slen,
+					    dst, &req->dlen, *ctx);
 	else
-		ret = crypto_scomp_decompress(scomp, scratch->src, req->slen,
-					      scratch->dst, &req->dlen, *ctx);
+		ret = crypto_scomp_decompress(scomp, src, req->slen,
+					      dst, &req->dlen, *ctx);
 	if (!ret) {
 		if (!req->dst) {
 			req->dst = sgl_alloc(req->dlen, GFP_ATOMIC, NULL);
@@ -146,10 +160,17 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 				goto out;
 			}
 		}
-		scatterwalk_map_and_copy(scratch->dst, req->dst, 0, req->dlen,
-					 1);
+		if (dst == scratch->dst) {
+			scatterwalk_map_and_copy(scratch->dst, req->dst, 0,
+						 req->dlen, 1);
+		}
 	}
 out:
+	if (src != scratch->src)
+		kunmap_local(src);
+	if (dst != scratch->dst)
+		kunmap_local(dst);
+
 	spin_unlock(&scratch->lock);
 	return ret;
 }
-- 
2.34.1


