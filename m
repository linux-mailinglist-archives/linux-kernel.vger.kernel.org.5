Return-Path: <linux-kernel+bounces-17990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A146D825680
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 442B6B218CF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5666431721;
	Fri,  5 Jan 2024 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="jeLTI0B/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDE62E849
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A75683F154
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 15:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704468118;
	bh=lY3Wm0rqUAhsDJUxSGP7DuG2vuWegRTpE6t0VrqtHps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=jeLTI0B/iGD4kYv1X6OzcLyIqcUp9pAx63SDlbSVBTrPjzAMsGIMXLWcuk5rdBm81
	 XOmLAGFOynjdiHiWnc4yUjZsGXM5xsGwx+qhd6heNdbSlAiUO6ULewRMlwvcKd1MuJ
	 gCkOMqg3pnnXgZrSA71kRR1um5A1qpJD8azBFvBGDKpnNx/6fBClFWSzlffVMeBiu7
	 gYG/OqLeEEmDZDx5L5DXMa2e+viiujjU/7296/n3KgKeCJ4NKj9Yfpog0HtU+6K6oY
	 Lk3d8/8f0sQJtgeYlp1wqYVxCM+OOwK9++JWj+8uFFwcq1r6AfgEAum0M5QoJYUbyL
	 4sY7XEAIxvByw==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a2336591d48so72624866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 07:21:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704468116; x=1705072916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lY3Wm0rqUAhsDJUxSGP7DuG2vuWegRTpE6t0VrqtHps=;
        b=YDeDMNX7vhnc+IdV7GaJKazm/gkEqfI/RcWEPWAM6XlUHewL+LsZ2/i1uLOknmUO5m
         bLvx31K1QYniWjALqC9kH50ZhaK3ioHWwjLplaRHYCDoLwHMMsQQv/6Jlc51Mi69SD6f
         R7ZVyv654nCVwzHaiVnMEj0M5rbrZPmOLcu/Agt2TAkuP1nRknwWgLjaS0UYMY2GU42k
         m/vmng+Gm6/dOhU7VnnBzizb7O1obxckgVjwlnyeUhC/ALdcfAVIySxirAl04GEzaRtz
         lkG3nOWLRmxZqEwUqoOXNukXYEBs+jXPWKTiYWIk/474hHOqYrlQsrtXDXZSmos/LqHQ
         2hjA==
X-Gm-Message-State: AOJu0Yw+XhD7ZyHvD2bXAZ/5kHU/jdxySFht0JsOXsGJ7BGf4NxUKmr/
	arBYLV04jmEh0bFQTnjMaXikL88Y/2bP77284Bp+C2zsSmT+X11u3+J57Kp3vyvHD0uEYaM3b1x
	MV8khPfE4dn94L5I9aevTFiHXfkJZfkY8gss1h5aWU659xT4o
X-Received: by 2002:a17:906:270b:b0:a28:e451:b023 with SMTP id z11-20020a170906270b00b00a28e451b023mr1093669ejc.145.1704468116335;
        Fri, 05 Jan 2024 07:21:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQY4isbmkx0ezLO2LhTLTYXcX8Thqdvs1vKKmu4JjT/DRJLBcJ+3Na9NmK4+yNkl3jyGF0vg==
X-Received: by 2002:a17:906:270b:b0:a28:e451:b023 with SMTP id z11-20020a170906270b00b00a28e451b023mr1093664ejc.145.1704468116100;
        Fri, 05 Jan 2024 07:21:56 -0800 (PST)
Received: from amikhalitsyn.lan ([91.64.72.41])
        by smtp.gmail.com with ESMTPSA id i23-20020a170906115700b00a298adde5a1sm345630eja.189.2024.01.05.07.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 07:21:55 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] fuse: use GFP_KERNEL_ACCOUNT for allocations in fuse_dev_alloc
Date: Fri,  5 Jan 2024 16:21:28 +0100
Message-Id: <20240105152129.196824-3-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105152129.196824-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240105152129.196824-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_dev_alloc() is called from the process context and it makes
sense to properly account allocated memory to the kmemcg as these
allocations are for long living objects.

Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: <linux-fsdevel@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 2a6d44f91729..b8636b5e79dc 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1415,11 +1415,11 @@ struct fuse_dev *fuse_dev_alloc(void)
 	struct fuse_dev *fud;
 	struct list_head *pq;
 
-	fud = kzalloc(sizeof(struct fuse_dev), GFP_KERNEL);
+	fud = kzalloc(sizeof(struct fuse_dev), GFP_KERNEL_ACCOUNT);
 	if (!fud)
 		return NULL;
 
-	pq = kcalloc(FUSE_PQ_HASH_SIZE, sizeof(struct list_head), GFP_KERNEL);
+	pq = kcalloc(FUSE_PQ_HASH_SIZE, sizeof(struct list_head), GFP_KERNEL_ACCOUNT);
 	if (!pq) {
 		kfree(fud);
 		return NULL;
-- 
2.34.1


