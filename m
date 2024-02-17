Return-Path: <linux-kernel+bounces-69682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F631858D3D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 05:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3E72828D9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 04:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E701CFBF;
	Sat, 17 Feb 2024 04:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhD1c8DO"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC9B1CF8B;
	Sat, 17 Feb 2024 04:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708145503; cv=none; b=A08wxn7k5odK9mWA0Zpm4XCJrlYQlMs3geU3Yes+c8gggnaPi+uc+O00cVjxrPsLb4DcWV2rnofXL0WXLB8N8HfvARQ2wb6Rdc6B4PlfGkdp63ppvfWyKIe+6+IdNshLHuuT3g+4Sbawn8ZeiNxsVlvtT2RMhGiIA1p4DwMdQUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708145503; c=relaxed/simple;
	bh=OXsYoToIjgeSRYAs9X9E0bo5WCdOjPMMPVgmJGURH78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kCEQojNmjLnpL671iBNqw9ABIKqpozRsEV+tVE/Q4LtYWLqSHGk/X6uHkD3WyPPIL9gakE5Tgtf7ydLO0P8NYc9lB3i3TdTPpjB7lWcI/YwRRdlBDT4G+kIw3maKI9UbNxqD5CZ22kXamFGxoYDqgL16jAZCZzaTHXxpqJ76+UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhD1c8DO; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7bf7e37dc60so145971739f.3;
        Fri, 16 Feb 2024 20:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708145500; x=1708750300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kW/qQndLj7MYeSMYgAPMliKXg25U647vW1M3U8+Bgew=;
        b=GhD1c8DOfSx/cvZLwz0Xk2k2Et3ZwFV169yH93IYF0UPQWfZdf8zNSH4tse5ipK53w
         PKgh/Y4f5q9CrylOtc6a+ot+k76IzBr7Pr1BBYQGGEhDOyUNP9+kJryEF+PB7nAeB0YU
         1XPpJFiz+JJL/EEKUE5ZQ4cHrH7FgEDOnkI8XeOob610Ms1B4a91eTJMKeSJ3Wu3iDxe
         uFQ9r1Tu66qq01zgid2EFxz7bAaQIFYjxAIb3EY/TrwZYvDeVtROdbayCuvM0cstN3wi
         Rk4pX4yvEKMW4EuSvF+pvd5CBrt5P+VqvZzEmdIVWOVA+hNoBbjdfnYskS9i/dy7qCiV
         6tPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708145500; x=1708750300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kW/qQndLj7MYeSMYgAPMliKXg25U647vW1M3U8+Bgew=;
        b=eEkoOAZ4HiQCxgEs6ZCh6W4CIsFtC45qdbB2RUoSrBZawozVhrDAgH2p08nHtCiqLM
         l7CyI3Mmb4+FVR/El+yWQ+TFKLo1/saHdl8UMA2gDIk7N3PoFK7NDA+j/lDhpRIevn35
         tF/p6zKCO/XpKv4/g1M9ZcLwMd8TkSK0BRE4G4YRwIUc53mTtwgH+2ikP2eLR3cHv48M
         y23t52HCqxYAbbia1YYAJUqgvbcVJpZH5rPsLfB6Z2IiXOUx3XmyTTMDpFDlib2mKgY3
         3b2hn72EDMPcdtTwZkhngdmNZBB4FCAqoVgyQ97bvERgiT7UTeQJIQjsNPBnAiTjaGXi
         kebw==
X-Forwarded-Encrypted: i=1; AJvYcCUoPilh/j3il++8x/aM5Jx/3oEK63zsBP7p9x3ZA7XqZ8mS9dhAArvT+viR872gUeD1WZVW0fqqVH0KYmGcGJDej6L1uhS5jJnS0/hvlcsc4mnIADc5+/7s4Gr0Eajgl4njYoxMxlYkCMkc
X-Gm-Message-State: AOJu0YwmO9H0cM0ovuKrS5RA65sDrh+8QGuKeyOoEyZSjeg/6nH07OLh
	cKTAyojN1zDThOQ1ynxUCQFau2RmX0SkgLSsGdDt+Mz/L+ttbsX0
X-Google-Smtp-Source: AGHT+IEOW4DS9BP7Ysw7VmEnIq9KlLgS920AXTvAFRO+XZXAmVk4YcCGu0RWQu1NKlAdLNbOmorNFg==
X-Received: by 2002:a05:6e02:13e2:b0:363:c63a:7975 with SMTP id w2-20020a056e0213e200b00363c63a7975mr6639713ilj.24.1708145500701;
        Fri, 16 Feb 2024 20:51:40 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:e82e:22f2:1bdb:989f])
        by smtp.gmail.com with ESMTPSA id n14-20020a635c4e000000b005dc2ca5b667sm610703pgm.10.2024.02.16.20.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 20:51:40 -0800 (PST)
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
Subject: [PATCH v3 3/3] crypto: scompress: remove memcpy if sg_nents is 1
Date: Sat, 17 Feb 2024 17:51:02 +1300
Message-Id: <20240217045102.55339-4-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217045102.55339-1-21cnbao@gmail.com>
References: <20240217045102.55339-1-21cnbao@gmail.com>
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


