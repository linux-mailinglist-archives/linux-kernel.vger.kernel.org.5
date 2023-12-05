Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338A9804E42
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbjLEJoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbjLEJoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:44:02 -0500
X-Greylist: delayed 2452 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Dec 2023 01:44:05 PST
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D211AFA;
        Tue,  5 Dec 2023 01:44:05 -0800 (PST)
Received: from p200301077700c3001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:c300:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1rARxy-0072Tw-GJ; Tue, 05 Dec 2023 10:43:46 +0100
Date:   Tue, 5 Dec 2023 10:43:43 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>, Andrew Davis <afd@ti.com>,
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
        =?UTF-8?B?QmVub8OudA==?= Cousson <bcousson@baylibre.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-omap@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH RFC 01/10] dt-bindings: gpu: Add PowerVR Series5 SGX
 GPUs
Message-ID: <20231205104343.2e3c4105@aktux>
In-Reply-To: <78a81d54-f12c-401e-9a26-5125eb0b1c65@linaro.org>
References: <20231204182245.33683-1-afd@ti.com>
        <20231204182245.33683-2-afd@ti.com>
        <b97f04f6-cda2-4e9b-b729-a5149e36f978@linaro.org>
        <20231205075657.GN5169@atomide.com>
        <df7dd7b0-f315-4033-985a-175f75568a8c@linaro.org>
        <20231205081031.GO5169@atomide.com>
        <efcd64f4-00d2-4671-af3a-e27764f70e8d@linaro.org>
        <20231205083001.GP5169@atomide.com>
        <27f2e3a3-0791-4278-adb2-55ed76820a3a@linaro.org>
        <20231205100246.5db0d6a1@aktux>
        <78a81d54-f12c-401e-9a26-5125eb0b1c65@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2023 10:27:56 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 05/12/2023 10:02, Andreas Kemnade wrote:
> > On Tue, 5 Dec 2023 09:45:44 +0100
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >   
> >>> Sure the clock nodes can be there for the child IP, but they won't do
> >>> anything. And still need to be managed separately by the device driver if
> >>> added.    
> >>
> >> So if OS does not have runtime PM, the bindings are wrong? Bindings
> >> should not depend on some particular feature of some particular OS.  
> > 
> > Any user of the devicetree sees that there is a parent and the parent needs
> > to be enabled by some mechanism.
> > E.g. I2c devices do not specify the clocks of the parent (the i2c master)  
> 
> If you use this analogy, then compare it with an I2C device which has
> these clock inputs. Such device must have clocks in the bindings.
> 
I would see target-module = i2c master.

Well, if there is a variant of the i2c device which does not require
external clocks and a variant which requires it, then clock can be
optional.

> > 
> > Maybe it is just more fine-grained on omap.
> > 
> > look e.g. at ti/omap/omap4-l4.dtsi
> > there are target-module@xxxx
> > with the devices as a child and a clock in the parent.  
> 
> Not related to runtime PM...
> 
Well, runtime PM is just the linux-specific mechanism to enable the
resources needed by the parent, so yes, it is not related... As said,
another OS can have another mechanism.

But anyways, the target module specifies resources which are required.

Regards,
Andreas
