Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707E57A1E90
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbjIOMXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbjIOMXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:23:16 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDE3268A;
        Fri, 15 Sep 2023 05:22:59 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38FCMpqU055787;
        Fri, 15 Sep 2023 07:22:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694780571;
        bh=WmM1Xt8FbeRToLJEAI7b1PKzcpbjHoLEicURQiB/CRQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=WnOLZJhLbkzatVnA9EGZzK+JEtze/dzcd1bczakV2ZVQphWoMboI9hDKaZ0DjtSMU
         vNhrYIGDMmE8gWLVeclIMkBKEE6qoMaYcTy+Ym2sufBRkpMH1eDNzPkrvnP0rsqnlP
         BmtVomlSkpJbODbTFIf31p/5QkFtKyx5bwwIAXRk=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38FCMpwP104015
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Sep 2023 07:22:51 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 15
 Sep 2023 07:22:51 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 15 Sep 2023 07:22:51 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38FCMpXS003652;
        Fri, 15 Sep 2023 07:22:51 -0500
Date:   Fri, 15 Sep 2023 07:22:51 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Nitin Yadav <n-yadav@ti.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <vigneshr@ti.com>, <rogerq@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] arm64: dts: ti: Add GPMC NAND support
Message-ID: <20230915122251.76uud4tmfzdvcala@preheated>
References: <20230913114711.2937844-1-n-yadav@ti.com>
 <20230913114711.2937844-2-n-yadav@ti.com>
 <32c82fa2-f8b9-d22d-f0ac-f8d6e48df39d@linaro.org>
 <f7bebc22-d494-f54d-5543-db75f5714a52@ti.com>
 <20230914160450.knooq6q3dflostv4@playtime>
 <bc3e9526-f497-616d-e720-69081e266983@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bc3e9526-f497-616d-e720-69081e266983@ti.com>
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

On 14:53-20230915, Nitin Yadav wrote:
> 
> 
> On 14/09/23 21:34, Nishanth Menon wrote:
> > On 14:56-20230914, Nitin Yadav wrote:
> >> Hi Krzysztof,
> >>
> >> On 14/09/23 11:57, Krzysztof Kozlowski wrote:
> >>> On 13/09/2023 13:47, Nitin Yadav wrote:
> >>>> Add support for AM62Q NAND card: X8 NAND EXPANSION
> >>>> BOARD card (PROC143E1) for AM62x LP SK board.
> > 
> > Commit message is all too wrong as well. Sigh.
> > 
> >>>>
> >>>> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> >>>> ---
> >>>>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 29 ++++++++++++++++++++++++
> >>>>  arch/arm64/boot/dts/ti/k3-am62.dtsi      |  2 ++
> >>>>  2 files changed, 31 insertions(+)
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> >>>> index 284b90c94da8..e93e79d8083f 100644
> >>>> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> >>>> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> >>>> @@ -955,4 +955,33 @@ mcasp2: audio-controller@2b20000 {
> >>>>  		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
> >>>>  		status = "disabled";
> >>>>  	};
> >>>> +	gpmc0: memory-controller@3b000000 {
> >>>> +		status = "disabled";
> >>>
> >>> status is never first in DTSI. Really, where did you see such code?
> >> Thank for pointing out, Will send a revised version.
> > 
> > GPMC is not functional without board specific interface configuration
> > such as pinmux. this approach, in fact is all over the place now and
> > discussed in the mailing list multiple times now.
> > 
> > What is missing here is the documentation of the constraints as to why
> > it is set as disabled by default.

> gpmc nand is only am62x lp sk in am62x series. it has pinmux conflict
> with macsp1, so disabling gpmc & elm by default for other am62 series.
> For am62x lpsk in overlay macsp1 is disabled.


When introducing a patch for SoC dtsi - explain in commit message and
code comments from the SoC's perspective, not the specific board
perspective.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
