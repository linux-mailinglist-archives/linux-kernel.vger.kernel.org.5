Return-Path: <linux-kernel+bounces-113852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB63888EAF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AF6F1F34F6A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE4320630B;
	Sun, 24 Mar 2024 23:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCKtz4yY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6319A12A157;
	Sun, 24 Mar 2024 22:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320901; cv=none; b=czz1WgYhI5DCFZSbpl+9qBJiyFc4mX6avaNGKQ1WFrTo+MbY7hBv4BR4fm9saC3QSP0MWICOIApfSH4twlurkjklil9cKfUfKCmcWPlhxW1Y2zmjVQtYAL4otqt1amPZpGY/0ChENitUCtq9InXjBq5OyB3E3jE1ZhuYGVon2IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320901; c=relaxed/simple;
	bh=c6VDLxSsF1fqG8uFy6YnuqSbnZ/4/24pxuGoEg5Vdkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzTR6ZIxzAO427e4aJrBfcNfJ90mS1ZgBuwy3/lmD2RNfc8Vz6iZguLN1Sl2K9jYhkcb4uIDOIK7ifarPFrMGtZsm0qEypkv/tPWYoXc/EcZhULhmzfcUadbmGDJ5nGfgl8Gxrv1j+2nYyrU4z9hFxpT7D1vxpwwyEl3itanGhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCKtz4yY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E359C43143;
	Sun, 24 Mar 2024 22:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320900;
	bh=c6VDLxSsF1fqG8uFy6YnuqSbnZ/4/24pxuGoEg5Vdkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WCKtz4yYGymUyiR8ZbABDXeXUUuBhvUqIbH8iZU6QnxeouJdbAx7n+Pgl50AswMbV
	 eOh8PdXIzZAJBsKG3H48vsTcnVSt9JdvV4l3VBxMZDugli7rgMkXrexGKHrMO2ZLA/
	 Gcwxy2JJTA88B8eVisy6U/iTSEt+MSJYCOh7QN9Tv0YfgibOcJfbSc5zrBMJTSYZqG
	 5e5VzzLYpeHuKZZmoAZzgyhIyiit0p1kD4qJVxWsGO7NLooWdK+Umh6UMnk3lC/Q3U
	 Slx6qtTf0j5f16OF0ejMjyW4P/YjNChO2nGxcOpNgN//oW850Tr+TeH063MfGw8JAj
	 4KueaJ4mILT0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Helen Koike <helen.koike@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 463/713] drm: ci: use clk_ignore_unused for apq8016
Date: Sun, 24 Mar 2024 18:43:09 -0400
Message-ID: <20240324224720.1345309-464-sashal@kernel.org>
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
index f285ed67eb3d8..2aa4b19166c06 100644
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


