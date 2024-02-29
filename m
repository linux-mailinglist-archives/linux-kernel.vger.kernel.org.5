Return-Path: <linux-kernel+bounces-86849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6495086CBB3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18BC1282596
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BB213774B;
	Thu, 29 Feb 2024 14:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="GBo5Z4Dk"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69283E489;
	Thu, 29 Feb 2024 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709217411; cv=none; b=n/+LQS/wE9aCQWy9GY3KeEiQKozqQVlzEc5ohT+xrsUNzq3ET0JSBGl3PkCaBw3seIgXN5CTcDQBX8l2gO+QYbStqLHSVFe/FgxdQziS+bgj3p+o9vyRuMz6rT7O8jBAbQae8cSipE5j9WRYWPgrGdCy+w7irxc7IjTQbnonJL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709217411; c=relaxed/simple;
	bh=ShkOrOceasbzr+t0dTg3xM/G0Ce9lc06tQ+L5rDgUFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f7I9Gyjem/R9ZuBZOBCXJjdHaj2GovZZ+lWCPazTBzGj5CWlKKuo1BQ/GehP0U1WR5wvubhX9NuTLOpHyyB5kGI8Ey8qBKcHDDT0M8hmnJiOjJWX1LKYlveXhFx2Y+uKTkySDuwpXHxzj1ptTNjA+dZ4UCKGMTUoiXyYLJKDu/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=GBo5Z4Dk; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=Yg7gA0jcv4W0xVz47D8GBOwfwX0WK4Erjbho1nblId0=; t=1709217408; x=1710427008; 
	b=GBo5Z4DkLB+CEbgGiAMfSSDsvM4tI0p2LTFfXQ9nMp1cM/oiQv4Z/QLF7LCuso1ZoZXV8YSXUHV
	tUKKl6H4FJg3Y+w7+YGFWSpTKO5W8Xz7TE6bMG7/sNegpRKF8zQ7mhhXGkvJFudlgQ2sMUX2w7eQj
	2ZGTQUV/3p5mIIaI9kLG0Zi+vyBknWpiv8cYjN+ZUPRyoleL0g3OmotYgaYY30x0MVJ71MjCTBLkM
	ksKOjzQxhrzq4qZgKX2whaehhe7OB9QN82RpnhAQAPUMSL9c1d6kuIXWV3K2GqBgPfZDW/EzOYoVF
	FIVcYE2+KOiEBndlG7Mu29M694Od+4Ikja5w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfhWX-0000000Ddei-2Zad;
	Thu, 29 Feb 2024 15:36:37 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	stable@vger.kernel.org,
	Ben Greear <greearb@candelatech.com>,
	Madhan Sai <madhan.singaraju@candelatech.com>
Subject: [PATCH] debugfs: fix wait/cancellation handling during remove
Date: Thu, 29 Feb 2024 15:36:20 +0100
Message-ID: <20240229153635.6bfab7eb34d3.I6c7aeff8c9d6628a8bc1ddcf332205a49d801f17@changeid>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Ben Greear further reports deadlocks during concurrent debugfs
remove while files are being accessed, even though the code in
question now uses debugfs cancellations. Turns out that despite
all the review on the locking, we missed completely that the
logic is wrong: if the refcount hits zero we can finish (and
need not wait for the completion), but if it doesn't we have
to trigger all the cancellations. As written, we can _never_
get into the loop triggering the cancellations. Fix this, and
explain it better while at it.

Cc: stable@vger.kernel.org
Fixes: 8c88a474357e ("debugfs: add API to allow debugfs operations cancellation")
Reported-by: Ben Greear <greearb@candelatech.com>
Closes: https://lore.kernel.org/r/1c9fa9e5-09f1-0522-fdbc-dbcef4d255ca@candelatech.com
Tested-by: Madhan Sai <madhan.singaraju@candelatech.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 fs/debugfs/inode.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 034a617cb1a5..a40da0065433 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -751,13 +751,28 @@ static void __debugfs_file_removed(struct dentry *dentry)
 	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
 		return;
 
-	/* if we hit zero, just wait for all to finish */
-	if (!refcount_dec_and_test(&fsd->active_users)) {
-		wait_for_completion(&fsd->active_users_drained);
+	/* if this was the last reference, we're done */
+	if (refcount_dec_and_test(&fsd->active_users))
 		return;
-	}
 
-	/* if we didn't hit zero, try to cancel any we can */
+	/*
+	 * If there's still a reference, the code that obtained it can
+	 * be in different states:
+	 *  - The common case of not using cancellations, or already
+	 *    after debugfs_leave_cancellation(), where we just need
+	 *    to wait for debugfs_file_put() which signals the completion;
+	 *  - inside a cancellation section, i.e. between
+	 *    debugfs_enter_cancellation() and debugfs_leave_cancellation(),
+	 *    in which case we need to trigger the ->cancel() function,
+	 *    and then wait for debugfs_file_put() just like in the
+	 *    previous case;
+	 *  - before debugfs_enter_cancellation() (but obviously after
+	 *    debugfs_file_get()), in which case we may not see the
+	 *    cancellation in the list on the first round of the loop,
+	 *    but debugfs_enter_cancellation() signals the completion
+	 *    after adding it, so this code gets woken up to call the
+	 *    ->cancel() function.
+	 */
 	while (refcount_read(&fsd->active_users)) {
 		struct debugfs_cancellation *c;
 
-- 
2.43.2


