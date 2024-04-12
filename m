Return-Path: <linux-kernel+bounces-142441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BED68A2B9C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2CC6B21491
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE15524DC;
	Fri, 12 Apr 2024 09:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="dlmtWb69"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F5D3A1A3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915691; cv=none; b=KaRvyWf5FgV6ChS6dbUsLbdTzMaEHZByIbNAw4yroeOybaLK83fvJ1GRQXMl59gUp7QnCfZHjcvwVawMzF9WJeoe/oN/Xh/7g7JzeHi2U2PHR7+sU7X4NS/HEYCDxbSOiybBuL51H2oSE8IQSdS/oHXBNXyvc2lmhalPLjUBp4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915691; c=relaxed/simple;
	bh=+mC8bOYpQ4j1ln9h+3n41mL3hSsE1KxulYl1f4Hdifk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AfduOeBcTxTHf2Nw+Om0omwDQhj670ajbKh8QNrx5+BhqqYgeswm+Mp9IvrG5SYa+QV8RFuFAPuLNuwAyREQgIKib3HoHvAkaYlLCH/MQYgC3DHP+8zue/PTaK4bsABIeMxHHURBbr3Qov8zEr/xCW3ozESzfBO7H3vOlONx1ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=dlmtWb69; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so698849b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 02:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1712915689; x=1713520489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J2Shw6UlHeUYDPtpjOCh3gm8rSwGbYvX8gPhx5RCNzA=;
        b=dlmtWb69vpn3qCpnTkEr98oBzV082R+8GIuJEghUGYj9sjppDZRsgNKkVWrCCdVsLl
         w1u6KeA4lrWPV7AIr3NWaNrFGxafmaps2aRYCs25LhxZh12rMfbgsP0yFgyTujqMkoTy
         ev043tvFMffsatjzQRlVF8cSX1bg2HKmqWYq8VTWHzI0AUS/YHfRbm0DT/YAV/Wnya13
         pPsAMBbz3GYMJs9p6pSumXj5O25Cs1T395IH5y+UuR7aXoudHeFEc+8fXt9TZuzDWLu3
         uyYySx3xxMw0hkHlq5jhNwiBySodOvF3lEKooAQDk0AuphIVfgOxT2+OnYRuatMAvSKO
         9Ylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712915689; x=1713520489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2Shw6UlHeUYDPtpjOCh3gm8rSwGbYvX8gPhx5RCNzA=;
        b=l+Skpq+FS7UF3OmwWplhDv63exUVkKSgSN0JhDlE8qh+XAX40ouBNA134XvPYhBpzy
         h+B3FWph8YVxLQikykGG5DMjb3I/JWdfW/ddkZHiGonbYtd80aGKVZaPbvAU45fELof+
         ZF2xjHboUNacGbKuipw3OtB6tEvkPtivo1YuHSi42RsxVbdvKOxsz2d0ibdU4MQXcvDR
         /en9K8Z9YDsJ7sUwyN3yvzN64Em4s0f7ADgvjmD6pT9RMsdO9jgSxUzy9BmYW1mmRddp
         JS4x5mep23uuenGrpHuux3NYx5625y4NNlsFNN15NsceCHC6dSquYAxf87O/NFWQ/dU0
         jw3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuhk3zL1LAMMBFTSi0SHQ4UDExfrIVHTWWOoJg5naf3G0MggVjLH9hFIefuf8asMQXd+tcOQI5MIEEcSCuaqn2gtj+iUqrHO4TeRH3
X-Gm-Message-State: AOJu0Yxf+LiO9eb4j8BNrkXqbqa3FzDh6avEqIyiCMxt7mipumbAbXx5
	dv4bMD/US5XTnTDW5W5yFQGtYo4YnxY/lyioUQMubEFVSdsGq3w27lWcoq44kgo=
X-Google-Smtp-Source: AGHT+IFBsYlJEEwf43MspheO9XTlBmNW2+wfPHIkBMYYVF14myVo59eUvS/rsztZmRhPfWX6Wyvw0w==
X-Received: by 2002:a05:6a20:c629:b0:1a9:5a2a:7e37 with SMTP id gp41-20020a056a20c62900b001a95a2a7e37mr1997680pzb.56.1712915689488;
        Fri, 12 Apr 2024 02:54:49 -0700 (PDT)
Received: from localhost.localdomain ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id n5-20020a170903110500b001e478f359bdsm2590765plh.127.2024.04.12.02.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 02:54:49 -0700 (PDT)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: cl@linux.com,
	vbabka@suse.cz
Cc: penberg@kernel.org,
	rientjes@google.com,
	iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org,
	roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH v2] slub: Clear __GFP_COMP flag when allocating 0 order page
Date: Fri, 12 Apr 2024 09:54:31 +0000
Message-Id: <20240412095431.612839-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We encounter warning messages when failing to create a new slab like
this:

page allocation failure: order:0, mode:0x1004000(GFP_NOWAIT|__GFP_COMP),
nodemask=(null)

It's a bit confusing for users because __GFP_COMP flag is used to create
compound page which implies the order should not be 0. This is because
minimum order will be tried if higher-order allocation fails and the
minimum order is 0. It's pointless to allocate 0 order page with __GFP_COMP
flag. Therefore, clear the __GFP_COMP flag when falling back to 0 order
allocation which makes the order and gfp flags matched.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
Suggested-by: Christoph Lameter (Ampere) <cl@linux.com>
---
Changes since v1:
- Place the check in allocate_slab() where the minimum order allocation
  is performed.
---
 mm/slub.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index a307d319e82c..e7bf1a1a31a8 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2027,6 +2027,15 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	if (unlikely(!slab)) {
 		oo = s->min;
 		alloc_gfp = flags;
+		unsigned int order = oo_order(oo);
+
+		/*
+		 * If fallback to the minimum order allocation and
+		 * the order is 0, clear the __GFP_COMP flag.
+		 */
+		if (order == 0)
+			alloc_gfp = alloc_gfp & ~__GFP_COMP;
+
 		/*
 		 * Allocation may have failed due to fragmentation.
 		 * Try a lower order alloc if possible
-- 
2.25.1


