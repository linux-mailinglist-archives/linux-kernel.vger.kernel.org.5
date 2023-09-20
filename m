Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4501A7A76EF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbjITJMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbjITJMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:12:14 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CC11AA;
        Wed, 20 Sep 2023 02:11:56 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bffc55af02so54650011fa.2;
        Wed, 20 Sep 2023 02:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695201114; x=1695805914; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p1x4ulOTEjSOQ+Fhe0wwtsVsIHWMLD1pUZs5tuTFtbg=;
        b=mGJ1giGJV4Jh7vsCvgHWeReRdciXSRc5v9zT3ROSY03Z3SfWat+3f+pmesxXk0JIXi
         7j4tu39VsFsZytYq0jhrnZF80zPiPFUfi2GQhedCQlp1jcZ0jN917b4G4PczpB8FQzro
         nefpqh/tADvyOOYqgB+TbGCyitVWEHctNTpYkUPm0fWo7Prn6RzT4Yi8YYPlJk2ne6JL
         xv+yirbCe/3m7ubTiV5GoTk4b5YmWYqgnsal/VgxNkwnkSmMiUwlYQemXQs76k05QLTs
         asoH5+Nol8TQw2XqumyuPmVl3mjQCyaWrsCtkC0xQEYP/I41Yd0uSzQOgY7x9yssvviM
         cVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695201114; x=1695805914;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p1x4ulOTEjSOQ+Fhe0wwtsVsIHWMLD1pUZs5tuTFtbg=;
        b=IQsLsCI6Bc2siSC3va5TQUb/oF7AiNBMS7tXf+ajQDlwtSntoOhEgVjaj2ASdu1HIE
         Q2z8JfE0KZVYMeXC6Vb7ZwAiSMWR82dYsAxaC7e3FdO00rwK2pqc1GuJAz22fPvgBQZM
         S+7yybl7crfnYnjNgCkKd1QIZJjv10uirn5aJENdJ+Yrf6gE9sTzUSkCU83moaIQnqCK
         zMD9vjFBQfPj6BDbIFNpVl6qufcAdfrAraE9zW19UmRx+IVT4BErY3/Di8uweaOKO0Lo
         frmqXY2Dv4rYDPFkzwm5nnZ13teNMLh/TvoGngeOzHceWwcYsCowqvyibD1J0QWvaZOc
         g6pA==
X-Gm-Message-State: AOJu0YzSNrtZReQHFoUrGPHy5JEBUfXFKLjBaomkFWPGFbI//lPWNlx8
        9sb4EuDqOMC+MokgEj3G2OxZ7sMVng2VMHuVKCA=
X-Google-Smtp-Source: AGHT+IFlh2NMaNjIOP8F/dYh1vzEh1bzqCv3IbyFy9N9OxrC9YilV6QuzTIVZeKPc31ouZElzHmBQXyCZ6wUhyRpZKo=
X-Received: by 2002:a2e:9b86:0:b0:2bf:fb49:6619 with SMTP id
 z6-20020a2e9b86000000b002bffb496619mr1513872lji.23.1695201114215; Wed, 20 Sep
 2023 02:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230918165958.2659-1-tmaimon77@gmail.com> <20230918165958.2659-2-tmaimon77@gmail.com>
 <b7a337f2-a810-d14c-e7cd-15e33a9ecb5d@linaro.org> <CAP6Zq1gSJYsNUuD-bexFW_1VpAUuF_WZkicNzZms6hVdo9LnMQ@mail.gmail.com>
 <e0d42d13-b307-9915-97c8-948261b39ce1@linaro.org> <CAP6Zq1g0=-h0PFg2a8bqao+XjdNHoxGMdYSRRPAnfY_6WdemAw@mail.gmail.com>
 <20230919162837.GA4051010-robh@kernel.org>
In-Reply-To: <20230919162837.GA4051010-robh@kernel.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Wed, 20 Sep 2023 12:11:42 +0300
Message-ID: <CAP6Zq1hJPPAtKw8auC22wViHGQHTi0SufPJoBiqYtGWomnNUYQ@mail.gmail.com>
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Rob,

I will check drivers/usb/roles

On Tue, 19 Sept 2023 at 19:28, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Sep 19, 2023 at 04:31:56PM +0300, Tomer Maimon wrote:
> > On Tue, 19 Sept 2023 at 15:39, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > >
> > > On 19/09/2023 07:14, Tomer Maimon wrote:
> > > >>>            - nvidia,tegra20-ehci
> > > >>>            - nvidia,tegra20-udc
> > > >>>            - nvidia,tegra30-ehci
> > > >>> @@ -325,6 +326,20 @@ properties:
> > > >>>      type: boolean
> > > >>>      deprecated: true
> > > >>>
> > > >>> +  nuvoton,sysgcr:
> > > >>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > >>> +    items:
> > > >>> +      - items:
> > > >>> +          - description: phandle to syscon that configures usb phy mux.
> > > >>> +          - description: offset of usb phy mux selection.
> > > >>> +          - description: mask usb phy mux selection.
> > > >>> +          - description: value usb phy mux selection.
> > > >>> +    description:
> > > >>> +      A phandle to syscon with three arguments that configure usb phy mux.
> > > >>> +      The argument one is the offset of usb phy mux selection, the argument two
> > > >>> +      is the mask usb phy mux selection, the argument three is the mask usb phy
> > > >>> +      mux selection.
> > > >>
> > > >> Sorry, you miss phy driver. Don't use syscon instead of proper hardware
> > > >> devices.
> > > > Sorry the role of nuvoton,sysgcr property is to handle a mux between
> > > > the different devices and not the handle the phy itself, handle the
> > > > mux done in the GCR.
> > > > Should we move the nuvoton,sysgcr description to another place in the
> > > > ci-hdrc-usb2.yaml
> > > > or
> > > > Should we use a different driver to handle the mux and call it from
> > > > the ci-hdrc-npcm driver, If yes which driver should we use?
> > >
> > > What is an "usb phy mux"?
> > We have USB phy that could be connected to USB host (different driver)
> > or it can be connected to the UDC driver(ChipIdea)
>
> Isn't that just role switching? There is a driver framework for that in
> drivers/usb/roles/. Though it doesn't seem widely used yet.
>
> Rob
