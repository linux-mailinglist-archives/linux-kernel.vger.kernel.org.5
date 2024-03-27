Return-Path: <linux-kernel+bounces-120957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C8788E0F4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8421C2981D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3353D15252C;
	Wed, 27 Mar 2024 12:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLoglpx0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626D5152517;
	Wed, 27 Mar 2024 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541693; cv=none; b=uUKTu8Vok2WtXpvy3BjiKpxJ8vZk7j4ZBQFbhpGsjlJwDYSp33aYa4DiudImJT8nCB7ZUacxCKXPyox+Xs45ngwX5zEtv8xToTdks4OXdAbXbYgk6lVNgiQ3M78Bvql5vDdst2rEMzbWnPRHfwoa6MWzpZY/ls6g36vGOexhIpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541693; c=relaxed/simple;
	bh=InLTL0BiJSyESEr0O1Y1zmUS5HNnDKY4umz7iqnxKL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gehiwA//YXVb3sqzFWfEE00QFG1V2H+DgT6hjooNaWYdxZSDJps5cngybIYx6gYQuW5CPI/L/cSxzLgLuV9P/mEzlLS9bIJjJV8P5qvOs0tGUdR0lNTfpOBlK9fQH8BmRED5M9C7iP3GoEkQj5jJ3NXdjcxOyF5eqL/kHdkOhHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLoglpx0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21299C433F1;
	Wed, 27 Mar 2024 12:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541692;
	bh=InLTL0BiJSyESEr0O1Y1zmUS5HNnDKY4umz7iqnxKL8=;
	h=From:To:Cc:Subject:Date:From;
	b=lLoglpx0sD9YAtACcppNuuxBF1hSUgy84gacn6lE4F3uRgIFaaPhUpgGe1zUiQ5bX
	 77tROhRT45+v7XLXJqCkBZEI9DtMhAjenvvTzOg5gdXa5nC3Q/tMOpgi9NggMC6JzH
	 mAlPnzxCY2G/pb6jZVAH+teYFCtEb2loHit312TSHxMpsCMOO93yPAxl83mJLO59EN
	 SMYmqMj/SixLC2gWujNXkvsbs1cnl7ObzTb5uOML+H06JAb/LXqDW6zevqpCqsppf2
	 D1FtBiWpkM9EXag9pH787E1BsTKzw4NT2xH3ADxrOhw0/NCcmFmsEjSVT7y576JKR7
	 vooD9vrC0tjBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	2045gemini@gmail.com
Cc: Yu Kuai <yukuai3@huawei.com>,
	Song Liu <song@kernel.org>,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "md/raid5: fix atomicity violation in raid5_cache_count" failed to apply to 5.15-stable tree
Date: Wed, 27 Mar 2024 08:14:50 -0400
Message-ID: <20240327121451.2831412-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From dfd2bf436709b2bccb78c2dda550dde93700efa7 Mon Sep 17 00:00:00 2001
From: Gui-Dong Han <2045gemini@gmail.com>
Date: Fri, 12 Jan 2024 15:10:17 +0800
Subject: [PATCH] md/raid5: fix atomicity violation in raid5_cache_count

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
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20240112071017.16313-1-2045gemini@gmail.com
Signed-off-by: Song Liu <song@kernel.org>
---
 drivers/md/raid5.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 14f2cf75abbd7..7ec445f49f1c3 100644
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
@@ -7388,11 +7388,13 @@ static unsigned long raid5_cache_count(struct shrinker *shrink,
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
2.43.0





