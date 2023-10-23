Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4580C7D40C3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 22:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjJWUSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 16:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjJWUSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 16:18:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A7610C1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 13:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698092255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KAf5Rr1iVgdAw+Z3XFK7IgULN7/EDBIya+lJDvW29po=;
        b=hPa5E4FBEIiBPtauHO9HfI3Wu0LRK4A183khO8FSi7l5nwJtYBe9lAeij7CjwXkvL61wqf
        /BCzZKDOSnYryT7c833Qx9KGoiyteSh3snof/eIVS4esztb55fTUuyfhAsZFY7YiYWwVhh
        dpePuBBqIPPpO+mTbv70vaiZ4cPCQ6A=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-D5-LN_F6Ow-efY1Yxgzinw-1; Mon, 23 Oct 2023 16:17:29 -0400
X-MC-Unique: D5-LN_F6Ow-efY1Yxgzinw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9b2cf504e3aso246611166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 13:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698092247; x=1698697047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAf5Rr1iVgdAw+Z3XFK7IgULN7/EDBIya+lJDvW29po=;
        b=MQPIH365btB+Jq74alerBddSE3BjT3tv6tRRPKo5t/de/EeCS2FVnGgEbllGRXL4eQ
         wfKXHRgiRDuLuDcSjQ5EmZb59xARlrw2LAoB+kw6ggSFsu+/2GgBrsTxIzELgCE0X38P
         Scd20JQljlG5OOCme6scnUWWSuTUFE1KuSO6YIqGnLpBvdw97H6ymhZC1jNKxzXMPGcM
         rmZqiaUK4Oaq1rdo/RGjzuVA9tnx/PZzCKlTYP2ZN9n5MieoYppT9L9oGnA1mPn91KBL
         vP7o6oEnnuLPM11RxxRz7osU3oeR7t34mJUK/+MaAvGDYHfgilE/h9/Qt2RqD+uoWe4u
         uVFg==
X-Gm-Message-State: AOJu0Yz9Uls6VFyDmdbJ+AqdL2cfPeE3wUmpyCcSex9KAYbukFhhU024
        sp6RFnJIEAvVKt9UsHPwRSJvZQVOF1V1tWkhcoJjkYhFTw15YPTFBpT626JFJAwGDTdmizA6LGG
        TMlPrc8G4n/s13tdcJODM6Wbee4S1nw/J
X-Received: by 2002:a17:906:32da:b0:9ba:65e:750e with SMTP id k26-20020a17090632da00b009ba065e750emr6001252ejk.32.1698092247354;
        Mon, 23 Oct 2023 13:17:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGD4g3QAuTF8kVHCKeF6VyrY5PWPxzwc20qpCoZUcRTv0lXg6r40s20U0k1pvFmXDqRjaaTNQ==
X-Received: by 2002:a17:906:32da:b0:9ba:65e:750e with SMTP id k26-20020a17090632da00b009ba065e750emr6001236ejk.32.1698092247142;
        Mon, 23 Oct 2023 13:17:27 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id dv24-20020a170906b81800b009a168ab6ee2sm7015109ejb.164.2023.10.23.13.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 13:17:26 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v7 6/7] drm/nouveau: make use of the GPUVM's shared dma-resv
Date:   Mon, 23 Oct 2023 22:16:52 +0200
Message-ID: <20231023201659.25332-7-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023201659.25332-1-dakr@redhat.com>
References: <20231023201659.25332-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DRM GEM objects private to a single GPUVM can use a shared dma-resv.
Make use of the shared dma-resv of GPUVM rather than a driver specific
one.

The shared dma-resv originates from a "root" GEM object serving as
container for the dma-resv to make it compatible with drm_exec.

In order to make sure the object proving the shared dma-resv can't be
freed up before the objects making use of it, let every such GEM object
take a reference on it.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_bo.c   | 11 +++++++++--
 drivers/gpu/drm/nouveau/nouveau_bo.h   |  5 +++++
 drivers/gpu/drm/nouveau/nouveau_gem.c  | 10 ++++++++--
 drivers/gpu/drm/nouveau/nouveau_uvmm.c |  7 ++-----
 drivers/gpu/drm/nouveau/nouveau_uvmm.h |  1 -
 5 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 0f3bd187ede6..7afad86da64b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -148,10 +148,17 @@ nouveau_bo_del_ttm(struct ttm_buffer_object *bo)
 	 * If nouveau_bo_new() allocated this buffer, the GEM object was never
 	 * initialized, so don't attempt to release it.
 	 */
