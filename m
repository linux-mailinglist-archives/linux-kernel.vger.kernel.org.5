Return-Path: <linux-kernel+bounces-104449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FFF87CE0A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFBD61F21BF7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71942286A6;
	Fri, 15 Mar 2024 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="PAw1XvAg"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A1825613
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710508977; cv=none; b=B1K3AfABo8FD0IMxnUMaVH4cDQbE/7RkYAVfzhghWXfwuQ4XE8XFha+c0v+dcqG1GnGLrVH6fD8WNXZceR3F1cZZuG6vUSNdjdJaXvSPT2OuU8QkxdGG81JgdRp9sF1oClz/HtQZQb8nopiymDTlfGoZeKs3tKtdPoJMwy4ABpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710508977; c=relaxed/simple;
	bh=ncOu9PjHTBYZwOVfZ7jZrW41AsoJ6GPzUDAM7PL1k1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bT5xDy7ibU9TRky/8EuSD3KR++Ud/ZDFJ1ztaQl/gycl3oYqeTg4ojYLvg+2Y25okZ4R5BIgHTRRhynZV3uQpsKlAduZ5ILw/jpyYS80o/V11pFug8tcRYHecpoAYUz3lbWUC36x4eppIvucfZ5ZDhbcsTpJVKQayTQ35jpKWWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=PAw1XvAg; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33e8f906f3dso1683383f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 06:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710508973; x=1711113773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ky6vAjI9f0v11GIeHx/FRiwL3E84H7dHD+VaFVnUoDc=;
        b=PAw1XvAg3CcfAgMfyTBrcHIF/sADQLL/nuyiLv9KizengcNTCOaY/W+OS81b+/of71
         5cU7o0HZt1+jnXSim70UGiG50yC8PlbGu+W0sA5cZ7FKEr61udWDJzzCfR2JhFf+FZ7Z
         F2sisbpLkk/frVG8t4HMbDLrd1aJIUr5ehwuv19RFu4/lFr6tmZt3a4tIGVsJYz/AJf+
         8ZXljbezT/NgV049T/mQ3llHLMNMr7xVbnxTQsOq3gYROLF84x9O4UDkQbfTqKMk10AA
         FcJDWapFbWk4HZ3j+pbRzdmS1ISx4aBNgafK4Rcm++PfYRYITllvVr1lmMUEgDg98tPh
         DDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710508973; x=1711113773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ky6vAjI9f0v11GIeHx/FRiwL3E84H7dHD+VaFVnUoDc=;
        b=OOoZReHDUO948zr0I5/jRLr3zy8ixWamfgWtbJwS/mUHVyNrG4mYYNuQLDVSAQE2xC
         8I7MVqFHWlxLXg0IWKYPpjcR1twR0Dw2xgW4/R6H6FAYNRtnF5qTiTYEvO4pDmX2WA7q
         fOa0bmi1YM1GNPNeFpiFzRq2czRMJ+Xz+2HraQq4TI4F25sSBI3qD3DrLSqD0DenskT9
         pX5NorMIXrV70aD6D/O5vdvHLmhlqaEQ/ZzTb2NmXea6Qpjz3ZJiptDD30QanMmNCqyq
         CucV8z2/qOfdDuFLJI3UkPnAmccQ9pY9X/iiaHPh3WVRChOf7HSzwvY0LtN0e7wThfjn
         m4JQ==
X-Gm-Message-State: AOJu0Yy+WkxK9zadFZkf13doxPB6K/Xc/MwmZxkzp3Nefm0RF9nNAslZ
	vBuIbzFU5A5U6rdxmbFAUFWzfKkByEfBf+5PxCx6fP3qV9BF96JatzZhceSMD3g4krnatEKgFQs
	2
X-Google-Smtp-Source: AGHT+IFJIfDzLBZHYFFv5q+DtD8ZNb3FNmX0Ys0zfHXnAB38q/hnFQ4UzJJsGVGLhBIPMsCjUGT1kA==
X-Received: by 2002:adf:f105:0:b0:33e:8aab:fde7 with SMTP id r5-20020adff105000000b0033e8aabfde7mr2174237wro.28.1710508972677;
        Fri, 15 Mar 2024 06:22:52 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id p6-20020adfcc86000000b0033ec072a491sm3196443wrj.35.2024.03.15.06.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 06:22:52 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	mingo@kernel.org,
	danielj@nvidia.com
Subject: [patch RFC] mm/slab: introduce KZALLOC_FREE() cleanup-ed allocation macro
Date: Fri, 15 Mar 2024 14:22:49 +0100
Message-ID: <20240315132249.2515468-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

With introduction of __free() macro using cleanup infrastructure, it
will very likely become quite common to see following pattern:
	type *var __free(kfree) = kzalloc(sizeof(*var), GFP_KERNEL);

To follow the CLASS() flow from cleanup.h, introduce a simple macro
KZALLOC_FREE() to wrap this over and allow the same flow.

Show an example usage in gpio-sim driver.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/gpio/gpio-sim.c | 3 +--
 include/linux/slab.h    | 3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index c4106e37e6db..997237b3d80c 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -1496,8 +1496,7 @@ gpio_sim_config_make_device_group(struct config_group *group, const char *name)
 {
 	int id;
 
-	struct gpio_sim_device *dev __free(kfree) = kzalloc(sizeof(*dev),
-							    GFP_KERNEL);
+	KZALLOC_FREE(struct gpio_sim_device *, dev, GFP_KERNEL);
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/include/linux/slab.h b/include/linux/slab.h
index b5f5ee8308d0..baee6acd58d3 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -711,6 +711,9 @@ static inline __alloc_size(1) void *kzalloc(size_t size, gfp_t flags)
 	return kmalloc(size, flags | __GFP_ZERO);
 }
 
+#define KZALLOC_FREE(_type, var, _gfp_t)				\
+	_type var __free(kfree) = kzalloc(sizeof(*var), _gfp_t)
+
 /**
  * kzalloc_node - allocate zeroed memory from a particular memory node.
  * @size: how many bytes of memory are required.
-- 
2.44.0


