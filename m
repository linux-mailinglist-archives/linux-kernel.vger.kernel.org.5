Return-Path: <linux-kernel+bounces-22334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B829829C48
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16A9BB27785
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF5D4CB27;
	Wed, 10 Jan 2024 14:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uhq+nv9f"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AB94A98C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d88fff7faso43147385e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 06:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704896090; x=1705500890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J8jYdrd32qpj6UYwFmFTXCiQDt/VqLbFNDBtbxT7ng8=;
        b=uhq+nv9fAQyMBYF8Pj/TA0VBkt660Ea0Zt8nyeJgpEsM67LHzswYeBs3rzY0xrkPJr
         EHkzHomTTlG6YDkAAt2SARrEcqAn85va/ckSiyqmqcoPuP5Yxg7I1hjmtzwCd7hAKZ6c
         dk2pxqlzAIm4Vdgpemhl0RZPq9LvwFRtULcAZTgRr88837vLFRr0+xrzWlq9C3vX0j2/
         q88d4Vm4B3diJdYCAdstcDlGZtzG9z//kasqvA2On1hrkLPWyrfi4z0dnNVfnEuJySue
         zDZ3DMzT4HRotFkyf5shHrouk4A+nSTObML1+SHZKL8Jm6G34aiL1OQ/rHO7yM7GhsKf
         wc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704896090; x=1705500890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8jYdrd32qpj6UYwFmFTXCiQDt/VqLbFNDBtbxT7ng8=;
        b=bCIFKpMzkwQzo3NI4aG3vJxEL3mkV634YEHy/PtRgmtjVcnzpcS0LvZ2oZFQx1ePbW
         /Y/Zo/bH7HpW9G3oKVAIkvfgccY4zCqN2NVUjUuhNagBVkLbgCQXj/zhPXNA5Fn9lbYX
         0V4Mqg5Akujvj04Ql7bfCXtjba2J5Zvnqj5jWxVPDjuxfSmUvtgMhjHvXdFgf00onGIk
         upt8bhWOyW1WU+UzST0PpAlUQkaGobtrHwDEu4+mtXnM+3UpzqRF4FY4cLsxVXu2G8Qt
         KnAu9UxkbheJkswoW38OazP0n4I+OjHMM83hQF7y81exYwQdHyv6AYrq+I1oAeL9Rs3U
         GxTQ==
X-Gm-Message-State: AOJu0YxFpShb4kVI4zqaIa/u205x8j/sbAJKEUMifg8vkwvqfRJu1M3G
	uE4R3ItKabcmx6SO5qXYT2DOgNfTw3EJZSm1DmupIFVKU7yBcUCu
X-Google-Smtp-Source: AGHT+IEHRXaEYKtpv9wgkctGP+Dh0vUx/8AF01+K3IuIdoRHwJAw23qEH0nWy3rq7+Sqm821M/hQ1Q==
X-Received: by 2002:a05:600c:c06:b0:40d:6f03:dd9a with SMTP id fm6-20020a05600c0c0600b0040d6f03dd9amr290341wmb.69.1704896090143;
        Wed, 10 Jan 2024 06:14:50 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:55f:21e0:9e19:4376:dea6:dbfa])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c1c1100b0040c46719966sm2363890wms.25.2024.01.10.06.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 06:14:49 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
To: 
Cc: Julien Stephan <jstephan@baylibre.com>,
	Andy Hsieh <andy.hsieh@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Florian Sylvestre <fsylvestre@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-media@vger.kernel.org,
	Louis Kuo <louis.kuo@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Phi-bang Nguyen <pnguyen@baylibre.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 0/5] Add Mediatek ISP3.0
Date: Wed, 10 Jan 2024 15:14:37 +0100
Message-ID: <20240110141443.364655-1-jstephan@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds the support of the Mediatek ISP3.0 found on some
Mediatek SoCs such as the mt8365. The driver is divided into 2 parts:

* SENINF: the sensor interface
* CAMSV: this driver provides a path to bypass the SoC ISP so that image
  data coming from the SENINF can go directly into memory without any
  image processing. This allows the use of an external ISP or camera
  sensor directly.

The SENINF driver is based on previous work done by Louis Kuo available
as an RFC here: https://lore.kernel.org/all/20200708104023.3225-1-louis.kuo@mediatek.com/

