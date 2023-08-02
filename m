Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BF976C49E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 07:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjHBFJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 01:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjHBFJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 01:09:34 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3B71716
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 22:09:33 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 372593qX020385;
        Wed, 2 Aug 2023 00:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690952943;
        bh=c5hMZJhUc/ZJCpfN2HH8sG9EEQfBdRElYZEr1fznPN8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FoOq1zsQ6dr0JjW8UkTGKlZH5FKnLrGoG+Ve3kPnu+r1SOC2vPuVsBcR70f8xOd4e
         nHjyqdLbwV80AG+t4BJtZ9PyITauK2XI0N6ZrSr98vfSSVHORGa3jv4rB7W2IoGeY8
         b3Ifoe1fd1oTUZBLlBYa/krCfiNUIm1YNDJBMmH8=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3725939f050635
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 00:09:03 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 00:09:03 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 00:09:03 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 372592h0123252;
        Wed, 2 Aug 2023 00:09:02 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <vigneshr@ti.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <quic_bjorande@quicinc.com>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <krzysztof.kozlowski@linaro.org>,
        <nfraprado@collabora.com>, <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <j-keerthy@ti.com>, <a-nandan@ti.com>
Subject: Re: [PATCH v4] arm64: defconfig: Enable various configs for TI K3 platforms
Date:   Wed, 2 Aug 2023 00:09:02 -0500
Message-ID: <169095281352.2814400.5176099282751822168.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230731161048.2522154-1-u-kumar1@ti.com>
References: <20230731161048.2522154-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Udit Kumar,

On Mon, 31 Jul 2023 21:40:48 +0530, Udit Kumar wrote:
> Enable TI ECAP, DP83869 driver, OMAP2 Mailbox, K3 remote proc
> SND_SOC_J721E_EVM, MCAN, UFS and RTI, Thermal driver to be built
> as module.
> 
> These configs are supported on below TI platforms
> 
> ECAP on am642, am65 iot2050 EVM.
> 
> [...]

I have applied the following to branch ti-k3-config-next on [1].
Thank you!

[1/1] arm64: defconfig: Enable various configs for TI K3 platforms
      commit: 8127ab5fbaeea40d32a43b168ec247909f85bcf6

NOTE: I edited a little to apply on top of v6.5-rc1 which is what my tree
is based off and what I send as PR upstream. I understand there might be
a potential conflict, will resolve it with the maintainers as it is needed to
be handled.

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

