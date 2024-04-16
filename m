Return-Path: <linux-kernel+bounces-147321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B26858A727E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41315B22C68
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA9E42058;
	Tue, 16 Apr 2024 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8WPemrt"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FC4133435;
	Tue, 16 Apr 2024 17:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713289038; cv=none; b=ID8Y+5BG8lqHzEajBe/tilwZkmA3ifSuAwowzPa47unIJ3SudfM/Fs614yW5kBGBae5RXTA9jPSPuOESvnYDd39Yi7wCZBbAvxPcopoe2Jtk3qdWfgtYbed27mMNb/RGHyNI8ojgbLND6T9bM2leSXTDoNd9LwwAXo+44hwVYNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713289038; c=relaxed/simple;
	bh=EjV2famXhIb7IZNI071UhvkpAcAeqfFS/DP81q74RJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b/meY4vDE5p/0VAM3cKK6Pu3+BMcWZjb9FUHA0OZtBXuLzI1IzeOyebKYZE6kn0K3JwKWxxo03id08Ym4/qmzoLvHhqGrBZzSqk8AtaasXLuPHRMTFXiN2kccT6/d37FyyfPBX5IHeVciB+rX5KQUx9+mtES7PIGMwqksK8IJ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8WPemrt; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcc80d6006aso4621907276.0;
        Tue, 16 Apr 2024 10:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713289036; x=1713893836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fu3d9ue0RJEN40rHB+pClBdAIk5T18keph2dg8V6BMg=;
        b=N8WPemrtbc+OeBYGbUOwmrMhLdu/QRn4aX4DP/AFgvMyTXEeWyOEKrP4DeAWd0cyvF
         XdYW7cIT/zTD3wg/OEJV5LVQsdgCEPAFqKzZBNrLLKfsd38HMb8QUj3bDxqPaaEhhdNp
         3OXzlAYE7leBeqbZhRRf2UWhWjc6qPomcfkw9R0EkCzwMizrzJjAKhzSuS6vNNE/eHzy
         TtxJKcalw9wXlLi/aHNXX+7wSy8WnpukYxkj/O4Eir6XAzqBBl7UeVlO6MZskjikjr0+
         cckAkxkGO8eGZoLEovP/fnYyMDsgDTLOU5ZjpdZgJ6OSbxC8oIek8JUIJtt4nVD2fHWU
         HKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713289036; x=1713893836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fu3d9ue0RJEN40rHB+pClBdAIk5T18keph2dg8V6BMg=;
        b=moxAzyODITX2Ojae6war1BnoG9xpIh6ZRND78AnsBVOXMlCZRRrZ7QrgMKRDvcAb6c
         Hx7NnfPZK18BFWtRpIG2TRKY7bGZ5VqX+fDyYdyJ7bDmKRo3N6y6xdKvfVirIKdLuGbL
         c86ru9MINaNcNAnH2MVofWkj1mtAlFGmQEjEOy/lkNEQMLTQ8RO7tZJZXGuoq8QpMz4M
         aaZ9qgL/XZXJe3BM4jfk0aRO82ZzvabrV2B74y6H4/1HxeNrhg3wHQUz1IsGhvgcoV+s
         UcePx7TYJmitxHvYN/SjO3gm6xe1APrVZGTgcknsTDLxJhFnTyEUgzfjdzW7UOsMVgxg
         lwLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/kXpUZz4+JjG1f7NSKxntqX9fU/JGcTwZWbTK8vGg6yhEYSJVakO4sGKb8/eOoOrtoEf/vcBBKhOeHi0pxE/d7qBauU9x4ByUF+veY1vxV1H07ZxoRf1EGSzT+jvg+JEfplq+CJE7Ow==
X-Gm-Message-State: AOJu0YztJWY736VBZE34ZsN90gCJW2KRjmu2atbLTYiKlWkny6pHJr81
	jrh5yqB+RlPypq1TRVxKjJXqzK+rTGEuquXr9hWaDMkIy3tiWpvYB11Lzg==
X-Google-Smtp-Source: AGHT+IGpi4j7BJBWcfngMBM3FmhJTvcQtjqX7peZRqeqRJXKrj9I7NEaTrypsMKeO6hPZwC3Bg44ew==
X-Received: by 2002:a05:6902:2b84:b0:dc2:41de:b744 with SMTP id fj4-20020a0569022b8400b00dc241deb744mr15263478ybb.32.1713289036231;
        Tue, 16 Apr 2024 10:37:16 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:2767:ac3e:3052:cd0])
        by smtp.gmail.com with ESMTPSA id c6-20020a258806000000b00dc6d51c8555sm2486186ybl.17.2024.04.16.10.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 10:37:15 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v2 1/2] MIPS: SGI-IP27: micro-optimize arch_init_irq()
Date: Tue, 16 Apr 2024 10:37:10 -0700
Message-Id: <20240416173711.613750-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240416173711.613750-1-yury.norov@gmail.com>
References: <20240416173711.613750-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function sets adjusted groups of bits in hub_irq_map by using
for-loops. There's a bitmap_set() function dedicated to do this.

Because [0, CPU_CALL_B_IRQ] and [NI_BRDCAST_ERR_A, MSC_PANIC_INTR]
ranges belong to the same machine word, bitmap_set() would boil down
to an inline wrapper in both cases, avoiding generating a loop, with
the associate overhead. Effectively, it would be a compile-time:

	*hub_irq_map = GENMASK() | GENMASK();

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/mips/sgi-ip27/ip27-irq.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
index 8f5299b269e7..d8acdf0439d2 100644
--- a/arch/mips/sgi-ip27/ip27-irq.c
+++ b/arch/mips/sgi-ip27/ip27-irq.c
@@ -277,7 +277,6 @@ void __init arch_init_irq(void)
 {
 	struct irq_domain *domain;
 	struct fwnode_handle *fn;
-	int i;
 
 	mips_cpu_irq_init();
 
@@ -286,11 +285,8 @@ void __init arch_init_irq(void)
 	 * Mark these as reserved right away so they won't be used accidentally
 	 * later.
 	 */
-	for (i = 0; i <= CPU_CALL_B_IRQ; i++)
-		set_bit(i, hub_irq_map);
-
-	for (i = NI_BRDCAST_ERR_A; i <= MSC_PANIC_INTR; i++)
-		set_bit(i, hub_irq_map);
+	bitmap_set(hub_irq_map, 0, CPU_CALL_B_IRQ + 1);
+	bitmap_set(hub_irq_map, NI_BRDCAST_ERR_A, MSC_PANIC_INTR - NI_BRDCAST_ERR_A + 1);
 
 	fn = irq_domain_alloc_named_fwnode("HUB");
 	WARN_ON(fn == NULL);
-- 
2.40.1


