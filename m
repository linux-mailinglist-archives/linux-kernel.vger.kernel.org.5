Return-Path: <linux-kernel+bounces-124714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6E8891BB8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA614B24A41
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6A6145339;
	Fri, 29 Mar 2024 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCUqlDRb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386CE145321;
	Fri, 29 Mar 2024 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715970; cv=none; b=ehJ8Ye1dAQZO6b98CBAXrcUEXOYEruYv5IBNd6JG897DT3XmWPxgPEswBjxUTxfU7PhS1vIFggUZs6oFwoVOywNDhp+SvKh7jSw1i5+NXWrvHrGQYR8jk/Fff+ngYfmHhUjRVt4rNGKzmjQ/fZrG8Up9mp6NDoNMd+E7NAiNDKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715970; c=relaxed/simple;
	bh=gNn0eGRs3G+bpg8uuW+xOQSr8p0k5GYdAyTCRrvHaPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXhoSk+OnCR1HOOgdyKTMf0ldL08M5YYaN11DuqLW9Zw2ZGoibIX2UQJZXHiZvfUwa1+GqPUBrCdISLq1JVVDLma1aaM/BiOFfBa1zuulthb7ycDgQ7EfjiRBnARAywnNnPZE7BAGLGIVsj2D6eS1/ZIrJfka7vSygT22uU4+kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCUqlDRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E14FC433F1;
	Fri, 29 Mar 2024 12:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715969;
	bh=gNn0eGRs3G+bpg8uuW+xOQSr8p0k5GYdAyTCRrvHaPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RCUqlDRbm++MaerrW2uGJIxZrjjsAAJWtUlf6U9TOnaF7dTgYjqpgFr8aCdqirBLU
	 OY1ZpIKK/hpn0dMht5yPULZRYbXG2T8XuaA/orKYXUdDDXcj2G+bjdLMUZbhUuSAHM
	 4QobAZpjT+gTYUUc7HnYCM5YnVAoPIdfKXbhtmb1DvWe4uCZnNkrQNvl2Mo0ofKuQs
	 0KrJSa/Lg37t2f3VGgPAVXmUXInZWUGBmWvJWb7vmYrBcYUu6NjKsEGOFc3alzs7Cf
	 Vpl1Jz7MsbOA6WGLrusm6E4eIfX2rHRa9u0AHKjeHAbG7lrbN7OHnyq63lLnxXrqwS
	 CvJzMKr3Rs9LA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Samuel Dionne-Riel <samuel@dionne-riel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 05/98] drm: panel-orientation-quirks: Add quirk for GPD Win Mini
Date: Fri, 29 Mar 2024 08:36:36 -0400
Message-ID: <20240329123919.3087149-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Samuel Dionne-Riel <samuel@dionne-riel.com>

[ Upstream commit 2f862fdc0fd802e728b6ca96bc78ec3f01bf161e ]

This adds a DMI orientation quirk for the GPD Win Mini panel.

Signed-off-by: Samuel Dionne-Riel <samuel@dionne-riel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20231222030149.3740815-2-samuel@dionne-riel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 3d92f66e550c3..aa93129c3397e 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -117,6 +117,12 @@ static const struct drm_dmi_panel_orientation_data lcd1080x1920_leftside_up = {
 	.orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP,
 };
 
+static const struct drm_dmi_panel_orientation_data lcd1080x1920_rightside_up = {
+	.width = 1080,
+	.height = 1920,
+	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
+};
+
 static const struct drm_dmi_panel_orientation_data lcd1200x1920_rightside_up = {
 	.width = 1200,
 	.height = 1920,
@@ -279,6 +285,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G1618-03")
 		},
 		.driver_data = (void *)&lcd720x1280_rightside_up,
+	}, {	/* GPD Win Mini */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "GPD"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G1617-01")
+		},
+		.driver_data = (void *)&lcd1080x1920_rightside_up,
 	}, {	/* I.T.Works TW891 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),
-- 
2.43.0


