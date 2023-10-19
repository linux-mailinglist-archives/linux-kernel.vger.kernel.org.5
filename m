Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DC87CFC78
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346093AbjJSO1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346063AbjJSO1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:27:13 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F34182
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:27:08 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39JEQwNY061660;
        Thu, 19 Oct 2023 09:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697725618;
        bh=5hAbYwtgEhKVSeY2eR8pPkbu7GnTYy+COvBi0srBcXE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=eZ/oL9KL8ru2cmYu81WM/ILmQ7PYjbqKZfbwO5BK+E3vZRyoogUK1sHfbbABAHDWn
         gn2DWjDEhG0O5Ms4V7X39ifnc+4Va5bvHl6dsCpW+Nk89US8YTcpHKggCg6clhtgrA
         rBd2dbyd0Js3PNZfQk0rYOfIn8wuY4Sy5MgTrMmU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39JEQw3g011290
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Oct 2023 09:26:58 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Oct 2023 09:26:57 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Oct 2023 09:26:57 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39JEQvmj008004;
        Thu, 19 Oct 2023 09:26:57 -0500
Date:   Thu, 19 Oct 2023 09:26:57 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ARM Linux Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-am62p: Add nodes for more IPs
Message-ID: <20231019142657.wxikbsz2s7qmjn2k@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20231018194839.2689377-1-bb@ti.com>
 <20231018194839.2689377-2-bb@ti.com>
 <e35d333a-7f24-4a3f-90e3-87bc859a18e3@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <e35d333a-7f24-4a3f-90e3-87bc859a18e3@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh!

On October 19, 2023 thus sayeth Vignesh Raghavendra:
> 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> > index aaf4b793b58e7..e37f19f7e58ea 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> > @@ -6,17 +6,35 @@
> >  
> >  &cbass_wakeup {
> >  	wkup_conf: bus@43000000 {
> > -		bootph-all;
> >  		compatible = "simple-bus";
> >  		reg = <0x00 0x43000000 0x00 0x20000>;
> >  		#address-cells = <1>;
> >  		#size-cells = <1>;
> >  		ranges = <0x00 0x00 0x43000000 0x20000>;
> > +		bootph-all;
> >  
> >  		chipid: chipid@14 {
> > -			bootph-all;
> >  			compatible = "ti,am654-chipid";
> >  			reg = <0x14 0x4>;
> > +			bootph-all;
> > +		};
> > +
> > +		cpsw_efuse: syscon@200 {
> > +			compatible = "syscon", "simple-mfd";
> > +			reg = <0x200 0x4>;
> 
> This holds mac-address which is at least 48bits long
> 
> > +			bootph-all;
> > +		};
> > +
> > +		usb0_phy_pll_refclk: syscon@4008 {
> > +			compatible = "syscon", "simple-mfd";
> > +			reg = <0x4008 0x10>;
> > +			bootph-all;
> > +		};
> > +
> > +		usb1_phy_pll_refclk: syscon@4018 {
> > +			compatible = "syscon", "simple-mfd";
> > +			reg = <0x4018 0x10>;
> > +			bootph-all;
> 
> This adds new dtbs_check warnings:
> 
> +/workdir/arch/arm64/boot/dts/ti/k3-am62p5-sk.dtb: syscon@100000: $nodename:0: 'syscon@100000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
> +/workdir/arch/arm64/boot/dts/ti/k3-am62p5-sk.dtb: syscon@200: compatible: ['syscon', 'simple-mfd'] is too short
> +/workdir/arch/arm64/boot/dts/ti/k3-am62p5-sk.dtb: syscon@4008: compatible: ['syscon', 'simple-mfd'] is too short
> +/workdir/arch/arm64/boot/dts/ti/k3-am62p5-sk.dtb: syscon@4018: compatible: ['syscon', 'simple-mfd'] is too short
>
> 
> I suggest to drop them for now.
> 
> Please add a new yamls for these nodes or single yaml for top level wkup_conf to 
> cover am62/62a/62p SoCs and then introduce the nodes accordingly
> 

Ah man I didn't see these warnings. Yeah dropping USB and CPSW may be 
the only way for now :/

Thanks again for the review Vignesh
~Bryan

