Return-Path: <linux-kernel+bounces-19270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70704826A9A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E885EB21B8D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33DA13FF9;
	Mon,  8 Jan 2024 09:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V18Xy4s4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67E313FF0
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704705660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OT2gYV6QW0aw9hDO4YgXL/qxcf2YqqLjTuz//C31W+E=;
	b=V18Xy4s4kkGU14mVBIc4ecoafU1JKsRJXFIujoOwJVudg2ulJeDLJiaw1V+K9wD3+6DgEy
	HV3HhNTe8DpsnOe+jcyKfcX3C/Qvso+sJToXmBg9xXUup2q3PXEqwiREO++bUY3y38k5yO
	rb4xyJuXBhqyy1EfBZLvU/GHfzBzHPM=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-XRVMqmm8PHyN0kdktVEbxg-1; Mon, 08 Jan 2024 04:20:58 -0500
X-MC-Unique: XRVMqmm8PHyN0kdktVEbxg-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3bbbfe871afso426519b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 01:20:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704705658; x=1705310458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OT2gYV6QW0aw9hDO4YgXL/qxcf2YqqLjTuz//C31W+E=;
        b=uMnB9mfJ7Es/B00zsPmF48K7ORVEG8+tGwK7RqyvkK6qw+la0SgIlrjNtk9V86QG+r
         1YUlB4bhofVa46Bkg3/IQTBObPGDFFn8x3DuFM3/r7N7aeAoF4CzWckcPSyVuQRnjPw4
         hlWbOdF7WCyMBKSR/MCma+HFFmw3PSNq7EpuLUdAQL6pwJjJm1h9+oSYJyCRUeh1rJLI
         cS7eg/OQoKA0wGtf4o/e4pHPskcOYbNOhQE+FixfolYbj/RDOb/19aKZR/5uhtxNMvzG
         ApMaTIdhNnG+ldVNtL5xeorWRH846AOqJAhgIsPzvcnjWcmn6obSDKsP5V9oBdU6r9zf
         x2iA==
X-Gm-Message-State: AOJu0YwrGypazqGpXaeQN9kY/hbdsVWzYy/qGYs5Ag6fV5vq043rJGDB
	LhRa5xgj/3vmvc57pduBiBSaabDWil2NaXw1y7cwrj+qXwMsR3NEKr9ZYgkoYV/Z7ubj0WSL5Kq
	dFvVt+eGL+wB8ohz1q0DqQ+Hdadx7IUN5
X-Received: by 2002:a05:6808:b29:b0:3bd:1fe4:731d with SMTP id t9-20020a0568080b2900b003bd1fe4731dmr5145675oij.2.1704705658322;
        Mon, 08 Jan 2024 01:20:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEB1C15Fw6VGoZGz9oWNUFxUzMEbudyu27+vWQsCI2s0Rd1Z7xeT1ZpKC2PTY/Nx1IYLi86pQ==
X-Received: by 2002:a05:6808:b29:b0:3bd:1fe4:731d with SMTP id t9-20020a0568080b2900b003bd1fe4731dmr5145658oij.2.1704705658009;
        Mon, 08 Jan 2024 01:20:58 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id dm4-20020ad44e24000000b00680613267d5sm2732554qvb.115.2024.01.08.01.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:20:57 -0800 (PST)
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
Subject: [PATCH v2 2/2] drm/dcss: request memory region
Date: Mon,  8 Jan 2024 10:20:43 +0100
Message-ID: <20240108092042.16949-4-pstanner@redhat.com>
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

The driver's memory regions are currently just ioremap()ed, but not
reserved through a request. That's not a bug, but having the request is
a little more robust.

Implement the region-request through the corresponding managed
devres-function.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/gpu/drm/imx/dcss/dcss-dev.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/imx/dcss/dcss-dev.c b/drivers/gpu/drm/imx/dcss/dcss-dev.c
index 4f3af0dfb344..63dbb8d9c1b0 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-dev.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-dev.c
@@ -177,10 +177,11 @@ struct dcss_dev *dcss_dev_create(struct device *dev, bool hdmi_output)
 		return ERR_PTR(-ENODEV);
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "cannot get memory resource\n");
-		return ERR_PTR(-EINVAL);
+	res = devm_platform_get_and_request_resource(pdev, IORESOURCE_MEM, 
+						     0, "dcss");
+	if (IS_ERR(res)) {
+		dev_err(dev, "cannot get / request memory resource\n");
+		return res;
 	}
 
 	dcss = kzalloc(sizeof(*dcss), GFP_KERNEL);
-- 
2.43.0


