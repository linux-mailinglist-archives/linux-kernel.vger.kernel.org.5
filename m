Return-Path: <linux-kernel+bounces-113374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBA68883D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5681F2591F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C7D19EE22;
	Sun, 24 Mar 2024 22:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ip+5CDQU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF03F19EE05;
	Sun, 24 Mar 2024 22:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320175; cv=none; b=N4hpBhbluh8NnANByrlXLo8T6edie4tKwdsX34wxZBupA0CkXmp5o1tPu99E4zcAEpBTAsqZuQ2O8qB81whEjxRKKRGjsPy4jNCdoI/4WwbIqlgTkQtBlAyP5XY2SAbBmtnxEJE9zX3OA4J//+KHXMeUDgxx3aIddxJhGgmuRtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320175; c=relaxed/simple;
	bh=97fYqvoyWoojc4WVtMU5TN0AQq0iEGtqgA6cQ1Sz7iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2o4LT1amJKe0oBXLdPaA6lOUcNZEDsGoMLoOk3sJoz/2Va9r8h6IWV3TUsG5z26vGQFdgSfXaZCLb3xckIV9vkYdZBCPEpPirElWxslZdOI/MoTr8x2HDGBYeRN3Bk2qLFHPHyaZsP9IVYQro1/XQhAu7U9SUljhwxizo6H1BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ip+5CDQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BF5C433F1;
	Sun, 24 Mar 2024 22:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320175;
	bh=97fYqvoyWoojc4WVtMU5TN0AQq0iEGtqgA6cQ1Sz7iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ip+5CDQULsKJbQYBKWqtDZAF6FcS5q5ksUUdt3wPatODbG2m+2K5m+nx+R9YLVjK0
	 9df7uV+D7eAeb2Fswjt6b5L4ScH4f5z5SijsonQggh40WeXjUC1f/ekXEtBXVX2HP6
	 A4cSxSbZm2o7k5nRjJ584A08Bp7ln/wgQGSOdfaxWaerKm4EmTm1jiNDc2luXiBxVx
	 SeRm03nL8MLJpDL5HgVbwZu+2D52pCs8sDiJXo8eudWkBiBFfBc30PFRtFwSCcRePx
	 pSuVwEk/UGlkMis45yjVIX4JpoEentWjNNVQM2qVxMVqMUCN18rJa61eDBaAHHJkHf
	 mFBae/6/NgBig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rob Clark <robdclark@chromium.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 483/715] drm/msm/a7xx: Fix LLC typo
Date: Sun, 24 Mar 2024 18:31:02 -0400
Message-ID: <20240324223455.1342824-484-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

[ Upstream commit 0776ad9274d96d132131af66a5941df45b9d46b4 ]

We'd miss actually activating LLC.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Fixes: af66706accdf ("drm/msm/a6xx: Add skeleton A7xx support")
Patchwork: https://patchwork.freedesktop.org/patch/573043/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index dc80e5940f51e..fd60e49b8ec4d 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2426,7 +2426,7 @@ static int a6xx_gmu_pm_resume(struct msm_gpu *gpu)
 
 	msm_devfreq_resume(gpu);
 
-	adreno_is_a7xx(adreno_gpu) ? a7xx_llc_activate : a6xx_llc_activate(a6xx_gpu);
+	adreno_is_a7xx(adreno_gpu) ? a7xx_llc_activate(a6xx_gpu) : a6xx_llc_activate(a6xx_gpu);
 
 	return ret;
 }
-- 
2.43.0


