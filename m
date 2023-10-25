Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5239E7D66D9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjJYJcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjJYJcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:32:36 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241FF132
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:32:34 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-581ed744114so2193841eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1698226353; x=1698831153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JleXfSUkp+S9wegLsWLcm92sHQy5rJ9h3rjZTaRBvnc=;
        b=OYKclmbKyWktjRtAkSdXs0Ix/x913g4zDh6w1aAKWYDyoETuShoaQDTwZRVDQHd+Gw
         CnHsjqRK5LaLMAA8AlAAcnqAXfYx0sFYrsPuas4L1MzkwZY3PmBU5IOkJ8p5M++phScJ
         ITOfRQhfbkJTnv+Oq4YLbJpNqucExlUPOnfKEmGjyjOJkvE4dYT20QTGojo+x4O9cTH6
         TbS/bwLi+ER1idQxkedtbhJPOf2Y2It4ZfI+IRbAWOLXa5VUC8V10HjOjZziDRdDEkzg
         joB/EEcelncRdN+3/xlF9Bsj5ZyUdITd8RbjnbinHjPDMYfCgRmoOPJ5dUMDX+zeVQfK
         vLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698226353; x=1698831153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JleXfSUkp+S9wegLsWLcm92sHQy5rJ9h3rjZTaRBvnc=;
        b=nSorzgdXlu3KFwWURh/AxABHxKTyBs7JYktBpvaTUNZJS6srht40LekcEP0jcFR97y
         XKkUTlnsskGdqoUbj8ZrHlwEq+PqfH4d1y0TpJuYt946kV08Rce1KB57dWAiv4MxNRS2
         rMX3bZ4SZD4WmUUhZW9s7j4ceEYxMq8L2TWKwzsR4zFyQ2OfRl9Ypvwz/jwCj6/8LNWP
         bqWqS25xaGbCmPNnAHgSItz7oMHKprz4nu2clHzdnmk1cQ6NlczykLVqIz9Isjb1HrAR
         rXnYr+OoeOk0TDy2gUlR1nwXp6tY1xsPrJQR1TRvmQZ2fPIl/XhyrH+2ZVCG8kUrmDVM
         WpBw==
X-Gm-Message-State: AOJu0YxCz6j/yMvrT1Lv6IJP81iC7wKzkf7BchVtnugydVCeuGRcVSB5
        anqMDrocBqZctfaTBa2S3EsbFtkoIdHdAz+fD0zULg==
X-Google-Smtp-Source: AGHT+IGZxk2jV1lHWX15BuUJIJfzVkgZuAvuKKi7ENF8WnTrOGFD3ImZuACpY6oAzEWaSNmuZvMv8h2OzLOxHAoarhE=
X-Received: by 2002:a05:6870:1250:b0:1ea:fca:8ca2 with SMTP id
 16-20020a056870125000b001ea0fca8ca2mr12157627oao.56.1698226353289; Wed, 25
 Oct 2023 02:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231024101902.6689-1-nylon.chen@sifive.com> <20231024101902.6689-2-nylon.chen@sifive.com>
 <20231024-yin-coliseum-11f5e06fec14@spud>
In-Reply-To: <20231024-yin-coliseum-11f5e06fec14@spud>
From:   Nylon Chen <nylon.chen@sifive.com>
Date:   Wed, 25 Oct 2023 17:32:21 +0800
Message-ID: <CAHh=Yk_h_1r7ZG+yLK=SoK9AgPkestuQDH-CK621mz=X-PA+cQ@mail.gmail.com>
Subject: Re: [v5 1/2] riscv: dts: sifive: unleashed/unmatched: Remove PWM
 controlled LED's active-low properties
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, emil.renner.berthing@canonical.com,
        vincent.chen@sifive.com, greentime.hu@sifive.com,
        zong.li@sifive.com, nylon7717@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

