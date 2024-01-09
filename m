Return-Path: <linux-kernel+bounces-20825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F5B8285B8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5A71F25120
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88189374EB;
	Tue,  9 Jan 2024 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVeHUeHm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B950374C4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 12:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704801974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8M7Gv5IVBBA2mbcRwXaGm3ftRkiaPEEV/XwtkM0luc0=;
	b=gVeHUeHmD/X9OPza+F9FIi+6nL3lxqeAHTxnX9Y8psrKcfw1SEg7ap4e4hZXAEqwJhK6fD
	5vm2DntaOHP/jw67m6z0QP5I8rkiRC+7RUAAevyTFkRkCq+IReHrcOjXWYzjkEYziGM7XQ
	iDmDll+odTWM/Os+BSxSJ2GL4Ekn7xo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-eJNqjcGbONKt1edTNc8k1A-1; Tue, 09 Jan 2024 07:06:13 -0500
X-MC-Unique: eJNqjcGbONKt1edTNc8k1A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3368698f0caso1837457f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 04:06:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704801971; x=1705406771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8M7Gv5IVBBA2mbcRwXaGm3ftRkiaPEEV/XwtkM0luc0=;
        b=LKY/Gq31pfINKXezIezLHilEE3VlpJPVPvyKBeOl4OCB+44MKh4PSrXWbXx6kq3pla
         e4k7szMY3jpb96AbllExzz2Ib/gNJhpSP0znlomcIr4H/KlMLsIWb7kAcc38Ry8cRJYx
         d+DAFZwtXVcYu1ZLAjgX21CFR8tBXcs4dY+TJJW/bliCt4g2fh/jNZhcuXnuK7+1IDd0
         5ynpRCDd382A8Q472Y8UFPKDqzDcVQAbU9/QhuIvufnaIuAfHwA4W7txsYW2sJlCXU+3
         eIfKBfIn66qJN1QwyJm7kuzK9V21ZFdkFYmiVfhYW0OJv7Vvm/1LzNce+XCjkPZ4s13Q
         PMlw==
X-Gm-Message-State: AOJu0YwtJgP+20FGl53AtT9vIVlKTPJ0uVRnC2ppJIpAircFWNdIR129
	teVDsHoXCNc7r1BHbv54pbxB4f/BhhE6iR9oTixi184+9ydtYyyFHkUDoMHDajqfNuTcYclCljA
	AQ/XuSd1u1rdamScwaTPkOs/mleF/QbHTpgPAzwPbiA3hjd9EQkqY15Sm9vjyxLd53aG0hsIS8/
	1WvLrBFlJwjt6P63o=
X-Received: by 2002:adf:e4c4:0:b0:337:4a10:ea3 with SMTP id v4-20020adfe4c4000000b003374a100ea3mr317800wrm.186.1704801971238;
        Tue, 09 Jan 2024 04:06:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7g1/Xhez1rCFP7vtPXdsWcQDVa/csDBccgmtzWhXp51V5vd3d6ZEfxealNmYDMH9OoEa7iA==
X-Received: by 2002:adf:e4c4:0:b0:337:4a10:ea3 with SMTP id v4-20020adfe4c4000000b003374a100ea3mr317783wrm.186.1704801970911;
        Tue, 09 Jan 2024 04:06:10 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600004d000b003367ff4aadasm2250543wri.31.2024.01.09.04.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 04:06:10 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>,
	Erico Nunes <nunes.erico@gmail.com>,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Donald Robson <donald.robson@imgtec.com>,
	Frank Binns <frank.binns@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Sarah Walker <sarah.walker@imgtec.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/imagination: Defer probe if requested firmware is not available
Date: Tue,  9 Jan 2024 13:05:59 +0100
Message-ID: <20240109120604.603700-1-javierm@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The device is initialized in the driver's probe callback and as part of
that initialization, the required firmware is loaded. But this fails if
the driver is built-in and the firmware isn't present in the initramfs:

$ dmesg | grep powervr
[    2.969757] powervr fd00000.gpu: Direct firmware load for powervr/rogue_33.15.11.3_v1.fw failed with error -2
[    2.979727] powervr fd00000.gpu: [drm] *ERROR* failed to load firmware powervr/rogue_33.15.11.3_v1.fw (err=-2)
[    2.989885] powervr: probe of fd00000.gpu failed with error -2

$ ls -lh /lib/firmware/powervr/rogue_33.15.11.3_v1.fw.xz
-rw-r--r-- 1 root root 51K Dec 12 19:00 /lib/firmware/powervr/rogue_33.15.11.3_v1.fw.xz

To prevent the probe to fail for this case, let's defer the probe if the
firmware isn't available. That way, the driver core can retry it and get
the probe to eventually succeed once the root filesystem has been mounted.

If the firmware is also not present in the root filesystem, then the probe
will never succeed and the reason listed in the debugfs devices_deferred:

$ cat /sys/kernel/debug/devices_deferred
fd00000.gpu     powervr: failed to load firmware powervr/rogue_33.15.11.3_v1.fw (err=-517)

Fixes: f99f5f3ea7ef ("drm/imagination: Add GPU ID parsing and firmware loading")
Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/imagination/pvr_device.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/imagination/pvr_device.c
index 1704c0268589..6eda25366431 100644
--- a/drivers/gpu/drm/imagination/pvr_device.c
+++ b/drivers/gpu/drm/imagination/pvr_device.c
@@ -295,8 +295,16 @@ pvr_request_firmware(struct pvr_device *pvr_dev)
 	 */
 	err = request_firmware(&fw, filename, pvr_dev->base.dev);
 	if (err) {
-		drm_err(drm_dev, "failed to load firmware %s (err=%d)\n",
-			filename, err);
+		/*
+		 * Defer probe if the firmware is not available yet (e.g: the driver
+		 * is built-in and the firmware not present in the initramfs image).
+		 */
+		if (err == -ENOENT)
+			err = -EPROBE_DEFER;
+
+		dev_err_probe(drm_dev->dev, err, "failed to load firmware %s (err=%d)\n",
+			      filename, err);
+
 		goto err_free_filename;
 	}
 
-- 
2.43.0


