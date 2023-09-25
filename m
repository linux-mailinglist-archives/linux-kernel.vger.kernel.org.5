Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B6B7AD726
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 13:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjIYLnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 07:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjIYLnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 07:43:31 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B12101;
        Mon, 25 Sep 2023 04:43:24 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EC3322C6;
        Mon, 25 Sep 2023 13:41:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1695642102;
        bh=7drmX4x0568COQ3pmzKZZ5GBj/TdmLP8mLIm57UxoTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kdMLdujFa+CaEAZgea7ohvBwyIGATOAD46fquHT85pDVPg8wfFfhb0E4VPru3Eiky
         TP6THd4p+RNmisuYDj1FxIsv93yIne1grVH2+/odWIVVe45WP0Hs9IVJPHlO4+eVUt
         RB4GmJgmkL1P+o0QWWp8EhRUF7D7dboQvBwuSg70=
Date:   Mon, 25 Sep 2023 14:43:32 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Alain Volmat <alain.volmat@foss.st.com>
Cc:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Dan Scally <dan.scally@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] ARM: dts: stm32: add dcmipp support to stm32mp135
Message-ID: <20230925114332.GC8583@pendragon.ideasonboard.com>
References: <20230901155732.252436-1-alain.volmat@foss.st.com>
 <20230901155732.252436-5-alain.volmat@foss.st.com>
 <20230905090258.GC31594@pendragon.ideasonboard.com>
 <20230922160227.GA608616@gnbcxd0016.gnb.st.com>
 <20230922160818.GJ19112@pendragon.ideasonboard.com>
 <20230925113542.GA646870@gnbcxd0016.gnb.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230925113542.GA646870@gnbcxd0016.gnb.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 01:35:42PM +0200, Alain Volmat wrote:
> On Fri, Sep 22, 2023 at 07:08:18PM +0300, Laurent Pinchart wrote:
> > On Fri, Sep 22, 2023 at 06:02:27PM +0200, Alain Volmat wrote:
> > > On Tue, Sep 05, 2023 at 12:02:58PM +0300, Laurent Pinchart wrote:
> > > > On Fri, Sep 01, 2023 at 05:57:23PM +0200, Alain Volmat wrote:
> > > > > From: Hugues Fruchet <hugues.fruchet@foss.st.com>
> > > > > 
> > > > > Add dcmipp support to STM32MP135.
> > > > > 
> > > > > Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
> > > > > Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> > > > > ---
> > > > >  arch/arm/boot/dts/st/stm32mp135.dtsi | 8 ++++++++
> > > > >  1 file changed, 8 insertions(+)
> > > > > 
> > > > > diff --git a/arch/arm/boot/dts/st/stm32mp135.dtsi b/arch/arm/boot/dts/st/stm32mp135.dtsi
> > > > > index abf2acd37b4e..beee9ec7ed0d 100644
> > > > > --- a/arch/arm/boot/dts/st/stm32mp135.dtsi
> > > > > +++ b/arch/arm/boot/dts/st/stm32mp135.dtsi
> > > > > @@ -8,5 +8,13 @@
> > > > >  
> > > > >  / {
> > > > >  	soc {
> > > > > +		dcmipp: dcmipp@5a000000 {
> > > > > +			compatible = "st,stm32mp13-dcmipp";
> > > > > +			reg = <0x5a000000 0x400>;
> > > > > +			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
> > > > > +			resets = <&rcc DCMIPP_R>;
> > > > > +			clocks = <&rcc DCMIPP_K>;
> > > > > +			status = "disabled";
> > > > 
> > > > This needs a port, as it's marked as required in the bindings. You can
> > > > leave the endpoint out.
> > > 
> > > I first agreed with your comment but, having done the check (make
> > > CHECK_DTBS=y  ...) this doesn't seem to be required because the dcmipp
> > > node is kept disabled within our dtsi.
> > 
> > Interesting.
> > 
> > > (it is later on only enabled in dts file which as well have the port
> > > property).
> > > Indeed, to check this I changed it to okay and DTC_CHK complained about
> > > missing port property.
> > > 
> > > Hence, I'd think that port doesn't have to be added in this dtsi file.
> > > Would you agree with that ?
> > 
> > I still think the port belongs here, as it's an intrinsic property of
> > the dcmipp, not a property of the board. Does it cause any issue to add
> > a port in the .dtsi ?
> 
> I agree that the port refers more to the SoC (hence dtsi) rather than
> the board (hence dts), however I am wondering if this is really
> something usually done.  I had a look at other dtsi with node related
> to similar kind of devices and it seems to me that there is no such case
> of a dtsi with a port having nothing in it.  Did I missed something ?

Look at the csi@32e4000 and csi@32e5000 nodes in
arch/arm64/boot/dts/freescale/imx8mp.dtsi for instance. There are quite
a few other examples.

> > > > With this fixed,
> > > > 
> > > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > 
> > > > > +		};
> > > > >  	};
> > > > >  };

-- 
Regards,

Laurent Pinchart
