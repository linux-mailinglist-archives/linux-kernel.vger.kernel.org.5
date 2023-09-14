Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E7E7A0A3D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241462AbjINQFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241439AbjINQFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:05:03 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC3D1BDD;
        Thu, 14 Sep 2023 09:04:59 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38EG4oqp075064;
        Thu, 14 Sep 2023 11:04:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694707490;
        bh=vQL80/+kCMGTTVV38gtzZKwjbEGDPwKyLfgY6s/HBP4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=X6hH6jh0Smbh3bOWXWTiG03OlJ+oguZZUF5EDL7CYbKMLeRBu/w1+E3L5vOzIvuHj
         NJ5UmD6qLUFgKPkjz+pAlMDh77bxGEjD/Yrn2UbEQGw0+qSZMgmOgjnD4SAkT64Wmu
         pkEdKHFj3M2Fsglm1Chclx20eV5MtVRxSththRik=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38EG4oHv056947
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Sep 2023 11:04:50 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 14
 Sep 2023 11:04:50 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 14 Sep 2023 11:04:50 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38EG4oW4017019;
        Thu, 14 Sep 2023 11:04:50 -0500
Date:   Thu, 14 Sep 2023 11:04:50 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Nitin Yadav <n-yadav@ti.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <vigneshr@ti.com>, <rogerq@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] arm64: dts: ti: Add GPMC NAND support
Message-ID: <20230914160450.knooq6q3dflostv4@playtime>
References: <20230913114711.2937844-1-n-yadav@ti.com>
 <20230913114711.2937844-2-n-yadav@ti.com>
 <32c82fa2-f8b9-d22d-f0ac-f8d6e48df39d@linaro.org>
 <f7bebc22-d494-f54d-5543-db75f5714a52@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f7bebc22-d494-f54d-5543-db75f5714a52@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:56-20230914, Nitin Yadav wrote:
> Hi Krzysztof,
> 
> On 14/09/23 11:57, Krzysztof Kozlowski wrote:
> > On 13/09/2023 13:47, Nitin Yadav wrote:
> >> Add support for AM62Q NAND card: X8 NAND EXPANSION
> >> BOARD card (PROC143E1) for AM62x LP SK board.

Commit message is all too wrong as well. Sigh.

> >>
> >> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> >> ---
> >>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 29 ++++++++++++++++++++++++
> >>  arch/arm64/boot/dts/ti/k3-am62.dtsi      |  2 ++
> >>  2 files changed, 31 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> >> index 284b90c94da8..e93e79d8083f 100644
> >> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> >> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> >> @@ -955,4 +955,33 @@ mcasp2: audio-controller@2b20000 {
> >>  		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
> >>  		status = "disabled";
> >>  	};
> >> +	gpmc0: memory-controller@3b000000 {
> >> +		status = "disabled";
> > 
> > status is never first in DTSI. Really, where did you see such code?
> Thank for pointing out, Will send a revised version.

GPMC is not functional without board specific interface configuration
such as pinmux. this approach, in fact is all over the place now and
discussed in the mailing list multiple times now.

What is missing here is the documentation of the constraints as to why
it is set as disabled by default.


> > 
> >> +		compatible = "ti,am64-gpmc";
> >> +		power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
> > 
> > First is compatible, second is reg/reg-names/ranges.
> > 
> > 
> > Best regards,
> > Krzysztof
> > 
> 
> -- 
> Regards,
> Nitin

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
