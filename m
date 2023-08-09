Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881717762B4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbjHIOkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbjHIOk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:40:29 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507A02107;
        Wed,  9 Aug 2023 07:40:27 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379Ee6DD011384;
        Wed, 9 Aug 2023 09:40:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691592006;
        bh=Ht+MQt2z/ktrchacS0VLjAbZCASRyaYR0JilJqDkvdg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=qq0sGRzta45Xnv+5aVgbMgjbV+iRwayQPw6lTdnLu6vPYMs+aphD6BFxG9uApVr8i
         C9HOZkADb3OfK/6aD6UEHuenL3J2c2azWgSIeYcVkGiw6HDdrQlU8VA6A92Z0N1Jo5
         vmHrWtOcnvAWabawhBmI+kxarOOFJw3EFvzzr8tw=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379Ee5ic018424
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 09:40:05 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 09:40:05 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 09:40:05 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379Ee5IF023524;
        Wed, 9 Aug 2023 09:40:05 -0500
Date:   Wed, 9 Aug 2023 09:40:05 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Aradhya Bhatia <a-bhatia1@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Francesco Dolcini <francesco@dolcini.it>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
Subject: Re: [PATCH v5 0/6] arm64: ti: k3-am62: Add display support
Message-ID: <20230809144005.n3uq5yjusrrtjhqz@churn>
References: <20230809084559.17322-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230809084559.17322-1-a-bhatia1@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:15-20230809, Aradhya Bhatia wrote:
> Hi all,
> 
> The patch series adds DT nodes for Display SubSystem (DSS) and other
> peripherals required to enable the HDMI audio and video on the AM625 SK,
> AM62-LP SK, as well as the AM625 based Beagle-Play platforms. An HDMI
> monitor can be connected to the boards for the audio/video outputs.
> 
> The series adding the compatible and basic driver support[0] is in the
> drm-misc-next and linux-next queues and is expected to be in the
> mainline by v6.6-rc1. Patch 5/6 also requires Nishanth Menon's patch[1]
> that introduces debounce select mux macros. This patch too is not in
> v6.5-rc1 but has been picked up in ti-next[2] and hence, is present in
> linux-next.
> 
> Patches 4 and 5 have been picked up from TI's vendor tree[3] based off
> linux-kernel v6.1.
> 
> Regards
> Aradhya
> 
> Change Log:
> V4 -> V5:
>   - Cosmetic changes as suggested by Jayesh.
>   - Fixed the mis-represented DSS VP1 clock, and added a
>     fixed-factor-clock.
> 
> V3 -> V4:
>   - Added "Fixes" tag for patch 1/6.
>   - Rebased to linux-next.
>   - Enabled display at board level and disabled at SoC level.
>   - Dropped OLDI pinmux configuration as OLDI output comes directly from
>     the SoC and muxing is not required.
>   - Squashed DSS pinmux patches into their platform specific HDMI
>     support patches, because it did not make sense to have only one set
>     of pinmux config separated in a patch.
> 
> V2 -> V3:
>   - Updated the compatible from "ti,am65x-dss" to "ti,am625-dss".
>   - Peripheral nodes like HDMI TX, HDMI connector are now added to
>     k3-am62x-sk-common.dtsi instead of k3-am625-sk.dts, in order to
>     support AM62-LP SK-EVM as well.
>   - Dropped the HDMI master clock node as it is not connected on the
>     EVM, and should not have been added in the first place.
>   - Re-worded and Re-ordered commits.
>   - Dropped Rahul Ravikumar's R-bs because of the changes.
>   - Added AM625 based Beagle-Play for HDMI support.
>   - Added HDMI audio support as well.
> 
> V1 -> V2:
>  - Removed repetitive data in dss_ports
> 
> V4: https://lore.kernel.org/all/20230807153307.22174-1-a-bhatia1@ti.com/
> V3: https://lore.kernel.org/all/20230728173438.12995-1-a-bhatia1@ti.com/
> V2: https://lore.kernel.org/all/20220505134303.23208-1-a-bhatia1@ti.com/
> V1: https://lore.kernel.org/all/20220427090850.32280-1-a-bhatia1@ti.com/
> 
> [0]: https://lore.kernel.org/all/20230616150900.6617-1-a-bhatia1@ti.com/
> [1]: https://lore.kernel.org/all/20230619131620.3286650-1-nm@ti.com/
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git/commit/?id=0bec3d7ecc7493b0e530f6f34539841ef6779006
> [3]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/log/?h=ti-linux-6.1.y-cicd
> 
> 
> Aradhya Bhatia (4):
>   arm64: dts: ti: k3-am62x-sk-common: Update main-i2c1 frequency
>   arm64: dts: ti: k3-am62-main: Add node for DSS
>   arm64: dts: ti: k3-am62x-sk-common: Add HDMI support
>   arm64: defconfig: Enable ITE_IT66121 HDMI transmitter
> 
> Jai Luthra (1):
>   arm64: dts: ti: am62x-sk: Add overlay for HDMI audio
> 
> Nishanth Menon (1):
>   arm64: dts: ti: k3-am625-beagleplay: Add HDMI support
> 
>  arch/arm64/boot/dts/ti/Makefile               |   3 +
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi      |  25 +++
>  arch/arm64/boot/dts/ti/k3-am62.dtsi           |   8 +
>  .../arm64/boot/dts/ti/k3-am625-beagleplay.dts | 150 ++++++++++++++++++
>  .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi |  93 ++++++++++-
>  .../boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso   |  40 +++++
>  arch/arm64/configs/defconfig                  |   1 +
>  7 files changed, 319 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso
> 
> 
> base-commit: 71cd4fc492ec41e4acd85e98bbf7a13753fc1e03
> -- 
> 2.40.1
> 

Can you help cleanup the following before we start introducing new oldi
and dss support? I am not sure if these were introduced due to yaml
updates or something pre-existing.

linux/build/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dtb: dss-oldi-io-ctrl@41e0: compatible: 'anyOf' conditional failed, one must be fixed:
linux/build/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dtb: dss-oldi-io-ctrl@41e0: compatible: 'anyOf' conditional failed, one must be fixed:
linux/build/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dtb: dss-oldi-io-ctrl@41e0: compatible: 'anyOf' conditional failed, one must be fixed:
linux/build/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dtb: dss-oldi-io-ctrl@41e0: compatible: 'anyOf' conditional failed, one must be fixed:
linux/build/arch/arm64/boot/dts/ti/k3-am654-base-board.dtb: dss-oldi-io-ctrl@41e0: compatible: 'anyOf' conditional failed, one must be fixed:
linux/build/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dtb: dss-oldi-io-ctrl@41e0: compatible: 'anyOf' conditional failed, one must be fixed:

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
