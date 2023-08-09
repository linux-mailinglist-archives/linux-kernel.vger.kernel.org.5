Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005F47755D3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 10:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjHIIqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 04:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjHIIq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 04:46:28 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C111BD9;
        Wed,  9 Aug 2023 01:46:27 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3798k0FB069863;
        Wed, 9 Aug 2023 03:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691570760;
        bh=z2lZjb/EYROWBJKfb637ljNbM/pwM/IhgHjoVNaRqxI=;
        h=From:To:CC:Subject:Date;
        b=EQIpAxOQMaXoRITlYARdxbtV0HIOdVqIwSTg6urXLUaqGHRiaKWCZU3/gwGwtTcsT
         pjEw1JhSe3H1Y2E4lC+GDsNDHJ8wl05nBM5EyTMKFn9S0pXuXCACddO0m7ooeKDReU
         JBIQyb6TMEvtI2uqLtPgYafFUut3ux4AJKZKvmHc=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3798k09J067107
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 03:46:00 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 03:46:00 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 03:46:00 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3798jxeA112184;
        Wed, 9 Aug 2023 03:46:00 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Francesco Dolcini <francesco@dolcini.it>
CC:     Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH v5 0/6] arm64: ti: k3-am62: Add display support
Date:   Wed, 9 Aug 2023 14:15:53 +0530
Message-ID: <20230809084559.17322-1-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.40.1
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

Hi all,

The patch series adds DT nodes for Display SubSystem (DSS) and other
peripherals required to enable the HDMI audio and video on the AM625 SK,
AM62-LP SK, as well as the AM625 based Beagle-Play platforms. An HDMI
monitor can be connected to the boards for the audio/video outputs.

The series adding the compatible and basic driver support[0] is in the
drm-misc-next and linux-next queues and is expected to be in the
mainline by v6.6-rc1. Patch 5/6 also requires Nishanth Menon's patch[1]
that introduces debounce select mux macros. This patch too is not in
v6.5-rc1 but has been picked up in ti-next[2] and hence, is present in
linux-next.

Patches 4 and 5 have been picked up from TI's vendor tree[3] based off
linux-kernel v6.1.

Regards
Aradhya

Change Log:
V4 -> V5:
  - Cosmetic changes as suggested by Jayesh.
  - Fixed the mis-represented DSS VP1 clock, and added a
    fixed-factor-clock.

V3 -> V4:
  - Added "Fixes" tag for patch 1/6.
  - Rebased to linux-next.
  - Enabled display at board level and disabled at SoC level.
  - Dropped OLDI pinmux configuration as OLDI output comes directly from
    the SoC and muxing is not required.
  - Squashed DSS pinmux patches into their platform specific HDMI
    support patches, because it did not make sense to have only one set
    of pinmux config separated in a patch.

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

V4: https://lore.kernel.org/all/20230807153307.22174-1-a-bhatia1@ti.com/
V3: https://lore.kernel.org/all/20230728173438.12995-1-a-bhatia1@ti.com/
V2: https://lore.kernel.org/all/20220505134303.23208-1-a-bhatia1@ti.com/
V1: https://lore.kernel.org/all/20220427090850.32280-1-a-bhatia1@ti.com/

[0]: https://lore.kernel.org/all/20230616150900.6617-1-a-bhatia1@ti.com/
[1]: https://lore.kernel.org/all/20230619131620.3286650-1-nm@ti.com/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git/commit/?id=0bec3d7ecc7493b0e530f6f34539841ef6779006
[3]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/log/?h=ti-linux-6.1.y-cicd


Aradhya Bhatia (4):
  arm64: dts: ti: k3-am62x-sk-common: Update main-i2c1 frequency
  arm64: dts: ti: k3-am62-main: Add node for DSS
  arm64: dts: ti: k3-am62x-sk-common: Add HDMI support
  arm64: defconfig: Enable ITE_IT66121 HDMI transmitter

Jai Luthra (1):
  arm64: dts: ti: am62x-sk: Add overlay for HDMI audio

Nishanth Menon (1):
  arm64: dts: ti: k3-am625-beagleplay: Add HDMI support

 arch/arm64/boot/dts/ti/Makefile               |   3 +
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      |  25 +++
 arch/arm64/boot/dts/ti/k3-am62.dtsi           |   8 +
 .../arm64/boot/dts/ti/k3-am625-beagleplay.dts | 150 ++++++++++++++++++
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi |  93 ++++++++++-
 .../boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso   |  40 +++++
 arch/arm64/configs/defconfig                  |   1 +
 7 files changed, 319 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso


base-commit: 71cd4fc492ec41e4acd85e98bbf7a13753fc1e03
-- 
2.40.1