-	if (bo->base.dev)
+	if (bo->base.dev) {
+		/* Gem objects not being shared with other VMs get their
+		 * dma_resv from a root GEM object.
+		 */
+		if (nvbo->no_share)
+			drm_gem_object_put(nvbo->r_obj);
+
 		drm_gem_object_release(&bo->base);
-	else
+	} else {
 		dma_resv_fini(&bo->base._resv);
+	}
 
 	kfree(nvbo);
 }
diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.h b/drivers/gpu/drm/nouveau/nouveau_bo.h
index 07f671cf895e..70c551921a9e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.h
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.h
@@ -26,6 +26,11 @@ struct nouveau_bo {
 	struct list_head entry;
 	int pbbo_index;
 	bool validate_mapped;
+
+	/* Root GEM object we derive the dma_resv of in case this BO is not
+	 * shared between VMs.
+	 */
+	struct drm_gem_object *r_obj;
 	bool no_share;
 
 	/* GPU address space is independent of CPU word size */
diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index a0d303e5ce3d..49c2bcbef129 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -111,7 +111,8 @@ nouveau_gem_object_open(struct drm_gem_object *gem, struct drm_file *file_priv)
 	if (vmm->vmm.object.oclass < NVIF_CLASS_VMM_NV50)
 		return 0;
 
-	if (nvbo->no_share && uvmm && &uvmm->resv != nvbo->bo.base.resv)
+	if (nvbo->no_share && uvmm &&
+	    drm_gpuvm_resv(&uvmm->base) != nvbo->bo.base.resv)
 		return -EPERM;
 
 	ret = ttm_bo_reserve(&nvbo->bo, false, false, NULL);
@@ -245,7 +246,7 @@ nouveau_gem_new(struct nouveau_cli *cli, u64 size, int align, uint32_t domain,
 		if (unlikely(!uvmm))
 			return -EINVAL;
 
-		resv = &uvmm->resv;
+		resv = drm_gpuvm_resv(&uvmm->base);
 	}
 
 	if (!(domain & (NOUVEAU_GEM_DOMAIN_VRAM | NOUVEAU_GEM_DOMAIN_GART)))
@@ -288,6 +289,11 @@ nouveau_gem_new(struct nouveau_cli *cli, u64 size, int align, uint32_t domain,
 	if (drm->client.device.info.family >= NV_DEVICE_INFO_V0_TESLA)
 		nvbo->valid_domains &= domain;
 
+	if (nvbo->no_share) {
+		nvbo->r_obj = drm_gpuvm_resv_obj(&uvmm->base);
+		drm_gem_object_get(nvbo->r_obj);
+	}
+
 	*pnvbo = nvbo;
 	return 0;
 }
diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 1e95b0a1b047..005bb9c77990 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1842,7 +1842,6 @@ nouveau_uvmm_init(struct nouveau_uvmm *uvmm, struct nouveau_cli *cli,
 	int ret;
 
 	mutex_init(&uvmm->mutex);
-	dma_resv_init(&uvmm->resv);
 	mt_init_flags(&uvmm->region_mt, MT_FLAGS_LOCK_EXTERN);
 	mt_set_external_lock(&uvmm->region_mt, &uvmm->mutex);
 
@@ -1885,14 +1884,14 @@ nouveau_uvmm_init(struct nouveau_uvmm *uvmm, struct nouveau_cli *cli,
 			    kernel_managed_addr, kernel_managed_size,
 			    NULL, 0, &cli->uvmm.vmm.vmm);
 	if (ret)
-		goto out_free_gpuva_mgr;
+		goto out_gpuvm_fini;
 
 	cli->uvmm.vmm.cli = cli;
 	mutex_unlock(&cli->mutex);
 
 	return 0;
 
-out_free_gpuva_mgr:
+out_gpuvm_fini:
 	drm_gpuvm_destroy(&uvmm->base);
 out_unlock:
 	mutex_unlock(&cli->mutex);
@@ -1950,6 +1949,4 @@ nouveau_uvmm_fini(struct nouveau_uvmm *uvmm)
 	nouveau_vmm_fini(&uvmm->vmm);
 	drm_gpuvm_destroy(&uvmm->base);
 	mutex_unlock(&cli->mutex);
-
-	dma_resv_fini(&uvmm->resv);
 }
diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.h b/drivers/gpu/drm/nouveau/nouveau_uvmm.h
index a308c59760a5..878cc7958483 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.h
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.h
@@ -12,7 +12,6 @@ struct nouveau_uvmm {
 	struct nouveau_vmm vmm;
 	struct maple_tree region_mt;
 	struct mutex mutex;
-	struct dma_resv resv;
 
 	u64 kernel_managed_addr;
 	u64 kernel_managed_size;
-- 
2.41.0

