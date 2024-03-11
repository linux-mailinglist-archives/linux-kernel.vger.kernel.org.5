Return-Path: <linux-kernel+bounces-99080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A703878337
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13DEF282B91
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CF95E087;
	Mon, 11 Mar 2024 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2rk8BTg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74C65DF26;
	Mon, 11 Mar 2024 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170004; cv=none; b=mBbRVI/33Xj6YNIaolS+qXW17NldevP0iO0cTDx8e55BoM422pa8AfrSZ7+zVrb+RrnJ1L7Yidwx+8XBTXLS/L+JJz7Q68SuGXbBZpBAbbo+6NoL/CVzI8gMt73Ok7PRO4B6bhVUITU3uwY+2T20UiyjQzUcqsoCQm9hPpETrLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170004; c=relaxed/simple;
	bh=DnBTn8M9ECog35VLJPBV08nJCttgdumjnhsnix40o/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TPDgQlhKo5cxPkI+mZfDFzIoUoT6Dt8Pv0J/4aqxdMsipqt+dqIEGqB6vGSVZXx8V2JtughJdDo4Qo3rxwwqIbKcH+M+3NktyNcg5YDvHlALYJ6oXIXcXLarfpUxu/kWyEzkcCRCJziIrNhHn/l04KtMVJUQbu3oex67XfW3Yfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2rk8BTg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D22C43399;
	Mon, 11 Mar 2024 15:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710170004;
	bh=DnBTn8M9ECog35VLJPBV08nJCttgdumjnhsnix40o/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E2rk8BTgXfnZM1mW5Ss3o7ltBqnltyIp69+8OH5uhAL++z6mT1fi8vpTK3vGyJfoa
	 CdzTbxjeHrqHbCDxIXBPdoNjE1NCY6KTvdi1NafxN6Zia1GNpBGIJ7dLeXes1v8EP3
	 JHjiMho1ielrIFPx3nQz7OcThGfDyHRETCmArj9qJCIonbnvjeK34R0dtxMGM7aGEo
	 m18piY9inMNeR4r3QRmlWnE5726q7QtJjCKhO4qzJxVQe90REqo/WhEcTfTsDr0LD2
	 jroItTdSOyB078I3pBoBxXIu9iYPAnvEMs9ZdWRSglCf5fF6/J6n9LcsdP5nGHBXBA
	 Ii5NnCmusitlA==
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
Subject: [PATCH AUTOSEL 6.6 06/17] drm/ttm/tests: depend on UML || COMPILE_TEST
Date: Mon, 11 Mar 2024 11:12:57 -0400
Message-ID: <20240311151314.317776-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151314.317776-1-sashal@kernel.org>
References: <20240311151314.317776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.21
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


