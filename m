Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E007B1363
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjI1Gxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjI1Gxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:53:42 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEC5199
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 23:53:40 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7ab68ef45e7so3708500241.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 23:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695884019; x=1696488819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xruzTjy5WcrjBjJM07hHvhKt83Q4GJyyiDox0uwU38Q=;
        b=OQgo6Lut8iManiA1nKTijxf/er6GqVALk206IZbvQyoVm5mFRNVI1MEJ/whSw4OzBB
         mcAUYW4gLWoO/70nn9MF4MUkCxMPTOAHOY3yAzpTFkBD9YLQ6CLnFURy7sZ7M1J3JDJk
         9wTnwLpjG86+a7CETBp2FugQW+bShevgFlV0w/1MBOFJyuHvQWH5gKw8qTDNASg0XmkY
         dYLKZzDBN88Ei6HklevTvKWhpVh49E4ZQ921QHKFyx1YgUtCGJ9VlWmIA06f5Xpv5n9g
         y6SCj9K7PECKm4gMeacb0SYknCVaBdGakSW3JKgvnC9aq+x1gsKkQg4d0HSMiGEZAUQk
         Q5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695884019; x=1696488819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xruzTjy5WcrjBjJM07hHvhKt83Q4GJyyiDox0uwU38Q=;
        b=ZGFGcGOopgTe+5r/dqkhA+WvQO1/LCkQs4ZR1kr7dhApkAg0UdqybwMrD1FpojBxOF
         6J1gpOXeHhunpWwivXozG+aq4Zc+a4OU/T6IVSeGltb56e8JtqIKlyW5969siLlnitgw
         mTb9jdWvtuxVHrfydntQKzkTjCiATY+y2iFpKAdbJa2lUMxQgYyuwT6clcpicqBeVD1Q
         zVWMK+Or4fSkGXA90cRgmTxs7yqM9AMpPIvaMi8CvuU2Wcowd8kp6BE1t+zsKBnOn+x2
         1AlsFtLae57svmVz0vRNmVtVNNwOQdGnP1zASYTjr+qj9LzRXUMYnEuSiCbIvyZiBQUG
         JIPA==
X-Gm-Message-State: AOJu0Yz4wHBgiDnGGECNIjP/570fd2FKEJ+otgnHYSonucIuTLrRTeP8
        NBN6SZq1YBMqkX/0bKyTu/bMm92V20XHM6gzdgKWVw==
X-Google-Smtp-Source: AGHT+IGmpqBATbpH3HYGIvHr4Z0rnOb696RLx0AZUozA1C7yBAZM81V3kAkXcXeXka2AnmIqzMZzFqmqtc5v75s2tA0=
X-Received: by 2002:a05:6102:212:b0:44e:9113:ac58 with SMTP id
 z18-20020a056102021200b0044e9113ac58mr207356vsp.6.1695884019642; Wed, 27 Sep
 2023 23:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230911094604.14179-1-brgl@bgdev.pl> <CAMRc=Mc2Yo61uivOWHagR2Raxh11dBb=S6jtCDu8_-csX3ozvw@mail.gmail.com>
 <04e28f8a-1393-d991-264c-b0592746c123@nvidia.com>
In-Reply-To: <04e28f8a-1393-d991-264c-b0592746c123@nvidia.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 28 Sep 2023 08:53:28 +0200
Message-ID: <CAMRc=MfMdMJXS1Yh_T-Ke+0U3ZC-oZhb2hJqb_g1wgO2s+7JAQ@mail.gmail.com>
Subject: Re: [PATCH] hte: allow building modules with COMPILE_TEST enabled
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     timestamp@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 5:31=E2=80=AFAM Dipen Patel <dipenp@nvidia.com> wro=
te:
>
> On 9/25/23 1:37 AM, Bartosz Golaszewski wrote:
> > On Mon, Sep 11, 2023 at 11:46=E2=80=AFAM Bartosz Golaszewski <brgl@bgde=
v.pl> wrote:
> >>
> >> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>
> >> Allow building all HTE modules with COMPILE_TEST Kconfig option enable=
d.
> >>
> >> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >> ---
> >> This was part of a wider series but since this is independent, I'm sen=
ding
> >> it separately.
> >>
> >>  drivers/hte/Kconfig | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/hte/Kconfig b/drivers/hte/Kconfig
> >> index cf29e0218bae..083e67492bf2 100644
> >> --- a/drivers/hte/Kconfig
> >> +++ b/drivers/hte/Kconfig
> >> @@ -16,7 +16,7 @@ if HTE
> >>
> >>  config HTE_TEGRA194
> >>         tristate "NVIDIA Tegra194 HTE Support"
> >> -       depends on ARCH_TEGRA_194_SOC
> >> +       depends on (ARCH_TEGRA_194_SOC || COMPILE_TEST)
> >>         help
> >>           Enable this option for integrated hardware timestamping engi=
ne also
> >>           known as generic timestamping engine (GTE) support on NVIDIA=
 Tegra194
> >> @@ -25,7 +25,7 @@ config HTE_TEGRA194
> >>
> >>  config HTE_TEGRA194_TEST
> >>          tristate "NVIDIA Tegra194 HTE Test"
> >> -        depends on HTE_TEGRA194
> >> +        depends on (HTE_TEGRA194 || COMPILE_TEST)
> >>          help
> >>           The NVIDIA Tegra194 GTE test driver demonstrates how to use =
HTE
> >>           framework to timestamp GPIO and LIC IRQ lines.
> >> --
> >> 2.39.2
> >>
> >
> > Hi Dipen!
> >
> > Any comments on this, the other patch with a comment update as well as
> > the one addressing usage of gpiochip_find() in HTE drivers?
> Sorry for the late response, This looks good to me. I will review and tes=
t
> rest other patches.
>
> >
> > Bart
> Acked-by: Dipen Patel <dipenp@nvidia.com>

Do you want me to take it through the GPIO tree or your own? Either
way no GPIO patches depend on it.

Bart
