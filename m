Return-Path: <linux-kernel+bounces-129535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BA5896C58
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FC64B2985E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF4F13AD2F;
	Wed,  3 Apr 2024 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="E8bqjPJj"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EDD137933;
	Wed,  3 Apr 2024 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139976; cv=none; b=JVfc7/vnHlg/zp1W+eYIwrwi29YCuMl4Gmi9oiW9y0vqXvBAFURBvufVFXL2sAFVwAWrUmPMQArogefKfJGJUNHYeoHfHJpX/RvwK+acq80+4+5bErufi4Gv84e/3LXTyudRR/vqXoLRgNibDyxdWGivSko3hH6oPgBbArOdZO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139976; c=relaxed/simple;
	bh=8aaBJr63kQxDdWbfBycNeLNa1P95Go+c14ogN0Tzs20=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rBw0LngdC6JvNJOTvVC4Ph6c/094cPMcSf/0fwwksCFwUSHTZ5If6U9RhEDBJb9SeRBja/edm8j94SQIqAP5KAWvJu0PynoHSYJ6PGK5PGGjiwDnQ4xpol+YHczXFZqNEvCLKTBR45gHi1l0pz0dMz+X/mB0uNjFCwonIHPIGB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=E8bqjPJj; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 948c89f6f1a411eeb8927bc1f75efef4-20240403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=zI0sMjMp3gJZFl+e3ioYmwF3P0NdTg6udb+mIb8wH+w=;
	b=E8bqjPJjhdi9/zpaPjsZGPf4l5dRtfzHMvzYsg8TDzyAlNCzJdE0Bedb5E9S3HFpLWCR86l4yzpx7UlduOlnO8K30rkn2PVen7kIXH54iGWgCDjda/dCDLAe8R2UpKMNXzn1N4DrEUU7u9F/KCtPQKynB783ASnD5bWFaU3yDGI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:919b9912-9c0c-4485-b2ac-ee963ecc1dd6,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:2bfcc585-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 948c89f6f1a411eeb8927bc1f75efef4-20240403
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 28167227; Wed, 03 Apr 2024 18:26:06 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 3 Apr 2024 18:26:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 3 Apr 2024 18:26:05 +0800
From: Shawn Sung <shawn.sung@mediatek.com>
To: CK Hu <ck.hu@mediatek.com>, Jassi Brar <jassisinghbrar@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, Hsiao Chien Sung
	<shawn.sung@mediatek.com>, "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
	Houlong Wei <houlong.wei@mediatek.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Hsiao Chien Sung
	<shawn.sung@mediatek.corp-partner.google.com>
Subject: [PATCH v5 10/10] drm/mediatek: Add interface to allocate MediaTek GEM buffer.
Date: Wed, 3 Apr 2024 18:26:02 +0800
Message-ID: <20240403102602.32155-11-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240403102602.32155-1-shawn.sung@mediatek.com>
References: <20240403102602.32155-1-shawn.sung@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--10.383100-8.000000
X-TMASE-MatchedRID: IP2XlN8ufaOXFGyE5q3nYI6MisxJraxHvhf/zJ92tsP7efdnqtsaE0bj
	B8LDWKj2Aunqu1nlwTRswaBvYjx/7iQVVteP90CtKaMQ6tw7oDJU3K6aV1ad7d9RlPzeVuQQkmi
	3zE7HIvkybq5nXNxxl6mm1mbOCqOQig1RteqE6iB0Uibeis6dEK6JG5H2YJq6FLXUWU5hGiERcU
	eSUAEujpJWdV1quNw8aNPw9ABc6H69WjwSnAs/t6OuVibdZNTvuoYFb0nRiqPIvQIyugvKdbyPe
	55WbcuIaO7i+fdXAfAy7RToPtBlKOlVfYNOXGqmoiN8YTmq+cvoFXQb3ZgkUf2TbFr0CGODEcRa
	3XM5JeRptSMKPu8IjkdWV7qYCXR19dXaIcOJDZ+yBjDX4sGuTaxwr8rYOW+OZ3q824boKrLr2yi
	Kkd3N2shHObr27PYyaK8uWXuH4d0fE8yM4pjsDwtuKBGekqUpI/NGWt0UYPCztFsz3UM2JH/t3i
	lEWiSYZevEzYr2I57Pbkz8xBB1sCZW8DARDgA6
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.383100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	5013D66FBB75C856B501B8C8A0161162BCDC9187673B60F24AF64EE2E4CAC5DD2000:8
X-MTK: N

