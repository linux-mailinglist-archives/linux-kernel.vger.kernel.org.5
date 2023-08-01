Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A4876BE4F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjHAUMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHAUMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:12:07 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CEF2684;
        Tue,  1 Aug 2023 13:12:05 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 371KBdWA023600;
        Tue, 1 Aug 2023 15:11:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690920699;
        bh=9ITTukSxNJ6iY+dRHpQPqxE8G8kzSM69kn5L94u17a4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=iJPBwwyfMYYT1CIBj+DMx/ogjI2/hpXBr3awhnf+3iqYkATKdGucTitXTFaJ50wAJ
         w7Yseyi+uheyFCIAE1H4eSZxCUj5vXf3b8wlJbte0lZUa6wODhcZuxpsvm9OR+32NR
         FnDrURHNthWIukRJFxsojppu3qLLnQyr0b692cCI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 371KBdxE113152
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Aug 2023 15:11:39 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Aug 2023 15:11:39 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 1 Aug 2023 15:11:39 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 371KBdAG004137;
        Tue, 1 Aug 2023 15:11:39 -0500
Date:   Tue, 1 Aug 2023 15:11:39 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Sinthu Raja <sinthu.raja@mistralsolutions.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j721s2-main: Add dts nodes for EHRPWMs
Message-ID: <20230801201139.g3mv5ghuxe3hp5vy@crinkly>
References: <20230713114021.28450-1-sinthu.raja@ti.com>
 <20230801183345.ypzawnia7gluabqa@exclusion>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230801183345.ypzawnia7gluabqa@exclusion>
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

On 13:33-20230801, Nishanth Menon wrote:
> On 17:10-20230713, Sinthu Raja wrote:
> > From: Sinthu Raja <sinthu.raja@ti.com>
> > 
> > Add dts nodes for 6 EHRPWM instances on SoC. Disable EHRPWM nodes in the
> > dtsi files and only enable the ones that are actually pinned out on a
> > given board in the board dts file.
> > 
> > Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> > ---
> >  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 66 ++++++++++++++++++++++
> >  1 file changed, 66 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> > index ed79ab3a3271..0d3a965f764f 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> > @@ -58,6 +58,72 @@ serdes_ln_ctrl: mux-controller@80 {
> >  			mux-reg-masks = <0x80 0x3>, <0x84 0x3>, /* SERDES0 lane0/1 select */
> >  					<0x88 0x3>, <0x8c 0x3>; /* SERDES0 lane2/3 select */
> >  		};
> > +
> > +		ehrpwm_tbclk: clock-controller@140 {
> > +			compatible = "ti,am654-ehrpwm-tbclk", "syscon";
> 
> NAK. Udit: your team needs to please run dtbs_check prior to posting patches
> I had done a cleanup
> https://lore.kernel.org/all/20230713184759.3336536-1-nm@ti.com/ already
> and I dont want to reopen this again.
> 
> Please read Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
> 

Apologies, please ignore my rant. I missed the fact that this was complained about
and addressed in https://lore.kernel.org/all/20230721082150.12599-1-sinthu.raja@ti.com/

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
