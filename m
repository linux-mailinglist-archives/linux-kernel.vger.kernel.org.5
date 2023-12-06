Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD2F80709C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378467AbjLFNLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378426AbjLFNLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:11:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633D4122
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:11:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7663C433C8;
        Wed,  6 Dec 2023 13:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701868300;
        bh=oKRQwjQGrRuXRGCinFYih9JQNoNZM1Tw5h7ae1B3fyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OlRop1enKtnGbB71sEGXYrmdNaumfmLuJD4K+tNdE99DMFqt6E3yZS+WzdqPCua/d
         OV7jfse4o/PGxOwE+z6QPXXA2JBPAv9LOdEdyEeV/sTliV0wu3bJcVszTojoicoodt
         ak1jK4+8SsabBz1TcrNQwgEk/VYFEpNIUYtWUZXP2iRH19c39CPMU/UhUCRkuQEaZq
         J8BK7SUb2yP2Ay/Sc2+jJsjO4I0WuYBvuWeviW2f7Jz601mjNRiXM8k7VIYrz7vzBk
         0LNZgFUrFrnotZQFBZAvknm0HjCEEPdM/8JbdM7ynsWmxOwqkhghJgudl9s5KIyHXd
         xmqjZoKmbTybQ==
Date:   Wed, 6 Dec 2023 13:11:34 +0000
From:   Lee Jones <lee@kernel.org>
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andy.shevchenko@gmail.com, kernel@sberdevices.ru,
        rockosov@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v5 00/11] leds: aw200xx: several driver updates
Message-ID: <20231206131134.GA3375667@google.com>
References: <20231125200519.1750-1-ddrokosov@salutedevices.com>
 <170142898612.3365188.2222761548333694548.b4-ty@kernel.org>
 <20231206112958.xlzrzorkzzexwpwe@CAB-WSD-L081021>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231206112958.xlzrzorkzzexwpwe@CAB-WSD-L081021>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Dec 2023, Dmitry Rokosov wrote:

> Hello Lee,
> 
> On Fri, Dec 01, 2023 at 11:09:46AM +0000, Lee Jones wrote:
> > On Sat, 25 Nov 2023 23:05:08 +0300, Dmitry Rokosov wrote:
> > > The following patch series includes several updates for the AW200XX LED
> > > driver:
> > >     - some small fixes and optimizations to the driver implementation:
> > >       delays, autodimming calculation, disable_locking regmap flag,
> > >       display_rows calculation in runtime;
> > >     - fix LED device tree node pattern to accept LED names counting not
> > >       only from 0 to f;
> > >     - add missing reg constraints;
> > >     - support HWEN hardware control, which allows enabling or disabling
> > >       AW200XX RTL logic from the main SoC using a GPIO pin;
> > >     - introduce the new AW20108 LED controller, the datasheet for this
> > >       controller can be found at [1].
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [01/11] leds: aw200xx: fix write to DIM parameter
> >         commit: 785fec3a8daff2957fd55e49cbdfe0a50866fdb7
> > [02/11] leds: aw200xx: support HWEN hardware control
> >         commit: eabe8239022cf3c75b90d9ee07dcfbbe4e50bcac
> > [03/11] dt-bindings: leds: aw200xx: introduce optional enable-gpios property
> >         commit: e91899ea3759d04e185721153a036e1a25e315b7
> > [04/11] leds: aw200xx: calculate dts property display_rows in the driver
> >         commit: 4ccd392c3ea7ceefbee58622e634d4997ef46acc
> > [05/11] dt-bindings: leds: aw200xx: remove property "awinic,display-rows"
> >         commit: 66d078f105837670c52bb31da29e26ad13bc2923
> > [06/11] leds: aw200xx: add delay after software reset
> >         commit: aac13e5630d6e081a9f6c5a57e5e6fc1152acca8
> > [07/11] leds: aw200xx: enable disable_locking flag in regmap config
> >         commit: 851fa70b9b162bbf5b5f5f92fc450633e6b21a3a
> > [08/11] leds: aw200xx: improve autodim calculation method
> >         commit: 5fcc24b92b43f012cbf430244f0698ff588ec9fc
> > [09/11] leds: aw200xx: add support for aw20108 device
> >         commit: abc74724d5e714bb3359124f3576d5318828a83e
> > [10/11] dt-bindings: leds: awinic,aw200xx: add AW20108 device
> >         commit: d6bbe677add2c560ae4aa2f9dab7a19c287e2193
> > [11/11] dt-bindings: leds: aw200xx: fix led pattern and add reg constraints
> >         commit: 5707a06e5391a4eeaf0c2705f973336537a41c79
> 
> Thank you for applying the patch series!
> 
> Could you please advise where I can find the above commits? I've tried
> looking in the 'lee/leds' branch, but I couldn't find anything. I want

They there now and should be in -next by tomorrow.

> to cherry-pick the commits that you applied to my internal branch, which
> I sync with the upstream periodically.

I suggest that a rebase might be a better approach.

-- 
Lee Jones [李琼斯]
