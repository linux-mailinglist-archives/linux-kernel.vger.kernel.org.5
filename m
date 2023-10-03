Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72577B670E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239726AbjJCLCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239803AbjJCLCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:02:42 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B32DAD;
        Tue,  3 Oct 2023 04:02:39 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 393B2YGp047912;
        Tue, 3 Oct 2023 06:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696330954;
        bh=icfEo0eu6mNB2zKzO9Im4222yhYXMHz3FNTDGw5U4Qc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=yDjDDv9lG/oSA8WCCoqdas1R26dwHk9jRy8nOyw7bNsFYXDos1z1kh5CaGUyZClxq
         qHatWES1fAcCz76jTBVCXtbfoaYt8i2QfcFM/T8AtMAPX6kBButZ8eDG1g6VKyvi0Z
         q/N0p6Ophp9Rj5Zoj0L+93/8FKBUf774pD5oryFQ=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 393B2Yvq010243
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Oct 2023 06:02:34 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Oct 2023 06:02:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Oct 2023 06:02:34 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 393B1Dvi129223;
        Tue, 3 Oct 2023 06:02:30 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Neha Malcom Francis <n-francis@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>,
        <kristo@kernel.org>, <u-kumar1@ti.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j721e-mcu-wakeup: Add MCU domain ESM instance
Date:   Tue, 3 Oct 2023 16:30:45 +0530
Message-ID: <169633065056.2221719.3724450328166244211.b4-ty@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230926142810.602384-1-n-francis@ti.com>
References: <20230926142810.602384-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neha Malcom Francis,

On Tue, 26 Sep 2023 19:58:10 +0530, Neha Malcom Francis wrote:
> Currently J721E defines only the main_esm in DTS. Add node for mcu_esm
> as well.
> 
> According to J721E TRM (12.11.2.2 ESM Environment) [1], we see that the
> interrupt line from ESMi (main_esm) is routed to MCU_ESM (mcu_esm). This
> is MCU_ESM0_LVL_IN_95 with interrupt ID 95. Configure mcu_esm
> accordingly so that errors from main_esm are routed to mcu_esm and
> handled.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j721e-mcu-wakeup: Add MCU domain ESM instance
      commit: cd5b5c5a527b7fd25260be7e9013ee9c97efc2c0

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

