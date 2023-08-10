Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0E6776D51
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 02:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjHJA7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 20:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjHJA7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 20:59:02 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35A81982;
        Wed,  9 Aug 2023 17:59:01 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37A0wr8u009450;
        Wed, 9 Aug 2023 19:58:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691629133;
        bh=8XOSbvtoN1GYhrzODnBbU3a1ecMQHQ6sH0pAkhRLzig=;
        h=From:To:CC:Subject:Date;
        b=JQiXVvbJK5Gb52Ag2HfxF4vh9BjeebgAwd7Slo4ytd3oAMjesz0/o9MGOKnmkzMmm
         +nrgn7PZuAEYI7NrCGk0GW4wtYJrBVMgPETZyv2imFC7/Cum6fksz/+UrxQcfEX5wr
         PrnoptYrrmgmxNxE2wqykLigArbE9FVIEJVmi2h4=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37A0wrHn072653
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 19:58:53 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 19:58:53 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 19:58:53 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37A0wqDl030675;
        Wed, 9 Aug 2023 19:58:52 -0500
From:   Hari Nagalla <hnagalla@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 0/5] Add R5F and C7x DSP nodes for AM62a SoC
Date:   Wed, 9 Aug 2023 19:58:45 -0500
Message-ID: <20230810005850.21998-1-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds R5F and C7x dsp processor nodes for AM62A SoC.
The first patch amends the dsp node binding doc file and the remaining
patches configure the remote processor device nodes.

v1: https://lore.kernel.org/all/20230502141416.9924-1-hnagalla@ti.com/ 

Devarsh Thakkar (2):
  arm64: dts: k3-am62a-wakeup: Add R5F device node
  arm64: dts: ti: k3-am62a7-sk: Enable ipc with remote proc nodes

Hari Nagalla (2):
  dt-bindings: remoteproc: k3-dsp: correct optional sram properties for
    AM62A SoCs
  arm64: dts: k3-am62a-mcu: Add R5F remote proc node

Jai Luthra (1):
  arm64: dts: k3-am62a-main: Add C7xv device node

 .../bindings/remoteproc/ti,k3-dsp-rproc.yaml  | 16 ++++-
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi     | 11 +++
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi      | 35 ++++++++++
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi   | 23 +++++++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts       | 68 +++++++++++++++++++
 5 files changed, 151 insertions(+), 2 deletions(-)

-- 
2.34.1

