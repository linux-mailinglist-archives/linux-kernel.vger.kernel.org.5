Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76C0779875
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjHKUXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjHKUXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:23:10 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914B0D3;
        Fri, 11 Aug 2023 13:23:08 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BKMvKe089828;
        Fri, 11 Aug 2023 15:22:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691785377;
        bh=aT9zc8OmPOr5VHaVovhnDtQDqiUsRKxxduzEWZtX0xk=;
        h=From:To:Subject:Date;
        b=AUADqh3VL6aIrDMQIHSMeQn4yb3rN+iaN9cmHyV1hr1+UCe32cRvjEGI2su1PvinS
         b88kdJjF4xQCZ8JySJtSTf0sHBlKv7FF1BNvkJcybuPeCahCXu8W01H0N/I6YUfTRQ
         SXvM8+zgnSBoskohemmUK3eYAfNUhHPPkyVltLok=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BKMvD2124125
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 15:22:57 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 15:22:56 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 15:22:56 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BKMr53055948;
        Fri, 11 Aug 2023 15:22:54 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Apurva Nandan <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hari Nagalla <hnagalla@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v3 0/5] Add R5F and C7x DSP nodes for J721S2 SoC.
Date:   Sat, 12 Aug 2023 01:52:47 +0530
Message-ID: <20230811202252.3586926-1-a-nandan@ti.com>
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

This series adds the R5F processor nodes and C7x DSP nodes for 
J721S2 SoC.

The first three patches adds the remote proc nodes to the SoC device
tree and the last two patches reserves the memory for remote proc IPCs
on J721S2 EVM board.

Test log: https://gist.githubusercontent.com/apurvanandan1997/556b4148651ae74b50dda993ad07f1e5/raw/

v3: Changelog:
1) Disabled c7x in k3-j721s2-main.dtsi and enabled in k3-j721s2-som-p0.dtsi
   which fixes the following dtbs_check for k3-am69-sk.dts
   - dsp@64800000: 'mboxes' is a required property
   - dsp@64800000: 'memory-region' is a required property
2) Split into separate patches for C7x and R5F

Link to v2:
https://lore.kernel.org/lkml/20230808201842.292911-1-a-nandan@ti.com/

v2:Changelog:
1) Added status = "disabled"; in soc dtsi files, and removed it from som dts
2) Fixed mboxes property in for all cores in som dts

Link to v1:
https://lore.kernel.org/all/20230529220941.10801-1-hnagalla@ti.com/

Apurva Nandan (4):
  arm64: dts: ti: k3-j721s2-main: Add MAIN R5F remote processsor nodes
  arm64: dts: ti: k3-j721s2-main: Add C7x remote processsor nodes
  arm64: dts : ti: k3-j721s2-som-p0: Add DDR carveout memory nodes for
    R5F
  arm64: dts : ti: k3-j721s2-som-p0: Add DDR carveout memory nodes for
    C71x DSPs

Hari Nagalla (1):
  arm64: dts: ti: k3-j721s2-mcu: Add MCU R5F cluster nodes

 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 106 +++++++++
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |  40 ++++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  | 208 ++++++++++++++++++
 3 files changed, 354 insertions(+)

-- 
2.34.1

