Return-Path: <linux-kernel+bounces-23168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A499382A88F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81CE51C233EE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D21DDB6;
	Thu, 11 Jan 2024 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iGEA8wWS"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0451BDDA6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d48a8ed85bso11931835ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 23:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1704959563; x=1705564363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=boeF34l37rPHQaYGqB9mI3IbjEfH4gVZPW67x+BNni4=;
        b=iGEA8wWSuhTR+QT3WYvuHtsPgbfDqExUVTM2i4ZJl6LZWKMydb0lvT4VXL0C6GVAHk
         JtSZk2NTqEhOLQUP/kJlnvU+c1CIlo0/zvtZijrA/1K8YSYi5hEyJA9uibz7WW8u1Hjg
         baHlWT7ZSSV3hLhXvAU8/lMBDRgcbphn96Gz2+uI2UpAPYORthmWjQ+nQmmMMWZvR2tt
         B7Q3PjjzRZu/+h0QwdQhEETTcOeELnrsyMRfa4BrpSi8l2XJSXN2LTwLawgnxMz4q7mT
         tMuI3PdKQrXyqLiDjo85irqVeDR5up1NqCpTHrU4CgHyRfKMxMFNsN3MoRXUdj8PvCIh
         MSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704959563; x=1705564363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=boeF34l37rPHQaYGqB9mI3IbjEfH4gVZPW67x+BNni4=;
        b=nn5v5sRTsTQXbnKJwZGoFTaxg454voQs3dS8in41yiYFA2kg9NF9v3kO6o4xUfJbd+
         BjIXqe4mfCy5jLMAyQH9GAySQBcvz9u/XnZjkRj8kl8Flyfmw2i+2zCfX0vHtF5nPIpV
         V4n87IL6n3Ic04T6kXEtzv7zOZKP8Mmm0Qnp3GkzW0WRuX1rXj48LcarCRcND+fdp0f0
         TJewHO0ZDhHs8+BI+jMpFLKq+ht920cPF5Uv1pWZR2KFGHmjv9CEEDCv2YxWpUZbnXhP
         X30kMekUGSjjlOeGxFhE5mdIe5Izl0o3pwgnPCsLB8ivGK0j0BZtY7FXK+FP3ulBK2jT
         zniw==
X-Gm-Message-State: AOJu0YwSRjC9pZAjMPydctsPJ72p6CrN1cMSallcr7seegNnjCnkXRix
	X71ESJRy5zhdUKhOSOAdcHUIEgZNf0iIbA==
X-Google-Smtp-Source: AGHT+IG5RE3IzDCkPvGnKomBTn8Zx4TrwD0muWO0J+kFVVl5U32Nzm4eoLJnPYJRAG+M6ZS0tae7nA==
X-Received: by 2002:a17:902:d4c6:b0:1d4:e1d7:373d with SMTP id o6-20020a170902d4c600b001d4e1d7373dmr1483452plg.6.1704959563289;
        Wed, 10 Jan 2024 23:52:43 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id v3-20020a170902d08300b001d4a8fcca5esm545544plv.9.2024.01.10.23.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 23:52:42 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: akpm@linux-foundation.org,
	david@fromorbit.com,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH] MAINTAINERS: add entry for shrinker
Date: Thu, 11 Jan 2024 15:52:19 +0800
Message-Id: <20240111075219.34221-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the shrinker-related code has been moved to a separate shrinker.c
file, it's time to add a MAINTAINERS entry for it.

Dave, Roman, Muchun and I have all worked on shrinker (development,
review, etc) in the past period of time, and all of us are willing to
continue working on shrinker in the future, so I'd like to add all of us
as maintainer/reviewer.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a7c4cf8201e0..2d897e8c38fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19597,6 +19597,19 @@ T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/i2c/rj54n1cb0c.c
 F:	include/media/i2c/rj54n1cb0c.h
 
+SHRINKER
+M:	Andrew Morton <akpm@linux-foundation.org>
+M:	Dave Chinner <david@fromorbit.com>
+R:	Qi Zheng <zhengqi.arch@bytedance.com>
+R:	Roman Gushchin <roman.gushchin@linux.dev>
+R:	Muchun Song <muchun.song@linux.dev>
+L:	linux-mm@kvack.org
+S:	Maintained
+F:	Documentation/admin-guide/mm/shrinker_debugfs.rst
+F:	include/linux/shrinker.h
+F:	mm/shrinker.c
+F:	mm/shrinker_debug.c
+
 SH_VOU V4L2 OUTPUT DRIVER
 L:	linux-media@vger.kernel.org
 S:	Orphan
-- 
2.30.2


