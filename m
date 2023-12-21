Return-Path: <linux-kernel+bounces-8234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005A281B419
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32F4E1C23B9F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084426E590;
	Thu, 21 Dec 2023 10:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMUtexx/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA8A6E2A0;
	Thu, 21 Dec 2023 10:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cd54e5fbb2so255266a12.2;
        Thu, 21 Dec 2023 02:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703155443; x=1703760243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bo5HJl27sw1CMSOKy+oOqaIrDQeJX/kJbyC1rLu2v4w=;
        b=dMUtexx/KE1PzAoch6XRtlFsEksjvIreexOf1j08l8igJb7XXWXWLGSLfgxV6ELLIn
         V51k/xfwcgDz8vgS31vWu5bUapYULUuPOuA6ojdESopb3efm3pPlQw7ZYLQlOCxZP+Rx
         r4+xPIQQ8UShwmRB/ju/Bb9Zs0dDvO3Wzd2Pf4Ev73V+xyAAOfjiOGsndt+rFC+QqlNx
         IgS6NOEKqiOG8AM2GKt02QP6sPjL8dgPsiGPEMzzP3oajhEjF2LGKHahTDbq7mEKDWbR
         lZoT5nJWrVD+vUlYFIJjevIuV3CbERSNZ3ZLBbefXdXBOzd6qg9qBEMX3wu4fSZRnzbK
         rf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703155443; x=1703760243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bo5HJl27sw1CMSOKy+oOqaIrDQeJX/kJbyC1rLu2v4w=;
        b=jp7mEc235Y6mnjMfdIhyHBpc2cgYpdxJaGPJkYYMMGbCTamDVgi3RTdJkdq5FQ5Mqc
         b4yawj1HPh1LE8dhYBKhMgXaf8X2cS2Ajiwc7x+KmGnUaY//+G5sq+PNjk9AQ+W2rNf4
         aDKTI2DpMVkY0Ec2DD5zaEYvacOfcDzOuzNDWePOMBogfXx50hOR77G5lTdzMJhwGle6
         GWbWhv9dZRbkYP3pxOhhZzCssSeTZYp6j2GP/ZuA4oeLD5wzYf/8fOjDhJYjs8sG/upr
         WukgxtQx84ZMAuJOGox7dyQa0PTM8MusXNM4HTpsiqiYw9bHsUo9m+yEKt2bW3LUakcW
         Bqfg==
X-Gm-Message-State: AOJu0YyjcapEPF3CLrstS7r5zsajXGulEOqlwx9UDxWb3ZpHTNtRyrxb
	kk8IUPKJOvViRk6n+IJz6Pc=
X-Google-Smtp-Source: AGHT+IEXCGLsKGUvqFYBb1EDPhNJjKoCtRN8qbD51wyTxoqlw+tZIBw9kcFX9bbMUt30akC+jrBlbA==
X-Received: by 2002:a05:6a20:a10e:b0:190:8c90:c310 with SMTP id q14-20020a056a20a10e00b001908c90c310mr795053pzk.42.1703155443225;
        Thu, 21 Dec 2023 02:44:03 -0800 (PST)
Received: from g2039B650.. ([106.39.42.144])
        by smtp.gmail.com with ESMTPSA id ei8-20020a17090ae54800b0028bd9f88576sm1470111pjb.26.2023.12.21.02.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 02:44:02 -0800 (PST)
From: Gui-Dong Han <2045gemini@gmail.com>
To: song@kernel.org,
	yukuai3@huawei.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com,
	Gui-Dong Han <2045gemini@gmail.com>,
	BassCheck <bass@buaa.edu.cn>
Subject: [PATCH] md/raid5: fix atomicity violation in raid5_cache_count
Date: Thu, 21 Dec 2023 18:43:43 +0800
Message-Id: <20231221104343.5557-1-2045gemini@gmail.com>
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
 drivers/md/raid5.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 8497880135ee..62ebf33402cc 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7390,11 +7390,12 @@ static unsigned long raid5_cache_count(struct shrinker *shrink,
 				       struct shrink_control *sc)
 {
 	struct r5conf *conf = shrink->private_data;
-
-	if (conf->max_nr_stripes < conf->min_nr_stripes)
+	int max_stripes = conf->max_nr_stripes;
+	int min_stripes = conf->min_nr_stripes;
+	if (max_stripes < min_stripes)
 		/* unlikely, but not impossible */
 		return 0;
-	return conf->max_nr_stripes - conf->min_nr_stripes;
+	return max_stripes - min_stripes;
 }
 
 static struct r5conf *setup_conf(struct mddev *mddev)
-- 
2.34.1


