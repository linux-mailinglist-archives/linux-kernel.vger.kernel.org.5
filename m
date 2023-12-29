Return-Path: <linux-kernel+bounces-13056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B80FE81FF15
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 12:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21FD7283360
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 11:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC421118E;
	Fri, 29 Dec 2023 11:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2vw8F5X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F4710A1C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703848834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d3KNTkAHMEq6kRnLdtQoUQE4cKQn8zc78RB5qaLNfps=;
	b=J2vw8F5Xn7HPWrlohulLK5HsK3290yElhIo7Z+Nbwe4Iahv5BOmTXOo7uFxZo4T4puBe3h
	j/AZqjcUVzJQBISaqAI6B6WH7SIGE+dVvutIo66a6C2ZFh+ZBy7Emo3UXFg3XWKIk+pmVe
	xnHrTmP494SbvAB8LHLhodZZBOjnUgk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-NyMzKxuQMPKw7h1rjP5Now-1; Fri, 29 Dec 2023 06:20:33 -0500
X-MC-Unique: NyMzKxuQMPKw7h1rjP5Now-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50e86a0debcso2105324e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 03:20:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703848831; x=1704453631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d3KNTkAHMEq6kRnLdtQoUQE4cKQn8zc78RB5qaLNfps=;
        b=VePljNdMx7/lzI0EyD/YIL1QikZnF25b/so6EVaTgD4iyVzvWLERk+8WCUiNXlHbPh
         u4gq1y45Pg2UFHTgpSKpf17XVR6QXYbomDxAeISME9Tt+OXu4kSDV9Ab1DyV+yFjZFog
         zyIQj3pOgYXvoH/gmVvxzZURw7v/d1WxA1W9BMWqKUpCtUvlXzLbFF4QNRug9x1H9CMd
         Wx5TUKxHXwKRBrSLQGBKfClrPsb2SsVugCYlxm6u5sfqZ00KVnOMPbCcol3sKofhKGn2
         zGgxTIhzLmPXyZcnL6N8KlUwIAtUM8t2Ecs+5pDZjdrPR4jkEyaeP/fnXNv4NoFYzRrJ
         WAXA==
X-Gm-Message-State: AOJu0YxAdexH8HDXN+YrQ7LckJGN7Ku3cXp4Zwh6QyCB39+PK6tzq6Vn
	3uGm0MumhoxmQy6MDsLv+3ltLhFCEYARvuIP+hQ5G9v47skdim5GRngpBqao8pz0d1+bR3/hHRW
	JFFU14DyqqS8/FnrmeORnoQ4qzCF8Eoz/mPe/MfC0lh1KX89He2ffrobWHPx6NB2ffCmYbjVLIs
	bdF4LQ1jbj1NbgHig=
X-Received: by 2002:ac2:47e6:0:b0:50e:7702:a189 with SMTP id b6-20020ac247e6000000b0050e7702a189mr3613965lfp.22.1703848831603;
        Fri, 29 Dec 2023 03:20:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHH/ywHRre541SoLTPy1QECA7NUgjNY8fcN4VeI019+xCIjYOchbO5JRtdR/qeeHiOlbvC6jw==
X-Received: by 2002:ac2:47e6:0:b0:50e:7702:a189 with SMTP id b6-20020ac247e6000000b0050e7702a189mr3613937lfp.22.1703848830973;
        Fri, 29 Dec 2023 03:20:30 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m2-20020a05600c4f4200b0040d5c58c41dsm10315024wmq.24.2023.12.29.03.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 03:20:30 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Conor Dooley <conor@kernel.org>,
	Peter Robinson <pbrobinson@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v5 0/4] drm/solomon: Add support for the SSD133x controller family
Date: Fri, 29 Dec 2023 12:20:17 +0100
Message-ID: <20231229112026.2797483-1-javierm@redhat.com>
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

This is a v5 that is basically the same than the previous v4 but dropping
support for I2C since the ssd133x family does not support that interface.

The patches were tested on a Waveshare SSD1331 display using glmark2-drm,
fbcon, fbtests and the retroarch emulator. The binding schema were tested
using the `make W=1 dt_binding_check` target.

Patch #1 and #2 are fixes for the DT binding schema of the existing SSD130x
and SSD132x families.

Patch #3 adds a DT binding schema for the SSD133x controllers and patch #4
extends the ssd130x DRM driver to support the SSD133x controller family.

Best regards,
Javier

Changes in v5:
- Drop I2C example in DT binding schema due that bus not being supported.
- Drop "solomon,ssd1331" entry from ssd130x-i2c due I2C bus not being supported.

Changes in v4:
- Fix typo in commit message (Jocelyn Falempe).
- Add collected tags.

Changes in v3:
- Move solomon,ssd-common.yaml ref before the properties section and
  width/height constraints after the other properties (Conor Dooley).

Changes in v2:
- Unconditionally set the width and height constraints (Conor Dooley).
- Fix indentation in the DTS examples (Krzysztof Kozlowski).

Javier Martinez Canillas (4):
  dt-bindings: display: ssd1307fb: Add vendor prefix to width and height
  dt-bindings: display: ssd132x: Add vendor prefix to width and height
  dt-bindings: display: Add SSD133x OLED controllers
  drm/ssd130x: Add support for the SSD133x OLED controller family

 .../bindings/display/solomon,ssd1307fb.yaml   |  20 +-
 .../bindings/display/solomon,ssd132x.yaml     |  12 +-
 .../bindings/display/solomon,ssd133x.yaml     |  45 +++
 drivers/gpu/drm/solomon/ssd130x-spi.c         |   7 +
 drivers/gpu/drm/solomon/ssd130x.c             | 370 ++++++++++++++++++
 drivers/gpu/drm/solomon/ssd130x.h             |   5 +-
 6 files changed, 442 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd133x.yaml

-- 
2.43.0


