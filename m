Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1478812B13
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbjLNJE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbjLNJEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:04:16 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1811198
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:04:09 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50bf37fd2bbso10624771e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702544648; x=1703149448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cTvFHAMXeQGxCRdh6OTGkWelc6AXy45UFFjHQGyz1GI=;
        b=KTdjbHbtKHcKHqiG9sdGOTsjzt3Vk5draYMWyq1JoFWIAk5pOnYjGi2Bx6qgqXZ/bA
         Xg4SFwVpYVUgf57tfY9Q1QaRQglxGH7IeL82+JUg5L3BwEjS1b8fpNs3iTC8NZu2olMA
         X7Ql8mXGEe/ON+1n/QePMAfB33+/ELRk4OebJ6B2Q2kLwuN4Wk3MIFihSyA6fJicZ9nM
         9jJ5otUg6b1/KQJF9DHgdXdoGCcA6K+yIYVcNw4tVVRYoeSrfKx7e9KNO9hN7HQG0gEa
         chzM36IzG9HO7E4jmJx2vFtzEtxWtWYXsPLIxxEw/3wZKNzFITOh/4+t4xjdjUtmKJXU
         AX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702544648; x=1703149448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTvFHAMXeQGxCRdh6OTGkWelc6AXy45UFFjHQGyz1GI=;
        b=YrpRcYw4otplHo8AbuAUxQLl0iEnENk6Efr9Gkj6m8Pim8UdXHRvoV/+aU8gEdi3i1
         hFV24mTImZWPTsfcq23RB4M5jRnFfv6N+NKeZ+SK3mlaVRJrEaQZsYOVz8DJeOQ1NNKs
         bUJ5x7rnIo2gvbGmuTPhWvPOE+qBn41hp8nL67kovBax6Yq8i3MRCwVT9JBfxZrJJUq7
         NNwqZWHsXKG7h+QpEG155lBY+oGxj0VoAa+FqyjqbBTcEUUrNcAQJiSJdJ3tH+VXullE
         /4ayCG6A7bC1pU8A289UDyDA8mTn3WLkyQHVzMHdAr7dZ6ISqqR9rFkI/ZB5WfhcwIKW
         nDgw==
X-Gm-Message-State: AOJu0Yzg2NYkyJVePG+O1wfSHi1rmlIBX/6hK7oQqMnhOXvibtWj5U3k
        IxSkmBH5ZfRMLyU40k8+yw8=
X-Google-Smtp-Source: AGHT+IGSi0gVopc2whZcyu6ZJQjxvWITahwwKg9EWNncmutR/e9990NTWTAZuaPKMNSD9DOe+AIM5Q==
X-Received: by 2002:a19:3810:0:b0:50d:1f13:2fc6 with SMTP id f16-20020a193810000000b0050d1f132fc6mr3799206lfa.37.1702544647500;
        Thu, 14 Dec 2023 01:04:07 -0800 (PST)
Received: from odroid.prahal.homelinux.net (91-175-163-178.subs.proxad.net. [91.175.163.178])
        by smtp.gmail.com with ESMTPSA id vu8-20020a170907a64800b00a1d5c52d628sm9007847ejc.3.2023.12.14.01.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 01:04:06 -0800 (PST)
From:   Alban Browaeys <alban.browaeys@gmail.com>
Cc:     Alban Browaeys <alban.browaeys@gmail.com>,
        Qiang Yu <yuq825@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RFC: drm/lima: fix calling drm_mm_init with an empty range
Date:   Thu, 14 Dec 2023 10:12:11 +0100
Message-Id: <20231214091215.2435-1-alban.browaeys@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the empty_vm initialization the range is empty which is not supported
by drm_mm_init.

With CONFIG_DRM_DEBUG_MM set, I get:
------------[ cut here ]------------
 kernel BUG at drivers/gpu/drm/drm_mm.c:965!
 Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
 Modules linked in: lima(+) drm_shmem_helper gpu_sched s5p_jpeg s5p_g2d
 videobuf2_dma_contig videobuf2_memops v4l2_mem2mem videobuf2_v4l2
 videobuf2_common s5p_cec tun fuse configfs auth_rpcgss sunrpc ip_tables
 x_tables autofs4 btrfs lzo_compress zlib_deflate raid10 raid456
 async_raid6_recov async_memcpy async_pq async_xor async_tx xor xor_neon
 raid6_pq libcrc32c raid1 raid0 linear md_mod dm_mirror dm_region_hash
 dm_log hid_logitech_hidpp hid_logitech_dj
 CPU: 0 PID: 1033 Comm: systemd-udevd Not tainted 6.4.0-rc1-debug+ #230
 Hardware name: Samsung Exynos (Flattened Device Tree)
 PC is at drm_mm_init+0x94/0x98
 LR is at 0x0
 Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
  drm_mm_init from lima_vm_create+0xcc/0x108 [lima]
  lima_vm_create [lima] from lima_device_init+0xd8/0x4a0 [lima]
  lima_device_init [lima] from lima_pdev_probe.part.0+0x6c/0x158 [lima]
  lima_pdev_probe.part.0 [lima] from platform_probe+0x64/0xc0
  platform_probe from call_driver_probe+0x2c/0x110

