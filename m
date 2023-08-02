Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBFC76CEDB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbjHBNfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjHBNfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:35:15 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E24D1BF9;
        Wed,  2 Aug 2023 06:35:14 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 372DZ4Us010762;
        Wed, 2 Aug 2023 08:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690983304;
        bh=4/u6kCCuKDX3VbHZKQNmNFuOe0MsX0t2WAH7bt6aPNI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=e5pYuridN6k4IRAOcxKyWbv5SsHLBDUcUNtUaqvgurwGsv05p/D7OyJmz2yz+iy78
         QtBJ3W7ZqxxCKS/niz3fzO/XMO7F/xQoPgyxT0cUCnuIOJ5LEiGN0r+Nz1hwGhCjb4
         fHZW9lCtfrv4woe4J3vap8oJGaAv7wUk3pSgZOUc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 372DZ3aL080538
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 08:35:03 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 08:35:02 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 08:35:02 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 372DZ2xs095024;
        Wed, 2 Aug 2023 08:35:02 -0500
Date:   Wed, 2 Aug 2023 08:35:02 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jai Luthra <j-luthra@ti.com>
CC:     Devarsh Thakkar <devarsht@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jayesh Choudhary <j-choudhary@ti.com>
Subject: Re: [PATCH 4/5] arm64: dts: ti: k3-am62a7-sk: Enable audio on AM62A
Message-ID: <20230802133502.zjvf7sslmcuayg5z@defog>
References: <20230731-mcasp_am62a-v1-0-8bd137ffa8f1@ti.com>
 <20230731-mcasp_am62a-v1-4-8bd137ffa8f1@ti.com>
 <aa8d2aa6-a121-51e6-77de-0e1c8bdac043@ti.com>
 <52pbbqnp46h33gymoydnjtxoo3dsb6wnytvjnmomtjdtwck536@ewhb2rngomr2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <52pbbqnp46h33gymoydnjtxoo3dsb6wnytvjnmomtjdtwck536@ewhb2rngomr2>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:10-20230802, Jai Luthra wrote:
> Hi Devarsh,
> 
> On Aug 02, 2023 at 16:15:12 +0530, Devarsh Thakkar wrote:
> > Hi Jai,
> > 
> > Thanks for the patch.
> > 
> > On 31/07/23 18:14, Jai Luthra wrote:
> > > Add nodes for audio codec and sound card, enable the audio serializer
> > > (McASP1) under use and update pinmux.
> > > 
> > > Link: https://www.ti.com/lit/zip/sprr459
> > > Signed-off-by: Jai Luthra <j-luthra@ti.com>
> > > Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>
> > > ---
> > >  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 77 +++++++++++++++++++++++++++++++++
> > >  1 file changed, 77 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> > > index 752c2f640f63..5f68d2eefe0f 100644
> > > --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> > > +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> > > @@ -125,6 +125,41 @@ led-0 {
> > >  			default-state = "off";
> > >  		};
> > >  	};
> > > +
> > > +	tlv320_mclk: clk-0 {
> > > +		#clock-cells = <0>;
> > > +		compatible = "fixed-clock";
> > > +		clock-frequency = <12288000>;
> > > +	};
> > > +
> > > +	codec_audio: sound {
> > > +		compatible = "simple-audio-card";
> > > +		simple-audio-card,name = "AM62Ax-SKEVM";
> > 
> > In my opinion better to give the codec name instead of board name here.
> 
> I agree, maybe calling it "sk-am62a-tlv320aic3106" would be the most 
> clear option.
> 
> Running a quick ripgrep on next tree:
> 
> $ rg "simple-audio-card,name" arch/*/boot/dts/
> 
> I see a healthy mix of using both board and/or codec name here - with TI 
> almost always using the board name. Maybe we can change the convention, 
> but it would be a good idea to at least update SK-AM62 as well to use 
> the new convention.
> 
> Is it okay with you if it is handled as a separate series?

Will this cleanup of existing board break any userspace? If so, NO and
follow existing "board" convention - I'd like to maintain consistency,
even if that is not exactly clean! If not, cleanup in a later series
is fine, but please make sure to follow through this week - with this
patch following the convention of choice.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
