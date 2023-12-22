Return-Path: <linux-kernel+bounces-9948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D051C81CDB6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0176A1C21E71
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F98A28DD0;
	Fri, 22 Dec 2023 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJlcUFZU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B8C2C183;
	Fri, 22 Dec 2023 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-336746a545fso1256567f8f.0;
        Fri, 22 Dec 2023 09:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703266941; x=1703871741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hHFkedPmax7f2jMznqg0TqRbSWkPKtd98J+qp1ddTP0=;
        b=eJlcUFZU6JBEX87MKg0HtKBkTmNXERGRsGuvW+FC/dFsC0rV/a9/5nqhcGvMObNcMt
         khNdirsnc4SJOFeQvvvtnRwH6P6Z33l8foHaWKanrvFi3v5UoiCKIrDYbJ/FLzOAzVXx
         arbX+irwcH9q2EFooTvqBeas+bVAXTdiTdVTUY0fHynDy34D27NdYOK/XpRtfbJPdbia
         gtSfqzN9oJScdilWgGksvGGDKHcOfEMHr29kraFKromrVSaIgPYV8FI41YK5PP0K1C5x
         uD+Oxyxv28WqEQVVnIQ3gYWGllaHAzvUpOYyq+6Mwc4SXxnDj9lVmshr5rlZHn25F/Sf
         jRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266941; x=1703871741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hHFkedPmax7f2jMznqg0TqRbSWkPKtd98J+qp1ddTP0=;
        b=PkU05mCbkl/RyUB5icMaPma1nHkV8ledBIYepyIp4u3q3rg5ytFSySgHzn+mQCKpkf
         w0bphemlYHEI6hsvUeV4wFJwJ5kwNjCxiY/kCeFcSVuWtTugVDycYjeoanwJjvaX2Bz8
         tKq3y0L5bu+eXowlIJWg3ywbQTx79G9A1vL5YAXztWgYw0BCmTCFmDEkoDxVpQ5Bieek
         pwCTMj1vaDNzfhfxdHbv3CvXPPKsS4/QIXocc+5C4EJ1v7hlmVwrPi74r1nLOUBX0xlB
         6MpSxfX62ASSgEWvjzgMjfRZmtH0eHEXa5HOndpfdxf0KYvCt76W8PhY5F7HJ/ui6x4n
         k8Pg==
X-Gm-Message-State: AOJu0YyFASZVqQ73k5l1mN+gySnGoqk4Pix2tiilaGLMW1JaHPObFmZq
	c9Iqd2JOiuOp0y88wpiLYg==
X-Google-Smtp-Source: AGHT+IHwJ7vKkIduWkKIJWTuwfloN+HwqKIaLADdUtYCaF29vwkh72hGBlvXCgEZafcU5IlivtWLFw==
X-Received: by 2002:a5d:6102:0:b0:336:5bc1:f53 with SMTP id v2-20020a5d6102000000b003365bc10f53mr1693282wrt.10.1703266941511;
        Fri, 22 Dec 2023 09:42:21 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:f3ae:2788:7e03:f44])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00336670abdcasm4777116wrn.40.2023.12.22.09.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:42:21 -0800 (PST)
From: Alex Bee <knaerzche@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v4 00/29]  Add HDMI support for RK3128
Date: Fri, 22 Dec 2023 18:41:51 +0100
Message-ID: <20231222174220.55249-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is version 4 of my series that aims to add support for the display
controller (VOP) and the HDMI controller block of RK3128 (which is very
similar to the one found in RK3036). The original intention of this series
was to add support for this slightly different integration but is by now,
driven by maintainer's feedback, exploded to be a rework of inno-hdmi
driver in large parts. It is, however, a change for the better.

The VOP part is very simple -  everything we need for HDMI support is
already there. I only needed to split the output selection registers from
RK3036. The VOP has an IOMMU attached, but it has a serious silicon bug:
Registers can only be written, but not be read. As it's not possible to use
it with the IOMMU driver in it's current state I'm not adding it here and
we have to live with CMA for now - which works fine also. I got response
from the vendor, that there is no possibility to read the registers and an
workaround must be implemented in software in order to use it.

