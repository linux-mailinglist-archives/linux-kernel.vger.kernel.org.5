Return-Path: <linux-kernel+bounces-24361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A330082BB8B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181F71F22C35
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B844D5C916;
	Fri, 12 Jan 2024 07:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFsureoa"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972755C8E6;
	Fri, 12 Jan 2024 07:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-203fb334415so4002659fac.2;
        Thu, 11 Jan 2024 23:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705043749; x=1705648549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XaiivCdRiflUGAhs3GPaW8lDbk654fv72WhTYZD7nnI=;
        b=CFsureoaO4Auk7HfcT9cMPHLq5JxeV8RUZR499mo8GsVqYCWEjgZ2X+WjHMiJb9QFL
         Z0i2pGxQeqToDWPlXzGLYihOKOP0vpZdkfVS03Nbx2eHeKL/L9Uc9lpOOycWqGmk1CyH
         JmD0G1YKF1V/F4lMdrODcXgVFvvXS3JvUBJjva+3yFJhzUUDqLZR2kfUwIbfSJ/h15Z1
         iWbblEZ8Tmjl0snQP+APv49eZPU/jnc99VhiBOAn/FnQjer0iGAYF4Ykn2baIq0geRUC
         e7l9CmMekIOr8EFKN52h6u00VCJSu1QI7/BkOsJ+F3W6Ldsy0yHjumCNxccePxrtFpo1
         Lhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705043749; x=1705648549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XaiivCdRiflUGAhs3GPaW8lDbk654fv72WhTYZD7nnI=;
        b=FDjrXENo3itA3g3Ibb+8ZydiiF8JcEpv3THQkch/V3CwI9A4M5D+XNNuMVPdQX7oga
         zdIsCLg1kvRJa1s7J33lFCBTFyGzy+1AexgedJ0JspYCNM7osd3zg3zFKG3fvPKH58La
         HVfoy+HMXNTbTha03QW/qzfOttfsoh8cPz48ssRPsGdWhnmgii1HRX0KPeS3LLw5IKQw
         qlhoCpdKK/TK+GwcwTAA8WBz4oQGK2QbcLPmVbpKoV9svLLJc3bUAWLANw1Fzj/l3v7O
         6wlvRyK8NJ6OSkb0VM3FQ0JzzfuWUWokrSL4ryUbD2QeQluvL7qBwfn3mmhi15AzQWRm
         uDKg==
X-Gm-Message-State: AOJu0YxcIXibO5p+LubYNuKnoAhyAPk5z5Nih7cThP84XySMFnWvIk34
	mNYfbb8rg5KcoOn3yOW3uJAHQ7Do7GJkMA==
X-Google-Smtp-Source: AGHT+IG5DRBvRgvUq8RgIT4mdKhROYYYlwAv8/K2wX8tZra7wx76FJMW5zUpUzeSkJZGIHm3J5mMnQ==
X-Received: by 2002:a05:6a20:1699:b0:19a:508a:7f70 with SMTP id q25-20020a056a20169900b0019a508a7f70mr389807pzc.30.1705043430082;
        Thu, 11 Jan 2024 23:10:30 -0800 (PST)
Received: from g2039B650.. ([106.39.42.152])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902d50f00b001d1cd7e4ad2sm2374631plg.125.2024.01.11.23.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 23:10:29 -0800 (PST)
From: Gui-Dong Han <2045gemini@gmail.com>
To: song@kernel.org,
	yukuai3@huawei.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com,
	Gui-Dong Han <2045gemini@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] md/raid5: fix atomicity violation in raid5_cache_count
Date: Fri, 12 Jan 2024 15:10:17 +0800
Message-Id: <20240112071017.16313-1-2045gemini@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In raid5_cache_count():
    if (conf->max_nr_stripes < conf->min_nr_stripes)
        return 0;
    return conf->max_nr_stripes - conf->min_nr_stripes;
The current check is ineffective, as the values could change immediately
after being checked.

In raid5_set_cache_size():
    ...
    conf->min_nr_stripes = size;
    ...
    while (size > conf->max_nr_stripes)
        conf->min_nr_stripes = conf->max_nr_stripes;
    ...

Due to intermediate value updates in raid5_set_cache_size(), concurrent
execution of raid5_cache_count() and raid5_set_cache_size() may lead to
inconsistent reads of conf->max_nr_stripes and conf->min_nr_stripes.
The current checks are ineffective as values could change immediately
after being checked, raising the risk of conf->min_nr_stripes exceeding
conf->max_nr_stripes and potentially causing an integer overflow.

