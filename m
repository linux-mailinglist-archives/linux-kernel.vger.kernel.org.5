Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92F377668E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjHIRjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjHIRjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:39:31 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F48E71;
        Wed,  9 Aug 2023 10:39:31 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379HdCZw058014;
        Wed, 9 Aug 2023 12:39:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691602752;
        bh=DW02Hdws2cTgi1idHFvVaz8VmWVCgengNghKzecN+S8=;
        h=From:To:Subject:Date;
        b=RaA5ZPuttkZ2kC8EEl8F6MlIGEEMvA1BPGRR6RB/IC5y+kC5lu2IWgn8psRWTb+hE
         rdjMi/AMKD9WO5/L2JqA+Iv0g5LITo5enI/xFAmGk/M8/XyWzxw1Fja0F3MbYrEJQK
         bySdT/g6mqrA7QApovmKBn0d/EW1cFir5M15fIpQ=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379HdCFM097117
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 12:39:12 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 12:39:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 12:39:10 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379Hd6ga077353;
        Wed, 9 Aug 2023 12:39:06 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Apurva Nandan <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rafael J Wysocki <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Keerthy J <j-keerthy@ti.com>
Subject: [PATCH 0/3] Add support for thermal mitigation for K3 J7200 SoC
Date:   Wed, 9 Aug 2023 23:09:02 +0530
Message-ID: <20230809173905.1844132-1-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for thermal mitigation using the CPUFREQ for K3 J7200 SoC.
K3 J7200 SoC supports Dynamic Frequency Scaling(DFS) for A72 & this can
be used to drop the cpu frequency using cpufreq to produce a cooling
effect in the SoC.

Keerthy (3):
  thermal: k3_j72xx_bandgap: Add cooling device support
  arm64: dts: ti: k3-j7200: Add the supported frequencies for A72
  arm64: dts: ti: k3-j7200-thermal: Add cooling maps and cpu_alert trip
    at 75C

 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi |  14 +++
 arch/arm64/boot/dts/ti/k3-j7200.dtsi         |  28 +++++
 drivers/thermal/k3_j72xx_bandgap.c           | 121 +++++++++++++++++++
 3 files changed, 163 insertions(+)

-- 
2.34.1

