Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988EF7610AD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbjGYKZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjGYKZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:25:52 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9172610DC;
        Tue, 25 Jul 2023 03:25:51 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36P5SPLC027052;
        Tue, 25 Jul 2023 05:25:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=R
        qnEvulVbTp72yIIkFG83AR9zXle457tl0dD1DxHoGQ=; b=L2rM02seFiVgBEtjj
        ob6S2Mn7UM/BMbeiisa48o0Y1m92BkMYJFefmebvnKocVp7elgjs/fUFg/4W2D/3
        qZiCr15n76LsMOwAOvz+UUHZO6mD20fAM62to0RKhU3ZFvij6R3Ys6t+S0nldDND
        dsA57PtA3n1eLVWZQ+n/mn1tOK6PHoHtzsKVM1JjrhbPd0PN+KoPJGM/t23K7PdE
        E0xELwm9VRkUqDC6aVnMAstktu5Ihwj4T/h5uGvq6KlrfJ2AdMYd+3GBjueTNvGN
        QGPSKMtkIxBgU+Br/N4SwK15pEd6vnL60zqYusypOdj92PWoAKlQL6GRsneOBgcY
        V5mTw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3s0cgxu6yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 05:25:34 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 25 Jul
 2023 11:25:32 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Tue, 25 Jul 2023 11:25:32 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4C8B211AB;
        Tue, 25 Jul 2023 10:25:32 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>, <lee@kernel.org>, <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linus.walleij@linaro.org>,
        <lgirdwood@gmail.com>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>, <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 0/6] Add cs42l43 PC focused SoundWire CODEC
Date:   Tue, 25 Jul 2023 11:25:26 +0100
Message-ID: <20230725102532.2567580-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: iZ6ya1_9bcp2O4e2-WwJRXEtsTzh639l
X-Proofpoint-GUID: iZ6ya1_9bcp2O4e2-WwJRXEtsTzh639l
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch chain adds support for the Cirrus Logic cs42l43 PC focused
SoundWire CODEC. The chain is currently based of Lee's for-mfd-next
branch.

This series is mostly just a resend keeping pace with the kernel under
it, except for a minor fixup in the spi stuff.

Thanks,
Charles

Charles Keepax (4):
  dt-bindings: mfd: cirrus,cs42l43: Add initial DT binding
  mfd: cs42l43: Add support for cs42l43 core driver
  pinctrl: cs42l43: Add support for the cs42l43
  ASoC: cs42l43: Add support for the cs42l43

Lucas Tanure (2):
  soundwire: bus: Allow SoundWire peripherals to register IRQ handlers
  spi: cs42l43: Add SPI controller support

 .../bindings/sound/cirrus,cs42l43.yaml        |  313 +++
 MAINTAINERS                                   |    4 +
 drivers/mfd/Kconfig                           |   23 +
 drivers/mfd/Makefile                          |    3 +
 drivers/mfd/cs42l43-i2c.c                     |   98 +
 drivers/mfd/cs42l43-sdw.c                     |  239 ++
 drivers/mfd/cs42l43.c                         | 1189 +++++++++
 drivers/mfd/cs42l43.h                         |   28 +
 drivers/pinctrl/cirrus/Kconfig                |   11 +
 drivers/pinctrl/cirrus/Makefile               |    2 +
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c      |  609 +++++
 drivers/soundwire/bus.c                       |   32 +
 drivers/soundwire/bus_type.c                  |   12 +
 drivers/spi/Kconfig                           |    7 +
 drivers/spi/Makefile                          |    1 +
 drivers/spi/spi-cs42l43.c                     |  284 ++
 include/linux/mfd/cs42l43-regs.h              | 1184 +++++++++
 include/linux/mfd/cs42l43.h                   |  102 +
 include/linux/soundwire/sdw.h                 |    9 +
 include/sound/cs42l43.h                       |   17 +
 sound/soc/codecs/Kconfig                      |   16 +
 sound/soc/codecs/Makefile                     |    4 +
 sound/soc/codecs/cs42l43-jack.c               |  969 +++++++
 sound/soc/codecs/cs42l43-sdw.c                |   74 +
 sound/soc/codecs/cs42l43.c                    | 2278 +++++++++++++++++
 sound/soc/codecs/cs42l43.h                    |  131 +
 26 files changed, 7639 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs42l43.yaml
 create mode 100644 drivers/mfd/cs42l43-i2c.c
 create mode 100644 drivers/mfd/cs42l43-sdw.c
 create mode 100644 drivers/mfd/cs42l43.c
 create mode 100644 drivers/mfd/cs42l43.h
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-cs42l43.c
 create mode 100644 drivers/spi/spi-cs42l43.c
 create mode 100644 include/linux/mfd/cs42l43-regs.h
 create mode 100644 include/linux/mfd/cs42l43.h
 create mode 100644 include/sound/cs42l43.h
 create mode 100644 sound/soc/codecs/cs42l43-jack.c
 create mode 100644 sound/soc/codecs/cs42l43-sdw.c
 create mode 100644 sound/soc/codecs/cs42l43.c
 create mode 100644 sound/soc/codecs/cs42l43.h

-- 
2.30.2

