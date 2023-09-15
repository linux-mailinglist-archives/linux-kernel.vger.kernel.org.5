Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA9F7A2084
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbjIOOK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjIOOK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:10:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92891FD0;
        Fri, 15 Sep 2023 07:10:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5A2C433C9;
        Fri, 15 Sep 2023 14:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694787052;
        bh=JgqigKeKn865Q196uxCOO5B3UhLulNuRopfW1IGHX/I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dLYRMZFmecxZO7OCH+M02gl2UwkGgwxH/vnzPqMEnfwsaaQ8b5jOaJYagcJN1+k4e
         HsLb+qOAUwJ6cfRrk3x/LxIp8rte28kYpVMf/b9o7m/P0sc5zeUXQQbpKEEAobd/ME
         WHwfozfy8fu19U9TuZu4gt9mu0e85aA4mC/W+wnkpfBghMxvUPZcAN7SUo+N9cAseR
         UYynEHFMaOFDURVS10OZvymGRdHFIMOKGiiEQj5gwcuQfNHRrRtLQ5OksU4HCrqaLq
         gyPpeFvMBk64m7DzxOvPt7wBpAi4JrSBpsx4lfGBdBRybE8a4wViV1c3PvWRRs32sv
         b7N8Fp61mxpwQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-502b0d23f28so3641819e87.2;
        Fri, 15 Sep 2023 07:10:52 -0700 (PDT)
X-Gm-Message-State: AOJu0YxGd2MmlxU0KO24cl7JGaK+XGayNqfjqOZM87kb3AG395QHvKC7
        9+js9+C5dESDtVPwjTfemcjMR+nI1kc6lw5qFQ==
X-Google-Smtp-Source: AGHT+IGfSXqgnoVODLmCStH2PZnoG0f0eybJBmzuJK6LXRRY+/qapC/6pZa6jdWzQ/BL56sxjUupvvrB18R1ANxMHZs=
X-Received: by 2002:a19:4f08:0:b0:500:979e:8d8b with SMTP id
 d8-20020a194f08000000b00500979e8d8bmr1590402lfb.34.1694787050499; Fri, 15 Sep
 2023 07:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230912-gpio-led-trigger-dt-v1-0-1b50e3756dda@linaro.org>
 <20230912-gpio-led-trigger-dt-v1-1-1b50e3756dda@linaro.org>
 <20230913133451.GA2841610-robh@kernel.org> <CACRpkdb72f9WFeEGo-tXscZaBmFH04WiePM+tJSmuuXQxxy=3A@mail.gmail.com>
 <CAL_Jsq+PizSdqJ5Yc4TpNscy5e3gBP4vjQF+ka6SRwnJhSt-0w@mail.gmail.com> <CACRpkdZeCjRrQ1iKQhYzhWgQOXH8nQ=TN5AsdoQm2jr7wtdPQQ@mail.gmail.com>
In-Reply-To: <CACRpkdZeCjRrQ1iKQhYzhWgQOXH8nQ=TN5AsdoQm2jr7wtdPQQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 15 Sep 2023 09:10:38 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLMxsQBfOXXAOqvruPL9UTqLf-1xvTPV1QWdWigs8i9Ug@mail.gmail.com>
Message-ID: <CAL_JsqLMxsQBfOXXAOqvruPL9UTqLf-1xvTPV1QWdWigs8i9Ug@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: leds: Mention GPIO triggers
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     =?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat@cesnet.cz>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 7:01=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Thu, Sep 14, 2023 at 4:27=E2=80=AFPM Rob Herring <robh@kernel.org> wro=
te:
> > On Thu, Sep 14, 2023 at 3:40=E2=80=AFAM Linus Walleij <linus.walleij@li=
naro.org> wrote:
> > > On Wed, Sep 13, 2023 at 3:34=E2=80=AFPM Rob Herring <robh@kernel.org>=
 wrote:
> > > > On Tue, Sep 12, 2023 at 03:44:30PM +0200, Linus Walleij wrote:
> > > > > We reuse the trigger-sources phandle to just point to
> > > > > GPIOs we may want to use as LED triggers.
> > > > >
> > > > > Example:
> > > > >
> > > > > gpio: gpio@0 {
> > > > >     compatible "my-gpio";
> > > > >     gpio-controller;
> > > > >     #gpio-cells =3D <2>;
> > > > >     interrupt-controller;
> > > > >     #interrupt-cells =3D <2>;
> > > > >     #trigger-source-cells =3D <2>;
> > > >
> > > > BTW, this is not documented for any GPIO binding. If we want to spe=
cify
> > > > the cell size, then it has to be added to every GPIO controller bin=
ding.
> > > > If not, we then need to reference gpio.yaml in every GPIO controlle=
r
> > > > binding (along with unevaluatedProperties). Doesn't have to be done=
 for
> > > > this patch to go in though.
> > >
> > > Yeah I mean this trigger-sources =3D <...>; one-size-fits-all is a bi=
t
> > > weird in a way.
> > >
> > > My other idea was to simply add trigger-gpios to the normal way
> > > and be done with it, but now the trigger binding has this weird
> > > thing.
> > >
> > > Would trigger-gpios be better?
> >
> > Then GPIOs are different than everyone else. I think we have to think
> > about other bindings too. While we could standardize the naming here
> > with trigger-gpios, that won't work with the foos/foo-names style of
> > bindings.
> >
> > trigger-sources is not widely used as it is just USB ATM and a few
> > platforms. We could come up with something different.
> > "trigger-sources-<cellname>" is the only idea I have. Then the
> > property name gives you the cell name to read. But variable property
> > names have their own challenges. We would need to look at all the
> > current trigger sources (i.e. the linux,default-trigger ones) and see
> > what else might need this.
>
> I think it in a way is elegant with the trigger-sources phandle as it
> is so I would stick with this.
>
> I can just add '#trigger-source-cells' to the existing GPIO
> bindings and it's a bit tedious since we don't have a common file
> for the GPIO chip stuff, but it's just lots of lines.

We do, gpio.yaml in dtschema. We just didn't reference it in all
controllers because at the time unevaluatedProperties didn't
exist/work and you still have to list most properties to define their
constraints. In general, we reference the common schema for ones with
child nodes, but not ones which are just #foo-cells and other
properties. For GPIO, it's evolved to the point that referencing the
common schema makes sense mainly because we have the hog nodes now.

I said before we still need '#trigger-source-cells' in each schema,
but really I suppose if we just set it to 1 or 2 cells in the common
schema, that would be good enough. It's so rarely used. I expect
(because there's discussions on it) someday jsonschema will support
data dependent schemas (i.e. if the value of prop is X, then apply
schema). Actually, we can do that already with if/then schemas, but it
would be kind of verbose.

> I guess it would be better to break out gpio-common.yaml and
> gpio-common-irq.yaml for GPIO controllers with or without
> interrupt support and then add '#trigger-source-cells' to just
> those supporting IRQs because I think only that makes sense,
> polling for a line to change isn't quite a "trigger".

No need to split them just for that:

dependencies:
  '#trigger-source-cells': interrupt-controller

Though maybe a split makes sense anyways.

Rob
