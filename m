Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B927657E2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjG0Pl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjG0PlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:41:24 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21113B4;
        Thu, 27 Jul 2023 08:41:24 -0700 (PDT)
Received: from umang.jainideasonboard.com (unknown [103.86.18.216])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 622594A9;
        Thu, 27 Jul 2023 17:40:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690472422;
        bh=Xf++ltgPgr14drE6ifgMA6GI7A5yNuwTe9sdwBYtmuY=;
        h=From:To:Cc:Subject:Date:From;
        b=AIMA6KJFCarKLHwXBvAE2Tjr20weaLe5Ts6e7Ca20a3iK1iDgMBDfqBw/3B9JDkiX
         dWkKofme3/OTcTSgfVNB0MNiUhKYd+Kw95/i2jfgf52E4LGfLEo2Xy61Tbw6ztvLRt
         hlLYI7wJhoOrWLJDdh4kOSuZW54wNe1yTiWgVHoI=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Lee Jackson <lee.jackson@arducam.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        kieran.bingham@ideasonboard.com,
        Marco Felsch <m.felsch@pengutronix.de>,
        jacopo.mondi@ideasonboard.com,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 0/2] media: i2c: imx519: Support for Sony IMX519 sensor
Date:   Thu, 27 Jul 2023 21:11:06 +0530
Message-Id: <20230727154108.308320-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Series adds driver support for Sony IMX519 sensor.

Lee, can do add S-o-B tags please to these patches
since I've updated your email IDs at various places from
info@ to lee.jackson@.

Thanks!

Lee Jackson (2):
  media: dt-bindings: imx519: Add IMX519 DT bindings
  media: i2c: imx519: Support for the Sony IMX519 sensor

 .../bindings/media/i2c/sony,imx519.yaml       |  113 +
 MAINTAINERS                                   |    8 +
 drivers/media/i2c/Kconfig                     |   11 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/imx519.c                    | 2134 +++++++++++++++++
 5 files changed, 2267 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx519.yaml
 create mode 100644 drivers/media/i2c/imx519.c

-- 
2.39.1

