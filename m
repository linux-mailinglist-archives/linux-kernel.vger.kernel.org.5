Return-Path: <linux-kernel+bounces-23220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8662182A91A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A1E028561F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506D2DF6D;
	Thu, 11 Jan 2024 08:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cv1rICBh"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D37F9C4;
	Thu, 11 Jan 2024 08:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d3f29fea66so28561405ad.3;
        Thu, 11 Jan 2024 00:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704961636; x=1705566436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=boFKFTSQTK3LQG6ZExJ0Q1TZnqDN18G8UXN3MVHCwso=;
        b=Cv1rICBhH/tc7bTZprhPgGzUUy+8A92aMBleE4IK5iugEEOb6AF5xMIUOIN5xz3khS
         EUTZKDtN/lI0Ykvh8BmNMAZ0lDWJqbh79XvZlaHMmLQT0t52Z+kBXhRGJRjPlf7ftQvZ
         /M89TQh6HqpdBs6V5zjBaOtNPT8cTEVY6wVI6HAKX+MHAlmuDDS/0s+P2IcdtM/N/aN6
         qcGL9RxyR+7NZF2WANIvHq5KrrL4+S4kg+XVl4Vd8y2b6oepEeZ5JLlgs4+hX30k3/C7
         5hHWjNj4qu8t7p7ATfHT2wLLrEnkboaMWDJpIPA1q7JXvRhZZByufFxx+W5ys9uCxwWZ
         YLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704961636; x=1705566436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=boFKFTSQTK3LQG6ZExJ0Q1TZnqDN18G8UXN3MVHCwso=;
        b=UPAtJvgcY6M4rew4PCf4qsfdVjKybKQFwr6XQb2+jA/aZGeOI6TNab6MChN0z6YqXO
         EJcF4fj1vJS2HSGC+04nym/NEdxbaYMunXovds751Sv5c2V37z6UaMtJJcY2e2uBaIpA
         z33A0WdIvQ1kg8byUoeLLcNWlVO5YZjIygmzEZImSismcGjOar6WAwGs+/Z8hKE6OR6B
         3Sxia2GUoEsK+HmIfI4D/FNd/rEhrUiXP9fZ/JlCK+44ywJAchc+d3EaAa4Dtg2miAa8
         llRawNAHQMKMkDJaxbstxKlPC7gkUVP2MOk4/BG71Vvci+bOq2t6tWt8yaCBcFFltZi1
         fkKA==
X-Gm-Message-State: AOJu0Yz/uE9QHAluu6yBo5bJvEBavvVI5E7y0hqp7KKyaR/2CSevuDyL
	ODWyXAm0l6ui4IrbQar0Y3gsySpVHWKFsA==
X-Google-Smtp-Source: AGHT+IGMvYOczBUqULKaxJbjhRoaIK6lXqtoUwSh1XXAVFX4pk3FDQCK72tIUn9ZbNdSu3mUFUfXBA==
X-Received: by 2002:a17:903:48e:b0:1d4:44cf:abe2 with SMTP id jj14-20020a170903048e00b001d444cfabe2mr686760plb.113.1704961636431;
        Thu, 11 Jan 2024 00:27:16 -0800 (PST)
Received: from g2039B650.. ([106.39.42.152])
        by smtp.gmail.com with ESMTPSA id c8-20020a170902d48800b001d49c0daf60sm605879plg.265.2024.01.11.00.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 00:27:15 -0800 (PST)
From: Gui-Dong Han <2045gemini@gmail.com>
To: song@kernel.org,
	yukuai3@huawei.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com,
	Gui-Dong Han <2045gemini@gmail.com>
Subject: [PATCH v3] md/raid5: fix atomicity violation in raid5_cache_count
Date: Thu, 11 Jan 2024 16:27:04 +0800
Message-Id: <20240111082704.7503-1-2045gemini@gmail.com>
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

Fixes: edbe83ab4c27 ("md/raid5: allow the stripe_cache to grow and ...")
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
 drivers/md/raid5.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 26e1e8a5e941..ece2b2094dc0 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2422,7 +2422,7 @@ static int grow_one_stripe(struct r5conf *conf, gfp_t gfp)
 	atomic_inc(&conf->active_stripes);
 
 	raid5_release_stripe(sh);
-	conf->max_nr_stripes++;
+	WRITE_ONCE(conf->max_nr_stripes, conf->max_nr_stripes + 1);
 	return 1;
 }
 
@@ -2717,7 +2717,7 @@ static int drop_one_stripe(struct r5conf *conf)
 	shrink_buffers(sh);
 	free_stripe(conf->slab_cache, sh);
 	atomic_dec(&conf->active_stripes);
-	conf->max_nr_stripes--;
+	WRITE_ONCE(conf->max_nr_stripes, conf->max_nr_stripes - 1);
 	return 1;
 }
 
@@ -6878,7 +6878,7 @@ raid5_set_cache_size(struct mddev *mddev, int size)
 	if (size <= 16 || size > 32768)
 		return -EINVAL;
 
-	conf->min_nr_stripes = size;
+	WRITE_ONCE(conf->min_nr_stripes, size);
 	mutex_lock(&conf->cache_size_mutex);
 	while (size < conf->max_nr_stripes &&
 	       drop_one_stripe(conf))
@@ -6890,7 +6890,7 @@ raid5_set_cache_size(struct mddev *mddev, int size)
 	mutex_lock(&conf->cache_size_mutex);
 	while (size > conf->max_nr_stripes)
 		if (!grow_one_stripe(conf, GFP_KERNEL)) {
-			conf->min_nr_stripes = conf->max_nr_stripes;
+			WRITE_ONCE(conf->min_nr_stripes, conf->max_nr_stripes);
 			result = -ENOMEM;
 			break;
 		}
@@ -7449,10 +7449,12 @@ static unsigned long raid5_cache_count(struct shrinker *shrink,
 {
 	struct r5conf *conf = shrink->private_data;
 
-	if (conf->max_nr_stripes < conf->min_nr_stripes)
+	int max_stripes = READ_ONCE(conf->max_nr_stripes);
+	int min_stripes = READ_ONCE(conf->min_nr_stripes);
+	if (max_stripes < min_stripes)
 		/* unlikely, but not impossible */
 		return 0;
-	return conf->max_nr_stripes - conf->min_nr_stripes;
+	return max_stripes - min_stripes;
 }
 
 static struct r5conf *setup_conf(struct mddev *mddev)
-- 
2.34.1


