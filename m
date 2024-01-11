Return-Path: <linux-kernel+bounces-23142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 710A082A834
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068601F230F4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE58D281;
	Thu, 11 Jan 2024 07:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IuYA6eEo"
Received: from m16.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127A5D262
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=R8VFdJC97hGi6WO7sk
	P6qyL2qnnTIh7AwE9P1ND/YWU=; b=IuYA6eEoUN8jXWDf/dlMDBMmMSWwjSmHgZ
	EPAupVCZx6oULRtVs2eq3pIiAGY/8kFu9C21+GPLIMgd3kZTALqKgrnnD6CgTVjG
	NxsZ94RZrVtZqxuZy7JSM/ijPw1moJk61JhssiF1srWzdmDsf7rlR/Kw/+zBoWhP
	BbFxlb/9o=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-2 (Coremail) with SMTP id _____wDXv5Dokp9lWXmQAA--.19329S2;
	Thu, 11 Jan 2024 15:04:08 +0800 (CST)
From: GuoHua Chen <chenguohua_716@163.com>
To: tzimmermann@suse.de,
	airlied@gmail.com,
	maarten.lankhorst@linux.intel.com,
	daniel@ffwll.ch,
	mripard@kernel.org,
	patrik.r.jakobsson@gmail.com
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	GuoHua Chen <chenguohua_716@163.com>
Subject: [PATCH] drm/gma500: Clean up errors in intel_gmbus.h
Date: Thu, 11 Jan 2024 07:04:06 +0000
Message-Id: <20240111070406.9430-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDXv5Dokp9lWXmQAA--.19329S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw45KryUWr48CFWUZrW3trb_yoW3Xwb_uF
	s8Jr48u395CF9agF13AF4Y9rWjvr1Y9r4kA3Wrta47t3W5Ar1Uu34v9FyUWrW8WFy7Wa9r
	Ja1kXF1FqFsrGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjb4S3UUUUU==
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/1tbiqAli1mVOBk6dnAAAs3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: space prohibited after that '!' (ctx:BxW)

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/gma500/intel_gmbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/intel_gmbus.c b/drivers/gpu/drm/gma500/intel_gmbus.c
index aa45509859f2..769e47480e11 100644
--- a/drivers/gpu/drm/gma500/intel_gmbus.c
+++ b/drivers/gpu/drm/gma500/intel_gmbus.c
@@ -39,7 +39,7 @@
 #define _wait_for(COND, MS, W) ({ \
 	unsigned long timeout__ = jiffies + msecs_to_jiffies(MS);	\
 	int ret__ = 0;							\
-	while (! (COND)) {						\
+	while (!(COND)) {						\
 		if (time_after(jiffies, timeout__)) {			\
 			ret__ = -ETIMEDOUT;				\
 			break;						\
-- 
2.17.1


