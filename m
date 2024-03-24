Return-Path: <linux-kernel+bounces-113386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1C38883EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE663B24C00
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB441A133B;
	Sun, 24 Mar 2024 22:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yog491wT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AE21A1326;
	Sun, 24 Mar 2024 22:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320188; cv=none; b=TW+hvXM5BXCCufTnthdIRzZfnPZKNSaXPoq07mXJGzLFSJXszH5mWu0oJ/Bhtzp2/ZeCPr47T0m2GGw60nRtJtqipfGHJ+mquQ9E8KKCk5cR3TZceSwazJFpdY9z0ErWDSvOC+8YhdsHgO9tXouxp27LPa6dF84MdxgjzLhJ53w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320188; c=relaxed/simple;
	bh=3hJv1C7S8XE7V4wMtaiW0cPgyCupiCP1W5fbV7VJQjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nZ2/e0PpUiNBqKunWLjiWd9FKVw8sLLxZJasCXxzxW1aKYkklt9v/sH1qNNme5v4t2k06vJKzzqbb5BThcgdocTgM2+0nCY/fGFNvcEvk5MwmInngf3lOjPNSA0z98k5hcRkndu4ywKKcdxN/YeYpTYoum4AlF+XGaKpuia+MIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yog491wT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF2AC433B2;
	Sun, 24 Mar 2024 22:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320187;
	bh=3hJv1C7S8XE7V4wMtaiW0cPgyCupiCP1W5fbV7VJQjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yog491wTlIH3yUioLBHQDIpkcclTG40CJt1NdNQgy1IHMkKUltqsww6QSEQDNTSnz
	 0AjAQ+/B6ellGMWRJbcIkDFZgLDbU675EJLe7KanPs4DjdqKloDIOcI1eQzlp+qF+k
	 4PntbUiGT799PthdYKvqu6z0/vpWG5cFUwtDX+ggLHvLNKlF7O44TMeF36E7aYAXtz
	 zXdx2+Qd2WqsFHx4viLCSvRjaceqeicFGTRFNVorjVg3ccsCQnJoj/hLgESQpqT/jk
	 TC44aO88fk81pJp9IsTrfXGNseMQ1ONrB91PthrmpGuOC71i7rjijjKWjOCa6LI7OM
	 ziTmXJjF04YSQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 495/715] drm/tests: helpers: Include missing drm_drv header
Date: Sun, 24 Mar 2024 18:31:14 -0400
Message-ID: <20240324223455.1342824-496-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


