Return-Path: <linux-kernel+bounces-115311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD468889A9A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592622A3D21
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B25F1DB403;
	Mon, 25 Mar 2024 02:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXNdmKN8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDFD7FBDB;
	Sun, 24 Mar 2024 22:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320498; cv=none; b=fX6WJVfW9vkwKhV+EFlttOWKiY5T1PugN26geQwP1APVZ0cKcvLHyo7k7eyirfJlUfG12L/HUW02NuZWZK7CErygEyMJKItsXKG7VGBEr/vcy0jwziWSMfnnoKsZmkLW+LP0akOayrDou669i1se5/gvRSG0YEXPuL63ntvzSrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320498; c=relaxed/simple;
	bh=C3JXHkC8QSlxMQacEgZP+jIDKkUrjVb3FnkXfTRxrtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l40/+8vHYXbss6pknwiP1m3VSjN1U97bPSSrdIEh2XmBGW/LAknGVfJbeZbDFzJtvxI+YQqyL4LLhI/7kSKjsqkUgeN0n+Y6MkH0l+Kl8cmyBdNi7RLKtjSNInFV43odMluEc+6ymDJAVKIdK8yT1luOhQp/rNcTBRmespUQEYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXNdmKN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161A4C43399;
	Sun, 24 Mar 2024 22:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320498;
	bh=C3JXHkC8QSlxMQacEgZP+jIDKkUrjVb3FnkXfTRxrtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nXNdmKN84Cr2nohznlDZqZbcwNDHiauo/iG36bkcCQmz7/KnyXOH3DjOaIx115fDY
	 InaX8X6wZVFqFJ0YpqDBl9D8MnL91HTKpwGjq4OJqg58GyFtfz6FEOs4M18ClyGFtK
	 YW8YTz4YFB0jwnCgBeDsCQPFpMdYG/OAR49V9QSyMF8EXvBb3N5QCa7TeahCeJvImT
	 qYu+Mf7KRMPQ7+Zep4/O0NpET811RA79EPztWmxLQ/wODw8lSQSayccK6NI5w4YObO
	 D4g60YAiA4GFxzfyG1h9f5SYQd65a8PzXy8FyMaNqZ9eS0j13G3kB8SgeauF9EaVkn
	 ilqS09sSIB9zw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 058/713] drm/ttm/tests: depend on UML || COMPILE_TEST
Date: Sun, 24 Mar 2024 18:36:24 -0400
Message-ID: <20240324224720.1345309-59-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


