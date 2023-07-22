Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D38E75DD95
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 19:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjGVRHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 13:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGVRHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 13:07:15 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D9B1A7;
        Sat, 22 Jul 2023 10:07:14 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1ba2e911c24so1912226fac.0;
        Sat, 22 Jul 2023 10:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690045633; x=1690650433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aR5sCXAxQTVo6Nxobbh0jeRT3E3q1mjLjpUY2gBLFfI=;
        b=M6xNzvn9qfgjwampMqsk9kyRuUzW2Hl7DnmtUBeldISzPj5rnFeyHh73GDALYg6OMB
         +dfDw2XgA9KMSe2UupnN7DTu2KnpfdGNKMlkXNQpxJmEM5KdtFC1hHpO5jjZn8Kuc98t
         MBN33MHOrKHsmv2/n/O25rhZ1gwKSPcE77X5pobL1nBcJD/6U5bXC2VADhbaEaqPCddY
         pE/HBj7Xat55v/gUD8TsEmr5YLXOVECzl1VWoVJxX4fD5MPCl9fp5vrVDCG0L1LzlQN0
         5n3Ndx36Af7zKxSr2/+QDecxhf49rWN9mp6NTr89FqwacG6sldc8OO5sM1uroJ/Jxjei
         AYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690045633; x=1690650433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aR5sCXAxQTVo6Nxobbh0jeRT3E3q1mjLjpUY2gBLFfI=;
        b=Cuv+abSwDkhMPH8ESBdlHAoLIdZDSsIRh7SrrXAVQLJgfG/ADa7BVl7EZvTHFFu3i/
         5WRti7hLZCkHbMFYVp69fHn0URVOw8T1KGBLnHPb5SLB6xXe/7n4Ula+Q5sCTyFiN/a6
         k9mBLCYiJ/ExcR2RP1A6g9lefIwTaIcfNxgA2a5cR98hEuX+P1/wuEMy/bVJCGsBH5//
         UQOK3vjT5L3vHjsluuj337hsKaPmeCCRIlDCefDDim0DNJOaLDDCw2gIe5SqluI4eeui
         hi56t6YtEyNDVXFgBiulPVx7Zd8uwvdQZkEATVAyv+KzTIbMHDYR4F/TTmFJT5WHKwyb
         4CJg==
X-Gm-Message-State: ABy/qLZ6naFKZzDUyl/P9lf0nTQ2+K5pXxl1BnrMW80g0GMrgh5Q+q07
        ChDHlo3EpUix5o1L+sSKZekk1L6hifwlJrOD7BE=
X-Google-Smtp-Source: APBJJlGf12boWGa1Ok5FcHZ42bsj2uiFXxSgYW/GRxrbZhwgHnh1o7HA330OZXEQh8XFvImF/v+0qEkYHsn6d3M6X4M=
X-Received: by 2002:a05:6870:7026:b0:19a:2d23:4e32 with SMTP id
 u38-20020a056870702600b0019a2d234e32mr4404421oae.28.1690045633557; Sat, 22
 Jul 2023 10:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230721103350.3684483-1-james.hilliard1@gmail.com>
 <20230721103350.3684483-2-james.hilliard1@gmail.com> <3492152a-d668-54ba-7cb4-4db8bfec6f03@linaro.org>
 <CADvTj4r8oVyghXN_4ONMBfhMqHGNPJN517kB6X1FfwUmB16OFQ@mail.gmail.com> <ZLpu72xDla42x7J8@francesco-nb.int.toradex.com>
In-Reply-To: <ZLpu72xDla42x7J8@francesco-nb.int.toradex.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Sat, 22 Jul 2023 11:07:01 -0600
Message-ID: <CADvTj4op-CEmBrfZ6a2YkzPbZ42EbG7wCkwGbwgdS-FXKG2Qxg@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] ARM: dts: imx6qdl: Add Variscite VAR-SOM-MX6 SoM support
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 5:41=E2=80=AFAM Francesco Dolcini <francesco@dolcin=
i.it> wrote:
>
> On Fri, Jul 21, 2023 at 05:05:51AM -0600, James Hilliard wrote:
> > On Fri, Jul 21, 2023 at 4:43=E2=80=AFAM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > > On 21/07/2023 12:33, James Hilliard wrote:
> > > > +             compatible =3D "regulator-fixed";
> > > > +             regulator-name =3D "touch_3v3_supply";
> > > > +             regulator-always-on;
> > >
> > > Also, missing constraints.
> >
> > Hmm, what's the correct way to determine the constraint values?
>
> You should know/understand the hardware design. Normally when writing a
> DT file you have the hardware schematics and the relevant datasheets
> available.

I did find some datasheets/schematics, but I'm having trouble finding somet=
hing
which indicates it would be anything other than 3.3v there(although I don't=
 read
a lot of schematics in general so I might be missing something obvious):
https://www.variscite.com/wp-content/uploads/2017/12/VAR-SOM-MX6_v1-Datashe=
et.pdf
https://www.variscite.com/wp-content/uploads/2017/12/VAR-SOM-MX6_datasheet.=
pdf
https://www.variscite.com/wp-content/uploads/2017/12/VAR-MX6CustomBoard-Sch=
ematics-for-VAR-SOM-MX6_V1.pdf
https://www.variscite.com/wp-content/uploads/2017/12/V2_VAR-MX6CustomBoard-=
Schematics.pdf
https://www.variscite.com/wp-content/uploads/2017/12/VAR-MX6CustomBoard-Dat=
asheet.pdf

>
> > I'm guessing they should just be set to this based on the name?:
> > regulator-min-microvolt =3D <3300000>;
> > regulator-max-microvolt =3D <3300000>;
>
> This looks like a good guess, assuming that the regulator name is
> correct.

Tested with that but it didn't work, screen failed so I guess must be
something different?

>
> Francesco
>
