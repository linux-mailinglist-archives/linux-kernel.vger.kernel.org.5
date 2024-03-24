Return-Path: <linux-kernel+bounces-113322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1925888366
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4A651F22B18
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3428D194C85;
	Sun, 24 Mar 2024 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvkEddIh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C2D194C69;
	Sun, 24 Mar 2024 22:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320124; cv=none; b=jDILwhAKFo+KnJYCcbuH+QhOxgXBv9XOxMk9F2Mp7v2MpuligS3E/+Ug5ioVIxpWgHtiDPau9dwj3izIA9beyU7dAiLdCe0FFWf0H4jBqYx3JwVyxukag/6cxf1sdkvNC9NkRYykVDWezJAcxJnIm1Zx2os6R6NqkA52sgKvku0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320124; c=relaxed/simple;
	bh=Fwt/7Ant5CbrmEv+92CR3ba1T1ruM9gWJeZOBzxfmGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5cKJeErEurYthiUcDUT7SpYrW2dyvSbRPHk4l/YQpNl2c2yXPg+kp85oYvSSInXBBmKBCKqxmSXrcmGtYgSu+bZE8lSpzX6irWeDpvYdlnoXk3rxDg9VVO0cSbqvCRAQgY3kgktDDjzaTWOkwSrqpFc3axxklvQFCX0ZoncC3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvkEddIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B013C43609;
	Sun, 24 Mar 2024 22:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320123;
	bh=Fwt/7Ant5CbrmEv+92CR3ba1T1ruM9gWJeZOBzxfmGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CvkEddIhEGZPLuQh7wAF6+tebJIrOthjoVEhQBfQxSaRIxGJehZWYI76aZCcGFIY1
	 RsBk7DJYGt0unX59EOgQqlXmDtj0F9UIbYe8cIZF+DdFNsYjtrh++nWOozkKFK6WoN
	 QKztSr1OafXLeQa6dDftDJPYDVai0gkglnU87avo+f4HSVlFfnfXw9SATtDmpUi6fq
	 cHhbXxOVJWy3I4HNY6Qfba1thjampT24f+BDfmDph9vR7vy0RF1FjXMILe/CkaSl1A
	 AxAiGN0dtwpV7Sccovl+j+7Y8skcE2ctBl3dvMfP7arO94WVZm3+5cu4NzfgvDttvX
	 5viJPElwGnnww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Helen Koike <helen.koike@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 431/715] drm: ci: use clk_ignore_unused for apq8016
Date: Sun, 24 Mar 2024 18:30:10 -0400
Message-ID: <20240324223455.1342824-432-sashal@kernel.org>
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

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit aa1267e673fe5307cf00d02add4017d2878598b6 ]

If the ADV7511 bridge driver is compiled as a module, while DRM_MSM is
built-in, the clk_disable_unused congests with the runtime PM handling
of the DSI PHY for the clk_prepare_lock(). This causes apq8016 runner to
fail without completing any jobs ([1]). Drop the BM_CMDLINE which
duplicate the command line from the .baremetal-igt-arm64 clause and
enforce the clk_ignore_unused kernelarg instead to make apq8016 runner
work.

[1] https://gitlab.freedesktop.org/drm/msm/-/jobs/54990475

Fixes: 0119c894ab0d ("drm: Add initial ci/ subdirectory")
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Helen Koike <helen.koike@collabora.com>
Signed-off-by: Helen Koike <helen.koike@collabora.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240214083708.2323967-1-dmitry.baryshkov@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ci/test.yml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 2c9a1838e7284..5e1c727640c40 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -104,7 +104,10 @@ msm:apq8016:
     DRIVER_NAME: msm
     BM_DTB: https://${PIPELINE_ARTIFACTS_BASE}/arm64/apq8016-sbc-usb-host.dtb
     GPU_VERSION: apq8016
-    BM_CMDLINE: "ip=dhcp console=ttyMSM0,115200n8 $BM_KERNEL_EXTRA_ARGS root=/dev/nfs rw nfsrootdebug nfsroot=,tcp,nfsvers=4.2 init=/init $BM_KERNELARGS"
+    # disabling unused clocks congests with the MDSS runtime PM trying to
+    # disable those clocks and causes boot to fail.
+    # Reproducer: DRM_MSM=y, DRM_I2C_ADV7511=m
+    BM_KERNEL_EXTRA_ARGS: clk_ignore_unused
     RUNNER_TAG: google-freedreno-db410c
   script:
     - ./install/bare-metal/fastboot.sh
-- 
2.43.0


