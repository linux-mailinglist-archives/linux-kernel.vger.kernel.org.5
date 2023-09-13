Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3799D79E670
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239966AbjIMLRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237605AbjIMLRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:17:15 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3781BD1;
        Wed, 13 Sep 2023 04:17:11 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38DBGrP4029335;
        Wed, 13 Sep 2023 06:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694603813;
        bh=iwopYHKycH/d3Lm1X7x5sKpzyN7SrYd9qhdLWvscRNI=;
        h=From:To:CC:Subject:Date;
        b=oW52qQSSnqiynfndgbF5WkQ5yzjf6/QvgsmAOEbKG88AQcftvOODwqw97HLBBCe6p
         bsm6JCmXuwdtG/j7q+a+VGYd7D4v55BI35yiMLu7nNHxktvUCkVRv9kpYSbETnpQRM
         +7Kw9DGlDFnKxBzFDHvjyKnme74cVLj9L6e9/bFQ=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38DBGr2h098065
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Sep 2023 06:16:53 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Sep 2023 06:16:53 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Sep 2023 06:16:53 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38DBGr8s003631;
        Wed, 13 Sep 2023 06:16:53 -0500
From:   Hari Nagalla <hnagalla@ti.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <p.zabel@pengutronix.de>, <martyn.welch@collabora.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v6 0/4] TI K3 M4F support on AM64x and AM62x SoCs 
Date:   Wed, 13 Sep 2023 06:16:40 -0500
Message-ID: <20230913111644.29889-1-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series introduces K3 M4F remoteproc driver support for
AM64x and AM62x SoC families. These SoCs have a ARM Cortex M4F core in
the MCU voltage domain. For safety oriented applications, this core is
operated independently with out any IPC to other cores on the SoC.
However, for non safety applications, some customers use it as a remote
processor and so linux remote proc support is extended to the M4F core.

See AM64x Technical Reference Manual (SPRUIM2C – SEPTEMBER 2021) for
further details: https://www.ti.com/lit/pdf/SPRUIM2

See AM62x Technical Reference Manual (SPRUIV7A – MAY 2022) for
further details: https://www.ti.com/lit/pdf/SPRUIV7A

Hari Nagalla (1):
  dt-bindings: remoteproc: k3-m4f: Add K3 AM64x SoCs

Martyn Welch (3):
  remoteproc: k3: Split out data structures common with M4 driver
  remoteproc: k3: Split out functions common with M4 driver
  remoteproc: k3-m4: Add a remoteproc driver for M4F subsystem

 .../bindings/remoteproc/ti,k3-m4f-rproc.yaml  | 136 ++++
 drivers/remoteproc/Kconfig                    |  13 +
 drivers/remoteproc/Makefile                   |   3 +-
 drivers/remoteproc/ti_k3_common.c             | 513 +++++++++++++++
 drivers/remoteproc/ti_k3_common.h             | 103 +++
 drivers/remoteproc/ti_k3_dsp_remoteproc.c     | 598 +-----------------
 drivers/remoteproc/ti_k3_m4_remoteproc.c      | 331 ++++++++++
 7 files changed, 1127 insertions(+), 570 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
 create mode 100644 drivers/remoteproc/ti_k3_common.c
 create mode 100644 drivers/remoteproc/ti_k3_common.h
 create mode 100644 drivers/remoteproc/ti_k3_m4_remoteproc.c

-- 
2.34.1

