Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDC67AD80B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjIYM3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjIYM26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:28:58 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC659C0;
        Mon, 25 Sep 2023 05:28:51 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-57b8a0f320dso2472871eaf.1;
        Mon, 25 Sep 2023 05:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695644931; x=1696249731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEMB+aMclhd1sl71SWaIAmlGGLDyHVrWoaX/gY8/R5c=;
        b=V7KDck2LK6EjRLkng9gatYnO7JdSommgSsf4gkzKxtgvD0qU9Nz1AgNErTZ281S6V6
         Ox3kO/gQttIKUWuUn3AV9S0/HmOuBb3qDRjQ5BLKzIY9pJNi1oddX65Y+B18M6M0dBPA
         yXbo7i4s7LF/OFOkKDTMQzDTmbeQ9BOd4QZeu6yryn4rJ5ZBoJgrn4IQL17D36pm1Jt4
         mpE/feuJ1tejwkdS0V7ARmiJpykH6y98THurnB1B0qUZWSuzn9zSkml6Kon69i4AHYI2
         dOLj+9xHebAxFTyGjTrO+CtJNZI7/SvuClB5fH3MdHKtC6UAhS+3Gzvyd5YtJnIZXDji
         b9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695644931; x=1696249731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEMB+aMclhd1sl71SWaIAmlGGLDyHVrWoaX/gY8/R5c=;
        b=YW1huWns4+34NhE8V18MWKrsgJcCIy0J6bgTIfRVyQKCz9BCjfrdSfbIEIdNFF2K4H
         c1ztbXT1crHEIyp0OFJCkBBk8P+yYjhY5Okn5WSCxhwhquieaTa9pPc0SZhGjIsK+Ma8
         hNj57tCz8j5KhoqZfCyiCs3H952I5GCzxdkvPu6EcxduOzfSOkIb+XBvqlxBpq+weqMQ
         YCJhxbWfabkBuUBGOOyUXNTYZCliV6J/aj2bZvneoYmkhTLklI6g2bLtxGcCl98ZKEBz
         bcE5PsrEa16zrR0PsFwYBJhCyqsxA21Yq50wdInm6UbqIiHU2/SDy8IPd78MxR7eJ5U5
         i7EA==
X-Gm-Message-State: AOJu0Yw2O3DZcSPYqOF3uUT8j44zI4HyoGFaR0fcJn7LeAQBTFmJ7s1r
        JXlHssny3dr8SaUbPhmk6kgEGO0irH2ELMzkTKI=
X-Google-Smtp-Source: AGHT+IGIn17QRT9sghZGFLapfE2B79F0bn2aZRTy/vN6Uwtkl2OMEt9VJArKEss1Aal2b/jP5XnS7vRIpVGaykVipLw=
X-Received: by 2002:a4a:2a14:0:b0:576:8b77:59ee with SMTP id
 k20-20020a4a2a14000000b005768b7759eemr5823510oof.2.1695644931104; Mon, 25 Sep
 2023 05:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230924222559.2038721-1-andreas@kemnade.info>
 <20230924222559.2038721-3-andreas@kemnade.info> <CAHp75VfvmED4ZsmrH4B6m9kGsH=68-zjQd5JMszb6UBTtbF0bw@mail.gmail.com>
 <20230925140415.00130082@aktux>
In-Reply-To: <20230925140415.00130082@aktux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Sep 2023 15:28:15 +0300
Message-ID: <CAHp75VeyCnDwCAf4pKVynQDXdqM9nURLFHKODkgF0c+BLCrQ7w@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: imu: mpu6050: add level shifter flag
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bcousson@baylibre.com, tony@atomide.com,
        jean-baptiste.maneyrol@tdk.com, chenhuiz@axis.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
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

On Mon, Sep 25, 2023 at 3:04=E2=80=AFPM Andreas Kemnade <andreas@kemnade.in=
fo> wrote:
> On Mon, 25 Sep 2023 14:07:58 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Mon, Sep 25, 2023 at 1:26=E2=80=AFAM Andreas Kemnade <andreas@kemnad=
e.info> wrote:
> > >
> > > Some boards fail in magnetometer probe if flag is not set.
> >
> > Which flag? Can you elaborate a bit more?
> >
> well see $subj. The level shifter flag.

Well. it is better to have the commit message being self-contained.

> > Does it deserve the Fixes tag?
> >
> As there are only certain boards affected, they would also have
> to add the flag in dtb, I do not think it deservers a Fixes tag.
> Even in the board I have here, there are basically two
> mpu9150 connected per cable, only one of them needs the flag.

OK.

...

> > >         unsigned int val;
> > >         int ret;
> >
> > > +       ret =3D regmap_update_bits(st->map, 0x1, 0x80,
> > > +                                st->level_shifter ? 0x80 : 0);
> >
> > This is a bit cryptic, what does 1 stand for?
> >
> Well, I do not find anything in
> https://invensense.tdk.com/wp-content/uploads/2015/02/MPU-9150-Register-M=
ap.pdf
> I have just found a similar line in the ancient 3.0 vendor kernel. No sym=
bolic
> names there.

Okay, perhaps a comment on top to point out this ("the code based on
v3.0 vendor kernel, the meaning is unknown").

--=20
With Best Regards,
Andy Shevchenko
