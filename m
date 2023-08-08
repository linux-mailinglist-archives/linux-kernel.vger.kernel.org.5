Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2C5774D56
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjHHVtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjHHVtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:49:45 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0778110D1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 14:49:44 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9c55e0fbeso95333021fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 14:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1691531382; x=1692136182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qYerQWFf1ix5KHtY99MS4jSB8DQAs9co/lnQIZ+dhI=;
        b=FrNaFxjlwpRFm2ZaqTEVKKumXjnd7ComOOWOZmrjXYgDYMvEXazM7CCXphzVh1/C/K
         NP5sjTK0dIQm0/9wGmf7nEwDV7Xk8f+T97AbHbMm4JkjPDfbkskBicWsAACfRTGKUHkG
         zuC69RP3+07PAyZhrHIpT6PPZ98X9xyJu+2DEkSGWP1HRqHeQ1YU8pWInTUVhylbG2g4
         bzAC745EN5wdU3rCMBBBZT6q6cD2O+q2EGddA4xv+55YkHsb2lE90EoPvp2S73b9Wgfa
         bcZc3s1S6HVntugMBSpBUNjQUovF4F1LmIketV9E5WzR9zdf+AT9GddV1aRJ5XYi7wY+
         qtzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691531382; x=1692136182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qYerQWFf1ix5KHtY99MS4jSB8DQAs9co/lnQIZ+dhI=;
        b=je+qXxxP2QwqBg3gmekJTTnxPC1nNyKkvWoAQM5ahPkfLscySlebkxbN/QJdbOdZs1
         jRxWdrv4x+BAtR3N+6ZWb8n6l6uwsf38vm+KqXHIkLugE5YdunhJxm3L8U9ceSsZ17go
         oU35pLG3lkf5Zp4nz/fXwYZu2k6F4sfySCqkxoyZ84WzvhImXdr7hIBJqmM/9apJl2L7
         8VURNCXFeU4NEjceGMjFaTgixU7dszerqUkaOpGKUnvX5ruIEzsRasLI8dMU62Y5JYRZ
         ZxYQJLcCyfncU4zAGrrarXza04ckY//8iYWkmNhQcm58mpezYSsrOLMtcfH8nByTjC/I
         9+rw==
X-Gm-Message-State: AOJu0Yy6A4bGSWbwkSf1AaKusMLU4atSQq0KpQtTONDUe/b090w/5rBZ
        kz4kWRxYTlmo8WLWz2MA85XHTqvzSoOeXZs9q69g9Q==
X-Google-Smtp-Source: AGHT+IH2g37CljZBjyKryUTqwvcCbghj2op+ujnMBCmtdJr8xIQF/zKIPIsTftv+x+by2YvZLpwCGXHcH4ENvmiFF18=
X-Received: by 2002:a2e:9b86:0:b0:2b9:e501:a6a6 with SMTP id
 z6-20020a2e9b86000000b002b9e501a6a6mr563511lji.30.1691531381689; Tue, 08 Aug
 2023 14:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230808050016.1911447-1-da@libre.computer> <b8931b6c-5b35-8477-d50f-b7a43b13615f@gmail.com>
In-Reply-To: <b8931b6c-5b35-8477-d50f-b7a43b13615f@gmail.com>
From:   Luke Lu <luke.lu@libre.computer>
Date:   Tue, 8 Aug 2023 21:49:30 +0000
Message-ID: <CAAzmgs75L6Y3PU1SF8Uvh1Z2cqt86HmaRKFn088yzRK73mfnLA@mail.gmail.com>
Subject: Re: [PATCH v3] net: phy: meson-gxl: implement meson_gxl_phy_resume()
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Da Xue <da@libre.computer>, Andrew Lunn <andrew@lunn.ch>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Heiner Kallweit:

On Tue, Aug 8, 2023 at 6:42=E2=80=AFAM Heiner Kallweit <hkallweit1@gmail.co=
m> wrote:
>
> On 08.08.2023 07:00, Da Xue wrote:
> > After suspend and resume, the meson GXL internal PHY config needs to
>
> To avoid misunderstandings:
> You mean suspend/resume just of the PHY, or of the system?
>
We found this issue during the test of whole system
suspend/resume(including ethernet/network),
so it's more proper to interpret as "the system" here

> Description sounds like this patch is a fix and should go to stable.
I agree it's worth the effort to push the patch to stable tree, but
found a conflict with
commit 69ff53e4a4c9 ("net: phy: meson-gxl: use MMD access dummy stubs
for GXL, internal PHY")
It will prevent maintainers doing a clean cherry-pick, we can slightly
rework the patch and
send it to the stable tree separately once this patch is accepted by mainli=
ne.

> So add a Fixes tag.
Sure, as the issue is introduced with first resume(), so will add
Fixes: 7334b3e47aee ("net: phy: Add Meson GXL Internal PHY driver")

> And a formal remark: Your patch misses the net / net-next annotation.
>
Not sure if we understand this correctly, do you mean the one line
summary of this patch?
or the content of the commit message that needs to improve to reflect this =
is an
ethernet/net related fix?

I'd appreciate if you can explain a little bit more, so we can better
fix this, thanks

> > be initialized again, otherwise the carrier cannot be found:
> >
> >       eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state
> >               DOWN group default qlen 1000
> >
> > After the patch, resume:
> >
> >       eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state U=
P
> >               group default qlen 1000
> >
> > Signed-off-by: Luke Lu <luke.lu@libre.computer>
> > Signed-off-by: Da Xue <da@libre.computer>
> > ---
> > Changes since v2:
> >  - fix missing parameter of genphy_resume()
> >
> > Changes since v1:
> >  - call generic genphy_resume()
> > ---
> >  drivers/net/phy/meson-gxl.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
> > index bb9b33b6bce2..bbad26b7c5a1 100644
> > --- a/drivers/net/phy/meson-gxl.c
> > +++ b/drivers/net/phy/meson-gxl.c
> > @@ -132,6 +132,18 @@ static int meson_gxl_config_init(struct phy_device=
 *phydev)
> >       return 0;
> >  }
> >
> > +static int meson_gxl_phy_resume(struct phy_device *phydev)
> > +{
> > +     int ret;
> > +
> > +     genphy_resume(phydev);
>
> Return value of this function should be checked.
>
will fix in v4

> > +     ret =3D meson_gxl_config_init(phydev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +
> >  /* This function is provided to cope with the possible failures of thi=
s phy
> >   * during aneg process. When aneg fails, the PHY reports that aneg is =
done
> >   * but the value found in MII_LPA is wrong:
> > @@ -196,7 +208,7 @@ static struct phy_driver meson_gxl_phy[] =3D {
> >               .config_intr    =3D smsc_phy_config_intr,
> >               .handle_interrupt =3D smsc_phy_handle_interrupt,
> >               .suspend        =3D genphy_suspend,
> > -             .resume         =3D genphy_resume,
> > +             .resume         =3D meson_gxl_phy_resume,
> >               .read_mmd       =3D genphy_read_mmd_unsupported,
> >               .write_mmd      =3D genphy_write_mmd_unsupported,
> >       }, {
>
