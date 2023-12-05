Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A8E804C6C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbjLEIbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjLEIbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:31:00 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11953D43;
        Tue,  5 Dec 2023 00:31:03 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id 9B1E26042D;
        Tue,  5 Dec 2023 08:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1701765062;
        bh=swrVHZbhWDxCODyjsNt232tWJXmmCylCOu5L8kw8Q+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PjFPbmXT7q8uOgIzJGh4VmxKxeHkr95aTuM5sK09gM/ph64TOwsasG+jrQoiNl7bK
         LZItCfw2bSweP4pM77h4V6B2/8krGniRklX9Gg0kaGZgoqJO6mD56ZTm1o+7mQfsCT
         fnFE/oWcA7vch8SgDBYQnK5pbO1FbSTxXtUE0X/Vgx1kt2OSA+qaMXgSDimRUqpHbX
         NJcGN1bzGVPpsjL8G99Tg6QoUK2Vjh18SmOoPVZWIsQYPQq+ca7N3pWTfv6xax6vwp
         bcM1z6j5oBxf9T//ZynM5mYrS6iBDsYmmKib2BtJ/m+JAt+ihRfXE+QsmZagu+tFJ0
         9+7XBiWalgTqA==
Date:   Tue, 5 Dec 2023 10:30:01 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andrew Davis <afd@ti.com>, Frank Binns <frank.binns@imgtec.com>,
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
Message-ID: <20231205083001.GP5169@atomide.com>
References: <20231204182245.33683-1-afd@ti.com>
 <20231204182245.33683-2-afd@ti.com>
 <b97f04f6-cda2-4e9b-b729-a5149e36f978@linaro.org>
 <20231205075657.GN5169@atomide.com>
 <df7dd7b0-f315-4033-985a-175f75568a8c@linaro.org>
 <20231205081031.GO5169@atomide.com>
 <efcd64f4-00d2-4671-af3a-e27764f70e8d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efcd64f4-00d2-4671-af3a-e27764f70e8d@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> [231205 08:16]:
> On 05/12/2023 09:10, Tony Lindgren wrote:
> > * Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> [231205 08:03]:
> >> What does runtime PM have to do with it? If runtime PM enables clocks,
> >> these are real signals and not optional.
> > 
> > Runtime PM propagates to the parent device.
> 
> Then it is not really relevant to the hardware talk here, unless you put
> this device clocks in parent node, but then it's just wrong hardware
> description.

No it's not. The interconnect target module may have one or more separate
devices with the same shared clocks. See for example the am3 usb module that
has usb controllers, phys and dma at target-module@47400000 in am33xx.dtsi.

Sure the clock nodes can be there for the child IP, but they won't do
anything. And still need to be managed separately by the device driver if
added.

Regards,

Tony
