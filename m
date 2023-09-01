Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B445E78FC0A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjIALCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjIALCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:02:33 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1AFE42;
        Fri,  1 Sep 2023 04:02:31 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68becf931bfso1445126b3a.0;
        Fri, 01 Sep 2023 04:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693566151; x=1694170951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WaNPFWIWuliIYtcO+upyqNmV7l5WRS5CbnAo0TfGhaI=;
        b=FSjL0unoYVO0a+g5BFTG6ioL2nBczPBj5unBqyJeLfer6kJMjDG8Qcfpz7ij8GmTNt
         U9KhDLHRwiZGKmC/qJjfViPx7qt1aa9YNDcFWJgze8cebUCHaAEtQEG7la9Zzx741+Q8
         pJFuyIcp35LIqx2xuZSSk1tfSFBx70HIS80vLwQL5x782X1iq6lh59C0drnkgwF64DT3
         HVo744xStUFDtONi0FMlHViiw+WFqWvdOXh8NT2wd6oJ729M9+ij1nAJf2cYQLR2hWND
         X7hctyviJJUDgO+wqCBcuhdwjWAf90POq4NpkIzXS3N7QMNSqyK5PqV0QguXhRnF6ZyQ
         aWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693566151; x=1694170951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WaNPFWIWuliIYtcO+upyqNmV7l5WRS5CbnAo0TfGhaI=;
        b=RXU15kNJ926wfwOwg5wT8357o6kl+NF2+DI3WxuVV7oKUxQPloA5rbahFHquBjoNIy
         7dlamFUSR4Pbli0eEtxIgmHQa5tPmeL/sqxPTdSDFt/m24adt44VryAaXOnBCXdlWiNN
         d1eGrkmVXvvpBVjuSL04Gudzsyc/ckg0MvpbZwO/eE3JDQA9ufIjwwT7ilpJHKFUTuH7
         5kIxyZ4HJwCztFQe6JahcRuSc6WoBw96aWTsmkDccUItEUzLS6pZRQGrFfBQY9YeGdZe
         2Ti065lVADvh9mx66AzMkOsFBWv5/hnd+zuNVRMXD4pEGR/whfHzBcgyftXZjp5NOKWY
         lDuQ==
X-Gm-Message-State: AOJu0YxpXhSyBsF3JF2V9RSZBQ2ZN2bz6fuaD0hvbg9+h55dpCdqVHxA
        NMeic5/lHfrGCEmgKAmrU3MQoHUYkw6kNT2q7fs=
X-Google-Smtp-Source: AGHT+IFR9WW+K2rsaZpP9M4Fkt6GT9Xl6X3fTDiodA1ldxcB7wireh9+kRbbrOLiSNS+b+bt4K8sr9Nau/KfboR+C8c=
X-Received: by 2002:a17:90a:6096:b0:262:ceaa:1720 with SMTP id
 z22-20020a17090a609600b00262ceaa1720mr1845394pji.5.1693566150530; Fri, 01 Sep
 2023 04:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230831044431.250338-1-aford173@gmail.com> <99204fbf-3246-6124-2e35-bdc353d7e7b6@denx.de>
In-Reply-To: <99204fbf-3246-6124-2e35-bdc353d7e7b6@denx.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 1 Sep 2023 06:02:17 -0500
Message-ID: <CAHCN7xJGGSaO949=u2W6jybdE5R1dE8ihdP9wSrCgk5+9=9H6g@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] arm64: dts: imx8mp: Add easrc node
To:     Marek Vasut <marex@denx.de>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 4:52=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 8/31/23 06:44, Adam Ford wrote:
> > The i.MX8MP has an asynchronous sample rate converter which seems
> > to be the same as what is available on the i.MX8M Nano.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> > V3:  No Change.  The dt-binding update was already accepted into the so=
und tree, so that patch
> >       was dropped from the series
> >
> > V2:  No Change.
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boo=
t/dts/freescale/imx8mp.dtsi
> > index 83d907294fbc..3167706d81e1 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -1459,6 +1459,26 @@ sai7: sai@30c80000 {
> >                                       interrupts =3D <GIC_SPI 111 IRQ_T=
YPE_LEVEL_HIGH>;
> >                                       status =3D "disabled";
> >                               };
> > +
> > +                             easrc: easrc@30c90000 {
> > +                                     compatible =3D "fsl,imx8mp-easrc"=
, "fsl,imx8mn-easrc";
> > +                                     reg =3D <0x30c90000 0x10000>;
> > +                                     interrupts =3D <GIC_SPI 122 IRQ_T=
YPE_LEVEL_HIGH>;
> > +                                     clocks =3D <&audio_blk_ctrl IMX8M=
P_CLK_AUDIOMIX_ASRC_IPG>;
> > +                                     clock-names =3D "mem";
> > +                                     dmas =3D <&sdma2 16 23 0> , <&sdm=
a2 17 23 0>,
> > +                                            <&sdma2 18 23 0> , <&sdma2=
 19 23 0>,
> > +                                            <&sdma2 20 23 0> , <&sdma2=
 21 23 0>,
> > +                                            <&sdma2 22 23 0> , <&sdma2=
 23 23 0>;
> > +                                     dma-names =3D "ctx0_rx", "ctx0_tx=
",
> > +                                                 "ctx1_rx", "ctx1_tx",
> > +                                                 "ctx2_rx", "ctx2_tx",
> > +                                                 "ctx3_rx", "ctx3_tx";
> > +                                     firmware-name =3D "imx/easrc/easr=
c-imx8mn.bin";
>
> Should the firmware name really be imx8mn or should it be imx8mp ?

The firmware blobs provided by NXP only has easrc-imx8mn.bin and would
be concerned that having a different name might confuse people if they
try to go look for it and they only find easrc-imx8mn.bin.  To me,
this is no different than the SDMA driver using firmware called
sdma-imx7d.bin

>
> I think the later is better, you can always add a symlink for the
> firmware name, and you can discern mx8mn/mp firmwares on the same rootfs
> in case that was ever needed in the future.
