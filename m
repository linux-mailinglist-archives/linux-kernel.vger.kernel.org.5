Return-Path: <linux-kernel+bounces-9342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D321281C458
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11B281C23659
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B22463B9;
	Fri, 22 Dec 2023 04:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mL88mk/A"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146EC568B;
	Fri, 22 Dec 2023 04:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5cd870422c8so845807a12.0;
        Thu, 21 Dec 2023 20:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703220758; x=1703825558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wy4FnoE63HSTWvD7t5BrS3SLWIs+Za9UBHpe2htpsf0=;
        b=mL88mk/Ay4AbPlmgljpJAFanfevk/JJW9EmHJynmdQ82+uysWq1CaGrMUQTNJUq2bG
         +Z4kfD/740R275ni5kSxyYxk8qvanDppRIVSTXzsSYics9lkcNv5YVBTlgxZwp2mqnCi
         UzcZDzTAGr86fvb6aAbqXHD8bnuJwTNocdYJjBsEIjv+kz7ufB11Fjv6b8AO28AibM3+
         7r0iBtdZoDX10FfG8BnHdBIDgox4KSKz3W6HTlKsGv3DL5wESVVgOWVKN4XBTBRoaZ9k
         fuxuzumFf4EizVWXSztm7UOF2PQwOyooAumQnWLBA7kA5Q/LBkYOIZrBnBJmsAEIAPUq
         OQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703220758; x=1703825558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wy4FnoE63HSTWvD7t5BrS3SLWIs+Za9UBHpe2htpsf0=;
        b=Y4swRmsAeenJanF/92crwmtyT1G3m6VQzNoeBu8MGnvHeHjZwtpcXG15go0i8Nn3LB
         Lq39t+MWcM+2PzGTGb+sNiAZDoeSV6cOFZZrVrPmwDyrdlRCd1P3+Gd4Xa8xj1XfobtN
         59K3MiDlSF7lZnH3u81k/BIgwkEF1fB+MpsIJOnAZgBuyYxiKSUKzYrJCya9DA9fvOeE
         BTrmQ+JTs0Ov97VjKc9ZA3VVVptXp65GZ7Q0ikeMeFzO3PJF5yLnlc2dX8WRtl4nWjpb
         RxQmuY749r0J6U7Th/fvwUqvM/gO/6nKS7Bn3/sVxjMMoc9n4aDI1ddFQGWpoFhQaPUZ
         Ht2w==
X-Gm-Message-State: AOJu0Yzfk5/6NI92UMWVDGchqlHrVh56/H8p8J4oEEjDD40PaVQKxXNU
	N+Zq2W6YJGDgCYyVqvwdLLo=
X-Google-Smtp-Source: AGHT+IGaoBIq/qvdS23N9Qu7zQF2cx9KfQFiOSRvMlkefdp7esZHfzsigVMBtlFZzudBZ56vi9g3XQ==
X-Received: by 2002:a05:6a20:258f:b0:194:f21e:209c with SMTP id k15-20020a056a20258f00b00194f21e209cmr576302pzd.102.1703220758240;
        Thu, 21 Dec 2023 20:52:38 -0800 (PST)
Received: from g2039B650.. ([106.39.42.144])
        by smtp.gmail.com with ESMTPSA id sm18-20020a17090b2e5200b002868abc0e6dsm6554259pjb.11.2023.12.21.20.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 20:52:37 -0800 (PST)
From: Gui-Dong Han <2045gemini@gmail.com>
To: song@kernel.org,
	yukuai3@huawei.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com,
	Gui-Dong Han <2045gemini@gmail.com>,
	BassCheck <bass@buaa.edu.cn>
Subject: [PATCH v2] md/raid5: fix atomicity violation in raid5_cache_count
Date: Fri, 22 Dec 2023 12:52:24 +0800
Message-Id: <20231222045224.4439-1-2045gemini@gmail.com>
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

Fixes: edbe83ab4c27e ("md/raid5: allow the stripe_cache to grow and ...")
Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>

---
v2:
* In this patch v2, we've updated to use READ_ONCE() instead of direct
reads for accessing max_nr_stripes and min_nr_stripes, since read and
write can concurrent.
  Thank Yu Kuai for helpful advice.
---
 drivers/md/raid5.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 8497880135ee..9037e46de0e2 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7391,10 +7391,12 @@ static unsigned long raid5_cache_count(struct shrinker *shrink,
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


