Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1543C776E2D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 04:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjHJCrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 22:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjHJCrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 22:47:11 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2581AA;
        Wed,  9 Aug 2023 19:47:10 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37A2l1bf044537;
        Wed, 9 Aug 2023 21:47:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691635621;
        bh=rDh6665dXNHeRBZwmrnk1n1jLZUO7624dMT3vj10fBM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ShAnQBMohpfbaYBuAZYJi53HSSbdZxPFayOO0ej8GUX4G+pOSXAEbL0g/IVXBLnv9
         52YYC+WNV20b9vIjiwyVI7fKzBSBYKZPAakDlvfZt2NPtTwZ7oUvKv78/YCQr+gaBh
         VlgDOziUNDpu4F4La2qXJmEgl2gmY/ABeviq16K8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37A2l1T9030196
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 21:47:01 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 21:47:01 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 21:47:00 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37A2l0K2029561;
        Wed, 9 Aug 2023 21:47:00 -0500
Date:   Wed, 9 Aug 2023 21:47:00 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jai Luthra <j-luthra@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Apurva Nandan <a-nandan@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Esteban Blanc <eblanc@baylibre.com>, <jneanne@baylibre.com>,
        <aseketeli@baylibre.com>, <jpanis@baylibre.com>, <u-kumar1@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Hari Nagalla <hnagalla@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>
Subject: Re: [PATCH v6 0/7] Add TPS6594 PMIC support on several boards
Message-ID: <20230810024700.4qhgygd6mma4sw2u@kobold>
References: <20230810-tps6594-v6-0-2b2e2399e2ef@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230810-tps6594-v6-0-2b2e2399e2ef@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01:16-20230810, Jai Luthra wrote:
>  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts          |  95 +++++++++++
>  arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi      | 157 ++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi      | 163 +++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi     | 199 +++++++++++++++++++++++

Sigh.. Thanks Jai for stepping and trying to make this work, but I think
this series is a lot out of whack. Apparently somewhere in this series
is a patch for j721s2 that breaks proper boot. I spent quite a while
bisecting across boards to find it, So, I am just going to skip this
series for this release (and dependencies)

Next time for this series: I recommend submitter provide test
logs for every single platform touched.

https://gist.github.com/nmenon/72e5f9b344e9207863d93491f5bf4f8e

I have'nt debugged, but typically that looks like some one decided to
pull the voltage low on a key rail.

Let me see if I can pick the interrupt range fix at least since
should'nt be dependent on this.

>  arch/arm64/boot/dts/ti/k3-j784s4-evm.dts         | 104 ++++++++++++
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi       |   2 +-
>  arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi |   2 +-
>  arch/arm64/configs/defconfig                     |   1 +
>  8 files changed, 721 insertions(+), 2 deletions(-)
> ---
> base-commit: 21ef7b1e17d039053edaeaf41142423810572741
> change-id: 20230809-tps6594-e450b5738e66
> 
> Best regards,
> -- 
> Jai Luthra <j-luthra@ti.com>
> 


bisect log: (commit sha's dont mean a thing.. but anyways..)
git bisect start
# good: [f2e72716f089d6fcc4bf7b8cb7ac874b79ed05b1] iommu: dev->iommu->iommu_dev must be set before ops->device_group()
git bisect good f2e72716f089d6fcc4bf7b8cb7ac874b79ed05b1
# bad: [31f83ee5e42290c39e0bce42118ad1267eaf2790] arm64: dts: ti: k3-am64: Enable TSCADC nodes at the board level
git bisect bad 31f83ee5e42290c39e0bce42118ad1267eaf2790
# bad: [f51a52fc98cddb7b99ecb19d86c40845f7e8d91e] arm64: dts: ti: k3-am62a7-sk: Split vcc_3v3 regulators
git bisect bad f51a52fc98cddb7b99ecb19d86c40845f7e8d91e
# good: [0cc1aecdc1024eced6914f015dbc43c28f5ac6aa] arm64: dts: ti: k3-j721s2-som-p0: Add TP6594 family PMICs
git bisect good 0cc1aecdc1024eced6914f015dbc43c28f5ac6aa
# good: [8b4e4f23f60df9c8aadb0e26cb86b13735ed810b] arm64: dts: ti: k3-j784s4-evm: Add support for TPS6594 PMIC
git bisect good 8b4e4f23f60df9c8aadb0e26cb86b13735ed810b
# bad: [38ff20140c2cf09ba140234732dd03a9743ebd32] arm64: defconfig: Enable TPS6593 PMIC for SK-AM62A
git bisect bad 38ff20140c2cf09ba140234732dd03a9743ebd32
# good: [3e98e865a6135bef7d801b5c5236a42a0ef1bff2] arm64: dts: ti: k3-am62a7-sk: Add support for TPS6593 PMIC
git bisect good 3e98e865a6135bef7d801b5c5236a42a0ef1bff2
# first bad commit: [38ff20140c2cf09ba140234732dd03a9743ebd32] arm64: defconfig: Enable TPS6593 PMIC for SK-AM62A


-- 

Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
