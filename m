Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F3279D47D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbjILPLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbjILPLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:11:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3939115;
        Tue, 12 Sep 2023 08:11:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE9DC433C7;
        Tue, 12 Sep 2023 15:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694531490;
        bh=XvqdyTkbzYdmIFvzaFz0sUeabWQuIJEg/eBAxc9nVRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OP3qBhadnTTrB4c6LnMwpMtXpd4trRfjk9GCUS0TFWfaopUqFNZnW7UJz/P2KamPy
         bQUZqhV/yMRPKcymm9Tw9LBFhQ50yeAxFoJUk8g1X2QPycP7h0M8AeKKjbTi2n0r2x
         PjKLjVEDvxGvZLO0m1qbWm8Qx6MvtOrvbzmXLBCuewZ7qI6ujXgzbhq5uNUIjFhTPA
         2fujaj+jQ22/XPML+ropjSomHtLx4H0hNgIoTJ7+jMjQL0/D6QJhVarlKnXKbm+MF/
         jsINXr7R7mHL49BZVRMNaYZB7YvVS/UQrbQhsSrupWHzyecnNGKEQhFOtyf/EVxD64
         LT+BBefVm8Icg==
Received: (nullmailer pid 809556 invoked by uid 1000);
        Tue, 12 Sep 2023 15:11:27 -0000
