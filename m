Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9E5765239
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjG0L0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjG0L0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:26:08 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93549E61;
        Thu, 27 Jul 2023 04:26:07 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36RBPmvs127655;
        Thu, 27 Jul 2023 06:25:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690457148;
        bh=svjg9HDYBeq8qsphLJellGwA0fEMEIygUuTxU06ZdHQ=;
        h=From:To:CC:Subject:Date;
        b=hXocclXfTIGL2FNbNaSSb9BlpVrFmuVWtN5X04uCJZUwLZ/ON4FPnFOCK4z7RQFbf
         yvRjaSR1SGGQHMdfaRv3Yb1eyL6N6ewlBJ8h8hl2vB8Dh0SLXhB297ABwhXzMs0IQ1
         mSoIqlXaTfSrsRbiTpNpJ5XOt0o0pmVWIFGl2yOQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36RBPmrs030818
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Jul 2023 06:25:48 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jul 2023 06:25:48 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jul 2023 06:25:48 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36RBPkKK090103;
        Thu, 27 Jul 2023 06:25:47 -0500
From:   Devarsh Thakkar <devarsht@ti.com>
To:     <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hverkuil-cisco@xs4all.nl>, <laurent.pinchart@ideasonboard.com>,
        <eugen.hristev@collabora.com>, <ezequiel@vanguardiasur.com.ar>,
        <u.kleine-koenig@pengutronix.de>, <sakari.ailus@linux.intel.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <a-bhatia1@ti.com>, <j-luthra@ti.com>, <b-brnich@ti.com>,
        <detheridge@ti.com>, <p-mantena@ti.com>, <vijayp@ti.com>,
        <devarsht@ti.com>
Subject: [PATCH v2 0/2] Add V4L2 M2M Driver for E5010 JPEG Encoder
Date:   Thu, 27 Jul 2023 16:55:44 +0530
Message-ID: <20230727112546.2201995-1-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
Link: https://gist.github.com/devarsht/867b1d646bca3f3877edb1f3638aae31

E5010 JPEG Encoder Manual tests :
Link: https://gist.github.com/devarsht/ea31179199393c2026ae457219bb6321

Devarsh Thakkar (2):
  dt-bindings: media: Add bindings for Imagination E5010 JPEG Encoder
  drivers: media: imagination: Add E5010 JPEG Encoder driver

 .../bindings/media/img,e5010-jpeg-enc.yaml    |   79 +
 MAINTAINERS                                   |    7 +
 drivers/media/platform/Kconfig                |    1 +
 drivers/media/platform/Makefile               |    1 +
 drivers/media/platform/imagination/Kconfig    |   13 +
 drivers/media/platform/imagination/Makefile   |    3 +
 .../platform/imagination/e5010-core-regs.h    |  584 ++++++
 .../platform/imagination/e5010-jpeg-enc-hw.c  |  319 +++
 .../platform/imagination/e5010-jpeg-enc-hw.h  |   41 +
 .../platform/imagination/e5010-jpeg-enc.c     | 1762 +++++++++++++++++
 .../platform/imagination/e5010-jpeg-enc.h     |  165 ++
 .../platform/imagination/e5010-mmu-regs.h     |  303 +++
 12 files changed, 3278 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
 create mode 100644 drivers/media/platform/imagination/Kconfig
 create mode 100644 drivers/media/platform/imagination/Makefile
 create mode 100644 drivers/media/platform/imagination/e5010-core-regs.h
 create mode 100644 drivers/media/platform/imagination/e5010-jpeg-enc-hw.c
 create mode 100644 drivers/media/platform/imagination/e5010-jpeg-enc-hw.h
 create mode 100644 drivers/media/platform/imagination/e5010-jpeg-enc.c
 create mode 100644 drivers/media/platform/imagination/e5010-jpeg-enc.h
 create mode 100644 drivers/media/platform/imagination/e5010-mmu-regs.h

-- 
2.34.1

