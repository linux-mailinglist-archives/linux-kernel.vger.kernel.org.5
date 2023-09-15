Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F737A1DDE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbjIOMCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbjIOMCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:02:00 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375931FFE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:01:55 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3aca5c85a34so1224979b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694779314; x=1695384114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuzQxwfRLuYYkwxb5IQRfayhhE4ZirTH79+QLFntvNk=;
        b=CEfMEXmsbyIuGqvbygabO1En6V4IMycikaWkDvggkARLODvpenZvEei+kpmVgDZRvo
         gfWiz9WoC9844HvNOsmw50cosh2esFnCWLBNHIP62ag6DH0R3qaLTmB+xxQg79ThAPhz
         5WV9bw2ekwhlDl6MyDnKFEvnYSqpHbnvWizVJVDqQzVctUP6MiUcn70yzslw5qLkQVnJ
         Y4VuTGGBnAAVwVlInKQKG+cmuHA8uGRqeRTvpXvN4eoX9YmgdS9Pxa+iAatUdAyUxdek
         B4+IzR7dIrEQjYZ/tQnB4c3BPTNu3J1LxfdCMxDfpC9ECDKY8xHRYJIioP8XzRp1pr89
         Dalw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694779314; x=1695384114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuzQxwfRLuYYkwxb5IQRfayhhE4ZirTH79+QLFntvNk=;
        b=U+FDZhPoOdGMYo8YqsotxlQWJqIXZW3JgRNy9bm2VAnLElzWRTAHZGi+5OJ/kSRe+t
         6LVqWM6JkVVEe1WAJ4oDYvuKbvFYrsaoN14qiUWE8lCfEFNwsJ8bo16vOZYTJtlahqMM
         X5W3ireIsVyOlGEppTM8PjAPn4fpATprd0bRq+S5aJx9EaO4ctrBcCiS4VgLu7kp+ehx
         Al4y0mM8cJSfuYBtdRvPp/sG+QOOMMqxUwt242N1anNdy6fQkpPfmnGFCYHFaO7L2Bby
         MLBCQ7nSMYkZL01fD6juO3u3ql3JTqNg2/ZRhPUuDEQmRDvECGA5+mUwYznzftVQ9Z8/
         +ZPg==
X-Gm-Message-State: AOJu0Yxm8dZFgdKegBAaG9xwPqOMJaxepwfUglXvOZkpJuM6BE2BvGHq
        pXc1kEpGepzcbtNwkE1LWZmC1teNK1LJZ/PxbuvlbA==
X-Google-Smtp-Source: AGHT+IHXYWlChyP+R5UJVlYYmmHJCl+tnMgAPu0WP9s+/l6g32qgvo20rfSpiMfxlQu/zTy0jBjRr2rZGTClg3uns3M=
X-Received: by 2002:a05:6808:182:b0:3a3:6e43:e681 with SMTP id
 w2-20020a056808018200b003a36e43e681mr1497539oic.58.1694779314420; Fri, 15 Sep
 2023 05:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230912-gpio-led-trigger-dt-v1-0-1b50e3756dda@linaro.org>
 <20230912-gpio-led-trigger-dt-v1-1-1b50e3756dda@linaro.org>
 <20230913133451.GA2841610-robh@kernel.org> <CACRpkdb72f9WFeEGo-tXscZaBmFH04WiePM+tJSmuuXQxxy=3A@mail.gmail.com>
 <CAL_Jsq+PizSdqJ5Yc4TpNscy5e3gBP4vjQF+ka6SRwnJhSt-0w@mail.gmail.com>
In-Reply-To: <CAL_Jsq+PizSdqJ5Yc4TpNscy5e3gBP4vjQF+ka6SRwnJhSt-0w@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 15 Sep 2023 14:01:42 +0200
Message-ID: <CACRpkdZeCjRrQ1iKQhYzhWgQOXH8nQ=TN5AsdoQm2jr7wtdPQQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: leds: Mention GPIO triggers
To:     Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat@cesnet.cz>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 4:27=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
> On Thu, Sep 14, 2023 at 3:40=E2=80=AFAM Linus Walleij <linus.walleij@lina=
ro.org> wrote:
> > On Wed, Sep 13, 2023 at 3:34=E2=80=AFPM Rob Herring <robh@kernel.org> w=
rote:
> > > On Tue, Sep 12, 2023 at 03:44:30PM +0200, Linus Walleij wrote:
> > > > We reuse the trigger-sources phandle to just point to
> > > > GPIOs we may want to use as LED triggers.
> > > >
> > > > Example:
> > > >
> > > > gpio: gpio@0 {
> > > >     compatible "my-gpio";
> > > >     gpio-controller;
> > > >     #gpio-cells =3D <2>;
> > > >     interrupt-controller;
> > > >     #interrupt-cells =3D <2>;
> > > >     #trigger-source-cells =3D <2>;
> > >
> > > BTW, this is not documented for any GPIO binding. If we want to speci=
fy
> > > the cell size, then it has to be added to every GPIO controller bindi=
ng.
> > > If not, we then need to reference gpio.yaml in every GPIO controller
> > > binding (along with unevaluatedProperties). Doesn't have to be done f=
or
> > > this patch to go in though.
> >
> > Yeah I mean this trigger-sources =3D <...>; one-size-fits-all is a bit
> > weird in a way.
> >
> > My other idea was to simply add trigger-gpios to the normal way
> > and be done with it, but now the trigger binding has this weird
> > thing.
> >
> > Would trigger-gpios be better?
>
> Then GPIOs are different than everyone else. I think we have to think
> about other bindings too. While we could standardize the naming here
> with trigger-gpios, that won't work with the foos/foo-names style of
> bindings.
>
> trigger-sources is not widely used as it is just USB ATM and a few
> platforms. We could come up with something different.
> "trigger-sources-<cellname>" is the only idea I have. Then the
> property name gives you the cell name to read. But variable property
> names have their own challenges. We would need to look at all the
> current trigger sources (i.e. the linux,default-trigger ones) and see
> what else might need this.

I think it in a way is elegant with the trigger-sources phandle as it
is so I would stick with this.

I can just add '#trigger-source-cells' to the existing GPIO
bindings and it's a bit tedious since we don't have a common file
for the GPIO chip stuff, but it's just lots of lines.

I guess it would be better to break out gpio-common.yaml and
gpio-common-irq.yaml for GPIO controllers with or without
interrupt support and then add '#trigger-source-cells' to just
those supporting IRQs because I think only that makes sense,
polling for a line to change isn't quite a "trigger".

Yours,
Linus Walleij
