Return-Path: <linux-kernel+bounces-84533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B165786A7F6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11C51C22DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906BA210FB;
	Wed, 28 Feb 2024 05:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="mU3fbw12";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="HbBP3Ld8"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B1C20DEB
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 05:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709097718; cv=none; b=MmYLIpkoeLuvLQuHbgTvlK9pKanOtLRE7eervvwZuqa4J2S9+k/8MKmQuNCh/LI6htheu+QRhbL3SgrR5gCuCn9HLvhH4aykzg8IE2WBgOspEMhOGAIYxBBxepejiNdtmT1JcCEM6wiXgZqGZ6XGc0aBZEwamf64nZrDoIvzVm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709097718; c=relaxed/simple;
	bh=hag+kUREN7099AQsZeDg4yMNi/Oqegb9LMqtaO2yh/A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kMSkcoAk6VJJpYt03qnSdrsoMBibEpcU6LyjVxmtK7uPM7PPgZm5gXl/K4L/6yH4NGAx2yi2DoE/q5tu8n1f/stY12vAMIKsjW68nl684Bt5lHwkYkxQ632zYIk8NaHxI5MY+uuLwvH2WJ1J8V7PNRGtr5j0R+AATt8PZogQfKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=mU3fbw12; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=HbBP3Ld8; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1709097198;
	bh=hag+kUREN7099AQsZeDg4yMNi/Oqegb9LMqtaO2yh/A=;
	h=From:To:Cc:Subject:Date:From;
	b=mU3fbw12GXb/xsYE687cZCGU/q9KOfEZXCrK+IRRUYS64LSeLMoiHOIIXBgSaIAXl
	 aIBSgBQGEAAGx3jwY674Ri7J2T2qlmn5MkgdlzVnLfmiMct2gdyy5eI9Z2N+Tpyb1H
	 jlbzVH69qDG2Ncg8QF+GTnI/iCo6Js6dk5u0LyeOaoa/rxQlwzwCqMEL220h50djkB
	 nTYAOJVGRTQtEH8VrsTiFoN7N++P/8pwPTfCdn0duM/nImGpoGRqLvjlJmXxepn7M7
	 ZsH5/xIbv6LxMGGRkFZXd4eilssap0u8eQDDDdX3h0x1LPwbhdVh6DjHOhrKJFoNj3
	 asPKfGFicT5iA==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 48F42B81
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:13:18 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=HbBP3Ld8;
	dkim-atps=neutral
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 028FCA45
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:13:17 +0900 (JST)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3c1a40c48aeso3309723b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1709097195; x=1709701995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T5JD7ecTzwpeJkCMc8dbndbZzwY4gmo8GDlf+AKuHv8=;
        b=HbBP3Ld82AEEQkV3hgL3OqZvmusQL2OmS+YxdCXtr2DO/cs5Y9sCLj3GKcLj+jK2Bc
         oVVmgOe66yupvDqtImsMk+PUMRcP9k5NZYCTZFmqw+5GvMHKzC0s/cA00D20XtIIBtml
         +wS1QIrZj8Kg88mO3hUNYYZQOl3YxtqdK+j4UtfyFAGCHNuM3Y3+7f38pkEXcoHxXj59
         UYvsRvSaZnAz8Cw8EGCOtmPaIean/UoiH5NHkT93FHDu1WqZgA7h9zvb+IbMPVx9FaCf
         KToaA4gED1RgbN3UoNihTAD+VINrVi1TUJM+mN8VVyOJFKvyTF/9wZuMf8ocpplOrcZt
         3FTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709097195; x=1709701995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5JD7ecTzwpeJkCMc8dbndbZzwY4gmo8GDlf+AKuHv8=;
        b=AEz4gaxYRPgK0Z5ihVG38CgJEbg/zAoo1Shs5ZEGrDp6GJLrn3m1W6kijbXH8V19/T
         gXEcqImSr43ZQP/SDGpyjvUAF6Ducors5V/3WspIK4YhUl1A1R0Gk4RWcT5EygW669c3
         MjXWtU3SMmj1vH6L62EH1zR/9Llt0kfGkqQ6IL43yDwe6G94Z8xLbwlC2gCjfokL8NDc
         DNvi8Y0TfSDCY3Ah6QBH+R2VXal9TU3xXPHyJLe190HKiz9Y+iazqnCUTzYopVUVvkXv
         PTQvlDfLOALd4p+kft8wu/LpfummrEyA42YAg692xKHpu5SspBX0hgMCBQrBkaAMyK6Y
         FDGA==
