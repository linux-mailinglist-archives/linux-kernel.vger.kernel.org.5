Return-Path: <linux-kernel+bounces-61615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BD8851460
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 402D7281BEA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181CE3B18A;
	Mon, 12 Feb 2024 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agMK6zpv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0223AC1A;
	Mon, 12 Feb 2024 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743613; cv=none; b=X1DX2Ci5fA0N/uz2A5QMLVYiXxS3jNnSwVlUDQGfGdYht8ruas5ZkS/4uclWdnORfUNB8tF47bu7ViuZQfegaC+KsM49c4NLHbMyV5obpl2RJnpx/O2ET8voaWiv3JgqszizYaweTjGE49naVA3Y3G3mWqOdGHforcYvy7GsfQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743613; c=relaxed/simple;
	bh=81lEe31K2YU0V4EnFq3xxesUJy/t9LyYJwWTzno5+Rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=prttT1JfYoyfYAedA2SvHqieJamueWHayyh+mjjjAY9HM/WKI6YTis065IucKK8taOrOUCc/TtmIFJuiCMWJq3PFgDoHFOB/v6B0IeS1Bd4M+KfpQeDYr/e35j+L5dTCRTJcTONUsJFmReuJYoDkPkj13+Q3ltXPxtyIklGJfnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agMK6zpv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B5EC43399;
	Mon, 12 Feb 2024 13:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707743611;
	bh=81lEe31K2YU0V4EnFq3xxesUJy/t9LyYJwWTzno5+Rg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=agMK6zpvNkiF/exIgCw6MWEwPTwthUWbp7r55Qi9e+QM6MF82pxE8GXReInl+uxkt
	 UPWPI2UPVwJcvRL6hcKHnuiwe6Y+Jpn/I2OcLbGU7AwRCgF7I7fzwp4uitSHUGp++B
	 w3xGCk7/verBbLy5tcOGxTqnUbzKS195N15pPsSVHCsjMgpmDkilLn3p/77QjXaGkr
	 CCF4AZ+czm+PdhZ6fMmv1A2OgWRmLC5ew1XN+SJMi5bk20J43QtnZqe3PjjtnRN2mb
	 vduSytTdtFAhd1qL95znRl0o40rcMk0BbNhr3K+n7m3vgEK4f2dYKr3AklojLCZaLM
	 GiHMhmb9msFog==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 12 Feb 2024 14:12:44 +0100
Subject: [PATCH v6 01/36] drm/tests: helpers: Include missing drm_drv
 header
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-kms-hdmi-connector-state-v6-1-f4bcdc979e6f@kernel.org>
References: <20240212-kms-hdmi-connector-state-v6-0-f4bcdc979e6f@kernel.org>
In-Reply-To: <20240212-kms-hdmi-connector-state-v6-0-f4bcdc979e6f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>, 
 Jonathan Corbet <corbet@lwn.net>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=857; i=mripard@kernel.org;
 h=from:subject:message-id; bh=81lEe31K2YU0V4EnFq3xxesUJy/t9LyYJwWTzno5+Rg=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKmnJONyhB9FcElXrd69yPRXoObCkusKM1a2Hv5oaXJ4z
 +Hk8hCXjlIWBjEuBlkxRZYYYfMlcadmve5k45sHM4eVCWQIAxenAEykKonhv0fno5pP9Vc7D/+Z
 d1Fy4WvWJZy9e/cde6KwQjduwbKZhYGMDGdOfGx44vFtk85ti+fdSxJK35UELNHaWctYFPVA8UI
 PFzcA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

We have a few functions declared in our kunit helpers header, some of
them dereferencing the struct drm_driver.

However, we don't include the drm_drv.h header file defining that
structure, leading to compilation errors if we don't include both
headers.

Fixes: d98780310719 ("drm/tests: helpers: Allow to pass a custom drm_driver")
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 include/drm/drm_kunit_helpers.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/drm/drm_kunit_helpers.h b/include/drm/drm_kunit_helpers.h
index ba483c87f0e7..3ae19892229d 100644
--- a/include/drm/drm_kunit_helpers.h
+++ b/include/drm/drm_kunit_helpers.h
@@ -3,6 +3,8 @@
 #ifndef DRM_KUNIT_HELPERS_H_
 #define DRM_KUNIT_HELPERS_H_
 
+#include <drm/drm_drv.h>
+
 #include <linux/device.h>
 
 #include <kunit/test.h>

-- 
2.43.0


