Return-Path: <linux-kernel+bounces-9569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A8A81C7B8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708121F24FCB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979FA107A9;
	Fri, 22 Dec 2023 10:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GyQnZWbb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0C8FBF2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 10:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703239316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oS+qjXh8HC10X0gWfxfO5QF2dd2RsmhOYMQoP9qGsHs=;
	b=GyQnZWbbP9IGcyQ8hez6V5/yWfEv8WI6IrGyUQOPtx4lEpX1NeyqDAEA+uL++jCb98PaMp
	bRSgyRjneP5ktWGMvfYsUobl5V4m2ovXoxdRvcLljOsvXVpbXqr9nJ+BDQlFo+2r7jsy2l
	wUTZvAX04lukAV7j2at90AK2ZgZ37ZU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-GOI2o3KONlqwtVO4M_ieQg-1; Fri, 22 Dec 2023 05:01:54 -0500
X-MC-Unique: GOI2o3KONlqwtVO4M_ieQg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50e40182d1eso1564795e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 02:01:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703239312; x=1703844112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oS+qjXh8HC10X0gWfxfO5QF2dd2RsmhOYMQoP9qGsHs=;
        b=WvsW593Ltr+ZV/uZ2Ozac9EV8QpErQ0IO5Kfi9Lv27m1pKDEqeNTS+SdC6STECOLFl
         OD6zHRS8o6vE7gvY0KBHPXJlKQQEwQnIzr9wTgMNp0xndxpaHNNP02c7zcu17UsvIISQ
         zHdoqKr1nu3nu43IxBycTfkKoNOe3tIc4uANdrCQV4nnsDIFK2Q04Nlhr62pF2NuNzAD
         aRWcJsA2dCbjFX2L8APMVucgC08HC51b3YnzrDXIf3L/43V5RK3rplQf6ZuVU4/IzcPe
         mE9iuM31oJYhyq0i1NrJGpQ/tBKTABeD5+ylTr2h57uk7WVtfIW5QTC8x7/jYjef+9IY
         Nn0g==
X-Gm-Message-State: AOJu0Yz9VQqDdutyWmjfwXOhvND5upAsm3w/7H/4ucScptU56qRugh2R
	qNyhzq/lU2mtjjtDX2A9vE1EmfTkRk4TsHxIGCtdCZUir3g+20gJKECkbnLbS1MoprynW4Drckw
	GzElt7ucRphlEe2V7zEe9OrMyYxhnln5lJwQl7z9xqPbGkKw0kn1sSOJ/72mQFD1E/ES9GLPmxY
	8AotW+xVfDYzyIfJo=
X-Received: by 2002:a19:675c:0:b0:50b:f2b0:8002 with SMTP id e28-20020a19675c000000b0050bf2b08002mr565070lfj.1.1703239312064;
        Fri, 22 Dec 2023 02:01:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3UUA6JbUM94lCnUrXw37J307GXHRb3FGcQu41FituqE8XKR8rvHDKTEOZVs6QkjodmX2xng==
X-Received: by 2002:a19:675c:0:b0:50b:f2b0:8002 with SMTP id e28-20020a19675c000000b0050bf2b08002mr565039lfj.1.1703239311651;
        Fri, 22 Dec 2023 02:01:51 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h1-20020a05600c350100b0040d3f4b1c8esm4883265wmq.36.2023.12.22.02.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 02:01:51 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Peter Robinson <pbrobinson@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Conor Dooley <conor@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v4 0/4] drm/solomon: Add support for the SSD133x controller family
Date: Fri, 22 Dec 2023 11:01:37 +0100
Message-ID: <20231222100149.2641687-1-javierm@redhat.com>
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

This is a v4 that addresses issues pointed out in v3:

https://lists.freedesktop.org/archives/dri-devel/2023-December/435686.html

The patches were tested on a Waveshare SSD1331 display using glmark2-drm,
fbcon, fbtests and the retroarch emulator. The binding schema were tested
using the `make W=1 dt_binding_check` target.

Patch #1 and #2 are fixes for the DT binding schema of the existing SSD130x
and SSD132x families.

Patch #3 adds a DT binding schema for the SSD133x controllers and patch #4
extends the ssd130x DRM driver to support the SSD133x controller family.

Best regards,
Javier

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
 .../bindings/display/solomon,ssd133x.yaml     |  57 +++
 drivers/gpu/drm/solomon/ssd130x-i2c.c         |   5 +
 drivers/gpu/drm/solomon/ssd130x-spi.c         |   7 +
 drivers/gpu/drm/solomon/ssd130x.c             | 370 ++++++++++++++++++
 drivers/gpu/drm/solomon/ssd130x.h             |   5 +-
 7 files changed, 459 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd133x.yaml

-- 
2.43.0


