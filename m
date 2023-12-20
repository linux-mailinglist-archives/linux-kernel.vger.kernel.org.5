Return-Path: <linux-kernel+bounces-7422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2096781A7BF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3EC1F23474
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 20:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66261EA7B;
	Wed, 20 Dec 2023 20:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2hJ5E3U4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F67E1DA4E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 20:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbdae92c10aso146403276.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 12:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703105388; x=1703710188; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+67tASvvfvVlycjBWIPAKXF8pqUpHvg7cTGJy7iScoY=;
        b=2hJ5E3U4bK9LtJ00LFR+G8VE3Af/W1hYNTBtqhJeCcdukgDvlc3UYCl1JlxmH0V01h
         O6RPTvxuvhtrrG92H3aREHYgqqBE7/zt6ppJPmhKH7ouYitUV7QjdREUKDQIVZoU72Xm
         RwU7xfcEDD5RWWsF1HwuRVPZjjPPWEVvtt+EqRISgo9ZzkoMKOz5q5cXgk4Hyrie9LRz
         mupv6lLA0h3dWebTzQ50uFWBkNtVdXNouAM1TIh5BOJfmPFxezbGycH9CZXxbOcmA+b1
         pmjFLeoer86ri7Q2TEM0vr25mNb9rqLPD30r+CTlRJjLp0CV8WgK64yvQfk46c8epMNc
         V0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703105388; x=1703710188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+67tASvvfvVlycjBWIPAKXF8pqUpHvg7cTGJy7iScoY=;
        b=oBmiw8Tona1lCyLdtokieTJaTcGoXukD0zJGOGwlBppze/YsJlzW6ESKjvqkpxgdt2
         k753NsIvy8E2IiX703JIyETUoomocdToi7XwtsdeU85eGlSMJW3L0GsA84DB8qV/IVdC
         VktfseNZpPQDdE1KCVyZjS3oAU7HwTIXa0EO5om/MIeMawxPLoLiNGVcOFeCI1aV7IfD
         DhNQsloKNXmaCudTJ/39bML5VgkSWP5pAKrL+9I4sVxgA6H3fhPUKcACEzrCQ2K3dIpd
         p+oCZyhkTrauRTKFNKBClo2Z3jNxro+5YAjTBfvpHMR4UTebKUGFxLlpzk+D3vhbJOkC
         ZgBQ==
X-Gm-Message-State: AOJu0YyGD+vP4qn1B5zX+R1bPzzGeKksojDbjmjUrESj87gv2gCpLGdj
	Sn20wc8n7bhJc6cZS98YXTxu3p/a4i6/5GsB
X-Google-Smtp-Source: AGHT+IFGz/g8oviURbSJJeUW8nOMBtaCgjO0s5GEio3sKCF+sokVNU4wY8bytqJ5H4vjvQnhZJx9AlAUQr7FnGnG
X-Received: from changyuanl-desktop.svl.corp.google.com ([2620:15c:2a3:200:7133:a1e9:e9d0:684b])
 (user=changyuanl job=sendgmr) by 2002:a25:850d:0:b0:dbd:460e:1262 with SMTP
 id w13-20020a25850d000000b00dbd460e1262mr123237ybk.3.1703105388077; Wed, 20
 Dec 2023 12:49:48 -0800 (PST)
Date: Wed, 20 Dec 2023 12:49:06 -0800
In-Reply-To: <20231220023653-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231220023653-mutt-send-email-mst@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231220204906.566922-1-changyuanl@google.com>
Subject: [PATCH v4] virtio_pmem: support feature SHMEM_REGION
From: Changyuan Lyu <changyuanl@google.com>
To: mst@redhat.com
Cc: changyuanl@google.com, dan.j.williams@intel.com, dave.jiang@intel.com, 
	jasowang@redhat.com, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	pankaj.gupta.linux@gmail.com, virtualization@lists.linux.dev, 
	vishal.l.verma@intel.com, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Thanks Michael for the feedback!

On Tue, Dec 19, 2023 at 11:44 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> > On Tue, Dec 19, 2023 at 11:32:27PM -0800, Changyuan Lyu wrote:
> > 
> > +		if (!have_shm) {
> > +			dev_err(&vdev->dev, "failed to get shared memory region %d\n",
> > +					VIRTIO_PMEM_SHMEM_REGION_ID);
> > +			err = -ENXIO;
> > +			goto out_vq;
> > +		}
>
> Maybe additionally, add a validate callback and clear
> VIRTIO_PMEM_F_SHMEM_REGION if VIRTIO_PMEM_SHMEM_REGION_ID is not there.

