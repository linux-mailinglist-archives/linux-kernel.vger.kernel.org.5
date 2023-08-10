Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2980776F7D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjHJFVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHJFV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:21:28 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C517E69;
        Wed,  9 Aug 2023 22:21:28 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37A5LLgn069221;
        Thu, 10 Aug 2023 00:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691644881;
        bh=bcZpBKm8yil7rxs726+YhLq0Wq13zXWHT80ZvVCY4CU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WUCVcp2LBSaEoKdfXqDlq5lICXSD9cWGcT8pkLbwEfOQFMrznmSJieUimBjK6cJc1
         VGc7yU9FfGxzb9cHSb1wxF0XusX7J1SvoMAPoAAE5MutLzWRlWBNWzIfsdHKMahskz
         3gd5hdE9jVgkXrpfscS6cQrtuYiHZWspeaWbHkaA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37A5LLEF023559
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 00:21:21 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 00:21:20 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 00:21:20 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37A5LK4R028137;
        Thu, 10 Aug 2023 00:21:20 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <j-luthra@ti.com>, <a-nandan@ti.com>, <vigneshr@ti.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <conor+dt@kernel.org>, <kristo@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <eblanc@baylibre.com>,
        <u-kumar1@ti.com>, <jpanis@baylibre.com>, <vaishnav.a@ti.com>,
        <devarsht@ti.com>, <aseketeli@baylibre.com>,
        <devicetree@vger.kernel.org>, <hnagalla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <jneanne@baylibre.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: (subset) [PATCH v6 0/7] Add TPS6594 PMIC support on several boards
Date:   Thu, 10 Aug 2023 00:21:19 -0500
Message-ID: <169164472311.19570.17843597381384613605.b4-ty@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230810-tps6594-v6-0-2b2e2399e2ef@ti.com>
References: <20230810-tps6594-v6-0-2b2e2399e2ef@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jai Luthra,

On Thu, 10 Aug 2023 01:16:18 +0530, Jai Luthra wrote:
> TPS6594 is a Power Management IC which provides regulators and others
> features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
> PFSM (Pre-configurable Finite State Machine). The SoC and the PMIC can
> communicate through the I2C or SPI interfaces.
> TPS6594 is the super-set device while TPS6593 and LP8764 are derivatives.
> 
> This serie adds device tree nodes for TI TPS6594 PMICs found in the
> following boards:
> - J721EXSOMXEVM:
> - J721S2XSOMXEVM:
> - J7200XSOMXEVM:
> - AM62A-SKEVM:
> - J784S4XEVM
> 
> [...]

As I mentioned in the previous response - this needs much deeper review - I
recommend actual test log and board schematics links to cross verify we are
modifying the correct platforms in the right manner. So, I am not picking up
the defconfig either as it did'nt make sense to pick it up without dts
actually using it.

Only patch I could reasonably pick is the one below (ideally should
have been sent independent of the series, but, ok.).

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[4/7] arm64: dts: ti: k3-j784s4: Fix interrupt ranges for wkup & main gpio
      commit: 05a1f130101e7a49ff1e8734939facd43596ea26

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

