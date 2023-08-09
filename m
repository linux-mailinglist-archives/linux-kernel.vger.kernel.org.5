Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A52E7767FF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjHITLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHITLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:11:09 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F0910DC;
        Wed,  9 Aug 2023 12:11:08 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 379IWpv3006052;
        Wed, 9 Aug 2023 14:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=c
        3UmN3W3hnAkVHfz+DpAEuGrW04DcJ3EBtovN9KSjfI=; b=LRfC4hx/yrgzyck74
        FSeiZo1x8MQa+0oNaknPyW5dzAyF7eF8ChDmi5AgI8H+6QfcHLnCjDB4ypXUWbPX
        Ghaa/bkOOENTZJvzNush3FWXmID+kyHMaKab7HQCUEQbRKvMigqS+T/ZjrpqQH7E
        o77AteKTLXPqvGsqWIYS/BuIKPxIC9+sDeVjzwCPkQ9fKtC6FwKBFzc3nMNuRrgL
        HQhihgYTyoc2h8NCNe/o3cgrt0Jl4oZ4HEDgvWVtvhqjwv/ZPOP7qUtT80RQZj2z
        A6ar2aUap1LP1n+s19xwGAdrB0p+zYqskHbVZFN/NsD1vYZhcdYPCIzl53MZqPcI
        4hiIA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s9juhv39u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 14:10:36 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 20:10:35 +0100
Received: from aus-sw-rshr002.ad.cirrus.com (141.131.215.158) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30 via Frontend Transport; Wed, 9 Aug 2023 20:10:34 +0100
Received: by aus-sw-rshr002.ad.cirrus.com (Postfix, from userid 46936)
        id D8B484C0CD1; Wed,  9 Aug 2023 19:10:33 +0000 (UTC)
From:   James Ogletree <james.ogletree@cirrus.com>
To:     <dmitry.torokhov@gmail.com>
CC:     James Ogletree <james.ogletree@cirrus.com>,
        Fred Treven <fred.treven@cirrus.com>,
        Ben Bright <ben.bright@cirrus.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Lee Jones" <lee@kernel.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        "ChiYuan Huang" <cy_huang@richtek.com>,
        Joel Stanley <joel@jms.id.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Jacky Bai <ping.bai@nxp.com>,
        Jean Delvare <jdelvare@suse.de>,
        Eddie James <eajames@linux.ibm.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        <patches@cirrus.com>, <linux-input@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] Add support for CS40L50
Date:   Wed, 9 Aug 2023 19:10:26 +0000
Message-ID: <20230809191032.820271-1-james.ogletree@cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: waT-EpVnCsdJxFO7wu69KbhCVnabLtRO
X-Proofpoint-ORIG-GUID: waT-EpVnCsdJxFO7wu69KbhCVnabLtRO
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
- Fix checkpatch warnings

Changes in v3:
- YAML formatting corrections
- Fix typo in MAINTAINERS
- Use generic node name "haptic-driver"
- Fix regulator error code path
- Use sizeof(*)
- Remove tree reference in MAINTAINERS

James Ogletree (2):
  dt-bindings: input: cirrus,cs40l50: Support for CS40L50
  Input: cs40l50 - Initial support for Cirrus Logic CS40L50

 .../bindings/input/cirrus,cs40l50.yaml        |   77 ++
 MAINTAINERS                                   |   10 +
 drivers/input/misc/Kconfig                    |   33 +
 drivers/input/misc/Makefile                   |    3 +
 drivers/input/misc/cs40l50-i2c.c              |   67 ++
 drivers/input/misc/cs40l50-spi.c              |   67 ++
 drivers/input/misc/cs40l50.c                  | 1008 +++++++++++++++++
 include/linux/input/cs40l50.h                 |  321 ++++++
 8 files changed, 1586 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/cirrus,cs40l50.yaml
 create mode 100644 drivers/input/misc/cs40l50-i2c.c
 create mode 100644 drivers/input/misc/cs40l50-spi.c
 create mode 100644 drivers/input/misc/cs40l50.c
 create mode 100644 include/linux/input/cs40l50.h

-- 
2.25.1

