Return-Path: <linux-kernel+bounces-138117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D05F89ECD0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E2EA1C21D3F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610E313D623;
	Wed, 10 Apr 2024 07:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+JlGm83"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9C113D536;
	Wed, 10 Apr 2024 07:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735800; cv=none; b=HVV5SOdvVyHMV0raASmkTDMzel+zecfuHGi0ubMojycy9aIaO1ddvh6pnk367QKnzd4rEK8l40rD91w+jX0D0njLRr6Dg3sXuF1VetaqVFdjZ4d/VA4/nriWMtaWbdy9mpp4CFxQTYt7obSZyFAy6CjWSacuc7F2nZ2KsZxi+Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735800; c=relaxed/simple;
	bh=NK+9z+w7+F+nA2B8FMvVvcdDt6QdhjD/HlCTA9qMDpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VEmB3GgT6rSIZfQTTLmJtKx59J3d4awCMFtrfy7wMCeH4gpJkmlQhfP6cOi823HLeY+5kHYrA7k6Hl6bfU+WoDSe/7PlxsdBMHY9EmHNgZFqBvhwvPmKMN4+jthKs+nu1ivanlvF7L+ztn0A6xTizA2omUZA5BpcddB2hqZUpbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+JlGm83; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-22edbef3b4eso1341983fac.3;
        Wed, 10 Apr 2024 00:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712735798; x=1713340598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aVuwGhJrx8wB/LK417AXzSlyIW3TeS0s0fLJhVHG8Y=;
        b=T+JlGm83UTnTLe2JcoQRwc/7xbwrzi0Feam1Bnh9TqvGEbGS5YJdxK8/pU238qIBBy
         bXQsbyknkIep+SgiXTZY+ufK4jw1DsaQ35vOd0ixAhX+Q9JfeJjxV3xNJXOC2Mu0b4eK
         2eslUEg9PPSIhW74EdL8CuntoP5k0P4DjMDMA1+/y2+WyBQs4iRceZNqZCNIbxRu6fc/
         Vs9q5C7rd8cxGlJ55jiOe1ufXS2+xLlkfjwwliySho8Tw6d1D1Z+Lk1qbTPq2fdVGU2p
         HzZ1A+z7tepO3qvltp41shaXwZPZzPYVLzSdkux2IGSI4zZudmIQYawBh80YQk5cxF+P
         4yow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712735798; x=1713340598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2aVuwGhJrx8wB/LK417AXzSlyIW3TeS0s0fLJhVHG8Y=;
        b=M/lMbSOhlWl6PpKMvPPTXk+mnib/K3ftLWsxvNv1MMwak46TF3TIJEkC1vEUuEAOZw
         lxw1E6FX2RJzuq08GSqS4Nn6mobq4r2zMUQd9WH4OnR2LHKjvBIi4t8vK8oO97SY329D
         UCGJ+TFzZQbjRsWBrS0BBI5mxOaHUtfT++4BsiWw5JvikMZIJOu/BMJTrOuGvXzyCIGY
         z4MHmXEVe61zxLYTyHgpCKqwSgSOStZBXx5AscrFEjiDON8nbn70g265O/zWReNZ+00t
         pbtsKrxiyajnZRVut3tIAGuoJn4+ys2sgDUMByXUIB25HK140+c+5WxeXH6n7Hmv5zM+
         VXtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg6sXKPDRWNyOT/eEDAz4dNEyL+8jGBVbBKbDjHXy3RyGwivYmi2orGQY2at3CAPIzAXShEVb3X5IAJfIGBd0Qrf8b1lWGrMPcZE6t
X-Gm-Message-State: AOJu0YwOYV5vTLXB/6wlYSZetQt9R2Ss56/FW+6CtFv6WxCauX/4L+t4
	PxmGVGDG7oqs9kz7fvuSD108k/5chTJkkmJkWEq1YdHItA5TgpUhuYv+gN51
X-Google-Smtp-Source: AGHT+IH9osrCI36emc6JIk1jeBcIIa1Q90tsCaYR3eKskcsTlgIqMYq9W1okqrrC/Y4P/3Kkb+Xnng==
X-Received: by 2002:a05:6870:40c6:b0:21f:aba0:772d with SMTP id l6-20020a05687040c600b0021faba0772dmr1939811oal.39.1712735798255;
        Wed, 10 Apr 2024 00:56:38 -0700 (PDT)
Received: from carrot.. (i220-108-140-44.s42.a014.ap.plala.or.jp. [220.108.140.44])
        by smtp.gmail.com with ESMTPSA id 3-20020a631843000000b005e485fbd455sm9438001pgy.45.2024.04.10.00.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 00:56:37 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs <linux-nilfs@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] nilfs2: Add kernel-doc comments to nilfs_btree_convert_and_insert()
Date: Wed, 10 Apr 2024 16:56:28 +0900
Message-Id: <20240410075629.3441-3-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410075629.3441-1-konishi.ryusuke@gmail.com>
References: <20240410075629.3441-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Li <yang.lee@linux.alibaba.com>

This commit adds kernel-doc style comments with complete parameter
descriptions for the function nilfs_btree_convert_and_insert.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/btree.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index 65659fa0372e..a139970e4804 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -1857,13 +1857,22 @@ nilfs_btree_commit_convert_and_insert(struct nilfs_bmap *btree,
 }
 
 /**
- * nilfs_btree_convert_and_insert -
- * @bmap:
- * @key:
- * @ptr:
- * @keys:
- * @ptrs:
- * @n:
+ * nilfs_btree_convert_and_insert - Convert and insert entries into a B-tree
+ * @btree: NILFS B-tree structure
+ * @key: Key of the new entry to be inserted
+ * @ptr: Pointer (block number) associated with the key to be inserted
+ * @keys: Array of keys to be inserted in addition to @key
+ * @ptrs: Array of pointers associated with @keys
+ * @n: Number of keys and pointers in @keys and @ptrs
+ *
+ * This function is used to insert a new entry specified by @key and @ptr,
+ * along with additional entries specified by @keys and @ptrs arrays, into a
+ * NILFS B-tree.
+ * It prepares the necessary changes by allocating the required blocks and any
+ * necessary intermediate nodes. It converts configurations from other forms of
+ * block mapping (the one that currently exists is direct mapping) to a B-tree.
+ *
+ * Return: 0 on success or a negative error code on failure.
  */
 int nilfs_btree_convert_and_insert(struct nilfs_bmap *btree,
 				   __u64 key, __u64 ptr,
-- 
2.34.1


