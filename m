Return-Path: <linux-kernel+bounces-18107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4194E8258FE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538CF1C232C0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC7E328B4;
	Fri,  5 Jan 2024 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I6ajNEEy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78830321A9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704475396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xBgR6EF/EirqUkTInXMLhcQ/iDbvWyd/X1PfgAKAIyE=;
	b=I6ajNEEyLUhnhTnmqTicSdPg2f2dPsD8T8jBZP7YtPP1dgCvsPk7sQFWVfyCIWCSUhbAkb
	CrDRPLvIqDFqLJmJOtz/d1AulUmy6lYPUA2rAc/7yb5vM1pA056EG0/PaKBH8Wm7XTQ2zt
	bwunMRjWvOy/arGRLL4JsL1iiYTkjRg=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-lEVl_tcJN1-FBVw7CkIWFA-1; Fri, 05 Jan 2024 12:23:15 -0500
X-MC-Unique: lEVl_tcJN1-FBVw7CkIWFA-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-4670ca688easo169587137.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 09:23:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704475394; x=1705080194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xBgR6EF/EirqUkTInXMLhcQ/iDbvWyd/X1PfgAKAIyE=;
        b=CMO7Mg1PKt8mPTLInnvDWxCu2VpIPEcw4x/r8WyJPwOVRJEb9Sq8wB5z29nW/gkE56
         natimtxfDY6Je+UkpXGlUKZqGL0NYiu+D7pbv5muOCTeDRXspjFSyitSWsfgYSAQMV2C
         oep58dyC9Nd1ElD62rj4H5TfgMCtlshIyZg+f0SnPFaaZP+DSEsTs2TrOq5+6y0FKzU9
         Cm9o+wAUsEgbnJD+b4sDHxNZaSrcM1QWMzCg2ypGDujd3/uxpOwCh7oTIWZ6wDJ6okrU
         U/bLllrxmpejK/pRDNRBk63fV63AoYySQWDEpx2S7//nxcQNF6xHRWOz6Ry3ockkhkt8
         /WtQ==
X-Gm-Message-State: AOJu0YwN5/dv2l+ou1wYhB2RHhBN8zMSfsZ+QmTRxFMC7/mM8OUzpmKK
	OMYyyF5KpNRdpQHKkgqI3XH6/BDkr2BX+0VGRIhpU9pYEzXap7noO/Pw3+eEqDAFnuqWTEFlAPK
	2XjCiBK6rkV379EExAQW60/0wFQp+eGEb
X-Received: by 2002:a67:ecda:0:b0:467:55c5:588 with SMTP id i26-20020a67ecda000000b0046755c50588mr4120295vsp.3.1704475394638;
        Fri, 05 Jan 2024 09:23:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTkGeaWdrkvk9vkGZOM8wRaOT8a6juJhCYrGyYaDRBNcd8dZEL/Cbb4G38NHhLuk+2Ph/AUQ==
X-Received: by 2002:a67:ecda:0:b0:467:55c5:588 with SMTP id i26-20020a67ecda000000b0046755c50588mr4120262vsp.3.1704475394262;
        Fri, 05 Jan 2024 09:23:14 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32d1:a900:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id t22-20020ac865d6000000b004282c862fccsm884750qto.57.2024.01.05.09.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 09:23:13 -0800 (PST)
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
Subject: [PATCH 1/2] platform_device: add devres function region-reqs
Date: Fri,  5 Jan 2024 18:22:18 +0100
Message-ID: <20240105172218.42457-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105172218.42457-2-pstanner@redhat.com>
References: <20240105172218.42457-2-pstanner@redhat.com>
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

Add the function devm_platform_get_resource()

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/base/platform.c         | 37 +++++++++++++++++++++++++++++++++
 include/linux/platform_device.h |  2 ++
 2 files changed, 39 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 10c577963418..243b9ec54d04 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -82,6 +82,43 @@ struct resource *platform_get_mem_or_io(struct platform_device *dev,
 }
 EXPORT_SYMBOL_GPL(platform_get_mem_or_io);
 
+/**
+ * devm_platform_get_and_resource - get and request a resource
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
+struct resource *devm_platform_get_resource(struct platform_device *pdev,
+		unsigned int type, unsigned int num, const char *name)
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
+EXPORT_SYMBOL_GPL(devm_platform_get_resource);
+
 #ifdef CONFIG_HAS_IOMEM
 /**
  * devm_platform_get_and_ioremap_resource - call devm_ioremap_resource() for a
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 7a41c72c1959..68e2857521f4 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -59,6 +59,8 @@ extern struct resource *platform_get_resource(struct platform_device *,
 					      unsigned int, unsigned int);
 extern struct resource *platform_get_mem_or_io(struct platform_device *,
 					       unsigned int);
+extern struct resource *devm_platform_get_resource(struct platform_device *pdev,
+		unsigned int type, unsigned int num, const char *name);
 
 extern struct device *
 platform_find_device_by_driver(struct device *start,
-- 
2.43.0


