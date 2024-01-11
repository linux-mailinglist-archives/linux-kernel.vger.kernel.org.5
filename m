Return-Path: <linux-kernel+bounces-23153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD9E82A869
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E033F2838DE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1D9D294;
	Thu, 11 Jan 2024 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VJmoc6MS"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C50D271
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=S/f2vyfPnwoS0WzdX3
	JNLT4HQzDSAla6k7Zu1R5fNKU=; b=VJmoc6MSB/ECxs9GhEKm5x1b/1LKRYgmHG
	Agik00T+6PRgE5+nMWX7zcPFARiRtG8OtBGizepRCElf8lexCvOBcM+KBDn0oOwt
	4KJCAJpB8UC9LT8DgAho1iCY845dq5H4v9fK9/55szQAlrRfapy1c2b+xqVFB3gp
	32IZGsRqc=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wD3X+1Alp9ljIeRAA--.17433S2;
	Thu, 11 Jan 2024 15:18:24 +0800 (CST)
From: GuoHua Chen <chenguohua_716@163.com>
To: alain.volmat@foss.st.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	GuoHua Chen <chenguohua_716@163.com>
Subject: [PATCH] drm/sti: Clean up errors in sti_mixer.c
Date: Thu, 11 Jan 2024 07:18:23 +0000
Message-Id: <20240111071823.10142-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3X+1Alp9ljIeRAA--.17433S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFW3XryfZF43Zr1kuF4Durg_yoW3Cwb_CF
	47trs5Ww4YyrnrGr12ka13ZFsavr43uan5Za48tas3JrWDXr45X34kWryDXw18WFW3JFnF
	ya97XFy3Cr9agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjT7KDUUUUU==
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/xtbBEh5i1mVOBk4eZgAAsj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: do not initialise statics to 0x000000

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/sti/sti_mixer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_mixer.c b/drivers/gpu/drm/sti/sti_mixer.c
index 7e5f14646625..6628c7f78868 100644
--- a/drivers/gpu/drm/sti/sti_mixer.c
+++ b/drivers/gpu/drm/sti/sti_mixer.c
@@ -16,7 +16,7 @@
 #include "sti_vtg.h"
 
 /* Module parameter to set the background color of the mixer */
-static unsigned int bkg_color = 0x000000;
+static unsigned int bkg_color;
 MODULE_PARM_DESC(bkgcolor, "Value of the background color 0xRRGGBB");
 module_param_named(bkgcolor, bkg_color, int, 0644);
 
-- 
2.17.1


