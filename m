Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDB77D4BD3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbjJXJUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjJXJU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:20:27 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B30D79
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:20:25 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-5079f6efd64so5909594e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698139223; x=1698744023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lr0fZE5whQdrFV4eAi6FdmCNxpQ+X4q7C3SQAfAKz58=;
        b=c5kN7qanRr3oN7DJaizP5UoJadl5zCdES8ZL99fxxBb8HrxUJx3bsaYPHVDMnreob1
         sIEeVDDHIYkODfZtctVyAXs6NmcFUtHoVgTc0/1kDA/fq0RZfX5Y8sxITyYVslc0FS2l
         4f6SEn6wVX8wjyGV3eBeqKx3eoAzXpEJuhUWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698139223; x=1698744023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lr0fZE5whQdrFV4eAi6FdmCNxpQ+X4q7C3SQAfAKz58=;
        b=egWC+jVu/gnLj1CTZwlrpqHtxeTtRxs78oQscOWwhNB2fvXAvmq99opH1kVsGSYbjC
         umnyEXlO+Qqsw/VP0ZHOX9nikCSETThOJ7GoicZTspTq+8iVXugByEODEoRbL/Raq9Q+
         5Qp7d73LjVrY4PLPcDYGTPKNzuADWnZm5OEnmpGh52yPunYCwMathybbE8zSQ2oFg938
         AAXQPRLz9FzjLvgJWEy7f4s8JLGm4q4cotSYhWsYYH75SgMnKL7n89yD9UgapvbRd/vP
         Z5ijl7HSXti46m+O39ztDCKgj77LEMoF9k5eSQf786LjqZJ36wJWqqEhD6NV78bdlRdL
         ZRkQ==
X-Gm-Message-State: AOJu0Yz9pYtaDdG8Ham74Pw58vZhPSPmwxaIaeD0Bt0fOirdwPbhH2ZA
        k0E9xm8hsdCOw/BVKPeA29XsCW5KZqjJFFBaRKtBjQ==
X-Google-Smtp-Source: AGHT+IFTV/kMgT6B5ttsp9pPqwDV0yzNxuvadJ1z0YSqmADystKSt3gJ1x4Zf3Z0DIC+EwhjiAYsW2oerWQNqAW0S2k=
X-Received: by 2002:a19:5011:0:b0:507:9a08:61d7 with SMTP id
 e17-20020a195011000000b005079a0861d7mr7752247lfb.34.1698139223027; Tue, 24
 Oct 2023 02:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231019124914.13545-1-angelogioacchino.delregno@collabora.com>
 <CAGXv+5H0rUajeU-i8nYyV2xWFQTnzqxioZCCyyP_RZXKqmcugQ@mail.gmail.com>
 <283d18028590d57025e5654d18b8b5b7.sboyd@kernel.org> <CAGXv+5EpBLnXVdxnk9wBZi5F7U5wdJRfYH7fgg4Lkr1HJXm+WA@mail.gmail.com>
 <9c1e10b56db315e03daa3df5918cde844297c680.camel@mediatek.com>
In-Reply-To: <9c1e10b56db315e03daa3df5918cde844297c680.camel@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 24 Oct 2023 17:20:11 +0800
Message-ID: <CAGXv+5HQ2sVx=F3my2jOGMw3j3pU2aarEg+Dj1XgNzwio98ezA@mail.gmail.com>
Subject: Re: [PATCH] clk: mediatek: mt8186: Change I2C 4/5/6 ap clocks parent
 to infra
To:     =?UTF-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= 
        <Yu-chang.Lee@mediatek.com>
Cc:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        =?UTF-8?B?Q2h1bi1KaWUgQ2hlbiAo6Zmz5rWa5qGAKQ==?= 
        <Chun-Jie.Chen@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <Miles.Chen@mediatek.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 3:47=E2=80=AFPM Yu-chang Lee (=E6=9D=8E=E7=A6=B9=E7=
=92=8B)
<Yu-chang.Lee@mediatek.com> wrote:
>
> On Tue, 2023-10-24 at 10:58 +0800, Chen-Yu Tsai wrote:
> > On Tue, Oct 24, 2023 at 10:52=E2=80=AFAM Stephen Boyd <sboyd@kernel.org=
>
> > wrote:
> > >
> > > Quoting Chen-Yu Tsai (2023-10-19 22:06:35)
> > > > On Thu, Oct 19, 2023 at 8:49=E2=80=AFPM AngeloGioacchino Del Regno
> > > > <angelogioacchino.delregno@collabora.com> wrote:
> > > > >
> > > > > Fix the parenting of clocks imp_iic_wrap_ap_clock_i2c{4-6}, as
> > > > > those
> > > > > are effectively parented to infra_ao_i2c{4-6} and not to the
> > > > > I2C_AP.
> > > > > This permits the correct (and full) enablement and disablement
> > > > > of the
> > > > > I2C4, I2C5 and I2C6 bus clocks, satisfying the whole clock tree
> > > > > of
> > > > > those.
> > > > >
> > > > > As an example, when requesting to enable
> > > > > imp_iic_wrap_ap_clock_i2c4:
> > > > >
> > > > > Before: infra_ao_i2c_ap -> imp_iic_wrap_ap_clock_i2c4
> > > > > After:  infra_ao_i2c_ap -> infra_ao_i2c4 ->
> > > > > imp_iic_wrap_ap_clock_i2c4
> > > > >
> > > > > Fixes: 66cd0b4b0ce5 ("clk: mediatek: Add MT8186 imp i2c wrapper
> > > > > clock support")
> > > > > Signed-off-by: AngeloGioacchino Del Regno <
> > > > > angelogioacchino.delregno@collabora.com>
> > > >
> > > > I'm curious about what led to discovering this error?
> > > >
> > >
> > > Is that an acked-by?
> >
> > MediaTek engineers are saying the original code already matches the
> > documentation provided by their hardware engineers. I'm trying to get
> > them to respond on the mailing list.
> >
> > ChenYu
> >
> After checking with I2C clock hardware designer there is no
> infra_ao_i2c{4-6} clock gate in between. And the clock document at hand
> aslo shows the same result. Generallly speaking, we would like to keep
> sw setting align with the hardware design document. I would recommand
> not to change this part of code, but enable infra_ao_i2c{4-6} prior to
> the usage of imp_iic_wrap_ap_clock_i2c clock.

Are infra_ao_i2c{4-6} actually used by the hardware? If so, for what purpos=
e?
If it is actually needed by the hardware and it is not in the existing path=
,
then it needs to be described in the device tree and handled by the driver.

ChenYu
