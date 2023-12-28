Return-Path: <linux-kernel+bounces-12846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F95381FB1E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 21:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 344CC1F245F8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 20:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B494F111B6;
	Thu, 28 Dec 2023 20:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCFjgp5X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF76110A31
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 20:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5e266e8d39eso54825027b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 12:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703794185; x=1704398985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fiqg7NMTo1hnms2N+QcuxP30iXk/HvqGHex9PC1KYAY=;
        b=UCFjgp5XnaVjOjmorJ/Ed1flWnOHA9/D3ztHX2r1SbV/8/TXsW52EW89yrI4Xe7zpy
         HJJPVfWmCAorjUIhHZ7z+iBYtjCysDuzX4psoAWqdsGrhM/4HLL+UKzOMEmodb+qsO/B
         73SjlgXWGU2s+okfTOxWxuB0JgQcTeK93QrxgXVrMEUTDFdBYwtWwwRAB5FzWb5wgubf
         D5M+6H5tqVyT7RIdh33M4CF19PCpQHBhDzasXqnIUwIBrBC4P2YXD8WWqLGqOo0FIXVa
         lnbq8fajbwCRBm0TvHXNdMdDAUEjtuieV3JQPk13LYJt3Fnt/SZsk5uKSlaK0UFeZVgU
         rXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703794185; x=1704398985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fiqg7NMTo1hnms2N+QcuxP30iXk/HvqGHex9PC1KYAY=;
        b=NguC6cNOSmZ35iQoFXJ4vKXIOkTSm4N9gPmyhPZhN/xgOZw1Ps8VjrU0GlyDw487SR
         NhPO7vQg7R1O9sfGcAoXTEc2UCKGzl8ApVMuocUQXokkBw5HddXZCPZ/bnqxffHro5mm
         Bl9Mvh0D4oAGlkknOIJ3WJdRNMBoSN4bPkyFvE1uJbFAfDKXy4Vd83Mh2zl8WputkB7v
         hw3tu2fBC2HKNkIBGbw6q9Mto0g5QTNt4CGKsSBi2VXvrVieArTqrRZTqKhoZiyP0Tf+
         nCC0utOWHgUv6V8fzX6LATXQOmsmozPE6JoTWz9niiXAc/SjjeSjd+snVHagwai7pQ0/
         1gJg==
X-Gm-Message-State: AOJu0Yx8F+/6xHyVgC+SbRDovsJM/OXNwkC/XiSJqcig7jmmDA9hUPsc
	+dnGg1WR1qma3MaVlWiFaok=
X-Google-Smtp-Source: AGHT+IER6tNGef2L3hiXuMT0rLdDBtturZ2Q3+wyCn4IOGclEdDMoL2I66MldAZV8xbecCgLWJeq0A==
X-Received: by 2002:a0d:d2c6:0:b0:5e7:cd6d:b6da with SMTP id u189-20020a0dd2c6000000b005e7cd6db6damr7447267ywd.47.1703794185564;
        Thu, 28 Dec 2023 12:09:45 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:967c:a333:ae09:3f60])
        by smtp.gmail.com with ESMTPSA id n127-20020a817285000000b005ca99793930sm7691447ywc.20.2023.12.28.12.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 12:09:44 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ming Lei <ming.lei@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 5/9] lib/group_cpus: don't zero cpumasks in group_cpus_evenly() on allocation
Date: Thu, 28 Dec 2023 12:09:32 -0800
Message-Id: <20231228200936.2475595-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228200936.2475595-1-yury.norov@gmail.com>
References: <20231228200936.2475595-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nmsk and npresmsk are both allocated with zalloc_cpumask_var(), but they
are initialized by copying later in the code, and so may be allocated
uninitialized.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/group_cpus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index 952aac9eaa81..72c308f8c322 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -354,10 +354,10 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	int ret = -ENOMEM;
 	struct cpumask *masks = NULL;
 
-	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
+	if (!alloc_cpumask_var(&nmsk, GFP_KERNEL))
 		return NULL;
 
-	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
+	if (!alloc_cpumask_var(&npresmsk, GFP_KERNEL))
 		goto fail_nmsk;
 
 	node_to_cpumask = alloc_node_to_cpumask();
-- 
2.40.1


