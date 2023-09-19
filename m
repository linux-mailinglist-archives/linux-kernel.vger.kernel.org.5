Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D397A68DD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 18:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjISQ2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 12:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjISQ2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:28:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53402BE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 09:28:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBAFC433C8;
        Tue, 19 Sep 2023 16:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695140926;
        bh=Gs2VeKYvanEmhRbfroqQm1XNSDENhOjKx9E77X+qzDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WImvJ0PNoZteN42w7al/gnnH+lwAzvx7thtk8cjvknG2YkrhW/o+QsmNUwQER6jrS
         8DlDdEMHAA7qTT3YAMwRH6UU96mUJBfl5CDSI+k8dgNNiBqAcqx7aOOSHLiq1iXCfq
         /pWeAq4E2YoLuxbB5c7bVdaIWj/hYqy7jRwC5/1rtgdIxnJFcRi/azKy5vfkbGRAEO
         vXlV24Sf4DcR7UoJH0/TysoI69PK9k+u7pdgH1OYtI4juxuEBjTlRU7JzfRnfNpsYC
         MnM6VYFzy0BGBSZ36Tz/EI54ujxh/LQUitvrn3MI/rzsvsxkyX1vva9i9uaf0OhA/f
         R0wBWR4b07glA==
Received: (nullmailer pid 4059576 invoked by uid 1000);
        Tue, 19 Sep 2023 16:28:37 -0000
Date:   Tue, 19 Sep 2023 11:28:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        peter.chen@kernel.org, gregkh@linuxfoundation.org,
        krzysztof.kozlowski+dt@linaro.org, xu.yang_2@nxp.com,
        peng.fan@nxp.com, avifishman70@gmail.com, tali.perry1@gmail.com,
        joel@jms.id.au, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, j.neuschaefer@gmx.net,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-binding: usb: ci-hdrc-usb2: document Nuvoton
 NPCM supprt
Message-ID: <20230919162837.GA4051010-robh@kernel.org>
References: <20230918165958.2659-1-tmaimon77@gmail.com>
 <20230918165958.2659-2-tmaimon77@gmail.com>
 <b7a337f2-a810-d14c-e7cd-15e33a9ecb5d@linaro.org>
 <CAP6Zq1gSJYsNUuD-bexFW_1VpAUuF_WZkicNzZms6hVdo9LnMQ@mail.gmail.com>
 <e0d42d13-b307-9915-97c8-948261b39ce1@linaro.org>
 <CAP6Zq1g0=-h0PFg2a8bqao+XjdNHoxGMdYSRRPAnfY_6WdemAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP6Zq1g0=-h0PFg2a8bqao+XjdNHoxGMdYSRRPAnfY_6WdemAw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 04:31:56PM +0300, Tomer Maimon wrote:
> On Tue, 19 Sept 2023 at 15:39, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 19/09/2023 07:14, Tomer Maimon wrote:
> > >>>            - nvidia,tegra20-ehci
> > >>>            - nvidia,tegra20-udc
> > >>>            - nvidia,tegra30-ehci
> > >>> @@ -325,6 +326,20 @@ properties:
> > >>>      type: boolean
> > >>>      deprecated: true
> > >>>
> > >>> +  nuvoton,sysgcr:
> > >>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > >>> +    items:
> > >>> +      - items:
> > >>> +          - description: phandle to syscon that configures usb phy mux.
> > >>> +          - description: offset of usb phy mux selection.
> > >>> +          - description: mask usb phy mux selection.
> > >>> +          - description: value usb phy mux selection.
> > >>> +    description:
> > >>> +      A phandle to syscon with three arguments that configure usb phy mux.
> > >>> +      The argument one is the offset of usb phy mux selection, the argument two
> > >>> +      is the mask usb phy mux selection, the argument three is the mask usb phy
> > >>> +      mux selection.
> > >>
> > >> Sorry, you miss phy driver. Don't use syscon instead of proper hardware
> > >> devices.
> > > Sorry the role of nuvoton,sysgcr property is to handle a mux between
> > > the different devices and not the handle the phy itself, handle the
> > > mux done in the GCR.
> > > Should we move the nuvoton,sysgcr description to another place in the
> > > ci-hdrc-usb2.yaml
> > > or
> > > Should we use a different driver to handle the mux and call it from
> > > the ci-hdrc-npcm driver, If yes which driver should we use?
> >
> > What is an "usb phy mux"?
> We have USB phy that could be connected to USB host (different driver)
> or it can be connected to the UDC driver(ChipIdea)

Isn't that just role switching? There is a driver framework for that in 
drivers/usb/roles/. Though it doesn't seem widely used yet.

Rob
