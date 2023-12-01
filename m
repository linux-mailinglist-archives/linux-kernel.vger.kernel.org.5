Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EE880055F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377805AbjLAIUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjLAIUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:20:49 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777AB1711;
        Fri,  1 Dec 2023 00:20:55 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B18KkJt117998;
        Fri, 1 Dec 2023 02:20:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701418846;
        bh=DJncCBeXfr2wI08BAiTIZthGqiZyXSwntyS7s1P3QJM=;
        h=From:To:CC:Subject:Date;
        b=GRjaGjoNmwlhgqGmlSwk5b/WMClqMKUgebQnj4MDHHTtRoJWkAYR4mPT5D+wNKuNp
         A5GWHKt+MeOEJZFLcACzPaE48Lf7TgHGhnq5K3iOhWOudXWb0vnei8HcU6KeFCbMjw
         wq5ft4DzunSmktwEXHUEZhGBXwoLpL50nMi36Op0=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B18Kkik006061
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Dec 2023 02:20:46 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Dec 2023 02:20:46 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Dec 2023 02:20:46 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B18KjMO032651;
        Fri, 1 Dec 2023 02:20:46 -0600
From:   Bhavya Kapoor <b-kapoor@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <kristo@kernel.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <b-kapoor@ti.com>
Subject: [PATCH 0/3] arm64: dts: ti: Add Itap Delay Value For High Speed DDR
Date:   Fri, 1 Dec 2023 13:50:42 +0530
Message-ID: <20231201082045.790478-1-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
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

This Series adds Itap Delay Value for DDR52 speed mode for eMMC in
J7200 and for DDR50 speed mode for MMCSD in J721s2 and J784s4 SoC.

Rebased to next-20231201

Bhavya Kapoor (3):
  arm64: dts: ti: k3-j7200-main: Add Itap Delay Value For DDR52 speed
    mode
  arm64: dts: ti: k3-j721s2-main: Add Itap Delay Value For DDR50 speed
    mode
  arm64: dts: ti: k3-j784s4-main: Add Itap Delay Value For DDR50 speed
    mode

 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi  | 1 +
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 1 +
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 1 +
 3 files changed, 3 insertions(+)

-- 
2.34.1

