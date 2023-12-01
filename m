Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676B980064C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377911AbjLAIy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjLAIyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:54:24 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020C01735;
        Fri,  1 Dec 2023 00:54:11 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B18rvON109275;
        Fri, 1 Dec 2023 02:53:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701420837;
        bh=bQAKdQBO4j60zJgcuCEAI1mNejYUux2ae47ggYHnYwo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tlVT2q6OvDD4OHdyh1X3yeHBZ45UATUdwrk6bS3fn05ahkcAeqmN3UUJFBYDT/Mml
         hu6tD9twDBV/nDtWmBVBl291Xz2FYOZ++2Lnaf/ippkOc7y6CK6QALYXJYzTIH0+5u
         0NPBhgAdC3zR1tEbAkL8TbwaWDVrbzvjPicMGt8A=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B18rvT5117923
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Dec 2023 02:53:57 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Dec 2023 02:53:56 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Dec 2023 02:53:56 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B18rutZ107391;
        Fri, 1 Dec 2023 02:53:56 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
Subject: Re: [PATCH v4 0/5] arm64: dts: iot2050: DT fixes, cleanups and enhancements
Date:   Fri, 1 Dec 2023 02:53:55 -0600
Message-ID: <170142082012.923433.9902299258818951121.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1699087938.git.jan.kiszka@siemens.com>
References: <cover.1699087938.git.jan.kiszka@siemens.com>
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

Hi Jan Kiszka,

On Sat, 04 Nov 2023 09:52:14 +0100, Jan Kiszka wrote:
> This fixes the lost aliases for the IOT2050 series, fixes mini PCIe card
> hangs, drops an unused device node, brings runtime pinmuxing for the
> Arduino connector via debugfs. Finally, it enables PRU-based Ethernet on
> PG2/M.2 device variants. PG1 devices still need changes to the TI driver
> to enable them as well (work in progress).
> 
> Changes in v4:
>  - fix dtbs_check findings
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/5] arm64: dts: ti: iot2050: Re-add aliases
      commit: ad8edf4ff37ab157f6547da173aedc9f4e5c4015
[2/5] arm64: dts: ti: iot2050: Drop unused ecap0 PWM
      commit: 95fd0767ef961d906f0722b5848276e566a46a4c
[3/5] arm64: dts: ti: iot2050: Definitions for runtime pinmuxing
      commit: e6a53facc8ade138089a64adb4980a1622e7f75f
[4/5] arm64: dts: ti: iot2050: Refactor the m.2 and minipcie power pin
      commit: 6c183a881100144e990f23fbd0f3262e93e8191d
[5/5] arm64: dts: ti: iot2050: Add icssg-prueth nodes for PG2 devices
      commit: 73b4e471cd573e7597cfbd59b882a6cf6408791a

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

