Return-Path: <linux-kernel+bounces-121224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B420288E420
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8161F2F5C1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82351411CC;
	Wed, 27 Mar 2024 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIg4l7+R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB87118B618;
	Wed, 27 Mar 2024 12:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542392; cv=none; b=Zzqa6I5jiGUZljIsbhsNI97uyOY8VhTJT6MVgA/UclwL42AlmQmUDIv4YnrSeFw8ACNq/aQQvrJkEjfmReWKfX3sPdWQNWnlx+kFJmpkw49zPBkXRXmKL3+I5oRGkIvwQQvp4Swp80kAf8P6Eeyd7df2ixLR2QPlVavEAvq//+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542392; c=relaxed/simple;
	bh=c6I8Ilt7BMRkOWNzIl697pUiKROGT3eJAxfs/f6ncJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cU7lUwPMywWwFaIiuebg0S/9gWTvimzm/ZIa9qinqUt/lLrG93baUPNX1+4dGYC0WdEPXmt7KWqpR7DhBPXc7x9ZDztBt1jtrSn9BKNsSS6nSwTbIafE/eDwEV9uBn3azEgtrmcyqXGOBz7BLh80aByFcbKV+krfBbXCeVtJVSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIg4l7+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B900CC433F1;
	Wed, 27 Mar 2024 12:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542391;
	bh=c6I8Ilt7BMRkOWNzIl697pUiKROGT3eJAxfs/f6ncJQ=;
	h=From:To:Cc:Subject:Date:From;
	b=XIg4l7+R5UQi2IglUDLt22Q4mTZBnecJFto7c+lBwKKvlwVWYzEpKb9F2kZnHf3cM
	 NVMAGFgEzpwgzv7l6iHdW99T/ZZ4rj6CvS/B1GtxNCH/wTsgrhgEsuDIKFdCAkkeE4
	 kB8t1yHxFFWRO++ACxiVZHswwcB9GaIzZ1eL08lFUdFyUpcqOQF7p/5TjU1b689mLj
	 PzavNI8TP0iKqPOuZ9tjkejCZm2+uxXH4ujbeaXJR7onTuhaliRRjQJIo1tPPsXFQ3
	 eHqlKfgzSxIS+KCHwkAwQ5R+YXzJdO8v7/q2nVroLkKEZROELU2qls7bhh/IkNhYfJ
	 E9MDIWbe8BtrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ville.syrjala@linux.intel.com
Cc: Jani Nikula <jani.nikula@intel.com>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/i915/dp: Limit SST link rate to <=8.1Gbps" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:26:29 -0400
Message-ID: <20240327122629.2841148-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6061811d72e14f41f71b6a025510920b187bfcca Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Date: Thu, 8 Feb 2024 17:45:52 +0200
Subject: [PATCH] drm/i915/dp: Limit SST link rate to <=8.1Gbps
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Limit the link rate to HBR3 or below (<=8.1Gbps) in SST mode.
UHBR (10Gbps+) link rates require 128b/132b channel encoding
which we have not yet hooked up into the SST/no-sideband codepaths.

Cc: stable@vger.kernel.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240208154552.14545-1-ville.syrjala@linux.intel.com
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index ab415f41924d7..5045c34a16be1 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -2356,6 +2356,9 @@ intel_dp_compute_config_limits(struct intel_dp *intel_dp,
 	limits->min_rate = intel_dp_common_rate(intel_dp, 0);
 	limits->max_rate = intel_dp_max_link_rate(intel_dp);
 
+	/* FIXME 128b/132b SST support missing */
+	limits->max_rate = min(limits->max_rate, 810000);
+
 	limits->min_lane_count = 1;
 	limits->max_lane_count = intel_dp_max_lane_count(intel_dp);
 
-- 
2.43.0





