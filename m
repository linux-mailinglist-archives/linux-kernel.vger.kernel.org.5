Return-Path: <linux-kernel+bounces-120846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8160B88DF20
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37CE81F2EC33
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AFD13BADD;
	Wed, 27 Mar 2024 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ch5m27B2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCAF12FF6E;
	Wed, 27 Mar 2024 12:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541372; cv=none; b=PKjdGaMo/zEN2JCaJcACn5ypxU6/GWIlnk9FuVHlW6pBOC4yMq6aJMxkpGR5L08RzmUQA98JdmtVwft4Yf8S3R3sFQhA1jW7gvtpmfyAX4ql2/K8IUtFR/Z613IRembrSpk2Jiho6+qNIe9fXZIlBSrnojxUInp2WCkNWO6qyBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541372; c=relaxed/simple;
	bh=r8CjedoAGOnsR5731C64zxM8vQnk7uyMIQsl69lVsig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M59DT+Y2WPGLSZ+sh73jxL2ZIGgEKXxeKwjn9+s7KQGhoFsGX96FwsZ0BBChD+if5L2beYa89TbHmU7p8EFc9f6ZqqPEqylPAPk73tIXgY4Do07SkfQN0T7UWeF5h0nNHZ2uFfLCL7cDQqPy/BE9pw3IkgdzRoPsll1zjn3TtoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ch5m27B2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945B8C43390;
	Wed, 27 Mar 2024 12:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541372;
	bh=r8CjedoAGOnsR5731C64zxM8vQnk7uyMIQsl69lVsig=;
	h=From:To:Cc:Subject:Date:From;
	b=ch5m27B2+5tUvH0Vy4apYSI9xNMI5LFPhNouCo98Xw9emKJBggC+HJRsHqTyaKSRV
	 vkPU4BExp5l/ED+ujWMTBAoN3LDKn2e1wqAd62RZLhTWkQd9zBd2CfxYezTUNfyWtg
	 YzLMssUQx5vx8ntayQIDMCy1ns/RXyJrkG4Oo5KYfCrY6toCl0n9aNbZBgw3M/LlhE
	 bnDKO7VgSbaObhBLnalGXuxOkUg19pxTRciypieagJ7W1n+REtMhjBTrdSgwT+418S
	 SmpOV9nlN7watBRx5dLLddFwGCgdupt1TADgqF0O8YIvAs1LNJ+/7K0pxZdudQurIj
	 zETx6OwsmrhQg==
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
Subject: FAILED: Patch "drm/i915: Check before removing mm notifier" failed to apply to 6.6-stable tree
Date: Wed, 27 Mar 2024 08:09:30 -0400
Message-ID: <20240327120930.2827120-1-sashal@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
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