X-Forwarded-Encrypted: i=1; AJvYcCWTJsNeYsoncA3YPXYoy/W2DN4qJTV7yoU9o2mDwSy9jWgNVFym9XVntTML0bmbblCEqxUzTHi7ck8HiZd+NjeI6sQh/RDhr2j4Da+X
X-Gm-Message-State: AOJu0YzYl82JScEi2WU1flrUaUGIw/ow2y084cI8zXO3cwl6rQjlIWXX
	Y404S7UQp+hGpmM4NesrMDVBGUojGuo0uUtMUNEzpRe6lq1p2QWLUZ3gPyFF1PC1aRNQuQs3GuL
	0lgs4tsDKPb6VD4ecQwtbWNznczcWMZAw9YDb5UbWmzFTsfKID59k73oy02tLA3M=
X-Received: by 2002:a05:6808:23ce:b0:3c1:ae1d:6f2 with SMTP id bq14-20020a05680823ce00b003c1ae1d06f2mr4509898oib.7.1709097195708;
        Tue, 27 Feb 2024 21:13:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFT9V8+kOD8C+u3gkW+7qF1bb24v14baBPE9HkQL13QPLLJze87Xvo/ppu75bTP7cbuo+fsBw==
X-Received: by 2002:a05:6808:23ce:b0:3c1:ae1d:6f2 with SMTP id bq14-20020a05680823ce00b003c1ae1d06f2mr4509879oib.7.1709097195373;
        Tue, 27 Feb 2024 21:13:15 -0800 (PST)
Received: from pc-0182.atmarktech (162.198.187.35.bc.googleusercontent.com. [35.187.198.162])
        by smtp.gmail.com with ESMTPSA id h22-20020aa786d6000000b006e089bb3619sm6849540pfo.112.2024.02.27.21.13.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Feb 2024 21:13:14 -0800 (PST)
Received: from [::1] (helo=pc-0182.atmark.tech)
	by pc-0182.atmarktech with esmtp (Exim 4.96)
	(envelope-from <dominique.martinet@atmark-techno.com>)
	id 1rfCFl-00GjY5-1o;
	Wed, 28 Feb 2024 14:13:13 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Syunya Ohshio <syunya.ohshio@atmark-techno.com>,
	=?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dominique Martinet <dominique.martinet@atmark-techno.com>
Subject: [PATCH] iio: industrialio-core: look for aliases to request device index
Date: Wed, 28 Feb 2024 14:12:54 +0900
Message-Id: <20240228051254.3988329-1-dominique.martinet@atmark-techno.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Syunya Ohshio <syunya.ohshio@atmark-techno.com>

When using dtb overlays it can be difficult to predict which iio device
will get assigned what index, and there is no easy way to create
symlinks for /sys nodes through udev so to simplify userspace code make
it possible to request fixed indices for iio devices in device tree.

For platforms without device trees of_alias_get_id will just fail and
ida_alloc_range will behave as ida_alloc currently does.

For platforms with device trees, they can not set an alias, for example
this would try to get 10 from the ida for the device corresponding to
adc2:
aliases {
  iio10 = &adc2
};

To: Jonathan Cameron <jic23@kernel.org>
Cc: Guido Günther <agx@sigxcpu.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Syunya Ohshio <syunya.ohshio@atmark-techno.com>
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---

