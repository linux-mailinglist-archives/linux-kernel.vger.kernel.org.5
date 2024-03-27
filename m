Return-Path: <linux-kernel+bounces-120959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A1388E0F8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B23D1F2DB5F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EB5152E00;
	Wed, 27 Mar 2024 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCQPNP27"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEC6152DF5;
	Wed, 27 Mar 2024 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541698; cv=none; b=UK+oV5avDK8mIINXerZ9BWoWXz/F6RLxBXUp4CJK+zAvpkl5gV4aYXdzP7kfW1zTgKYYg+wjANiGen6JzyAm3H1QhhMLHVsoXuTbRFAwUCaEgNUd52uaCoSaCqLRhl0MvmMHvItLttW9ugy/G72r3xMsCmtOAAJLwiaOTKekLFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541698; c=relaxed/simple;
	bh=Y3gYdt06EUc/YiIiQHUuEXpUvGyjkqcRA4kCPskLo4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G/1JDEgoiSJQu9vhB/qh5Kj1eqrNpbZ1qPOzHNvAfta1ivVnXVAE8exfLJGdQM2dXYib5JVasX0j0z9etY30liZGpW2HdlT9mN2KWniHB+gRyaHw54+QbHBIHL4PpP6+StIuDXDn4Gl6ctp63OIvNZf17iYZtdPsFjutPqpNlwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCQPNP27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720DFC433C7;
	Wed, 27 Mar 2024 12:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541698;
	bh=Y3gYdt06EUc/YiIiQHUuEXpUvGyjkqcRA4kCPskLo4c=;
	h=From:To:Cc:Subject:Date:From;
	b=gCQPNP27PnWVNf8ZcAMsjRLnmCSRsWjTq+QQOfbH/xlQ/Y1xmOBt7u1tgmQ+7MKLT
	 +X0wllq7T1VyYFKMcDTBHShmRyKGZeE6j6n+tJUsWaF5yFHoZtIhBTtpLXnWlzVVQF
	 hIRcWjhqEChOZuekp7T/OkpE/u68NZZMpJa/wEqr/wnZ/iQM8ye9McGAfQ2CilH2lG
	 Sl4Bcq+OYJyvXbUd7ptN5pTm62mi+YkdA00MVTdtpPsGOz+s1hcWOg6Utr/WwKUqUH
	 8QKObH3FzzUMHfVJiP7DZ0B+e7NRtzCI05TeFHnp8uMYZmIU2HuRW3aevGYh+923FL
	 J1QSiNNGDzbkQ==
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
Subject: FAILED: Patch "drm/i915: Check before removing mm notifier" failed to apply to 5.15-stable tree
Date: Wed, 27 Mar 2024 08:14:56 -0400
Message-ID: <20240327121456.2831492-1-sashal@kernel.org>
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





