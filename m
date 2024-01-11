Return-Path: <linux-kernel+bounces-23024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0189982A671
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96EDDB21741
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247FA53AF;
	Thu, 11 Jan 2024 03:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="lhO/sXbp"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D815382
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=dshx51HI40zA1xqVFX
	zADg2VlgDAFrz0WnOsTKSvvUw=; b=lhO/sXbpD8kmL5Zy69zMbiyZgZP82WkN2I
	xhZb4hC4o2O9faM+D8P/ckSD8YzOBHCUx1KeyYUY584dTO3iTDMFh7kkT9plwwg1
	XJ3VJVpL8uwd07wtJVmruQW4ZGxhzK7iF9iqF5sGG7+TFD3nXlrJzvL6Rbf9A0pk
	eBN63YPl4=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wD3X4UwX59lAvWdAA--.60309S2;
	Thu, 11 Jan 2024 11:23:28 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: daniel@ffwll.ch,
	airlied@gmail.com,
	alexander.deucher@amd.com,
	Xinhui.Pan@amd.com,
	christian.koenig@amd.com
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	chenxuebing <chenxb_99091@126.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in dimgrey_cavefish_ip_offset.h
Date: Thu, 11 Jan 2024 03:23:27 +0000
Message-Id: <20240111032327.7402-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3X4UwX59lAvWdAA--.60309S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1DCF48KF4ftF17Kr45ZFb_yoWfAFX_Ca
	43Xr1fW347ZFnrtF17Zanru3yj9w1kuFs7Xw15tr15trZrCr18W3y5Gr47ZrWruFZxKFnr
	C3WkXFZ8XrnI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRK9atUUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiGAdixWVLZWQS9AABsw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/include/dimgrey_cavefish_ip_offset.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/dimgrey_cavefish_ip_offset.h b/drivers/gpu/drm/amd/include/dimgrey_cavefish_ip_offset.h
index f84996a73de9..53cb4296df88 100644
--- a/drivers/gpu/drm/amd/include/dimgrey_cavefish_ip_offset.h
+++ b/drivers/gpu/drm/amd/include/dimgrey_cavefish_ip_offset.h
@@ -25,13 +25,11 @@
 #define MAX_SEGMENT                                         6
 
 
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


