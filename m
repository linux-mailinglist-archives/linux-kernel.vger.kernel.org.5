Return-Path: <linux-kernel+bounces-23035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AF782A689
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE942882AC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBAA20F5;
	Thu, 11 Jan 2024 03:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="pxEA2lEB"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307621C16
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=En1CBR0kBxa9quIwfp
	/NIa2YsneYuX52TYhnjn5Zx/c=; b=pxEA2lEBZijLftPdfXwtP3vOjvN2IXaO8c
	FWlVJ81D6ptczWK5Ecs8a4pfMgzBdi2c6XRxUDFiJD0zXg0q2Y3iGU3iBTcpV2Wo
	qY89z6+TezDtesKBKDG0yYvrucHgLCBKAVC/shFGeM7+4BSja48SxeptdwhVTAA0
	2W7/0VVEQ=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wD3f6f7YZ9l2LwgAA--.42672S2;
	Thu, 11 Jan 2024 11:35:23 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: daniel@ffwll.ch,
	alexander.deucher@amd.com,
	airlied@gmail.com,
	Xinhui.Pan@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	chenxuebing <chenxb_99091@126.com>
Subject: [PATCH] drm/amd/include/navi14_ip_offset: Clean up errors in navi14_ip_offset.h
Date: Thu, 11 Jan 2024 03:35:22 +0000
Message-Id: <20240111033522.7791-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3f6f7YZ9l2LwgAA--.42672S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1DCF48KrW7JryUCrWruFg_yoW3KFX_Ca
	4xJ3s3WayxuFnFvFnFkFZ7Z34Ik3W09Fn3Xw1ftFy5trnrAr18W3y5Jrs7XrWruFnF9FZr
	Z3WrXFy5ZrnIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRt8nDUUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiHARixWV2zz-RdwABs7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/include/navi14_ip_offset.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/navi14_ip_offset.h b/drivers/gpu/drm/amd/include/navi14_ip_offset.h
index c39ef651adc6..508011288dea 100644
--- a/drivers/gpu/drm/amd/include/navi14_ip_offset.h
+++ b/drivers/gpu/drm/amd/include/navi14_ip_offset.h
@@ -25,13 +25,11 @@
 #define MAX_SEGMENT                                        5
 
 
-struct IP_BASE_INSTANCE
-{
+struct IP_BASE_INSTANCE {
     unsigned int segment[MAX_SEGMENT];
 };
 
-struct IP_BASE
-{
+struct IP_BASE {
     struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
 } __maybe_unused;
 
-- 
2.17.1


