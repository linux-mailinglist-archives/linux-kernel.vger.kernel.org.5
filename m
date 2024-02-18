Return-Path: <linux-kernel+bounces-70547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6309985990D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4EBC1F2149A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237DB745CE;
	Sun, 18 Feb 2024 19:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="jxr11Znv"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A3171B2B;
	Sun, 18 Feb 2024 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708283868; cv=none; b=sPWO6+xAIchFPvGSaTn5+LSaHbNTUGLCypLPvrPvy2WXuOD0S+knwxTxkI5nmwkuYsWcCop2K/9eJYPdLRdtnu4ff58Tp3zg1Ps4/S1IpwoLIpw7nJUNi/Bv16cR1u9RgSeh8m1VxiiEKvm2mhoLlJKk3S5vhnV3OzDps7goXvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708283868; c=relaxed/simple;
	bh=PlDZ/DQXM/07PMDcTyBhIrDP9W36zYqNuPUo0TzKbvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pWVhib8L8yiajBboNLyWo3fL4EMuK85PXBbuRTkpAN47pbPGUIYWISB5hVrRoflN0TBSiI09p/zSOcEEr2ovRvLf2DzGc6rkEWpWlUXCqcqZQiNtNDt+h6qWhqkIre3k7923GiL5Jzm/488pfX4zf6+o/5ISYM2cQbTxJA6BCW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=jxr11Znv; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59d7cbf1279so2313273eaf.2;
        Sun, 18 Feb 2024 11:17:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708283866; x=1708888666;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vQNRYm3ukxsOLCb4b7JJwL+j5XGiWOnosPqQUAzHJIQ=;
        b=bxyI0iNH9wH7eQpyHy6QXkFsnjLvRT4PtANswm+WQpQ1V8uwxdILlif3/F3yZ45ycY
         OkCPDKr8ObPY9iAWSBnWgoaPThuPbDKYEmjB3/sT68pA+RF0UwLAQuCr951rzn37a0/r
         ellZxVEBCGmiomB6E08osLq/XFklXnudoq3sjd8FrBIQMz+OwwOSBMtaMmWV48UakciO
         vBv7lg8ivBHd/hWT/QnKPRhOVTIz08up/J5EE+QpZV1ecoj658ygrvp6trvZGHWNAen8
         k36lM0BkG8suyawg75mbxd/aO8RPDsth5WkwCxxx49kkh3UaLdWAZ+9MsQIRZ7X40PTC
         IIgw==
X-Forwarded-Encrypted: i=1; AJvYcCVY8w7quQkQxoD2VlJq01A7pm65fHr+cQSEMFw/J7hyZCOAu+prKCz1JgchhVRFDLG9OKoGbaKyTXTFsPl88LUFfv7O43+voyMHw5P/
X-Gm-Message-State: AOJu0YxzrBZc6S+l1sa8vt9BZBgk5O2n+vVk5FKMufOfISz32C5I6taY
	RLfNr77FrPa12Fg6pkgBKuF+bW8MnS0l8/3IaorUXyk+QpvtgfEq
X-Google-Smtp-Source: AGHT+IHNSBDdixhtzL9S51bmQvSdYOHfw8Jh+BFGmARn/5r61F82/KS6NNVeKhUD8UcHzpqeAomupg==
X-Received: by 2002:a05:6358:63a2:b0:178:b7c0:323f with SMTP id k34-20020a05635863a200b00178b7c0323fmr12456899rwh.19.1708283865667;
        Sun, 18 Feb 2024 11:17:45 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id p21-20020aa78615000000b006e0949b2548sm2634422pfn.209.2024.02.18.11.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 11:17:45 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708283864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vQNRYm3ukxsOLCb4b7JJwL+j5XGiWOnosPqQUAzHJIQ=;
	b=jxr11ZnvAo4cR83d6om9WnVVOUns/mfSWeHif+O75tci1hSFO8RfZ8Op/hwvqqh+01nE2/
	95WQTinlCXTX2v7qbqFfxj33V+g026d9ixsPkn3/+dH552dokspiuT7x/BbhTo6jpcJu4h
	Dd2LvJDrp8qXO+ZjDWR9NSVTCjYUMweQA6g7jTkZAcFUjXIe04UbSkdIK1OZRkfOtBQ8A+
	SDM/vGT340u7flzNWJIGYPvSUTeF2jJTi5rEJ9649q7+X71dcdOheRNhIr4ninfFwsE3gz
	+b85WgFSovQ7OVEz8nPm3248+GYog+GFpLA5tJlO0AUF10nQnCVpUcrCHw4M0g==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 18 Feb 2024 16:18:12 -0300
