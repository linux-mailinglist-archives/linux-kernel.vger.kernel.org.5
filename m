Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED3E79FEF0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbjINIsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbjINIsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:48:39 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712FC91
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:48:35 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-59bdb3d03b1so7919707b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694681314; x=1695286114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgpTo8R8cmbn0NQ4Vlj56EaTvnRjrAgeOGC10HJRtqo=;
        b=Hpnb+hzCSPUIOqPD4GZnNXO4j/huzhreLOqE3+VvJtlU3+u+wzM+3y7+NQ4skzhusL
         EYcEZWrEewd7OMmdei5lTA8u60e0lalUqu1J7RH4jiwtmfPDfdLRlK2nXe6e6nNusMfE
         c2/cdGQdIRn++9ofjsiCVm6mhSUebkxCu6iI5UEJvc+icbTSW5Ud8jR5GuwG+iUJDFna
         8a7g82bpE0KR8pI5Cqnwu76bfxY5Dcay29OqhmLJIwJyPYfWfeEMD+eC/Dety52VmCXR
         Y8UJqDc7njr2UMzE+4v7c1AElL9U7QCMuXTaGZP2ooWxKrpCAH3D351AB4WHRrGVHNZi
         ca2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694681314; x=1695286114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgpTo8R8cmbn0NQ4Vlj56EaTvnRjrAgeOGC10HJRtqo=;
        b=mVw8A0rrB88M9Mrsczqi3YjUzpIycJNY89CwrcDUZpvzlEu8muqD1RCMM5Mdao7AjH
         Q9StbZswtPNjSW4npZ2oXt+fn4+JL+gUs9H4kNKcxhobHKifftEKe19VO9YReLpefsVm
         G13A43nvOjPj6ghEAicGA7l+KZkJcEHpnQQFuGw+IRKZaaWO5zqE/IqRRdxTtAT8bg5i
         JGBHj2xqUakCQeVo/7iGUMQZK4Szv/aoNQAzrUJdJQl/6dKMg8M0+8dweI2Z65zbF3N+
         NGCrTJR6tdfUrtoC2/OP879t42OmKx3LldoiJueQnt37o4925Lia3ZlmAyhnc0ziKNj8
         Ph3w==
X-Gm-Message-State: AOJu0YwU9gd+3BWsNlDMJzX/+lx3i7maPFB/7xlQPiolKNrTFskRNRTE
        46OXnbmdVTArg9gUVkmbGRBIXZKI2jxqWCB2c8ck/A==
X-Google-Smtp-Source: AGHT+IH0/RvG4XKSLv54lS1VtzFk3qWRB3eh8qCYQISlXOFNm4f+ZAr6PIOVb5l8XmXpGSFRjTp8xmu5+NtuZdyDXF4=
X-Received: by 2002:a0d:f604:0:b0:589:e4aa:7b67 with SMTP id
 g4-20020a0df604000000b00589e4aa7b67mr4381748ywf.41.1694681314700; Thu, 14 Sep
 2023 01:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230914-vf610-gpio-v1-0-3ed418182a6a@nxp.com>
 <20230914-vf610-gpio-v1-3-3ed418182a6a@nxp.com> <b97ff9b6-97df-2c62-1946-06cd4ac79c95@linaro.org>
In-Reply-To: <b97ff9b6-97df-2c62-1946-06cd4ac79c95@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Sep 2023 10:48:23 +0200
Message-ID: <CACRpkdYJFp72o=c1OxN9Kcd7-Ee-id8+O2m0ag-rrT-nfq1Srg@mail.gmail.com>
Subject: Re: [PATCH 3/5] gpio: vf610: add i.MX8ULP of_device_id entry
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 7:48=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 14/09/2023 04:20, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX8ULP supports two interrupts, while i.MX7ULP supports one interrupt=
.
> > So from hardware perspective, they are not compatible.
> >
> > So add entry for i.MX8ULP.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/gpio/gpio-vf610.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
> > index dbc7ba0ee72c..88f7215cdf4b 100644
> > --- a/drivers/gpio/gpio-vf610.c
> > +++ b/drivers/gpio/gpio-vf610.c
> > @@ -67,6 +67,7 @@ static const struct fsl_gpio_soc_data imx_data =3D {
> >  static const struct of_device_id vf610_gpio_dt_ids[] =3D {
> >       { .compatible =3D "fsl,vf610-gpio",       .data =3D NULL, },
> >       { .compatible =3D "fsl,imx7ulp-gpio",     .data =3D &imx_data, },
> > +     { .compatible =3D "fsl,imx8ulp-gpio",     .data =3D &imx_data, },
>
> Why? It is the same as imx7. No need.

Because compatible =3D "fsl,imx7ulp-gpio" is not what is going to be in the
device tree, but compatible =3D "fsl,imx8ulp-gpio"?

What am I missing here? Maybe the commit message is weird.

Yours,
Linus Walleij
