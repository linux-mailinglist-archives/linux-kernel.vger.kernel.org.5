Return-Path: <linux-kernel+bounces-18108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055D08258FF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9291C23463
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44992347A4;
	Fri,  5 Jan 2024 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMyrg8a2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459D6328DB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 17:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704475400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2qUZvjVZIZkY/BqEpnbV7C2OUzTR+OzcQfnt1cm3UY=;
	b=LMyrg8a2MwnhXFbbeiJnUpt8Xgfm97dweKm06ThEs67XpnUNcXp4usbu6XTcpnF0IGIEHi
	AlJHuUHiUUhbQ0B92L5Qgkwc3sUKigOYmlxsow25Q5arh/Ekvmj4eck49s3ppdiRjOuXGI
	vI8nz7IrnEC2wD9P0Z8w4UjaGxyh5F8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-SlB6JFXJPpaydRIiUBl7iQ-1; Fri, 05 Jan 2024 12:23:18 -0500
X-MC-Unique: SlB6JFXJPpaydRIiUBl7iQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4277052412cso2250931cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 09:23:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704475398; x=1705080198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2qUZvjVZIZkY/BqEpnbV7C2OUzTR+OzcQfnt1cm3UY=;
        b=Dh4/xoTLUzwRSr35pXokGhlJMStmsHbXsHilKS3VxGoO0EYBObQ83tUhjFE729su+E
         6oZF0PT0VxhLYLuo5ENyz43gglp6EIkPaYMm10U6CNWeSk9WDEbutwewL2dX+zIpSjc1
         AfvG+gtAy4jt0YDmyypNRROQsDsQiaRyezVgYb6BjeDd9gRxIeurSkaNfjsH1E+QXTQ5
         dAKf1z8IU90stvsTdHY4qjM2A6xHz6yxE+UguSZpHrhGj2PfLpE33m5KLjc+ReKp3gXt
         uIP1WGfF1kapbeXd2+WSFiYfhMzTMQuuBMpmSwJqJItAg7FvcHSJ7X7RFQ5QiTWu6Zqr
         3EFQ==
X-Gm-Message-State: AOJu0YxzEhzaCixjxemQ8W8kXaF5y5Y07Nv8niQjjDOXbqFJNgb9nOdg
	19u8FTF4TX6WINzHJvKlA5cwzdHVsTAwztTyUXZ5Ns+goM5WZ64TDQz9mVMC/CQv5Tem6iZXO2h
	7109wQfy1rn2WN40twwxz71CkezIf/F8p
X-Received: by 2002:a05:622a:50:b0:428:2650:f3e2 with SMTP id y16-20020a05622a005000b004282650f3e2mr5249590qtw.5.1704475397794;
        Fri, 05 Jan 2024 09:23:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF532epDikfCQdMZTGaUEridQlW9l8yNvNyDw9n1OMG2UUu/mdbSu/2QfYbrZ833QqmwaxhCw==
X-Received: by 2002:a05:622a:50:b0:428:2650:f3e2 with SMTP id y16-20020a05622a005000b004282650f3e2mr5249572qtw.5.1704475397552;
        Fri, 05 Jan 2024 09:23:17 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32d1:a900:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id t22-20020ac865d6000000b004282c862fccsm884750qto.57.2024.01.05.09.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 09:23:17 -0800 (PST)
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
Subject: [PATCH 2/2] drm/dcss: request memory region
Date: Fri,  5 Jan 2024 18:22:19 +0100
Message-ID: <20240105172218.42457-4-pstanner@redhat.com>
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

The driver's memory regions are currently just ioremap()ed, but not
reserved through a request. That's not a bug, but having the request is
a little more robust.

Implement the region-request through the corresponding managed
devres-function.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/gpu/drm/imx/dcss/dcss-dev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/imx/dcss/dcss-dev.c b/drivers/gpu/drm/imx/dcss/dcss-dev.c
index 4f3af0dfb344..efd3a998652d 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-dev.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-dev.c
@@ -177,10 +177,10 @@ struct dcss_dev *dcss_dev_create(struct device *dev, bool hdmi_output)
 		return ERR_PTR(-ENODEV);
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "cannot get memory resource\n");
-		return ERR_PTR(-EINVAL);
+	res = devm_platform_get_resource(pdev, IORESOURCE_MEM, 0, "dcss");
+	if (IS_ERR(res)) {
+		dev_err(dev, "cannot get / request memory resource\n");
+		return res;
 	}
 
 	dcss = kzalloc(sizeof(*dcss), GFP_KERNEL);
-- 
2.43.0


