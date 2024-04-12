Return-Path: <linux-kernel+bounces-142796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4FE8A302F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40AE81C22FF2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715E785C7B;
	Fri, 12 Apr 2024 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4MuP/Vb"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0DB85939;
	Fri, 12 Apr 2024 14:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931008; cv=none; b=Y3DWvMG7VvzVu6SCI+Q2Fo9DZTdkSq+ugMNtmWx3Wer/OyvUfCrreWMVk4UBbNyWiQuv28kXV6oQ+X010WTbXDKkETNn0era+u00zuyOpaV6I6eWrTe8mKXEg6vxjGfF3ta1aHXIfSFbr1HFBtmh2md2RLYNSo2fU8X6ozzSOTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931008; c=relaxed/simple;
	bh=kP5fvy0TH4cELyJB6+wTRXk3uN7OL9Rtm3SJaT9RpWU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iMF/dbEDtKsLmMmhNRNh8GWh8orapvnPxWsg+1Y5yf8l3+Iyh1XUDUfdyspFQiW6bT+NP4UIXIPFeJF9HC/+u56x6q2vw7P60Y8+7D4bjRhFWytSG6PCi3nyEFkhpYxoMR+FJB8ysCHNa/T5VZc06QR6HjseRoQapy7SfOS4A14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4MuP/Vb; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ead4093f85so843235b3a.3;
        Fri, 12 Apr 2024 07:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712931007; x=1713535807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2v42DRWLOed5JT4EgzNbhffgc6QDunSBW8zl0fYmT1o=;
        b=e4MuP/VbBGS8nQ/JYdnIjH60gpqMxMM9lMw3FzyzknUen5n6biaKHIJ/vB9XMaMmsB
         0s3H7X9lgnAcCVnwdcLILHE9aEjyqXPRPQwUTiDwdz7TpkenP4WvvzNTvkT0xvUk68i7
         DsgVWv6ivxzro/EC0EmOcjLl65UU0Ga6l9xIpztELVFooT9H07nwaRJt9RlKcD5oC4tq
         TzGYdQy3UVppoeMOdE4M4H9g9Ply3Lkzp6CZhzYOQKYpyo7XK9JyCG1jzHrSqO+7oqMl
         R/1sFDJWxHc/0ADPtI8flQj5Y8uTIM9RDEavjltEJfZt81ZZV3eoTJG85a9SueaNCGud
         p93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712931007; x=1713535807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2v42DRWLOed5JT4EgzNbhffgc6QDunSBW8zl0fYmT1o=;
        b=Yx+sBokcVHleG2JDuoM7iZk90O9j2Kr14oimGhrNiTaB+WEywy1V81+uhtZBtMuWOS
         b/H3Mzimtfml+MY0tAN8KQAf5cYz2q0FAY5I1mhrth+jZDUr8br8yC1CNkr03D6nEWQn
         qjJMLCRx7XbDcgcE8MEvJkf6TJuK5KYj/EABmVKYBAPYbeE24e1BAl8BAEls1NgS4k6B
         7m0BBhM2SjGym84NJc+go82KRGq/m3IrF4a+PXt04wyyAZwNJziFunEWvQ4SD7M5VacN
         iXyXT7BijJLp879zZEaMEvUGzR260c97t5sW9Zhl3l5p1lK5IfNSlZxF2OzNbl61kMMQ
         8+Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVOqIOCsgX6M1K3sVHDBDtWzy5Q62yW33LrzkHDhhMpnkasuz6HU/SxfgJfNVn8aR+xQsIL/x8o3ndX6gcqnIhFXZrCgQzW0XkGR7Hs
X-Gm-Message-State: AOJu0YxYzP7NH4qrerqWnUEt0ZEVsbTI2Ge3fD+cvH8P9VrJzL0XYGcQ
	3vsNnruQY2yTxZCbo+twVt1rQ+1gOTuDSLGfSr/E8FaDNMImxAKk
X-Google-Smtp-Source: AGHT+IH7orDCennOSoOpM4csAtd1nOIzQ98Te4TUM40YXNz30NaMamD7uzGZdLOkGv50W9tB5WjtwA==
X-Received: by 2002:a05:6a00:b4a:b0:6e8:3d5b:f3b1 with SMTP id p10-20020a056a000b4a00b006e83d5bf3b1mr2703700pfo.22.1712931006678;
        Fri, 12 Apr 2024 07:10:06 -0700 (PDT)
Received: from localhost.localdomain ([49.142.40.215])
        by smtp.gmail.com with ESMTPSA id c9-20020a056a000ac900b006e647716b6esm3006425pfl.149.2024.04.12.07.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 07:10:06 -0700 (PDT)
From: skseofh@gmail.com
To: robh@kernel.org,
	saravanak@google.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daero Lee <skseofh@gmail.com>
Subject: [PATCH] of: of_reserved_mem: remove repeated call to get no-map property
Date: Fri, 12 Apr 2024 23:09:38 +0900
Message-Id: <20240412140938.137803-1-skseofh@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daero Lee <skseofh@gmail.com>

In __reserved_mem_alloc_size, of_get_flat_dt_prop is called and checked
whether the "no-map" property exists for the node. In
fdt_init_reserved_mem, the only caller of __reserved_mem_alloc_size,
we checked this again for the same node. Therefore, repeated
of_get_flat_dt_prop call was removed and 'nomap' was passed as an input
parameter to the callee function.

Signed-off-by: Daero Lee <skseofh@gmail.com>
---
 drivers/of/of_reserved_mem.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 8236ecae2953..cb86a28379c7 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -254,14 +254,13 @@ static int __init __reserved_mem_alloc_in_range(phys_addr_t size,
  *	'size', 'alignment'  and 'alloc-ranges' properties.
  */
 static int __init __reserved_mem_alloc_size(unsigned long node,
-	const char *uname, phys_addr_t *res_base, phys_addr_t *res_size)
+	const char *uname, phys_addr_t *res_base, phys_addr_t *res_size, bool nomap)
 {
 	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
 	phys_addr_t start = 0, end = 0;
 	phys_addr_t base = 0, align = 0, size;
 	int len;
 	const __be32 *prop;
-	bool nomap;
 	int ret;
 
 	prop = of_get_flat_dt_prop(node, "size", &len);
@@ -284,8 +283,6 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
 		align = dt_mem_next_cell(dt_root_addr_cells, &prop);
 	}
 
-	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
-
 	/* Need adjust the alignment to satisfy the CMA requirement */
 	if (IS_ENABLED(CONFIG_CMA)
 	    && of_flat_dt_is_compatible(node, "shared-dma-pool")
@@ -451,7 +448,7 @@ void __init fdt_init_reserved_mem(void)
 
 		if (rmem->size == 0)
 			err = __reserved_mem_alloc_size(node, rmem->name,
-						 &rmem->base, &rmem->size);
+						 &rmem->base, &rmem->size, nomap);
 		if (err == 0) {
 			err = __reserved_mem_init_node(rmem);
 			if (err != 0 && err != -ENOENT) {
-- 
2.25.1


