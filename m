Return-Path: <linux-kernel+bounces-8804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC1981BC7E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76989B224AD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C361D5822B;
	Thu, 21 Dec 2023 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BaSqGs76"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AED05821E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703177939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YfzgPU3MkfaqMkHywTBvwxBqqqhijQZYQX1JEq3yLos=;
	b=BaSqGs762xxaBKLh8zl0g+GTMPoiR2NxJ6iMau8Kjs2jpGGjNiQrEUSgZtZBxF/bEezK0o
	4TABIiyLvAROtZsksiIVACQxknv+lfmNaKBCjFZ8qggHtq1E/qh4lo+mP8LvDBX/1BQvsJ
	Sav72rQdrtmy9p2s5UZu/V6J2c/dvTA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-iAYrCm-EMAiboEnHJGc83A-1; Thu, 21 Dec 2023 11:58:57 -0500
X-MC-Unique: iAYrCm-EMAiboEnHJGc83A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40c3cea4c19so8821955e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 08:58:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703177936; x=1703782736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YfzgPU3MkfaqMkHywTBvwxBqqqhijQZYQX1JEq3yLos=;
        b=VqoATI+FTk7QrNb2yM+X0fsfDQb2IE8eOEfSOT/nhQAmrlEhGFk7rq2ua9CpaPdr92
         taM1T+7ZQ4MBgSdL+D+gtyon64X3d24a4a/ugirwgJyWB5X9ZeClPup6mYfrQxwlAoP6
         rnJqgwPmRJ2XGj0T/mDI9w4MeCF8A22pDf0se4Ml8TnboIneLLpNOkNlXVD6tJWRcaw0
         laU+JALmvN6y6BUEOp8rkobOdXskyQgjFLWWyeNUjHpalV7UQVLLPWcb9I+xkCiEhu1S
         71HO53OM00z3LoV9NYh7CrvhXKka+sFt5koEy1ThzuXqgCJYwMmG3TiQpGIVDm0lBBmO
         v/4Q==
X-Gm-Message-State: AOJu0YzK7yDtJ46jXnEuSG6oUEvdh91c5V1MXuuAt7GiICniIYHvCyQP
	Az31z7BGnZyDoFc4lKUvv72bOeejNQk0Ix59xwmp10YymwWjA4TzbRafcYYWjn48wJvvdc9MAlY
	Bmc+y9DyF9P6rX1bsQ9m62t1PoxbV3gc=
X-Received: by 2002:a7b:c8d7:0:b0:40d:3bd1:3dc9 with SMTP id f23-20020a7bc8d7000000b0040d3bd13dc9mr2459wml.219.1703177936726;
        Thu, 21 Dec 2023 08:58:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbByqWtAWAPFMSK5jVspKSO6YeLOYJty6KrgKSNfnZjI5LmzBWOfBm3dl7JgTsSMglSsII3Q==
X-Received: by 2002:a7b:c8d7:0:b0:40d:3bd1:3dc9 with SMTP id f23-20020a7bc8d7000000b0040d3bd13dc9mr2454wml.219.1703177936454;
        Thu, 21 Dec 2023 08:58:56 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-31-72.cust.vodafonedsl.it. [2.34.31.72])
        by smtp.gmail.com with ESMTPSA id v14-20020a05600c444e00b0040c58e410a3sm11874745wmn.14.2023.12.21.08.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 08:58:56 -0800 (PST)
From: Marco Pagani <marpagan@redhat.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/module: improve documentation for try_module_get()
Date: Thu, 21 Dec 2023 17:58:47 +0100
Message-ID: <20231221165848.150041-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sentence "this call will fail if the module is already being
removed" is potentially confusing and may contradict the rest of the
documentation. If one tries to get a module that has already been
removed using a stale pointer, the kernel will crash.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 include/linux/module.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index a98e188cf37b..08364d5cbc07 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -668,7 +668,7 @@ extern void __module_get(struct module *module);
  * @module: the module we should check for
  *
  * Only try to get a module reference count if the module is not being removed.
- * This call will fail if the module is already being removed.
+ * This call will fail if the module is in the process of being removed.
  *
  * Care must also be taken to ensure the module exists and is alive prior to
  * usage of this call. This can be gauranteed through two means:
-- 
2.43.0


