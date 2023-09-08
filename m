Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DF179873C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 14:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243217AbjIHMn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 08:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjIHMn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 08:43:59 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0141419AB;
        Fri,  8 Sep 2023 05:43:54 -0700 (PDT)
Received: from www.ideasonboard.com (unknown [103.251.226.21])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 43C5F10FC;
        Fri,  8 Sep 2023 14:42:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694176944;
        bh=sMUri7fQTwPsXuq0LSzjlDUxeJQGgORch+JxYx16dVA=;
        h=From:To:Cc:Subject:Date:From;
        b=D3aqkHyVFqeOKPhk4NCaU+3yCESXX67VWO0+LG6vUCDmqSe1P05Ebi7w4mtyYuFDX
         yZKRkphwY1ASx0YLM+22/E9/RnP/EfA7Veeut7S38imSj+WLg/H5a3aYfQItf81cZz
         Ygv5JppOBU33OOKPvHYBnkOgBa6/fXMt7857MB0o=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Lee Jackson <lee.jackson@arducam.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        kieran.bingham@ideasonboard.com, jacopo.mondi@ideasonboard.com,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v6 0/2] media: i2c: imx519: Support for Sony IMX519 sensor
Date:   Fri,  8 Sep 2023 08:43:42 -0400
Message-ID: <20230908124344.171662-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series adds support for Sony imx519 sensor.
Tested for all modes on top of [1] with libcamera on Raspberry Pi 4

Changes in v6:
- Port to use subdev active state
- Use CCI helpers to read and write regs
- Drop embedded data pad support from previous version
  (Will be done in subsequent series with streams API)
- Drop pm resume/suspend functions
- Inline imx519_reset_colorspace()
- Drop IMX519_NUM_SUPPLIES define
- Rework imx519_start_streaming()
- Rework imx519_stop_streaming()
- Use PM runtime autosuspend API
- Misc trivial fixes

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/pinchartl/linux.git/log/?h=rpi/v6.5/unicam/dev

Lee Jackson (2):
  dt-bindings: media: i2c: Add IMX519 CMOS sensor
  media: i2c: Add driver for IMX519 sensor

 .../bindings/media/i2c/sony,imx519.yaml       |  107 +
 MAINTAINERS                                   |    9 +
 drivers/media/i2c/Kconfig                     |   14 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/imx519.c                    | 1842 +++++++++++++++++
 5 files changed, 1973 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx519.yaml
 create mode 100644 drivers/media/i2c/imx519.c


base-commit: 3f609d0d03e4967469b2aa22738b1bae74cff2b0
-- 
2.41.0