Done.

> > +/* Feature bits */
> > +#define VIRTIO_PMEM_F_SHMEM_REGION 0	/* guest physical address range will be
> > +					 * indicated as shared memory region 0
> > +					 */
>
> Either make this comment shorter to fit in one line, or put the
> multi-line comment before the define.

Done.

---8<---

This patch adds the support for feature VIRTIO_PMEM_F_SHMEM_REGION
(virtio spec v1.2 section 5.19.5.2 [1]). 

During feature negotiation, if VIRTIO_PMEM_F_SHMEM_REGION is offered
by the device, the driver looks for a shared memory region of id 0.
If it is found, this feature is understood. Otherwise, this feature
bit is cleared.

During probe, if VIRTIO_PMEM_F_SHMEM_REGION has been negotiated,
virtio pmem ignores the `start` and `size` fields in device config
and uses the physical address range of shared memory region 0.

[1] https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html#x1-6480002

Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
v4:
  * added virtio_pmem_validate callback. 
v3:
  * updated the patch description.
V2:
  * renamed VIRTIO_PMEM_SHMCAP_ID to VIRTIO_PMEM_SHMEM_REGION_ID
  * fixed the error handling when region 0 does not exist
---
 drivers/nvdimm/virtio_pmem.c     | 36 ++++++++++++++++++++++++++++----
 include/uapi/linux/virtio_pmem.h |  7 +++++++
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
index a92eb172f0e7..4ceced5cefcf 100644
--- a/drivers/nvdimm/virtio_pmem.c
+++ b/drivers/nvdimm/virtio_pmem.c
@@ -29,12 +29,27 @@ static int init_vq(struct virtio_pmem *vpmem)
 	return 0;
 };
 
+static int virtio_pmem_validate(struct virtio_device *vdev)
+{
+	struct virtio_shm_region shm_reg;
+
+	if (virtio_has_feature(vdev, VIRTIO_PMEM_F_SHMEM_REGION) &&
+		!virtio_get_shm_region(vdev, &shm_reg, (u8)VIRTIO_PMEM_SHMEM_REGION_ID)
+	) {
+		dev_notice(&vdev->dev, "failed to get shared memory region %d\n",
+				VIRTIO_PMEM_SHMEM_REGION_ID);
+		__virtio_clear_bit(vdev, VIRTIO_PMEM_F_SHMEM_REGION);
+	}
+	return 0;
+}
+
 static int virtio_pmem_probe(struct virtio_device *vdev)
 {
 	struct nd_region_desc ndr_desc = {};
 	struct nd_region *nd_region;
 	struct virtio_pmem *vpmem;
 	struct resource res;
+	struct virtio_shm_region shm_reg;
 	int err = 0;
 
 	if (!vdev->config->get) {
@@ -57,10 +72,16 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
 		goto out_err;
 	}
 
-	virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
-			start, &vpmem->start);
-	virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
-			size, &vpmem->size);
+	if (virtio_has_feature(vdev, VIRTIO_PMEM_F_SHMEM_REGION)) {
+		virtio_get_shm_region(vdev, &shm_reg, (u8)VIRTIO_PMEM_SHMEM_REGION_ID);
+		vpmem->start = shm_reg.addr;
+		vpmem->size = shm_reg.len;
+	} else {
+		virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
+				start, &vpmem->start);
+		virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
+				size, &vpmem->size);
+	}
 
 	res.start = vpmem->start;
 	res.end   = vpmem->start + vpmem->size - 1;
@@ -122,10 +143,17 @@ static void virtio_pmem_remove(struct virtio_device *vdev)
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
+	.validate		= virtio_pmem_validate,
 	.probe			= virtio_pmem_probe,
 	.remove			= virtio_pmem_remove,
 };
diff --git a/include/uapi/linux/virtio_pmem.h b/include/uapi/linux/virtio_pmem.h
index d676b3620383..ede4f3564977 100644
--- a/include/uapi/linux/virtio_pmem.h
+++ b/include/uapi/linux/virtio_pmem.h
@@ -14,6 +14,13 @@
 #include <linux/virtio_ids.h>
 #include <linux/virtio_config.h>
 
+/* Feature bits */
+/* guest physical address range will be indicated as shared memory region 0 */
+#define VIRTIO_PMEM_F_SHMEM_REGION 0
+
+/* shmid of the shared memory region corresponding to the pmem */
+#define VIRTIO_PMEM_SHMEM_REGION_ID 0
+
 struct virtio_pmem_config {
 	__le64 start;
 	__le64 size;
-- 
2.43.0.472.g3155946c3a-goog


