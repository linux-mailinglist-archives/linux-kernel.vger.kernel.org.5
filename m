Return-Path: <linux-kernel+bounces-6414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6AC819889
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AFFE2888C6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB10F18E0B;
	Wed, 20 Dec 2023 06:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PlvIct+c"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01146168B2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 06:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbd5ba9cbc7so1265209276.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 22:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703052786; x=1703657586; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FytEr1AiciozV1CFLbrh8ZdVPQCwqpJveiMvdE8lpUk=;
        b=PlvIct+cS4j7ihPNIJUdsghuHEFd+HeTsgxMUMd+bIJtkJq3bSo1jgmaVRGpIQWMVO
         LFU/GwvEIrCqC1I40GuZPHwfJZv2luZ4D7oEwHd3E10909QhSpujklxf9hirLrVv9vBt
         /kxDqc9/8tcxwyWV0WZZCYRE4rdtHYlRzZAIuRuZ/GMmmJ8dd2hjftYbCn4qFh27Jo3V
         rUKMd1Vvsw/qH+cKj5SC1GxEIaAeKZcH531zWMf75TZADYhBwNFQDKFW6AwLb+jMpCZV
         2NxdoX4xLx4ImGWQFrTW/LYJXJuvkaO6vxomu9OKn0BTQHXTewz2vrw0vUOUU5l6fKr2
         eltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703052786; x=1703657586;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FytEr1AiciozV1CFLbrh8ZdVPQCwqpJveiMvdE8lpUk=;
        b=cWMpMzsWJ4zBwiqEpm9PwUs9VZqLtPC/A2KqsaJvRkix1phBBTEZVS+FyGhO8jeOEy
         FQTqzXNBD2aVDuY2HVtp+BXHznpAHvqTU2dKawl4AEp2qYbqLNnux9oCuFI7vK3DbpEJ
         vVJpVdriuf6BWka6Ru1YdUK+7Cs9mRRkAidIANpvWkxXjj24Gw+k8Kxzq2NVLjBiltM/
         uwS6P8G04TrC2UteGovpaosrh8B7jbHCUFUwKzCaHrjKTSTLLZPhPYYVgNB5D67qbzA6
         paLgYPS3H0Pg2jSZhW1KdA7NONT7sqa4qO0NdmShv1q1jkktDmQ6qexRLoYp1S7F+WSV
         Kb1A==
X-Gm-Message-State: AOJu0YwKOagYZaPDbe8w0yUBHRzc8ZRV3NjbIqf6zYzxqqrnOLPoBs1M
	0q9/UWMfKOW3W1JSDtJY9Z0gGXAlikaLk+Ip
X-Google-Smtp-Source: AGHT+IFhU+ACKrdxqy/U0ilwdSG0AHSs/D4KzU5z627yhd9WcP3m3e9s5QcTmMDxLJFBD7GlK/M3LM3b4DBZ6DKr
X-Received: from changyuanl-desktop.svl.corp.google.com ([2620:15c:2a3:200:2c53:4290:ec42:9360])
 (user=changyuanl job=sendgmr) by 2002:a25:b904:0:b0:db4:5e66:4a05 with SMTP
 id x4-20020a25b904000000b00db45e664a05mr361892ybj.2.1703052785992; Tue, 19
 Dec 2023 22:13:05 -0800 (PST)
Date: Tue, 19 Dec 2023 22:13:00 -0800
In-Reply-To: <CACGkMEuEY5xJyf6H6RgqSuD0PeY9kynYywxzM2+3W6MPaav0Zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CACGkMEuEY5xJyf6H6RgqSuD0PeY9kynYywxzM2+3W6MPaav0Zw@mail.gmail.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231220061301.228671-1-changyuanl@google.com>
Subject: [PATCH v2] virtio_pmem: support feature SHMEM_REGION
From: Changyuan Lyu <changyuanl@google.com>
To: jasowang@redhat.com
Cc: changyuanl@google.com, dan.j.williams@intel.com, dave.jiang@intel.com, 
	linux-kernel@vger.kernel.org, mst@redhat.com, nvdimm@lists.linux.dev, 
	pankaj.gupta.linux@gmail.com, virtualization@lists.linux.dev, 
	vishal.l.verma@intel.com, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

On Tue, Dec 19, 2023 at 7:57 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Tue, Dec 19, 2023 at 3:19 PM Changyuan Lyu <changyuanl@google.com> wrote:
> >
> > +/* shmid of the shared memory region corresponding to the pmem */
> > +#define VIRTIO_PMEM_SHMCAP_ID 0
>
> NIT: not a native speaker, but any reason for "CAP" here? Would it be
> better to use SHMMEM_REGION_ID?

I was following the name VIRTIO_FS_SHMCAP_ID_CACHE in
include/uapi/linux/virtio_fs.h, where I guess "CAP" was referring to
the shared memory capability when the device is on PCI bus. I agree
SHMMEM_REGION_ID is a better name.

On Tue, Dec 19, 2023 at 3:19 PM Changyuan Lyu <changyuanl@google.com> wrote:
>
> +		if (!have_shm) {
> +			dev_err(&vdev->dev, "failed to get shared memory region %d\n",
> +					VIRTIO_PMEM_SHMCAP_ID);
> +			return -EINVAL;
> +		}

I realized that it needs to jump to tag out_vq to clean up vqs
instead of simply returnning an error.

Thanks for reviewing the patch!

---8<---

As per virtio spec 1.2 section 5.19.5.2, if the feature
VIRTIO_PMEM_F_SHMEM_REGION has been negotiated, the driver MUST query
shared memory ID 0 for the physical address ranges.

Signed-off-by: Changyuan Lyu <changyuanl@google.com>

---
V2:
  * renamed VIRTIO_PMEM_SHMCAP_ID to VIRTIO_PMEM_SHMEM_REGION_ID
  * fixed the error handling when region 0 does not exist
---
 drivers/nvdimm/virtio_pmem.c     | 30 ++++++++++++++++++++++++++----
 include/uapi/linux/virtio_pmem.h |  8 ++++++++
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
index a92eb172f0e7..8e447c7558cb 100644
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
@@ -57,10 +59,24 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
 		goto out_err;
 	}
 
-	virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
-			start, &vpmem->start);
-	virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
-			size, &vpmem->size);
+	if (virtio_has_feature(vdev, VIRTIO_PMEM_F_SHMEM_REGION)) {
+		have_shm = virtio_get_shm_region(vdev, &shm_reg,
+				(u8)VIRTIO_PMEM_SHMEM_REGION_ID);
+		if (!have_shm) {
+			dev_err(&vdev->dev, "failed to get shared memory region %d\n",
+					VIRTIO_PMEM_SHMEM_REGION_ID);
+			err = -ENXIO;
+			goto out_vq;
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
@@ -122,7 +138,13 @@ static void virtio_pmem_remove(struct virtio_device *vdev)
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
index d676b3620383..c5e49b6e58b1 100644
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
+#define VIRTIO_PMEM_SHMEM_REGION_ID 0
+
 struct virtio_pmem_config {
 	__le64 start;
 	__le64 size;
-- 
2.43.0.472.g3155946c3a-goog