The drm_mm.c line 965 is:
drivers/gpu/drm/drm_mm.c
void drm_mm_init(struct drm_mm *mm, u64 start, u64 size)
{
        DRM_MM_BUG_ON(start + size <= start);

lima_vm_create is called with va_start and va_end both unset
in lima_device_init line 371:
ldev->empty_vm = lima_vm_create(ldev);

Signed-off-by: Alban Browaeys <alban.browaeys@gmail.com>
---
 drivers/gpu/drm/lima/lima_device.c |  2 +-
 drivers/gpu/drm/lima/lima_drv.c    |  2 +-
 drivers/gpu/drm/lima/lima_vm.c     | 10 +++++++---
 drivers/gpu/drm/lima/lima_vm.h     |  3 ++-
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_device.c b/drivers/gpu/drm/lima/lima_device.c
index 02cef0cea657..bd3afff0f44a 100644
--- a/drivers/gpu/drm/lima/lima_device.c
+++ b/drivers/gpu/drm/lima/lima_device.c
@@ -368,7 +368,7 @@ int lima_device_init(struct lima_device *ldev)
 	if (err)
 		goto err_out0;
 
-	ldev->empty_vm = lima_vm_create(ldev);
+	ldev->empty_vm = lima_vm_create(ldev, false);
 	if (!ldev->empty_vm) {
 		err = -ENOMEM;
 		goto err_out1;
diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_drv.c
index 10fd9154cc46..ca09142e0ac1 100644
--- a/drivers/gpu/drm/lima/lima_drv.c
+++ b/drivers/gpu/drm/lima/lima_drv.c
@@ -219,7 +219,7 @@ static int lima_drm_driver_open(struct drm_device *dev, struct drm_file *file)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->vm = lima_vm_create(ldev);
+	priv->vm = lima_vm_create(ldev, true);
 	if (!priv->vm) {
 		err = -ENOMEM;
 		goto err_out0;
diff --git a/drivers/gpu/drm/lima/lima_vm.c b/drivers/gpu/drm/lima/lima_vm.c
index 2b2739adc7f5..7f9775eefd78 100644
--- a/drivers/gpu/drm/lima/lima_vm.c
+++ b/drivers/gpu/drm/lima/lima_vm.c
@@ -197,7 +197,7 @@ u32 lima_vm_get_va(struct lima_vm *vm, struct lima_bo *bo)
 	return ret;
 }
 
-struct lima_vm *lima_vm_create(struct lima_device *dev)
+struct lima_vm *lima_vm_create(struct lima_device *dev, bool has_drm_mm)
 {
 	struct lima_vm *vm;
 
@@ -221,7 +221,10 @@ struct lima_vm *lima_vm_create(struct lima_device *dev)
 			goto err_out1;
 	}
 
-	drm_mm_init(&vm->mm, dev->va_start, dev->va_end - dev->va_start);
+	if (has_drm_mm) {
+		vm->has_drm_mm = true;
+		drm_mm_init(&vm->mm, dev->va_start, dev->va_end - dev->va_start);
+	}
 
 	return vm;
 
@@ -237,7 +240,8 @@ void lima_vm_release(struct kref *kref)
 	struct lima_vm *vm = container_of(kref, struct lima_vm, refcount);
 	int i;
 
-	drm_mm_takedown(&vm->mm);
+	if (vm->has_drm_mm)
+		drm_mm_takedown(&vm->mm);
 
 	for (i = 0; i < LIMA_VM_NUM_BT; i++) {
 		if (vm->bts[i].cpu)
diff --git a/drivers/gpu/drm/lima/lima_vm.h b/drivers/gpu/drm/lima/lima_vm.h
index 3a7c74822d8b..e7443f410d6d 100644
--- a/drivers/gpu/drm/lima/lima_vm.h
+++ b/drivers/gpu/drm/lima/lima_vm.h
@@ -30,6 +30,7 @@ struct lima_vm {
 	struct mutex lock;
 	struct kref refcount;
 
+	bool has_drm_mm;
 	struct drm_mm mm;
 
 	struct lima_device *dev;
@@ -43,7 +44,7 @@ void lima_vm_bo_del(struct lima_vm *vm, struct lima_bo *bo);
 
 u32 lima_vm_get_va(struct lima_vm *vm, struct lima_bo *bo);
 
-struct lima_vm *lima_vm_create(struct lima_device *dev);
+struct lima_vm *lima_vm_create(struct lima_device *dev, bool has_drm_mm);
 void lima_vm_release(struct kref *kref);
 
 static inline struct lima_vm *lima_vm_get(struct lima_vm *vm)
-- 
2.39.2

