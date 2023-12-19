Return-Path: <linux-kernel+bounces-4794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 592DE818224
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED6A9B2342D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009B3C158;
	Tue, 19 Dec 2023 07:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MtnxsFxB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DE7C12A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 07:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-daee86e2d70so3469788276.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 23:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702970389; x=1703575189; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gZWYP/oOlOggqgKUebMmGuOo7PQ5M/AycpxW1yV0m6w=;
        b=MtnxsFxBxZNMGn2Luk18C1b1mf5zI3r0YaWQw9uHwRaq/Cg00HujuZWDf0nxuN5bcV
         tRXKw/ceP9i3ZeH+t8k2NfaapZcud6tyTwtKVrfwMiv3McJRIGPEqmTeb0RY4uMvmYTV
         3XZYeaXQ9FOVhqxtuBlxWHFRM6PeoWPLtSMS07ztCn6Jd3Hneq6vBMmLR/p4PpNphtBw
         SS/n+e84Hmk+T0f05lUVaR6ny2UXZLu45Rdbdt3J9pdnQQORTtod5a7duNmnXg8tRwDG
         gl4MnKGNsns+tLywAgXmE/PbWp0h/lzAfboa6jpt1TmJLC/tUMtTbD9G1e8UqNHDHzfM
         9Akw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702970389; x=1703575189;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gZWYP/oOlOggqgKUebMmGuOo7PQ5M/AycpxW1yV0m6w=;
        b=nO4quTxudqqSK7N5hwuK1aAnbdkZbxnaL3gbFiS8SOMyDZHJsVT2VbS8QPJuMZvDfH
         9cU9yUUWiEQIc/B1gcW8dSlRb7+G9tvgvSAM1cAksuK3rcJ0iSuDO0XWsNWlVANiFp0c
         EGUBvY5J8zuZRYJMJnZw0wTg06l+fZsPMpB6x+Nw5l7lU+Fc3iKlURqreV3sk88cYjkR
         lDsgxvvuQbwtsKYpFlcVcoouXTsax4VC7+bbuJSz2IVGCw2+OGNM/v/GetuNIcnFkQxE
         Fyd321IawExRs02xXz3ic4eOGk9dUZvu2b71I4aSkJF0Wtg/BlSUd09J6evuZNHGBxXE
         fBjg==
X-Gm-Message-State: AOJu0Yy/jblwl27wy3oARWZoXXRMHVoUjeV7r/0VkLl47M2yHPXy3ojp
	Rvkn72muk7cWP2JzBd81+7WNdZ/0cCwKaLXk
X-Google-Smtp-Source: AGHT+IE+rN4NVhqEMOpU1c0Y1JbYbMaraxu/g+XW3gohe7Z0gme65cSYEjDzpnlNRx8dnz8oXjI74er4NvKN5KMi
X-Received: from changyuanl-desktop.svl.corp.google.com ([2620:15c:2a3:200:b586:7ce5:ab58:992c])
 (user=changyuanl job=sendgmr) by 2002:a25:b904:0:b0:db4:5e66:4a05 with SMTP
 id x4-20020a25b904000000b00db45e664a05mr324670ybj.2.1702970388799; Mon, 18
 Dec 2023 23:19:48 -0800 (PST)
Date: Mon, 18 Dec 2023 23:18:49 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231219071849.3912896-1-changyuanl@google.com>
Subject: [PATCH] virtio_pmem: support feature SHMEM_REGION
From: Changyuan Lyu <changyuanl@google.com>
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	virtualization@lists.linux.dev, nvdimm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"

As per virtio spec 1.2 section 5.19.5.2, if the feature
VIRTIO_PMEM_F_SHMEM_REGION has been negotiated, the driver MUST query
shared memory ID 0 for the physical address ranges.

Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 drivers/nvdimm/virtio_pmem.c     | 29 +++++++++++++++++++++++++----
 include/uapi/linux/virtio_pmem.h |  8 ++++++++
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
index a92eb172f0e7..5b28d543728b 100644
--- a/drivers/nvdimm/virtio_pmem.c
+++ b/drivers/nvdimm/virtio_pmem.c
@@ -35,6 +35,8 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
 	struct nd_region *nd_region;
 	struct virtio_pmem *vpmem;
 	struct resource res;
+	struct virtio_shm_region shm_reg;
+	bool have_shm;
 	int err = 0;
 
 	if (!vdev->config->get) {
@@ -57,10 +59,23 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
 		goto out_err;
 	}
 
-	virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
-			start, &vpmem->start);
-	virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
-			size, &vpmem->size);
+	if (virtio_has_feature(vdev, VIRTIO_PMEM_F_SHMEM_REGION)) {
+		have_shm = virtio_get_shm_region(vdev, &shm_reg,
+				(u8)VIRTIO_PMEM_SHMCAP_ID);
+		if (!have_shm) {
+			dev_err(&vdev->dev, "failed to get shared memory region %d\n",
+					VIRTIO_PMEM_SHMCAP_ID);
+			return -EINVAL;
+		}
+		vpmem->start = shm_reg.addr;
+		vpmem->size = shm_reg.len;
+	} else {
+		virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
+				start, &vpmem->start);
+		virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
+				size, &vpmem->size);
+	}
+
 
 	res.start = vpmem->start;
 	res.end   = vpmem->start + vpmem->size - 1;
@@ -122,7 +137,13 @@ static void virtio_pmem_remove(struct virtio_device *vdev)
 	virtio_reset_device(vdev);
 }
 
+static unsigned int features[] = {
+	VIRTIO_PMEM_F_SHMEM_REGION,
+};
+
 static struct virtio_driver virtio_pmem_driver = {
+	.feature_table		= features,
+	.feature_table_size	= ARRAY_SIZE(features),
 	.driver.name		= KBUILD_MODNAME,
 	.driver.owner		= THIS_MODULE,
 	.id_table		= id_table,
diff --git a/include/uapi/linux/virtio_pmem.h b/include/uapi/linux/virtio_pmem.h
index d676b3620383..025174f6eacf 100644
--- a/include/uapi/linux/virtio_pmem.h
+++ b/include/uapi/linux/virtio_pmem.h
@@ -14,6 +14,14 @@
 #include <linux/virtio_ids.h>
 #include <linux/virtio_config.h>
 
+/* Feature bits */
+#define VIRTIO_PMEM_F_SHMEM_REGION 0	/* guest physical address range will be
+					 * indicated as shared memory region 0
+					 */
+
+/* shmid of the shared memory region corresponding to the pmem */
+#define VIRTIO_PMEM_SHMCAP_ID 0
+
 struct virtio_pmem_config {
 	__le64 start;
 	__le64 size;
-- 
2.43.0.472.g3155946c3a-goog