Hello! We are facing an issue on one of our device where iio devices
aren't numbered as we'd like in some situations, and I feel like we
could do better than the only alternative I found of making symlinks
directly to /sys in /dev as e.g.
https://git.toradex.com/cgit/meta-toradex-bsp-common.git/tree/recipes-core/udev/files/verdin-imx8mm/toradex-adc.sh?h=kirkstone-6.x.y

Ultimately we'd just like to able to designate a stable path for our
users to use in their application and tell them it won't change even if
we fiddle with the overlays a bit, which is a problem we had as current
init is done in whatever order device tree nodes are processed, and that
in turn depends on how the overlays are applied.
If you can think of a better way of doing it then we'll be happy to
consider something else.
Otherwise aliases seem like it could do a good job, and isn't too
surprising for users - the main downside I can see would be that it
doesn't help platforms without device trees but I honestly don't see
what would work well in a more generic way -- looking at
/sys/bus/iio/devices/iio:deviceX/name to decide what we're looking at
is a bit of a hassle.

Thanks!


 .../devicetree/bindings/iio/common.yaml         |  9 +++++++--
 drivers/iio/industrialio-core.c                 | 17 ++++++++++++++++-
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/common.yaml b/Documentation/devicetree/bindings/iio/common.yaml
index b3a10af86d76..23d4c3012aeb 100644
--- a/Documentation/devicetree/bindings/iio/common.yaml
+++ b/Documentation/devicetree/bindings/iio/common.yaml
@@ -12,13 +12,18 @@ maintainers:
 
 description: |
   This document defines device tree properties common to several iio
-  sensors. It doesn't constitute a device tree binding specification by itself but
-  is meant to be referenced by device tree bindings.
+  sensors. It doesn't constitute a device tree binding specification by itself
+  but is meant to be referenced by device tree bindings.
 
   When referenced from sensor tree bindings the properties defined in this
   document are defined as follows. The sensor tree bindings are responsible for
   defining whether each property is required or optional.
 
+  Note: it is also possible to request an index for the iio device through the
+  "aliases" device tree node. It is however only used as a hint so care should
+  be taken to either set all devices, or set indices in a range that will not
+  be used by devices without aliases.
+
 properties:
   proximity-near-level:
     $ref: /schemas/types.yaml#/definitions/uint32
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 173dc00762a1..0f088be3a48c 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/poll.h>
 #include <linux/property.h>
 #include <linux/sched.h>
@@ -1644,6 +1645,7 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	struct iio_dev_opaque *iio_dev_opaque;
 	struct iio_dev *indio_dev;
 	size_t alloc_size;
+	int iio_dev_id;
 
 	alloc_size = sizeof(struct iio_dev_opaque);
 	if (sizeof_priv) {
@@ -1667,7 +1669,10 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	mutex_init(&iio_dev_opaque->info_exist_lock);
 	INIT_LIST_HEAD(&iio_dev_opaque->channel_attr_list);
 
-	iio_dev_opaque->id = ida_alloc(&iio_ida, GFP_KERNEL);
+	iio_dev_id = of_alias_get_id(parent->of_node, "iio");
+	iio_dev_opaque->id = ida_alloc_range(&iio_ida,
+					     iio_dev_id < 0 ? 0 : iio_dev_id,
+					     ~0, GFP_KERNEL);
 	if (iio_dev_opaque->id < 0) {
 		/* cannot use a dev_err as the name isn't available */
 		pr_err("failed to get device id\n");
@@ -1681,6 +1686,16 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 		return NULL;
 	}
 
+	/* log about iio_dev_id after dev_set_name() for dev_* helpers */
+	if (iio_dev_id < 0) {
+		dev_dbg(&indio_dev->dev,
+			"No aliases in fw node for device: %d\n", iio_dev_id);
+	} else if (iio_dev_opaque->id != iio_dev_id) {
+		dev_warn(&indio_dev->dev,
+			 "Device requested %d in fw node but could not get it\n",
+			 iio_dev_id);
+	}
+
 	INIT_LIST_HEAD(&iio_dev_opaque->buffer_list);
 	INIT_LIST_HEAD(&iio_dev_opaque->ioctl_handlers);
 
-- 
2.39.2



