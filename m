Return-Path: <linux-kernel+bounces-120978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 401B188E12A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBFA6286479
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF1B155746;
	Wed, 27 Mar 2024 12:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTfRb8LF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CB6155734;
	Wed, 27 Mar 2024 12:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541750; cv=none; b=HIPP92JH53WrSTL5z1iblJPmCrapNljF/J2sc1Mi+oRoR25GpOnOMjfqcyIFju35/9ehyoW1194yYDBaWcuGqHEnHo3gnK2Es3eMQtZEWIFxOLQ/qXD5Z3DYrGVhKyQHaNd0G4wT/FI0uewTsTLJ3dPLI98h401unyJ9iNc2jpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541750; c=relaxed/simple;
	bh=gSEg3FsJ7yLa9wiYXBGrlsIdWly0md4ZNt4KTha+zec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tyqSWp6E8/AZTrwijK7NKAL26jZsQM+tYaOBtd/lz26ZR9f7JPKUgm6EC63qlO79tDrs3BD6d+TJsWnNi5TAf5UclfPSqiNj2Q18KCUV2ozqCO3zSz+it+NZUTJOAgDejzuHXxbjN8vAUrn5cMH5iQZzAvwz83oPfIhWJrLsTl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTfRb8LF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06599C43390;
	Wed, 27 Mar 2024 12:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541749;
	bh=gSEg3FsJ7yLa9wiYXBGrlsIdWly0md4ZNt4KTha+zec=;
	h=From:To:Cc:Subject:Date:From;
	b=VTfRb8LFdHV73nW+pph4G1QOOue8RZbpDMTwKZiWRjteQe/+s1J9nAd7eGq9kDNFD
	 AU+9wV9wIOHqRLPjcNZIFJqSNMCoWQbqDXU3ZEJuBNURNqlBgTWfLNq9/W4wri6D5G
	 ewebDUYlq/3H2g6OsIZciCD7I1z+7mIfIsthG3qEAN9E9pX25Cry4wgwMdDl9qkW8q
	 iE7L69GyVU6ww/22oyaVhzZb0yZ7QRZKRmKBP+tK7mwCTz7d1/xbDxHXLpuUQhYxD0
	 AKnTcBMK4lVrFADpNE3LouvPPG3elbmEUKoVxlx6buX4OLMU1KkCxHB8GcxEuFTOLx
	 VweSCDyi9zVQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ville.syrjala@linux.intel.com
Cc: Jani Nikula <jani.nikula@intel.com>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/i915/dp: Limit SST link rate to <=8.1Gbps" failed to apply to 5.15-stable tree
Date: Wed, 27 Mar 2024 08:15:47 -0400
Message-ID: <20240327121548.2832193-1-sashal@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
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





