Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A587CD755
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjJRI7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjJRI7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:59:53 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00FAFD;
        Wed, 18 Oct 2023 01:59:51 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1e9baf16a86so3448614fac.1;
        Wed, 18 Oct 2023 01:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697619591; x=1698224391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLg1o9DOF3VnHtMnC8PASVDsIiegad5WKGOMGpmn+Ec=;
        b=ndnn/ryij66BIvxFAtAUGEEKwcuDFnhOf0Ag63I/9eYtfrX/pGRZeB9XgOeszSZ3GI
         g+UcU+ALVUTCvTVtoWqFD8PG+ygpsz6TTaQJMueYaqsVILV0rrkzN4XZU77ocjF/R50I
         Jd694UXQAZ5dWdrbtClPSN76Q/0M+i0kwbaCmtR3OZRtk7GfY24P9SPQd5w5Czbu1duB
         uDJK9TNM/gUbTXbIGiHKk9Q/8+3bysfl/Ajc85Mfyfi0XQbO0TdHzaNtbjY+Q9VmGGd2
         s1hy05Krg936YFxuPZoB4JH5rHIJ/BTuQrwHpUpIi9Nkz9hQviTDpQiK4XJSZQJK+GxL
         5F4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697619591; x=1698224391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLg1o9DOF3VnHtMnC8PASVDsIiegad5WKGOMGpmn+Ec=;
        b=VE84AxipUxfEWtxVXZq3BNEx5NdcbwrvQw5x4cAaYpK4LUu3clQIzZlNFtRPTk7R7l
         9zrgk3HWWT3BneRTdNm7krJIgtRdwaSVRq/Tna3Aj12SYYhILWzgyM/56Akm8VMpl13v
         4nmR0KVsqnbLmOwdfzmIYYPxdOKbGgVCZYCXiAc37zigfK8hfTW8BSAsGXdmxuSg5APC
         6KbQWapCr7TPZXc8OzA+NSpCgJbVDJ+JxBPWTdza/2YOKwKKnFarTtkDvUVUBpknSG5X
         8mnJ4NHymqnQgCMV29+zO777oRin+SQ871+doDMxDhUeAVIXXMsFOg1tGbWm0+WFlTNw
         JOFw==
X-Gm-Message-State: AOJu0YybcrhLaeuC+61KH6dNSsds1ZI46PtYUrMsm9ACxrb6y1Wt2jpE
        lB9wZp0PPLYlZS8tSj9KLLeOQ7ayddxGKMqfxSg=
X-Google-Smtp-Source: AGHT+IEwmg6hKMx5NyEARa7yEZGHlf4iBHwoIM3/a+e2XvCgZXkBJX5beUIBiBA4x9a5zAMY8Xeq9izSd5tpItfzcJI=
X-Received: by 2002:a05:6870:4202:b0:1d0:f5bd:6cf with SMTP id
 u2-20020a056870420200b001d0f5bd06cfmr5715015oac.43.1697619590829; Wed, 18 Oct
 2023 01:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230827023932.501102-1-sergio.paracuellos@gmail.com> <20231017155257.GA710773@dev-arch.thelio-3990X>
In-Reply-To: <20231017155257.GA710773@dev-arch.thelio-3990X>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 18 Oct 2023 10:59:39 +0200
Message-ID: <CAMhs-H8cLcHNX5yOinyYcHe8-wNS5sBk9sW9U913Lph_JQG_dA@mail.gmail.com>
Subject: Re: [PATCH v2] clk: ralink: mtmips: quiet unused variable warning
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-clk@vger.kernel.org, tsbogend@alpha.franken.de,
        sboyd@kernel.org, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        arnd@kernel.org, yangshiji66@outlook.com,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 5:53=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> On Sun, Aug 27, 2023 at 04:39:32AM +0200, Sergio Paracuellos wrote:
> > When CONFIG_OF is disabled then the matching table is not referenced an=
d
> > the following warning appears:
> >
> > drivers/clk/ralink/clk-mtmips.c:821:34: warning: unused variable 'mtmip=
s_of_match' [-Wunused-const-variable]
> > 821 |   static const struct of_device_id mtmips_of_match[] =3D {
> >     |                          ^
> >
> > There are two match tables in the driver: one for the clock driver and =
the
> > other for the reset driver. The only difference between them is that th=
e
> > clock driver uses 'data' and does not have 'ralink,rt2880-reset' compat=
ible.
> > Both just can be merged into a single one just by adding the compatible
> > 'ralink,rt2880-reset' entry to 'mtmips_of_match[]', which will allow it=
 to
> > be used for 'mtmips_clk_driver' (which doesn't use the data) as well as=
 for
> > 'mtmips_clk_init()' (which doesn't need get called for 'ralink,rt2880-r=
eset').
> >
> > Doing in this way ensures that 'CONFIG_OF' is not disabled anymore so t=
he
> > above warning disapears.
> >
> > Fixes: 6f3b15586eef ("clk: ralink: add clock and reset driver for MTMIP=
S SoCs")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202307242310.CdOnd2py-lkp=
@intel.com/
> > Suggested-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Thanks, Nathan!

Best regards,
    Sergio Paracuellos
>
> > ---
> > Changes in v2:
> > - Merge two match tables into one to properly avoid this warning.
> >
> > PATCH in v1: https://lore.kernel.org/lkml/20230802092647.3000666-1-serg=
io.paracuellos@gmail.com/T/
> >
> >  drivers/clk/ralink/clk-mtmips.c | 20 +++++---------------
> >  1 file changed, 5 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/clk/ralink/clk-mtmips.c b/drivers/clk/ralink/clk-m=
tmips.c
> > index 1e7991439527..50a443bf79ec 100644
> > --- a/drivers/clk/ralink/clk-mtmips.c
> > +++ b/drivers/clk/ralink/clk-mtmips.c
> > @@ -821,6 +821,10 @@ static const struct mtmips_clk_data mt76x8_clk_dat=
a =3D {
> >  };
> >
> >  static const struct of_device_id mtmips_of_match[] =3D {
> > +     {
> > +             .compatible =3D "ralink,rt2880-reset",
> > +             .data =3D NULL,
> > +     },
> >       {
> >               .compatible =3D "ralink,rt2880-sysc",
> >               .data =3D &rt2880_clk_data,
> > @@ -1088,25 +1092,11 @@ static int mtmips_clk_probe(struct platform_dev=
ice *pdev)
> >       return 0;
> >  }
> >
> > -static const struct of_device_id mtmips_clk_of_match[] =3D {
> > -     { .compatible =3D "ralink,rt2880-reset" },
> > -     { .compatible =3D "ralink,rt2880-sysc" },
> > -     { .compatible =3D "ralink,rt3050-sysc" },
> > -     { .compatible =3D "ralink,rt3052-sysc" },
> > -     { .compatible =3D "ralink,rt3352-sysc" },
> > -     { .compatible =3D "ralink,rt3883-sysc" },
> > -     { .compatible =3D "ralink,rt5350-sysc" },
> > -     { .compatible =3D "ralink,mt7620-sysc" },
> > -     { .compatible =3D "ralink,mt7628-sysc" },
> > -     { .compatible =3D "ralink,mt7688-sysc" },
> > -     {}
> > -};
> > -
> >  static struct platform_driver mtmips_clk_driver =3D {
> >       .probe =3D mtmips_clk_probe,
> >       .driver =3D {
> >               .name =3D "mtmips-clk",
> > -             .of_match_table =3D mtmips_clk_of_match,
> > +             .of_match_table =3D mtmips_of_match,
> >       },
> >  };
> >
> > --
> > 2.25.1
> >
