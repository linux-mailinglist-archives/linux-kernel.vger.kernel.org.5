Return-Path: <linux-kernel+bounces-120825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F9E88DE75
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 914781C26A3D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6CA1386B2;
	Wed, 27 Mar 2024 12:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K38slKvI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5343D1386A5;
	Wed, 27 Mar 2024 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541312; cv=none; b=bKWY5FFGaK6n98vBbX1zrEYBtZLFnvyVPkiLFrtxZXvHsa8EuFMc6CMVq3qtpAPepirB4oDgar2xF9PKUONgNY+Ka7V8QtcqWBdF9klrpsM0PhGnzlmiSdIsg4Xa5zcDZSljnjmEO9seWKiKbGje44xJGwywevwj+R89zBjQP5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541312; c=relaxed/simple;
	bh=+6Y/rySNhxC1EF9/6EjIu3gQHaidUbRWc6Err1nFeCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AD4CtRDqHEEfaF+Iknjwdkb6MQ8cz3xdV9Zm40qe39a7xUMz7WSbK717/TEzxPv15vqHrbWOWO3dkI+utorUzJTXbh7pY6F6u2TpUlkYczjMvQaR+RSTWjLMXiqLSvj9GNmvYlFJWAaEHz09rY0Bl5WJH/VrVwc++VzX2Yd3CXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K38slKvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64A2C433C7;
	Wed, 27 Mar 2024 12:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541310;
	bh=+6Y/rySNhxC1EF9/6EjIu3gQHaidUbRWc6Err1nFeCY=;
	h=From:To:Cc:Subject:Date:From;
	b=K38slKvIngki1eEm0687YuzwgNCrtEOEyZmS/h48jGWt9hM3YRxWokbxxt697UrWv
	 aV3v7fkPuqwz00vdPI/9k7FwKZu7K/2WYcv6vxmw3C87TxcceYTwUwpwdXPPKOIF9U
	 uRt2bzoL0pnpdXND7NcaWhpbMn5/H/Flo0qInBottDs/zcM+f15obWyEKIkYHKBuZ9
	 voJW2/o+dZwz+PcEx6dwTPl5gJFBy1r/Udo9GDmvgCbl65xwoCQKkTnb2c3wP6/FY7
	 qJAf/ZJbbPt4SFFuLrxC/QqnS31luz3NejuucjbpXcYBtVuZ1AldPRpl7VRxooZymK
	 E8ZXIOxSw4o+g==
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
Subject: FAILED: Patch "drm/i915: Check before removing mm notifier" failed to apply to 6.7-stable tree
Date: Wed, 27 Mar 2024 08:08:28 -0400
Message-ID: <20240327120828.2826214-1-sashal@kernel.org>
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

The patch below does not apply to the 6.7-stable tree.
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





