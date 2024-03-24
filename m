Return-Path: <linux-kernel+bounces-115513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0518E889C7C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36EF4B3A80D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D272223A779;
	Mon, 25 Mar 2024 02:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGMKJkhp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9041D12B156;
	Sun, 24 Mar 2024 22:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320961; cv=none; b=C3819rMPDB3IGJ0OmUBqAa/kes+OCthpViY3zwZDJG+u+N2Xi8lJL3HVZhxqMBuWP3Hni7HlM6vv9vIHw7T4SKBNF7BzaioWMUPvb3lLKuDnEqtctw/sFA2qAC/Z1jM4LONL645BhBPHR8/CAroMTy1ZvcgEHYbmIQXJ6YhVFao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320961; c=relaxed/simple;
	bh=3hJv1C7S8XE7V4wMtaiW0cPgyCupiCP1W5fbV7VJQjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dvOoF+pCWsyPs7VzI7a3I+ciah3qnZYGg6fqMEm7YUqJLE+FS75BcW+pE2AGHLS+QF7fvqO2ta+IoBytusqyh8CgmQQemGEAo5kZz4JJwQk8XPQJeKSCQ80KebEGunTibchUVQ6JSV4dDJpMU5EbNXI7RRq5hTIplox6g13l1Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGMKJkhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5EAC43394;
	Sun, 24 Mar 2024 22:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320960;
	bh=3hJv1C7S8XE7V4wMtaiW0cPgyCupiCP1W5fbV7VJQjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eGMKJkhpF+UIl7U8Ox++e345iqO7efEFnCH4QS//H8TXsR16PE/qm5AXDBAjqmV6E
	 IQeV8GSMWJpOE7uWJQO7b1GuqITj28RcGhoGMTY9pFa8TPG2UqFpX+WkX2dVn9c9Hq
	 ZCWW+iWjg97RpgQc2f14ehfBly0kaTqOUzm5opJoteg/DpWE9awl7T552fxrkzG5M6
	 DNQotSjjEd9Vt9+Sofq9diUqCbSzLQ5ooPEVxbgUmnF/jDtcTq4V6lMRfxoJDm1S4y
	 ViIhwe7ThBMJa3Atbaeoa2Qh/Ckh6HeJB53sREYyBnGdjXZzkq4lLDQmP/8ucRf9+L
	 RW+gxaKLdQqEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 523/713] drm/tests: helpers: Include missing drm_drv header
Date: Sun, 24 Mar 2024 18:44:09 -0400
Message-ID: <20240324224720.1345309-524-sashal@kernel.org>
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

From: Maxime Ripard <mripard@kernel.org>

[ Upstream commit 73984daf07a1a89ace8f0db6dd2d640654ebbbee ]

We have a few functions declared in our kunit helpers header, some of
them dereferencing the struct drm_driver.

However, we don't include the drm_drv.h header file defining that
structure, leading to compilation errors if we don't include both
headers.

Fixes: d98780310719 ("drm/tests: helpers: Allow to pass a custom drm_driver")
Reviewed-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240222-kms-hdmi-connector-state-v7-1-8f4af575fce2@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/drm/drm_kunit_helpers.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/drm/drm_kunit_helpers.h b/include/drm/drm_kunit_helpers.h
index ba483c87f0e7b..3ae19892229db 100644
--- a/include/drm/drm_kunit_helpers.h
+++ b/include/drm/drm_kunit_helpers.h
@@ -3,6 +3,8 @@
 #ifndef DRM_KUNIT_HELPERS_H_
 #define DRM_KUNIT_HELPERS_H_
 
+#include <drm/drm_drv.h>
+
 #include <linux/device.h>
 
 #include <kunit/test.h>
-- 
2.43.0


