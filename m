Return-Path: <linux-kernel+bounces-114042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F065E88880C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB703294FB2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB6922E164;
	Sun, 24 Mar 2024 23:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dc8kF34V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4128F14EC77;
	Sun, 24 Mar 2024 23:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321325; cv=none; b=PRQngbX28afKO7vU2dO5L/0ihmXzLX/N4Df1iy9pvikt9N0+6u62nbIvLq9Oz3XQRuCeSg7dpL4fv6Q9spwJppeW6rL7LuFXJM2Xho5H15tvobeUMTYGtm9vhYrwaktVtS7Cbq2vi6HNzQGdNvkWFRSzsz4Uue4bjqwB8NDPwNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321325; c=relaxed/simple;
	bh=DnBTn8M9ECog35VLJPBV08nJCttgdumjnhsnix40o/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CEDawQThyWXi7s+Krra24874NORFqQ6pGmxZKn70yGpGq4iDWwFHGw3Cx5Z+1T5zFvs8kRE70G1nrnyXsWBgoS3EY1Vhj6nGLuh9L9wmYnC2R0boVmWRFP7Uiiu/WJRLtaIU5zCnMVyTJaIhx7sq7FpbaTAFmah3E9kiYuAw13c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dc8kF34V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3A5C433F1;
	Sun, 24 Mar 2024 23:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321324;
	bh=DnBTn8M9ECog35VLJPBV08nJCttgdumjnhsnix40o/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dc8kF34V1fYgDjHGPa9qJ3HnjWIMF1snem8ixnJXIJEKKqtHvIUPR1xM0YxzQ2ZRN
	 GHHOB07nYgjICyraqtPW6kSJZvvSNxk8R/huarlZCclU3A8u0p6UQeiGrT/XNxvthR
	 hlFf+JN1Gel+8bjWwBiLPCfnHEedMrZX6FZylLN2aVGKk1golZQhQLtkkwbREUfDYg
	 mYjv8ZzJa96lykzXtwBRC8AUK7zp2AbOWCmdPT2s5A4QRFa08l8n7ePAigqVfCP9nQ
	 4p3OtEIyOpfXmVyxKE9Wgdo9JmVa5pToSTcVbmN5QelzOw64yj5niZjttiti7dJcdb
	 TbMyVXBfpfENA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 047/638] drm/ttm/tests: depend on UML || COMPILE_TEST
Date: Sun, 24 Mar 2024 18:51:24 -0400
Message-ID: <20240324230116.1348576-48-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Christian König <christian.koenig@amd.com>

[ Upstream commit 9d3f8a723c7950e56e0b95ab84b572caee29e065 ]

At least the device test requires that no other driver using TTM is
loaded. So make those unit tests depend on UML || COMPILE_TEST to
prevent people from trying them on bare metal.

Signed-off-by: Christian König <christian.koenig@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Link: https://lore.kernel.org/all/20240219230116.77b8ad68@yea/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 3caa020391c75..ec4abf9ff47b5 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -198,7 +198,7 @@ config DRM_TTM
 config DRM_TTM_KUNIT_TEST
         tristate "KUnit tests for TTM" if !KUNIT_ALL_TESTS
         default n
-        depends on DRM && KUNIT && MMU
+        depends on DRM && KUNIT && MMU && (UML || COMPILE_TEST)
         select DRM_TTM
         select DRM_EXPORT_FOR_TESTS if m
         select DRM_KUNIT_TEST_HELPERS
@@ -206,7 +206,8 @@ config DRM_TTM_KUNIT_TEST
         help
           Enables unit tests for TTM, a GPU memory manager subsystem used
           to manage memory buffers. This option is mostly useful for kernel
-          developers.
+          developers. It depends on (UML || COMPILE_TEST) since no other driver
+          which uses TTM can be loaded while running the tests.
 
           If in doubt, say "N".
 
-- 
2.43.0


