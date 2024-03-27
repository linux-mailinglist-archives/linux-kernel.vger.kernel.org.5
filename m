Return-Path: <linux-kernel+bounces-121038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0428888E1F9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9572FB26201
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD1D13A409;
	Wed, 27 Mar 2024 12:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgNwPjak"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9AF12F59E;
	Wed, 27 Mar 2024 12:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541910; cv=none; b=IPgx2KM6S+wKd34ZYlq6+fBuyyT06yV9c+9wP5Y0er3xeNLOz68mZD+TrWYjDcISHOvMtJqFr1PXl3fKZbOQzajWzC8CFc3gV+GF4zAWXi7/ADas12GPoZRMfeFcEuiKWCZutZxPJPiAMgZJI8M7hEc0IJDgsjOHa9rq0Xc4Q0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541910; c=relaxed/simple;
	bh=kpN8gtQ+UjQ5s8qvDRazGbOWGn4l3RSzrFn1A+c2WdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cZ9Vy0W05ElqkULkl8SqNY+nmKo5YAOloM+J2N5nlhiHMjm/67YxZDj3fjxlH/P5ba4SNWaCcrQ3CUMZGm3yo/x/KmxlmFSwZ8iDmvqDTAeWKbD0pDUaOhoDlPwcSuX59/Ow7BSuoFZw4TA1+tY2LbMCoYt47EN7zl3qlEAVkjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgNwPjak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0DFC433F1;
	Wed, 27 Mar 2024 12:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541909;
	bh=kpN8gtQ+UjQ5s8qvDRazGbOWGn4l3RSzrFn1A+c2WdE=;
	h=From:To:Cc:Subject:Date:From;
	b=kgNwPjakHxzFyPqs7M/nyl2CjAbaCTpnO6gn9gzgCCzgQIpY+rt78vhhpQ3bcIbRJ
	 JbGojeQ1lLeIx/7FFaeAEb16qWBaWFCqdoEzKcrXQgZodRt7swxGosBFT27/xBNg36
	 Y4/h/GCZ2LfqxBSrvjPQa02c6/WSy4q6Vi6U/jvjaOjeGxkbcy90zsLsa1fKFh0/O5
	 7lizsvLRW//z72gIWlsMc+eE+0q9Fo2Hf6cYVQpY7crDVafp2P2rVvPsRoOzcyqlUA
	 RTkt6zEumBiaMFvOoSgs0hl2ei6J1SP5I+Z/gUWHl8DIwK2xnIVxYZ4jMX91HlTx+n
	 jYZF//NalUVsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yukuai3@huawei.com
Cc: Xiao Ni <xni@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Song Liu <song@kernel.org>,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "md/dm-raid: don't call md_reap_sync_thread() directly" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:18:27 -0400
Message-ID: <20240327121828.2834377-1-sashal@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From cd32b27a66db8776d8b8e82ec7d7dde97a8693b0 Mon Sep 17 00:00:00 2001
From: Yu Kuai <yukuai3@huawei.com>
Date: Tue, 5 Mar 2024 15:23:03 +0800
Subject: [PATCH] md/dm-raid: don't call md_reap_sync_thread() directly

Currently md_reap_sync_thread() is called from raid_message() directly
without holding 'reconfig_mutex', this is definitely unsafe because
md_reap_sync_thread() can change many fields that is protected by
'reconfig_mutex'.

However, hold 'reconfig_mutex' here is still problematic because this
will cause deadlock, for example, commit 130443d60b1b ("md: refactor
idle/frozen_sync_thread() to fix deadlock").

Fix this problem by using stop_sync_thread() to unregister sync_thread,
like md/raid did.

Fixes: be83651f0050 ("DM RAID: Add message/status support for changing sync action")
Cc: stable@vger.kernel.org # v6.7+
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Xiao Ni <xni@redhat.com>
Acked-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20240305072306.2562024-7-yukuai1@huaweicloud.com
---
 drivers/md/dm-raid.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index e2d7a73c0f874..47c4b1b6e532a 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3719,6 +3719,7 @@ static int raid_message(struct dm_target *ti, unsigned int argc, char **argv,
 {
 	struct raid_set *rs = ti->private;
 	struct mddev *mddev = &rs->md;
+	int ret = 0;
 
 	if (!mddev->pers || !mddev->pers->sync_request)
 		return -EINVAL;
@@ -3726,17 +3727,24 @@ static int raid_message(struct dm_target *ti, unsigned int argc, char **argv,
 	if (test_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags))
 		return -EBUSY;
 
-	if (!strcasecmp(argv[0], "frozen"))
-		set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-	else
-		clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	if (!strcasecmp(argv[0], "frozen")) {
+		ret = mddev_lock(mddev);
+		if (ret)
+			return ret;
 
-	if (!strcasecmp(argv[0], "idle") || !strcasecmp(argv[0], "frozen")) {
-		if (mddev->sync_thread) {
-			set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-			md_reap_sync_thread(mddev);
-		}
-	} else if (decipher_sync_action(mddev, mddev->recovery) != st_idle)
+		md_frozen_sync_thread(mddev);
+		mddev_unlock(mddev);
+	} else if (!strcasecmp(argv[0], "idle")) {
+		ret = mddev_lock(mddev);
+		if (ret)
+			return ret;
+
+		md_idle_sync_thread(mddev);
+		mddev_unlock(mddev);
+	}
+
+	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	if (decipher_sync_action(mddev, mddev->recovery) != st_idle)
 		return -EBUSY;
 	else if (!strcasecmp(argv[0], "resync"))
 		; /* MD_RECOVERY_NEEDED set below */
-- 
2.43.0





