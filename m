Return-Path: <linux-kernel+bounces-135768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2696589CAFC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86C03B246BA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDDD1448DD;
	Mon,  8 Apr 2024 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLaGFlYd"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49538143C79;
	Mon,  8 Apr 2024 17:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598445; cv=none; b=uo6mUpMpXaN2mBcwrIRDUiKpCjPi/RdCx74TjC0Jb1xOW9RI8w9ZYqaEhnzRRYG5yKXe+i1LyHWJ7ZePhhTRpqbX3cPwpfV7a5CFONnBvHSb8wZv1IPO+1RfxBqbfZR9O+RcWGrz37qWBQaplQ/FAQXubaF7BxJVqazxV8cDQFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598445; c=relaxed/simple;
	bh=4I86mxqxviiRcVJTe3puc8bAtdUf+v4wN/fHetei+G4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tY1hYQtSAU8nA3R+gY96EKWxB1G9iqeI2D2jJTfRauMRqKUI3jKBvxBDiZ+4SI7PJN2TMxwOYqeSQYbFI7IaCIwyz7220hy+/YXi6KKbHePU0i8ifuHTQ5x9ulVd4nDEjZ+CRVRAP8mU3nLWsG4HoZ4nnZYlKwInk3HHynImF4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLaGFlYd; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5a4930d9c48so1428483eaf.1;
        Mon, 08 Apr 2024 10:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712598443; x=1713203243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JwaQrBi/Lb4swFNBzhz/Zq2k8S4Qq8Dh3rIl0JBflxU=;
        b=TLaGFlYdyP8dXg5ca7IKlQ9I/mYiMpnMFyUlBD6+thdibSuzgm9Vr2kuYaJC1Lk8al
         yAUYduwgLXe54MK34jI6TatWVA+3vGw05ljskRhaxf5DSgRKtJ9p1b+eIL5Z52vV9zzv
         8DQv0cfA/tu/QPHFY+LymbhgeE0j9GsU5+TAuFmmV9ohQeLkSKOjaCgh5f5Y0wK+yU2e
         aUxJ24Nmyz+T6A9aKLShOMNFcOcp5+z5tLp5lbEbqZlhzhB8Jvk2UElb5HxWl7r//MHV
         LqRQZHkq0f1eqYVc8/UXnIzQVIwJBvcZhl4gtZ4OTIsmLx1g2DESqvGM3wIIaGIuUxtn
         J4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712598443; x=1713203243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JwaQrBi/Lb4swFNBzhz/Zq2k8S4Qq8Dh3rIl0JBflxU=;
        b=VVn7MMPChQ5D8oIR0HYnEz+CJ2CT2i+iuw0+u2e1pamUZfUczmZugtkGK1ftUwUFS1
         F7gTxq99TymYuy5brpCt1mOG4OEPX2dFx8KDtFtxDHGdYrbvM5q+rPhLGPG9s54vMDhc
         PcA9HUl0MK/LEYWRcQJYYt8LP3+1bCsyMu806xTL/fnY0mxoZOyxcz3oR4d3ZhaTrPoH
         ALFcsD1vNC1L+hsAfeF5EmZbhYTdPkv4EIqmkXbm6zhXr3F7ZlJQyqcHLDBozvS/PMJg
         YcaEryblCFp+v1gkSl6UYuQGb0oCxqqfNK24SG4cyPmXpfnSi+6jXAYiFhO6dkAw3ahg
         S6/A==
X-Forwarded-Encrypted: i=1; AJvYcCWfVlXJd4muD/pJ02n0zjARIAemgRIXxgzu7l1woLjxPDCvv+LGdC7Oq2y9r+g+ThQ2z5Lsa7ep54zGVge9iIUy8wH0sQjtqYcLAh7KYKKKgG+C6Gyaha6OsnOcdVLiyIiqjNvP
X-Gm-Message-State: AOJu0YwHuSgwrv9EDNnZESw7XZ+owLvOfbfMANbAajE3bu3aI1cUKOlf
	pK2Y7UHDSejYfIRrShkvYMcjDInzm6lBk2BMGgPZVwMEibokmF1D
X-Google-Smtp-Source: AGHT+IFnY7oyhUQ2h1YHDDpIJAZW8c1j5v0T5sdQe4YExZyP043/DJ68ik+7HU4G7BhF8KWbj8RTDQ==
X-Received: by 2002:a05:6358:9dae:b0:185:fea7:fecd with SMTP id d46-20020a0563589dae00b00185fea7fecdmr5923178rwo.0.1712598443274;
        Mon, 08 Apr 2024 10:47:23 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id k26-20020a63ff1a000000b005e4666261besm6821143pgi.50.2024.04.08.10.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 10:47:22 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: toke@toke.dk
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jserv@ccns.ncku.edu.tw,
	cake@lists.bufferbloat.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH net-next v2] net: sched: cake: Optimize the number of function calls and branches in heap construction
Date: Tue,  9 Apr 2024 01:47:16 +0800
Message-Id: <20240408174716.751069-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When constructing a heap, heapify operations are required on all
non-leaf nodes. Thus, determining the index of the first non-leaf node
is crucial. In a heap, the left child's index of node i is 2 * i + 1
and the right child's index is 2 * i + 2. Node CAKE_MAX_TINS *
CAKE_QUEUES / 2 has its left and right children at indexes
CAKE_MAX_TINS * CAKE_QUEUES + 1 and CAKE_MAX_TINS * CAKE_QUEUES + 2,
respectively, which are beyond the heap's range, indicating it as a
leaf node. Conversely, node CAKE_MAX_TINS * CAKE_QUEUES / 2 - 1 has a
left child at index CAKE_MAX_TINS * CAKE_QUEUES - 1, confirming its
non-leaf status. The loop should start from it since it's not a leaf
node.

By starting the loop from CAKE_MAX_TINS * CAKE_QUEUES / 2 - 1, we
minimize function calls and branch condition evaluations. This
adjustment theoretically reduces two function calls (one for
cake_heapify() and another for cake_heap_get_backlog()) and five branch
evaluations (one for iterating all non-leaf nodes, one within
cake_heapify()'s while loop, and three more within the while loop
with if conditions).

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 net/sched/sch_cake.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index edee926ccde8..2eabc4dc5b79 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1512,7 +1512,7 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 	if (!q->overflow_timeout) {
 		int i;
 		/* Build fresh max-heap */
-		for (i = CAKE_MAX_TINS * CAKE_QUEUES / 2; i >= 0; i--)
+		for (i = CAKE_MAX_TINS * CAKE_QUEUES / 2 - 1; i >= 0; i--)
 			cake_heapify(q, i);
 	}
 	q->overflow_timeout = 65535;
-- 
2.34.1


