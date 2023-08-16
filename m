Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8056377E503
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344155AbjHPPWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344148AbjHPPWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:22:41 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F721987;
        Wed, 16 Aug 2023 08:22:32 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37GFMC1M112777;
        Wed, 16 Aug 2023 10:22:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692199332;
        bh=AaaVtVTqX2Nn4tIHGRAQK7zVdynaBfAeuskWD0vfCWU=;
        h=From:To:CC:Subject:Date;
        b=CXA3r0XgHOPUzeamJsInnZi9yazTrtPbWG1QTHuAudUTY+w3Gqzg8QgYjdkXacC6F
         zOVuJ+ppCNjH+7VuwuKduc/TtyYAtFMMvKuHDIbtAju9SswsgqgRSpBVxV9BXKG5vM
         4cB9ZFjfYZDxHl1ibPNdV6b/kue2ZpIoxlowFTfI=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37GFMCmj012127
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Aug 2023 10:22:12 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Aug 2023 10:22:12 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Aug 2023 10:22:11 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37GFMAtl124178;
        Wed, 16 Aug 2023 10:22:11 -0500
From:   Devarsh Thakkar <devarsht@ti.com>
To:     <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hverkuil-cisco@xs4all.nl>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <laurent.pinchart@ideasonboard.com>, <eugen.hristev@collabora.com>,
        <ezequiel@vanguardiasur.com.ar>, <u.kleine-koenig@pengutronix.de>,
        <sakari.ailus@linux.intel.com>, <praneeth@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <b-brnich@ti.com>, <detheridge@ti.com>, <p-mantena@ti.com>,
        <vijayp@ti.com>, <devarsht@ti.com>
Subject: [PATCH v3 0/4] Add V4L2 M2M Driver for E5010 JPEG Encoder
Date:   Wed, 16 Aug 2023 20:52:06 +0530
Message-ID: <20230816152210.4080779-1-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for V4L2 M2M based driver for E5010 JPEG Encoder
which is a stateful JPEG encoder from Imagination technologies
and is present in TI AM62A SoC.

v4l2-compliance test :
Link: https://gist.github.com/devarsht/17348fc509fe375a630a798196edbb73

E5010 JPEG Encoder Manual tests :

Performance:
Link: https://gist.github.com/devarsht/ef5aba211aae45166681b8b4418d4e65

Functionality:
Link: https://gist.github.com/devarsht/bfef1e3ead8e858b09cbf418aea753e8

Compression Quality:
Link: https://gist.github.com/devarsht/345df9bf7157b4ca094293760e257451

Multi Instance:
Link: https://gist.github.com/devarsht/4b4d734eeb9e0e616837c0836ddbc769

Devarsh Thakkar (4):
  dt-bindings: media: Add bindings for Imagination E5010 JPEG Encoder
    driver
  media: imagination: Add E5010 JPEG Encoder driver
  arm64: dts: ti: k3-am62a : Add E5010 JPEG Encoder
  arm64: defconfig: Enable E5010 JPEG Encoder

 .../bindings/media/img,e5010-jpeg-enc.yaml    |   81 +
 MAINTAINERS                                   |    7 +
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi     |   11 +
 arch/arm64/boot/dts/ti/k3-am62a.dtsi          |    2 +
 arch/arm64/configs/defconfig                  |  117 +-
 drivers/media/platform/Kconfig                |    1 +
 drivers/media/platform/Makefile               |    1 +
 drivers/media/platform/imagination/Kconfig    |   12 +
 drivers/media/platform/imagination/Makefile   |    3 +
 .../platform/imagination/e5010-core-regs.h    |  585 ++++++
 .../platform/imagination/e5010-jpeg-enc-hw.c  |  320 ++++
 .../platform/imagination/e5010-jpeg-enc-hw.h  |   42 +
 .../platform/imagination/e5010-jpeg-enc.c     | 1678 +++++++++++++++++
 .../platform/imagination/e5010-jpeg-enc.h     |  169 ++
 .../platform/imagination/e5010-mmu-regs.h     |  311 +++
 15 files changed, 3265 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
 create mode 100644 drivers/media/platform/imagination/Kconfig
 create mode 100644 drivers/media/platform/imagination/Makefile
 create mode 100644 drivers/media/platform/imagination/e5010-core-regs.h
 create mode 100644 drivers/media/platform/imagination/e5010-jpeg-enc-hw.c
 create mode 100644 drivers/media/platform/imagination/e5010-jpeg-enc-hw.h
 create mode 100644 drivers/media/platform/imagination/e5010-jpeg-enc.c
 create mode 100644 drivers/media/platform/imagination/e5010-jpeg-enc.h
 create mode 100644 drivers/media/platform/imagination/e5010-mmu-regs.h

---
Changelog:
V1->V2: 
No change (sending dt-binding and driver together)

V2->V3:
- Add DONOTMERGE patches for dts and defconfig
- Update driver with below changes :
  - Correct license headers
  - Use more generic name core instead of jasper for base registers
  - Add Comment for forward declarations
  - Simplify quantization table calculations
  - Use v4l2_apply_frmsize_constraints for updating framesize and remove unrequired functions
  - Place TODO at top of file and in commit message too
  - Use dev_err_probe helper in probe function
  - Fix return value checking for failure scenarios in probe function
  - Use v4l2_err/info/warn helpers instead of dev_err/info/warn helpers
  - Fix unexpected indentation
  - Correct commit message
- Update dt-bindings with below changes :
  - Add vendor specific compatible 
  - Fix commit title and message
  - Update reg names
  - Update clocks to 1
  - Fix dts example with proper naming
-- 
2.34.1

