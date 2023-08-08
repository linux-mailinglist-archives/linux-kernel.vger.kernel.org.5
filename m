Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9899B7749ED
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjHHUG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjHHUGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:06:17 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3CFFE5D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 11:26:34 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-48735dd1b98so1255698e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 11:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691519193; x=1692123993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbSuxAH1dmgDI1cFhSw3+FjHgNgeooTpwVKeZW63XUA=;
        b=omX3M6W7HI4CkdKEejiKetClW4YUWnvCPUq8gKc/AoVUAnqTLGguQDDx/Sp7R778JN
         J9TSo32CN6hMaWQKcsB0qNqnAfUmpGbESPtgNucK5ozybmP7dGop+fVUtC7USzhv0x20
         JypPvqhLY7OCKJtBcfnX+96fYG5NsovjpKeVeQyTpMIw8hCNkqz97Nj5+31R97GKArfx
         FvTCBQ21Dt/3FRicqjABaU4W4VS+jqKz5MgCjjWoW7/8fz5NgBnX8wQtxRvChUJ90vs8
         M6mrEFvM5V+hgB099+64rLexf3D68SYLB6togDUSjQ9USqOosVkxu49B4wTl+yHLi33a
         3Kiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691519193; x=1692123993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbSuxAH1dmgDI1cFhSw3+FjHgNgeooTpwVKeZW63XUA=;
        b=MrqLDkPEtk0SoL9fk3MEo6KWngo99Ac5bGP2q40vfjqo8IWv5baEQHqAiNkF1a6A5f
         2Whn/TsDceMNUbr9qAh2cdkjrwsdLdyCmyiXpmfL7ra4H88eL1uZnjy4GVzFHnChNpBd
         tjzz1bpZwOwsEOrtwHEW6cSmEszvSHP/GWhTALto6aKNTuEelNsPVXvUJU0qiAoC6JhR
         m7y+9kJYvUJbaDHAplCwC5Xm2Jv3jjL8Oq8PKnvcB19qt9xMfliLpHKohIZ3kSxornoP
         DO8OYjqGtR3OOL+eCmU/yBSUvp4R7yeKa5C5N8ACN7s9iEh7DeiwMOZtdPiGwCPJSlLv
         QvvQ==
X-Gm-Message-State: AOJu0YwKsE1VRzDBkfvKs8N4ks2q1S4wCB+VAQJl0SLHmRJTrybo4aKD
        1haBtclhxdXZnf+Nb9wkmXXt8FOx6Meu+A866UYFNQ==
X-Google-Smtp-Source: AGHT+IG8ilz+lyyZPz/QTN9yYwu4PQ8UFXiUmVfIAYHkY7cO5/Ehx+F7e2EvG0Tpci9f03MzRW/uy/lDk0h8r21yu9I=
X-Received: by 2002:a67:f905:0:b0:443:677e:246e with SMTP id
 t5-20020a67f905000000b00443677e246emr716156vsq.5.1691519193393; Tue, 08 Aug
 2023 11:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230807193102.6374-1-brgl@bgdev.pl> <54421791-75fa-4ed3-8432-e21184556cde@lunn.ch>
 <CAMRc=Mc6COaxM6GExHF2M+=v2TBpz87RciAv=9kHr41HkjQhCg@mail.gmail.com>
 <ZNJChfKPkAuhzDCO@shell.armlinux.org.uk> <CAMRc=MczKgBFvuEanKu=mERYX-6qf7oUO2S4B53sPc+hrkYqxg@mail.gmail.com>
 <65b53003-23cf-40fa-b9d7-f0dbb45a4cb2@lunn.ch> <CAMRc=MecYHi=rPaT44kuX_XMog=uwB9imVZknSjnmTBW+fb5WQ@mail.gmail.com>
 <xfme5pgj4eqlgao3vmyg6vazaqk6qz2wq6kitgujtorouogjty@cklyof3xz2zm> <d021b8ae-a6a3-4697-a683-c9bd45e6c74b@lunn.ch>
In-Reply-To: <d021b8ae-a6a3-4697-a683-c9bd45e6c74b@lunn.ch>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 8 Aug 2023 20:26:22 +0200
Message-ID: <CAMRc=MegMdB0LZNRRrCfqFGZQWMFdBhd8o+_NBxwLk0xS99M_w@mail.gmail.com>
Subject: Re: [PATCH 0/2] net: stmmac: allow sharing MDIO lines
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Andrew Halaney <ahalaney@redhat.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 5:15=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > I'll make the water muddier (hopefully clearer?). I have access to the
> > board schematic (not SIP/SOM stuff though), but that should help here.
> >
> > MAC0 owns its own MDIO bus (we'll call it MDIO0). It is pinmuxed to
> > gpio8/gpio9 for mdc/mdio. MAC1 owns its own bus (MDIO1) which is
> > pinmuxed to gpio21/22.
> >
> > On MDIO0 there are two SGMII ethernet phys. One is connected to MAC0,
> > one is connected to MAC1.
> >
> > MDIO1 is not connected to anything on the board. So there is only one
> > MDIO master, MAC0 on MDIO0, and it manages the ethernet phy for both
> > MAC0/MAC1.
> >
> > Does that make sense? I don't think from a hardware design standpoint
> > this is violating anything, it isn't a multimaster setup on MDIO.
>
> Thanks for taking a detailed look at the schematics. This is how i
> would expect it to be.
>
> > > > > Good point, but it's worse than that: when MAC0 is unbound, it wi=
ll
> > > > > unregister the MDIO bus and destroy all PHY devices. These are no=
t
> > > > > refcounted so they will literally go from under MAC1. Not sure ho=
w
> > > > > this can be dealt with?
> > > >
> > > > unbinding is not a normal operation. So i would just live with it, =
and
> > > > if root decides to shoot herself in the foot, that is her choice.
> > > >
> > >
> > > I disagree. Unbinding is very much a normal operation.
>
> What do you use it for?
>
> I don't think i've ever manually done it. Maybe as part of a script to
> unbind the FTDI driver from an FTDI device in order to use user space
> tools to program the EEPROM? But that is about it.
>
> I actually expect many unbind operations are broken because it is very
> rarely used.
>

When I say "device unbind", I don't just mean manual unbinding using
sysfs. I mean any code path (rmmod, unplugging the USB, etc.) that
leads to the device being detached from its driver. This is a
perfectly normal situation and should work correctly.

I won't be fixing it for this series but may end up looking into
establishing some kind of device links between MACs and their "remote"
PHYs that would allow to safely unbind them.

Bart
