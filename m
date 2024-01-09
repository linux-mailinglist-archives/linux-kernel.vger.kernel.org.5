Return-Path: <linux-kernel+bounces-20921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A811828763
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B041C24336
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB46C39AC6;
	Tue,  9 Jan 2024 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7I9GQHG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C142839AC1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704808126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M8MWpk09OQuDs87AoNXwxvL0Dxd7gugP0Z+NGe+ASM8=;
	b=K7I9GQHG+KtpL+xofEBHXNV0z5DgF3XQdlzm4eeEFPh/EE8FMa5xlb1J6ZfSz6mb++cY8d
	6cOxOrEXYjbDbljVQv/ZZkTmlymbSKi8ltw40vTeXH9II+5le7s82R7PkdRP9ZXNbdknZO
	izMeXXlvLIW8fS3yAqDBSRAtBiYO4IM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-jOgiBFJ4NcWdubicmw4OwA-1; Tue, 09 Jan 2024 08:48:45 -0500
X-MC-Unique: jOgiBFJ4NcWdubicmw4OwA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40e4478a3afso11283655e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 05:48:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704808123; x=1705412923;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M8MWpk09OQuDs87AoNXwxvL0Dxd7gugP0Z+NGe+ASM8=;
        b=M4jHsFFYQ2cxG7W5bGkWMwdsZ8QZ2uDlLCaPCVAUFh8yt0iPNOrtwvOd+pLxNwW3oZ
         tVyxkz4Fl1rzdtCGmJYSCnXG8DK/RsCVYGxnQN7afXhl5gsqdy2+UBj+C1IfLH/yplxI
         P+YcHApOdrQ9zZcgxG+BjFx/S+2KWHmuusu533vilnaX9ck04bXyjCcC5T/4EYiY4Xmf
         fjWJsoZK8D3zDURqj8Wd9RUuWdrPkWKjizmYz14OKdNSq9n/l9L2YNLCozfhcgcgKZn2
         HdjzRJTzZzUBaPrRdyCsmLE+TdfRmot8vv4WmBjfqcqT6Ln3ks2r+aMrBNnK6t4xjNmY
         2/nQ==
X-Gm-Message-State: AOJu0Yxt34AW9NkVnvTuVWeVI4zP7kk2E6ztfZmrJRSvFqtFqM8AxR48
	vCI60vGSFamor+4zGiBHRcy3nipOZeLTFZrDZ/6Y+kubnq0D5SJ+e7AphO+yJywIDSH/74gSug5
	uT5BDIdNMMNEEzIYbDVCWaMlebvrDhbqTf3ubuw9H
X-Received: by 2002:a7b:cd17:0:b0:40e:364d:d526 with SMTP id f23-20020a7bcd17000000b0040e364dd526mr510541wmj.87.1704808123736;
        Tue, 09 Jan 2024 05:48:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCa84zrH28KSvMgLx7Cb7jp4WCSd+4pulKgR7Vjd/YUqadrK/0HeoSukDb/qnNIbHxwb4oiQ==
X-Received: by 2002:a7b:cd17:0:b0:40e:364d:d526 with SMTP id f23-20020a7bcd17000000b0040e364dd526mr510532wmj.87.1704808123414;
        Tue, 09 Jan 2024 05:48:43 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c4fce00b0040d8cd116e4sm14883637wmq.37.2024.01.09.05.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 05:48:43 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, Erico
 Nunes <nunes.erico@gmail.com>, =?utf-8?Q?Jos=C3=A9_Exp=C3=B3sito?=
 <jose.exposito89@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, Donald
 Robson <donald.robson@imgtec.com>, Frank Binns <frank.binns@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Matt Coster
 <matt.coster@imgtec.com>, Sarah Walker <sarah.walker@imgtec.com>, Thomas
 Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/imagination: Defer probe if requested firmware is
 not available