From: CK Hu <ck.hu@mediatek.com>

Add an interface to allocate MediaTek GEM buffers, allow the IOCTLs
to be used by render nodes.
This patch also sets the RENDER driver feature.

Signed-off-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 16 ++++++-
 drivers/gpu/drm/mediatek/mtk_gem.c     | 40 ++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_gem.h     | 11 +++++
 include/uapi/drm/mediatek_drm.h        | 64 ++++++++++++++++++++++++++
 4 files changed, 130 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/drm/mediatek_drm.h

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index b5f605751b0a1..41eed3f89316c 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -23,6 +23,7 @@
 #include <drm/drm_of.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
+#include <drm/mediatek_drm.h>
 
 #include "mtk_crtc.h"
 #include "mtk_ddp_comp.h"
@@ -570,6 +571,14 @@ static void mtk_drm_kms_deinit(struct drm_device *drm)
 	component_unbind_all(drm->dev, drm);
 }
 
+static const struct drm_ioctl_desc mtk_ioctls[] = {
+	DRM_IOCTL_DEF_DRV(MTK_GEM_CREATE, mtk_gem_create_ioctl,
+			  DRM_UNLOCKED | DRM_AUTH | DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(MTK_GEM_MAP_OFFSET,
+			  mtk_gem_map_offset_ioctl,
+			  DRM_UNLOCKED | DRM_AUTH | DRM_RENDER_ALLOW),
+};
+
 DEFINE_DRM_GEM_FOPS(mtk_drm_fops);
 
 /*
@@ -585,12 +594,17 @@ static struct drm_gem_object *mtk_gem_prime_import(struct drm_device *dev,
 }
 
 static const struct drm_driver mtk_drm_driver = {
-	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
+	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC |
+			   DRIVER_RENDER,
 
 	.dumb_create = mtk_gem_dumb_create,
 
 	.gem_prime_import = mtk_gem_prime_import,
 	.gem_prime_import_sg_table = mtk_gem_prime_import_sg_table,
+
+	.ioctls = mtk_ioctls,
+	.num_ioctls = ARRAY_SIZE(mtk_ioctls),
+
 	.fops = &mtk_drm_fops,
 
 	.name = DRIVER_NAME,
diff --git a/drivers/gpu/drm/mediatek/mtk_gem.c b/drivers/gpu/drm/mediatek/mtk_gem.c
index 5a82d7cf3ed0d..e59e0727717b7 100644
--- a/drivers/gpu/drm/mediatek/mtk_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_gem.c
@@ -4,9 +4,11 @@
  */
 
 #include <linux/dma-buf.h>
+#include <drm/mediatek_drm.h>
 
 #include <drm/drm.h>
 #include <drm/drm_device.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_prime.h>
@@ -285,3 +287,41 @@ void mtk_gem_prime_vunmap(struct drm_gem_object *obj, struct iosys_map *map)
 	mtk_gem->kvaddr = NULL;
 	kfree(mtk_gem->pages);
 }
