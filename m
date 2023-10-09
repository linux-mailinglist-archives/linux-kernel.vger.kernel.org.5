Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23517BE3E8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376362AbjJIPIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjJIPIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:08:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 983F98F;
        Mon,  9 Oct 2023 08:08:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F38A31FB;
        Mon,  9 Oct 2023 08:08:57 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC9153F5A1;
        Mon,  9 Oct 2023 08:08:15 -0700 (PDT)
Date:   Mon, 9 Oct 2023 16:08:13 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        sudeep.holla@arm.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Oleksii_Moisieiev@epam.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [RFC v2 5/5] dt-bindings: gpio: Add bindings for pinctrl based
 generic gpio driver
Message-ID: <ZSQXXW1NRiCpsENu@e120937-lin>
References: <20231005025843.508689-1-takahiro.akashi@linaro.org>
 <20231005025843.508689-6-takahiro.akashi@linaro.org>
 <20231006132346.GA3426353-robh@kernel.org>
 <CACRpkdaLsfSBEG-h9ZNT2_Lm8tW8AZO7tedDVNeuZoQAqSkyjw@mail.gmail.com>
 <ZSPDILYZkxvTnQia@e120937-lin>
 <CACRpkdY=eza0TuBRDb_cWk9LM2qNQg76rZSgWa-RP4TYLL=Ppw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdY=eza0TuBRDb_cWk9LM2qNQg76rZSgWa-RP4TYLL=Ppw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 03:13:24PM +0200, Linus Walleij wrote:
> On Mon, Oct 9, 2023 at 11:08 AM Cristian Marussi
> <cristian.marussi@arm.com> wrote:
> 
> > > > +    gpio0: gpio@0 {
> > > > +        compatible = "pin-control-gpio";
> > > > +        gpio-controller;
> > > > +        #gpio-cells = <2>;
> > > > +        gpio-ranges = <&scmi_pinctrl 0 10 5>,
> > > > +                      <&scmi_pinctrl 5 0 0>;
> > > > +        gpio-ranges-group-names = "",
> > > > +                                  "pinmux_gpio";
> > > > +    };
> > >
> >
> > Assuming the above &scmi_pinctrl refers to the protocol node as we
> > usually do,
> 
> No it does not, it is a three-layer cake.
> 
> scmi <-> scmi_pinctrl <-> scmi_gpio
> 
> it refers to the scmi_pinctrl node.
> 

Thanks, this explains a lot.
Cristian

> There is no SCMI GPIO protocol, instead SCMI is using the
> operations already available in the pin controller to exercise
> GPIO. Generic pin control has operations to drive lines for
> example, and Takahiro is adding the ability for a generic pin
> controller to also read a line.


> 
> Yours,
> Linus Walleij
