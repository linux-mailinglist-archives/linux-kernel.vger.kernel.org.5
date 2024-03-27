Return-Path: <linux-kernel+bounces-120786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B2D88DD34
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FF04B24861
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F40412E1F3;
	Wed, 27 Mar 2024 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VV1q8dHX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB6712E1DB;
	Wed, 27 Mar 2024 12:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541199; cv=none; b=BkR7C3wi1n9zxG7G9CXKZmuAPIiqImE+PbMeI4IeR9Ns4XtnupajC0v3IA72lYt1/0es3V9Orb3R0wRS3HAzy/9FE604mZectZOy+220GdNk5t5IDALWApCzQENDua1MSwtbPqaFXCSaLAjiquv7I7PUFSoTbBg80kBHJban9Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541199; c=relaxed/simple;
	bh=GH2siRTrEfWZu5SbglE8+vXL8iCy7Ey8rFRQg2WqqOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FrFfDWi27WlLYKADkrSei3XvERL6TsEaLEF3z5I3oX+64U1Q7iRlT+6eBFyDDx9/XzbPx5mw5KlIdaEntBDYgvwZu3Q/PHFzoyhOPwmRbaqlGK4kmts9+yaYe3Yq4BrvAmKd1FoEhxeAhooNH+k2usQ1vFucI+SoJh5/Gq1pIxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VV1q8dHX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7781CC433C7;
	Wed, 27 Mar 2024 12:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541199;
	bh=GH2siRTrEfWZu5SbglE8+vXL8iCy7Ey8rFRQg2WqqOQ=;
	h=From:To:Cc:Subject:Date:From;
	b=VV1q8dHX8kmS56gDlscP8lpUE6pKLzcFbWs8iM5Nzo46Czfo74OY9hnN4dFj+hEyY
	 XbCNlUjIMAaph3RmH7LRIYaAF/sU0kGtMFeeORz97Cxlx6Z070xR1962fbo5mR/5mK
	 CCy6mBOi+IkxruNjy9+8WPxmBg+ECWqFPt3j9aScMSiz/Co0Lulxj7Safptv3gejY3
	 h/kOdnvrcLJYgssPOPwjPmLQ4cbxECphcTGwG3+MmSYA3QfqLbqRrhtanLx4XHwrw6
	 iz3UCVwzxhbBRgwDw9elpjl/GMfSkr458xc4sUkhHZeukZKBLdUINaSWqUxb2S6YAR
	 LZTbGBEwLip4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	nirmoy.das@intel.com
Cc: Andi Shyti <andi.shyti@linux.intel.com>,
	Shawn Lee <shawn.c.lee@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/i915: Check before removing mm notifier" failed to apply to 6.8-stable tree
Date: Wed, 27 Mar 2024 08:06:37 -0400
Message-ID: <20240327120637.2824630-1-sashal@kernel.org>
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

The patch below does not apply to the 6.8-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From db7bbd13f08774cde0332c705f042e327fe21e73 Mon Sep 17 00:00:00 2001
From: Nirmoy Das <nirmoy.das@intel.com>
Date: Mon, 19 Feb 2024 13:50:47 +0100
Subject: [PATCH] drm/i915: Check before removing mm notifier

Error in mmu_interval_notifier_insert() can leave a NULL
notifier.mm pointer. Catch that and return early.

Fixes: ed29c2691188 ("drm/i915: Fix userptr so we do not have to worry about obj->mm.lock, v7.")
Cc: <stable@vger.kernel.org> # v5.13+
[tursulin: Added Fixes and cc stable.]
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Shawn Lee <shawn.c.lee@intel.com>
Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240219125047.28906-1-nirmoy.das@intel.com
Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
index 0e21ce9d3e5ac..61abfb505766d 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
@@ -349,6 +349,9 @@ i915_gem_userptr_release(struct drm_i915_gem_object *obj)
 {
 	GEM_WARN_ON(obj->userptr.page_ref);
 
+	if (!obj->userptr.notifier.mm)
+		return;
+
 	mmu_interval_notifier_remove(&obj->userptr.notifier);
 	obj->userptr.notifier.mm = NULL;
 }
-- 
2.43.0