Subject: [PATCH 4/4] usb: core: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-device_cleanup-usb-v1-4-77423c4da262@marliere.net>
References: <20240218-device_cleanup-usb-v1-0-77423c4da262@marliere.net>
In-Reply-To: <20240218-device_cleanup-usb-v1-0-77423c4da262@marliere.net>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3413; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=PlDZ/DQXM/07PMDcTyBhIrDP9W36zYqNuPUo0TzKbvE=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl0lf1mygX1QLxHNFMAm/dvDIotCaFbkuZjMfCB
 AtIDT8fKbeJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdJX9QAKCRDJC4p8Y4ZY
 pjfYD/49rP6j1XNXmK3NjDC1kryNy/X232I7AlecWd+LG6BquAUQA1H/l/STXE6NccXSXdK5SOE
 4Db5GT6YeX2Vh6VF02/wUDXUMqVtdWyq0tyRgUKJ872+T2KFM+jcgMIfyi7Urg7EwTJ029CgYIZ
 dBjZAdLKk1AZr2CzoRUzxPi+dMbE8Ah0qWghMU4Lg67ift1V9FDuApGQaIFKaRiqDDehdptmGaF
 v7aIEwsXbbqOfvbWLcMz4ncJv32fhA0UwxT8qCTUZ3+P1ClXC45ycsJV3X27pfC44Oej7OpUeEc
 lSP4/iryIyy3UqTmmiFFS/g+Ud4eTaJNMKsSL6AY49DcRzywrS5kO/7+SuW7AvecMnTNMs1SLX0
 ktGt8125IK658Bsde2d8lQ9YEeu5OSM118abbTg9lDwKTpbP02kI0iFO7TtA2ISXcOjWf8Nb1cu
 7jCs+o3AlTcC6kDzNJ4tObqUDuT/czEDRLUDdG8T8xpHCccKVj3tHMwCscP80cuC5E/D1sne/wQ
 /NjjjwJytBmFcsuLTZQaQG1K0GSyM3MBzSdNUVRhhVmrUnsNk30dCmI+QaTfWrgrFvYx8tFaSJE
 Pk0IYISliJNTyIrsBrJfbgq74gAIzXRYXYW/N5PF8bBTa6El1IRuYcq+hJr/gQ1X4PRK6DuPZVJ
 s3Pgt9Q3AEkiH1w==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the
usb_device_type, usb_if_device_type, usb_ep_device_type and
usb_port_device_type variables to be constant structures as well, placing
it into read-only memory which can not be modified at runtime.

Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/usb/core/endpoint.c | 2 +-
 drivers/usb/core/message.c  | 2 +-
 drivers/usb/core/port.c     | 2 +-
 drivers/usb/core/usb.c      | 2 +-
 drivers/usb/core/usb.h      | 8 ++++----
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/core/endpoint.c b/drivers/usb/core/endpoint.c
index a2530811cf7d..4b38b87a1343 100644
--- a/drivers/usb/core/endpoint.c
+++ b/drivers/usb/core/endpoint.c
@@ -141,7 +141,7 @@ static void ep_device_release(struct device *dev)
 	kfree(ep_dev);
 }
 
-struct device_type usb_ep_device_type = {
+const struct device_type usb_ep_device_type = {
 	.name =		"usb_endpoint",
 	.release = ep_device_release,
 };
diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 077dfe48d01c..67316d271596 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1849,7 +1849,7 @@ static int usb_if_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
-struct device_type usb_if_device_type = {
+const struct device_type usb_if_device_type = {
 	.name =		"usb_interface",
 	.release =	usb_release_interface,
 	.uevent =	usb_if_uevent,
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index c628c1abc907..84d36172b040 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -429,7 +429,7 @@ static const struct dev_pm_ops usb_port_pm_ops = {
 #endif
 };
 
-struct device_type usb_port_device_type = {
+const struct device_type usb_port_device_type = {
 	.name =		"usb_port",
 	.release =	usb_port_device_release,
 	.pm =		&usb_port_pm_ops,
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index dc8d9228a5e7..a0c432b14b20 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -592,7 +592,7 @@ static char *usb_devnode(const struct device *dev,
 			 usb_dev->bus->busnum, usb_dev->devnum);
 }
 
-struct device_type usb_device_type = {
+const struct device_type usb_device_type = {
 	.name =		"usb_device",
 	.release =	usb_release_dev,
 	.uevent =	usb_dev_uevent,
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index bfecb50773b6..b8324ea05b20 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -144,10 +144,10 @@ static inline int usb_disable_usb2_hardware_lpm(struct usb_device *udev)
 extern const struct class usbmisc_class;
 extern const struct bus_type usb_bus_type;
 extern struct mutex usb_port_peer_mutex;
-extern struct device_type usb_device_type;
-extern struct device_type usb_if_device_type;
-extern struct device_type usb_ep_device_type;
-extern struct device_type usb_port_device_type;
+extern const struct device_type usb_device_type;
+extern const struct device_type usb_if_device_type;
+extern const struct device_type usb_ep_device_type;
+extern const struct device_type usb_port_device_type;
 extern struct usb_device_driver usb_generic_driver;
 
 static inline int is_usb_device(const struct device *dev)

-- 
2.43.0


