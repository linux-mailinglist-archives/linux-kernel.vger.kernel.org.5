Return-Path: <linux-kernel+bounces-120857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5968988DF76
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0C27B273C8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACC213E6A7;
	Wed, 27 Mar 2024 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mha8lhqi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCCB13E413;
	Wed, 27 Mar 2024 12:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541404; cv=none; b=s3CNaugRd2gP3JFVT1K3warBzhyHMXK93BTHsq5fYuFsb9UGc4xkmdKpTkKumsW7E93nw9m98Hv1Vom03ZcDawMdaOBMgIBrleM0ffGkFn6ThiTmPQTZVmEJhr3CiwMKV/wdD8nmALzdV9l7eFpADTpw3ByhwRr0g43FThXNR7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541404; c=relaxed/simple;
	bh=RWEIZ255bmbgDlx7jX6+2xTRGrPjXnnv6wh8EEn9Vt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hxHYDl97MfbtpTlzM0NIBSneNS80iSm6a8O7L0yEfJZ1tMLpzjxYFNZRfU8lGqY9kq3rnXvpuS40UOgfkKUEoH7SxFBxUC5o2SpmsYQQgsT2Pu4Ubt57guTaqcOkXVb/zXUmrgefhI6M8aMQyDYmy2e8+CfY2FTdfusZ7Wju2sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mha8lhqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BA7C433C7;
	Wed, 27 Mar 2024 12:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541404;
	bh=RWEIZ255bmbgDlx7jX6+2xTRGrPjXnnv6wh8EEn9Vt0=;
	h=From:To:Cc:Subject:Date:From;
	b=Mha8lhqiBPZaR7/fWt0cpTHXOJ5/f2LFA6j3eIjl57RPbLuhp2YVXZ1wPtwNrv76t
	 RPNotuhf3Je2wzlzmsHknn5n7gFfKBK7qer72dT6hZcf/c9mP2AfBHYkSYSLKbwXQt
	 6NM2RITspTFlF7JxViRTbKam4uNSlbg9RZ4IcTm6MybQXNQqKAskt3Ebi8idZIc/e0
	 mFGrfrqAz1XzWvVad1sQNoKcQaSnKmyHUGl5Z5nVMgPLicvEblhDyT2Hb9LNeSAezM
	 nNCLsF7v5lcAUmd5RYN4P6bwLNPtPJICUzt2nhGKFVACyL9egpiKQHzht68a1Jr5Mh
	 QTr/P4ycfVNMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ville.syrjala@linux.intel.com
Cc: Jani Nikula <jani.nikula@intel.com>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/i915/dp: Limit SST link rate to <=8.1Gbps" failed to apply to 6.6-stable tree
Date: Wed, 27 Mar 2024 08:10:02 -0400
Message-ID: <20240327121002.2827540-1-sashal@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
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





