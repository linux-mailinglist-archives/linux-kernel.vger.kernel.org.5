Return-Path: <linux-kernel+bounces-23329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E2D82AB1F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECBFD1F23280
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED9B11719;
	Thu, 11 Jan 2024 09:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Kxd6mT6o"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D9E11194
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=grwVG+AmXoGKqTy2la
	H8uBXIiMvnlbZHKoSxHFDFIx0=; b=Kxd6mT6ou2yDWT6nJzl+KbGQfofmaClbZ1
	rgXuVFC6Jd9CPH29TccLw5ksGML03L33ll7Vpixj9IFCLUPoMJA509LfUquo4eZr
	FxLXCrmdDdHtz8OLvBZuTVwECMEaNvNpfwB/xH/H1EXX0Er20GZ9MIWlO1k2+Aab
	0RzY955jA=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wD3H7l_t59l0N42AA--.10079S2;
	Thu, 11 Jan 2024 17:40:15 +0800 (CST)
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
Subject: [PATCH] drm/radeon/evergreen_cs: Clean up errors in evergreen_cs.c
Date: Thu, 11 Jan 2024 09:40:13 +0000
Message-Id: <20240111094013.14347-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3H7l_t59l0N42AA--.10079S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF1fZFWDGw45tF48GrWrAFb_yoWftrX_Cr
	4rX3s8X3sru3ZFkF1xZF48WFWvkFW5ZrW8Cayfta4fGry5AF10grWS9ryFqw45W3WUJFZ5
	Aw4kWFW3Xr97WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRioUq5UUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiHB1ixWV2z0UUrQAAsG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: space required after that ',' (ctx:VxV)
ERROR: spaces required around that '>' (ctx:VxV)
ERROR: spaces required around that '<' (ctx:VxV)

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 drivers/gpu/drm/radeon/evergreen_cs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/radeon/evergreen_cs.c
index 0de79f3a7e3f..1fe6e0d883c7 100644
--- a/drivers/gpu/drm/radeon/evergreen_cs.c
+++ b/drivers/gpu/drm/radeon/evergreen_cs.c
@@ -33,8 +33,8 @@
 #include "evergreen_reg_safe.h"
 #include "cayman_reg_safe.h"
 
-#define MAX(a,b)                   (((a)>(b))?(a):(b))
-#define MIN(a,b)                   (((a)<(b))?(a):(b))
+#define MAX(a, b)                   (((a) > (b)) ? (a) : (b))
+#define MIN(a, b)                   (((a) < (b)) ? (a) : (b))
 
 #define REG_SAFE_BM_SIZE ARRAY_SIZE(evergreen_reg_safe_bm)
 
-- 
2.17.1


