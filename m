Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0601475FAFE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjGXPjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjGXPjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:39:31 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DF6E5A;
        Mon, 24 Jul 2023 08:39:25 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36OFdDEr105741;
        Mon, 24 Jul 2023 10:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690213153;
        bh=jHf1+YHcvRTgeIgRDILeKSMz+Sy3wzGvBzTKbbw5fto=;
        h=From:To:CC:Subject:Date;
        b=rDPsJaY6dowhP8j9yxBL6a+karBkPKJ24xhNVzzsR8hi9MRvtOfTNBd/CLXrk3+6w
         GYLNrPoEHOUeW8DmXcVCET2kcd/YxlC8ti+xDLolemqrE+3xSuAY2OStvj/GkQJJpM
         jXKi2y+mAxmR4Z2+5t1aPCvffoh1WNEI/SAt1fiU=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36OFdDUc018401
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Jul 2023 10:39:13 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Jul 2023 10:39:13 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Jul 2023 10:39:13 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36OFdDsj126997;
        Mon, 24 Jul 2023 10:39:13 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tony Lindgren <tony@atomide.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/5] dt-bindings: opp/cpufreq: Convert ti-cpufreq to
Date:   Mon, 24 Jul 2023 10:39:06 -0500
Message-ID: <20230724153911.1376830-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Patches 1-3 are probably meant for omap tree via Tony and cleansup the
existing tree while the patches 4-5 convert the exiting txt bindings to
yaml.

This series also fixes up a bunch of dtbs_check warnings introduced into
the arm64/boot/dts/ti tree as well.

Nishanth Menon (5):
  arm: dts: ti: omap: omap36xx: Rename opp_supply nodename
  arm: dts: ti: omap: am5729-beagleboneai: Drop the OPP
  arm: dts: ti: omap: Fix OPP table node names
  dt-bindings: opp: Convert ti-omap5-opp-supply.txt to yaml binding
  dt-bindings: cpufreq: Convert ti-cpufreq.txt to yaml binding

 .../bindings/cpufreq/ti-cpufreq.txt           | 132 ------------------
 .../bindings/opp/opp-v2-ti-cpu.yaml           |  88 ++++++++++++
 .../bindings/opp/ti,omap-opp-supply.yaml      | 108 ++++++++++++++
 .../bindings/opp/ti-omap5-opp-supply.txt      |  63 ---------
 .../arm/boot/dts/ti/omap/am335x-boneblack.dts |   3 +-
 .../dts/ti/omap/am335x-osd335x-common.dtsi    |   3 +-
 arch/arm/boot/dts/ti/omap/am33xx.dtsi         |  30 ++--
 arch/arm/boot/dts/ti/omap/am3517.dtsi         |   6 +-
 arch/arm/boot/dts/ti/omap/am4372.dtsi         |  15 +-
 arch/arm/boot/dts/ti/omap/am437x-idk-evm.dts  |   6 +-
 .../boot/dts/ti/omap/am5729-beagleboneai.dts  |   6 -
 arch/arm/boot/dts/ti/omap/dra7.dtsi           |   9 +-
 arch/arm/boot/dts/ti/omap/dra76x.dtsi         |   3 +-
 arch/arm/boot/dts/ti/omap/omap34xx.dtsi       |  12 +-
 arch/arm/boot/dts/ti/omap/omap36xx.dtsi       |  14 +-
 15 files changed, 261 insertions(+), 237 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
 create mode 100644 Documentation/devicetree/bindings/opp/opp-v2-ti-cpu.yaml
 create mode 100644 Documentation/devicetree/bindings/opp/ti,omap-opp-supply.yaml
 delete mode 100644 Documentation/devicetree/bindings/opp/ti-omap5-opp-supply.txt

-- 
2.40.0

