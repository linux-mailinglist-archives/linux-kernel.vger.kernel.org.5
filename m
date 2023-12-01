Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6345800646
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377932AbjLAIxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377930AbjLAIxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:53:34 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2DD12A;
        Fri,  1 Dec 2023 00:53:36 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B18rTMp126953;
        Fri, 1 Dec 2023 02:53:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701420809;
        bh=LtcidDfIPRJM6R0cPv02cOKItt85LGasLWw1fH2EQY4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LOdvSXAlji+KOO6TphnFfJKK7Prtbw7SHHGXPlpHe9xTMLsz72QN54BpYy1UtoylZ
         tmXKzpbV3cKevghC526uW3poBFTpNCryGY4XTVZ10f5OGD/4mjrEE1XfDadl3k4S1w
         agq0DxK9jjDBkpheFpVT+S3PRABkkh89610dF2uk=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B18rTjC026057
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Dec 2023 02:53:29 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Dec 2023 02:53:28 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Dec 2023 02:53:28 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B18rS9a107118;
        Fri, 1 Dec 2023 02:53:28 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-am642-evm/sk: Mark mcu_gpio_intr as reserved
Date:   Fri, 1 Dec 2023 02:53:26 -0600
Message-ID: <170142080163.923229.11181699314375476710.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231110132508.3137454-1-vigneshr@ti.com>
References: <20231110132508.3137454-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

Hi Vignesh Raghavendra,

On Fri, 10 Nov 2023 18:55:06 +0530, Vignesh Raghavendra wrote:
> Similar to MCU GPIO, mark the MCU GPIO router also as reserved for MCU
> domain firmware usage.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] arm64: dts: ti: k3-am642-evm/sk: Mark mcu_gpio_intr as reserved
      commit: 26abae3d840b8b83413c6222725db1104fe4811d
[2/3] arm64: dts: ti: k3-am62p5-sk: Mark mcu gpio and mcu_gpio_intr as reserved
      commit: 1b3014a65adb491ec5a777c988f0dd85094d78bd
[3/3] arm64: dts: ti: k3-am62x-sk-common: Mark mcu gpio and mcu_gpio_intr as reserved
      commit: 5582b1c623a6d62d3aff62c070173c9f1eb8fabd

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