This possible bug is found by an experimental static analysis tool
developed by our team. This tool analyzes the locking APIs to extract
function pairs that can be concurrently executed, and then analyzes the
instructions in the paired functions to identify possible concurrency bugs
including data races and atomicity violations. The above possible bug is
reported when our tool analyzes the source code of Linux 6.2.

To resolve this issue, it is suggested to introduce local variables
'min_stripes' and 'max_stripes' in raid5_cache_count() to ensure the
values remain stable throughout the check. Adding locks in
raid5_cache_count() fails to resolve atomicity violations, as
raid5_set_cache_size() may hold intermediate values of
conf->min_nr_stripes while unlocked. With this patch applied, our tool no
longer reports the bug, with the kernel configuration allyesconfig for
x86_64. Due to the lack of associated hardware, we cannot test the patch
in runtime testing, and just verify it according to the code logic.

Fixes: edbe83ab4c27 ("md/raid5: allow the stripe_cache to grow and shrink.")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
---
v2:
* In this patch v2, we've updated to use READ_ONCE() instead of direct
reads for accessing max_nr_stripes and min_nr_stripes, since read and
write can concurrent.
  Thank Yu Kuai for helpful advice.
---
v3:
* In this patch v3, we've updated to use WRITE_ONCE() in 
raid5_set_cache_size(), grow_one_stripe() and drop_one_stripe(), in order
to pair READ_ONCE() with WRITE_ONCE().
  Thank Yu Kuai for helpful advice.
---
v4:
* In this patch v4, we've addressed several code style issues.
  Thank Yu Kuai for helpful advice.
---
 drivers/md/raid5.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 8497880135ee..30e118d10c0b 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2412,7 +2412,7 @@ static int grow_one_stripe(struct r5conf *conf, gfp_t gfp)
 	atomic_inc(&conf->active_stripes);
 
 	raid5_release_stripe(sh);
-	conf->max_nr_stripes++;
+	WRITE_ONCE(conf->max_nr_stripes, conf->max_nr_stripes + 1);
 	return 1;
 }
 
@@ -2707,7 +2707,7 @@ static int drop_one_stripe(struct r5conf *conf)
 	shrink_buffers(sh);
 	free_stripe(conf->slab_cache, sh);
 	atomic_dec(&conf->active_stripes);
-	conf->max_nr_stripes--;
+	WRITE_ONCE(conf->max_nr_stripes, conf->max_nr_stripes - 1);
 	return 1;
 }
 
@@ -6820,7 +6820,7 @@ raid5_set_cache_size(struct mddev *mddev, int size)
 	if (size <= 16 || size > 32768)
 		return -EINVAL;
 
-	conf->min_nr_stripes = size;
+	WRITE_ONCE(conf->min_nr_stripes, size);
 	mutex_lock(&conf->cache_size_mutex);
 	while (size < conf->max_nr_stripes &&
 	       drop_one_stripe(conf))
@@ -6832,7 +6832,7 @@ raid5_set_cache_size(struct mddev *mddev, int size)
 	mutex_lock(&conf->cache_size_mutex);
 	while (size > conf->max_nr_stripes)
 		if (!grow_one_stripe(conf, GFP_KERNEL)) {
-			conf->min_nr_stripes = conf->max_nr_stripes;
+			WRITE_ONCE(conf->min_nr_stripes, conf->max_nr_stripes);
 			result = -ENOMEM;
 			break;
 		}
@@ -7390,11 +7390,13 @@ static unsigned long raid5_cache_count(struct shrinker *shrink,
 				       struct shrink_control *sc)
 {
 	struct r5conf *conf = shrink->private_data;
+	int max_stripes = READ_ONCE(conf->max_nr_stripes);
+	int min_stripes = READ_ONCE(conf->min_nr_stripes);
 
-	if (conf->max_nr_stripes < conf->min_nr_stripes)
+	if (max_stripes < min_stripes)
 		/* unlikely, but not impossible */
 		return 0;
-	return conf->max_nr_stripes - conf->min_nr_stripes;
+	return max_stripes - min_stripes;
 }
 
 static struct r5conf *setup_conf(struct mddev *mddev)
-- 
2.34.1


