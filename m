Return-Path: <linux-kernel+bounces-72426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF3B85B319
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86347280F10
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4DD5A787;
	Tue, 20 Feb 2024 06:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlVM8ClU"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8C95A4DE;
	Tue, 20 Feb 2024 06:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708411494; cv=none; b=Ui6xaMDpbwyjX2+BO/TG9pRV3h5Atn/v30BNVlXNGQqRrYNbJuxmEg8BbLgLYJOQ2ppwXhqUCHscdzXd2vmnF/it6R1PJoRsP2lxi4XGJPWK4Ftxqh7ZrFyPybTRs70fqs7xvXv0y6FyDZxikG2viOYA99w+5FbwIViJiUE0weI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708411494; c=relaxed/simple;
	bh=OXsYoToIjgeSRYAs9X9E0bo5WCdOjPMMPVgmJGURH78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mn5gRDPYSY3JCPOBDBvnKLuN7pSQhmLkZvAJO9buSWlGlSYbANRw1dGam/b4K4y6PLmXfXzj2p1x1a5XVDFfbWgzw5PFk2qzz362ZLjrd+gICmY78fJLYAMMLI/v49paNgiARQ2ofxNnou6qbgbbhyoMG4dBtidCyEtnwr0qCMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlVM8ClU; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2997c5fe6abso1897230a91.1;
        Mon, 19 Feb 2024 22:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708411492; x=1709016292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kW/qQndLj7MYeSMYgAPMliKXg25U647vW1M3U8+Bgew=;
        b=QlVM8ClU7zuheGbBwmGCYE/VCTle86bL/4mR3GB114bbYj7E3RjvX8kTB8PakVDOe/
         GuMvgTIq/Wb3gOPF88bRwV0xcpwUT22ul8InlqpM6nBomP2b4jJdQ+C0y2jO/SCheNYn
         8JbjOitnv1qrGSRbjORarp0PiCGhiJHq4uvvp5oUieIW/fM+oYxLpu3qG7HIxuDAr/nU
         E3XC3Jx4gTRUN8j30vFGvM8smWQpwXmKW1COH0F2iBa+kTD1aVa+xyDt4mHzPb8ed1sE
         hL/v5Qrmmvob6ZuI5kNmONc/rV5Zg5zoIMkEraDcn4P6tVbXyksp8aEV97iNECOYC6Ab
         U2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708411492; x=1709016292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kW/qQndLj7MYeSMYgAPMliKXg25U647vW1M3U8+Bgew=;
        b=qZ16NInLwtJOe13q7d7lMy6zp2FL52Lq/xiCww/h4/sun/hKETOPZOcU63ekfWppHp
         O7z7jygamcTMYVEN9qkcGo6oHjf5ZWrMVbcI7E3PgK0qqg8O+le28R24L8fZIoiapD+/
         ptvlRzp0fUDh4cNXTMgjy3WeWw5GUORFy8Qv4noRd6ewh9H/6JVZqPsYt6sC3N4HLZ9o
         hllXje0sCSnIDxnjBmOjxUIBBkDjLJI5d8IYC8d5iIThK/NXSj9Zo14qMnigs6Lg1FN5
         g0L8hTVOVXoMgH+H91WbX+9cW2CRMCrjwKVZLNHUFArioOBaN/X7XjpUPdEeUcla7uKo
         PCog==
X-Forwarded-Encrypted: i=1; AJvYcCUyaJea1y9YLGU9fuTprHJTuqQcBDTWfoDNUHeL3I3WMrW0so/mBmSMI6dh4u692oFLO7NOFkSzIy3d0YAXtEvGA2q+ne/BKtdwItvTNZWc2Z/ipmuIicSYEOk/tHPc+26K42WGVwsxk4Cn
X-Gm-Message-State: AOJu0YzqRRZ1OafamOqgCV6K6sqEXaAyybCa+ETBMGR9DA8DRWVYhEiB
	NPPxuiGLMMHNYXfb0rDjQh8YgTkcnrj4XmZrUIo/VnDKqCke04bO
X-Google-Smtp-Source: AGHT+IFy6i7+4k/jye/gmwuX1sSdiY9dP1qorrai79dHWwgMgxT8+F/EE4GSmEybEa4pgheMKtFkLg==
X-Received: by 2002:a17:90b:4a08:b0:299:951f:e7de with SMTP id kk8-20020a17090b4a0800b00299951fe7demr4537779pjb.14.1708411492102;
        Mon, 19 Feb 2024 22:44:52 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:a5bd:9c11:af2b:aecf])
        by smtp.gmail.com with ESMTPSA id w16-20020a1709029a9000b001db60446abdsm5419090plp.262.2024.02.19.22.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 22:44:51 -0800 (PST)
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
Subject: [PATCH v5 3/3] crypto: scompress: remove memcpy if sg_nents is 1
Date: Tue, 20 Feb 2024 19:44:14 +1300
Message-Id: <20240220064414.262582-4-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220064414.262582-1-21cnbao@gmail.com>
References: <20240220064414.262582-1-21cnbao@gmail.com>
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


