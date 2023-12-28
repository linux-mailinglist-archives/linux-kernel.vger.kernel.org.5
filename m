Return-Path: <linux-kernel+bounces-12457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3353981F50C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA5C282CB2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 06:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE68D3D8E;
	Thu, 28 Dec 2023 06:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="JAw+/nS9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836043C0E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 06:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6da67ca9969so4502788a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 22:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1703744858; x=1704349658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ezcMWpqhmHAMLrYn0+Q9MY7X5OW7VKM8sl5WwMShxTE=;
        b=JAw+/nS9zoAliofEWk5N8/OC2ihpkcUiCF++bhH/Kjt6JnKUwFIlHMMFUlAkh7nR7a
         7oMBPC3hAi62BcbBV3CdJg82Sc2HGLsnJXcdqsmB0731LvyN84V6jnu69obFTkOxQDQS
         amgtKYBf0C4cFhauBqYvBLoKVuwtLKyIFS9lphgdEqDC8LezfKZkZFWIoGumK5LW/dzO
         jpFPiie+atJFOo4D6azUclCqI99rfHZe23QuW+HahFwRYqWqW9apWg3o9wqmMYuu/Bvu
         CS5YGnHCfLYkrn+ubOrIvxbDTVLk2ly+kimL7wtfk/G+fMzfMAQi5rMLL2Q7f/0W1s6y
         R4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703744858; x=1704349658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ezcMWpqhmHAMLrYn0+Q9MY7X5OW7VKM8sl5WwMShxTE=;
        b=J/XtsTqop59ezaMMIMJSBnkEkw59eHEudvIGEbJUSWtjbJTvuo3Z/DW14wLYEP+2DQ
         JBPxyAXk14C3JqcPmOKDaQQn6eyw9L0ZMoDUI5SiW577mWrw05kv5WxPKa10iBVuWfAn
         qoNL6ialEp77ScJnFVG9L56ZzQc4qigzPjeoHrh6YJwvtLylILCRpE5gBfOx4y4sv+rd
         KuWMNpyq8WZS/Wu7zuwRbBBf2o4vy7OBSVzlaUwKCFHKlQPpxAp4KKXIX4lv40NunA3n
         ijPduMvi6SFv0zbNfL6xvsyfNsRDAMNfmZk7i2mWrazuWEaVimwu8eLaIiVuYFB4CqDb
         TSxw==
X-Gm-Message-State: AOJu0YyS5pxDq/WRubWay0ZG83dOBuncUY45/ko0B7A0GZ+dNQO5FlKt
	bKkAwiB2TqWT8qSrPcZH2vyrgOfM+4CQrQ==
X-Google-Smtp-Source: AGHT+IERoZAaKW1da0vPwR5UnXPl5D9HGEMteAVaBdugBeFgLsr210XyHAAiaMtP+HF1RTPmOk4Sdw==
X-Received: by 2002:a05:6830:610e:b0:6dc:1ddd:b7ff with SMTP id ca14-20020a056830610e00b006dc1dddb7ffmr188180otb.49.1703744858464;
        Wed, 27 Dec 2023 22:27:38 -0800 (PST)
Received: from ubuntu-haifeng.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id g5-20020aa78745000000b006d9af8c25easm7681381pfo.84.2023.12.27.22.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 22:27:38 -0800 (PST)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: roman.gushchin@linux.dev
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	shakeelb@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH 1/2] mm: list_lru: disable memcg_aware when cgroup.memory is set to "nokmem"
Date: Thu, 28 Dec 2023 06:27:14 +0000
Message-Id: <20231228062715.338672-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Actually, when using a boot time kernel option "cgroup.memory=nokmem",
all lru items are inserted to list_lru_node. But for those users who
invoke list_lru_init_memcg() to initialize list_lru, list_lru_memcg_aware()
returns true. And this brings unneeded operations related to memcg.

To make things more convenient, let's disable memcg_aware when
cgroup.memory is set to "nokmem".

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 mm/list_lru.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index a05e5bef3b40..86f63c92fd88 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -566,6 +566,9 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 		lru->shrinker_id = shrinker->id;
 	else
 		lru->shrinker_id = -1;
+
+	if (mem_cgroup_kmem_disabled())
+		memcg_aware = false;
 #endif
 
 	lru->node = kcalloc(nr_node_ids, sizeof(*lru->node), GFP_KERNEL);
-- 
2.25.1


