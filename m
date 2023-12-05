Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7EC804B95
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 08:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjLEH5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 02:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjLEH5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 02:57:53 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29C8109;
        Mon,  4 Dec 2023 23:57:59 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id 9065F60354;
        Tue,  5 Dec 2023 07:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1701763079;
        bh=h3c0XIZu8HbtvK19lq1dOZHqca7qeD59maL/gJhxeU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OvctUa8QMANcluWAdRPNxxmD+MVnpSnWC7upoG4UBmVkldsPZDF5bG4K2pjCO2el1
         k7PF1jodRp1xIPKpY9F/Sqd++pafBjiWkEUQ93eB4XUu5cBd+RWhmo94eBTBZeIcaf
         yy6jzlahvKwGQYE/lZ+B0Jk1nAc5YcbFbC7mFp7lYigIiUf9iPyWjV4KXnIgf8oAKP
         2RfpM3jym7Z1TlujzL9SLs34YjoJm6iXY5wnan1T7/oVqW5nLCnBrE0dt8jw0mjJBY
         WzQI/kVtk+kMg0wLCQXW/2/tfZJaYH13Z3Ny/NY+o/tE3lOHdj9mEXGAhv57TgpRo7
         bwBLsWKH9hgaQ==
Date:   Tue, 5 Dec 2023 09:56:57 +0200
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
Message-ID: <20231205075657.GN5169@atomide.com>
References: <20231204182245.33683-1-afd@ti.com>
 <20231204182245.33683-2-afd@ti.com>
 <b97f04f6-cda2-4e9b-b729-a5149e36f978@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b97f04f6-cda2-4e9b-b729-a5149e36f978@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> [231205 07:10]:
> On 04/12/2023 19:22, Andrew Davis wrote:
> > @@ -56,6 +76,43 @@ allOf:
> >        properties:
> >          clocks:
> >            maxItems: 1
> > +      required:
> > +        - clocks
> > +        - clock-names
> 
> You need to define the clocks for your variants or disallow them. The
> original code should be fixed as well and make the clocks fixed for all
> img-axe cases.

To clarify, the clocks may be optional as they can be hardwired and coming
from the interconnect target wrapper module and enabled with runtime PM.

Regards,

Tony
