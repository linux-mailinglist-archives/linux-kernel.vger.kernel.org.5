Return-Path: <linux-kernel+bounces-143844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E32A8A3E23
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 20:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C851F20621
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 18:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500FF53816;
	Sat, 13 Apr 2024 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3hMO5sg"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD1C537E6;
	Sat, 13 Apr 2024 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713034158; cv=none; b=l0VbUdQzrP6ud4ThZBc1+cAGuFtDd6Cmy99bNQs6dh1f+DazlsAw7V1LPb+p+r6xWNgEGqlJwoxyYJs91QYJRb8VNX6c7Yyok9Tt5iyINxHlVzedFbDF7hVT5uALJ2QanVqPINh1oO8g/6XRCK8KYv7SG6r1Gis6OoJETRnzUhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713034158; c=relaxed/simple;
	bh=z5FQ/+JIFzZLsKnwxuDvNC7NZmX+DCl2VNkM6o23eSg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z+ASSSzJn3z7nznTcEtjW006jj/69bGHOBah6nvhspnKvA9S76PvqVdkNfZ/DHBVf14PhyxJDrRXvINYJsVs98GsBpzgdX9Jy0N28eWVY8YFrdjNYaq7gjjOg9p07nlbalHHTlWHpVaBtcv9iDBtBVq1NDL9IBUVuIN4HHSY3dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3hMO5sg; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-618944792c3so9375407b3.1;
        Sat, 13 Apr 2024 11:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713034156; x=1713638956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=160OjO5rJ+6EO7hckAf9kwMm6qEF4sLw5PXx2sn7OvA=;
        b=P3hMO5sgXSX6kfQnVgP9WBDqm/IQgUoo+/OZMbQ4JOspC+SOLWZic2I3afJ3j6smxp
         tCY8gfbWYsk5CWJrBnYPKnJBz6hqaXjlWdKEwueUAHGV/gFrlqBK2GKD/lS77Vtv7/nU
         ATn3dLfjo3YoGCZ5k8ZJmOqPtC0FzppyIqjeKcIzim1PTlJGOWfJWJCgfGf+Vdzqa1EW
         5BfEdYFkxuIu70FMnqhhwOoerGoKgIHHdRzjUPIeOB4VG0WoYrJxJ+zkkKzUoOP53PWp
         ijIx93PnVNl7BU3MR4XPe69Loz+cV2V4hgG0eCVCczonLmeyowg18XLmI1k01W/eBS1c
         E9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713034156; x=1713638956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=160OjO5rJ+6EO7hckAf9kwMm6qEF4sLw5PXx2sn7OvA=;
        b=eDOABbkm5j/prySW1hGeIpWsx9UAEjAZJ/xPiJeYInp2HDjd83TR2FRBdQuQ5ygOAl
         PfgjO/8k6t3ZhQ5TEpNrd9G5F6kGriYFeWggG15mrGjjJfRuOp9QAjOI+SqvVFGRbg3m
         sFEZ9RoC1nHG8ophi7GTjIqpX4p7FAwxMo897FyVPMLP0/H616Xmj0iW3QTVJctZKdlr
         Izr89AEhIAfGq6fvcvyul8COf80lIuIAzUHce0Qh+gVG9KPCZf7lRfLw94dpCcUXJunI
         hVMabxKX1Lc3m59Q+mFuW3j0KLwRMCIqjmHzG0QrB96i84n2VgvLJYpRTUscg4gTobVY
         g5zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuX8T3VQR1Fi60zeoGnVOm5oZP/3aNagVXZwQ+2/Y2B7qXmuuJWpDFiF80fXoukRaNlwWYJW/t23SdFTdXXv+eLQ/VInprHS7TEyKwBHaWqAhMoalOgO8qC12EKE3t1AjEyP9azvln5Q==
X-Gm-Message-State: AOJu0Yxif52ayPX3fcIvcSYIqxTItrXZ+125hLpo9u+hRT/5CIO8rh7R
	ApHZ0wJTtva2488GF3K3fl5XHO/Jhb2BLuv06RCwwCZ345ufZ+4Ch6ePNA==
X-Google-Smtp-Source: AGHT+IEVjHmFoEl1AYMhS97dzrWkQXhK8NSU71a+3aFFmsOqdyhU15s4H0okQPP0caOTw9tOzhjTng==
X-Received: by 2002:a0d:d794:0:b0:609:ef57:2266 with SMTP id z142-20020a0dd794000000b00609ef572266mr6214284ywd.34.1713034156101;
        Sat, 13 Apr 2024 11:49:16 -0700 (PDT)
Received: from localhost ([69.73.66.55])
        by smtp.gmail.com with ESMTPSA id k4-20020a81ed04000000b006145e0aa9c5sm1312426ywm.60.2024.04.13.11.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 11:49:15 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] MIPS: SGI-IP27: micro-optimize arch_init_irq()
Date: Sat, 13 Apr 2024 11:49:13 -0700
Message-Id: <20240413184913.69268-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function sets adjasted groups of bits in hub_irq_map by using
for-loops. There's a bitmap_set() function dedicated to do this.

Because [0, CPU_CALL_B_IRQ] and [NI_BRDCAST_ERR_A, MSC_PANIC_INTR]
ranges belong to the same machine word, bitmap_set() would boil down
to an inline wrapper in both cases, avoiding generating a loop, whth
the associate overhead.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/mips/sgi-ip27/ip27-irq.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
index e6ca34cc9853..3c3a4b56ab95 100644
--- a/arch/mips/sgi-ip27/ip27-irq.c
+++ b/arch/mips/sgi-ip27/ip27-irq.c
@@ -279,11 +279,8 @@ void __init arch_init_irq(void)
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


