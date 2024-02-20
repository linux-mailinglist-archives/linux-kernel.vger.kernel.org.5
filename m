Return-Path: <linux-kernel+bounces-72234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A712585B107
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E8B0B23984
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0786E56B9C;
	Tue, 20 Feb 2024 02:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQHKfSFK"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B488856B7E;
	Tue, 20 Feb 2024 02:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708397787; cv=none; b=iuPup5hxAfPcnTU7ubeO5amIgRvQBYxwnnaJ7Bo7hKtKQWR4MmFNTYdTKw+AAJrnwMKLOP152s8HBE/L4ynp4n+L/ucoSqMVzmCMZ6YlFw8yRn7/DUoQs5++8jd1SoSu2cjaPhML7ogJnofpLjjwxEl29eM/ri81vwHlXMJo2+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708397787; c=relaxed/simple;
	bh=OXsYoToIjgeSRYAs9X9E0bo5WCdOjPMMPVgmJGURH78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c8YEyhzdS7lyN0Ueyeoyhlk3qqJ1Bv7+r40ss2EvxI4AoOde9MD/dQSGEUowPezeNW4Sfxt6lloVyN7h4h8HuodVFh3thLEPHHoadoNJVKrxOFG1IWNuN0PqXJfKhNqTN6KrC6L6W3RtfdbVGdAAk55cqAOgSG+0+zR1+Dbk4mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQHKfSFK; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-59cb1e24e91so1627723eaf.0;
        Mon, 19 Feb 2024 18:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708397785; x=1709002585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kW/qQndLj7MYeSMYgAPMliKXg25U647vW1M3U8+Bgew=;
        b=gQHKfSFKqnMhPk7iUPojFDzhc66LsEsSotgbQMp5KbD1VXbgbOnaLznR7ZAwfrj5nb
         IX4oZS6BuOQOoZJZbakIBLBC495H8FmNZsBCkMAhjhm06dqsyWAcsKUacWQgRcTlQsUy
         6RUNzr8Jbm9ZrlJjgZJGXJgGOLJ3n5+OKCwNRzJe9ejU8yUjwfCYNxR3Lz2QcxkmI2f1
         iVOPMsFQIGybZ3GVR2EzlOIDTv5/r/aboAFEYKKKxjyetZpnhLfVw9YdAtCIGCy0djAj
         eMDrfEOSJnkzeT7M0+NaEW1oOVD4+JzTszmvxTmu648r08DyKKeq9PQtla3ppKyHZp0u
         pc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708397785; x=1709002585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kW/qQndLj7MYeSMYgAPMliKXg25U647vW1M3U8+Bgew=;
        b=rxHlNdyJo//r6NprHy2jg5zj5k6KkNgWPubOq64kFEy6LRVyBKoWPYlFaS90njYGoi
         RC3DBWck9J17A+MxcOKO/f6s/op7gMtMJSVyRCTqrKwXXnfv5gg87ph6UJCGwVrYjIhK
         0s9TixJE0pmEsibhtDQN8IhnyECyuHdWQSnSZbDlW/Ukoqse6HjJuWREiPUt4PiECsF4
         bF9WNcoYpUBfuTK9k07qIepoeY7p6gEprLAOTU1idEo8jTN6LbelDX7i2vjeCEbOoRuF
         tc24ZUzibstskiVdr0QreskslP2vrkPQZ9it2HXLq2vq6hPYeDhz5T+GpM61hKfEgj09
         h7TA==
X-Forwarded-Encrypted: i=1; AJvYcCXMYtxnz0i+qzFp5vkNU/7XtfLV18aEdMwJdyrCyzaU8Han6v/Zq3EacgScK4IlhpxB201YA6S9HIwVnnpQbwbJw2dzDHypw45Bv547J/z4ARSatNB94mpsSYiWPZOhOsnTWMuiwBFV0c8+
X-Gm-Message-State: AOJu0YxIbza8cCnD2EpjHSAXMWffKg7hTSfxu4UWnrCN50dUFGm7QTuA
	K3C2duNvlIQheI7Qx7Rh6eGpbyMGn/KdiruSfrvZTmPig/9PTF3V
X-Google-Smtp-Source: AGHT+IHm1nRrDZtEWW28L4x2rAgwEL50c0JazukXW93V03ZXEqdBNo20ZbIjvDpQgzMenUad5lxqAw==
X-Received: by 2002:a05:6358:6584:b0:176:8472:800f with SMTP id x4-20020a056358658400b001768472800fmr9579507rwh.31.1708397784669;
        Mon, 19 Feb 2024 18:56:24 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:a5bd:9c11:af2b:aecf])
        by smtp.gmail.com with ESMTPSA id j34-20020a63fc22000000b005dc1edf7371sm5500047pgi.9.2024.02.19.18.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 18:56:24 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	davem@davemloft.net,
	hannes@cmpxchg.org,
	herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org,
	linux-mm@kvack.org,
	nphamcs@gmail.com,
	yosryahmed@google.com,
	zhouchengming@bytedance.com
Cc: chriscli@google.com,
	chrisl@kernel.org,
	ddstreet@ieee.org,
	linux-kernel@vger.kernel.org,
	sjenning@redhat.com,
	vitaly.wool@konsulko.com,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH v4 3/3] crypto: scompress: remove memcpy if sg_nents is 1
Date: Tue, 20 Feb 2024 15:55:45 +1300
Message-Id: <20240220025545.194886-4-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220025545.194886-1-21cnbao@gmail.com>
References: <20240220025545.194886-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

while sg_nents is 1 which is always true for the current kernel
as the only user - zswap is the case, we should remove two big
memcpy.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 crypto/scompress.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/crypto/scompress.c b/crypto/scompress.c
index b108a30a7600..50a487eac792 100644
--- a/crypto/scompress.c
+++ b/crypto/scompress.c
@@ -117,6 +117,7 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 	struct crypto_scomp *scomp = *tfm_ctx;
 	void **ctx = acomp_request_ctx(req);
 	struct scomp_scratch *scratch;
+	void *src, *dst;
 	unsigned int dlen;
 	int ret;
 
@@ -134,13 +135,25 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
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
+	if (req->dst && sg_nents(req->dst) == 1)
+		dst = kmap_local_page(sg_page(req->dst)) + req->dst->offset;
+	else
+		dst = scratch->dst;
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
@@ -152,10 +165,19 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 			ret = -ENOSPC;
 			goto out;
 		}
-		scatterwalk_map_and_copy(scratch->dst, req->dst, 0, req->dlen,
-					 1);
+		if (dst == scratch->dst) {
+			scatterwalk_map_and_copy(scratch->dst, req->dst, 0,
+						 req->dlen, 1);
+		} else {
+			flush_dcache_page(sg_page(req->dst));
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


