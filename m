Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47187B2557
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjI1Seu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjI1Ses (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:34:48 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E3ABF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 11:34:45 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7ae0da3a692so2238227241.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 11:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695926085; x=1696530885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHIi3+QPsqXjSO/wlLFP4QrQOZ0gG9LZj95iau1h3Hk=;
        b=WmJSO95BvZlz/TDfhBvT52BQSJpsUaz/lsN2mmwZgmSv/CukQ5obBBgPa97KNgKAez
         UHBzMOHDGjBQ+rjEm1wRbbeYZeaVcIpf8JYJDgX8cJSR8pc6rGaXabWgitfx0hLtfBLm
         03CEUNktbIcNjgC85hOyMI8SMrWkx4M5qVSTFaLZL/55GdoU2LKB8wkhEsJi+q1Qds0v
         x4tLy8t7y6eV2bobU3g7IbOAHrO+fp7X5wRWitULdvIzm640y3fHQkongNQdEXRig/2z
         tY+5bQCACwvqHshQ09fTP25u+CoV0+R8R7O+jxzvtHo/lei2yPg2pjMoLmE5VWVXDM21
         vPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695926085; x=1696530885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHIi3+QPsqXjSO/wlLFP4QrQOZ0gG9LZj95iau1h3Hk=;
        b=JvOxvpmlLzjnbo8cTP3kfimcetwOG30gnm84j3ED3aP90/yF1uD8C2+cTgWwcmlFnC
         nwOqppPXU5cuLGteANGJSrFeA6eY/7H+gwmwRv3t3xVCi13UOfRCIzDtWjgALfXieVxJ
         xqdUqs7esMlOGeyxgjgzO1WjhhPqPdVpKdo6UCAU5+Rl0Xd24Nc/glpHI8BGRbGXTQSt
         ql8p9Nn5ik0Rudzovsgh8X0jBcrynpZS4+3GiCsWcI1ybsESb3lz8lLe9UqSQ3zJTE+S
         c/9A7L8Zv3omnxwQ9u6GwIhoUPTosjvCuL3o9DGkAYJDBSeR2Obrd7SL1L8zln4ltnXQ
         8N4g==
X-Gm-Message-State: AOJu0Yzj1bHerQO/UU8WgQ8FNYHKTPW3+IaFAecpklc9Uk6Z0MpqBPxY
        yM81Trm99oW8u+ct71ehEXCa0V/JkvdG3sLx1NLwFQ==
X-Google-Smtp-Source: AGHT+IFfrPviHFnqrsRkwxjM9DAezDyiIX28xKmpqMoiafFuHKCE4W2aBDxuAO+GvkGaHwv1eHIWt8Ff6Dq8HvmxDMM=
X-Received: by 2002:a05:6102:212:b0:44e:9113:ac58 with SMTP id
 z18-20020a056102021200b0044e9113ac58mr1677855vsp.6.1695926084825; Thu, 28 Sep
 2023 11:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230911094604.14179-1-brgl@bgdev.pl> <CAMRc=Mc2Yo61uivOWHagR2Raxh11dBb=S6jtCDu8_-csX3ozvw@mail.gmail.com>
 <04e28f8a-1393-d991-264c-b0592746c123@nvidia.com> <CAMRc=MfMdMJXS1Yh_T-Ke+0U3ZC-oZhb2hJqb_g1wgO2s+7JAQ@mail.gmail.com>
 <2fd6d2a4-d8a4-f763-2f31-00709c7d3603@nvidia.com>
In-Reply-To: <2fd6d2a4-d8a4-f763-2f31-00709c7d3603@nvidia.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 28 Sep 2023 20:34:34 +0200
Message-ID: <CAMRc=Me+k1UbjF6Hn1+gOGiNoZb4UZ444S7me4AOiw2VOLMp1g@mail.gmail.com>
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

On Thu, Sep 28, 2023 at 7:36=E2=80=AFPM Dipen Patel <dipenp@nvidia.com> wro=
te:
>
> On 9/27/23 11:53 PM, Bartosz Golaszewski wrote:
> > On Thu, Sep 28, 2023 at 5:31=E2=80=AFAM Dipen Patel <dipenp@nvidia.com>=
 wrote:
> >>
> >> On 9/25/23 1:37 AM, Bartosz Golaszewski wrote:
> >>> On Mon, Sep 11, 2023 at 11:46=E2=80=AFAM Bartosz Golaszewski <brgl@bg=
dev.pl> wrote:
> >>>>
> >>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>>
> >>>> Allow building all HTE modules with COMPILE_TEST Kconfig option enab=
led.
> >>>>
> >>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >>>> ---
> >>>> This was part of a wider series but since this is independent, I'm s=
ending
> >>>> it separately.
> >>>>
> >>>>  drivers/hte/Kconfig | 4 ++--
> >>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/hte/Kconfig b/drivers/hte/Kconfig
> >>>> index cf29e0218bae..083e67492bf2 100644
> >>>> --- a/drivers/hte/Kconfig
> >>>> +++ b/drivers/hte/Kconfig
> >>>> @@ -16,7 +16,7 @@ if HTE
> >>>>
> >>>>  config HTE_TEGRA194
> >>>>         tristate "NVIDIA Tegra194 HTE Support"
> >>>> -       depends on ARCH_TEGRA_194_SOC
> >>>> +       depends on (ARCH_TEGRA_194_SOC || COMPILE_TEST)
> >>>>         help
> >>>>           Enable this option for integrated hardware timestamping en=
gine also
> >>>>           known as generic timestamping engine (GTE) support on NVID=
IA Tegra194
> >>>> @@ -25,7 +25,7 @@ config HTE_TEGRA194
> >>>>
> >>>>  config HTE_TEGRA194_TEST
> >>>>          tristate "NVIDIA Tegra194 HTE Test"
> >>>> -        depends on HTE_TEGRA194
> >>>> +        depends on (HTE_TEGRA194 || COMPILE_TEST)
> >>>>          help
> >>>>           The NVIDIA Tegra194 GTE test driver demonstrates how to us=
e HTE
> >>>>           framework to timestamp GPIO and LIC IRQ lines.
> >>>> --
> >>>> 2.39.2
> >>>>
> >>>
> >>> Hi Dipen!
> >>>
> >>> Any comments on this, the other patch with a comment update as well a=
s
> >>> the one addressing usage of gpiochip_find() in HTE drivers?
> >> Sorry for the late response, This looks good to me. I will review and =
test
> >> rest other patches.
> >>
> >>>
> >>> Bart
> >> Acked-by: Dipen Patel <dipenp@nvidia.com>
> >
> > Do you want me to take it through the GPIO tree or your own? Either
> > way no GPIO patches depend on it.
> This patch I should be able to push, assuming it is for 6.7 timeframe. Do=
 other HTE patches depend on
> any of your GPIO patches?
>
> >
> > Bart
>

Only this one needs GPIO changes:

    https://lore.kernel.org/lkml/20230905185309.131295-15-brgl@bgdev.pl/

Bart
