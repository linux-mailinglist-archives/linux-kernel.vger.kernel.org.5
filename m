Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9CA77A4E9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 06:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjHMETB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Aug 2023 00:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHMES7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 00:18:59 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D3A10F9;
        Sat, 12 Aug 2023 21:19:02 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-63d10da0f26so23327656d6.3;
        Sat, 12 Aug 2023 21:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691900341; x=1692505141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HI593M9zMN8epqOMj2ahalMMsfEOiEZNyKM6XMUdoUI=;
        b=jGIQqWqCrr/m7Rvt2JvowGL1TWp7QrRSfQ4/Yf+c6Up8vkvLoyHi6xdVdOh1YBU2k2
         sbdXvmbmR13OeMY53RJ1R2NHM+4Zg575E2ddwpYl1QIPGXRXN/8yek+YaNpAge58UMjT
         mGVK1MN8XrxWvVXKI+ZDbTiIBPqiC/6qI5oPhAmaPbikuqUL10gIngwRoiNvtbCsBthH
         KTlbTqCN/IZs40MkILmNi2xoumvy68y/r9EaaF+J0JSBHi7CRLd+GOu3io0uDr9Zl++V
         QydDnTxVJmlkCIQJ4xYNaNryup+Nds8gmFxEzjAKgeSW2aENeZgfCeyHqiwG5h3L1OWd
         WuSQ==
X-Gm-Message-State: AOJu0Yz1eHrzKfdEBWFkaYxMahWFLtzofTP6p7DRJ8N8KpAjCjZZXwoF
        sgkZVq//zPxAeigPjnks45Pwcp0K6t6ngety
X-Google-Smtp-Source: AGHT+IGqPjLev/uq/p6MhGyGKxjJZVgiXhB5xVCeuXOf9CE9DYvB4d144/fCEnQCbO0F6HgdKCxXcw==
X-Received: by 2002:ad4:4521:0:b0:633:45e2:5603 with SMTP id l1-20020ad44521000000b0063345e25603mr5973829qvu.60.1691900341507;
        Sat, 12 Aug 2023 21:19:01 -0700 (PDT)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com. [209.85.219.48])
        by smtp.gmail.com with ESMTPSA id n4-20020a0ce544000000b00636e767d445sm2362553qvm.62.2023.08.12.21.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Aug 2023 21:19:00 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6430bf73e1cso11969086d6.0;
        Sat, 12 Aug 2023 21:19:00 -0700 (PDT)
X-Received: by 2002:a17:902:e741:b0:1bb:8e13:deba with SMTP id
 p1-20020a170902e74100b001bb8e13debamr7297585plf.11.1691900000803; Sat, 12 Aug
 2023 21:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230731023701.2581713-1-contact@jookia.org> <3248110.44csPzL39Z@jernej-laptop>
In-Reply-To: <3248110.44csPzL39Z@jernej-laptop>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 13 Aug 2023 12:13:09 +0800
X-Gmail-Original-Message-ID: <CAGb2v66g1On2uy0_15ZA5-uXcrLSg7V-tsw8zLo=tUY_HUW00g@mail.gmail.com>
Message-ID: <CAGb2v66g1On2uy0_15ZA5-uXcrLSg7V-tsw8zLo=tUY_HUW00g@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: allwinner: d1: Specify default CAN pins
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     linux-sunxi@lists.linux.dev, John Watts <contact@jookia.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mkl@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 4:59 AM Jernej Škrabec <jernej.skrabec@gmail.com> wrote:
>
> /cc Marc
>
> Dne ponedeljek, 31. julij 2023 ob 04:36:59 CEST je John Watts napisal(a):
> > There are only one set of CAN pins available on these chips.
> > Specify these as the default to avoid redundancy in board device trees.
> >
> > Signed-off-by: John Watts <contact@jookia.org>
> > ---
> >  arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> > b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi index
> > 4086c0cc0f9d..b27c3fc13b0d 100644
> > --- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> > +++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> > @@ -898,6 +898,8 @@ can0: can@2504000 {
> >                       interrupts = <SOC_PERIPHERAL_IRQ(21)
> IRQ_TYPE_LEVEL_HIGH>;
> >                       clocks = <&ccu CLK_BUS_CAN0>;
> >                       resets = <&ccu RST_BUS_CAN0>;
> > +                     pinctrl-names = "default";
> > +                     pinctrl-0 = <&can0_pins>;
> >                       status = "disabled";
> >               };
>
> pinctrl-names and pinctrl-0 are usually at the top. However, since there is no
> hard rule (I've seen it mixed), I'm fine with it.

AFAIK this only applies to board files where there are mostly none of the
resource (clocks, reg, resets, interrupts) properties. OOTH the compatible
property is always the first property. I would normally put the pinctrl
stuff after the internal resources, since it is an external property.
In the SoC dtsi files, they would end up after the resource properties
I mentioned above, and before the "status" property.

ChenYu

> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>
> Since original DT node entry goes through netdev tree, this should be picked
> there or it can be dropped there and I pick both patches or I can pick patch
> for later kernel version.
>
> Best regards,
> Jernej
>
> >
> > @@ -907,6 +909,8 @@ can1: can@2504400 {
> >                       interrupts = <SOC_PERIPHERAL_IRQ(22)
> IRQ_TYPE_LEVEL_HIGH>;
> >                       clocks = <&ccu CLK_BUS_CAN1>;
> >                       resets = <&ccu RST_BUS_CAN1>;
> > +                     pinctrl-names = "default";
> > +                     pinctrl-0 = <&can1_pins>;
> >                       status = "disabled";
> >               };
> >       };
>
>
>
>
