Return-Path: <linux-kernel+bounces-124755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A720E891C2C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599EC28A2EE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBA617EB89;
	Fri, 29 Mar 2024 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7SefPV7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8ED17E3C1;
	Fri, 29 Mar 2024 12:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716084; cv=none; b=JSrUe6PquIYSDhRNO6/bKs4OdMMZHVd7ddpvdAZGJbXAQU9QkgpjY/KHpfQWa5TwKNYvP017zRIPFACAudmOQj1WABct4syTuHyziCPfeXVuex8AsCPpgT68BnYm2KqSCjg65GoVyo4znWj9U6rT45lwrqgHtpaTrFuy1Vitv3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716084; c=relaxed/simple;
	bh=aBfxlAzff38Lw9SJcNvtB6NOL4XdN34vW1m0GjQTEcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCC7pkgyUoVu+PmXXbiltbpg/gf93fFJrJyb5EYnmgCXDJp3rIGLyYaTDYfzXG55aai1g7ZLLUOYcZnr5W4bxxoIcOD4f2D/63c4N+ZVij3s+7TaVzXtN88aV7xlxliW1GU0rKbsXDjyoy+Rsda/jzpqQyq20r+/Ko1uW9+o7Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7SefPV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADF2C43390;
	Fri, 29 Mar 2024 12:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716083;
	bh=aBfxlAzff38Lw9SJcNvtB6NOL4XdN34vW1m0GjQTEcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D7SefPV7kQfZCsoaip9uFS1zD71DT6gJAEOwGCUW6YnJI9HyHIzQQbUzzo8vY3kdK
	 u+TStC0z/VlLHtfARt/8Lk05hxjC/yeVMHczcZkZ7ivV94TSazJMEAuDkd9TlMvWaw
	 4jlHl2bszpajArbqEsGahl2CAVv0JRr9eN2Gnu3YGdyErpZGGoTeezsmOA8EfirFY6
	 BKXE51C3T1u32XUJNnc1jD+CcHUduPVI/SCjIVLm8FSWjWgdc5yiAh1p8rhVP9wxyp
	 mB303iyw5vUMRoSVxi9Wj80CdUbfkABYCdW7JqwJM+nREm+t0jWXr/FhFdysGsmBEm
	 67DoADYwQujhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 46/98] drm/panel: simple: Add BOE BP082WX1-100 8.2" panel
Date: Fri, 29 Mar 2024 08:37:17 -0400
Message-ID: <20240329123919.3087149-46-sashal@kernel.org>
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

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit dc90214ff58be575fdceb549f901506cdef5d093 ]

The BOE BP082WX1-100 is a 8.2" panel similar to the 10.1" panel
BP101WX1-100. Both panels use the same timings.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Link: https://lore.kernel.org/r/20240211111703.7567-2-tony@atomide.com
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240211111703.7567-2-tony@atomide.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index d493ee735c734..72fdab8adb088 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1367,6 +1367,23 @@ static const struct drm_display_mode boe_bp101wx1_100_mode = {
 	.vtotal = 800 + 6 + 8 + 2,
 };
 
+static const struct panel_desc boe_bp082wx1_100 = {
+	.modes = &boe_bp101wx1_100_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 177,
+		.height = 110,
+	},
+	.delay = {
+		.enable = 50,
+		.disable = 50,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct panel_desc boe_bp101wx1_100 = {
 	.modes = &boe_bp101wx1_100_mode,
 	.num_modes = 1,
@@ -4345,6 +4362,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "bananapi,s070wv20-ct16",
 		.data = &bananapi_s070wv20_ct16,
+	}, {
+		.compatible = "boe,bp082wx1-100",
+		.data = &boe_bp082wx1_100,
 	}, {
 		.compatible = "boe,bp101wx1-100",
 		.data = &boe_bp101wx1_100,
-- 
2.43.0


