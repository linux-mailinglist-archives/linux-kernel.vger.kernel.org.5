Return-Path: <linux-kernel+bounces-120909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A88A88E067
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 492001C29581
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2C5131BD7;
	Wed, 27 Mar 2024 12:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1580LdN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308261487FF;
	Wed, 27 Mar 2024 12:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541556; cv=none; b=RcJZLS90iZSpEfNGbqj7UB16kXyrfEbNBnZ+KOAaDzPFTxx4oKJX1RcKXh0XE49Lgkj2O7pnKbXyl6DWUdzFwrzc5U+ULpX/hRUb10C40QFrI1VIMrHwwqiMhsqx3jitNPjG25wtPr+4xqbYkFAVYmK5zCsfrFNoonHhYhpX6Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541556; c=relaxed/simple;
	bh=Hn5Xtt8cfgQCV4XlMCbeyL8L+BxqJXvYnJjave/+Qxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OizlwnMC9FJGjQ52xkFVJv5o2W4mCRXa8zXJCr4eNhZgiWRrNRQGukXOI/IUwEjrJrvJ5PQbqvw3RjPH/N7koSrSPKIYLBpeVnI9Y6lVg4aSMvur7Em3hsBoXE3alyEHdb1E561p/F4Y4onLUGPBSq3VlHkNot8giz+N94NjK94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1580LdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B8DC43390;
	Wed, 27 Mar 2024 12:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541556;
	bh=Hn5Xtt8cfgQCV4XlMCbeyL8L+BxqJXvYnJjave/+Qxw=;
	h=From:To:Cc:Subject:Date:From;
	b=G1580LdNE/uM1DYumzwue+Wgb/1uw015BDWWPdF7EIZwzgKjlxHUI+jPzNGnLMJBg
	 SQuyBSdWOTropYUcyyOSBRATB+Y79OeU5tfOeUa/iQSA2An2HFYxUIfMRlXPt5NoQK
	 vpdHTkAC/gkXidQ2zxiFA29bvjsi/y87hEm4RY1jfFbmo3a2YGVE/9wpuqlBRCY+UP
	 AZYOi4BY7cIKWCt7ADR6aihzYMV4GQV2cw8guXnqgd7u3sne2xk9J9xPuTXJEL4jlv
	 OSzzNuFetfgxkMwXU7TlN1CainkwRAJ4iHwcF3IMLU/aQrS8Z/Fqj1dGXqAB9diJXF
	 TGte1NC5zwD1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ville.syrjala@linux.intel.com
Cc: Jani Nikula <jani.nikula@intel.com>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "drm/i915/dp: Limit SST link rate to <=8.1Gbps" failed to apply to 6.1-stable tree
Date: Wed, 27 Mar 2024 08:12:34 -0400
Message-ID: <20240327121234.2829619-1-sashal@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
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





