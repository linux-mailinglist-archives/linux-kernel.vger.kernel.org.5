Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA512772956
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjHGPeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjHGPdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:33:47 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CD310E9;
        Mon,  7 Aug 2023 08:33:33 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377FX9gW041559;
        Mon, 7 Aug 2023 10:33:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691422389;
        bh=v8umCupgOqoPJ5dDP0MCVid0DrDus8c9YIkXUyBGDPo=;
        h=From:To:CC:Subject:Date;
        b=djJpPFRuscu7bMUqGvwTV8xIwDTA2pdGiOFp7QlIsvWCuqDvgKqSfWieAxFdL6Bgn
         XRy8l9l50IaEVjHo6PiIYHdSYmY9HKwL9As1TEtFwlXwhYD8MhDxVU203TGWmYvTt6
         uq6L/orCJlEBhxKjh3Sep9s24G7nGSW1m38kLfMA=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377FX9FM119813
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 10:33:09 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 10:33:09 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 10:33:09 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377FX82Y084446;
        Mon, 7 Aug 2023 10:33:08 -0500
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
Subject: [PATCH v4 0/6] arm64: ti: k3-am62: Add display support
Date:   Mon, 7 Aug 2023 21:03:01 +0530
Message-ID: <20230807153307.22174-1-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 .../arm64/boot/dts/ti/k3-am625-beagleplay.dts | 158 ++++++++++++++++++
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi |  95 ++++++++++-
 .../boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso   |  40 +++++
 arch/arm64/configs/defconfig                  |   1 +
 6 files changed, 321 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso


base-commit: f7dc24b3413851109c4047b22997bd0d95ed52a2
-- 
2.40.1

