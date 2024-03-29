Return-Path: <linux-kernel+bounces-124812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 031CC891CC1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DA5EB27A15
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11631494C9;
	Fri, 29 Mar 2024 12:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFALz0Np"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63631494B7;
	Fri, 29 Mar 2024 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716216; cv=none; b=foTQrqaIdTQ4c8cFVAi8TkBhKrOJurUj0myfbyD+hgKB2MO/lgaak5Cxa5isKog6g1G2IrSNGDnGWoLoBXWOnEAUAWly912KpHi+gE+OiyuHXEUDu8FKdZg/UO4vHmdvFWsB9ZRPa5xb0sWHzKNgdRzkhuyHa7oVj8rwpFR8dfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716216; c=relaxed/simple;
	bh=unAcMRuAE1vIWssF2K6cGs00MZFhLexNVVz7+k7K4PY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMWXfqbDppRwp2uQHJ3kuLQz7E93yNa1O8VygOyPmUK7hyCtRXvKFzx9w9RZ1cRjUcCOUQney/1ALepUZ9W+ZbVQm+BHng8i+DkvvMDu6YwMSXoucPy1zLCY2yTuFoeFnh9EXzoBhLWaNxxIHlEwUGS+F1bvwvkwygQzVpU4d34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFALz0Np; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AB7C433C7;
	Fri, 29 Mar 2024 12:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716215;
	bh=unAcMRuAE1vIWssF2K6cGs00MZFhLexNVVz7+k7K4PY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HFALz0Npzv2X2l80dJHDlVwv2xDTND8pTJwz2AWsfgae9+SsNHSSzw1fkKPJPJ3gy
	 z8PsywHS0YAqWbC14wTyGSFFhQlZUi7pzwqFAjNAH0mz/vgruZuh9mooRUg5xzk1cK
	 U6v0YOklIR0RMZY2veyW4ECv6ATB55vOnA6dI8lh8EI0B/HXl2FDkcG5hbn0YN2Sn2
	 1UCnnFXpeIlIiUAhOs7yWXHa85wVQgqs1JDhwwQf+ZvH5UU7JCCh28a4zFw28VjQJZ
	 HiTzTvn9ttvEHbwMdvvRYyn2dBAkQmo/qJJzrGZL+BK/4feouAckLEPRhsxgLtianV
	 5td484kxyVRsw==
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
Subject: [PATCH AUTOSEL 6.6 03/75] drm: panel-orientation-quirks: Add quirk for GPD Win Mini
Date: Fri, 29 Mar 2024 08:41:44 -0400
Message-ID: <20240329124330.3089520-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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
index d5c15292ae937..3fe5e6439c401 100644
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


