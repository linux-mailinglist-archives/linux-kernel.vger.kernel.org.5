Return-Path: <linux-kernel+bounces-113885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BE1888EC8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C540128EAA6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A7920CDE6;
	Sun, 24 Mar 2024 23:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaRzE56Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3AD1EC644;
	Sun, 24 Mar 2024 22:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320950; cv=none; b=OWIywDq0/FaTxNWwh3QT8LcZaLXtzzC0xU9oHvxMboqAyXosgQfsd65sseGBg2ekFPWIMt6BNQzDFxNyuYwNCZs7pmbZ4szVRHzEAF1cWe261Tqn7Unj/rNej94jIQwJn5g7LSsvlv6p4vd8ls/chlei6rutqk/pmaNF1cdnFUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320950; c=relaxed/simple;
	bh=XxGmLl6+DooQ9xpblrIj6cmIex0vd08lyEIDlpuMsCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXe3iiNGV4Wp45msyMNnUZWg55hEl85NtPF91CtblA8foZHK5HfMytsSmGXbZnAoDzMGtLw5yvs3porKzoB2XlyR+ZW5xPx/LL/SUO+mj5JJwDRJ1ZWzWnuZuKDGgVeKkNhYWLIk9W48ZubIz8mVRpGCX0nRsEyqpquGZGiApXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaRzE56Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D243DC433C7;
	Sun, 24 Mar 2024 22:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320948;
	bh=XxGmLl6+DooQ9xpblrIj6cmIex0vd08lyEIDlpuMsCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZaRzE56Q3HFkS7qkLsS2TI+x2Y7gx/Ve3TTZdLsb/sxHFWvWujXESqAUiZ46GzUHR
	 ujOocNRaXuSIzppm8Ht1HhbjEhJhcOTrn2+rxpNskflgV8beyZa3tXDSH302VFC0Uy
	 RK8egHKYACuALxmwgZ9AK4ODlb31wusryH1Qft4x+uhpJSmPW3Hh/L036eWs1sTykO
	 SRy3luDUqqrdG7RVcByrZfd2w7M+ErFcCM3+ysejkETaRzAdfmuh/R/japYl2GkR0s
	 rAaTyf1s7Q2qqF3G31f2VwktiFap7lgqNtx4+cstrwhjoyKOwT4OMKuobK6F48OemM
	 SUwuzTNokSwxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rob Clark <robdclark@chromium.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 512/713] drm/msm/a7xx: Fix LLC typo
Date: Sun, 24 Mar 2024 18:43:58 -0400
Message-ID: <20240324224720.1345309-513-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 500ed2d183fcc..edc1eeef844ef 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2416,7 +2416,7 @@ static int a6xx_gmu_pm_resume(struct msm_gpu *gpu)
 
 	msm_devfreq_resume(gpu);
 
-	adreno_is_a7xx(adreno_gpu) ? a7xx_llc_activate : a6xx_llc_activate(a6xx_gpu);
+	adreno_is_a7xx(adreno_gpu) ? a7xx_llc_activate(a6xx_gpu) : a6xx_llc_activate(a6xx_gpu);
 
 	return ret;
 }
-- 
2.43.0


