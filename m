Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A281767382
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbjG1RfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbjG1RfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:35:00 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E14C35B8;
        Fri, 28 Jul 2023 10:34:58 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36SHYeAi002916;
        Fri, 28 Jul 2023 12:34:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690565680;
        bh=RP+HRN01GvCpuLHa+K+zuLzVcQpXjb4bgF/7YnW6uXY=;
        h=From:To:CC:Subject:Date;
        b=x4TQFCgvRLIeBk11C/rA5lqYLyzy9Ugq/Tvgkz3I+HPjulOqozoo3mg4b5ejiIGi5
         GOdXApZWMSR3o7cPX8r9R+PuGibnAJAr/EHPhq6dsUEexS+AG7X5JwV2MGxa2dJ1oa
         l3RkIFm1nI7xSgZOfO192OPtIEVxneFwhPgYNO9k=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36SHYeBp061014
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Jul 2023 12:34:40 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jul 2023 12:34:40 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jul 2023 12:34:40 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36SHYdiu003961;
        Fri, 28 Jul 2023 12:34:39 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH v3 0/8] arm64: ti: k3-am62: Add display support
Date:   Fri, 28 Jul 2023 23:04:30 +0530
Message-ID: <20230728173438.12995-1-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Reviving this old patch series, after a long time. This was paused
because the compatible for the Display SubSystem (DSS) had to be
changed, along with the driver.

The patch series adds DT nodes for Display SubSystem (DSS) and other
peripherals required to enable the HDMI audio and video on the AM625 SK,
AM62-LP SK, as well as the AM625 based Beagle-Play platforms. An HDMI
monitor can be connected to the boards for the audio/video outputs.

The series adding the compatible and basic driver support[0] is in the
drm-misc-next and linux-next queues and is expected to be in the
mainline by v6.6-rc1.

Patches 5 and 7 have been picked up from TI's linux tree[1] based off
linux-kernel v6.1.

Change Log:
V2 -> V3:
  - Updated the compatible from "ti,am65x-dss" to "ti,am625-dss".
  - Peripheral nodes like HDMI TX, HDMI connector are now added to
    k3-am62x-sk-common.dtsi instead of k3-am625-sk.dts, in order to
    support AM62-LP SK-EVM as well.
  - Dropped the HDMI master clock node as it is not connected on the
    EVM, and should not have been added in the first place.
  - Re-worded and Re-ordered commits.
  - Dropped Rahul Ravikumar's R-bs because of the changes.
  - Added AM625 based Beagle-Play for HDMI support.
  - Added HDMI audio support as well.

V1 -> V2:
 - Removed repetitive data in dss_ports

V2: https://lore.kernel.org/all/20220505134303.23208-1-a-bhatia1@ti.com/
V1: https://lore.kernel.org/all/20220427090850.32280-1-a-bhatia1@ti.com/

[0]: https://lore.kernel.org/all/20230616150900.6617-1-a-bhatia1@ti.com/
[1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/log/?h=ti-linux-6.1.y-cicd

Aradhya Bhatia (6):
  arm64: dts: ti: k3-am62x-sk-common: Update main-i2c1 frequency
  arm64: dts: ti: k3-am62-main: Add node for Display SubSystem
  arm64: dts: ti: k3-am62x-sk-common: Add DSS pinmux info
  arm64: dts: ti: k3-am62x-sk-common: Add support for HDMI output
  arm64: dts: ti: k3-am625-beagleplay: Add DSS pinmux info
  arm64: defconfig: Enable ITE_IT66121 HDMI transmitter

Jai Luthra (1):
  arm64: dts: ti: am62x-sk: Add overlay for HDMI audio

Nishanth Menon (1):
  arm64: dts: ti: k3-am625-beagleplay: Add HDMI support

 arch/arm64/boot/dts/ti/Makefile               |   3 +
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      |  23 +++
 .../arm64/boot/dts/ti/k3-am625-beagleplay.dts | 182 ++++++++++++++++++
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 119 +++++++++++-
 .../boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso   |  40 ++++
 arch/arm64/configs/defconfig                  |   1 +
 6 files changed, 367 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso

-- 
2.40.1

