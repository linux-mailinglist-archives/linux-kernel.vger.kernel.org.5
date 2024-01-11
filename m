Return-Path: <linux-kernel+bounces-23306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A3282AACA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5EC1C26A8B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D77114ABB;
	Thu, 11 Jan 2024 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="obw9noa5"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EE914AB2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=wD5zN4hzyUEjpnUjnj
	XzVLQvtOsmM60ckERcp/meCTE=; b=obw9noa5m3ceEvV/dm96uUjOYmOkLrX7u1
	8eE8ejHpiWDq7t3c0o/2kdHVvjvj0TS5iQydy5JgBKn4I7FUVzzYuMUC2sN9Rgaz
	MuUaiNNaX2Xb9vVhpWnwyCgCpaUHwJCu9aa1r1U3z8H/r7vv0zO+09Thnd+l7WR4
	uimyom1SA=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-4 (Coremail) with SMTP id _____wDXH3gps59lddWkAA--.12795S2;
	Thu, 11 Jan 2024 17:21:45 +0800 (CST)
From: XueBing Chen <chenxb_99091@126.com>
To: daniel@ffwll.ch,
	Xinhui.Pan@amd.com,
	alexander.deucher@amd.com,
	airlied@gmail.com,
	christian.koenig@amd.com
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	XueBing Chen <chenxb_99091@126.com>
Subject: [PATCH] drm/radeon: Clean up errors in clearstate_ci.h
Date: Thu, 11 Jan 2024 09:21:43 +0000
Message-Id: <20240111092143.13739-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDXH3gps59lddWkAA--.12795S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFWDZrWxuFyUWF4xCrWxWFg_yoW3ZrX_Cw
	48J397WrW2vF9xX3W3Ar4rXFWv9r45uanru3Wvva4fCr17Zrs5ua43ury5Xw15XFs8JF1D
	Aw4rXFnxCrn2gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRR_OzPUUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiHBRixWV2z0TRLgABsJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: that open brace { should be on the previous line

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 drivers/gpu/drm/radeon/clearstate_ci.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/clearstate_ci.h b/drivers/gpu/drm/radeon/clearstate_ci.h
index c1b6c22dbed7..0045d42aa27c 100644
--- a/drivers/gpu/drm/radeon/clearstate_ci.h
+++ b/drivers/gpu/drm/radeon/clearstate_ci.h
@@ -23,8 +23,7 @@
 
 #include "clearstate_defs.h"
 
-static const unsigned int ci_SECT_CONTEXT_def_1[] =
-{
+static const unsigned int ci_SECT_CONTEXT_def_1[] = {
     0x00000000, // DB_RENDER_CONTROL
     0x00000000, // DB_COUNT_CONTROL
     0x00000000, // DB_DEPTH_VIEW
-- 
2.17.1


