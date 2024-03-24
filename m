Return-Path: <linux-kernel+bounces-115700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AA288971D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7332E29B2D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C86925A1EF;
	Mon, 25 Mar 2024 02:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHct1SrK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C6313A89B;
	Sun, 24 Mar 2024 23:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321687; cv=none; b=csy4Q0gillaiq4eE1diKAmaqjaWS7ckWtLV+Qm80+f0wXwILrnllL9YrjFkvuNDTJazRD3RouGH5e78FaoywCImkzKHjPUj0c/ePUcINdRKNQ6FK84yKK7xajptNcnkZKP2F9AewjsTbuoxUE5Mvf/PIcMUH/XQPDVpUFeO3H4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321687; c=relaxed/simple;
	bh=rKYlC7jVDqXNr3hDf0STuqNXitRGrhJcxmC1di3E12E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nv7vtP0Jl41jgP5x9SitW2sMxP1VrWCpJ4YNtSqfJKw7mhH9FicIzaYr8CI2FOn7ICT6nMOnuYJF/KC7ipSVRv1wpQoRBLbcgXdeGGJgHksTY1nTeK8R+UWSMdhueKn5IL72uuRRjRL5bRbYg4dH6RxYyGIkoN/jlvK/c9wo4NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHct1SrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66266C433F1;
	Sun, 24 Mar 2024 23:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321687;
	bh=rKYlC7jVDqXNr3hDf0STuqNXitRGrhJcxmC1di3E12E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OHct1SrKKndNr8vZ3WwRsQHvfRtthGA1iv3P1r510pBnftRzRw9mDqnS2IKMSA1Ps
	 DmPERuWHnNJ4uvoYgIEM20UX8MgotbF3En/q9j8Oxud77tzAe7TakO2NKevSJNc0ms
	 fYEjdqHx5KFB5pQWAPdHduNfD/+NyWRCyiQToi29Q1oqEfMLtJnnnmoBDUIWCWy0yX
	 saqy081QwFui0rvvRc3563fQzAzcf8eSHRmm3gDRIXeEIfpDn+BTfB2snUfXfbRqSJ
	 Q+eZRGAjzBjQmEo637X1T/G2za/X0o7UdKAEWTIC/FpT7cDKddU8oZUWE0KQGAT4rO
	 lFKHmFVNEDmIg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Helen Koike <helen.koike@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 415/638] drm: ci: use clk_ignore_unused for apq8016
Date: Sun, 24 Mar 2024 18:57:32 -0400
Message-ID: <20240324230116.1348576-416-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 6473cddaa7a96..e5b7d309ca186 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -104,7 +104,10 @@ msm:apq8016:
     DRIVER_NAME: msm
     BM_DTB: https://${PIPELINE_ARTIFACTS_BASE}/arm64/apq8016-sbc.dtb
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


