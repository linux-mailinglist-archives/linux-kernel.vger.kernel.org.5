Return-Path: <linux-kernel+bounces-23314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F81082AAED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D2FF1F24335
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A279211194;
	Thu, 11 Jan 2024 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="aMENAKH1"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DA910785
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=SKtrUrIGdRmsfBc9it
	8ZXLO8jM/D3LjDPZUsNHDws34=; b=aMENAKH1QAo+qZGdbNe6CU75Q2pnw6Y3zD
	a29K234H81vIu972ctzSRIXiIFT6a977M1SUPNxv0u/JyaAIfYnD8CUk+DwuP+bD
	aVtPxH8AvZPSyrvh20p9zYf7LZFN45DbmDJ5jrJz5xskE4J1CUkFJXNWwYsCJjs7
	SrtKW6rYM=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wD3X6VItZ9lwjsoAA--.52777S2;
	Thu, 11 Jan 2024 17:30:48 +0800 (CST)
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
Subject: [PATCH] drm/radeon: Clean up errors in clearstate_cayman.h
Date: Thu, 11 Jan 2024 09:30:39 +0000
Message-Id: <20240111093039.13914-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3X6VItZ9lwjsoAA--.52777S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZryxCFWUWw43uryfZF17GFg_yoW8Xr1fpF
	4DWrn5Cw4rGa15XryxJr1DGryfGa92vFyIyrWDKw1fCw1kArZ7Was8JayxAryUtr97tr17
	tFykZry2qa18Cw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRRbyNUUUUU=
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiGAtixWVLZWlXQgAAsD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 drivers/gpu/drm/radeon/clearstate_cayman.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/clearstate_cayman.h b/drivers/gpu/drm/radeon/clearstate_cayman.h
index 4774e04c4da6..7693fb6624a3 100644
--- a/drivers/gpu/drm/radeon/clearstate_cayman.h
+++ b/drivers/gpu/drm/radeon/clearstate_cayman.h
@@ -23,8 +23,7 @@
 
 #include "clearstate_defs.h"
 
-static const u32 SECT_CONTEXT_def_1[] =
-{
+static const u32 SECT_CONTEXT_def_1[] = {
     0x00000000, // DB_RENDER_CONTROL
     0x00000000, // DB_COUNT_CONTROL
     0x00000000, // DB_DEPTH_VIEW
@@ -514,8 +513,7 @@ static const u32 SECT_CONTEXT_def_1[] =
     0x00000000, // CB_BLEND6_CONTROL
     0x00000000, // CB_BLEND7_CONTROL
 };
-static const u32 SECT_CONTEXT_def_2[] =
-{
+static const u32 SECT_CONTEXT_def_2[] = {
     0x00000000, // PA_CL_POINT_X_RAD
     0x00000000, // PA_CL_POINT_Y_RAD
     0x00000000, // PA_CL_POINT_SIZE
@@ -523,8 +521,7 @@ static const u32 SECT_CONTEXT_def_2[] =
     0x00000000, // VGT_DMA_BASE_HI
     0x00000000, // VGT_DMA_BASE
 };
-static const u32 SECT_CONTEXT_def_3[] =
-{
+static const u32 SECT_CONTEXT_def_3[] = {
     0x00000000, // DB_DEPTH_CONTROL
     0x00000000, // DB_EQAA
     0x00000000, // CB_COLOR_CONTROL
-- 
2.17.1


