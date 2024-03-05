Return-Path: <linux-kernel+bounces-92291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E48A871DFE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54A0B28680E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2CD5B5C3;
	Tue,  5 Mar 2024 11:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="ZeOa8Sr0"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810765B1EA;
	Tue,  5 Mar 2024 11:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638472; cv=none; b=ls7CjeSmhzlI2dgCXOEhESpmoJcioekk1AT2mTyArcZwXqgkL13HfiaNOwJrjybSVQ7UmNecobYvQyxkomLGyamlteDZgvW5nuw2P/Y7pjl8UnPtw5fbHSzywhsf2u23zbryv5DNYfZWfYviSLqwr7mKlB2/fmIhCZdZrwmctNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638472; c=relaxed/simple;
	bh=TBVpOiYhHL/5knKRvD0InlYh5cmtDcK9l0qZqxgxL78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dqil5aCongtWgmTtqzVJSgBuu5cByJkV5K3aDrTqa8P0ooxVz1M7KA9Jso9tCmVZBLsQzXrCTZuLpqSM40laBIUOEppNddxp4PEyScoxCx6Gm67YqwufeDhTJ7uNwj8LE45l13HqyigqFK75eC2jE7L3134FfqMXvES6TTRg6EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=ZeOa8Sr0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dbd32cff0bso46999905ad.0;
        Tue, 05 Mar 2024 03:34:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709638470; x=1710243270;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SGvjvL1l3IEoVUIMcNND+raHtPvpiWRh02eFx2GTgcs=;
        b=AoCIrG1PMnITXmJmj3VwZhG90wJNJsY0S4rayW3wcLqNPBymg2ITo8TX2W6KF2b6ui
         o0AoYKrnx4pKidAXmgG9rv1k+5usTRvXr8E6h3CDTsOjbJF7wfLkYjL+ROfm7KZbYP54
         mGnSPOgMNWWAZ7fDFXzm161lDpqMf1rdweBoOUFnLsrd15UGrdVyFVn+BCqz5sPonODp
         idW7vJ03NflOj+s5SF21jkTvUCz2bjM90O+JNPTdjYfVLQwJOpQWUrrB3Aa60BiemIia
         rnj3yFm1b836HoV4ejX03x0nhqVyQrkW/WNpUDp+2r9g8vrcrkRk9ydI7zjqyjAStIfB
         BTXA==
X-Forwarded-Encrypted: i=1; AJvYcCWGUZApX+LJPVHM+8UG0fksYk+ZQvSMLqo9VPXw94BavRFkqvLwAySnfrGe0uL5TfLMH2kkEDclCt/hgraI6f9fSfeExezBf8/YEKya79ni1iy6l636PzJEyocYX9JuhpSKO4R/x69iQaJ90acPAWliPB+O2XHyRur61EqHBWvmhveYkhYrHA==
X-Gm-Message-State: AOJu0YzASSUu1IX+i9FCBJTW9Jn6TGG5z4dVaAQCg6KAoQX/Jj19DS2H
	B5F9VaW1NLZM6sLf/lxoqHQZJReku/LFelj6sz2BoeLJPsfcjDPwLYZx1aVrT5x8NQ==
X-Google-Smtp-Source: AGHT+IEvvXqVgNig+0Ajd3GcxrPcqCzSQEPkm0LQdI67Nas42de+ACS1GOh6k+iqXrCZCfKKLop+HQ==
X-Received: by 2002:a17:902:e74b:b0:1da:22d9:e7fd with SMTP id p11-20020a170902e74b00b001da22d9e7fdmr1703170plf.20.1709638469624;
        Tue, 05 Mar 2024 03:34:29 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id d15-20020a170903230f00b001dc3c4e7a12sm10315600plh.14.2024.03.05.03.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 03:34:29 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709638468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGvjvL1l3IEoVUIMcNND+raHtPvpiWRh02eFx2GTgcs=;
	b=ZeOa8Sr0g4u6ioHCa+AEJa2P0N6xyD41cZUQ99KQvEzFdKnmd85LBQCyqKPIR5hy9KPSf7
	2+tam0hUlZYXqIDf0mcMsitkiEf4w2O2Dsug3zulLjOsnzEaXf10zv9c76IibqBwUbkjxn
	MWnSweGc9mb7nk902l1B8nIts3HHOF/UOhYGjUTALy8vy8lGwsa28tCcLbBXgfvcuUjmLn
	d6M6yTQvSWAXtpSrKnFRA/ZhPJRh47SAhJag2AzLaXAhKco444IbXSptaSEjuK0sIydl4h
	h7PH7a3+TI9JSbm/NNmJU4sIXPFk7ie9bTMFZIZv2WLs3VbdxddhAK4zjQxccQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 08:34:13 -0300
