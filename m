Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B937750FB4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjGLReU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbjGLReT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:34:19 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F991980
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:34:17 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fb41682472so10913387e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1689183255; x=1691775255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THupXVrcQgstmKZ7g3sWCpKEqGRDMCR0S1cuPxvrmm0=;
        b=CEkTls9NpLa7QXntC+qxjwisHZSsRQgQwgxURUxzFeBcv9LvOyTjJworuQN7WatsWZ
         2K8NdX0u0LbxZ2lR1yUo79lVYV7Up0UpO2i2X/Rw8KhfiAEoAlYYFuDPvs0u48lBYlby
         Hr1UZ63ywo5FibwhwcS7qoubUmXWRJA5tgVIa0eFHOuV/v7sNq3UfNSWZ7LHxLcnsYO7
         4av0aEY16DDYWnZRJoM4szLJmn5o+qjXQ6Ny2xJEot+VxVVdx7Lp4Q3D7xvuoXEsOoCE
         +AVENbJNR+oens7/f65Ii+msEkHaRKqN92l7wvCOx7qSEv3ZeIceedllAlVUezPkND2D
         psnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689183255; x=1691775255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THupXVrcQgstmKZ7g3sWCpKEqGRDMCR0S1cuPxvrmm0=;
        b=aC1XwkF8dt4owmi1+VUUUSWiD9mhSXJmrLW1z61+vmosfL+/1Y132z6sbS41tj2rwa
         ofhK2qlZBkFZmS0NwCxlBZMMcsv0qRZDOJh0H888u9Yaj+LiG10iJ4055HWxPiLxzIPR
         4xbs0AgFB6kSNUDxu3A7fcntfM47Pe9+pndNUwBpwH0lcuFAU5hjjBBM4sfGsE7/e1WV
         quqCHtiJZQrriTjrpaZCX0X7GP29UmBsbRsX0+7NswobCPD/4ZiQlnAcD2Riur00YTp2
         7Hlk8mavnY2pEt8To8se4Gvx3PV/lfCfcr5s5MJWmgfxr8X3ZsPfLUJHQPdg+JhlH5rL
         5wkA==
X-Gm-Message-State: ABy/qLYOzZ/t3O6+tcvX8u2bFgLhA0PYWgGy733g8c02tfHeryKMSU2C
        JbntNjEHLhRxKm8YNYZ2DaFPVh0Y8bgsQJsVF2e/Qw==
X-Google-Smtp-Source: APBJJlHvVk6KQIaeMx+Y8djfpAYOUtMArgWEG07w/d6ONkJCrU9E2j1ZpgldQFTViBw1jnRhyDheAmQQeSboRoBB5SI=
X-Received: by 2002:a05:6512:3287:b0:4fb:89f2:278e with SMTP id
 p7-20020a056512328700b004fb89f2278emr17145159lfe.68.1689183255338; Wed, 12
 Jul 2023 10:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230706081554.1616839-1-alex@shruggie.ro> <20230706081554.1616839-2-alex@shruggie.ro>
 <9c37e2d5-a430-4a0f-b6b9-5de0dc14033f@lunn.ch>
In-Reply-To: <9c37e2d5-a430-4a0f-b6b9-5de0dc14033f@lunn.ch>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Wed, 12 Jul 2023 20:34:03 +0300
Message-ID: <CAH3L5Qp_887Jg4QN8qo1QQWJGhyLmvafKKTBRF-Yu3nkLE0G+g@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: net: phy: vsc8531: document
 'vsc8531,clkout-freq-mhz' property
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
        olteanv@gmail.com, marius.muresan@mxt.ro
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 8, 2023 at 9:25=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Jul 06, 2023 at 11:15:54AM +0300, Alexandru Ardelean wrote:
> > For VSC8351 and similar PHYs, a new property was added to generate a cl=
ock
> > signal on the CLKOUT pin.
> > This change documents the change in the device-tree bindings doc.
> >
> > Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
> > ---
> >  Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt=
 b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> > index 0a3647fe331b..133bdd644618 100644
> > --- a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> > +++ b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> > @@ -31,6 +31,10 @@ Optional properties:
> >                         VSC8531_LINK_100_ACTIVITY (2),
> >                         VSC8531_LINK_ACTIVITY (0) and
> >                         VSC8531_DUPLEX_COLLISION (8).
> > +- vsc8531,clkout-freq-mhz : For VSC8531 and similar PHYs, this will ou=
tput
> > +                       a clock signal on the CLKOUT pin of the chip.
> > +                       The supported values are 25, 50 & 125 Mhz.
> > +                       Default value is no clock signal on the CLKOUT =
pin.
>
> It is possible this could cause regressions. The bootloader could
> turned the clock on, and then Linux leaves it alone. Now, it will get
> turned off unless a DT property is added.
>
> I prefer to explicitly have the property, so there is no dependency on
> the bootloader, so lets leave it like this. But if we do get
> regressions reported, this might need to change.

Well, we could also need add a "mscc,clkout-freq-mhz =3D <0>" handling
where the CLKOUT pin gets disabled explicitly (if needed, after the
bootloade), for some weird corner cases.
Though, to-be-honest, I can't think of any (remotely) reasonable ones.

It would definitely be simple to just make sure that Linux does not do
any changes if this property isn't present.

If you're on board about having this as-is, I will keep it; and spin a
V2 just with 'vsc8531,clkout-freq-mhz ' -> 'mscc,clkout-freq-mhz' as
Rob requested.

Thanks
Alex

>
>    Andrew
