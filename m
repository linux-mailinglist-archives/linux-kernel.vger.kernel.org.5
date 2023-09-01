Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA4F78F860
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 08:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244214AbjIAGJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 02:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjIAGJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 02:09:41 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B175112F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 23:09:36 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4ff09632194so2919155e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 23:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20230601.gappssmtp.com; s=20230601; t=1693548575; x=1694153375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2X9aQ6kjaHcqnoXrvZ4rj7x9p81exKW6dfx0r3OrpVM=;
        b=WFaq3mBDGe9rpOX0hOyEJC18H672JhLx4EpHNkuw3dTRTQs0k4ZBQGaQb7iLf8TuVj
         YxGxfbxdyajq4bRZDqKO6vdNuHCrjOWXNfjUCeswGe1xHZIkwfR5lJusRNe9MQ94mnAk
         HduuWvkO/I8eJ035+NTldZft/Kxg3pLbEsrgdlY6PzpXvJvAVQqyuYeBBXa7Qb36F8RC
         jUqaB97Zp3HSiNaPNtgfmWqCjZNfmOdpOFQwYRRBXDm1HcS9LuhsmPO4tz3H6lqzonJK
         fnLy55r6LMVCTuIMILnki2nWe1Qd/8UqNorldyng5CzUHANC5EEvBGAQaos26vesa52W
         WEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693548575; x=1694153375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2X9aQ6kjaHcqnoXrvZ4rj7x9p81exKW6dfx0r3OrpVM=;
        b=HZbE/k8vkIlFItGCgzdTriGpK53uR7eQujcsA+oCa7YRXuFFubAXZgtMas2zFYCqNJ
         8zCll/2l9L+1+wQ7EmRdPUdlQrWwOnZkUyrFq5zqidkTuqiaswKdOyJVm/O2ytBkQJb4
         igJzCkcLU0PF4t7NkMHx/Gm8zBK+a+9r+/gyWlgVsidMBggzobu2Nu8ekzK8o9hhzaIi
         sQWBDhplMwJzbZ5900K7hG1kbwdhUCWKO+bpgGGaBgU+RYF0dVxuLhHNK6ke5ASfQ5Qe
         eL/Cz0yaQtiIbzyemmp8QkbJQ0VNhSYXimPOE+xQ8bNcQ3mfGC+S6zik6om1ZXqMW4+M
         3S1g==
X-Gm-Message-State: AOJu0YyfU6y8SHqBU4WxpeQzM49whNcW45owNe+QBLyCitsQSpNMcNzI
        4cOSCyzmQkRTxDIEtrRPb8MNqlt1XncLu+JrPZ6fyw==
X-Google-Smtp-Source: AGHT+IEpbjisJgojrc9V4dY+OL0FoJj+82T7LyPCLjB0dO7jvYU5ogexJvk1/AAyEF+s9N5djuw56V22H4SpW3S7s/E=
X-Received: by 2002:ac2:530b:0:b0:4fb:829b:196e with SMTP id
 c11-20020ac2530b000000b004fb829b196emr862178lfh.2.1693548575001; Thu, 31 Aug
 2023 23:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230828102329.20867-1-aboutphysycs@gmail.com> <20230828114806.cjshfg7tpxiwyy6i@viti.kaiser.cx>
In-Reply-To: <20230828114806.cjshfg7tpxiwyy6i@viti.kaiser.cx>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Fri, 1 Sep 2023 09:09:23 +0300
Message-ID: <CAH3L5QrGn6+A7FiRc502E+8o3ZOWnukr+fXqVp-VrLC8kmj79A@mail.gmail.com>
Subject: Re: [PATCH] char: hw_random: xgene-rng: removed unneeded call to platform_set_drvdata()
To:     Martin Kaiser <lists@kaiser.cx>
Cc:     Andrei Coardos <aboutphysycs@gmail.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        yuzhe@nfschina.com, u.kleine-koenig@pengutronix.de,
        herbert@gondor.apana.org.au, olivia@selenic.com
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

On Mon, Aug 28, 2023 at 2:48=E2=80=AFPM Martin Kaiser <lists@kaiser.cx> wro=
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
> >  drivers/char/hw_random/xgene-rng.c | 1 -
> >  1 file changed, 1 deletion(-)
>
> > diff --git a/drivers/char/hw_random/xgene-rng.c b/drivers/char/hw_rando=
m/xgene-rng.c
> > index 7c8f3cb7c6af..9d64b5931a27 100644
> > --- a/drivers/char/hw_random/xgene-rng.c
> > +++ b/drivers/char/hw_random/xgene-rng.c
> > @@ -321,7 +321,6 @@ static int xgene_rng_probe(struct platform_device *=
pdev)
> >               return -ENOMEM;
>
> >       ctx->dev =3D &pdev->dev;
> > -     platform_set_drvdata(pdev, ctx);
>
> >       ctx->csr_base =3D devm_platform_ioremap_resource(pdev, 0);
> >       if (IS_ERR(ctx->csr_base))
> > --
> > 2.34.1
>
> This one's ok, too. 67fb1e295839 ("hwrng: xgene - Simplify using
> devm_clk_get_optional_enabled()") removed the platform_get_drvdata call.
>

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>

> Reviewed-by: Martin Kaiser <martin@kaiser.cx>
