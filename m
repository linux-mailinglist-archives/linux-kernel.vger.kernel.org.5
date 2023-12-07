Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E698080E7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 07:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377664AbjLGGjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 01:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377662AbjLGGjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 01:39:01 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B5810CB;
        Wed,  6 Dec 2023 22:39:06 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id 25AE36045F;
        Thu,  7 Dec 2023 06:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1701931146;
        bh=WJ0wR74d+mkwm+IUhYNno9dDAtwE/eqL/spvRAJBdfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NB5K6bbGCpg41F4Y2JGI/TNwe3RGFW3Rb4TSnkoscLAJWyiJiI9oXkVCYi5gJHMUE
         rec/JKiVE0yT1vYJQYhdXWSOpHIN54QGzL6WqfqoxkLv91onW6Dz79NJ6Vdb3udRhT
         g4HB3bZFTntDqubO+X3JvKDCdaKA0DekPQ4uWpzaKpeKqvgHMCIg8HwkhVRqCravtn
         YeFizvmnz0qBvGZ2CbSPVnG4I+Gr9T0sxFMTO9tFLKvsPkuLc89p9Vr2tw7BtmLd1j
         PUVaUSKJDGuguxsfKpyxZIFKGKz5PBUnOl4Ij7KZmXv3Ryh00sxy2R/JOPY1RyCIZ1
         XKfEq9e8Lqa+Q==
Date:   Thu, 7 Dec 2023 08:38:02 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andrew Davis <afd@ti.com>,
        Frank Binns <frank.binns@imgtec.com>,
        Donald Robson <donald.robson@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Adam Ford <aford173@gmail.com>,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-omap@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH RFC 01/10] dt-bindings: gpu: Add PowerVR Series5 SGX GPUs
Message-ID: <20231207063802.GR5169@atomide.com>
References: <b97f04f6-cda2-4e9b-b729-a5149e36f978@linaro.org>
 <20231205075657.GN5169@atomide.com>
 <df7dd7b0-f315-4033-985a-175f75568a8c@linaro.org>
 <20231205081031.GO5169@atomide.com>
 <efcd64f4-00d2-4671-af3a-e27764f70e8d@linaro.org>
 <20231205083001.GP5169@atomide.com>
 <27f2e3a3-0791-4278-adb2-55ed76820a3a@linaro.org>
 <20231205100246.5db0d6a1@aktux>
 <78a81d54-f12c-401e-9a26-5125eb0b1c65@linaro.org>
 <20231205104343.2e3c4105@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205104343.2e3c4105@aktux>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [231205 09:43]:
> On Tue, 5 Dec 2023 10:27:56 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
> > On 05/12/2023 10:02, Andreas Kemnade wrote:
> > > On Tue, 5 Dec 2023 09:45:44 +0100
> > > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> > >   
> > >>> Sure the clock nodes can be there for the child IP, but they won't do
> > >>> anything. And still need to be managed separately by the device driver if
> > >>> added.    
> > >>
> > >> So if OS does not have runtime PM, the bindings are wrong? Bindings
> > >> should not depend on some particular feature of some particular OS.  
> > > 
> > > Any user of the devicetree sees that there is a parent and the parent needs
> > > to be enabled by some mechanism.
> > > E.g. I2c devices do not specify the clocks of the parent (the i2c master)  

Yeah the interconnect target module needs to be enabled before the child
IP can be probed for any OS. That is unless the target module is left on
from the bootloader.

But like I said, I have no objection to also having the clocks for the
child SGX device here. I think two out of the tree SGX clocks are merged,
so one of the three clocks would repeat twice in the binding.

We do provide some of the clock aliases, like fck and ick, for the child
ip automatically by the ti-sysc interconnect target module. But likely we
don't want to clock name specific handling in the driver so best to
standardize on SGX specific clock names. That is if the clock properties
are not set optional.

> > If you use this analogy, then compare it with an I2C device which has
> > these clock inputs. Such device must have clocks in the bindings.
> > 
> I would see target-module = i2c master.
> 
> Well, if there is a variant of the i2c device which does not require
> external clocks and a variant which requires it, then clock can be
> optional.

Yes that sounds about right for an analogy :)

Regards,

Tony
