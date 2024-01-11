Return-Path: <linux-kernel+bounces-23082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1758782A770
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CBAC1C213C8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846B323C3;
	Thu, 11 Jan 2024 06:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ot0bgKDU"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C928A2105
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 06:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=ehJAe3CSmeN3lDNYy/
	+b8hVNINSf7+zifOWAKLIOOx0=; b=ot0bgKDUZPCnkLRjhL1mmmjjES9ySLkLak
	xDvgDxqZhEvqHO56iRLNJFA1jVrtvUd+i/HaarGBI012sNjMefCIbVO9rEJQsyQg
	PhbGn3htWohn3ENjaN7ZGE9LzoOshnBLljCEnqSgHq7iMt4sbMr8YUzpD3Cjl06s
	eyFG++yt8=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wD3f7nfhp9l5VwyAA--.62725S2;
	Thu, 11 Jan 2024 14:12:48 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: christian.koenig@amd.com,
	alexander.deucher@amd.com,
	Xinhui.Pan@amd.com,
	daniel@ffwll.ch,
	airlied@gmail.com
Cc: linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	chenxuebing <chenxb_99091@126.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in displayobject.h
Date: Thu, 11 Jan 2024 06:11:27 +0000
Message-Id: <20240111061127.8385-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3f7nfhp9l5VwyAA--.62725S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyUGryDZF48WrW5uw47twb_yoWkCFbEkr
	17Gw4xW3yIvrnFgF1j9rZ8ZrW2kw4a9F4kXFyfJay7t3yfC3W5W34DKr4jqFZ5WF4UCF4q
	yw48XFy7XrWa9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU0tC7UUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiWRdixWVLYUFHTAABst
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: spaces required around that '=' (ctx:WxV)
ERROR: space prohibited after that open parenthesis '('

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/include/displayobject.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/displayobject.h b/drivers/gpu/drm/amd/include/displayobject.h
index ddbfe122b2dc..0f9529c40496 100644
--- a/drivers/gpu/drm/amd/include/displayobject.h
+++ b/drivers/gpu/drm/amd/include/displayobject.h
@@ -159,7 +159,7 @@ CONNECTOR_SINGLE_LINK_DVI_D_ENUM_ID1 = (DISPLAY_OBJECT_TYPE_CONNECTOR << OBJECT_
                                                  OBJECT_ENUM_ID1 << ENUM_ID_SHIFT |\
                                                  CONNECTOR_OBJECT_ID_SINGLE_LINK_DVI_D << OBJECT_ID_SHIFT),
 
-CONNECTOR_SINGLE_LINK_DVI_D_ENUM_ID2 =(DISPLAY_OBJECT_TYPE_CONNECTOR << OBJECT_TYPE_SHIFT |\
+CONNECTOR_SINGLE_LINK_DVI_D_ENUM_ID2 = (DISPLAY_OBJECT_TYPE_CONNECTOR << OBJECT_TYPE_SHIFT |\
                                                  OBJECT_ENUM_ID2 << ENUM_ID_SHIFT |\
                                                  CONNECTOR_OBJECT_ID_SINGLE_LINK_DVI_D << OBJECT_ID_SHIFT),
 
-- 
2.17.1


