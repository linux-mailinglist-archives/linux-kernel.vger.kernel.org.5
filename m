Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EE17CE59F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344608AbjJRR6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjJRR57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:57:59 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BA01AB;
        Wed, 18 Oct 2023 10:57:53 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39I5YN72000966;
        Wed, 18 Oct 2023 12:57:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=q
        eX7pmeDThbZJ5XEVeY493tQsiruFyR0Vjp7sszjW9Q=; b=Cvd7JflpwLdb72wU8
        oDcff5R4Y9GZC/uaJSJFSdDrXOMSlIPgxOVx1M8wAgaSp4aI1PUiy1RcwsQ5FUDS
        Toj9twH9foMgcEjpQ4F6cneOCpQLuH1zMDFZmSJtcyM/YsqWnAyqwFG4qehC9Xpn
        NsHH/zArchjT7FmNDCe9IPLcR9FWPppqk7vsiqgxgs/zzxb9tgAM+Ajmg608QX+3
        CAPsoMPabLUAVB7b5qhP6svQpdcBbu0HBSYSIvUR1vgUOXAB0rVk5c4pnjlHNGk/
        a2VVzNaFbhABLpSYIZLKAkpOKcMJZ10uqqQpl8EuIama6FEVtPT+kF30oZhO9gYa
        Zmtsg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3tqrcw6n6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 12:57:42 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 18 Oct
 2023 18:57:39 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Wed, 18 Oct 2023 18:57:39 +0100
Received: from aus-sw-rshr002.ad.cirrus.com (aus-sw-rshr002.ad.cirrus.com [141.131.145.53])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4BE20458;
        Wed, 18 Oct 2023 17:57:38 +0000 (UTC)
From:   James Ogletree <james.ogletree@opensource.cirrus.com>
CC:     James Ogletree <james.ogletree@cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Fred Treven <fred.treven@cirrus.com>,
        Ben Bright <ben.bright@cirrus.com>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/4] Add support for CS40L50
Date:   Wed, 18 Oct 2023 17:57:21 +0000
Message-ID: <20231018175726.3879955-1-james.ogletree@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: o8M-gExX3u65-0iA2utk737nFnCy12E_
X-Proofpoint-ORIG-GUID: o8M-gExX3u65-0iA2utk737nFnCy12E_
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Ogletree <james.ogletree@cirrus.com>

This patch series adds support for Cirrus Logic CS40L50, a haptic driver.

While I2S streaming to the device will need to be supported in the future,
no codec driver is included in this submission and therefore this MFD
driver has just one component. A bare bones codec driver can be created
and included if maintainers prefer.

Changes in v4:
- Move from Input to MFD
- Move common Cirrus haptic functions to a library
- Incorporate runtime PM framework
- Coding style related improvements

Changes in v3:
- YAML formatting corrections
- Fix typo in MAINTAINERS
- Use generic node name "haptic-driver"
- Fix probe error code paths
- Use sizeof(*)
- Remove tree reference in MAINTAINERS

Changes in v2:
- Fix checkpatch warnings

James Ogletree (4):
  dt-bindings: input: cirrus,cs40l50: Add initial DT binding
  Input: cs40l50 - Add cirrus haptics base support
  mfd: cs40l50: Add support for CS40L50 core driver
  Input: cs40l50 - Add support for the CS40L50 haptic driver

 .../bindings/input/cirrus,cs40l50.yaml        |  70 +++
 MAINTAINERS                                   |  13 +
 drivers/input/misc/Kconfig                    |  10 +
 drivers/input/misc/Makefile                   |   1 +
 drivers/input/misc/cirrus_haptics.c           | 586 ++++++++++++++++++
 drivers/input/misc/cs40l50-vibra.c            | 353 +++++++++++
 drivers/mfd/Kconfig                           |  30 +
 drivers/mfd/Makefile                          |   4 +
 drivers/mfd/cs40l50-core.c                    | 443 +++++++++++++
 drivers/mfd/cs40l50-i2c.c                     |  69 +++
 drivers/mfd/cs40l50-spi.c                     |  68 ++
 include/linux/input/cirrus_haptics.h          | 121 ++++
 include/linux/mfd/cs40l50.h                   | 198 ++++++
 13 files changed, 1966 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/cirrus,cs40l50.yaml
 create mode 100644 drivers/input/misc/cirrus_haptics.c
 create mode 100644 drivers/input/misc/cs40l50-vibra.c
 create mode 100644 drivers/mfd/cs40l50-core.c
 create mode 100644 drivers/mfd/cs40l50-i2c.c
 create mode 100644 drivers/mfd/cs40l50-spi.c
 create mode 100644 include/linux/input/cirrus_haptics.h
 create mode 100644 include/linux/mfd/cs40l50.h

-- 
2.25.1

