Return-Path: <linux-kernel+bounces-140156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 248368A0C26
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93F91F21756
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD561442FE;
	Thu, 11 Apr 2024 09:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="ZqxQwzzX"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BA5143868
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827145; cv=none; b=SaUm1fmPeEhyljwH3OoQqBQzvtFRr8ekmO8BZYTtFjgFGx5zXeDMSaawp/AwsXsOroSPFMOgGQs5n+C/cMIXHrtpYA4y4Uq3hOA+JxiGo1HA5bJF8q1iDFFZLJ3WjhNBEgP4RphErvX86XUn7813TmX30BpYiwr5xwqSk/Y6h34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827145; c=relaxed/simple;
	bh=cHruvy1egUjnb0x8QWBPKMeUJkvlKHBQzM4giRQrotg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZzQJ8C0VHqKeA8aPVe9oR8+/dIwSioTzMX4WnLE2/oKhlqJoIHmDGPSIwQQYAd9x5lCnk3+mtQ9wlmyj7I14+JRAJWiuFkFSpadOsr/7uxueX1iKwWZWUV3WOeLUKBUJwvb3t1+oP+2uos8SmvBNH94gVIrcUjgvcScSVrmIOio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=ZqxQwzzX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e3cf5b171eso44360125ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 02:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1712827143; x=1713431943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EtlNfLs5P8um3SIPEQ0hBH+mGM1233JNtg+NHXLJ+e4=;
        b=ZqxQwzzXcd+DqNGkSooQMcnesAa/Wyymkv9CrxuEOW1/V8ijsRZP9/ILSIHeAUTQ8E
         W9d0VH3MzW1qvUmYbeGktlfwA8ijnFKuDMSNZ8x9IReJdv1WXPlyqJUnMnyXVN9Xq/iS
         oL01HJtoBkmOzbCvthO6mQPtxe4SzHRKNfKI2zrsvios/vsuM4dxluALf1EFux5vZZJS
         XGtLH5FuQgWyeRI33tR7JlyR8tUG0WPPrNz4Z3ITkfUgUc/m2aUDpFqsOo1pdFyQL1QF
         GCiaDLXAKnb1JEHaJondECaJR1VbdIN1ZvHZR7/RHZQqklxPRA9bOzLQZLOvqVn7Kg1d
         VTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712827143; x=1713431943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EtlNfLs5P8um3SIPEQ0hBH+mGM1233JNtg+NHXLJ+e4=;
        b=bK/rVFlCiZfLS0AUtB2s/c689V5/hNp4LejbjLemzmW6fOQUheDYrau5mG6JP51NdH
         2l+bS0t+G0ZvjgLZvG9PuNFsO+rPDpOCFEn7qw1iTUcx8y8P25HIIUzmzb7fve4zD7Ay
         3V7qFyE09HHKaVPB+XiREwlzylM8gQP2RM4kdhWhIfG9RZ/9jy9x6tXmLLhWbqm5V3oM
         Tf7qDel4FxuXzJRX+ztiCspG9SogWktMrhRvx7e54/qC7uvrZRaB8ZbahbDon5uAnZ8u
         y3FnNqg781YGDkj/eGbs3lYWHlmVmYz56a4Tk609iHla6kSJ94esRoTRrJg7yBbnggQr
         FwnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGjuz986OfsLLrKQCKFYlYGVLX7fOYX4Ui2hMF2uC7epkyaDLvxqFe7vY3b/gOwSpk1o98GCq1KC42LbZgFtdkBSLzmSsBFOSkjLt4
X-Gm-Message-State: AOJu0YztI0o8F/NseObGyLC9CQ3sgP3NziL2I2w0GHbCar/X6mdSrMMC
	Ew8US6j8ooqR3PXafienpfch21I9CyEhEGUuIXyHRq30ISn/quLdoPFqU1VNFcY=
X-Google-Smtp-Source: AGHT+IH8AHfCAqu+2YM9kQDcuI8cWGs9J2LkLXmRmn/UvJaJHjtq7lMTpyYGnye3fBWeJd27izbRzw==
X-Received: by 2002:a17:903:244d:b0:1e5:5cab:3186 with SMTP id l13-20020a170903244d00b001e55cab3186mr755376pls.12.1712827143397;
        Thu, 11 Apr 2024 02:19:03 -0700 (PDT)
Received: from localhost.localdomain ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id m6-20020a170902db0600b001e2a7ed52d0sm776424plx.239.2024.04.11.02.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 02:19:03 -0700 (PDT)
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
Subject: [PATCH] slub: Clear __GFP_COMP flag when allocating 0 order page
Date: Thu, 11 Apr 2024 09:18:32 +0000
Message-Id: <20240411091832.608280-1-haifeng.xu@shopee.com>
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
---
 mm/slub.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index a307d319e82c..d3e03dcb9ff2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1875,6 +1875,13 @@ static inline struct slab *alloc_slab_page(gfp_t flags, int node,
 	struct slab *slab;
 	unsigned int order = oo_order(oo);
 
+	/*
+	 * If fallback to the minimum order allocation and the order is 0,
+	 * clear the __GFP_COMP flag.
+	 */
+	if (order == 0)
+		flags = flags & ~__GFP_COMP;
+
 	if (node == NUMA_NO_NODE)
 		folio = (struct folio *)alloc_pages(flags, order);
 	else
-- 
2.25.1


