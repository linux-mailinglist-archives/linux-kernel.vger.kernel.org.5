Return-Path: <linux-kernel+bounces-562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8958B8142F0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4125F284363
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F30179A2;
	Fri, 15 Dec 2023 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Dqzmsdjs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B0A1774C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 07:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5cd51c0e8ebso152288a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 23:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1702626410; x=1703231210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CURAtT+EULVw1WUO/LymnRu4QScwQ/mpUpF54vPt0wo=;
        b=DqzmsdjsfsRC8bcWcZOmumaiXS4CsYhXa7w2L0+RcdUdKB5b5UKF3JEYzScqXELnYl
         vs9jzA5PZi3nPD4mxHECReO/7PmbslzQEDV4zbTT8sGLloMM6JaoF1YRmA2PCEPkI/la
         DEEAtK1g10At7KUREZUjBEYs6kgWBn+34qaZoOhk/psFvlXmF5K5WFSubektWOrGy7KZ
         kv3dv2JTxru6C3HIt4F92LEUW7ftLnRAzB366UUNs0sBabVkoTxAlv/87AUGZI5tQBjv
         SMZUzmwfwVS2OJUpwFnATR+UntRmK7BlABK8t0fwVb62IO2oAKcLRfu+Jiz32bvWYG5C
         XJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702626410; x=1703231210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CURAtT+EULVw1WUO/LymnRu4QScwQ/mpUpF54vPt0wo=;
        b=ZZIH8ymLOq6JWAQXsTEccOsljeBs8VkRP/YPBhPyzkNYEvB2ZzAv43YXPaxmWeIFdF
         7wZFnNxeU5ZQdlgpvmDs1lDEIgzqRfaX2FGqAsbX8OZv976pPhd+6X49R1kH5iRsGLDX
         q/gCoBaMTPWCu6VjRFLi+3UuhdHkiyGN+oeMIwVWLRl8efdtR8lA0VoRsF7BwmW3gAAf
         HIhVkOIFoB1F6TQXrniJs5T5xOl/8UZhHsqaXueA8WqnXCA7uZ4JOHYNP4E3FKSYPjOZ
         q6wt8+Vwxvh/2gyFJYAskMgNOE2MpMC5G6sq8Bro9sqOpKGwMmQatPSl+E4GmV/w4C71
         gOag==
X-Gm-Message-State: AOJu0Yzs0ECa6r3VGfjRkW2nESH7Xn4yGS9DHwTra3w+q7ZSNT+BCrje
	HzL1dB2nhsp8pfBm13WWrv/SYA==
X-Google-Smtp-Source: AGHT+IGbl4tSvWzLdqBdv1C+br/qeaLBNQi/RO+pfmEb3VdxMcWDGLvFxcjKUE2VnMHln98cwQAz5Q==
X-Received: by 2002:a05:6a20:8e01:b0:187:97fc:6c56 with SMTP id y1-20020a056a208e0100b0018797fc6c56mr7173650pzj.49.1702626409748;
        Thu, 14 Dec 2023 23:46:49 -0800 (PST)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id 28-20020a17090a1a1c00b00280070a2613sm2823175pjk.51.2023.12.14.23.46.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 14 Dec 2023 23:46:49 -0800 (PST)
From: Peng Zhang <zhangpeng.00@bytedance.com>
To: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	maple-tree@lists.infradead.org,
	Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH] maple_tree: Avoid checking other gaps after getting the largest gap
Date: Fri, 15 Dec 2023 15:46:32 +0800
Message-Id: <20231215074632.82045-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The last range stored in maple tree is typically quite large. By
checking if it exceeds the sum of the remaining ranges in that node, it
is possible to avoid checking all other gaps.

Running the maple tree test suite in user mode almost always results in
a near 100% hit rate for this optimization.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index c9a970ea20dd..6f241bb38799 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1518,6 +1518,9 @@ static unsigned long mas_leaf_max_gap(struct ma_state *mas)
 		gap = ULONG_MAX - pivots[max_piv];
 		if (gap > max_gap)
 			max_gap = gap;
+
+		if (max_gap > pivots[max_piv] - mas->min)
+			return max_gap;
 	}
 
 	for (; i <= max_piv; i++) {
-- 
2.20.1


