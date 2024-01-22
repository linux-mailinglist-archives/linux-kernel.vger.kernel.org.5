Return-Path: <linux-kernel+bounces-33348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D175783689D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 813DD1F221A4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D5365194;
	Mon, 22 Jan 2024 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1SwxWwg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F0C64CE4;
	Mon, 22 Jan 2024 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935949; cv=none; b=RaJzddWsNWJnOkU4PpozC8PHGTswaSZCxN12j36TGXLBgnl6njXmTg1ffPl3OuNAZ/bBDzvH2ujOhAad6aS7smW8JFJ6bSwpKduJzolpwJ2kFTYArKT+7uaoGbMgCvzELWr9VZmBUWM3JMCjjpz/K8j7nBjCtqb22YfahdhXEEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935949; c=relaxed/simple;
	bh=czHMZ8afmUww3mrTkrBbxdizfsByb75ouQpZiiXkEuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4wayymahzaSUmaK5fvXj5QBGSqTEyyOF61reFt9w5QiIAJtm3pOpK0lv7b31NCq81K28fBc6VqINv3sPewmukot51/QOfF1/3WPzdLwdpcMYHIeGaVT22cPWL9QV0IJMG1oue8/bOVK3oHDPR8TGDhSGFWgej4YsNoWAW93qZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1SwxWwg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E594FC433F1;
	Mon, 22 Jan 2024 15:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935949;
	bh=czHMZ8afmUww3mrTkrBbxdizfsByb75ouQpZiiXkEuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i1SwxWwgfeAXS04JaQA6gpnwU7bvGKiGGtZSZb4FLEB7KkTu9hPvBu7Knm1ctwVbe
	 pl7cPuQQgd0M+V5cyEO6foC6FgpO+1ik9gEkgLy4eT464BXdRKh+eKi5JS1Gd6rtOZ
	 IJq6d1hE149Ek4zECIH64f9XjXR8Y8EAZL6tJgDPvCr/8esWnVNGMIwroFE+D72LL5
	 aj4VrUdxTnqzf6ugr5zTPCNajglrj43ZYWxlHbChq6Tl955yFNEq5nTMf+80cWVTb1
	 iEVDmenvXAKAIwukeVX9woBn3HbVo5RjIF5syS2qwgbLkco3V1VLX8ryoVZ5ADW4g6
	 tw4jEyGQk5xKA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	robdclark@gmail.com,
	quic_abhinavk@quicinc.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	quic_khsieh@quicinc.com,
	quic_bjorande@quicinc.com,
	quic_vpolimer@quicinc.com,
	swboyd@chromium.org,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 26/73] drm/msm/dp: Add DisplayPort controller for SM8650
Date: Mon, 22 Jan 2024 10:01:40 -0500
Message-ID: <20240122150432.992458-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
Content-Transfer-Encoding: 8bit

From: Neil Armstrong <neil.armstrong@linaro.org>

[ Upstream commit 1b2d98bdd7b7c64265732f5f0dace4c52c9ba8a8 ]

The Qualcomm SM8650 platform comes with a DisplayPort controller
with a different base offset than the previous SM8550 SoC,
add support for this in the DisplayPort driver.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/571132/
Link: https://lore.kernel.org/r/20231207-topic-sm8650-upstream-dp-v1-2-b762c06965bb@linaro.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 76f13954015b..eec5768aac72 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -171,6 +171,11 @@ static const struct msm_dp_desc sm8350_dp_descs[] = {
 	{}
 };
 
+static const struct msm_dp_desc sm8650_dp_descs[] = {
+	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
+	{}
+};
+
 static const struct of_device_id dp_dt_match[] = {
 	{ .compatible = "qcom,sc7180-dp", .data = &sc7180_dp_descs },
 	{ .compatible = "qcom,sc7280-dp", .data = &sc7280_dp_descs },
@@ -181,6 +186,7 @@ static const struct of_device_id dp_dt_match[] = {
 	{ .compatible = "qcom,sc8280xp-edp", .data = &sc8280xp_edp_descs },
 	{ .compatible = "qcom,sdm845-dp", .data = &sc7180_dp_descs },
 	{ .compatible = "qcom,sm8350-dp", .data = &sm8350_dp_descs },
+	{ .compatible = "qcom,sm8650-dp", .data = &sm8650_dp_descs },
 	{}
 };
 
-- 
2.43.0


