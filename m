Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3005E77113A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 20:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjHESE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 14:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHESE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 14:04:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00610187;
        Sat,  5 Aug 2023 11:04:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84F0C60D41;
        Sat,  5 Aug 2023 18:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7354BC433C7;
        Sat,  5 Aug 2023 18:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691258694;
        bh=96EhEx/ZwAoLEZrGKhah56CZPPgGexCaaNmFBjOhFbo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hvB++aps/bNGYC6pSwdXTNR5Fj41/6hoGjDLgBIcH9qUmPPT3i1+7LyB0Yk5rrExR
         j4sVxJewj4lZu2OUjCHkzzBP2AfjvPSTxJRxqAWhK0lSKFCP39BMwkUObyW3BET+OB
         nPDmNvVPduv6yM/imIEF54LXw9VuloACj101O2b8OfUkDEZ64ZZPad1IHiLyO/a4gd
         bEUMjjoW/XXoXcaYNmaW3juFPHhMuQXWPGRLFXwGnYvdzuxbweJvIAFywwnOLERHYu
         jxfyNpXBp1EqIcIB0lMP0GfOWKUHn0FLOlnOuosTWgkQt+gs/M5OOMWGYV1vEBaBTP
         tAqmdtEJEEpGw==
Date:   Sat, 5 Aug 2023 19:04:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alex@shruggie.ro>
Cc:     Andrei Coardos <aboutphysycs@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-iio@vger.kernel.org, alexandre.torgue@foss.st.com,
        mcoquelin.stm32@gmail.com, lars@metafoo.de
Subject: Re: [PATCH] iio: trigger: stm32-lptimer-trigger: remove unneeded
 platform_set_drvdata()
Message-ID: <20230805190445.08036501@jic23-huawei>
In-Reply-To: <CAH3L5QpuoDYU6qvWH7_z5Yx0cW2qPMbCA8AFEYAPsiEkSzCiwQ@mail.gmail.com>
References: <20230802120915.25631-1-aboutphysycs@gmail.com>
        <CAH3L5QpuoDYU6qvWH7_z5Yx0cW2qPMbCA8AFEYAPsiEkSzCiwQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Wed, 2 Aug 2023 15:37:02 +0300
Alexandru Ardelean <alex@shruggie.ro> wrote:

> On Wed, Aug 2, 2023 at 3:09=E2=80=AFPM Andrei Coardos <aboutphysycs@gmail=
.com> wrote:
> >
> > This function call was found to be unnecessary as there is no equivalent
> > platform_get_drvdata() call to access the private data of the driver. A=
lso,
> > the private data is defined in this driver, so there is no risk of it b=
eing
> > accessed outside of this driver file.
> >
> > Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
> > Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> > ---
> >  drivers/iio/trigger/stm32-lptimer-trigger.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/iio/trigger/stm32-lptimer-trigger.c b/drivers/iio/=
trigger/stm32-lptimer-trigger.c
> > index 2e447a3f047d..df2416e33375 100644
> > --- a/drivers/iio/trigger/stm32-lptimer-trigger.c
> > +++ b/drivers/iio/trigger/stm32-lptimer-trigger.c
> > @@ -92,8 +92,6 @@ static int stm32_lptim_trigger_probe(struct platform_=
device *pdev)
> >         if (ret)
> >                 return ret; =20
>=20
> this can become now:
>=20
>             return stm32_lptim_setup_trig(priv);
I made that change whilst applying.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to take a look at it and see if they can find anything
we missed.

Thanks,

Jonathan

>=20
>=20
> >
> > -       platform_set_drvdata(pdev, priv);
> > -
> >         return 0;
> >  }
> >
> > --
> > 2.34.1
> > =20