Conor Dooley <conor@kernel.org> =E6=96=BC 2023=E5=B9=B410=E6=9C=8824=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8810:55=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hey,
>
> On Tue, Oct 24, 2023 at 06:19:01PM +0800, Nylon Chen wrote:
> > This removes the active-low properties of the PWM-controlled LEDs in
> > the HiFive Unmatched device tree.
> >
> > The reference is hifive-unleashed-a00.pdf[0] and hifive-unmatched-schem=
atics-v3.pdf[1].
> >
> > Link: https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7bf8=
453f8698_hifive-unleashed-a00-schematics-1.pdf [0]
> > Link: https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9e-e68c=
e76f4192_hifive-unmatched-schematics-v3.pdf [1]
>
> >
>
> This blank line should be removed if there is a follow-up.
thanks, I got it.
>
> > Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
>
> What did Vincent contribute to this patch? Are you missing a
> co-developed-by tag, perhaps?
Yes, Vincent was the first person to find the PWM driver problem, and
Zong Li helped me with the relevant review internally.

so in the next version, I will add the correct tags for these two developer=
s.

Thank you again for your time.
>
> > Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>
> I expect this to go via the pwm tree since this is going to "break" (in
> the loosest possible sense) existing systems if merged separately.
>
> Cheers,
> Conor.
>
> > ---
> >  arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts |  8 ++++----
> >  arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 12 ++++--------
> >  2 files changed, 8 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch=
/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> > index 900a50526d77..11e7ac1c54bb 100644
> > --- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> > +++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> > @@ -49,7 +49,7 @@ led-controller {
> >               compatible =3D "pwm-leds";
> >
> >               led-d1 {
> > -                     pwms =3D <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
> > +                     pwms =3D <&pwm0 0 7812500 0>;
> >                       active-low;
> >                       color =3D <LED_COLOR_ID_GREEN>;
> >                       max-brightness =3D <255>;
> > @@ -57,7 +57,7 @@ led-d1 {
> >               };
> >
> >               led-d2 {
> > -                     pwms =3D <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
> > +                     pwms =3D <&pwm0 1 7812500 0>;
> >                       active-low;
> >                       color =3D <LED_COLOR_ID_GREEN>;
> >                       max-brightness =3D <255>;
> > @@ -65,7 +65,7 @@ led-d2 {
> >               };
> >
> >               led-d3 {
> > -                     pwms =3D <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
> > +                     pwms =3D <&pwm0 2 7812500 0>;
> >                       active-low;
> >                       color =3D <LED_COLOR_ID_GREEN>;
> >                       max-brightness =3D <255>;
> > @@ -73,7 +73,7 @@ led-d3 {
> >               };
> >
> >               led-d4 {
> > -                     pwms =3D <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
> > +                     pwms =3D <&pwm0 3 7812500 0>;
> >                       active-low;
> >                       color =3D <LED_COLOR_ID_GREEN>;
> >                       max-brightness =3D <255>;
> > diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch=
/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> > index 07387f9c135c..b328ee80693f 100644
> > --- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> > +++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> > @@ -51,8 +51,7 @@ led-controller-1 {
> >               compatible =3D "pwm-leds";
> >
> >               led-d12 {
> > -                     pwms =3D <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
> > -                     active-low;
> > +                     pwms =3D <&pwm0 0 7812500 0>;
> >                       color =3D <LED_COLOR_ID_GREEN>;
> >                       max-brightness =3D <255>;
> >                       label =3D "d12";
> > @@ -68,20 +67,17 @@ multi-led {
> >                       label =3D "d2";
> >
> >                       led-red {
> > -                             pwms =3D <&pwm0 2 7812500 PWM_POLARITY_IN=
VERTED>;
> > -                             active-low;
> > +                             pwms =3D <&pwm0 2 7812500 0>;
> >                               color =3D <LED_COLOR_ID_RED>;
> >                       };
> >
> >                       led-green {
> > -                             pwms =3D <&pwm0 1 7812500 PWM_POLARITY_IN=
VERTED>;
> > -                             active-low;
> > +                             pwms =3D <&pwm0 1 7812500 0>;
> >                               color =3D <LED_COLOR_ID_GREEN>;
> >                       };
> >
> >                       led-blue {
> > -                             pwms =3D <&pwm0 3 7812500 PWM_POLARITY_IN=
VERTED>;
> > -                             active-low;
> > +                             pwms =3D <&pwm0 3 7812500 0>;
> >                               color =3D <LED_COLOR_ID_BLUE>;
> >                       };
> >               };
> > --
> > 2.42.0
> >
