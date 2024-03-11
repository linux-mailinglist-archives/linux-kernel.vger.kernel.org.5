Return-Path: <linux-kernel+bounces-99059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 015EA8782FA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A5E1F24A3D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F5551026;
	Mon, 11 Mar 2024 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhroRI4V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0305950278;
	Mon, 11 Mar 2024 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169962; cv=none; b=jm2BYojyFNoXuiQQkPRlw0fIsS5gd4ZQMy7S2saH47zTU/SWCTieEnINIgoRIvY+7yGVjWir/YV/i50t4+EyR+qXnyrBMOXeVacj1JQ//q7Fc7eWQujPSY2ATVSn+CBV0cdvYQIbLZCrCE3/iU5AVqI6+P41z22hETh/SKNOk78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169962; c=relaxed/simple;
	bh=C3JXHkC8QSlxMQacEgZP+jIDKkUrjVb3FnkXfTRxrtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IPclI3POtZFSdKfX0S6fDTd7TMpwtshbrSxSMAJzfUJMKQu1L93WQnzhndps7U6Yk+aiO9P2Rh+QXF9fl0Wr4l2yMzJogrXi/qKjS7BxPnCIYAWWp51si/Dx0U6o18Fd/n+WMgxR+vd+/cXsu0CsQWjHeASrL3ZOPXyAyF6A948=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhroRI4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F60BC43399;
	Mon, 11 Mar 2024 15:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710169961;
	bh=C3JXHkC8QSlxMQacEgZP+jIDKkUrjVb3FnkXfTRxrtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dhroRI4VS1yakJm+bffgxqWggabmjKXx/94v/wAjg8WqIxYA+xXio2tRzNa7HJ+4m
	 cu2IPiOD4tAxgv8jJoO4M7WWvyb9m+0EYvyWXbMGm17PqVAs8sYi1S9bntWlnkXMpN
	 W2Q2Bky/Thm8Sj60GjDpW72WpXUOr869dGQACpMVgCWF5Wek3oFn8PIZEvrxtlzOIG
	 vGxFYV7KzfST9bspkEtzfynpmvTlcQBGwB71WLO92yKPRY1ioue5QxIUnJc5eeWJyn
	 ltjKyRmF3Y0U1gf3qgQaCXTi0Dk6eDhxvoSVtGD491cJ01sADKuNbslDy66bcKHBFB
	 2Jw6mM8HKpxFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 11/23] drm/ttm/tests: depend on UML || COMPILE_TEST
Date: Mon, 11 Mar 2024 11:11:51 -0400
Message-ID: <20240311151217.317068-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151217.317068-1-sashal@kernel.org>
References: <20240311151217.317068-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
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
index 3eee8636f847a..9b079f3a1b811 100644
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


