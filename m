Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02447886C5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244552AbjHYMPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244548AbjHYMPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:15:25 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168C8E6B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:15:23 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d62bdd1a97dso866622276.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692965722; x=1693570522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMU1R+PVzBac87HpuQmNr/+WsySv+iMkq0OhR7XVs3E=;
        b=cISxvSrYo5AlkdO2bFshDP2PNrawKbv+enAiO+stYKRHMS7uGI3g9Rk+KDe1wtFSch
         UK4dKie4WAfjvipqmDVVTu3szRMIcGj3QOdasio/EMUmBmXZFfXciMNxc4HaFrn2EUw4
         Nmyr7jPj+08WcHz3hDVVwOgcKwjuFsTPayjf5+iPRi4OGvdBDKmkUDc4Y50SkhJSXPiq
         O4H1Fh/44j12iwC5WfHjUshnUl/FLRdhs5XK0A3uPuL39HU46HK/uhLG88Cf0djhqltq
         3r+1k5sqAqVVAFQvVmyFLg1DCL3ZDRvu3A/DtlF44CxlecNRiU+SLt5nedqNMAOaI6w2
         HPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692965722; x=1693570522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMU1R+PVzBac87HpuQmNr/+WsySv+iMkq0OhR7XVs3E=;
        b=dKDgNdVqFQ/rixTXJGF8tIySuaRPNwTQF9pWP/FZp0dpGbjHn/91TPU7sHbjk138jr
         kuOsz7RV4BhImKksS9+AQg83Ga5hL581tYA8m+emhxEYZkfL+UV0KWQJgF/lgBRz2FXF
         aNfHJP4Wcc8pI3Lz8d9zwKIfttr0I70lSLpjv30F4FpUjE5BKKvmGrIbHp/ON5X6TXUA
         CrRz08tp+QXJgsSh4xfljhM5dZjz4meXPnJyz59eQlhMhcTF9OltxGoB+bkVU0TP3hmx
         KbTZJR9kZYixzKkw+qa12CuUZ9Whf5Ic+NyybNpq/yfByxPly6htyNT3hH7nUOTWiIEt
         JH0g==
X-Gm-Message-State: AOJu0Yw991z71H4YO16PFEy7JOp+4TBllv6BVzDD7yuRSHdGrdmKsjz5
        mA1B+UCyf6JnmNe/A8rNhjLYcmsZfwlbgrFIdIbnyQ==
X-Google-Smtp-Source: AGHT+IHvePUD7/4ibhi9aXpUNxQ1GUMTKm3YUWv5cNLzvbOBOrVXxhA8JP2jLRIJnobmYcOIRD8Nx636DTTS0+/jheg=
X-Received: by 2002:a25:ce0e:0:b0:d6b:78fe:f1c1 with SMTP id
 x14-20020a25ce0e000000b00d6b78fef1c1mr18229770ybe.65.1692965722298; Fri, 25
 Aug 2023 05:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230825095157.76073-1-balamanikandan.gunasundar@microchip.com>
 <20230825095157.76073-4-balamanikandan.gunasundar@microchip.com> <CACRpkdahEcKgR9gR7iU0cW_aDTReDYBKdP+5_F+hGcarCjG9gg@mail.gmail.com>
In-Reply-To: <CACRpkdahEcKgR9gR7iU0cW_aDTReDYBKdP+5_F+hGcarCjG9gg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 25 Aug 2023 14:14:46 +0200
Message-ID: <CAPDyKFqg7G_vTJnXXT6JSc7J9Vha8s+5gFBtQugE7nCFqCLj6Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] mmc: atmel-mci: Move card detect gpio polarity
 quirk to gpiolib
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, hari.prasathge@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2023 at 13:45, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
>
> On Fri, Aug 25, 2023 at 11:53=E2=80=AFAM Balamanikandan Gunasundar
> <balamanikandan.gunasundar@microchip.com> wrote:
>
> > The polarity of the card detection gpio is handled by the "cd-inverted"
> > property in the device tree. Move this inversion logic to gpiolib to av=
oid
> > reading the gpio raw value.
> >
> > Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@mic=
rochip.com>
> > Suggested-by: Linus Walleij <linus.walleij@linaro.org>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> > +#if IS_ENABLED(CONFIG_MMC_ATMELMCI)
> > +       /*
> > +        * The Atmel HSMCI has compatible property in the parent node a=
nd
> > +        * gpio property in a child node
> > +        */
> > +       if (of_device_is_compatible(np->parent, "atmel,hsmci")) {
> > +               np_compat =3D np->parent;
> > +               np_propname =3D np;
> > +       }
> > +#endif
>
> You don't need to use the preprocessor actually, what I did in my
> example works:
>
> if (IS_ENABLED()... && of_device_is_compatible()...) {
> ...
> }
>
> If the first expression in the if() clause is constant false, the compile=
r
> will optimize out the entire if()-clause. At least the compilers we care
> about.

Looks nicer. Feel free to send a patch on top, so I can pick it up.

Kind regards
Uffe
