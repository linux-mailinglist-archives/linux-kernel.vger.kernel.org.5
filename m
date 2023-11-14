Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7E37EAF4B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjKNLfQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Nov 2023 06:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbjKNLfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:35:14 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9323CC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 03:35:10 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id 977BC604A7;
        Tue, 14 Nov 2023 11:34:46 +0000 (UTC)
Date:   Tue, 14 Nov 2023 13:34:44 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] dt-bindings: pwm: ti,pwm-omap-dmtimer: Update
 binding for yaml
Message-ID: <20231114113444.GB5169@atomide.com>
References: <20231114082709.54138-1-tony@atomide.com>
 <20231114103610.sbiicumbh2xju6lj@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20231114103610.sbiicumbh2xju6lj@pengutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Uwe Kleine-König <u.kleine-koenig@pengutronix.de> [231114 10:36]:
> Hello,
> 
> On Tue, Nov 14, 2023 at 10:27:06AM +0200, Tony Lindgren wrote:
> > +  ti,timers:
> > +    description: Timer instance phandle for the PWM
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +
> > +  ti,prescaler:
> > +    description: |
> > +      Legacy clock prescaler for timer. The timer counter is prescaled
> > +      with 2^n where n is the prescaler.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
> > +    deprecated: true
> > +
> > +  ti,clock-source:
> > +    description: |
> > +      Legacy clock for timer, please use assigned-clocks instead.
> > +      0x00 - high-frequency system clock (timer_sys_ck)
> > +      0x01 - 32-kHz always-on clock (timer_32k_ck)
> > +      0x02 - external clock (timer_ext_ck, OMAP2 only)
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [ 0, 1, 2 ]
> > +    deprecated: true
> 
> Someone could collect some bonus points by converting these:
> 
> 	$ git grep ti,clock-source arch/arm/boot
> 	arch/arm/boot/dts/ti/omap/am335x-guardian.dts:          ti,clock-source = <0x01>;
> 	arch/arm/boot/dts/ti/omap/am3517-evm.dts:               ti,clock-source = <0x01>;
> 	arch/arm/boot/dts/ti/omap/logicpd-torpedo-baseboard.dtsi:               ti,clock-source = <0x01>;
> 	arch/arm/boot/dts/ti/omap/motorola-mapphone-common.dtsi:                ti,clock-source = <0x01>;
> 	arch/arm/boot/dts/ti/omap/motorola-mapphone-common.dtsi:                ti,clock-source = <0x01>;
> 	arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi:             ti,clock-source = <0x01>;
> 	arch/arm/boot/dts/ti/omap/omap3-n900.dts:               ti,clock-source = <0x00>; /* timer_sys_ck */
> 
> (I verified, this are all about this binding.)

Agreed, we should update all those.

> otherwise LGTM:
> 
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Should this go via the pwm tree or via some arm or omap or dt tree?

Please take this via the pwm tree, there are no dependencies.

Regards,

Tony
