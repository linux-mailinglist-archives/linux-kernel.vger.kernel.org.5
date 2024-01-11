Return-Path: <linux-kernel+bounces-22962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264D682A5DB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9AB02865DF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B872105;
	Thu, 11 Jan 2024 02:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="nbG+wwG9"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7857020E0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=IXEHNXRuUcKt6IyGJd
	ZD0CF1X7wE5BQBAI9i8Netnf8=; b=nbG+wwG9elFeqSBa8+vCi5EROJYYOh5gfc
	+5DRlJSzTNnyM7xEei0IzN2FIGYeaVw09mGO5KKfrmNsfIDqjkT966u9yWf9U6Id
	TQro4ck9N++4njxitGozKN3DtBPAuicSoMsEKXfVHa6gHtGiuDYFhTqfQf8HTcTF
	NAF+p21fE=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wD3v4WAT59lAXGcAA--.59409S2;
	Thu, 11 Jan 2024 10:16:33 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: christian.koenig@amd.com,
	alexander.deucher@amd.com,
	Xinhui.Pan@amd.com,
	daniel@ffwll.ch,
	airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	chenxuebing <chenxb_99091@126.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in amdgpu_drv.c
Date: Thu, 11 Jan 2024 02:16:31 +0000
Message-Id: <20240111021631.5974-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3v4WAT59lAXGcAA--.59409S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ury8Gw48Zw1rKr4DtF4DXFb_yoW8Jw1fpa
	1rWrn3tryUZF1UtrWDZas7WF90qa48XFyxGw1DZ347Xan8JF95Wa4rt3Z5WF9rWF4fCayx
	tF97J3y3u3Wa9FJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UjtC7UUUUU=
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiHAJixWV2zz5jswAAsL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: do not initialise globals to 0

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 880137774b4e..86d829055418 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -592,7 +592,7 @@ module_param_named(timeout_period, amdgpu_watchdog_timer.period, uint, 0644);
 #ifdef CONFIG_DRM_AMDGPU_SI
 
 #if IS_ENABLED(CONFIG_DRM_RADEON) || IS_ENABLED(CONFIG_DRM_RADEON_MODULE)
-int amdgpu_si_support = 0;
+int amdgpu_si_support;
 MODULE_PARM_DESC(si_support, "SI support (1 = enabled, 0 = disabled (default))");
 #else
 int amdgpu_si_support = 1;
@@ -611,7 +611,7 @@ module_param_named(si_support, amdgpu_si_support, int, 0444);
 #ifdef CONFIG_DRM_AMDGPU_CIK
 
 #if IS_ENABLED(CONFIG_DRM_RADEON) || IS_ENABLED(CONFIG_DRM_RADEON_MODULE)
-int amdgpu_cik_support = 0;
+int amdgpu_cik_support;
 MODULE_PARM_DESC(cik_support, "CIK support (1 = enabled, 0 = disabled (default))");
 #else
 int amdgpu_cik_support = 1;
-- 
2.17.1


