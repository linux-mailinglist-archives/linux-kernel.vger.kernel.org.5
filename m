Return-Path: <linux-kernel+bounces-20710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE778283DA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1122880E4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AE1364C7;
	Tue,  9 Jan 2024 10:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WgEeNCKB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2C1364B3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704795651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wy/M3ANrToiVi10PzVfO4hUq8Am1qDGx7AcrnHuqv94=;
	b=WgEeNCKBO2HW/jR1/4H+lkiEeHVCC53oEAxJoGB3k0ku0HjphWbJIS8esJ4G4qRpRZvQXq
	H3okOlh/4ZOb87Hx2KJ0bewd0tsebSSBhJKkfsOAc6YVxUSHn13g7snGALomGeT82i6n5W
	ErzCUSqECaSrsHhPdFKMDoSHCYYvwGE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-bjAebsWKMUumV8O4facrvg-1; Tue, 09 Jan 2024 05:20:45 -0500
X-MC-Unique: bjAebsWKMUumV8O4facrvg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-680b74cba78so8063756d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 02:20:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704795645; x=1705400445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wy/M3ANrToiVi10PzVfO4hUq8Am1qDGx7AcrnHuqv94=;
        b=vpfLbqe/IR+yAQgvZaUiwjZj36vN4N9hMrfCbPJF/qncH3Gn61U3ro/f2SXLQB7qrD
         7pan5ahakFhU10KY44jtCflRb1fGlUVTJfAJ8ughw8c6X+Ox3tozR0gwVijS23tjptY6
         lz6zEY7HrLMBWmBI+RXtewfLDDQ+8hIiLkuPv9RrXX5PPGmXPWTAsiH25l1CD+8H8lRY
         pA4iheytj1bdWehrpouHa2O6LOagj7YVbklNLD3PMU5zj7uJyAw8DPpr3NZZUlZdqXCS
         8CPt411vxZmbEmZvQ766tgMwXP1NgaQ9dPVQfMQczWG/PH+dNhlIrjteTjC5ovMDiFqW
         oZIQ==
X-Gm-Message-State: AOJu0Yy2qaaxot7QBs7pPUP32fZsTShxaD/ueK28tkkmcouAq3ZLJrlJ
	C3HWUpFazsBJcr5p7pFQEj58dA1N2ffStFZ8/iNC3ljwix4F+qBUoQui3zjgIEsmrE6w/cLx+m7
	ZaWQPGgQ/eS7/Tvm416yJQSgDPCzhU9t/
X-Received: by 2002:a05:620a:410a:b0:783:52a:25a0 with SMTP id j10-20020a05620a410a00b00783052a25a0mr10759993qko.3.1704795645168;
        Tue, 09 Jan 2024 02:20:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRJB76EgsOKxHrFXwYwzcFBNOSiztF/miafI4SjzA6CTawNFc6YBCvLUeclZxtDzc8bkApsQ==
X-Received: by 2002:a05:620a:410a:b0:783:52a:25a0 with SMTP id j10-20020a05620a410a00b00783052a25a0mr10759982qko.3.1704795644878;
        Tue, 09 Jan 2024 02:20:44 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id m24-20020ae9e018000000b00783217607d6sm679695qkk.115.2024.01.09.02.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 02:20:44 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v2 1/2] drm/dcss: request memory region
Date: Tue,  9 Jan 2024 11:20:31 +0100
Message-ID: <20240109102032.16165-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109102032.16165-1-pstanner@redhat.com>
References: <20240109102032.16165-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver's memory regions are currently just ioremap()ed, but not
reserved through a request. That's not a bug, but having the request is
a little more robust.

Implement the region-request through the corresponding managed
devres-function.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/gpu/drm/imx/dcss/dcss-dev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/imx/dcss/dcss-dev.c b/drivers/gpu/drm/imx/dcss/dcss-dev.c
index 4f3af0dfb344..1f93313c89b7 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-dev.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-dev.c
@@ -170,6 +170,7 @@ struct dcss_dev *dcss_dev_create(struct device *dev, bool hdmi_output)
 	struct resource *res;
 	struct dcss_dev *dcss;
 	const struct dcss_type_data *devtype;
+	resource_size_t res_len;
 
 	devtype = of_device_get_match_data(dev);
 	if (!devtype) {
@@ -183,6 +184,12 @@ struct dcss_dev *dcss_dev_create(struct device *dev, bool hdmi_output)
 		return ERR_PTR(-EINVAL);
 	}
 
+	res_len = res->end - res->start;
+	if (!devm_request_mem_region(pdev->dev, res->start, res_len, "dcss")) {
+		dev_err(dev, "cannot request memory region\n");
+		return ERR_PTR(-EBUSY);
+	}
+
 	dcss = kzalloc(sizeof(*dcss), GFP_KERNEL);
 	if (!dcss)
 		return ERR_PTR(-ENOMEM);
-- 
2.43.0


