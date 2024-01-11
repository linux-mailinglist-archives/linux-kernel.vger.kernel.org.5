Return-Path: <linux-kernel+bounces-23369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EB982ABB6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3CCC287D95
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303E314F61;
	Thu, 11 Jan 2024 10:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKTkJoKP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3D014A85
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704968091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwPn8i5O4VeqDYOYi0h7MKwVZXEs2j45ok+yxqKOjYI=;
	b=AKTkJoKPrDl7HN18Vtl8bfz9sU3EUmiyhyCRCtHQMm509CQQWsz5wpCAYpMr/R8epS7ZAD
	6a3dIX07xUuHVJZnN2yeaPnrQiDkh8EhHhTUgXOE5Y9K+nRSjyAZocQtMTPJTFfWElRA40
	IjcL0RSG94Zl+R34r1xh8kiGzBPTTYY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-yzcp9MlsMlavUBK-jL8aWw-1; Thu, 11 Jan 2024 05:14:50 -0500
X-MC-Unique: yzcp9MlsMlavUBK-jL8aWw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-427cc7d3617so8169701cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:14:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704968090; x=1705572890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwPn8i5O4VeqDYOYi0h7MKwVZXEs2j45ok+yxqKOjYI=;
        b=nkwfZaalVzhnFYhOz1dVTzBDlXfEAI+wjHMp8N3IXFH+S5fRbXQFhdleGXu43P3Vn3
         kNPisdeellYLY18Yec/5LhqDkx/YhhE0P95vCBwLaoWhZUoBU4+iKuLbJvjWk9mI3Vjb
         0bAurqnCZM7k6NtZz76JJwHB/vpkM8covUwam79w4tJ5SOKDyVTir+NJFXh0vVVJm+84
         JkXxyw+Y5Pgd36utP6SFwVDUA/OAWuzK5z1tFsl/TwgyQdnCJnjv4ncVxxcMriXxBfa0
         nOH2mbtJgujNVQaIKW7hScjaG582DssRsb5i9gCaj281pjjZH+ZcJDp6m5bEtHqfo1ue
         8E3g==
X-Gm-Message-State: AOJu0YwO0+r5+HdKBwyEl/Lhdtg4usAKGTskPAQBxY9yVO2Uqg3f5JY2
	cMkiIrmlxi/cVwroREt825/tF/RcWipplYqIP3vZHKFkU4dYCT90tdlbx6ebr+jGBfzxaw2S/sW
	iZ06m2KESKy4T48wmd87vkEDBhPC/SER4
X-Received: by 2002:a05:622a:c3:b0:429:c64e:bbf2 with SMTP id p3-20020a05622a00c300b00429c64ebbf2mr721888qtw.1.1704968090082;
        Thu, 11 Jan 2024 02:14:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVQIy0jo0pMVepzO0+SBQFVp2mhz3xvRaaT4o8KZrz1F6USNhJpdkki0vHfUo+Wzodq5ZSLg==
X-Received: by 2002:a05:622a:c3:b0:429:c64e:bbf2 with SMTP id p3-20020a05622a00c300b00429c64ebbf2mr721872qtw.1.1704968089859;
        Thu, 11 Jan 2024 02:14:49 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id eo7-20020a05622a544700b0042993549c3asm313237qtb.32.2024.01.11.02.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 02:14:49 -0800 (PST)
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
Subject: [PATCH v3 1/2] drm/imx/dcss: request memory region
Date: Thu, 11 Jan 2024 11:13:46 +0100
Message-ID: <20240111101346.15193-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111101346.15193-2-pstanner@redhat.com>
References: <20240111101346.15193-2-pstanner@redhat.com>
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
index 4f3af0dfb344..d448bf1c205e 100644
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
+	if (!devm_request_mem_region(dev, res->start, res_len, "dcss")) {
+		dev_err(dev, "cannot request memory region\n");
+		return ERR_PTR(-EBUSY);
+	}
+
 	dcss = kzalloc(sizeof(*dcss), GFP_KERNEL);
 	if (!dcss)
 		return ERR_PTR(-ENOMEM);
-- 
2.43.0


