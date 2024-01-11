Return-Path: <linux-kernel+bounces-23013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E895B82A658
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7136BB26EE4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FA8EC8;
	Thu, 11 Jan 2024 03:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="djDg4L3h"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4678CEA3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=V+U+dM4OmVoTS2YC8A
	HkHWnI+5wCPS12G/XIW6Y2PUA=; b=djDg4L3hZ0Xx/UqfoqIRFXLMjig4SvZ43D
	CNSAuDuagp3i4ferjDOHRpAe6FVO6FylnFkcrerNamkqwJWJrN2+FQfSXIpHQBKn
	0frf5QvpBYft/UaAtjGcm+ZNSoS7KgHKpvlW9wZZGLVkb6W+/mriuxUKK/aGPhzf
	rHGZI+VsU=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wD3P8UAXJ9lO5guAA--.26719S2;
	Thu, 11 Jan 2024 11:09:53 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: daniel@ffwll.ch,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	alexander.deucher@amd.com,
	airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	chenxuebing <chenxb_99091@126.com>
Subject: [PATCH] drm/amd/include/vega10_ip_offset:Clean up errors in vega10_ip_offset.h
Date: Thu, 11 Jan 2024 03:09:51 +0000
Message-Id: <20240111030951.7046-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3P8UAXJ9lO5guAA--.26719S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr1kGF1xAF1DJw1kKFW8Xrb_yoWfJrc_Ca
	4xXwn3GFWxZFnIqF12kF1xC34jk3WruFn3Ww1SyFyftrZrAr1UW3y5GrnrXr4ruasxCFs7
	Aa48XFy3ZrnagjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRK9atUUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiWQRixWVLYT7npQAAsJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following enum go on the same line

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/include/vega10_ip_offset.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/vega10_ip_offset.h b/drivers/gpu/drm/amd/include/vega10_ip_offset.h
index 3a22a5d16919..1e1ca69f21f7 100644
--- a/drivers/gpu/drm/amd/include/vega10_ip_offset.h
+++ b/drivers/gpu/drm/amd/include/vega10_ip_offset.h
@@ -24,13 +24,11 @@
 #define MAX_INSTANCE                                       5
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
 };
 
-- 
2.17.1


