Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E9A771D6E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjHGJuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjHGJt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:49:59 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5193F173B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:49:50 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe5eb84d8bso2982675e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 02:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691401785; x=1692006585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7WlaoSNS0YQPW0Ym1+gME4oJekwgVfQCX8PcT91w2v4=;
        b=Sa8PD0Y+SHMOpyVVYoPVv0bjF/lbLKgj8brbLKMHB8UR/YlDmps4DaYcK/PwagxM5F
         6kj6WB7tBpA9MZ9ZWuihJwiZQsnl6xQ4k8WAXX/8+kWxY1wrE0r0ox/EvvAt7xpGVOGE
         x/kB838MjxHRBYpAz641hN7ivYvnA8uW2WhfnGIyOUDiydJEc2Yq3fPLPejKhK5qcYxR
         hKQcmgGik+3OcEJEli0L4ToKdkPsFxencPLkDz77AoI4x7382U1jeilqSekJNYO7GhLA
         4724WjNHZSsxaBeZRFpTa33rn7eP0ByHaVUMfeO0PO979YDxlKsYWXAUO8u3Jrfoh/OJ
         Osgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691401785; x=1692006585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7WlaoSNS0YQPW0Ym1+gME4oJekwgVfQCX8PcT91w2v4=;
        b=iQxvl9nZfz7r5rX3irrEi8ZqAKiolFaL21RW9HvmayqGdn74c6CcPlFV3wqrs/LPfQ
         C+yo+fzs+C4AKEyyIpYqUJ+Xo2M4ykRiet4U7dTO8gVOHOdc1qZ5BhFp5Ha+r6g7m+gO
         bPwGjACFsUFAFHDz2koZvNeqAFAMXHFSIDKvDON+zlToZYntTU2072bUbPyBKRdPk/xb
         Nu51asjLKBWX0or8KqYdLFmWZ6PtTe4oFEIcmdxxVgJxVw3SzlNcI9uzUYXyNqNRvXeB
         kXMotjg2XcPnMaXv4zSg7vtaWcqvm0Shf+5qz6KFN/ls9fhAFXFOKspkTBnTCdbqEmvQ
         H0vg==
X-Gm-Message-State: AOJu0Yw648zScur6GGSObuUC14SDO375KwQUW/LyZT0GhFawCWMnapiT
        H89jMXRPzY1KzXMUwg5HF6ylRQ==
X-Google-Smtp-Source: AGHT+IEQJRkkN0Aet2aRuHdQXnzNkF4CizFKB1Dy7s2jxhLny1IPKP1IQDAj6d1UgfXDOBClCgMuQA==
X-Received: by 2002:a1c:7913:0:b0:3fb:b248:67c with SMTP id l19-20020a1c7913000000b003fbb248067cmr5522062wme.22.1691401784845;
        Mon, 07 Aug 2023 02:49:44 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:55f:21e0:9e19:4376:dea6:dbfa])
        by smtp.gmail.com with ESMTPSA id i11-20020a05600c2d8b00b003fe5228b78dsm2752429wmg.1.2023.08.07.02.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 02:49:44 -0700 (PDT)
From:   Julien Stephan <jstephan@baylibre.com>
Cc:     Julien Stephan <jstephan@baylibre.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        devicetree@vger.kernel.org,
        Florian Sylvestre <fsylvestre@baylibre.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        Louis Kuo <louis.kuo@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Phi-bang Nguyen <pnguyen@baylibre.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 0/4] Add Mediatek ISP3.0
Date:   Mon,  7 Aug 2023 11:48:09 +0200
Message-ID: <20230807094940.329165-1-jstephan@baylibre.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the support of the Mediatek ISP3.0 found on some
Mediatek SoCs such as the mt8365. The driver is divided into 2 parts:

* SENINF: the sensor interface
* CAMSV: this driver provides a path to bypass the SoC ISP so that image
  data coming from the SENINF can go directly into memory without any
  image processing. This allows the use of an external ISP or camera
  sensor directly.

The SENINF driver is based on previous work done by Louis Kuo available
as an RFC here: https://lore.kernel.org/all/20200708104023.3225-1-louis.kuo@mediatek.com/

This series depends on the following series: [1] for the phy,  [2] for
power management support

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
[2] : https://lore.kernel.org/lkml/20230627131040.3418538-1-msp@baylibre.com/


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
 drivers/media/platform/mediatek/Kconfig       |    1 +
 drivers/media/platform/mediatek/Makefile      |    1 +
 drivers/media/platform/mediatek/isp/Kconfig   |    2 +
 drivers/media/platform/mediatek/isp/Makefile  |    3 +
 .../platform/mediatek/isp/isp_30/Kconfig      |   35 +
 .../platform/mediatek/isp/isp_30/Makefile     |    4 +
 .../mediatek/isp/isp_30/camsv/Makefile        |    7 +
 .../mediatek/isp/isp_30/camsv/mtk_camsv.c     |  328 ++++
 .../mediatek/isp/isp_30/camsv/mtk_camsv.h     |  196 +++
 .../isp/isp_30/camsv/mtk_camsv30_hw.c         |  432 +++++
 .../isp/isp_30/camsv/mtk_camsv30_regs.h       |   60 +
 .../isp/isp_30/camsv/mtk_camsv_video.c        |  781 +++++++++
 .../mediatek/isp/isp_30/seninf/Makefile       |    5 +
 .../mediatek/isp/isp_30/seninf/mtk_seninf.c   | 1491 +++++++++++++++++
 .../isp/isp_30/seninf/mtk_seninf_reg.h        |  112 ++
 18 files changed, 3836 insertions(+)
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
2.41.0

