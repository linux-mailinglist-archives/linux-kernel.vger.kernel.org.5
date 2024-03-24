Return-Path: <linux-kernel+bounces-114351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D4F888A8D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73990B22E43
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF98172623;
	Sun, 24 Mar 2024 23:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riRwi4W4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AAD214871;
	Sun, 24 Mar 2024 23:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321741; cv=none; b=mGxGv3GRtyPacrgJI8eZsf2En+jdwW83NLHEeqO5R50XTla1WMBxHReiVzqfWQGKP6QUj0jryR/ccMDc321pjNYDntK8YN3UkAirMsB6GoVcEKXZXRYrBczc2e9x5N+KflVWdmtcOuWsDXjCUW/B549D1NhblltVGp8Iq2RuzQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321741; c=relaxed/simple;
	bh=3hJv1C7S8XE7V4wMtaiW0cPgyCupiCP1W5fbV7VJQjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tBjU/j2AI4JsXueMt6msVLlgnXhjsbvHgA4pTGKHvjl4+UmpMPOSeFlxnXLFJqfedjTEN8siFp0whg4oY/IR8iOQH2WAi9QwvGWe+69hqc9J5yDR5YCeY5WDT1+8vr7zpoR5eysHb9sqcXu46fkJxlusKLgnTv92AlP7o4khLl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riRwi4W4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6B0C43330;
	Sun, 24 Mar 2024 23:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321740;
	bh=3hJv1C7S8XE7V4wMtaiW0cPgyCupiCP1W5fbV7VJQjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=riRwi4W4XGopA0n/BWsArR8SULtddJMeTUpGWjj/A91J64R+oyfQXawCHL1sWxkID
	 R7aEplm9t1wjvcZPBESRoi5pl0iNhv9t1Nu1qeYb7nBZ/BmJA1lLzOISWwlKWAWuX9
	 hq8OIFC08UgwpG6NKmx2Vraf7B21xQc8BKBnEWcWxXAS+Pg6DguAjCYJN1JL9IYM0L
	 8x7bJ1t+JyaIG1FHrZ+6lHzuboDP78WPoUiejDnLHIaPFdBPd0yHABboBzjdm0tyd8
	 MxDcFYyu/xlanxM3gwPIpiRPOnOW/7brkGNncCv6vnEJydV5ZSABchnuZO2D7JSKLG
	 XzKGc0PxlEaGw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 468/638] drm/tests: helpers: Include missing drm_drv header
Date: Sun, 24 Mar 2024 18:58:25 -0400
Message-ID: <20240324230116.1348576-469-sashal@kernel.org>
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


