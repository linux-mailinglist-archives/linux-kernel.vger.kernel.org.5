Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1297C65DA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377412AbjJLGrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343561AbjJLGre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:47:34 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523EDB8;
        Wed, 11 Oct 2023 23:47:32 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39C6lKPU120622;
        Thu, 12 Oct 2023 01:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697093240;
        bh=qlDt9W9SRW+VaDucq5BW/ZDa/bC/TgdxhQBR1MX0quI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kDZVssYURiiG9E1VoD/V3SuuzceQZ3Z81i7+2HkUATJSrXYUwSVmopJFzmQZMPkox
         gwhQc/8Co6YmfUEpREeuYmFSaaHNDHrWlZtrThQYCe4IX/QK99y0/7twDbTNs6a6jH
         KdDndxJhqfFoNw6ur3LzkjwkepGAK/NE/eIqSr+c=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39C6lKJu007866
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Oct 2023 01:47:20 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 12
 Oct 2023 01:47:19 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 12 Oct 2023 01:47:19 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39C6lFAd040003;
        Thu, 12 Oct 2023 01:47:16 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@ew.tq-group.com>
Subject: Re: [PATCH 1/4] arm64: dts: ti: k3-am64-tqma64xxl: add supply regulator for I2C devices
Date:   Thu, 12 Oct 2023 12:17:09 +0530
Message-ID: <169709313767.2957749.10885918329569967999.b4-ty@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <d5991041263c96c798b94c0844a1550e28daa3b1.1695901360.git.matthias.schiffer@ew.tq-group.com>
References: <d5991041263c96c798b94c0844a1550e28daa3b1.1695901360.git.matthias.schiffer@ew.tq-group.com>
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

Hi Matthias Schiffer,

On Thu, 28 Sep 2023 13:45:10 +0200, Matthias Schiffer wrote:
> Describes the hardware better, and avoids a few warnings during boot:
> 
>     lm75 0-004a: supply vs not found, using dummy regulator
>     at24 0-0050: supply vcc not found, using dummy regulator
>     at24 0-0054: supply vcc not found, using dummy regulator
> 
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] arm64: dts: ti: k3-am64-tqma64xxl: add supply regulator for I2C devices
      commit: 8e4e717be847913517977d9689ab88f1b86d71d8
[2/4] arm64: dts: ti: k3-am64-tqma64xxl-mbax4xxl: add muxing for GPIOs on pin headers
      commit: ec30a50c72bdaa6007c999846675241b44b233d0
[3/4] arm64: dts: ti: k3-am64-tqma64xxl-mbax4xxl: add chassis-type
      commit: 92039884c9b57d14601c6e0e913b184dd2bff75c
[4/4] arm64: dts: ti: k3-am64-tqma64xxl-mbax4xxl: update gpio-led configuration
      commit: 06a0d54202e0de04e62c1991d39d6c7595f0d88a

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
Vignesh

