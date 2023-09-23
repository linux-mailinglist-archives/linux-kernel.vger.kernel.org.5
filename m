Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4D07AC144
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 13:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjIWLgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 07:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjIWLgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 07:36:02 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC93198;
        Sat, 23 Sep 2023 04:35:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695468932; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Fphbs3qFwIRRR1DioCFESz3HsUEwsBCTLkq+P2/1v78+R3TUZoVIMhgY3s+SwD85XK
    Jfqu4eEaGh5qX8QGf+3dephS0peqLW4nxRtZJ10C26yH2tfAdNlqE2s4EXjUZoYun87P
    NqkPX1WunBMLm4iZ2ri4oILiDqt7gTytBO2quh9ypIKssBzSwNPiL61lyDWgzlkbhR3e
    UUNB5c7VPBRYWlfwHg1K7NkHjsJcufB4FXJYz/SYU5VXmhNHCDKATL3YpvuBZrBIfMHC
    2Y9WR+Jf97FECGiTBWL++ys4vj201ZSpGXSmapJrgdwxuGAJMn+8/AjbFymkEYMPO/MO
    0NPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695468932;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=3Ed/4cpi3TGNdk2MJ6s1ZHaWjH5CNoWzYAuxmgsLtmY=;
    b=OBgRoOWHOjShqjzQrE2oswiGAwq7HpMPjb+ztmAVxpVPZGkjIvf359HBmUQTgGTLUx
    vVKe+jrcJopoc+IqMaf5mEEFkSdx47MIH0mk9D18FMRRYBcLSujF6ilkq4YqUkuGE5oR
    TC0d54A/dRS6t5DB2CPXh2HvCWWOkUkjzWsJdcMUJjHR21NkjiAfQFQNgNcobHuLHlGf
    R8JOXq1JoDSqY+WBcKegPqmRkqlTs+Ms3esJfbLtxmqYkBEVMZLiACgm7eyxSXIDXDX6
    wTRkeeiB6nLiOEAAv28v4OUkfZeokS2zO3cVXaHbjF2OMzH8A0hp0d9xf7Em3Z7xXNap
    pa+Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695468931;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=3Ed/4cpi3TGNdk2MJ6s1ZHaWjH5CNoWzYAuxmgsLtmY=;
    b=gmZcn60G7lti7RE2Jatdc7BxBkQU1gSR9r7UUYU5s0mwuD6x+hM3z8fUAgWAA1fHnj
    aYOSt/W8ZBY9mTLfPneOLsdBSaOKaVrQLw37/CdRSvAPgJN+awMJ/r7HQW8cPs4rHyrp
    X5Ia8ow/YhzS3kBpFkr86enP2VFEASU6b7Wk5tOQ5NuZeYi3tsKYhT11MsJwrtAh+Kg2
    trsUv2WvRFiJb8EyUFhRrJWvIOU6MZ84Fb9iFfvM2Ko1uq81ZObxSQSBN2g63JkpwmdH
    t5TBuwcfLg4oo8KalLTaSVe3c7DJENQ3O7/zH4KvoifGLxX6PKl2C0iTmz5dtolupJK3
    usjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695468931;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=3Ed/4cpi3TGNdk2MJ6s1ZHaWjH5CNoWzYAuxmgsLtmY=;
    b=pnJ5JgQhZeTw8hfChtHqOiA6syl4jZlwFuuAQ5S/hl5lU5geq3rePktozfuRbNe7oI
    VuwIt5E/xmB4FSaHH+Dw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA+p3h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z8NBZVVuO
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 23 Sep 2023 13:35:31 +0200 (CEST)
Date:   Sat, 23 Sep 2023 13:35:25 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Matti =?iso-8859-1?Q?Lehtim=E4ki?= <matti.lehtimaki@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pinctrl: qcom: msm8226: Add MPM pin mappings
Message-ID: <ZQ7NcuLOAwAJgQNr@gerhold.net>
References: <20230922224027.85291-1-matti.lehtimaki@gmail.com>
 <10339711.nUPlyArG6x@z3ntu.xyz>
 <ZQ63VCVfR51Ueunv@gerhold.net>
 <7570584.EvYhyI6sBW@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7570584.EvYhyI6sBW@z3ntu.xyz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 01:19:46PM +0200, Luca Weiss wrote:
