Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709A07761C7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjHINyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjHINyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:54:50 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D36598;
        Wed,  9 Aug 2023 06:54:50 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 379CrDND002197;
        Wed, 9 Aug 2023 08:54:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=w
        zv8wFOMXFLMdscI/4R9TEsLJO/SH4e1EZbywwAqkiY=; b=Qb2r/QK///w5qGTi6
        Id2HEaHfDeLPSe4D+afLoc89c563vVsCeXbO6puUtz5pUHgRLFR1WKiq2e8FHyLZ
        +XWaoiKzeXI+egKY3LOIrxUp3W5t5TmMGBYZFY1bduLTAkGkVUpXfkveRpUi+Gir
        jA7XfJ0R487sAMhiBLr8+e9fQ1WGnV+/HZ9fatig24M9UbH+y5GmHo3QX5MNQoXJ
        40LGWUmTtoPoUr8yAoODTBKD1VLqrGexxCc/fnLGy2nmF9rd5tThKoNA4MWh4Pfj
        uIdxfHoydjjY4htk9X+6bobOjBiPiq4W3yAb/6dNglaTPvK529RfjjNVXiCfBGtr
        kqCMA==
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sb7vtag9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 08:54:05 -0500 (CDT)
Received: from m0077473.ppops.net (m0077473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.22/8.17.1.22) with ESMTP id 379Ds5TQ022143;
        Wed, 9 Aug 2023 08:54:05 -0500
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sb7vtag9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 08:54:05 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 14:54:02 +0100
Received: from aus-sw-rshr002.ad.cirrus.com (141.131.215.158) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Wed, 9 Aug 2023 14:54:02 +0100
Received: by aus-sw-rshr002.ad.cirrus.com (Postfix, from userid 46936)
        id 54FBC4C0CD1; Wed,  9 Aug 2023 13:54:02 +0000 (UTC)
From:   James Ogletree <james.ogletree@cirrus.com>
To:     <dmitry.torokhov@gmail.com>
CC:     James Ogletree <james.ogletree@cirrus.com>,
        Fred Treven <fred.treven@cirrus.com>,
        Ben Bright <ben.bright@cirrus.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Lee Jones" <lee@kernel.org>, ChiYuan Huang <cy_huang@richtek.com>,
        Eddie James <eajames@linux.ibm.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        "Arnd Bergmann" <arnd@arndb.de>, Jacky Bai <ping.bai@nxp.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Jean Delvare <jdelvare@suse.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joel Stanley <joel@jms.id.au>, <patches@cirrus.com>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] Add support for CS40L50
Date:   Wed, 9 Aug 2023 13:53:08 +0000
Message-ID: <20230809135313.731706-1-james.ogletree@cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: dNe8GyaLXQiqb6LoAiPAItEOVdopn_MP
X-Proofpoint-ORIG-GUID: 2rHXDnGkkNL8M-p7A2J9ujMGHAkL9N0Z
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in V2:
- Fix checkpatch warnings

James Ogletree (2):
  dt-bindings: input: cirrus,cs40l50: Support for CS40L50
  Input: cs40l50 - Initial support for Cirrus Logic CS40L50

 .../bindings/input/cirrus,cs40l50.yaml        |   77 ++
 MAINTAINERS                                   |   11 +
 drivers/input/misc/Kconfig                    |   33 +
 drivers/input/misc/Makefile                   |    3 +
 drivers/input/misc/cs40l50-i2c.c              |   67 ++
 drivers/input/misc/cs40l50-spi.c              |   67 ++
 drivers/input/misc/cs40l50.c                  | 1013 +++++++++++++++++
 include/linux/input/cs40l50.h                 |  321 ++++++
 8 files changed, 1592 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/cirrus,cs40l50.yaml
 create mode 100644 drivers/input/misc/cs40l50-i2c.c
 create mode 100644 drivers/input/misc/cs40l50-spi.c
 create mode 100644 drivers/input/misc/cs40l50.c
 create mode 100644 include/linux/input/cs40l50.h

-- 
2.25.1

