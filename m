Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4527CE07B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344988AbjJRO5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjJRO5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:57:44 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6316C94;
        Wed, 18 Oct 2023 07:57:42 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39IEvW5a068968;
        Wed, 18 Oct 2023 09:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697641052;
        bh=iNQVmJ0xAkdsWhG7JTPi/JY1huhFFvj6B1R5uV3bZSk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nVtr4JQhwOyVYDqtuWJOIVlzT7gW61a/6njuGQFXkwjl58bG0Xdm/7QfSa9uxzKXt
         PL+LThAB9aJYwflcghkcoB58EJRzA9QwXe6SDA/Ev6D60Q2upZ70xuCA3wGrCNRi92
         ITgQXnPmvHObGn3nLwLqiqmt9oitm8HSfYXeg3SI=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39IEvWC7121543
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Oct 2023 09:57:32 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Oct 2023 09:57:32 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Oct 2023 09:57:31 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39IEvSbp022136;
        Wed, 18 Oct 2023 09:57:29 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <robh+dt@kernel.org>, <nm@ti.com>, <conor+dt@kernel.org>,
        <kristo@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        Keerthy <j-keerthy@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, <u-kumar1@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/7] arm64: ti: k3-j7: Add the ESM & main domain watchdog nodes
Date:   Wed, 18 Oct 2023 20:27:26 +0530
Message-ID: <169764101787.299606.2870832744489194714.b4-ty@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231008044657.25788-1-j-keerthy@ti.com>
References: <20231008044657.25788-1-j-keerthy@ti.com>
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

Hi Keerthy,

On Sun, 08 Oct 2023 10:16:50 +0530, Keerthy wrote:
> The series add the ESM & main domain watchdog nodes for j721s2,
> j784s4 SOCs.
> 
> Changes in v8:
> 
> 	* Changed the status of non-MPU nodes from disabled to reserved
> 	* Added inline comments to the reserved RTI nodes
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/7] arm64: dts: ti: k3-j721s2: Add ESM instances
      commit: dbf02264de7ab28933c152a2e5751f7ce9cd8c3d
[2/7] arm64: dts: ti: k3-j784s4: Add ESM instances
      commit: 1c4cc4ca5aff237544c502e6e5ffbe13f4c372fa
[3/7] arm64: dts: ti: k3-j7200: Add MCU domain ESM instance
      commit: 81be795bb3eac1a8cdbd5adb862044c12dc2b744
[4/7] arm64: dts: ti: k3-j784s4-main: Add the main domain watchdog instances
      commit: caae599de8c6cc7405dcfd3bcd66a467eee23d2b
[5/7] arm64: dts: ti: k3-j784s4-mcu: Add the mcu domain watchdog instances
      commit: 9ac8006abcda58c0fd866f967b1a6a05aa3c6b48
[6/7] arm64: dts: ti: k3-j721s2-main: Add the main domain watchdog instances
      commit: eb4c9909dc49f742bdbb9e5d411a4ac1df1cb6d6
[7/7] arm64: dts: ti: k3-j712s2-mcu: Add the mcu domain watchdog instances
      commit: 56bc311585206a8955de793301d4f84fb4ad2ee6

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

