Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322008113EE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbjLMOAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbjLMN7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:59:31 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739F2131;
        Wed, 13 Dec 2023 05:58:25 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BDDw2d7027536;
        Wed, 13 Dec 2023 07:58:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702475882;
        bh=zf1uNzLL138JIP7WwmzIZ2tsfIRpEhLUgJal4PSyHjA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qC20BgsZWC/uMfE9DeGFsk8VTBO/7cQTlIolYFubOeXxwTTquElLKZUikG7p4TJzU
         +DY3gSaVPZ6u5QJ3p5ymLRo2Q2GiHv6BZ8/NnOBlMwcmu2A+943NeaVNjYGTvHiyj8
         hwdKmavTZqnvmVALCviCIRd7qSn7OH3XXanTDUiY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BDDw21U125466
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Dec 2023 07:58:02 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Dec 2023 07:58:02 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Dec 2023 07:58:02 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
        by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BDDw2q8109090;
        Wed, 13 Dec 2023 07:58:02 -0600
From:   Nishanth Menon <nm@ti.com>
To:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <a-nandan@ti.com>, Neha Malcom Francis <n-francis@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <eblanc@baylibre.com>, <jneanne@baylibre.com>,
        <aseketeli@baylibre.com>, <jpanis@baylibre.com>, <u-kumar1@ti.com>,
        <j-luthra@ti.com>, <vaishnav.a@ti.com>, <hnagalla@ti.com>,
        <devarsht@ti.com>
Subject: Re: (subset) [PATCH v10 0/7] Add TPS6594 PMIC support on several boards
Date:   Wed, 13 Dec 2023 07:58:00 -0600
Message-ID: <170247584177.2577232.10722538239180811630.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231208114919.3429562-1-n-francis@ti.com>
References: <20231208114919.3429562-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neha Malcom Francis,

On Fri, 08 Dec 2023 17:19:12 +0530, Neha Malcom Francis wrote:
> TPS6594 is a Power Management IC which provides regulators and others
> features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
> PFSM (Pre-configurable Finite State Machine). The SoC and the PMIC can
> communicate through the I2C or SPI interfaces.
> TPS6594 is the super-set device while TPS6593 and LP8764 are derivatives.
> 
> This series adds device tree nodes for TI TPS6594 PMICs found in the
> following boards:
> - J721EXSOMXEVM:
>   Link: https://www.ti.com/tool/J721EXSOMXEVM
> - J721S2XSOMXEVM:
>   Link: https://www.ti.com/tool/J721S2XSOMXEVM
> - J7200XSOMXEVM:
>   Link: https://www.ti.com/tool/J7200XSOMXEVM
> - J784S4XEVM
>   Link: https://www.ti.com/tool/J784S4XEVM
> - SK-AM69
>   Link: https://www.ti.com/tool/SK-AM69
> - SK-TDA4VM (J721E-SK)
>   Link: https://www.ti.com/tool/SK-TDA4VM
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/7] arm64: dts: ti: k3-j7200-som-p0: Add TP6594 family PMICs
      commit: 08aaf5f02e9d593cf6b2dc7da9c568e19199e00e
[2/7] arm64: dts: ti: k3-j721s2-som-p0: Add TP6594 family PMICs
      commit: f4eb94b898f5b708d024a70fd544cdd76537bcf9
[3/7] arm64: dts: ti: k3-j721e-som-p0: Add TP6594 family PMICs
      commit: 46774eddde0ce499621cc8887106bcb449856e1f
[4/7] arm64: dts: ti: k3-j784s4-evm: Add support for TPS6594 PMIC
      commit: 3044f0184089e910f4da923bf64dca60ff47a117
[5/7] arm64: dts: ti: k3-am69-sk: Add support for TPS6594 PMIC
      commit: 865a1593bf99e1b3d4ffa6182919429694b17a36
[6/7] arm64: dts: ti: k3-j721e-sk: Add TPS6594 family PMICs
      commit: b808cef0be467318d862f87b64d7eddde6906ba3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