> On Samstag, 23. September 2023 12:00:52 CEST Stephan Gerhold wrote:
> > On Sat, Sep 23, 2023 at 11:32:47AM +0200, Luca Weiss wrote:
> > > Hi Matti,
> > > 
> > > On Samstag, 23. September 2023 00:40:26 CEST Matti Lehtimäki wrote:
> > > > Add pin <-> wakeirq mappings to allow for waking up the AP from sleep
> > > > through MPM-connected pins.
> > > > 
> > > > Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> > > > ---
> > > > 
> > > >  drivers/pinctrl/qcom/pinctrl-msm8226.c | 12 ++++++++++++
> > > >  1 file changed, 12 insertions(+)
> > > > 
> > > > diff --git a/drivers/pinctrl/qcom/pinctrl-msm8226.c
> > > > b/drivers/pinctrl/qcom/pinctrl-msm8226.c index
> > > > 994619840a70..1e46a9ab382f
> > > > 100644
> > > > --- a/drivers/pinctrl/qcom/pinctrl-msm8226.c
> > > > +++ b/drivers/pinctrl/qcom/pinctrl-msm8226.c
> > > > @@ -612,6 +612,16 @@ static const struct msm_pingroup msm8226_groups[] =
> > > > {
> > > > 
> > > >  #define NUM_GPIO_PINGROUPS 117
> > > > 
> > > > +static const struct msm_gpio_wakeirq_map msm8226_mpm_map[] = {
> > > > +	{ 1, 3 }, { 4, 4 }, { 5, 5 }, { 9, 6 }, { 13, 7 }, { 17, 8 },
> > > 
> > > I'm not really convinced this is the correct order of values...
> > > 
> > > Let's look at downstream:
> > >   qcom,gpio-map = <3  1>,
> > >   
> > >                   <4  4 >,
> > >                   <5  5 >,
> > >                   <6  9 >,
> > >                   [...]
> > > 
> > > From Documentation/devicetree/bindings/arm/msm/mpm.txt downstream:
> > >   Each tuple represents a MPM pin and which GIC interrupt is routed to it.
> > > 
> > > So first is pin number, second is interrupt number.
> > > 
> > > And check mainline:
> > >   /**
> > >   
> > >    * struct msm_gpio_wakeirq_map - Map of GPIOs and their wakeup pins
> > >    * @gpio:          The GPIOs that are wakeup capable
> > >    * @wakeirq:       The interrupt at the always-on interrupt controller
> > >    */
> > >   
> > >   struct msm_gpio_wakeirq_map {
> > >   
> > >   	unsigned int gpio;
> > >   	unsigned int wakeirq;
> > >   
> > >   };
> > > 
> > > So here we also have the order pin-interrupt, not the reverse order.
> > > 
> > > Therefore I believe the order in this patch is incorrect, and it should
> > > rather> 
> > > be:
> > >   { 3, 1 }, { 4, 4 }, { 5, 5 }, { 6, 9 }, { 7, 13 }, { 8, 17 },
> > >   [...]
> > > 
> > > Or do you think I'm missing something?
> > 
> > Yes :)
> > 
> > Let's look at the later entries:
> > > > +	{ 21, 9 }, { 27, 10 }, { 29, 11 }, { 31, 12 }, { 33, 13 }, { 35, 14
> > > 
> > > },
> > > 
> > > > +	{ 37, 15 }, { 38, 16 }, { 39, 17 }, { 41, 18 }, { 46, 19 }, { 48, 20
> > > 
> > > },
> > > 
> > > > +	{ 49, 21 }, { 50, 22 }, { 51, 23 }, { 52, 24 }, { 54, 25 }, { 62, 26
> > > 
> > > },
> > > 
> > > > +	{ 63, 27 }, { 64, 28 }, { 65, 29 }, { 66, 30 }, { 67, 31 }, { 68, 32
> > > 
> > > },
> > > 
> > > > +	{ 69, 33 }, { 71, 34 }, { 72, 35 }, { 106, 36 }, { 107, 37 },
> > > > +	{ 108, 38 }, { 109, 39 }, { 110, 40 }, { 111, 54 }, { 113, 55 },
> > > > +};
> > > > +
> > 
> > For example: { 113, 55 }, i.e. { .gpio = 113, .wakeirq = 55 }.
> > 
> > MSM8226 has GPIOs 0-116 and 64 MPM pins/interrupts. The order in this
> > patch is the only one that can be correct because the definition would
> > be invalid the other way around. 113 must be the GPIO number because it
> > is larger than the 64 available MPM interrupt pins. :)
> 
> So basically you're saying downstream is wrong / buggy?
> 

"Misleading" or "confusing" would be the words I would use. :-)

> From qcom,gpio-map = [...], <55 113>; it's taking the properties like this
> (drivers/soc/qcom/mpm-of.c):
> 
>   unsigned long pin = be32_to_cpup(list++);
>   irq_hw_number_t hwirq = be32_to_cpup(list++);
> 
> Your explanation does make sense I guess but somewhere the link downstream -> 
> mainline must be broken, no?
> 

After staring at mpm-of.c for a while I would say that there:
 - downstream "pin" = MPM pin = mainline "wakeirq"
   - because this is used as index to msm_mpm_irqs_m2a, which has a size
     of MSM_MPM_NR_MPM_IRQS (64)
 - downstream "hwirq" = GPIO / GIC IRQ = mainline "gpio"

This means for <55 113>: pin = wakeirq = 55 and hwirq = gpio = 113.
Which matches the definition in this patch:
  { .gpio = 113, .wakeirq = 55 } = { 113, 55 }

Stephan
