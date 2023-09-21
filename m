Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D4B7A9FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjIUU0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjIUU0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:26:07 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7879900C5;
        Thu, 21 Sep 2023 10:46:13 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-405361bb9cdso8134805e9.0;
        Thu, 21 Sep 2023 10:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695318372; x=1695923172; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s0MtmUBoFFRZ1KaXa+vO728c+OI89EgadZUVnpzkFf4=;
        b=X+BepzHeCjzhs4L1DMOfAQowXf7P16VfBhNkIMv5oBZmVN6hluILGhsH24wymo/bI/
         Tw2VcoP9DzWSqccJPAGDUAJSD0Bb4O6gfoKAm5+UOQiwS+3T31RQNnx6B+GpTSlOSKN4
         sbDwpOvindodMv3vmv/b89A7MlTVD0ZHJX64iH0w93nF/9g9PExlyy/KKpz/orFej/TP
         C4CLmb+Xe8PvgbK8rKLlY/y13Gdo0mL0+PB7A3G3VFtdnOHW6r9KXDWMYslchm+xzeo1
         1C50/PA3Rz1u0OOzEID5Ux6rLSx9+hIetETka1agqIrBvqu30XodBCBE2qZb/5XWSoXf
         b4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318372; x=1695923172;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0MtmUBoFFRZ1KaXa+vO728c+OI89EgadZUVnpzkFf4=;
        b=UUkSJGJap7Jzxp1YZDBdgURrCZa367a3CY7JcWH7AOfQ4TRL4/t9bx0yq4GJ2Ymp8L
         kbJukLJVmjvhtLpadlMga0Mw8EMmcdTK3tZzIww9cYAsmTI9cpdZj1k3HmkQBVqkjOX1
         iQ7WR+dWmrR3PjCWjJlev9FDESpPDWJaRXh9WF8GSi5+01GRSqGU0OhDbVxkqLzZ2uXk
         c4fMWoVn/3zgd50s27IHoiatGV//YbeC496G1uFbA2yqc1YHjI7gTXES+6pOqSO2PMqT
         7vedwjYyGlLIct14hAjy10a1DRLVYtLpz7M+mGf+ncb3IZVKO6HGwvf3ttwa92CoPsMo
         6ezA==
X-Gm-Message-State: AOJu0YzmUYSJb22WQf8uTP9+aB3vgy2Ds7/EuIMID9J5iaI8mCkmHs+L
        RTwH/spsftMTnIGKa94CkBPs+A0vrIhkU5ZNrNtZMWBZFV4=
X-Google-Smtp-Source: AGHT+IHYE8uHuhQAgOlNj2srv9Tl2K8NyVVKPejvFT4qvqp4BRCyx0VcWD+BRKbx2vEX0j1DXh6BQNj1kGISfZexFHU=
X-Received: by 2002:a2e:b713:0:b0:2b9:aa4d:3728 with SMTP id
 j19-20020a2eb713000000b002b9aa4d3728mr4606064ljo.29.1695302280319; Thu, 21
 Sep 2023 06:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230918165958.2659-1-tmaimon77@gmail.com> <20230918165958.2659-2-tmaimon77@gmail.com>
 <b7a337f2-a810-d14c-e7cd-15e33a9ecb5d@linaro.org> <CAP6Zq1gSJYsNUuD-bexFW_1VpAUuF_WZkicNzZms6hVdo9LnMQ@mail.gmail.com>
 <e0d42d13-b307-9915-97c8-948261b39ce1@linaro.org> <CAP6Zq1g0=-h0PFg2a8bqao+XjdNHoxGMdYSRRPAnfY_6WdemAw@mail.gmail.com>
 <20230919162837.GA4051010-robh@kernel.org> <CAP6Zq1hJPPAtKw8auC22wViHGQHTi0SufPJoBiqYtGWomnNUYQ@mail.gmail.com>
