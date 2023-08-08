Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9934D774175
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbjHHRVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbjHHRUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:20:48 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB84783EA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:08:28 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5861116fd74so56188017b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691510880; x=1692115680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgs4Fm92pOwgiTtgi3t0TURwZ645hXw810Qm9YB3fW0=;
        b=1zWyWbnBevP6AnHvWYDpz4fJJdYAMoauIzciKtQnY6PlehU2/ShRLFy26ni3eWxPJL
         Sz0gYFhnaOWI6iN93LDJbs5W5ROTqKNFy8SnJG3U3ByIgIC/iAYvobjthTq1mVbzkZn5
         GWu79Tnot5+yMgONDB1oup8BhRJ2zsiqH4tw7AiAYJpUk+MZfO1X0GXF7CRMkKpw/GJh
         4JzJRwnF/DiFMv1tkbu9WVXSI8AxU196bKO5T7zipAFfDFy7DMtFbXU0PWZoSqaYGz8o
         rCJpENlhq7XYfgBiGiF7Ss2oeFo0gy1XNlFt02JFyD1/tbES/U7CcsVn0I0NCJ8XKO4o
         UeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510880; x=1692115680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vgs4Fm92pOwgiTtgi3t0TURwZ645hXw810Qm9YB3fW0=;
        b=PJqMCGPAFjiNwby6442y/d/AyP1cj6MxHL5Vlr02fSOmmczD/ZlkWTYCqaebmNpVB8
         nIOcp6+ETSoj8p+orYjrXgO9gn4R+PQpc8TZH+dBJvkDAHGIbFxuRaLBSAsnIHbxYZY9
         GEBSAe7zB9d4KAHwiVS7bBi8M77cPsQVmVL8r/saVnv/ohcBWx/eiprv0+wvc4uGm15D
         /DUMnnvYaPfY+WtjWGdPSvwgwdYW6AqXdNLTHPKOlMOU9VuEs0a3xfWgNkz8QfcXUWmB
         qJVlexN/fGFwbV+0eb8dThyaVLMdmrxQ9OpunAfZTMcqBttAYejGIQOcVByHHsDBJ0Ry
         MTBQ==
X-Gm-Message-State: AOJu0YxDNw2+UxROQRQmZqRnYYhPniB7Cs8SXoNz+hnZ32jcbnMGNwYE
        IIMaQr9/a4H4jrRJ1t37FI0FrKxSpEei48bb+FoHDCcuYMPZ8OMiwPQ=
X-Google-Smtp-Source: AGHT+IEUOZn+oWGOzEe6eb18PD1LJbJH+AEz15hO43+Evd9T1seVx+elc0H04Xz8tIq6S3q/dujX/7mkZrhXRTgW+JU=
X-Received: by 2002:a05:6358:c19:b0:139:e3a4:7095 with SMTP id
 f25-20020a0563580c1900b00139e3a47095mr14782675rwj.7.1691503762572; Tue, 08
 Aug 2023 07:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230807193102.6374-1-brgl@bgdev.pl> <54421791-75fa-4ed3-8432-e21184556cde@lunn.ch>
 <CAMRc=Mc6COaxM6GExHF2M+=v2TBpz87RciAv=9kHr41HkjQhCg@mail.gmail.com> <ZNJChfKPkAuhzDCO@shell.armlinux.org.uk>
In-Reply-To: <ZNJChfKPkAuhzDCO@shell.armlinux.org.uk>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 8 Aug 2023 16:09:11 +0200
Message-ID: <CAMRc=MczKgBFvuEanKu=mERYX-6qf7oUO2S4B53sPc+hrkYqxg@mail.gmail.com>
Subject: Re: [PATCH 0/2] net: stmmac: allow sharing MDIO lines
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 3:26=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Tue, Aug 08, 2023 at 10:13:09AM +0200, Bartosz Golaszewski wrote:
> > Ok so upon some further investigation, the actual culprit is in stmmac
> > platform code - it always tries to register an MDIO bus - independent
> > of whether there is an actual mdio child node - unless the MAC is
> > marked explicitly as having a fixed-link.
> >
> > When I fixed that, MAC1's probe is correctly deferred until MAC0 has
> > created the MDIO bus.
> >
> > Even so, isn't it useful to actually reference the shared MDIO bus in s=
ome way?
> >
> > If the schematics look something like this:
> >
> > --------           -------
> > | MAC0 |--MDIO-----| PHY |
> > -------- |     |   -------
> >          |     |
> > -------- |     |   -------
> > | MAC1 |--     ----| PHY |
> > --------           -------
> >
> > Then it would make sense to model it on the device tree?
>
> So I think what you're saying is that MAC0 and MAC1's have MDIO bus
> masters, and the hardware designer decided to tie both together to
> a single set of clock and data lines, which then go to two PHYs.

The schematics I have are not very clear on that, but now that you
mention this, it's most likely the case.

>
> In that case, I would strongly advise only registering one MDIO bus,
> and avoid registering the second one - thereby preventing any issues
> caused by both MDIO bus masters trying to talk at the same time.
>

I sent a patch for that earlier today.

> The PHYs should be populated in firmware on just one of the buses.
>
> You will also need to ensure that whatever registers the bus does
> make sure that the clocks necessary for communicating on the bus
> are under control of the MDIO bus code and not the ethernet MAC
> code. We've run into problems in the past where this has not been
> the case, and it means - taking your example above - that when MAC1
> wants to talk to its PHY, if MAC0 isn't alive it can't.

Good point, but it's worse than that: when MAC0 is unbound, it will
unregister the MDIO bus and destroy all PHY devices. These are not
refcounted so they will literally go from under MAC1. Not sure how
this can be dealt with?

>
> So just be aware of the clocking situation and make sure that your
> MDIO bus code is managing the clocks necessary for the MDIO bus
> master to work.

Doesn't seem like stmmac is ready for it as it is now so this is going
to be fun...

Bartosz

>
> In regard to sharing of the MDIO bus signals between two bus
> masters, I do not believe that is permissible - there's no
> collision detection in hardware like there is on I=E6=B6=8E. So
> having two MDIO bus masters talking at the same time would
> end up corrupting the MDC (clock) and MDIO (data) signals if
> both were active at the same time.
>
