Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547CC77A511
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 08:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjHMGPB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Aug 2023 02:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHMGPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 02:15:00 -0400
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0A4110;
        Sat, 12 Aug 2023 23:14:59 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1bc7e65ea44so22612155ad.1;
        Sat, 12 Aug 2023 23:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691907298; x=1692512098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PquNnrwc6lc8WzSRLbxFenC5bqhWO9QOMiyMhVomEDw=;
        b=T2C3D9/2fDYL1yyof7eqvAjtBSrYZkalfj1BcEI3OJu89FElbm3y0Hg84ivs67y28c
         t0VXDBgwbKNiKEY5FnWaFbAHV6LMQ2jpteyT9cVdzb/bxJuKqJ+0KS5XfwJNo2I0bwvB
         MteLmiH7aEaXEi5w6LYkItxBjrnPZ8FDMedwIH7HD33nYmgLJmC8CNxHrqF4wOLEby5G
         zcZVG4SaQpvyB6bXq5ZCebxWi1Yzq4+T160l27WK8hhdUGN9+AhSI534Seg24Fzs25vv
         U53I7PLa/1o8QupLmr6ETjEFBoDhN0P6t2c9hpMKvPedcYj+ywZC4/opgO45+S1jqGT3
         n89A==
X-Gm-Message-State: AOJu0YxpPxq5d14JTeeAbyG0FYQNPeHH+Xwg3y4/nYeJCpTHr9it+59M
        vFa/G7ywGC4rFv7NF4yQYkya/ltmVScBSA==
X-Google-Smtp-Source: AGHT+IE80TRdxKqcdGBb8hGqXg5fCCQidKAeolOOtZvbPCb7/Kl79iD/nibc8m32sBOP+ZHQsQ3B3g==
X-Received: by 2002:a17:902:f549:b0:1bd:d510:78fb with SMTP id h9-20020a170902f54900b001bdd51078fbmr2070651plf.3.1691907298184;
        Sat, 12 Aug 2023 23:14:58 -0700 (PDT)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com. [209.85.210.181])
        by smtp.gmail.com with ESMTPSA id i9-20020a170902eb4900b001bc5dc0cd75sm713611pli.180.2023.08.12.23.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Aug 2023 23:14:56 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-68730bafa6bso2959966b3a.1;
        Sat, 12 Aug 2023 23:14:54 -0700 (PDT)
X-Received: by 2002:a17:90a:e0f:b0:267:f8f4:73ab with SMTP id
 v15-20020a17090a0e0f00b00267f8f473abmr12065548pje.16.1691907294402; Sat, 12
 Aug 2023 23:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230807191952.2019208-1-contact@jookia.org> <CAGb2v66vqrNZ-ga-1O_bQ16BWXH=RmSHo2Kb+WHJyw-Nm1kWVg@mail.gmail.com>
 <ZNhau0j_tV3EXGxl@titan>
In-Reply-To: <ZNhau0j_tV3EXGxl@titan>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 13 Aug 2023 14:14:42 +0800
X-Gmail-Original-Message-ID: <CAGb2v647FoATnjk43GKqVihX-FtZN+7XrxMMRseuqap0MBg2FQ@mail.gmail.com>
Message-ID: <CAGb2v647FoATnjk43GKqVihX-FtZN+7XrxMMRseuqap0MBg2FQ@mail.gmail.com>
Subject: Re: [PATCH v3] riscv: dts: allwinner: d1: Add CAN controller nodes
To:     John Watts <contact@jookia.org>
Cc:     linux-sunxi@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 12:23 PM John Watts <contact@jookia.org> wrote:
>
> On Sun, Aug 13, 2023 at 12:17:27PM +0800, Chen-Yu Tsai wrote:
> > > Signed-off-by: John Watts <contact@jookia.org>
> > > ---
> > > Changes in v3:
> > > - Set default pinctrl for can controller
> > > - Moved can nodes to proper location
> > > - Moved can pins to proper location
> > >
> > >  .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 34 +++++++++++++++++++
> > >  1 file changed, 34 insertions(+)
> > >
> > > diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> > > index d59b4acf183a..24f2e70d5886 100644
> > > --- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> > > +++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> > > @@ -52,6 +52,18 @@ pio: pinctrl@2000000 {
> > >                         #gpio-cells = <3>;
> > >                         #interrupt-cells = <3>;
> > >
> > > +                       /omit-if-no-ref/
> >
> > Just FYI this likely ends up doing nothing if you also have them
> > referenced through a default pinctrl setting. They end up always
> > referenced and always included. For the D1 series it looks like no
> > peripheral has default pinctrl setting given.
> >
> > We can still keep it though. It would help when future chip variants
> > specify different pinmuxes.
>
> Oops, thanks for pointing that out. I'll try to avoid that mistake in future.
>
> > The compatible string should be the first property. In other sunxi SoC dtsi
> > files, we put the pinctrl just before the "status" property if it's present
> > to specify a default pin muxing.
>
> Oh that makes sense.
>
> >
> > I can fix it up while applying.
>
> Please do!

Applied. Please check here:

https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git/commit/?h=sunxi/dt-for-6.6&id=f05af44f691351bfd954f39ec376666dc5e1b869
