Return-Path: <linux-kernel+bounces-120796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F7F88DD92
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E7781F2642B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554B4E541;
	Wed, 27 Mar 2024 12:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UufXcIIu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9945212DDB9;
	Wed, 27 Mar 2024 12:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541226; cv=none; b=h7U6MehSWMC3hjBw6wfS9ZXbB1B44q4tKvIvskAGgULsRFQmgsHubxa/xGNst/aCmqs7SAIvwfSq8IAgXfPPx0V3uTJAGjgb2+Quq0D/NOpVzisdiPWWjQzBI1cBVReDs4601IHHyW9koBacjTL7A4rNwzPj1kUud1vTUpSjk6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541226; c=relaxed/simple;
	bh=/43Y8blBbhBXwpL1ANH55PCjO3D5pu5+GO6xkE7RQCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SzEHLJb5eu3KNx0iios9IhzNnwPb1j1UOrUYo1mcr+BFyFZr1ke764HOdmC0COhb45H/XdGYt/wGnEIGVRuBnZD5C6pPhbMl+RHVc3Ny/nCQ1LqqcyYBWnuncMY3SGMr2eWsY0AzLp2Dr56U2M5t2hLBCuoiU5gKy697Bhvnkvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UufXcIIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80DEC43390;
	Wed, 27 Mar 2024 12:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541226;
	bh=/43Y8blBbhBXwpL1ANH55PCjO3D5pu5+GO6xkE7RQCg=;
	h=From:To:Cc:Subject:Date:From;
	b=UufXcIIu9iW05K0HELPQIwXkuZQclTaZRnl3AS40n1FylnXo23l7aBNHvLl6ZeBgy
	 VvBcrnl/ljxwLjnpCPFIJzA1ha6V8LG05mtmzyN1rzN7cdiQrIsHm8NPddOwzwaAOn
	 5nczZRW7cedx7JLJ+efviH9aavcaHCSVkLR/C3v/w+i5F2gNN+zdWJF8clKeBpDM1i
	 Kue3ifLZ0PN1F0dS1fT6QYXp6vuMAO+h9J3z31iwz9LVf+mc5skNuWWWKio8TDJWnz
	 NsXqEAekJvKYyt4Fh0QgFLDIF2CcQZrjqqbbnwUAa7Za7C6lMpPOcMum4LBMkGRVaS
	 xRP4jidbvG9Ag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ville.syrjala@linux.intel.com
Cc: Jani Nikula <jani.nikula@intel.com>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/i915/dp: Limit SST link rate to <=8.1Gbps" failed to apply to 6.8-stable tree
Date: Wed, 27 Mar 2024 08:07:04 -0400
Message-ID: <20240327120704.2825093-1-sashal@kernel.org>
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

The patch below does not apply to the 6.8-stable tree.
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





