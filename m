Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93456776F68
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjHJFPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjHJFPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:15:08 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8E410E;
        Wed,  9 Aug 2023 22:15:07 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37A5EaLJ081113;
        Thu, 10 Aug 2023 00:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691644476;
        bh=9g+CfPvUuUYpLQqijmxdNIEY2znEf4DiXeN0qUn9s8o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=RR2cF+5bvmmACeLovWA08gEN+c57CE25/wE7r9lVL6LmvxfjNn3v2JHv3oSM1h8XU
         80HAz7gcvClYFb6Tro16iYdj+ZUFgU40UCFlsv55LiIIB/hwvagcW4msQw8iLMObB6
         W2m8zQ/FlRV9+1/2fytsC1PUblaNqouzJyn0R5t8=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37A5Ea4s117251
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 00:14:36 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 00:14:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 00:14:34 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37A5EYLd021776;
        Thu, 10 Aug 2023 00:14:34 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <danishanwar@ti.com>, <vigneshr@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <peng.fan@nxp.com>, <srk@ti.com>,
        <linux-omap@vger.kernel.org>, <rafal@milecki.pl>,
        <konrad.dybcio@linaro.org>, <catalin.marinas@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski@linaro.org>, <christian.gmeiner@gmail.com>,
        <quic_bjorande@quicinc.com>, <geert+renesas@glider.be>,
        <nfraprado@collabora.com>, <will@kernel.org>
Subject: Re: [PATCH v4] arm64: defconfig: Enable TI PRUSS
Date:   Thu, 10 Aug 2023 00:14:33 -0500
Message-ID: <169164446249.18714.16221986005820294003.b4-ty@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230808130131.3081482-1-danishanwar@ti.com>
References: <20230808130131.3081482-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

Hi MD Danish Anwar,

On Tue, 8 Aug 2023 18:31:31 +0530, MD Danish Anwar wrote:
> The Programmable Realtime Unit - Industrial Communication Subsystem
> (PRU-ICSS) known as PRUSS, is a low-latency microcontroller subsystem
> used for industrial networking and other hard real-time functions in
> the TI K3 SoCs such as AM654x, AM64x.
> 
> AM654x-EVM, AM64xx-EVM, and iot2050 use the PRUSS driver.
> 
> [...]

I have applied the following to branch ti-k3-config-next on [1].
Thank you!

[1/1] arm64: defconfig: Enable TI PRUSS
      commit: b7314d6938759d6da8b9992d0eade4606daf72a6

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

[1] git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 

Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

