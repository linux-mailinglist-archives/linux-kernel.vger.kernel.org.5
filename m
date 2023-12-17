Return-Path: <linux-kernel+bounces-2521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F3C815E6A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 11:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D7EA1C20FF3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 10:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2DE20E3;
	Sun, 17 Dec 2023 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eT8QXAqi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CB51FB2
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702807668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PwCXRxshfx8ZM0R5hK4eeYL2KSGd//EyP+jsBCrOQIw=;
	b=eT8QXAqibqd4+p4A+1OZuSsU6hWXPJl1lroLr35rw2Hku+Gj9EfNVw0eVaH8pMuwvVATT7
	DFyOLNpvJ1jL99QxYVZb+aIH+n3GEzKfNjxp8EqlXLBoTZuEDcBeBze+ZpPTMhTAtsNDqA
	2wcgNL/m9crN+ew3HlOBTmJhcBvNHK8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-KSiFvTZzOE-LJRNaSeHf0Q-1; Sun, 17 Dec 2023 05:07:46 -0500
X-MC-Unique: KSiFvTZzOE-LJRNaSeHf0Q-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33608b14b3cso1596254f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 02:07:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702807665; x=1703412465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PwCXRxshfx8ZM0R5hK4eeYL2KSGd//EyP+jsBCrOQIw=;
        b=ceK6qzU56AsbHiwGNp46rXgmKm76LmIBm0ZnmPhNdQe29CdEk4yh3c15uE2G2FBX4s
         ptW2aeWyNPenHIGl7DM8trU2B0nx7SzGNvcIM0A2mRMdlFyyUOhTaRvqFQv72W/VfzFE
         T0+frV1MvIjmH1yOvI6polyYxFUoo+4ILd7kH6oEGJQzEDsxHnl9Ntzgfxpc3X5PA2yK
         +7mQ5az5SHy/Yl1FQ28kr4eRhHoqqE9KYAhmLw2xI1UWrVbWa2MbuLzEAYW0xkrc2ZlA
         BJng1Kt2ZVnCSqSHrqRh9Sw0DlpS7WlpyxmK66sMkogs90aZH22gvds9hMMEo/7XQiLi
         t+0w==
X-Gm-Message-State: AOJu0YwJZIiq9UAQ9S9ww+wjHzzjO+3J4E1ucFkGbFvStvU1OpAamQmD
	vzm5ClVGilPL1kmU6oT4xr5mkj0znNJlIzytI+coK3yPRwDSK1g11jqDw/NM4GKSepaiF6Mm79C
	YOoI2D7MRtp7N9VC4npF5N8W1UacVtWYATgQGnq9DL4TOeNg0Y/sCNN1TyJHfsj8pECBDZ2OC5j
	AsN7h3Utg=
X-Received: by 2002:a05:600c:5012:b0:40c:6bfc:4bb1 with SMTP id n18-20020a05600c501200b0040c6bfc4bb1mr1982318wmr.38.1702807665121;
        Sun, 17 Dec 2023 02:07:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFr/dUnxatgvI3QmEkCMBXVdE2DJBX2ZugmD4z83PXtxRvr9gelZBQVfY9JdfW/nkdU7628ww==
X-Received: by 2002:a05:600c:5012:b0:40c:6bfc:4bb1 with SMTP id n18-20020a05600c501200b0040c6bfc4bb1mr1982297wmr.38.1702807664778;
        Sun, 17 Dec 2023 02:07:44 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w7-20020a05600c474700b0040c41846919sm30661883wmo.41.2023.12.17.02.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 02:07:44 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Peter Robinson <pbrobinson@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 0/2] drm/solomon: Add support for the SSD133x controller family
Date: Sun, 17 Dec 2023 11:07:02 +0100
Message-ID: <20231217100741.1943932-1-javierm@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patch-set adds support for the family of SSD133x Solomon controllers,
such as the SSD1331. These are used for RGB Dot Matrix OLED/PLED panels.

The patches were tested on a Waveshare SSD1331 display using glmark2-drm,
fbcon, fbtests and the retroarch emulator.

Patch #1 adds a DT binding schema for the SSD133x controllers and patch #2
extends the ssd130x DRM driver to support the SSD133x controller family.

Best regards,
Javier


Javier Martinez Canillas (2):
  dt-bindings: display: Add SSD133x OLED controllers
  drm/ssd130x: Add support for the SSD133x OLED controller family

 .../bindings/display/solomon,ssd133x.yaml     |  63 +++
 drivers/gpu/drm/solomon/ssd130x-i2c.c         |   5 +
 drivers/gpu/drm/solomon/ssd130x-spi.c         |   7 +
 drivers/gpu/drm/solomon/ssd130x.c             | 370 ++++++++++++++++++
 drivers/gpu/drm/solomon/ssd130x.h             |   5 +-
 5 files changed, 449 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd133x.yaml

-- 
2.43.0


