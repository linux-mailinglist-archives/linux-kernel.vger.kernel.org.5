Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A647A89B5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbjITQoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbjITQom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:44:42 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8C1AD;
        Wed, 20 Sep 2023 09:44:36 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38KGiPvq107107;
        Wed, 20 Sep 2023 11:44:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695228265;
        bh=s7HosED0HiRN/Farus8C14hAZV0LN1la064sKC2XqYQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=SNEy30wTl5t7mJOrpc2UwPmTMHFScG6LXBUmtybzneVTYLinscXFCPj81i10KNhp2
         MVBaaP3exrTPXITCi/PEefqaRCrxNgMR2viPZ8lLrYM9ordlwYIyYBFa1uusNvqLDl
         Nnb0IOFBN0dJT32VnkIN2EfuGQj2Y+mHPPz/I2qw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38KGiPTX103967
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Sep 2023 11:44:25 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 20
 Sep 2023 11:44:24 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 20 Sep 2023 11:44:24 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38KGiOwT010187;
        Wed, 20 Sep 2023 11:44:24 -0500
Date:   Wed, 20 Sep 2023 11:44:24 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srk@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: ti: am642-evm: Add overlay for NAND
 expansion card
Message-ID: <20230920164424.rrjvm6nvtv4ysyrw@unreal>
References: <20230920133450.54226-1-rogerq@kernel.org>
 <20230920133450.54226-3-rogerq@kernel.org>
 <20230920135802.3ej2wcuaruqjidel@uncouth>
 <e8f26137-1284-4f45-a74d-a0a5f2aa2f93@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e8f26137-1284-4f45-a74d-a0a5f2aa2f93@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18:18-20230920, Roger Quadros wrote:
> 
> 
> On 20/09/2023 16:58, Nishanth Menon wrote:
> > On 16:34-20230920, Roger Quadros wrote:
> >> The NAND expansion card plugs in over the HSE (High Speed Expansion)
> >> connector. Add support for it.
> >>
> >> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> >> ---
> >>  arch/arm64/boot/dts/ti/Makefile               |   1 +
> >>  arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso | 140 ++++++++++++++++++
> >>  2 files changed, 141 insertions(+)
> >>  create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso
> >>
> >> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> >> index 06d6f264f292..ece74085a6be 100644
> >> --- a/arch/arm64/boot/dts/ti/Makefile
> >> +++ b/arch/arm64/boot/dts/ti/Makefile
> >> @@ -29,6 +29,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62p5-sk.dtb
> >>  
> >>  # Boards with AM64x SoC
> >>  dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
> >> +dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-nand.dtbo
> >>  dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
> >>  dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
> >>  dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
> > 
> > Also see https://lore.kernel.org/all/20230911165610.GA1362932-robh@kernel.org/
> > 
> > you may not get the dtbo installed when doing make dtbs_install
> > 
> > [...]
> > 
> 
> $ v8make dtbs_install INSTALL_DTBS_PATH=/tmp
>   INSTALL /tmp/ti/k3-am625-beagleplay.dtb
>   INSTALL /tmp/ti/k3-am625-phyboard-lyra-rdk.dtb
>   INSTALL /tmp/ti/k3-am625-sk.dtb
>   INSTALL /tmp/ti/k3-am625-verdin-nonwifi-dahlia.dtb
>   INSTALL /tmp/ti/k3-am625-verdin-nonwifi-dev.dtb
>   INSTALL /tmp/ti/k3-am625-verdin-nonwifi-yavia.dtb
>   INSTALL /tmp/ti/k3-am625-verdin-wifi-dahlia.dtb
>   INSTALL /tmp/ti/k3-am625-verdin-wifi-dev.dtb
>   INSTALL /tmp/ti/k3-am625-verdin-wifi-yavia.dtb
>   INSTALL /tmp/ti/k3-am62-lp-sk.dtb
>   INSTALL /tmp/ti/k3-am62x-sk-hdmi-audio.dtbo
>   INSTALL /tmp/ti/k3-am62a7-sk.dtb
>   INSTALL /tmp/ti/k3-am62p5-sk.dtb
>   INSTALL /tmp/ti/k3-am642-evm.dtb
>   INSTALL /tmp/ti/k3-am642-evm-nand.dtbo
> ^^^^
>   INSTALL /tmp/ti/k3-am642-phyboard-electra-rdk.dtb
>   INSTALL /tmp/ti/k3-am642-sk.dtb
> 
> 
> What did I miss?

I missed it, actually. See Rob's comment:
https://lore.kernel.org/all/CAL_Jsq+GR3hP6hFvFn2z5aXvSXnh9butD3aKZ-y_XJgx0_YPTw@mail.gmail.com/

Having orphan dtbo is apparently frowned upon

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
