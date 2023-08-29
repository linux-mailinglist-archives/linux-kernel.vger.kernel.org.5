Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1613978C532
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbjH2NZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236026AbjH2NZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:25:03 -0400
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E769E47;
        Tue, 29 Aug 2023 06:24:44 -0700 (PDT)
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37TCA4in012205;
        Tue, 29 Aug 2023 15:24:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=selector1; bh=HOHMmPN
        tb2/KAKCNwRrItjo3x21ZNwnn7k1eSYj8xNA=; b=t5NEXiKZeVdWee1K2SAdYQf
        Lg+c97uGgPTbhHOqD8Nh4SnCl1QMOIluQlBlQbHx3edHcE78qCFchZ2q4KorEGAx
        jyVGRtOj9xmpWaISIj81R4QDrN8B8z2jwwYPpwqEwbwgcqjdYPxOYDSCTsCOHNUc
        cxqcklac4OtvUs+TUlI/sklrHyyvBDeZT+UvOR0c5TkalcklJOWYDeOBUSkxELf4
        8n9vWtjflq5yZINXFfq28zuZxB+sFeWd2Ur8Cx12FKPRQOYKp5G03qWeLb8l47Ez
        unmHZYfjnRCoYqNOOxB78WNLBCU9Z0LuY4EaCNXlu7fDY8DaGE5coRJ5uSG8RrA=
        =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sqvbha0cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 15:24:10 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 30DD4100057;
        Tue, 29 Aug 2023 15:24:07 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4CE3A21ED54;
        Tue, 29 Aug 2023 15:24:07 +0200 (CEST)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 29 Aug
 2023 15:24:07 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Dan Scally <dan.scally@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/5] Add support for DCMIPP camera interface of STMicroelectronics STM32 SoC series
Date:   Tue, 29 Aug 2023 15:23:44 +0200
Message-ID: <20230829132357.192535-1-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_10,2023-08-29_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces support for Digital Camera Memory Interface
Pixel Processor (DCMIPP) of STMicroelectronics STM32 SoC series.

This initial support implements a single capture pipe
allowing RGB565, YUV, Y, RAW8 and JPEG capture with
frame skipping, prescaling and cropping.

DCMIPP is exposed through 3 subdevices:
- dcmipp_dump_parallel: parallel interface handling
- dcmipp_dump_postproc: frame skipping, prescaling and cropping control
- dcmipp_dump_capture: video device capture node

v2:
  - removal of pclk-max-frequency from yaml example dts
  - codying-style fixes
  - correction in enum functions (format, mbus, frame_size ...) handling
  - drop of v4l2_pipeline_pm_ calls, and specific open/close handler of
    vdev
  - video dev s_stream handling updated to call s_stream of remote subdev
    instead of loop until sensor subdev
  - code update following media_pipeline & v4l2_async_ api changes since v1
  - removal of IP reset call upon error
  - removal of link_validate handlers
  - addition of V4L2_CAP_IO_MC device_caps
  - removal of the frame skip control for the time being, will be added
    back in another commit once control method will be agreed
  - change byteproc entity type to MEDIA_ENT_F_PROC_VIDEO_SCALER
  - various fixes from Dan & Sakari remarks

Alain Volmat (2):
  dt-bindings: media: add bindings for dcmipp driver
  media: MAINTAINERS: add entry for STM32 DCMIPP driver

Hugues Fruchet (3):
  media: stm32-dcmipp: STM32 DCMIPP camera interface driver
  ARM: dts: stm32: add dcmipp support to stm32mp135
  ARM: multi_v7_defconfig: enable STM32 DCMIPP media support

 .../bindings/media/st,stm32-dcmipp.yaml       |   95 ++
 MAINTAINERS                                   |    9 +
 arch/arm/boot/dts/st/stm32mp135.dtsi          |    9 +
 arch/arm/configs/multi_v7_defconfig           |    1 +
 drivers/media/platform/st/stm32/Kconfig       |   15 +
 drivers/media/platform/st/stm32/Makefile      |    1 +
 .../platform/st/stm32/stm32-dcmipp/Makefile   |    5 +
 .../st/stm32/stm32-dcmipp/dcmipp-bytecap.c    | 1040 +++++++++++++++++
 .../st/stm32/stm32-dcmipp/dcmipp-byteproc.c   |  692 +++++++++++
 .../st/stm32/stm32-dcmipp/dcmipp-common.c     |  105 ++
 .../st/stm32/stm32-dcmipp/dcmipp-common.h     |  227 ++++
 .../st/stm32/stm32-dcmipp/dcmipp-core.c       |  673 +++++++++++
 .../st/stm32/stm32-dcmipp/dcmipp-parallel.c   |  523 +++++++++
 13 files changed, 3395 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/st,stm32-dcmipp.yaml
 create mode 100644 drivers/media/platform/st/stm32/stm32-dcmipp/Makefile
 create mode 100644 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c
 create mode 100644 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-byteproc.c
 create mode 100644 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-common.c
 create mode 100644 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-common.h
 create mode 100644 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c
 create mode 100644 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-parallel.c

-- 
2.25.1

