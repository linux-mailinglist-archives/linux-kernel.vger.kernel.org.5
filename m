Return-Path: <linux-kernel+bounces-19271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5572A826A9B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CADD1C21E35
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550DB14013;
	Mon,  8 Jan 2024 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQJb9I9j"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433EC13FED
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704705662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=arbdXlZxmXJOFEKJF2R1zNrEF3q6fd9QYRmRT41BVKs=;
	b=TQJb9I9j6/7hbwQeb/wFmek7SeqDCADNKmhpbpxgdYsECjU4rh6MA2/n6a5WqASn9IdgAp
	BZGj5gErIt2AVELcLkDafrKu/lRvKZjuxAJAzyegXZkDfHuUW/23lsXCOhVI5QdzOD5psX
	Uv2umGx9a0cLB+yEsQAxOZkN19WIgWg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-6LY5NC2iP8mqumGGCBsoxA-1; Mon, 08 Jan 2024 04:20:55 -0500
X-MC-Unique: 6LY5NC2iP8mqumGGCBsoxA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-42989eb8897so2846731cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 01:20:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704705655; x=1705310455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=arbdXlZxmXJOFEKJF2R1zNrEF3q6fd9QYRmRT41BVKs=;
        b=JpYF09Qia3T10pHXTfMzCk8NMDJqexfwJzyO6PXBNyRwEXMwhcIBdb94i8GxQcYt1s
         2zTw6Na3cYVgl3hb2vFw997gCKLrrH/iEzjVMK8Adzg0I6NjLS4oANXbc4DR9VS67GMr
         NSgymJuoJ+gMH679G5ajAAMA8yFGAE3TVB11cFXz4yFDAwy/epeyE7rvSQEMCavIxt+V
         zFhlTaOIJ+WTPOxlQVRDkRYhJaH1yr8ibmATzai1+z9TlpIAi5jB6ebSPJQgrRqelGlc
         +BQ1Lx5Q74KXyaiBiZ1+7QpwiTv/JWuMuuNL+YG1ui8YMP1UGVg4fgw2FAkIV36PiEXE
         kGCA==
X-Gm-Message-State: AOJu0Yy6sQXrZ759Ly8bU9at68fYru8NuJdHEI9TrXTNqsc+JaME8L5M
	9YeL0ukuN+BGm2PwW9lqdMXEX+4uiHP6mgydoybnpohUsU8ug7WBEKXaQuxls+hvtp7AT68tCy9
	xZfS1C1Kc7Qxob+GDghASX4Pzco6NVWqV
X-Received: by 2002:a05:6214:19c5:b0:67f:4c05:4d34 with SMTP id j5-20020a05621419c500b0067f4c054d34mr6990908qvc.5.1704705655233;
        Mon, 08 Jan 2024 01:20:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnK+XpKlzV2pJwpxp9WnHxnhGBrqDUDY4SuSe10hNQMzlz0sxl/7oEnH6B+hqyoG0C8qKDAg==
X-Received: by 2002:a05:6214:19c5:b0:67f:4c05:4d34 with SMTP id j5-20020a05621419c500b0067f4c054d34mr6990895qvc.5.1704705654917;
        Mon, 08 Jan 2024 01:20:54 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id dm4-20020ad44e24000000b00680613267d5sm2732554qvb.115.2024.01.08.01.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:20:54 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	David Gow <davidgow@google.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v2 1/2] platform_device: add devres function region-reqs
Date: Mon,  8 Jan 2024 10:20:42 +0100
Message-ID: <20240108092042.16949-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108092042.16949-2-pstanner@redhat.com>
References: <20240108092042.16949-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some drivers want to use (request) a region exclusively but nevertheless
create several mappings within that region.

Currently, there is no managed devres function to request a region
without mapping it.

Add the function devm_platform_get_resource().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/base/platform.c         | 38 +++++++++++++++++++++++++++++++++
 include/linux/platform_device.h |  3 +++
 2 files changed, 41 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 10c577963418..7b29e6da31ae 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -82,6 +82,44 @@ struct resource *platform_get_mem_or_io(struct platform_device *dev,
 }
 EXPORT_SYMBOL_GPL(platform_get_mem_or_io);
 
+/**
+ * devm_platform_get_and_request_resource - get and request a resource
+ *
+ * @pdev: the platform device to get the resource from
+ * @type: resource type (either IORESOURCE_MEM or IORESOURCE_IO)
+ * @num: resource index
+ * @name: name to be associated with the request
+ *
+ * Return: a pointer to the resource on success, an ERR_PTR on failure.
+ *
+ * Gets a resource and requests it. Use this instead of
+ * devm_platform_ioremap_resource() only if you have to create several single
+ * mappings with devm_ioremap().
+ */
+struct resource *devm_platform_get_and_request_resource(
+		struct platform_device *pdev, unsigned int type,
+		unsigned int num, const char *name)
+{
+	struct resource *res;
+
+	res = platform_get_resource(pdev, type, num);
+	if (!res)
+		return ERR_PTR(-EINVAL);
+
+	if (type & IORESOURCE_MEM)
+		res = devm_request_mem_region(&pdev->dev, res->start, res->end, name);
+	else if (type & IORESOURCE_IO)
+		res = devm_request_region(&pdev->dev, res->start, res->end, name);
+	else
+		return ERR_PTR(-EINVAL);
+
+	if (!res)
+		return ERR_PTR(-EBUSY);
+
+	return res;
+}
+EXPORT_SYMBOL_GPL(devm_platform_get_and_request_resource);
+
 #ifdef CONFIG_HAS_IOMEM
 /**
  * devm_platform_get_and_ioremap_resource - call devm_ioremap_resource() for a
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 7a41c72c1959..44e4ba930d5f 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -59,6 +59,9 @@ extern struct resource *platform_get_resource(struct platform_device *,
 					      unsigned int, unsigned int);
 extern struct resource *platform_get_mem_or_io(struct platform_device *,
 					       unsigned int);
+extern struct resource *devm_platform_get_and_request_resource(
+		struct platform_device *pdev, unsigned int type,
+		unsigned int num, const char *name);
 
 extern struct device *
 platform_find_device_by_driver(struct device *start,
-- 
2.43.0


