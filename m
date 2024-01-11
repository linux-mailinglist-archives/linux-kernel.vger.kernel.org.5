Return-Path: <linux-kernel+bounces-23027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C5282A675
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2443C287A99
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA99A17D4;
	Thu, 11 Jan 2024 03:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ToJ47kxQ"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B0415C2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=+fG4AXicLXIqBy2X4Q
	F4COIcQVewS78vBq1OfsVfqfI=; b=ToJ47kxQrvs2DSsZxlEHCZWqlm4FCaOt3S
	yPdjGkFEbjyHON3/6t6OSoDUlzwXp49oKzw4BvV1kMHCGstcR2peMIeSehL8RZGo
	zr8eV7MHx+M7TqibpVpJa5oUe7zbS8RZNm2cUYv3cHEEuiRbHFeTpI9i1wSYpju+
	FbFXLJKWU=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g1-1 (Coremail) with SMTP id _____wDX_9rGX59llvsuAA--.18065S2;
	Thu, 11 Jan 2024 11:25:58 +0800 (CST)
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
Subject: [PATCH] drm/amd/include/sienna_cichlid_ip_offset: Clean up errors in sienna_cichlid_ip_offset.h
Date: Thu, 11 Jan 2024 03:25:57 +0000
Message-Id: <20240111032557.7578-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDX_9rGX59llvsuAA--.18065S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1DCF48KF47Kw1DGw4DArb_yoWfWFX_Ca
	yxtwn3GrW7ZFnrWF1xCFZrZ3y293WkuF1kXw1fta4SyrnrAw1ru3y5Jr47X3yruFn3KFZr
	XayrZFy5WrnxWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRt8nDUUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiOgpixWVEuXtJ5QAAsY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/include/sienna_cichlid_ip_offset.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/sienna_cichlid_ip_offset.h b/drivers/gpu/drm/amd/include/sienna_cichlid_ip_offset.h
index b07bc2dd895d..054790470800 100644
--- a/drivers/gpu/drm/amd/include/sienna_cichlid_ip_offset.h
+++ b/drivers/gpu/drm/amd/include/sienna_cichlid_ip_offset.h
@@ -25,13 +25,11 @@
 #define MAX_SEGMENT                                         5
 
 
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


