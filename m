Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2AB773156
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 23:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjHGVji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 17:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjHGVjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 17:39:37 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9783E1711;
        Mon,  7 Aug 2023 14:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=rk1Esn0Oo7EKPEgyZaR/kh1M/XdtHnqi7QAdLgotIIw=; b=x/4fk0OoEZBgp4Fb7uXNOew2Ht
        Qe3HQ5e/Rsh4F1JDElLhl8ZVGYWZBaT9KK+bpsrbURqrPhX6aG6cWpmtuZ+JmNx72xqA+gE3dOGM1
        /xY7pvBzDc7TE6OxJyCtir1Snmz9tRdzXj80UCO+4dr5ScpiCeleabk7LxNu6hDcLgOI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qT7wq-003Oe7-E2; Mon, 07 Aug 2023 23:39:32 +0200
Date:   Mon, 7 Aug 2023 23:39:32 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 4/9] arm64: dts: qcom: sa8775p-ride: add pin functions
 for ethernet1
Message-ID: <5efc1789-e989-4008-8a7c-235d1e7fa269@lunn.ch>
References: <20230807193507.6488-1-brgl@bgdev.pl>
 <20230807193507.6488-5-brgl@bgdev.pl>
 <3ocnhpal77jmsqabcmnvekk4sqgookk5sunrvb3hstaupqfaj2@whnb7uj6w7ue>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ocnhpal77jmsqabcmnvekk4sqgookk5sunrvb3hstaupqfaj2@whnb7uj6w7ue>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 04:18:21PM -0500, Andrew Halaney wrote:
> On Mon, Aug 07, 2023 at 09:35:02PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > 
> > Add the MDC and MDIO pin functions for ethernet1 on sa8775p-ride.
> > 
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> > index 09ae6e153282..38327aff18b0 100644
> > --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> > +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> > @@ -480,6 +480,22 @@ ethernet0_mdio: ethernet0-mdio-pins {
> >  		};
> >  	};
> >  
> > +	ethernet1_default: ethernet1-default-state {
> > +		ethernet1_mdc: ethernet1-mdc-pins {
> > +			pins = "gpio20";
> > +			function = "emac1_mdc";
> > +			drive-strength = <16>;
> > +			bias-pull-up;
> > +		};
> > +
> > +		ethernet1_mdio: ethernet1-mdio-pins {
> > +			pins = "gpio21";
> > +			function = "emac1_mdio";
> > +			drive-strength = <16>;
> > +			bias-pull-up;
> > +		};
> > +	};
> > +
> 
> With the whole "EMAC0 MDIO handles the ethernet phy for EMAC1", this
> doesn't seem to make sense.
> 
> I don't have all the schematics, but these pins are not connected from
> what I see.

I kind of agree. I've seen different ways of describing pinmux. What
i've done for Kirkwood was to put all the common pinmux configurations
into the SoC .dtsi file. The .dts file can then reference it if
needed.

In this case, since the bus is unused, it seems odd to mux it. And
later versions of the board could actually use the pins for something
else, GPIOs etc.

      Andrew
