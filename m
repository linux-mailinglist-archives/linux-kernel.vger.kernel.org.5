Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D0F7ABF78
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 12:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjIWKBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 06:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjIWKBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 06:01:21 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21426199;
        Sat, 23 Sep 2023 03:01:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695463260; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=SOwtE8p7O4MdBm2QHtWNtB04u+ohAVr9S9pNEkBHKWwDNhCs5OWS9SAyQj0OYv6OjF
    UyEVmw59nnIVjEd7BU5tokekOMyAv6Pm9K7ncmT6fLI14eQAauOYJUw+knblUDlCJ9iC
    dveN4dAbfOLTEsCBWs+7jq8udeNco9Yd/D56LiQIqlQT+vD/oq6uyVsnUtOs5oBgjCH8
    48/cXqaxEACZ0bBaoRHkEFBbgBUrg8RddNIJjENh8+u0N+lV0WJsknq2IsTRtzCny7kc
    IbH9OzwWtX0Sv85nXp7/23KyW8H461oJXQ+kl4sCj5GEhZ5CLDUOQyWIduiwUBedQZmQ
    jbqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695463260;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=y/LWFlnNJk8p3a1fOpeYQEnkfVUcN4zPkKbPDikCflU=;
    b=Emi5iVoquMFUQgZhM7zNjPT6inypZ19jN8IG3EWhBbN+cgj75+V/B7+BH0+A5iRamQ
    JtVLcNn51YhCM5QVldUwekTLR+Dgg5t6WJj4tTyHeFP5IeHnWeCH4sjWNKmERBz//R57
    mASaTCUScdK/HSaK3L5R8kyDybdN5zUGIkTkDV7B/PfReJIbcc2GquaJOs/6h15rYBps
    A7Gh3JTT5l6LqdY/Snue2t+BiFxIfe+pJ9aZstIfurVdryiMTRa041vO49DYjYV0ys73
    3ZHU6F7/mxfVgpZnzYJL1FXTZc9IF0YUtj9IOPmooW5U4j00qMM9ptfwZCCX3g8iN3md
    gBDg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695463260;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=y/LWFlnNJk8p3a1fOpeYQEnkfVUcN4zPkKbPDikCflU=;
    b=YPjQHJgFI6mxDCrrc3AoioEuSkpSjUdd6VaN4vGQHzUHTy/PnL+ZcF7TAB4ID0SrmV
    PBY0jz4F4F+j+5R2bqv1uFZMD6uHWPT23J8Hbzj4kw/BC5kdRJjzPLW+CUE3c/vTjDit
    21Uoa3VC/G9z8+WtEWHkzDgejbr20XsavFp8LUlvdOKwFU4XS8OL6/QUjGDAuw4yu+xh
    ObTk7AuEp5t8rxag6Lx2YyZGWBtyS+ikw5sucomggwZDLsk65UH+33zAssOMVsPRusQ9
    jqNlBFbLYyefF59C5/GIUebuN+7BA+vTd2bagEJwEbjXIvWZAlbFM/8tXp2ir8GMAgG3
    ww9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695463260;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=y/LWFlnNJk8p3a1fOpeYQEnkfVUcN4zPkKbPDikCflU=;
    b=k+N0857/KDhfMNHKiGyhi7p0vrGQCAkA97wLaml9H1SMXNZfAfG/shdFEmArbCUbLs
    3EM5FTt337U4h11t/4BQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA+p3h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z8NA0xVlK
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 23 Sep 2023 12:00:59 +0200 (CEST)
Date:   Sat, 23 Sep 2023 12:00:52 +0200
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
Message-ID: <ZQ63VCVfR51Ueunv@gerhold.net>
References: <20230922224027.85291-1-matti.lehtimaki@gmail.com>
 <20230922224027.85291-2-matti.lehtimaki@gmail.com>
 <10339711.nUPlyArG6x@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10339711.nUPlyArG6x@z3ntu.xyz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 11:32:47AM +0200, Luca Weiss wrote:
> Hi Matti,
> 
> On Samstag, 23. September 2023 00:40:26 CEST Matti Lehtimäki wrote:
> > Add pin <-> wakeirq mappings to allow for waking up the AP from sleep
> > through MPM-connected pins.
> > 
> > Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> > ---
> >  drivers/pinctrl/qcom/pinctrl-msm8226.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/pinctrl/qcom/pinctrl-msm8226.c
> > b/drivers/pinctrl/qcom/pinctrl-msm8226.c index 994619840a70..1e46a9ab382f
> > 100644
> > --- a/drivers/pinctrl/qcom/pinctrl-msm8226.c
> > +++ b/drivers/pinctrl/qcom/pinctrl-msm8226.c
> > @@ -612,6 +612,16 @@ static const struct msm_pingroup msm8226_groups[] = {
> > 
> >  #define NUM_GPIO_PINGROUPS 117
> > 
> > +static const struct msm_gpio_wakeirq_map msm8226_mpm_map[] = {
> > +	{ 1, 3 }, { 4, 4 }, { 5, 5 }, { 9, 6 }, { 13, 7 }, { 17, 8 },
> 
> I'm not really convinced this is the correct order of values...
> 
> Let's look at downstream:
> 
>   qcom,gpio-map = <3  1>,
>                   <4  4 >,
>                   <5  5 >,
>                   <6  9 >,
>                   [...]
> 
> From Documentation/devicetree/bindings/arm/msm/mpm.txt downstream:
> 
>   Each tuple represents a MPM pin and which GIC interrupt is routed to it.
> 
> So first is pin number, second is interrupt number.
> 
> And check mainline: 
> 
>   /**
>    * struct msm_gpio_wakeirq_map - Map of GPIOs and their wakeup pins
>    * @gpio:          The GPIOs that are wakeup capable
>    * @wakeirq:       The interrupt at the always-on interrupt controller
>    */
>   struct msm_gpio_wakeirq_map {
>   	unsigned int gpio;
>   	unsigned int wakeirq;
>   };
> 
> So here we also have the order pin-interrupt, not the reverse order.
> 
> Therefore I believe the order in this patch is incorrect, and it should rather 
> be:
> 
>   { 3, 1 }, { 4, 4 }, { 5, 5 }, { 6, 9 }, { 7, 13 }, { 8, 17 },
>   [...]
> 
> Or do you think I'm missing something?
> 

Yes :)

Let's look at the later entries:

> > +	{ 21, 9 }, { 27, 10 }, { 29, 11 }, { 31, 12 }, { 33, 13 }, { 35, 14 
> },
> > +	{ 37, 15 }, { 38, 16 }, { 39, 17 }, { 41, 18 }, { 46, 19 }, { 48, 20 
> },
> > +	{ 49, 21 }, { 50, 22 }, { 51, 23 }, { 52, 24 }, { 54, 25 }, { 62, 26 
> },
> > +	{ 63, 27 }, { 64, 28 }, { 65, 29 }, { 66, 30 }, { 67, 31 }, { 68, 32 
> },
> > +	{ 69, 33 }, { 71, 34 }, { 72, 35 }, { 106, 36 }, { 107, 37 },
> > +	{ 108, 38 }, { 109, 39 }, { 110, 40 }, { 111, 54 }, { 113, 55 },
> > +};
> > +

For example: { 113, 55 }, i.e. { .gpio = 113, .wakeirq = 55 }.

MSM8226 has GPIOs 0-116 and 64 MPM pins/interrupts. The order in this
patch is the only one that can be correct because the definition would
be invalid the other way around. 113 must be the GPIO number because it
is larger than the 64 available MPM interrupt pins. :)

Thanks,
Stephan
