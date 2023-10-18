Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0A67CE085
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345094AbjJRO6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345093AbjJRO6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:58:30 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C3E10F;
        Wed, 18 Oct 2023 07:58:27 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39IEwKr0085053;
        Wed, 18 Oct 2023 09:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697641100;
        bh=fJ5ZF51QXn8i2PZQhi2CdyDiD2fW2kt2/JH2j2Zonac=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kFVGTW+rhpoIFe+SM8RCWgSyTXmrkfwuWtcDEZpoKJiMQPtxdBefOLg5HO10gWdhj
         YzsaF4xaHf8zHwpW73pEgEDntDY6KuGkAg1ptIXlB+Kb+/ldexL3g/CHhcnpyX4HD/
         DmuMdDM7ufl49aTtxrOg/4rwsoiPl60KevnPEvT0=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39IEwKRJ121999
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Oct 2023 09:58:20 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Oct 2023 09:58:19 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Oct 2023 09:58:19 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39IEwGuw026244;
        Wed, 18 Oct 2023 09:58:17 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] arm64: dts: ti: Use simple-bus wherever possible
Date:   Wed, 18 Oct 2023 20:28:15 +0530
Message-ID: <169764101784.299606.7410332060176644485.b4-ty@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231005151302.1290363-1-vigneshr@ti.com>
References: <20231005151302.1290363-1-vigneshr@ti.com>
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

Hi Vignesh Raghavendra,

On Thu, 05 Oct 2023 20:43:00 +0530, Vignesh Raghavendra wrote:
> This series coverts simple-mfd to simple-bus for segments housing Data
> movement related IPs (DMASS on AM64/AM62 and AM62A), NAVSS on the rest)
> 
> Boot tested on all K3 SoCs. excerised DMA by using ethernet and OSPI for
> sanity.
> 
> Vignesh Raghavendra (2):
>   arm64: dts: ti: k3-*: Convert DMSS to simple-bus
>   arm64: dts: ti: k3-*: Convert NAVSS to simple-bus
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-*: Convert DMSS to simple-bus
      commit: 6ff2e5bb81895247f0414ff6b129c8e025b99a17
[2/2] arm64: dts: ti: k3-*: Convert NAVSS to simple-bus
      commit: 6507bfa7e0cde01c5feecdbc163b392021d15cbb

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