In-Reply-To: <CAP6Zq1hJPPAtKw8auC22wViHGQHTi0SufPJoBiqYtGWomnNUYQ@mail.gmail.com>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Thu, 21 Sep 2023 16:17:48 +0300
Message-ID: <CAP6Zq1iUj8UfLZutyOVxbKgF42rMoF9ig3dViy7ApTHcqVoP7g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-binding: usb: ci-hdrc-usb2: document Nuvoton
 NPCM supprt
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        peter.chen@kernel.org, gregkh@linuxfoundation.org,
        krzysztof.kozlowski+dt@linaro.org, xu.yang_2@nxp.com,
        peng.fan@nxp.com, avifishman70@gmail.com, tali.perry1@gmail.com,
        joel@jms.id.au, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, j.neuschaefer@gmx.net,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Again thanks for your suggestion I took a look at the
drivers/usb/roles and I am not sure it answers NPCM ChipIdae case.
For example, in the NPCM845 we have ten UDC ChipIdea modules (UDC0-9).
Only UDC8 and UDC9 are muxed with USB host0 and USB host1.
NPCM UDC and NPCM USB host are different HW modules therefore different drivers.

The ChipIdea driver uses its own internal USB role function to switch
between ChipIdea UDC and ChipIdea USB host and we can't replace it
with a unique NPCM USB role function also we need to set the mux only
at the probe stage.

This is why I have added nuvoton,sysgcr property to the NPCM ChipIdea driver.

With the above do you think I should do it differently?

On Wed, 20 Sept 2023 at 12:11, Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Thanks Rob,
>
> I will check drivers/usb/roles
>
> On Tue, 19 Sept 2023 at 19:28, Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Sep 19, 2023 at 04:31:56PM +0300, Tomer Maimon wrote:
> > > On Tue, 19 Sept 2023 at 15:39, Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> wrote:
> > > >
> > > > On 19/09/2023 07:14, Tomer Maimon wrote:
> > > > >>>            - nvidia,tegra20-ehci
> > > > >>>            - nvidia,tegra20-udc
> > > > >>>            - nvidia,tegra30-ehci
> > > > >>> @@ -325,6 +326,20 @@ properties:
> > > > >>>      type: boolean
> > > > >>>      deprecated: true
> > > > >>>
> > > > >>> +  nuvoton,sysgcr:
> > > > >>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > > >>> +    items:
> > > > >>> +      - items:
> > > > >>> +          - description: phandle to syscon that configures usb phy mux.
> > > > >>> +          - description: offset of usb phy mux selection.
> > > > >>> +          - description: mask usb phy mux selection.
> > > > >>> +          - description: value usb phy mux selection.
> > > > >>> +    description:
> > > > >>> +      A phandle to syscon with three arguments that configure usb phy mux.
> > > > >>> +      The argument one is the offset of usb phy mux selection, the argument two
> > > > >>> +      is the mask usb phy mux selection, the argument three is the mask usb phy
> > > > >>> +      mux selection.
> > > > >>
> > > > >> Sorry, you miss phy driver. Don't use syscon instead of proper hardware
> > > > >> devices.
> > > > > Sorry the role of nuvoton,sysgcr property is to handle a mux between
> > > > > the different devices and not the handle the phy itself, handle the
> > > > > mux done in the GCR.
> > > > > Should we move the nuvoton,sysgcr description to another place in the
> > > > > ci-hdrc-usb2.yaml
> > > > > or
> > > > > Should we use a different driver to handle the mux and call it from
> > > > > the ci-hdrc-npcm driver, If yes which driver should we use?
> > > >
> > > > What is an "usb phy mux"?
> > > We have USB phy that could be connected to USB host (different driver)
> > > or it can be connected to the UDC driver(ChipIdea)
> >
> > Isn't that just role switching? There is a driver framework for that in
> > drivers/usb/roles/. Though it doesn't seem widely used yet.
> >
> > Rob

Best regards,

Tomer