Date:   Tue, 12 Sep 2023 10:11:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "naresh.solanki@9elements.com" <naresh.solanki@9elements.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "patrick@stwcx.xyz" <patrick@stwcx.xyz>
Subject: Re: [PATCH v8 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
Message-ID: <20230912151127.GA752403-robh@kernel.org>
References: <20230830123202.3408318-1-billy_tsai@aspeedtech.com>
 <20230830123202.3408318-2-billy_tsai@aspeedtech.com>
 <20230905170010.GA3505375-robh@kernel.org>
 <SG2PR06MB336567E43537C7F4947E342F8BEEA@SG2PR06MB3365.apcprd06.prod.outlook.com>
 <20230907194351.GA2033402-robh@kernel.org>
 <SG2PR06MB3365B916E3AD2CE331A0D4258BEDA@SG2PR06MB3365.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR06MB3365B916E3AD2CE331A0D4258BEDA@SG2PR06MB3365.apcprd06.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 08:49:25AM +0000, Billy Tsai wrote:
> On Thu, Sep 07, 2023 at 07:17:55AM +0000, Billy Tsai wrote:
> > > On Wed, Aug 30, 2023 at 08:32:00PM +0800, Billy Tsai wrote:
> > > >> From: Naresh Solanki <naresh.solanki@9elements.com>
> > > >> 
> > > >> Add common fan properties bindings to a schema.
> > > >> 
> > > >> Bindings for fan controllers can reference the common schema for the
> > > >> fan
> 
> 
> > > >> +properties:
> > > >> +  max-rpm:
> > > >> +    description:
> > > >> +      Max RPM supported by fan.
> > > >> +    $ref: /schemas/types.yaml#/definitions/uint32
> > > 
> > > > Physics will limit this to something much less than 2^32. Add some 
> > > > constraints. 10000?
> > > 
> > > 
> > > >> +
> > > >> +  min-rpm:
> > > >> +    description:
> > > >> +      Min RPM supported by fan.
> > > >> +    $ref: /schemas/types.yaml#/definitions/uint32
> > > 
> > > > ditto
> > > 
> > > >> +
> > > >> +  pulses-per-revolution:
> > > >> +    description:
> > > >> +      The number of pulse from fan sensor per revolution.
> > > >> +    $ref: /schemas/types.yaml#/definitions/uint32
> > > 
> > > >Needs constraints. I assume this is never more than 4 (or 2 even)?
> > > 
> > > Do you think we should add the contraint in the common binding?
> > > In my option, the limit of the max/min rpm should be declared by
> > > the binding if necessary, because the usage of each fan monitor is
> > > based on the connection of the tach pin.
> 
> > Yes, I think we should have default limits.
> 
> > Unless we go as far as a schema for every specific fan model, then there 
> > is actually no way we can have specific limits unless the fan 
> > controllers have some limits.
> 
> > The most I see in tree for pulses-per-revolution is 2. There's no value 
> > in more. So set the max to 4 and then if anyone needs more they can bump 
> > the value.
> 
> > Or maybe there's some electrical/mechanical design reason fans are 1 or 
> > 2 pulses and we'll never see anything else? This document[1] seems to 
> > indicate that is indeed the case. (First hit googling "fan tach signal 
> > pulses")
> 
> OK, I will add the maximum value for the max-rpm, min-rpm and pulses-per-revolution.
> 
> > > 
> > > 
> > > >> +  div:
> > > 
> > > > Too generic of a name.
> > > 
> > > >> +    description:
> > > >> +      Fan clock divisor
> > > 
> > > > But what is a fan clock?
> > > 
> > > This is the divisor for the tachometer sampling clock, which determines the sensitivity of the tach pin.
> > > So, if the name of the property changes to 'tach-div,' is it acceptable to you?
> 
> > That sounds like a property of the controller, not the fan, so it 
> > belongs in the controller binding. Is this really a common thing?
> 
> Yes, I believe this is a common feature for fans. You can refer to the Documentation/hwmon/sysfs-interface.rst,
> where the fan divisor is defined for users, determining the fan's sensitivity.

It's a feature of the controller, but I guess since it may be a per 
fan or tach channel setting having it in the fan node is fine. 
'tach-div' is fine.

>  
> > > >> +    $ref: /schemas/types.yaml#/definitions/uint32
> > > >> +
> > > >> +  target-rpm:
> > > >> +    description:
> > > >> +      Target RPM the fan should be configured during driver probe.
> > > 
> > > > What driver? By the time the OS driver runs, a bunch of other boot 
> > > > software has already run on modern systems. So this value would likely 
> > > > be used much earlier. The point is that when exactly is outside the 
> > > > scope of DT. This is "what RPM do I use in case of no other information 
> > > > (e.g. temperature)".
> > > 
> > > So, the description should be changed to 'The default desired fan speed in RPM,'
> > > and we shouldn't mention the timing of the property's operation in the DT, is that correct?
> 
> > Correct.
> 
> > > 
> > > >> +    $ref: /schemas/types.yaml#/definitions/uint32
> > > >> +
> > > >> +  mode:
> > > 
> > > > Too generic.
> > > 
> > > >> +    description:
> > > >> +      Select the operational mode of the fan.
> > > 
> > > > What are modes? Spin and don't spin?
> > > 
> > > The mode is used to indicate the driving mode of the fan (DC, PWM and so on).
> > > So, if the name of the property changes to 'fan-driving-mode,' is it acceptable to you?
> 
> > I tend to think that should be implied from the parent node and/or other 
> > properties. PWM if "pwms" property is present. DC if the supply is 
> > variable. We could also use compatible strings in the fan nodes if 
> > there's a need.
> 
> So, it looks that this property isn't necessary for the fan. And it should be determined by the
> present of the driving source. is that correct?

Looking back, I see Guenter asked for something like this. So I guess it 
is fine to keep if he still thinks we need it. I think it could also be 
implied a bit more clearly if we do 'cooling-levels' as below. The fan 
controller should know what modes it can do. Duty cycle vs. voltage in 
uV is pretty easy to distinguish.

> 
> > That reminds me, both of these modes probably need a table of 
> > voltage/duty-cycle to RPMs. I imagine it's not always a linear response.  
> > Naresh also privately sent me (don't do that) an updated common binding 
> > which we discussed the need for this. I expect him to comment further 
> > with details.
> 
> For this purpose, we should add the speed-map like the usage of the gpio-fan, right?
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/hwmon/gpio-fan.txt

That should be fine. I guess it comes down to whether we want one 
property or 3 depending on whether the control is voltage, duty-cycle, 
GPIO pins state, etc. Unfortunately, it's "gpio-fan,speed-map", not 
"speed-map", so we can't use that as-is. There's also "cooling-levels" 
which can accomplish the same thing. We don't know RPMs with that, but 
do we need to? Maybe, as it seems some drivers want to set speed in RPMs 
from userspace. Could also do something like this:

cooling-levels = < 33   66  100>;
rpm-levels =     <500 1000 1500>;

"rpm-levels" would replace the min-rpm/max-rpm properties.


Also, looking at gpio-fan.txt, it looks like you should add 
"#cooling-cells" as well.

Rob
