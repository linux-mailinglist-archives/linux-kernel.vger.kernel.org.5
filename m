Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36A878F85E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 08:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348340AbjIAGIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 02:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjIAGIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 02:08:12 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DD7EA
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 23:08:09 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-500b0f06136so3034225e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 23:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20230601.gappssmtp.com; s=20230601; t=1693548487; x=1694153287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55BxJjKi7DirtlyQXejaP8jWTZ8SZUZhKioXDf5mo/E=;
        b=QBsNy5Lk56lDMOQcMwG68f1lbiyhE5WE8znDWRToZSssU2pg8TxskDLijhxZM6ymYa
         3QGHwQzam/NL7HmgdREILF+vc/qLic9CMrWTKgxtAApon4E1rQs35bdzyVflzrWrYezL
         xdx+QUHHSedrOiOIkgmcu/QjF/gU8NkPuFZaix22ytjIMkNwg4u+x+dnxYsBzvvyz820
         ODCqGFIJ7IVgEVvMpXzSD9AlTkmM3tDLKaG09SlKIzXbCREWoek3i7c3so2uNw2pKS85
         pn6pX9oDARO+M2vYu0pSiYunPkNh5cx9YYR/GsTCjNPOjBRmFB1wnZmtnuhgYZia2AYr
         KFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693548487; x=1694153287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55BxJjKi7DirtlyQXejaP8jWTZ8SZUZhKioXDf5mo/E=;
        b=O6ggWym0K9KIodvzmvfjftvPI30XNq/HSho/lWq4ky9zNkO5b1+9fnGNb0vwQDWKg4
         d7oM2HxcEekM9NKc+NefkeiVFJJEz4jyPzJu0AUELqWxlmeqKPiZPr4gtkNmKOSBd3XU
         AfRhnezS8SoZSSxhGTNVKASISl5XosgTNuiZ93H4Zv1tlezVTR0UbPid8bGghuzFlw6h
         gpcd8CNtvwNw5/MjG6ULP/nVyCxU05oIgMJKoGbefhg+jwEO+D1vvOHJL7KVEi4US8TL
         VrXLzcWPGtwqJS7kUIbdyubnckNk5zjFHpfmZ1y7wmJ+2JOTYGIozcO3FQ8cE0jG/Uek
         kiYQ==
X-Gm-Message-State: AOJu0YyOeaMLOVjXciemqLs9yZAu5cbyyT9VpAXQSxBNXRYINvwFZj2s
        qgjzB8+zH9tgI2moomsbsnER0cul8lSOL5Drj6uiI8YevsIQTUqaCOk=
X-Google-Smtp-Source: AGHT+IHhmP3gDhGomai/9raHqQKs+Q5jpKVGJgJsGk/popt6RSiceb6Vl34UQbx7LN57F4CW4PL97nuoVUvhRY61XQc=
X-Received: by 2002:ac2:57cb:0:b0:4fe:7e7f:1328 with SMTP id
 k11-20020ac257cb000000b004fe7e7f1328mr693199lfo.16.1693548487184; Thu, 31 Aug
 2023 23:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230828101757.9724-1-aboutphysycs@gmail.com> <20230828-citable-superjet-d235f036be99@wendy>
In-Reply-To: <20230828-citable-superjet-d235f036be99@wendy>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Fri, 1 Sep 2023 09:07:56 +0300
Message-ID: <CAH3L5QreWNPgwogL7bCYZgKSuz_HfZuKLtRVqz+UyRtJ1TB-SA@mail.gmail.com>
Subject: Re: [PATCH] char: hw_random: mpfs-rng: removed unneeded call to platform_set_drvdata()
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Andrei Coardos <aboutphysycs@gmail.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-riscv@lists.infradead.org, herbert@gondor.apana.org.au,
        olivia@selenic.com, daire.mcnamara@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 2:06=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Mon, Aug 28, 2023 at 01:17:57PM +0300, Andrei Coardos wrote:
> > This function call was found to be unnecessary as there is no equivalen=
t
> > platform_get_drvdata() call to access the private data of the driver. A=
lso,
> > the private data is defined in this driver, so there is no risk of it b=
eing
> > accessed outside of this driver file.
>
> I think Greg previously pointed out to you that is it not sufficient to
> check for platform_get_drvdata() alone, because the information could be
> accessed without going through that helper. That's not the case here,
> but it could be true elsewhere.
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>
> Thanks,
> Conor.
>
> >
> > Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> > ---
> >  drivers/char/hw_random/mpfs-rng.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/char/hw_random/mpfs-rng.c b/drivers/char/hw_random=
/mpfs-rng.c
> > index c6972734ae62..0994024daa70 100644
> > --- a/drivers/char/hw_random/mpfs-rng.c
> > +++ b/drivers/char/hw_random/mpfs-rng.c
> > @@ -79,8 +79,6 @@ static int mpfs_rng_probe(struct platform_device *pde=
v)
> >       rng_priv->rng.read =3D mpfs_rng_read;
> >       rng_priv->rng.name =3D pdev->name;
> >
> > -     platform_set_drvdata(pdev, rng_priv);
> > -
> >       ret =3D devm_hwrng_register(&pdev->dev, &rng_priv->rng);

A question would be if there is a desire to keep the prints below, or
would this be sufficient?

          return devm_hwrng_register(&pdev->dev, &rng_priv->rng);

If there is the desire to keep the prints, then:

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>

> >       if (ret)
> >               return dev_err_probe(&pdev->dev, ret, "Failed to register=
 MPFS hwrng\n");
> > --
> > 2.34.1
> >
