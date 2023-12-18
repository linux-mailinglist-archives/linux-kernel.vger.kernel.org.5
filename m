Return-Path: <linux-kernel+bounces-3744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514F1817076
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38141F24D4B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A381D131;
	Mon, 18 Dec 2023 13:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QC0VV93f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B683129EF6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702905688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QgMgRDSHYmMiI0OrgNFQA61j2Lc6QloANV8tk9hWb9Q=;
	b=QC0VV93fu0e2ezdrjD6+AhsdhmqdgjeA+Acf2zYF0Oi4NEOpvzm0Cgd0mo+X46XkUI2vot
	4O3IGwG8sQ29UpBgnirEVg4BTRnfZ2CBqNMHHLtZrLegOIHbQ9TGsOdzE5eGNplkr0qPpK
	iGnm3BF+ZXpT2U/mUZFe8rBSabnMWOg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-mi0tCaJxP7-4kqc0eoU7sA-1; Mon, 18 Dec 2023 08:21:27 -0500
X-MC-Unique: mi0tCaJxP7-4kqc0eoU7sA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3365791d24eso1704132f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 05:21:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702905685; x=1703510485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QgMgRDSHYmMiI0OrgNFQA61j2Lc6QloANV8tk9hWb9Q=;
        b=JrEFuRnUNK25vIcac3eQTJABLilQ1YFFss9sg4twVaj7QXEW6d288WNv+dLK/DBrXw
         SQdKc4TSQ/NT0PwMldEKvEVN/P5ii+2s6ND4U7UJvCu4A6GRBFbTRZwSI+P6HzWG+F3Y
         qwlOCaUJFYwtBoHMR34Hrfq6QKvsErYgOLliLfgS/NDK0l6cvgv/VBM7bLXS6zSXQ50r
         jKruzUIMEKgffhfa4aYx4IXhr3D3cUwmxVMPv+XDa+hIUwgUmPTuQUhEVEnPixRiXX6h
         xu1TVssbceP9UQsXiRHTB3kTEPCRsqEpB6KckDdKicAAhbv1NJWKtQMmAncPvJoxsj1V
         Tqhw==
X-Gm-Message-State: AOJu0Yz0aJrIbrcRh/eGm8043UYV390megrKkp8mb6tC3viOZQY2sK8z
	ZyYcR0n+PtuVRqIIhtnMGYEftVTLfNRkejyXVzE9EMPzRoiNKV/XUGz3532wGFrqCZm5Jo63v2V
	U1Jyk1dOuSGXsqceP2aghNZyvEOqyo7WVgZdnR3KFfJEXlU/ajfO4DO/pLzd+tnROwgygCwo+2b
	FwJgn0LWw=
X-Received: by 2002:a05:6000:ccf:b0:333:4c30:dae4 with SMTP id dq15-20020a0560000ccf00b003334c30dae4mr7208830wrb.45.1702905685368;
        Mon, 18 Dec 2023 05:21:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeADstQsPMxdpXUY6VIcyZImy7z4H6FSe/tPLdOt2UZrsYef/bw1noI6ZXdZaCctcd3r5dsw==
X-Received: by 2002:a05:6000:ccf:b0:333:4c30:dae4 with SMTP id dq15-20020a0560000ccf00b003334c30dae4mr7208796wrb.45.1702905684680;
        Mon, 18 Dec 2023 05:21:24 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j4-20020adfea44000000b00336471bc7ffsm12370217wrn.109.2023.12.18.05.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 05:21:24 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Peter Robinson <pbrobinson@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/2] drm/solomon: Add support for the SSD133x controller family
Date: Mon, 18 Dec 2023 14:20:34 +0100
Message-ID: <20231218132045.2066576-1-javierm@redhat.com>
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

This is a v2 that addresses issues pointed out in v1:

https://lore.kernel.org/lkml/20231217100741.1943932-2-javierm@redhat.com/T/

The patches were tested on a Waveshare SSD1331 display using glmark2-drm,
fbcon, fbtests and the retroarch emulator.

Patch #1 adds a DT binding schema for the SSD133x controllers and patch #2
extends the ssd130x DRM driver to support the SSD133x controller family.

Best regards,
Javier

Changes in v2:
- Unconditionally set the width and height constraints (Conor Dooley).
- Fix indentation in the DTS examples (Krzysztof Kozlowski).

Javier Martinez Canillas (2):
  dt-bindings: display: Add SSD133x OLED controllers
  drm/ssd130x: Add support for the SSD133x OLED controller family

 .../bindings/display/solomon,ssd133x.yaml     |  57 +++
 drivers/gpu/drm/solomon/ssd130x-i2c.c         |   5 +
 drivers/gpu/drm/solomon/ssd130x-spi.c         |   7 +
 drivers/gpu/drm/solomon/ssd130x.c             | 370 ++++++++++++++++++
 drivers/gpu/drm/solomon/ssd130x.h             |   5 +-
 5 files changed, 443 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd133x.yaml

-- 
2.43.0