+
+int mtk_gem_map_offset_ioctl(struct drm_device *drm, void *data,
+			     struct drm_file *file_priv)
+{
+	struct drm_mtk_gem_map_off *args = data;
+
+	return drm_gem_dumb_map_offset(file_priv, drm, args->handle,
+				       &args->offset);
+}
+
+int mtk_gem_create_ioctl(struct drm_device *dev, void *data,
+			 struct drm_file *file_priv)
+{
+	struct mtk_gem_obj *mtk_gem;
+	struct drm_mtk_gem_create *args = data;
+	int ret;
+
+	mtk_gem = mtk_gem_create(dev, args->size, false);
+	if (IS_ERR(mtk_gem))
+		return PTR_ERR(mtk_gem);
+
+	/*
+	 * allocate a id of idr table where the obj is registered
+	 * and handle has the id what user can see.
+	 */
+	ret = drm_gem_handle_create(file_priv, &mtk_gem->base, &args->handle);
+	if (ret)
+		goto err_handle_create;
+
+	/* drop reference from allocate - handle holds it now. */
+	drm_gem_object_put(&mtk_gem->base);
+
+	return 0;
+
+err_handle_create:
+	mtk_gem_free_object(&mtk_gem->base);
+	return ret;
+}
diff --git a/drivers/gpu/drm/mediatek/mtk_gem.h b/drivers/gpu/drm/mediatek/mtk_gem.h
index 66e5f154f6980..4d7598220ca8f 100644
--- a/drivers/gpu/drm/mediatek/mtk_gem.h
+++ b/drivers/gpu/drm/mediatek/mtk_gem.h
@@ -45,4 +45,15 @@ struct drm_gem_object *mtk_gem_prime_import_sg_table(struct drm_device *dev,
 int mtk_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map);
 void mtk_gem_prime_vunmap(struct drm_gem_object *obj, struct iosys_map *map);
 
+/*
+ * request gem object creation and buffer allocation as the size
+ * that it is calculated with framebuffer information such as width,
+ * height and bpp.
+ */
+int mtk_gem_create_ioctl(struct drm_device *dev, void *data,
+			 struct drm_file *file_priv);
+
+/* get buffer offset to map to user space. */
+int mtk_gem_map_offset_ioctl(struct drm_device *dev, void *data,
+			     struct drm_file *file_priv);
 #endif
diff --git a/include/uapi/drm/mediatek_drm.h b/include/uapi/drm/mediatek_drm.h
new file mode 100644
index 0000000000000..b0dea00bacbc4
--- /dev/null
+++ b/include/uapi/drm/mediatek_drm.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2015 MediaTek Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _UAPI_MEDIATEK_DRM_H
+#define _UAPI_MEDIATEK_DRM_H
+
+#include <drm/drm.h>
+
+#ifdef __KERNEL__
+#include <linux/types.h>
+#else
+#include <stdint.h>
+#endif
+
+/**
+ * User-desired buffer creation information structure.
+ *
+ * @size: user-desired memory allocation size.
+ *	- this size value would be page-aligned internally.
+ * @flags: user request for setting memory type or cache attributes.
+ * @handle: returned a handle to created gem object.
+ *	- this handle will be set by gem module of kernel side.
+ */
+struct drm_mtk_gem_create {
+	uint64_t size;
+	uint32_t flags;
+	uint32_t handle;
+};
+
+/**
+ * A structure for getting buffer offset.
+ *
+ * @handle: a pointer to gem object created.
+ * @pad: just padding to be 64-bit aligned.
+ * @offset: relatived offset value of the memory region allocated.
+ *     - this value should be set by user.
+ */
+struct drm_mtk_gem_map_off {
+	uint32_t handle;
+	uint32_t pad;
+	uint64_t offset;
+};
+
+#define DRM_MTK_GEM_CREATE		0x00
+#define DRM_MTK_GEM_MAP_OFFSET		0x01
+
+#define DRM_IOCTL_MTK_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + \
+		DRM_MTK_GEM_CREATE, struct drm_mtk_gem_create)
+
+#define DRM_IOCTL_MTK_GEM_MAP_OFFSET	DRM_IOWR(DRM_COMMAND_BASE + \
+		DRM_MTK_GEM_MAP_OFFSET, struct drm_mtk_gem_map_off)
+
+#endif /* _UAPI_MEDIATEK_DRM_H */
-- 
2.18.0


