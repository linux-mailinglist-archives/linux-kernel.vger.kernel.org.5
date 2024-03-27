Return-Path: <linux-kernel+bounces-121050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 320C588E1DB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE66297229
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEB415E807;
	Wed, 27 Mar 2024 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDYha0AU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AB015ECC0;
	Wed, 27 Mar 2024 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541942; cv=none; b=bkEDX/59u4SVZVbJZNCrrcHLkcIHr7CtoJ8ewnzMwjhVdvGSCECXfbD1tSuqu1rs1XjLZ0bhLMRk59BjpXmfsBATRqcIY8L7/rZv/kwNA3qDXyk6ye36xfSSDrQNd3CfC80ONvw6HMJrkM/QOkwxlrCY7t3R1LebfaTC9Vnwy4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541942; c=relaxed/simple;
	bh=HQQ7qAJ7liJVQKz5cGHu/TbgouZievKm1GmpU7Y10Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YPz7zecRjFNf+06fISK8+HqAW9nfmL8nJXc3w/OQwmSvngXLbjcz9DZe++K0/Rn8aLVc0OhSuQuthLGXBxYScgpEriJwVnTlhpnqSxR2nCTwGT4UHSeIr8qjhBVZlCa3cYuM2mpipPmz8LSwzkh8cJEF4q5qY2Ek8G2dwwaZ1iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDYha0AU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524D7C433F1;
	Wed, 27 Mar 2024 12:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541942;
	bh=HQQ7qAJ7liJVQKz5cGHu/TbgouZievKm1GmpU7Y10Ws=;
	h=From:To:Cc:Subject:Date:From;
	b=CDYha0AU1m3USQnZ+OYqyeGzpeWGKQHYJwR/2SFCUJyKLMv7Jo4tkJCRRwNoUAJwJ
	 c6BACWeV4t/BqFAaO7gOayQ35gz+gh8sssLjLMIqintQGS3QG6jeMuFtpnteSC1B9I
	 VzgigqqtCUWQMDaQxjdOrRuHF7N7AIrz65/KJYHPeoJwafCPR3n/e0NT7GXPVZJB52
	 aWdKZxfjqawHTGr/CDVICTjVhXUX4YN8MSGo7N0JBLxIqRC3I7vJV+eWImmfYdkPMh
	 mk8EMzWL+aazzI09ntVu1fr2kGalpHpamLrzd9KVytCox5odhKdnLkqkUjJ44QYgw7
	 DX9Xd0QOp07pg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ville.syrjala@linux.intel.com
Cc: Jani Nikula <jani.nikula@intel.com>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/i915/dp: Limit SST link rate to <=8.1Gbps" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:19:00 -0400
Message-ID: <20240327121900.2834849-1-sashal@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
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