In-Reply-To: <ZZ1IellMvvyFlQaF@phenom.ffwll.local>
References: <20240109120604.603700-1-javierm@redhat.com>
 <ZZ1IellMvvyFlQaF@phenom.ffwll.local>
Date: Tue, 09 Jan 2024 14:48:42 +0100
Message-ID: <8734v6r51h.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daniel Vetter <daniel@ffwll.ch> writes:

Hello Sima,

Thanks for your feedback.

> On Tue, Jan 09, 2024 at 01:05:59PM +0100, Javier Martinez Canillas wrote:
>> The device is initialized in the driver's probe callback and as part of
>> that initialization, the required firmware is loaded. But this fails if
>> the driver is built-in and the firmware isn't present in the initramfs:
>> 
>> $ dmesg | grep powervr
>> [    2.969757] powervr fd00000.gpu: Direct firmware load for powervr/rogue_33.15.11.3_v1.fw failed with error -2
>> [    2.979727] powervr fd00000.gpu: [drm] *ERROR* failed to load firmware powervr/rogue_33.15.11.3_v1.fw (err=-2)
>> [    2.989885] powervr: probe of fd00000.gpu failed with error -2
>> 
>> $ ls -lh /lib/firmware/powervr/rogue_33.15.11.3_v1.fw.xz
>> -rw-r--r-- 1 root root 51K Dec 12 19:00 /lib/firmware/powervr/rogue_33.15.11.3_v1.fw.xz
>> 
>> To prevent the probe to fail for this case, let's defer the probe if the
>> firmware isn't available. That way, the driver core can retry it and get
>> the probe to eventually succeed once the root filesystem has been mounted.
>> 
>> If the firmware is also not present in the root filesystem, then the probe
>> will never succeed and the reason listed in the debugfs devices_deferred:
>> 
>> $ cat /sys/kernel/debug/devices_deferred
>> fd00000.gpu     powervr: failed to load firmware powervr/rogue_33.15.11.3_v1.fw (err=-517)
>> 
>> Fixes: f99f5f3ea7ef ("drm/imagination: Add GPU ID parsing and firmware loading")
>> Suggested-by: Maxime Ripard <mripard@kernel.org>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>
> Uh that doesn't work.
>
> Probe is for "I'm missing a struct device" and _only_ that. You can't
> assume that probe deferral will defer enough until the initrd shows up.
>

Fair.

> You need to fix this by fixing the initrd to include the required
> firmwares. This is what MODULE_FIRMWARE is for, and if your initrd fails
> to observe that it's just broken.
>

Tha's already the case, when is built as a module the initrd (dracut in
this particular case) does figure out that the firmware needs to be added
but that doesn't work when the DRM driver is built-in. Because dracut is
not able to figure out and doesn't even have a powervr.ko info to look at
whatever is set by the MODULE_FIRMWARE macro.

> Yes I know as long as you have enough stuff built as module so that there
> will be _any_ kind of device probe after the root fs is mounted, this
> works, because that triggers a re-probe of everything. But that's the most
> kind of fragile fix there is.
>

Is fragile that's true but on the other hand it does solve the issue in
pratice. The whole device probal mechanism is just a best effort anyways.

> If you want to change that then I think that needs an official blessing
> from Greg KH/device core folks.
>

I liked this approach due its simplicity but an alternative (and more
complex) solution could be to delay the firmware request and not do it at
probe time.

For example, the following (only barely tested) patch solves the issue for
me as well but it's a bigger change to this driver and wasn't sure if will
be acceptable:

From c3fb715047a44691412196d8408f2bd495bcd1ed Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javierm@redhat.com>
Date: Tue, 9 Jan 2024 14:47:05 +0100
Subject: [RFC PATCH] drm/imagination: Move PowerVR GPU init to the drivers's open
 callback
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently the device is initialized in the driver's probe callback. But as
part of this initialization, the required firmware is loaded and this will
fail when the driver is built-in, unless FW is included in the initramfs:

$ dmesg | grep powervr
[    2.969757] powervr fd00000.gpu: Direct firmware load for powervr/rogue_33.15.11.3_v1.fw failed with error -2
[    2.979727] powervr fd00000.gpu: [drm] *ERROR* failed to load firmware powervr/rogue_33.15.11.3_v1.fw (err=-2)
[    2.989885] powervr: probe of fd00000.gpu failed with error -2

$ ls -lh /lib/firmware/powervr/rogue_33.15.11.3_v1.fw.xz
-rw-r--r-- 1 root root 51K Dec 12 19:00 /lib/firmware/powervr/rogue_33.15.11.3_v1.fw.xz

To prevent this, let's delay the PowerVR GPU-specific initialization until
the render device is opened by user-space. By then, the root filesystem
will be mounted already and the driver able to find the required firmware.

Besides the mentioned problem, it seems more correct to only load firmware
and request the IRQ if the device is opened rather than do these on probe.

Fixes: f99f5f3ea7ef ("drm/imagination: Add GPU ID parsing and firmware loading")
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/imagination/pvr_device.c | 41 +++++++-----------------
 drivers/gpu/drm/imagination/pvr_device.h |  2 ++
 drivers/gpu/drm/imagination/pvr_drv.c    | 19 +++++++----
 3 files changed, 27 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/imagination/pvr_device.c
index 1704c0268589..1e0a3868394e 100644
--- a/drivers/gpu/drm/imagination/pvr_device.c
+++ b/drivers/gpu/drm/imagination/pvr_device.c
@@ -404,7 +404,7 @@ pvr_set_dma_info(struct pvr_device *pvr_dev)
  *  * Any error returned by pvr_memory_context_init(), or
  *  * Any error returned by pvr_request_firmware().
  */
