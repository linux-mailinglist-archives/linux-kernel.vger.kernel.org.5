Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FACD7D1415
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377862AbjJTQfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJTQfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:35:31 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DF6D60
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 09:35:29 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c54c8934abso15117651fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 09:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dberlin.org; s=google; t=1697819728; x=1698424528; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jp6YfYGoVMtTsSCroLFUYhmimeWjcHuUGyEJ+OCnT1g=;
        b=gqKe6wDI4X0t/jcjf+IcWV5pToIAmV4zvN+4lM+E74i2p9na72KiW7PJ/F68np8mXC
         Zi6hNo+I5JTXCbWiUlnByPqResw1eVp8mcUjeFWuUGoGDVpZCNU9uDOsXRrKRtExXa9I
         02UivF40ZIMyYFbtTAidEEKvx79D2jLhvbipuIynkQo/yBDS0zLvI0G/nUULD3dwPM7Q
         TDFjMzhjtjOtvp4qSYt4DbJmZDXPkEIUKE+W1SJVLZvQ/6Iwz4bF71pzWriqrSdhCrxU
         osts/z4fGLedt8n/Hi3scAYmnuNwlzBIBylSvzMmRKwRVFaGh1k0RFIb5X0Q3KJdYuW0
         eQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697819728; x=1698424528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jp6YfYGoVMtTsSCroLFUYhmimeWjcHuUGyEJ+OCnT1g=;
        b=S81ZjMhovogjLJiVuWDrBmS8b+G6nIEUV1iSrW89A/yiSUZ1u/xofIkUCfqiyoDn0V
         WVHBLBH0PQHbcV1ZJy9p+colrCM5DcGGpFHpB91/QG3ZBH6gMkg2FurnApdDxY4uQFJ1
         3o7eVNvln4l8ujUg9AeyRT0YjI2exzUnrGeNEQfduZ7fMhNP3+y8DeRu02wrw7MKlrvU
         m7bxZSqJi8DLf/tTyA6zaoDDo5AV7zd2t602pudI89BZt/ZzHJQP1XJRSgc/KnYqia+X
         nvY24rkhHgrZvgLyW7y28JS2gaOCipsp7c69S/ZTrJyVe7LUKvf3ZaY3x9SQls3pAacV
         xj7g==
X-Gm-Message-State: AOJu0YyXYPLW2WVW3VafwNiWpR+z/fEIQTZ7Nd2RYZUkuuTNN5dIJQVV
        l1CzdQqxYkGPEYLLVL1Hm6upHobgrERxHpa6j6/Pcw==
X-Google-Smtp-Source: AGHT+IHvYymc9rPNUuFnhzZdAawyOIWzYujGImzZt+jS1Ezk94R6vXx4xCMpxeZU/92fph8ajhp2Gr4FkJp7FR79DuA=
X-Received: by 2002:a05:651c:198c:b0:2c0:2f51:cb97 with SMTP id
 bx12-20020a05651c198c00b002c02f51cb97mr1972942ljb.6.1697819727424; Fri, 20
 Oct 2023 09:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697650207.git.dberlin@dberlin.org> <52c993fd93e13ac015be935a5284294c9a74ea8e.1697650207.git.dberlin@dberlin.org>
 <cc58057b-bc08-f717-1676-13046fc26c5c@broadcom.com>
In-Reply-To: <cc58057b-bc08-f717-1676-13046fc26c5c@broadcom.com>
From:   Daniel Berlin <dberlin@dberlin.org>
Date:   Fri, 20 Oct 2023 12:35:16 -0400
Message-ID: <CAF4BwTUTmUd0c-y_NfSi9WkCnDO9bhtpx03Aai1ByH5auq9YXw@mail.gmail.com>
Subject: Re: [PATCH 2/5] [brcmfmac] Add support for 6G bands
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
> maybe handle channel 2 here as well, ie.:
>         .center_freq = ((_channel) == 2) ? 5935 : 5950 + (5 * (_channel)),
>
> > +     .hw_value               = (_channel),                   \
> > +     .max_antenna_gain       = 0,                            \
> > +     .max_power              = 30,                           \
> > +}
>
> so we can drop this one below...
>
Will do.

