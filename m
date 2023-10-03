Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267F37B72AA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 22:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjJCUqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 16:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjJCUqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 16:46:01 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E1FAB;
        Tue,  3 Oct 2023 13:45:57 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-452863742f3so731853137.1;
        Tue, 03 Oct 2023 13:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696365957; x=1696970757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4JUA//MmEG4tfOe5BmsGEUrypRftrVNp99sibsB0mE=;
        b=kM0JnhD7U0cIpLpJbDWlcyWoXY8d3/2evEFB1su6fz9MVZZGHCPrA+CLdM8lSBxwKI
         pUFXqV/fmeOf/lBQu60iJWxdI8G3Q+gEpz4so23IVqMOGVY2ZCYFSbWKu0cuppUVBTOX
         aDI/D75WUGqVoCWtBVCkCOq0Y19QZEiTPx2SgA1j1umGSrLHE1dYAdRQwulUgRIj7X1h
         iJsDM8cDYojuPCn2lU1lwSEDqEE8jnVzjJknN26jV6h37W7YLu3/VGZiDqfbujdUK+Pg
         p8cjqjLcl3kIp3sviw9wagSH7yfVi8ORL0NOFZrNWtKssfUhRIbk9bNuhKC4/z0qYvl6
         c3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696365957; x=1696970757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4JUA//MmEG4tfOe5BmsGEUrypRftrVNp99sibsB0mE=;
        b=pF8olKgZy+R3wW/1YAs8Vks8K74qr5HPwBji8NoF4bQzA7PoAow/uRomj5qXNYFMep
         aaNnhHr303CeVs+Qujxq9trkWufhqMLbn8FUGU6Efd57P9cv2e+B3ZOTFMhNSSlZybSb
         gIKXr6KHGpfUrAiFmKQOO95gvvBBvXw+XQJhdO3A4vr163L5rLd4jIDQ7G0+ApcyhFop
         3aSoT22CYvaRnGVjinZ932ew2VqbWtjmKbSSghoYit/i0TUWIM/MJcJ9pNWTwHEnoAH9
         eArN+kaWXs3IBBiReuFAs9kvhY1WLIc1EDHgif0FmaWaIg7sgOku4A2hYy4lfiUSnhCm
         YqHw==
X-Gm-Message-State: AOJu0YzZylDSA3BxNulygc2IaZFJaY9zKRhUfhmWWpg2iou/Ch+8Poio
        dJJRyJXEaVqy/C5hOjCMSwzoK18p3HXJ0lXOM7Y=
X-Google-Smtp-Source: AGHT+IE1Hg6kxbaAnD2mOWBe2+9BPvUW66QqBJkk3o9xu75Lnp9EQwC/+6bK3nwa4mr0BawN2aSGw96VZ1ePvIc578E=
X-Received: by 2002:a67:f918:0:b0:452:8e07:db61 with SMTP id
 t24-20020a67f918000000b004528e07db61mr456504vsq.6.1696365956627; Tue, 03 Oct
 2023 13:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230912122201.3752918-1-paweldembicki@gmail.com>
 <20230912122201.3752918-3-paweldembicki@gmail.com> <ZQCWoIjvAJZ1Qyii@shell.armlinux.org.uk>
 <20230926230346.xgdsifdnka2iawiz@skbuf>
In-Reply-To: <20230926230346.xgdsifdnka2iawiz@skbuf>
From:   =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date:   Tue, 3 Oct 2023 22:45:45 +0200
Message-ID: <CAJN1KkwktmT_aV5s8+7i=6CW08R48V4Ru9D+QzwpiON+XF8N_g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/8] net: dsa: vsc73xx: convert to PHYLINK
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        netdev@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 27 wrz 2023 o 01:03 Vladimir Oltean <olteanv@gmail.com> napisa=C5=
=82(a):
>
> On Tue, Sep 12, 2023 at 05:49:36PM +0100, Russell King (Oracle) wrote:
> > On Tue, Sep 12, 2023 at 02:21:56PM +0200, Pawel Dembicki wrote:
> > > +static void vsc73xx_phylink_mac_link_up(struct dsa_switch *ds, int p=
ort,
> > > +                                   unsigned int mode,
> > > +                                   phy_interface_t interface,
> > > +                                   struct phy_device *phydev,
> > > +                                   int speed, int duplex,
> > > +                                   bool tx_pause, bool rx_pause)
> > > +{
> > > +   struct vsc73xx *vsc =3D ds->priv;
> > > +   u32 val;
> > > +
> > > +   if (speed =3D=3D SPEED_1000)
> > > +           val =3D VSC73XX_MAC_CFG_GIGA_MODE | VSC73XX_MAC_CFG_TX_IP=
G_1000M;
> > > +   else
> > > +           val =3D VSC73XX_MAC_CFG_TX_IPG_100_10M;
> > > +
> > > +   if (interface =3D=3D PHY_INTERFACE_MODE_RGMII)
> > > +           val |=3D VSC73XX_MAC_CFG_CLK_SEL_1000M;
> > > +   else
> > > +           val |=3D VSC73XX_MAC_CFG_CLK_SEL_EXT;
> >
> > I know the original code tested against PHY_INTERFACE_MODE_RGMII, but
> > is this correct, or should it be:
> >
> >       if (phy_interface_is_rgmii(interface))
> >
> > since the various RGMII* modes are used to determine the delay on the
> > PHY side.
> >
> > Even so, I don't think that is a matter for this patch, but a future
> > (or maybe a preceeding patch) to address.
> >
> > Other than that, I think it looks okay.
> >
> > Thanks.
> >
> > --
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
>
> I also agree with adding one more patch to this which converts to
> phy_interface_is_rgmii(). Pawe=C5=82: there was a recent discussion about
> the (ir)relevance of the specific rgmii phy-mode in fixed-link here.
> https://lore.kernel.org/netdev/ZNpEaMJjmDqhK1dW@shell.armlinux.org.uk/

I plan to make rgmii delays configurable from the device tree. Should I?
a. switch to phy_interface_is_rgmii in the current patch?
b. add another patch in this series?
c. wait with change to phy_interface_is_rgmii for patch with rgmii
delays configuration?
