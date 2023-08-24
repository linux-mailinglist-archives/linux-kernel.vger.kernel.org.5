Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F632786A07
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbjHXI2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238912AbjHXI2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:28:18 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81491734
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:28:13 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bbbda48904so81552911fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1692865692; x=1693470492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdz3KnRZnnKJHF7J9lrCuaBuAwD4CdeMT7lxdX3j5vc=;
        b=OCpq3/YFdKki4ePqQ2OXlshJpxa/mA43T4UO7SU7d4+WreOX5+PnixbkcrPVZH19PP
         9sd1g0nuxwCYjZzfVr1GnOGJ37Inz85fkDmmqv+fO6S1HNcOHu09DPeH7VK+SwiaVHRc
         y+qTURdnXyQ86obknrhWx4iCN3TBPaaakm5/kTOFiVwHpIVA7P6AJ6EiXt7BxSyX2GHl
         hfKv4ctvyqapZy4kl3hJMQPV/kDxsedq0wn2LdUnSJiaNvI3pXrMQrrOuWCu1XpYR/rR
         zwBdIaPgrxvSM6qXjXelh5I+VMh//R5p48/DJSI/LNuwVwKTbCltptPQNjB+KsesP2DB
         Ccrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692865692; x=1693470492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdz3KnRZnnKJHF7J9lrCuaBuAwD4CdeMT7lxdX3j5vc=;
        b=hwZ0Sjfs1mNjkoJ3RdgUt5TwR0FYlUYRq5UGYVp8MV3ud/Sg8YZ5TsOrT+r5r36rr0
         MUYDtrPj5yIpPhFhjusssk83kkhdOt0eOmfgekYyYFWiFhZHSc+qVbwLWRou7PmsonlH
         S64pmTuvzghR8IXWhNBmkVurLqbDKrQ8KmsAj2Mi6Iy1VfkGkAvCnGcbLzH60CW2GUyr
         U6apkYO9GSAGj34msGTLy4qXyD28VFl2ujfDDFfW+yRuoIp9pwZ5mz65O5eUBbIMAESJ
         xMLoGluyYbPElg+Mc3K/5SedWbO1b7BKcX1mS5E3zI5LKMNMl5c0DfMa888n2qcAZNNa
         tpbw==
X-Gm-Message-State: AOJu0YyXSDlygBNrHWX5SoooFIz8coPuHZ1vp8JQTkV+EPWOAt31LqPW
        q30N0FyOuwsz+fV6oYiunLJpjzxsLRSeWvOIGX0G+g==
X-Google-Smtp-Source: AGHT+IGqOaHfuFjakkSUTWio9q6lciJOqJWxMjbjAGnb3Ha4GwjzLDCj4ijaZAm6Ry2cuzS3pGhTYTdIzgYA30+EVmo=
X-Received: by 2002:a05:6512:553:b0:500:8fcb:e0c9 with SMTP id
 h19-20020a056512055300b005008fcbe0c9mr4056323lfl.69.1692865691841; Thu, 24
 Aug 2023 01:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230823112139.4012-1-aboutphysycs@gmail.com> <20230823134417.pe4jm3xqj6tdslav@viti.kaiser.cx>
In-Reply-To: <20230823134417.pe4jm3xqj6tdslav@viti.kaiser.cx>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Thu, 24 Aug 2023 11:28:00 +0300
Message-ID: <CAH3L5QpmVqNMr_kSFa_rar5ZEjLv_5Xxjss4syVX2_0bCuL5vQ@mail.gmail.com>
Subject: Re: [PATCH] char: hw_random: hisi-rng: removed unneeded call to platform_set_drvdata()
To:     Martin Kaiser <lists@kaiser.cx>
Cc:     Andrei Coardos <aboutphysycs@gmail.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, olivia@selenic.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 4:44=E2=80=AFPM Martin Kaiser <lists@kaiser.cx> wro=
te:
>
> Andrei Coardos (aboutphysycs@gmail.com) wrote:
>
> > This function call was found to be unnecessary as there is no equivalen=
t
> > platform_get_drvdata() call to access the private data of the driver. A=
lso,
> > the private data is defined in this driver, so there is no risk of it b=
eing
> > accessed outside of this driver file.
>
> > Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> > ---
> >  drivers/char/hw_random/hisi-rng.c | 2 --
> >  1 file changed, 2 deletions(-)
>
> > diff --git a/drivers/char/hw_random/hisi-rng.c b/drivers/char/hw_random=
/hisi-rng.c
> > index 96438f85cafa..b6f27566e0ba 100644
> > --- a/drivers/char/hw_random/hisi-rng.c
> > +++ b/drivers/char/hw_random/hisi-rng.c
> > @@ -79,8 +79,6 @@ static int hisi_rng_probe(struct platform_device *pde=
v)
> >       if (!rng)
> >               return -ENOMEM;
>
> > -     platform_set_drvdata(pdev, rng);
> > -
> >       rng->base =3D devm_platform_ioremap_resource(pdev, 0);
> >       if (IS_ERR(rng->base))
> >               return PTR_ERR(rng->base);
> > --
> > 2.34.1
>
> This one can go.
>

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>

> Reviewed-by: Martin Kaiser <martin@kaiser.cx>
