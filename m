Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53BB769AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjGaPW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGaPW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:22:26 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C34A10E3;
        Mon, 31 Jul 2023 08:22:25 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b962c226ceso67748611fa.3;
        Mon, 31 Jul 2023 08:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690816944; x=1691421744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2I2XlloNGmKuxVxE6pKOqgLTGqBQKWwmgKZfx+QruRY=;
        b=rpYrkLP4Y8+1qUUfAV+PptQg1XOnyI36VXs8D3qJDc9qDJ0yUBGB93VUz8f5khHAJG
         kiu7W5hFqpFYAlXT37+i6cVE82BM8waYCeaetlzVG94esLTDkcziri0cPH1gHRYzfWOX
         rf1jBkl18FoVLCzoECthSVczIF5ZzHKGZaChqtQYa+zIMvqTSvU4hB0LIDQ+GqMRKiJe
         7oRNSB6m7pflwgzI58KlDsxvMG2kz8bmUF9sbhPnVqzmIXDi2jDdnqEPvuOSTGD5iPF3
         MI1aLE/d/3ZlGvebKQM8Q+vYC/n8A4AM6n7qSLvSNX4lJTr//L/9FRtpm3pKdHduQ1BN
         ygkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690816944; x=1691421744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2I2XlloNGmKuxVxE6pKOqgLTGqBQKWwmgKZfx+QruRY=;
        b=imt3Iv/zgTOtS8/rMZfTd7y7wpyWl+HQ57+/j37q7HqwIyTN/2G7YT7/fMM5HTHX9n
         s9QBAOzVtSiQxHVS4F5OWSpXEHqw5YInHrRK+SEtwHnsHvv4vFTxfvGnmL8HnUEfkUnf
         vGlXkkDlIfOcqcuhPcLywdyRiCD60kSxFu9qlWj6E/qWJCtK9Vh0LD/5LtW4wTaqLgCu
         CIgqVWw9aEQTS3QsCuoAqh7YOTjs9alGUcpjW2OG/nba8nxxJi7dcOVdeJ81FCi0x9J5
         L5byMNWTqahZPoi+cTGZ2336WiCtNsSD3hZgPr6AqE/7pAKmNTne3VDRbjWA920K7uxH
         umtw==
X-Gm-Message-State: ABy/qLYl+pWmc8CoptxS2LW1eRuP4w1o0pNN5RjxwDvSqNtgOsPsRX5B
        cj6CJ3DciHPMsIecTj7VhtCK0ZpP64FnXHp/bZRN62FNoJFkaw==
X-Google-Smtp-Source: APBJJlGQ9izbwIrNbdEstsW1RMxfgp3nEoOpX5PUx15pIyA8vmZ/Y8AdE625q8ChWAjJZ0sdhbYfcpTO5r6kLsvmv08=
X-Received: by 2002:a2e:86c8:0:b0:2b9:e304:5f81 with SMTP id
 n8-20020a2e86c8000000b002b9e3045f81mr238576ljj.23.1690816943059; Mon, 31 Jul
 2023 08:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230624131632.2972546-1-bigunclemax@gmail.com>
 <20230624131632.2972546-4-bigunclemax@gmail.com> <10311404.nUPlyArG6x@jernej-laptop>
In-Reply-To: <10311404.nUPlyArG6x@jernej-laptop>
From:   Maxim Kiselev <bigunclemax@gmail.com>
Date:   Mon, 31 Jul 2023 18:22:11 +0300
Message-ID: <CALHCpMgXy0pLiVR8V48Roi82EJ7Zrx-Xyc-6etjgkmN0B7pb8A@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] riscv: dts: allwinner: d1: Add QSPI pins node for
 pinmux PC port
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Mark Brown <broonie@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=BF=D0=BD, 31 =D0=B8=D1=8E=D0=BB. 2023=E2=80=AF=D0=B3. =D0=B2 01:30, Jer=
nej =C5=A0krabec <jernej.skrabec@gmail.com>:
>
> Dne sobota, 24. junij 2023 ob 15:16:24 CEST je Maksim Kiselev napisal(a):
> > Add pinmux node that describes pins on PC port which required for
> > QSPI mode.
> >
> > Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> > ---
> >  arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> > b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi index
> > 1bb1e5cae602..9f754dd03d85 100644
> > --- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> > +++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> > @@ -131,6 +131,13 @@ uart3_pb_pins: uart3-pb-pins {
> >                               pins =3D "PB6", "PB7";
> >                               function =3D "uart3";
> >                       };
> > +
> > +                     /omit-if-no-ref/
> > +                     qspi0_pc_pins: qspi0-pc-pins {
> > +                             pins =3D "PC2", "PC3", "PC4", "PC5",
> "PC6",
> > +                                    "PC7";
> > +                             function =3D "spi0";
> > +                     };
>
> Sorry for late review, but it seems I'm missing something. D1 manual says
> those are pins for ordinary SPI, with HOLD and WP signals. Can they be
> repurposed for quad SPI?
>
Yes, they can. Here is a quote from D1 datasheet (9.3.3.8 SPI
Quad-Input/Quad-Output Mode):
"Using the quad mode allows data to be transferred to or from the
device at 4 times the rate of standard single mode, the data can be
read
at fast speed using four data bits (MOSI, MISO, IO2 (WP#) and IO3
(HOLD#)) at the same time."