The inno-hdmi driver currently gets a lot of attention [0-2] and I'm
hooking in now also. As requested I incorporated some of Maxime's series
[0] (and tested them).
I have intentionally not removed any code dealing with output format
conversion in this series. In contrast to the input format, which is always
RGB on this platform and certainly can be dropped, that can be implemented
later. And secondly I need the conversion for RGB full range to RGB limited
range for this series.

I did also some smaller driver cleanups from my side and implemented a
custom connector state which now holds the data that belongs there and it
is not longer in the device structure and, of course, addressed the
feedback from v1 [3] and v2 [4].
There hasn't been any feedback to v3[5] so far, but I fixed an issue with
the new custom connector reset hook: If there is a connector state already
it needs to be destroyed in there as well.

Please see individual patches for detailed changelog.

Note: Patches are based and tested on next-20231213.

[0] https://lore.kernel.org/all/20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org
[1] https://lore.kernel.org/all/20231204123315.28456-1-keith.zhao@starfivetech.com
[2] https://lore.kernel.org/all/2601b669-c570-f39d-8cf9-bff56c939912@gmail.com
[3] https://lore.kernel.org/all/20231213195125.212923-1-knaerzche@gmail.com/
[4] https://lore.kernel.org/all/20231216162639.125215-1-knaerzche@gmail.com/
[5] https://lore.kernel.org/all/20231219170100.188800-1-knaerzche@gmail.com/

Alex Bee (17):
  dt-bindings: display: rockchip,inno-hdmi: Document RK3128 compatible
  drm/rockchip: vop: Add output selection registers for RK312x
  drm/rockchip: inno_hdmi: Fix video timing
  drm/rockchip: inno_hdmi: Remove YUV-based csc coefficents
  drm/rockchip: inno_hdmi: Drop irq struct member
  drm/rockchip: inno_hdmi: Remove useless include
  drm/rockchip: inno_hdmi: Subclass connector state
  drm/rockchip: inno_hdmi: Correctly setup HDMI quantization range
  drm/rockchip: inno_hdmi: Don't power up the phy after resetting
  drm/rockchip: inno_hdmi: Split power mode setting
  drm/rockchip: inno_hdmi: Add variant support
  drm/rockchip: inno_hdmi: Add RK3128 support
  drm/rockchip: inno_hdmi: Add basic mode validation
  drm/rockchip: inno_hdmi: Drop custom fill_modes hook
  ARM: dts: rockchip: Add display subsystem for RK3128
  ARM: dts: rockchip: Add HDMI node for RK3128
  ARM: dts: rockchip: Enable HDMI output for XPI-3128

Maxime Ripard (12):
  drm/rockchip: inno_hdmi: Remove useless mode_fixup
  drm/rockchip: inno_hdmi: Remove useless copy of drm_display_mode
  drm/rockchip: inno_hdmi: Switch encoder hooks to atomic
  drm/rockchip: inno_hdmi: Get rid of mode_set
  drm/rockchip: inno_hdmi: no need to store vic
  drm/rockchip: inno_hdmi: Remove unneeded has audio flag
  drm/rockchip: inno_hdmi: Remove useless input format
  drm/rockchip: inno_hdmi: Remove tmds rate from structure
  drm/rockchip: inno_hdmi: Drop HDMI Vendor Infoframe support
  drm/rockchip: inno_hdmi: Move infoframe disable to separate function
  drm/rockchip: inno_hdmi: Switch to infoframe type
  drm/rockchip: inno_hdmi: Remove unused drm device pointer

 .../display/rockchip/rockchip,inno-hdmi.yaml  |  40 +-
 .../arm/boot/dts/rockchip/rk3128-xpi-3128.dts |  29 +
 arch/arm/boot/dts/rockchip/rk3128.dtsi        |  60 ++
 drivers/gpu/drm/rockchip/inno_hdmi.c          | 549 +++++++++++-------
 drivers/gpu/drm/rockchip/inno_hdmi.h          |   5 -
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c   |  13 +-
 drivers/gpu/drm/rockchip/rockchip_vop_reg.h   |   3 +
 7 files changed, 484 insertions(+), 215 deletions(-)


base-commit: 48e8992e33abf054bcc0bb2e77b2d43bb899212e
-- 
2.43.0