>
>
> > +             /* We ignore this BSS ID rather than try to continue on.
> > +              * Otherwise we will cause an OOPs because our frequency is 0.
> > +              * The main case this occurs is some new frequency band
> > +              * we have not seen before, and if we return an error,
> > +              * we will cause the scan to fail.  It seems better to
> > +              * report the error, skip this BSS, and move on.
> > +              */
> > +             return 0;
> > +     }
> >       bss_data.chan = ieee80211_get_channel(wiphy, freq);
>
> How could this fail? Our wiphy registers all possible channels so if
> ieee80211_channel_to_frequency() succeeds ieee80211_get_channel() can
> not fail.

I agree.
>
>
> > @@ -6965,6 +7066,10 @@ static int brcmf_construct_chaninfo(struct brcmf_cfg80211_info *cfg,
> >               for (i = 0; i < band->n_channels; i++)
> >                       band->channels[i].flags = IEEE80211_CHAN_DISABLED;
> >       band = wiphy->bands[NL80211_BAND_5GHZ];
> > +     if (band)
>
> Eh. Why is this conditional? We are creating all bands in the wiphy
> instance so why the null check here?


I just matched what was there, I can remove all of them if we want.

(I'll take care of the rest of the comments between here)

>
> > -     brcmf_dbg(INFO, "nmode=%d, vhtmode=%d, bw_cap=(%d, %d)\n",
> > +     brcmf_dbg(INFO,
> > +               "nmode=%d, vhtmode=%d, bw_cap=(%d, %d, %d), he_cap=(%d, %d)\n",
> >                 nmode, vhtmode, bw_cap[NL80211_BAND_2GHZ],
> > -               bw_cap[NL80211_BAND_5GHZ]);
> > +               bw_cap[NL80211_BAND_5GHZ], bw_cap[NL80211_BAND_6GHZ],
> > +               he_cap[0], he_cap[1]);
>
> So are these he mac and phy capabilities? ...

No, unfortunately, it's either 1 or 0 on these chips, and all chips i tested.
This is the hardware capability iovar.

In the debug firmware i have access to (not apple's), i do see a
command that looks like it may give the he cap, but i can't find how
it would ever be triggered.
(The iovar code for the iovar above is either always just return 0 or return 1)
There are no obvious iovars that relate, and  the absolute latest
bcmdhd hardcodes the he caps, as do infineon's latest ifx code.
:(
I'l hack around see if i can get the caps out of it.

I'll double check other ones.

> > @@ -8331,18 +8589,21 @@ struct brcmf_cfg80211_info *brcmf_cfg80211_attach(struct brcmf_pub *drvr,
> >       if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_DUMP_OBSS))
> >               ops->dump_survey = brcmf_cfg80211_dump_survey;
> >
> > -     err = wiphy_register(wiphy);
> > -     if (err < 0) {
> > -             bphy_err(drvr, "Could not register wiphy device (%d)\n", err);
> > -             goto priv_out;
> > -     }
> > -
> > +     /* We have to configure the bands before we register the wiphy device
> > +      * because it requires that band capabilities be correct.
> > +      */
>
> Is it?

If you register the 6g band without he_cap set, 80211 is unhappy.
It sanity checks the bands in wiphy_register, and we get caught in the
HE supported check for 6g.

See here:
https://elixir.bootlin.com/linux/latest/source/net/wireless/core.c#L823

In general, you can see it sanity checks the bands/etc as part of
registration.  It happens that 6g triggers the he one, but it seems in
general the bands are supposed to be sane before registration.



> The order was deliberate. brcmf_setup_wiphybands() calls
> brcmf_construct_chaninfo() which disables all channels. When you do that
> before wiphy_register() the orig_flags of the channel will be DISABLED
> and can never be used.

I'll take care of this by copying the flags around.

>
> >       err = brcmf_setup_wiphybands(cfg);
> >       if (err) {
> >               bphy_err(drvr, "Setting wiphy bands failed (%d)\n", err);
> >               goto wiphy_unreg_out;
> >       }
> >
> > +     err = wiphy_register(wiphy);
> > +     if (err < 0) {
> > +             bphy_err(drvr, "Could not register wiphy device (%d)\n", err);
> > +             goto priv_out;
> > +     }
> > +
> >       /* If cfg80211 didn't disable 40MHz HT CAP in wiphy_register(),
> >        * setup 40MHz in 2GHz band and enable OBSS scanning.
> >        */
>
