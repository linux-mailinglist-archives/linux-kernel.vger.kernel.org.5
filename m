Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37618119C4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjLMQmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjLMQmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:42:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12AF98
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:42:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C55BC433C8;
        Wed, 13 Dec 2023 16:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702485777;
        bh=i70rLgrJWZQl/7kOucCjrKxAdNgKJPgfg9aAZjgbDEY=;
        h=From:To:Cc:Subject:Date:From;
        b=VZjzpZkN9AHtW5Qg9tPr0eCc9IaNCr+lxmqqyVO0HpiEQoRlxov9ubT8hR72EPvmL
         IZc3GLOR2oAhwjw+PkbJcbi2nIaZLk3p/egeRcv1FxFIrahsh4zVHBuiqNV0np7/D7
         ab2SWhfCglAWrTD3joFq/sjVNmrEUKeNcnMB2QshtD4csK1mZI1StvxBXSsJlWqyTS
         ky4jt3rPORytlBDD2T+c+FqCznvh4W2D4TNOPUaZeSYnLpDflsh8Pxsq3GCSKKW2AG
         bpSNJ3Jhq63QMeNoDSyMu+riQr8CHPCGf+O7rS1QlLpLQZOQxOBCxcS5+1EPIoqsU3
         HPh+qJ9DbDMgA==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Bryan Wu <cooloney@kernel.org>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Hema HK <hemahk@ti.com>, James Gruber <jimmyjgruber@gmail.com>,
        Jaswinder Singh <jaswinder.singh@linaro.org>,
        Julian Scheel <julian@jusst.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Tomoki Sekiyama <tomoki.sekiyama@gmail.com>,
        usb-storage@lists.one-eyed-alien.net,
        Yadwinder Singh <yadi.brar01@gmail.com>
Subject: [PATCH 00/12] usb: Replace {v}snprintf() variants with safer alternatives
Date:   Wed, 13 Dec 2023 16:42:29 +0000
Message-ID: <20231213164246.1021885-1-lee@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is part of an effort to rid {v}snprintf() where possible.

For a far better description of the problem than I could author, see
Jon's write-up on LWN [1] and/or Alex's on the Kernel Self Protection
Project [1].

[0] https://lwn.net/Articles/69419/
[1] https://github.com/KSPP/linux/issues/105

Lee Jones (12):
  usb: gadget: configfs: Replace snprintf() with the safer scnprintf()
    variant
  usb: gadget: f_uac1: Replace snprintf() with the safer scnprintf()
    variant
  usb: gadget: f_uac2: Replace snprintf() with the safer scnprintf()
    variant
  usb: gadget: uvc: Replace snprintf() with the safer scnprintf()
    variant
  usb: gadget: udc: atmel: Replace snprintf() with the safer scnprintf()
    variant
  usb: cdns2: Replace snprintf() with the safer scnprintf() variant
  usb: host: max3421-hcd: Replace snprintf() with the safer scnprintf()
    variant
  usb: yurex: Replace snprintf() with the safer scnprintf() variant
  usb: mon_stat: Replace snprintf() with the safer scnprintf() variant
  usb: mon_text: Replace snprintf() with the safer scnprintf() variant
  usb: phy: twl6030: Remove snprintf() from sysfs call-backs and replace
    with sysfs_emit()
  usb: storage: Remove snprintf() from sysfs call-backs and replace with
    sysfs_emit()

 drivers/usb/gadget/configfs.c              |  11 +-
 drivers/usb/gadget/function/f_uac1.c       |   6 +-
 drivers/usb/gadget/function/f_uac2.c       |   6 +-
 drivers/usb/gadget/function/uvc_configfs.c |   2 +-
 drivers/usb/gadget/udc/atmel_usba_udc.c    |   3 +-
 drivers/usb/gadget/udc/cdns2/cdns2-debug.h | 138 ++++++++++-----------
 drivers/usb/host/max3421-hcd.c             |  18 +--
 drivers/usb/misc/yurex.c                   |  12 +-
 drivers/usb/mon/mon_stat.c                 |   6 +-
 drivers/usb/mon/mon_text.c                 |  28 +----
 drivers/usb/phy/phy-twl6030-usb.c          |   8 +-
 drivers/usb/storage/sierra_ms.c            |  16 +--
 12 files changed, 120 insertions(+), 134 deletions(-)

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
Cc: Bryan Wu <cooloney@kernel.org>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Cristian Birsan <cristian.birsan@microchip.com>
Cc: Daniel Scally <dan.scally@ideasonboard.com>
Cc: Hema HK <hemahk@ti.com>
Cc: James Gruber <jimmyjgruber@gmail.com>
Cc: Jaswinder Singh <jaswinder.singh@linaro.org>
Cc: Julian Scheel <julian@jusst.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Pawel Laszczak <pawell@cadence.com>
Cc: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc: Tomoki Sekiyama <tomoki.sekiyama@gmail.com>
Cc: usb-storage@lists.one-eyed-alien.net
Cc: Yadwinder Singh <yadi.brar01@gmail.com>
-- 
2.43.0.472.g3155946c3a-goog