Subject: [PATCH RESEND drm-misc 4/4] dma-buf: heaps: make dma_heap_class
 constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-drm-v1-4-94f82740525a@marliere.net>
References: <20240305-class_cleanup-drm-v1-0-94f82740525a@marliere.net>
In-Reply-To: <20240305-class_cleanup-drm-v1-0-94f82740525a@marliere.net>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Hans de Goede <hdegoede@redhat.com>, Helge Deller <deller@gmx.de>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2638; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=TBVpOiYhHL/5knKRvD0InlYh5cmtDcK9l0qZqxgxL78=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl5wMzXXEwr5JfufBuY7fFwRJL8nmL4A2R2R+Df
 j91UwjdnM+JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZecDMwAKCRDJC4p8Y4ZY
 pqQCD/9dAq8lWzYs5OjaBNAHM65zzjgz6Bgu/yB5UChhzZHSF5jbEB1KCMPsLUcOAD+H6g5bK69
 pAUxqPv2rzp9CWK1LphHF75Ys/ePMnp2Bcf4OyzIE6f91RhLoj6a4vbkFPo3ZEjSx/18f21XIqK
 7npqmmzF9bMJZ4uEDe+jODA+DBQYN9hVaJbTKxDS8gCZmfU25oI1BHVDQhreY8re7+ix7JSRyBm
 wPUj4mXuV+tzsbL9ZckyDvXuWCbO9ahj9PS3uSjE9nNg5frRpySuqZc8r94FQaSLRmTtmqSMmEa
 SaOKMQjsYWaR7HDt0KtlK2iZTXF+vm7jUvldFW4No5i3FP74h3rBI791dRMszvQXVMxe0YSJp1p
 S65Q9hxfqClvd7imVlKLKicraIepW+0Q+1p/FN5pf9wbZH4HmFKRlFJwDXpizdmwDpzqrPs2Fcz
 TS1Ke2yr1f9azqJrtXe2RyDIazXjn8oFYjH/iQ0NVI5qSTQgSiCN7XIsc0P5FF1QaF1J0OycvAg
 a7Y1NrbrkMUlnY3C/s6vWjrVcIDlj+65mOwFAUPdE9/908I9+Wxr3trDsTEbbyM5D1NEFpIhqvP
 kIBLJ4SWnDQasUHC1nJXCj2BVKfRDUdfhOGMRhz6653ioDf0gAwIeNI58zjAOjDGasGv4o8TfbK
 nsoMJNbrypYMCcQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the dma_heap_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/dma-buf/dma-heap.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index 84ae708fafe7..bcca6a2bbce8 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -43,10 +43,18 @@ struct dma_heap {
 	struct cdev heap_cdev;
 };
 
+static char *dma_heap_devnode(const struct device *dev, umode_t *mode)
+{
+	return kasprintf(GFP_KERNEL, "dma_heap/%s", dev_name(dev));
+}
+
 static LIST_HEAD(heap_list);
 static DEFINE_MUTEX(heap_list_lock);
 static dev_t dma_heap_devt;
-static struct class *dma_heap_class;
+static struct class dma_heap_class = {
+	.name = DEVNAME,
+	.devnode = dma_heap_devnode,
+};
 static DEFINE_XARRAY_ALLOC(dma_heap_minors);
 
 static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
@@ -261,7 +269,7 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 		goto err1;
 	}
 
-	dev_ret = device_create(dma_heap_class,
+	dev_ret = device_create(&dma_heap_class,
 				NULL,
 				heap->heap_devt,
 				NULL,
@@ -291,7 +299,7 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 	return heap;
 
 err3:
-	device_destroy(dma_heap_class, heap->heap_devt);
+	device_destroy(&dma_heap_class, heap->heap_devt);
 err2:
 	cdev_del(&heap->heap_cdev);
 err1:
@@ -301,11 +309,6 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 	return err_ret;
 }
 
-static char *dma_heap_devnode(const struct device *dev, umode_t *mode)
-{
-	return kasprintf(GFP_KERNEL, "dma_heap/%s", dev_name(dev));
-}
-
 static int dma_heap_init(void)
 {
 	int ret;
@@ -314,12 +317,11 @@ static int dma_heap_init(void)
 	if (ret)
 		return ret;
 
-	dma_heap_class = class_create(DEVNAME);
-	if (IS_ERR(dma_heap_class)) {
+	ret = class_register(&dma_heap_class);
+	if (ret) {
 		unregister_chrdev_region(dma_heap_devt, NUM_HEAP_MINORS);
-		return PTR_ERR(dma_heap_class);
+		return ret;
 	}
-	dma_heap_class->devnode = dma_heap_devnode;
 
 	return 0;
 }

-- 
2.43.0