-static int
+int
 pvr_device_gpu_init(struct pvr_device *pvr_dev)
 {
 	int err;
@@ -444,6 +444,10 @@ pvr_device_gpu_init(struct pvr_device *pvr_dev)
 	if (err)
 		goto err_vm_ctx_put;
 
+	err = pvr_device_irq_init(pvr_dev);
+	if (err)
+		goto err_vm_ctx_put;
+
 	return 0;
 
 err_vm_ctx_put:
@@ -459,9 +463,15 @@ pvr_device_gpu_init(struct pvr_device *pvr_dev)
  * pvr_device_gpu_fini() - GPU-specific deinitialization for a PowerVR device
  * @pvr_dev: Target PowerVR device.
  */
-static void
+void
 pvr_device_gpu_fini(struct pvr_device *pvr_dev)
 {
+	/*
+	 * Deinitialization stages are performed in reverse order compared to
+	 * the initialization stages in pvr_device_gpu_init().
+	 */
+	pvr_device_irq_fini(pvr_dev);
+
 	pvr_fw_fini(pvr_dev);
 
 	if (pvr_dev->fw_dev.processor_type != PVR_FW_PROCESSOR_TYPE_MIPS) {
@@ -519,43 +529,16 @@ pvr_device_init(struct pvr_device *pvr_dev)
 	if (err)
 		goto err_pm_runtime_put;
 
-	/* Perform GPU-specific initialization steps. */
-	err = pvr_device_gpu_init(pvr_dev);
-	if (err)
-		goto err_pm_runtime_put;
-
-	err = pvr_device_irq_init(pvr_dev);
-	if (err)
-		goto err_device_gpu_fini;
-
 	pm_runtime_put(dev);
 
 	return 0;
 
-err_device_gpu_fini:
-	pvr_device_gpu_fini(pvr_dev);
-
 err_pm_runtime_put:
 	pm_runtime_put_sync_suspend(dev);
 
 	return err;
 }
 
-/**
- * pvr_device_fini() - Deinitialize a PowerVR device
- * @pvr_dev: Target PowerVR device.
- */
-void
-pvr_device_fini(struct pvr_device *pvr_dev)
-{
-	/*
-	 * Deinitialization stages are performed in reverse order compared to
-	 * the initialization stages in pvr_device_init().
-	 */
-	pvr_device_irq_fini(pvr_dev);
-	pvr_device_gpu_fini(pvr_dev);
-}
-
 bool
 pvr_device_has_uapi_quirk(struct pvr_device *pvr_dev, u32 quirk)
 {
diff --git a/drivers/gpu/drm/imagination/pvr_device.h b/drivers/gpu/drm/imagination/pvr_device.h
index 2ca7e535799f..3083fcd3f91e 100644
--- a/drivers/gpu/drm/imagination/pvr_device.h
+++ b/drivers/gpu/drm/imagination/pvr_device.h
@@ -481,6 +481,8 @@ packed_bvnc_to_pvr_gpu_id(u64 bvnc, struct pvr_gpu_id *gpu_id)
 	gpu_id->c = bvnc & GENMASK_ULL(15, 0);
 }
 
+int pvr_device_gpu_init(struct pvr_device *pvr_dev);
+void pvr_device_gpu_fini(struct pvr_device *pvr_dev);
 int pvr_device_init(struct pvr_device *pvr_dev);
 void pvr_device_fini(struct pvr_device *pvr_dev);
 void pvr_device_reset(struct pvr_device *pvr_dev);
diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index 5c3b2d58d766..f8fb45136326 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -1309,10 +1309,18 @@ pvr_drm_driver_open(struct drm_device *drm_dev, struct drm_file *file)
 {
 	struct pvr_device *pvr_dev = to_pvr_device(drm_dev);
 	struct pvr_file *pvr_file;
+	int err;
+
+	/* Perform GPU-specific initialization steps. */
+	err = pvr_device_gpu_init(pvr_dev);
+	if (err)
+		return err;
 
 	pvr_file = kzalloc(sizeof(*pvr_file), GFP_KERNEL);
-	if (!pvr_file)
+	if (!pvr_file) {
+		pvr_device_gpu_fini(pvr_dev);
 		return -ENOMEM;
+	}
 
 	/*
 	 * Store reference to base DRM file private data for use by
@@ -1354,6 +1362,7 @@ static void
 pvr_drm_driver_postclose(__always_unused struct drm_device *drm_dev,
 			 struct drm_file *file)
 {
+	struct pvr_device *pvr_dev = to_pvr_device(drm_dev);
 	struct pvr_file *pvr_file = to_pvr_file(file);
 
 	/* Kill remaining contexts. */
@@ -1364,6 +1373,8 @@ pvr_drm_driver_postclose(__always_unused struct drm_device *drm_dev,
 	pvr_destroy_hwrt_datasets_for_file(pvr_file);
 	pvr_destroy_vm_contexts_for_file(pvr_file);
 
+	pvr_device_gpu_fini(pvr_dev);
+
 	kfree(pvr_file);
 	file->driver_priv = NULL;
 }
@@ -1430,16 +1441,13 @@ pvr_probe(struct platform_device *plat_dev)
 
 	err = drm_dev_register(drm_dev, 0);
 	if (err)
-		goto err_device_fini;
+		goto err_watchdog_fini;
 
 	xa_init_flags(&pvr_dev->free_list_ids, XA_FLAGS_ALLOC1);
 	xa_init_flags(&pvr_dev->job_ids, XA_FLAGS_ALLOC1);
 
 	return 0;
 
-err_device_fini:
-	pvr_device_fini(pvr_dev);
-
 err_watchdog_fini:
 	pvr_watchdog_fini(pvr_dev);
 
@@ -1464,7 +1472,6 @@ pvr_remove(struct platform_device *plat_dev)
 	xa_destroy(&pvr_dev->free_list_ids);
 
 	pm_runtime_suspend(drm_dev->dev);
-	pvr_device_fini(pvr_dev);
 	drm_dev_unplug(drm_dev);
 	pvr_watchdog_fini(pvr_dev);
 	pvr_queue_device_fini(pvr_dev);
-- 
2.43.0

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


