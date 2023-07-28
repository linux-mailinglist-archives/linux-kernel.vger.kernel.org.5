Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D674B76678A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbjG1Ion (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbjG1IoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:44:22 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB442735
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 01:44:21 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31757edd9edso1891776f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 01:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690533859; x=1691138659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vB7Of/BuFi9+aALG5cWGsKnoprs7rEvHZgFmRNt4IE8=;
        b=WquZjCfqA38ipQpLTa2wbLyI/Vc9NPdHX3NpU5TQu1cVaCW2Xmt+DKCWFXjbKB5l8K
         9kRhjxZjFodJrNu00zBTWkqQNgwf7QmoSc/XphhGNKUHGsTnOoequLu+r5fwb8DcFqcf
         V429agEzh6DlS2FiMWt4TfMs0kBkSnLNQfI7Xt2V9zmLruXgxB5XPx2aXriJq4g1Z9vz
         61dDxNX95+VJiiW0o8UegOKLiRA27eAyzH3I8RPJzo2XtuPPRfae3xzEoQgRnOpiRfsl
         b90XIUjZK0vx6zq1tGQiVUR2DqO1kqPsa8ERcDgXz5pOlEgqsXocqjK4d3LriNcpVuZ2
         QbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690533859; x=1691138659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vB7Of/BuFi9+aALG5cWGsKnoprs7rEvHZgFmRNt4IE8=;
        b=XePB8aYN0ukkVbBoodJoSIXBNS0+bmtL2HvEYz1fSGTWwGIK0A4XL64m7oPY+Zyaxl
         PDFvu+hMuNGxBi6un93+5QaIJqvXkSIw3ITvTkPgrmMGR8ykBdj+puvJvLSWK1/bwjFg
         sEYTVRj5ZNr7Ar7tyTjTNBz+fZGUdMLMsdX2pyi7QVagmaRQxLATwXLGHpmuwtaZ9tMW
         uK1j564rd2Crjc8SMzZMKCpahag/ZynRUT8Z7NFWQQAoXXRkzfu/QMzyLHazXxpaRPEd
         j/ABxNkdSfgWUJ6kneAoe+9npM2TiMIu19rW9bgtJ3j8H6LyDv5ZImNnMKEMGWOn9FXa
         oUgA==
X-Gm-Message-State: ABy/qLYsRrzlXZwtRHv+S97w5s05Mc013K2/Eb1YlEuB/UxD6lj/5gLd
        6z2Yy4wQUiod4rc4uurhbcmiLA==
X-Google-Smtp-Source: APBJJlH7pxfaml/ym7Fpd5Omt4CBBAfTo+yLhntYYDm4t5UKAIZolUwQGhIWA/FoYabu43jWNcAdOg==
X-Received: by 2002:a5d:668c:0:b0:317:1b01:857e with SMTP id l12-20020a5d668c000000b003171b01857emr1287224wru.41.1690533859505;
        Fri, 28 Jul 2023 01:44:19 -0700 (PDT)
Received: from hades (ppp089210088142.access.hol.gr. [89.210.88.142])
        by smtp.gmail.com with ESMTPSA id cs5-20020a056000088500b0031435731dfasm4270788wrb.35.2023.07.28.01.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 01:44:19 -0700 (PDT)
Date:   Fri, 28 Jul 2023 11:44:16 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
Message-ID: <ZMN/4F4TZZtt8B/b@hades>
References: <20230727-synquacer-net-v1-1-4d7f5c4cc8d9@kernel.org>
 <CAMj1kXH_4OEY58Nb9yGHTDvjfouJHKNVhReo0mMdD_aGWW_WGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXH_4OEY58Nb9yGHTDvjfouJHKNVhReo0mMdD_aGWW_WGQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard, Mark

On Fri, Jul 28, 2023 at 07:45:44AM +0200, Ard Biesheuvel wrote:
> (cc Masahisa)
> 
> On Thu, 27 Jul 2023 at 23:52, Mark Brown <broonie@kernel.org> wrote:
> >
> > As documented in acd7aaf51b20 ("netsec: ignore 'phy-mode' device
> > property on ACPI systems") the SocioNext SynQuacer platform ships with
> > firmware defining the PHY mode as RGMII even though the physical
> > configuration of the PHY is for TX and RX commits.  Since
> > bbc4d71d63549bc ("net: phy: realtek: fix rtl8211e rx/tx delay config")
> > this has caused misconfiguration of the PHY, rendering the network
> > unusable.
> >
> > This was worked around for ACPI by ignoring the phy-mode property but
> > the system is also used with DT.  Since the firmware used with DT is the
> > same (the firmware interface is selectable in the firmware
> > configuration) and the firmware configures the PHY prior to running the
> > OS we can use the same workaround.
> >
> 
> Wouldn't this break SynQuacers booting with firmware that lacks a
> network driver? (I.e., u-boot?)
> 

U-Boot does support the network interface (sni-netsec.c) but I'll have to
check what that code does wrt to the PHY config.  Since the interface works
I am assuming some config is done properly. 

> I am not sure why, but quite some effort has gone into porting u-boot
> to this SoC as well.

It was mostly an effort to prove the box is SystemReady-IR compliant.  On
top of that it was (back then) one of the few available platforms with an
RPMB interface and OP-TEE support, so it was used for demonstrating storing
EFI variables there. 

Regards
/Ilias
> 
> 
> > Limit this to the SynQuacer, though practically speaking this is the
> > only currently known system using this device.
> >
> > Fixes: 533dd11a12f6 ("net: socionext: Add Synquacer NetSec driver")
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > ---
> >  drivers/net/ethernet/socionext/netsec.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
> > index 2d7347b71c41..ae4d336efaa4 100644
> > --- a/drivers/net/ethernet/socionext/netsec.c
> > +++ b/drivers/net/ethernet/socionext/netsec.c
> > @@ -1845,10 +1845,20 @@ static int netsec_of_probe(struct platform_device *pdev,
> >  {
> >         int err;
> >
> > -       err = of_get_phy_mode(pdev->dev.of_node, &priv->phy_interface);
> > -       if (err) {
> > -               dev_err(&pdev->dev, "missing required property 'phy-mode'\n");
> > -               return err;
> > +       if (of_machine_is_compatible("socionext,developer-box")) {
> > +               /*
> > +                * SynQuacer reports RGMII but is physically
> > +                * configured with TX and RX delays, since the
> > +                * firwmare configures the PHY prior to boot just
> > +                * ignore the configuration.
> > +                */
> > +               priv->phy_interface = PHY_INTERFACE_MODE_NA;
> > +       } else {
> > +               err = of_get_phy_mode(pdev->dev.of_node, &priv->phy_interface);
> > +               if (err) {
> > +                       dev_err(&pdev->dev, "missing required property 'phy-mode'\n");
> > +                       return err;
> > +               }
> >         }
> >
> >         priv->phy_np = of_parse_phandle(pdev->dev.of_node, "phy-handle", 0);
> >
> > ---
> > base-commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef
> > change-id: 20230727-synquacer-net-e241f34baceb
> >
> > Best regards,
> > --
> > Mark Brown <broonie@kernel.org>
> >
