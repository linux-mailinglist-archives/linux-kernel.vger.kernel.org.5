Return-Path: <linux-kernel+bounces-23038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE80F82A68E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79B4C288450
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BCB20F5;
	Thu, 11 Jan 2024 03:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="oPMlqLtj"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7A51866
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=aEcTpox9RCNPCYEUFL
	+GBRnJlzPshU0S0hi+Stnhftw=; b=oPMlqLtj7agSMf7fa0r31pi6jl/aXLB5Ck
	hpebhpy44Zoztsi+AQMhp/1vLYJskOzkiOeq/jXvg88TYnJ5JdbTkV950cCPXqg3
	DbOK0d9NSSit7uXGZFVK/1HzN42LX/rBv50LGSrX5QZZOocUQQpHT8qknzQjH3pA
	btyRsiemc=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g1-1 (Coremail) with SMTP id _____wD3H9usYp9lhT8vAA--.20674S2;
	Thu, 11 Jan 2024 11:38:20 +0800 (CST)
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
Subject: [PATCH] drm/amd/amdgpu: Clean up errors in beige_goby_ip_offset.h
Date: Thu, 11 Jan 2024 03:38:18 +0000
Message-Id: <20240111033818.7968-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3H9usYp9lhT8vAA--.20674S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1DCF48KF13Kr4kWFWxWFg_yoWfJrX_Ca
	srGwn3GrWxZFs3XFyakFn3u34S93WF9F1kWw1SgFyrtr9ruF18W3yUJr4xXr4ruF9xCFsr
	A3WkXFy5XrnIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRt8nDUUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiHAtixWV2zz-88wAAsc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/include/beige_goby_ip_offset.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/beige_goby_ip_offset.h b/drivers/gpu/drm/amd/include/beige_goby_ip_offset.h
index 26044cb285d2..48542ea6882a 100644
--- a/drivers/gpu/drm/amd/include/beige_goby_ip_offset.h
+++ b/drivers/gpu/drm/amd/include/beige_goby_ip_offset.h
@@ -26,13 +26,11 @@
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
 };
 
-- 
2.17.1


