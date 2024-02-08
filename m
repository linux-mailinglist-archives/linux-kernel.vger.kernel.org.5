Return-Path: <linux-kernel+bounces-57384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 462E684D7BB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC791F23638
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B8C1D55F;
	Thu,  8 Feb 2024 02:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tb7BB+XA"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2C41CD33
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 02:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707358514; cv=none; b=YKcLZk22znhnnDql9SEGHiBbPPlhju3fXwtbFQ6wJWaGkoPQUN09kYSlXZngU0sKAwyBinK2sicgfeB8RYGVV3mGJbcqyHgNFi313aWbXdg4j1sipQ7l/lQ4nb4yKDjYgwgrtkZIQXHIIjEyJbU9WoVWilUIPxxD0X7D5adycw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707358514; c=relaxed/simple;
	bh=5jxQ7rp3f0TfsHJmSsqDidV/zOA9QMWktfKvmoRDLc8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=QOIieDerG9+YoYbo4BX7EfNr5kcGfi/1cRoGhQSAlAjYGE8lF6+0c9nNzZ1LtN//1ZYyZfOEM4Q3x+kBlzkLfrXzLkVVcUc+7WW08HQuH0Y29aJgJGz1WETmmfy5deAOCuMcQZqNLHaQ3Z0IDzfRFfXu/uuzu7NGIhXkudhyN7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tb7BB+XA; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a38392b9917so175008366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 18:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707358510; x=1707963310; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqBzT3onXCur0xX254jJErRIXH3jmw1EamFLcd9YzN4=;
        b=Tb7BB+XAnN5jnja119O5lz0O1/S9lV/Ud44F91OQ8GpJ8ByFIaIUR0bIHo9dk+laoG
         rr6g+htvlnAqk5I5GSG3/zWIUeAEUbWch5eJWNsoWWJDbXcIq7bvJW8xJQGcVnzPu5zQ
         vy5FqKDuEhuH0Ofw7tMB7MsJa7lcw2GEZSfnPtb1wWeVhAhXpzdt/CjUsZeB2R1fhm4M
         uAUEGpkqlMF0KQi8WQPZIAkwETz2RXT7WQpwZbpU5nhBLOhSVCnjh8vDclfAi0swLmvO
         QP9Xnz0IfL7wnnLMgt/+15fafJkn7Bb/GYN6XZkgHd8UL26BQ6gHr1yaAgOYZwFKm0Uy
         Jx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707358510; x=1707963310;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqBzT3onXCur0xX254jJErRIXH3jmw1EamFLcd9YzN4=;
        b=jf2S/eSjnYeTGlJuNLCt+HZaH+pNHl2OM3tqWZaSL0hMN4Zmd0LLwqXsfGaTzI+0tP
         Kif3iHAIeuo9Vlo1SH1O8EB/XmcgpQE9CeSVMz68nzeb9LOLp6xS7C79Sm2yn7QJsD6f
         +By3JmBLt5/8NV3O8FluWkpm8efkYspQwzHDEaU65cHKDWVPHC8jJXZCgESFrcOe6uMV
         g8IPGCxVD5hgeIESVTlnFJzYQ5HH7n3RevmJY1SkaFWgEwYEmZVB66ri4z3UPmD6FNYJ
         nUlVb8rLStTYNc1XnQc3SfRKSCWLHYkGQGrgxfYiK/I0xqQhz/dJPwGNv9O1i/ZBomVO
         3Mow==
X-Gm-Message-State: AOJu0Ywtw8GU5h3phIEMkX2iY5hoerAQeqxh7YHkqvejhv2W6J21feVD
	Jo367aiTCOiBWSoB5Bqca3bu2MMRMiyoaMMzFIjp07jGh8vYxtOTa92ETgGolUM=
X-Google-Smtp-Source: AGHT+IFvU8Q7TZtGJU7lnWqe8LgioR/V8i52+j7LR2yorZaHv42mXXZYkBDWPSURlIZ9yGz3IWJK4g==
X-Received: by 2002:a17:906:e085:b0:a3b:a2c0:5013 with SMTP id gh5-20020a170906e08500b00a3ba2c05013mr206142ejb.41.1707358510483;
        Wed, 07 Feb 2024 18:15:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4Dw7O+E8AuHda3gfIDvoRpUdSUClgAqA/qeaRGKS/QrPpJXPuYBRA3TD7Qvsy5ucf+CJa1pnSqurNC4Gm5QOxN1IUpLctefmnFduYPI50bpyOAd6u6eQvNLXh9qN7A6b9/Pq5/jGMewyR6AIXvixtiZ8YfLhTZ1xidoLnmvtslNJoyoBsb6c=
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id e18-20020a170906045200b00a379cc90bdesm1368447eja.199.2024.02.07.18.15.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Feb 2024 18:15:09 -0800 (PST)
From: Wei Yang <richard.weiyang@gmail.com>
To: elver@google.com
Cc: linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] list: leverage list_is_head() for list_entry_is_head()
Date: Thu,  8 Feb 2024 02:14:23 +0000
Message-Id: <20240208021423.15704-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is what list_is_head() exactly do.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/list.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index 059aa1fff41e..3dca3760f726 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -766,7 +766,7 @@ static inline size_t list_count_nodes(struct list_head *head)
  * @member:	the name of the list_head within the struct.
  */
 #define list_entry_is_head(pos, head, member)				\
-	(&pos->member == (head))
+	list_is_head(&pos->member, (head))
 
 /**
  * list_for_each_entry	-	iterate over list of given type
-- 
2.34.1


