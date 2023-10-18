Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226007CE08E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345142AbjJRO7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345139AbjJRO7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:59:08 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4744F7;
        Wed, 18 Oct 2023 07:59:06 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39IEx1nq069188;
        Wed, 18 Oct 2023 09:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697641141;
        bh=yPgGsfJKzCvXwN62kkBo6+6blW8BYPNEdSmbI8WojGM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Ap/yEGHlYgeW5FNHzks9QHiYT7fxazOV2ALPIU7e+pce/mhKkwg3Qs64bSfZZhnYt
         0W6xBADeYNqCuOUEBIHJdn9BVxRkVDENrHfwhYfAeA8ty1C1O3E/9k4BQfH0PTW4pw
         TaILxsQGfh4kKuiKvAemF/EYSIaVbs0Vro02eus8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39IEx1B9032106
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Oct 2023 09:59:01 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Oct 2023 09:59:00 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Oct 2023 09:59:00 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39IEwueM026595;
        Wed, 18 Oct 2023 09:58:57 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <nm@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vaishnav Achath <vaishnav.a@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <j-choudhary@ti.com>
Subject: Re: [PATCH v2 0/2] arm64: dts: ti: k3-j721s2/j784s4: Add CSI BCDMA nodes
Date:   Wed, 18 Oct 2023 20:28:43 +0530
Message-ID: <169764101786.299606.12584643376472033357.b4-ty@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231010111723.17524-1-vaishnav.a@ti.com>
References: <20231010111723.17524-1-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vaishnav Achath,

On Tue, 10 Oct 2023 16:47:21 +0530, Vaishnav Achath wrote:
> J721S2 and J784S4 have a dedicated BCDMA controller for
> Camera Serial Interface. Add the node for the DMA controllers
> and keep it disabled by default.
> 
> The BCDMA instances were enabled/disabled and tested:
> J721S2 : https://gist.github.com/vaishnavachath/4b9d7ec2ee1aad59a57d44cf28ed7eb0
> J784S4 : https://gist.github.com/vaishnavachath/f928e4566aa80c7f47e7ac3c1491d62e
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-j721s2-main: Add BCDMA instance for CSI2RX
      commit: 10c6c4db6283053e8ec20eef19eb77d4aeffed1a
[2/2] arm64: dts: ti: k3-j784s4-main: Add BCDMA instance for CSI2RX
      commit: 8b2e41833bd649086e32ac4c3a412d7ec80e8202

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

