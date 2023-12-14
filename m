Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076F88133DB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573622AbjLNPDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573588AbjLNPDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:03:48 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D4411D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:03:53 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c9e9c2989dso111035401fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702566232; x=1703171032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bdds0ORz8v+5B0f4PxBAIWXX7DWm0YzECYB8nL+ZDRg=;
        b=KclSK1B1CcPLhM0aUywjXMEsqXYJjb83l6nM+NlX87fmak/R33YXfUuh3E6TAOaa/g
         NiUZqE2lxir3Wl2lGEa9cEa0VoVf+PcnOsDTjuvFnSxt5hpdnvPwaEFHXKOUlgQZDToW
         9qO5hQM8R6Ns4bcVujuk6I3BGXOxYrhUJT24RqB35RPqNs0rS2AfNhTaSeCBHTXoRjUU
         kz1HaBrMKSRiATXdecZ+9CRBeXmppUVcy0+dlnDNk7UBQoKnk0/r+NT68aVxI/GsEVxr
         qzvq0gNLFamrpTkjCqTv9GkYZ5UHhHDOv4rtuWCatZDpa+gwT/FebYUsChVJSYUcsm1h
         T4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702566232; x=1703171032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bdds0ORz8v+5B0f4PxBAIWXX7DWm0YzECYB8nL+ZDRg=;
        b=ED8AF4fDdiJZZFN9ur9muTLRKSF9QF7JimW5YTFKRd5ipxQ5aYupaRbrXIepSiDeTv
         YYsd0hTnJ/UDdhA77Xrtb/gK3YNIlB1viD1B7B/5zEGe5z/D4zdmHgqFgmLa1kGEk4/m
         rHvDXCwdQB/yb5WepFjJU8pvvD70xU9KFlucmO4g8N4dLoSkMKs93LIooJauAIZc83XT
         8ixwW7yjF0rZMM7QGXWljLL9PLTMjTinsrSJTYMcgugcwX/DHZ4+vng8DZlMJn0U3ZiS
         kMNrnRmKxB/eY+HsG4CgK25xmp3mBQinEixOPutTroa4Czh4QbpfTo0xJjliUJQlxZO5
         YYyw==
X-Gm-Message-State: AOJu0YzGOpuVmSTZR2d14G4qD9BASTohthgZYtjugPXy+vFi58JbsVDq
        YT1Q6cuMDdD4an4/TH76aaeJEeJtbra6/iUpaYRSzg==
X-Google-Smtp-Source: AGHT+IFmyI386iLiUHPlW4WwtKlMnA6myG4ZHBLhXxLLf/cnJZpar+DOGncWRfIpEZelwC7WbFhYsO1g5sBePkgkHrc=
X-Received: by 2002:a05:651c:c1:b0:2cc:479d:2d15 with SMTP id
 1-20020a05651c00c100b002cc479d2d15mr255200ljr.81.1702566231864; Thu, 14 Dec
 2023 07:03:51 -0800 (PST)
MIME-Version: 1.0
References: <20231213-ad7380-mainline-v2-0-cd32150d84a3@baylibre.com>
 <20231213-ad7380-mainline-v2-3-cd32150d84a3@baylibre.com> <20231214101415.0000060c@Huawei.com>
 <CAMknhBF9GtbOP_M2q8DrrMOePFOaQzGxqcS2P8OHjtGN-Z27Vg@mail.gmail.com> <20231214123613.00002b69@Huawei.com>
In-Reply-To: <20231214123613.00002b69@Huawei.com>
From:   David Lechner <dlechner@baylibre.com>
Date:   Thu, 14 Dec 2023 16:03:40 +0100
Message-ID: <CAMknhBGR9mkk+mG-vFJqSBFFykyppLpeOYRqcXwUWi6dtMh28Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] iio: adc: ad7380: new driver for AD7380 ADCs
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Stefan Popa <stefan.popa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 1:36=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 14 Dec 2023 11:33:51 +0100
> David Lechner <dlechner@baylibre.com> wrote:
>
> > On Thu, Dec 14, 2023 at 11:14=E2=80=AFAM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Wed, 13 Dec 2023 05:21:20 -0600
> > > David Lechner <dlechner@baylibre.com> wrote:
> > >
> > > > This adds a new driver for the AD7380 family ADCs.
> > > >
> > > > The driver currently implements basic support for the AD7380, AD738=
1,
> > > > AD7383, and AD7384 2-channel differential ADCs. Support for additio=
nal
> > > > single-ended and 4-channel chips that use the same register map as =
well
> > > > as additional features of the chip will be added in future patches.
> > > >
> > > > Co-developed-by: Stefan Popa <stefan.popa@analog.com>
> > > > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> > > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > >
> > > Just one additional comment.  I 'might' sort both this an Nuno's comm=
ent
> > > if Mark is fine with the SPI and no on else has review comments.
> > > Feel free to send a v3 though if you like ;)
> > >
> > >
> > > > +/* fully differential */
> > > > +DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7380_channels, 16);
> > > > +DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7381_channels, 14);
> > > > +/* pseudo differential */
> > > > +DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7383_channels, 16);
> > > > +DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7384_channels, 14);
> > > > +
> > > > +/* Since this is simultaneous sampling, we don't allow individual =
channels. */
> > > > +static const unsigned long ad7380_2_channel_scan_masks[] =3D {
> > > > +     GENMASK(2, 0), /* both ADC channels and soft timestamp */
> > > > +     GENMASK(1, 0), /* both ADC channels, no timestamp */
> > >
> > > https://elixir.bootlin.com/linux/v6.7-rc5/source/include/linux/iio/ii=
o.h#L567
> > > See the comment (added recently!)
> >
> > I did see this comment but this is already sorted in order of
> > preference, so I'm not sure why you are calling it out. Just FYI, I
> > guess?
>
> No. Order of preference would be turn on the minimal if that is enough.
> First item is the highest preference (if the requested channels are a sub=
set of
> that we don't look any further).  Here that means we always stop on the f=
irst
> entry and never look at the second.

OK, I understand what you are getting at now. I thought the preference
could be my personal preference rather than the minimal case. :-)

But as you pointed out, the timestamp is handled separately, so it
doesn't make a difference here. The main point was to ensure that both
channels are always enabled since the ADC is doing simultaneous
sampling and always reading two channels at the same time.

>
> >
> > >
> > > Also, if I remember how this works correctly there is no need to incl=
ude
> > > the timestamp in the mask.  We do special handling for it to avoid ha=
ving to double
> > > the number of provided masks.  The details being that it uses
> > > iio_scan_el_ts_store rather than iio_scan_el_Store.
> >
> > Indeed. I've been working ahead on adding more features and noticed
> > this. So we will need to find a way to say that we the timestamp
> > should not be allowed under certain conditions. But that will be a
> > discussion for a later series.
>
> Interesting - you have cases where it's not valid at all?
> It sometimes becomes inaccurate because we are interpolating across
> data from a fifo, but I've not seen a case where we can't provide anythin=
g
> useful.  Ah well - as you say I'll wait for that later series!
>
> Jonathan
>
> >
> > >
> > > So as you have it I think you'll always end up with the first entry
> > > and that will include a bonus bit that isn't a problem as it will mat=
ch
> > > anyway.
> > >
> > > So just have the second entry and 0.
> > >
> > > Jonathan
> > >
> > > > +     0
> > > > +};
>
