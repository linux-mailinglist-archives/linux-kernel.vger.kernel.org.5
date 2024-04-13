Return-Path: <linux-kernel+bounces-143796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014B48A3D8E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83CC0281F64
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40444481A4;
	Sat, 13 Apr 2024 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="LH61v21Z"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3342A28EA
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713023809; cv=none; b=NKY080b1jPzs5Qh1Jg+XmMM8UhN+NtiQt4iOaTZhoqPpAuN8eDb8EQ/GkWDZQDJqM7swya6gQro54HCONfkl1fzLpA32LPmevTq4G2wEroO3XxLJYJzCakDfnqmNyYscVAi/KjYITLb4opquYAz+V2IRZ7hdyYjfGuZ6rR5zQGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713023809; c=relaxed/simple;
	bh=d7294oS6esXEBij8YskN/mVZsg2g4Fp7kfDt0BVpAig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QSfr9x4noPcTMjIl5meL4TfeXEppRKILuflhhhtR01nIkW8eQ8TUfzKLZj9lyccm0k9aLyBJ6HYSNBpO4664fE6hG7ptWYhpkpR28pwM/DVAeoP5drnkTs9Yq/2tZN2zYm4IDjh0R2TcL4fWhfkZBF3fLIqnpkG/xQU29ehfkqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=LH61v21Z; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2a528e7f2b6so1358867a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 08:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1713023807; x=1713628607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SlcR41hse8ytw2MXnYpZ97rYSoxohH+lL9OGt7SRLNU=;
        b=LH61v21ZoNglzPwG9NJ/aD6lIgjVOaJqszQC47QmqD+ZPsDf1xbXCV8+g8Emadz0Cf
         dD5dfNn9s0Xuxz3ZN8lKlAMmBALdBrrp+BtUroybRS+N4x6EzFp1uUG1nFhqNzAs3N4v
         r6NIquTMIRiVZpk8T+cNgS7oRGlgQ56Q9x5BEtv//OSya4UqKVyy8k1r7sGsiiD+IQiJ
         x4e44LCWeCH3ec2H4nNAwTUUZ/xIb2nUqhIBP/U/H8JpMup8DBAG32C2l7HgI9m1Qkaa
         dARXzFxiu3y0YTlGxqNJwGPN0ICngQzlTnOwazGrnJn2O8o7sDnzuURcpk56VF7MCRXT
         RJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713023807; x=1713628607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SlcR41hse8ytw2MXnYpZ97rYSoxohH+lL9OGt7SRLNU=;
        b=ayBjO40ea92jz0/fiBaoF9qn4xq+EmAeouV3G59eimsKoYTQk0lFL38GOi7rDAL8hx
         TVBXw/RL65laJAeDjn36cqbCAomZDEPyXW5HOAsdjKzw3DsKQxds4DOUnNEVMAeFO05Z
         Nztbp4z1n6IIymtP0PCrJ2tlVO2ZYuMNAkQffAVs3OCXhzhhdhQ8Zc33QIDKSnNb0p9l
         9NXR9jeIy0mllmfKVf1mHc97OMElfkpKHSOeIgh0M3PshjYO496yZoe0gYcigbk9C59k
         OsGlLeAwt367pJPPJeE4M/pm7u6nSLE8qAtTG97DJBleYWjr107fm9BxpuUgv3Ae0aeX
         SygQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbQu5oYmq1M689gU7bXnLZ9LawcMb+VUcq3cc0icnMzdRn3HIw/aEyasWj1kx62gJyiTRqfZh8NOBIV4HIKj7XJmCJnfVeRPwFkH3O
X-Gm-Message-State: AOJu0YzymE3E66VQW0js+xgSPqEPv6zMNrGC7EVXyxuhS5SxFX3SBJT5
	CjWatMY43wcJBP/FUzL/Q5sIa5Mk9ofarLSHa1XdEikw5wrNRBVONNfXiJ9JJPc=
X-Google-Smtp-Source: AGHT+IFieKNdVVSuLwqWGtv5VUNM4ouN23R6EytmrRddQajutjkn+wP1sPm30eKCbNzX3DUh9RWAAw==
X-Received: by 2002:a17:90a:49c7:b0:2a5:379a:e2c with SMTP id l7-20020a17090a49c700b002a5379a0e2cmr4500879pjm.7.1713023807460;
        Sat, 13 Apr 2024 08:56:47 -0700 (PDT)
Received: from localhost.localdomain ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id a18-20020a17090acb9200b002a5e1b215ccsm4443636pju.21.2024.04.13.08.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 08:56:47 -0700 (PDT)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: cl@linux.com,
	vbabka@suse.cz,
	willy@infradead.org
Cc: penberg@kernel.org,
	rientjes@google.com,
	iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org,
	roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH] slub: Set __GFP_COMP in kmem_cache by default
Date: Sat, 13 Apr 2024 15:56:03 +0000
Message-Id: <20240413155603.617554-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now the __GFP_COMP is set only if the higher-order is not 0. However,
__GFP_COMP flag can be set unconditionally because compound page can
not be created in the order-0 case. And this can also simplify the code
a bit (no need to check the order is 0 or not).

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/slub.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index e7bf1a1a31a8..49a3ebefab86 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4461,9 +4461,7 @@ static int calculate_sizes(struct kmem_cache *s)
 	if ((int)order < 0)
 		return 0;
 
-	s->allocflags = 0;
-	if (order)
-		s->allocflags |= __GFP_COMP;
+	s->allocflags = __GFP_COMP;
 
 	if (s->flags & SLAB_CACHE_DMA)
 		s->allocflags |= GFP_DMA;
-- 
2.25.1