This series depends on the following series for the phy [1]

Changes in v4:
- fix suspend/resume deadlock
- fix various locking issues reported by Laurent Pinchart on v3
- run LOCKDEP
- add missing include reported by kernel-test-robot for non mediatek arch and COMPILE_TEST=y
- use atomic poll inside mtk_camsv30_setup
- drop second lane support as it was not used 
- remove useless members in structs
- fix media entity initialization
- initialize correct pad for camsv video device
- add isp support in mt8365.dtsi
- rebase on 6.7

Changes in v3:
- fix a lot of formatting issues/coding style issues found in camsv/seninf reported by Angelo on v2
- fix camsv/seninf binding file error reported by Rob

Changes in v2:
- renamed clock `cam_seninf` to `camsys`
- renamed clock `top_mux_seninf` to `top_mux`
- moved phy properties from port nodes to top level
- remove patternProperties
- specify power management dependency in the cover letter description to fix
  missing include in dt-binding example
- change '$ref' properties on some endpoint nodes from
  '$ref: video-interfaces.yaml#' to '$ref: /schemas/graph.yaml#/$defs/endpoint-base'
 where applicable

Best
Julien Stephan

[1] : https://lore.kernel.org/all/20230620121928.1231745-1-jstephan@baylibre.com/



Louis Kuo (2):
  dt-bindings: media: add mediatek ISP3.0 sensor interface
  media: platform: mediatek: isp_30: add mediatek ISP3.0 sensor
    interface

Phi-bang Nguyen (2):
  dt-bindings: media: add mediatek ISP3.0 camsv
  media: platform: mediatek: isp_30: add mediatek ISP3.0 camsv

 .../bindings/media/mediatek,mt8365-camsv.yaml |  109 ++
 .../media/mediatek,mt8365-seninf.yaml         |  259 +++
 MAINTAINERS                                   |   10 +
 arch/arm64/boot/dts/mediatek/mt8365.dtsi      |  128 ++
 drivers/media/platform/mediatek/Kconfig       |    1 +
 drivers/media/platform/mediatek/Makefile      |    1 +
 drivers/media/platform/mediatek/isp/Kconfig   |    2 +
 drivers/media/platform/mediatek/isp/Makefile  |    3 +
 .../platform/mediatek/isp/isp_30/Kconfig      |   35 +
 .../platform/mediatek/isp/isp_30/Makefile     |    4 +
 .../mediatek/isp/isp_30/camsv/Makefile        |    7 +
 .../mediatek/isp/isp_30/camsv/mtk_camsv.c     |  328 ++++
 .../mediatek/isp/isp_30/camsv/mtk_camsv.h     |  199 +++
 .../isp/isp_30/camsv/mtk_camsv30_hw.c         |  427 +++++
 .../isp/isp_30/camsv/mtk_camsv30_regs.h       |   60 +
 .../isp/isp_30/camsv/mtk_camsv_video.c        |  774 +++++++++
 .../mediatek/isp/isp_30/seninf/Makefile       |    5 +
 .../mediatek/isp/isp_30/seninf/mtk_seninf.c   | 1488 +++++++++++++++++
 .../isp/isp_30/seninf/mtk_seninf_reg.h        |  112 ++
 19 files changed, 3952 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
 create mode 100644 drivers/media/platform/mediatek/isp/Kconfig
 create mode 100644 drivers/media/platform/mediatek/isp/Makefile
 create mode 100644 drivers/media/platform/mediatek/isp/isp_30/Kconfig
 create mode 100644 drivers/media/platform/mediatek/isp/isp_30/Makefile
 create mode 100644 drivers/media/platform/mediatek/isp/isp_30/camsv/Makefile
 create mode 100644 drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv.c
 create mode 100644 drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv.h
 create mode 100644 drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv30_hw.c
 create mode 100644 drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv30_regs.h
 create mode 100644 drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv_video.c
 create mode 100644 drivers/media/platform/mediatek/isp/isp_30/seninf/Makefile
 create mode 100644 drivers/media/platform/mediatek/isp/isp_30/seninf/mtk_seninf.c
 create mode 100644 drivers/media/platform/mediatek/isp/isp_30/seninf/mtk_seninf_reg.h

-- 
2.43.0


