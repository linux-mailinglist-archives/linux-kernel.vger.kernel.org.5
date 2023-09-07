Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF717979B7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242843AbjIGRTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbjIGRTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:19:16 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EDF10F6;
        Thu,  7 Sep 2023 10:18:52 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a9f88b657eso776460b6e.3;
        Thu, 07 Sep 2023 10:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694107066; x=1694711866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvxU3Tg/CrzSJAWHMozvHTDat1C3xfXUwj0L4NkG344=;
        b=PWdnes7qxWc+/RWSL1aJmjOh5COh7DExcpzcRiLxd7dyVTEHqgZNhKHRSK+q3HIOr+
         J6Bvj2ltOHs4gsOJRJQAheVbUpWx5s7rsmIUCpwrzOQa21Xh9+jWSh3KuKF/8tE7iJ97
         7EsCe2C66iGStVy5T/uimuoNyGNYdj7BdrUf23Wjiy4ynOF3SOW+i6Jz/PFHMPg4Lp0m
         OU+wxbc1H+f/msDe9s2QCoCyQp3r0KBJ0S0IkTGAwRIzTbq2QLKU3Xsumxvt5z1rh67s
         jcgdXS6e96bHJQQddzOHDEnHdDjaAg5vQmghfcFejsBdqT1q4lbkDKvDcycUWy/Lres1
         Fr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694107066; x=1694711866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TvxU3Tg/CrzSJAWHMozvHTDat1C3xfXUwj0L4NkG344=;
        b=hhhwR6zYYeMZPHJZksk04UhOkaUXFTC18jh7dZ1OFOc6G8X97BLDHPlVVYFNGdxblF
         GrstNHU3uk8BrO5+hCKlEoPWObpkcuMY8yjcwP4h6KeuzqY+7L8gFljRKZxxfnLGlpJT
         lcOmK7esT7YjCgZ9CdLUcReTC425IfqlfW/ww/SLtynyk7+IMRzzUWHjN8hs3fTIGeb+
         CyI1LWywYRwpvzbv8mOvKPTohrrbUTSRKrbagJlOFpJ0fsQ65UdS6GDinNu1YR+6BGlb
         9qP+7Obp+4ifz0WDR6Dg+BQ3K6kNItCjyxG6wQlCiKd3T9lwp6a3b6sIhjnajQfNwiEr
         lFzw==
X-Gm-Message-State: AOJu0YwpBm985GufegeZDQ74A802wpTmaIUph1gv9nK+fdtpkKNbMvb9
        m926hrHZWZ3rLkj7TXGaiMRDtKft1ECtFexiNDEiWXXo
X-Google-Smtp-Source: AGHT+IGhGyja7JD0MILhyMnfb4uAWq/A6tIDT6hRMJY+Vj2r/9PRBAmGOG8xJK+z2l778SBxTYGVV74yNZ5yITlb47c=
X-Received: by 2002:a25:50c5:0:b0:d77:e0d4:5ef8 with SMTP id
 e188-20020a2550c5000000b00d77e0d45ef8mr18796215ybb.54.1694091977388; Thu, 07
 Sep 2023 06:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230907010159.330555-1-aford173@gmail.com> <56334793-3d21-1f2c-2f5c-01ba2f306813@linaro.org>
In-Reply-To: <56334793-3d21-1f2c-2f5c-01ba2f306813@linaro.org>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 7 Sep 2023 08:06:05 -0500
Message-ID: <CAHCN7x+c76w61BDO_xLrnrYGX7Vnb6tEifectbgo+g2_CT48rQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm:dts: am3517-evm: Fix LED3/4 pinmux
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-omap@vger.kernel.org, aford@beaconembedded.com,
        =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Derald D. Woods" <woods.technical@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 7, 2023 at 1:11=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 07/09/2023 03:01, Adam Ford wrote:
> > The pinmux for LED3 and LED4 are incorrectly attached to the
> > omap3_pmx_core when they should be connected to the omap3_pmx_wkup
> > pin mux.  This was likely masked by the fact that the bootloader
> > used to do all the pinmuxing.
> >
> > Fixes: 0dbf99542caf ("ARM: dts: am3517-evm: Add User LEDs and Pushbutto=
n")
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> > This likely cannot apply to the original series, because the file has
> > moved.  I can generate a separate patch for the pre-move device trees
> > if necesssary.  The original location was:
> >   arch/arm/boot/dts/am3517-evm.dts
> >
> > diff --git a/arch/arm/boot/dts/ti/omap/am3517-evm.dts b/arch/arm/boot/d=
ts/ti/omap/am3517-evm.dts
> > index af9df15274be..738189ddc8d5 100644
> > --- a/arch/arm/boot/dts/ti/omap/am3517-evm.dts
> > +++ b/arch/arm/boot/dts/ti/omap/am3517-evm.dts
> > @@ -271,13 +271,6 @@ OMAP3_CORE1_IOPAD(0x21c4, PIN_INPUT_PULLUP | MUX_M=
ODE0)  /* i2c3_sda */
> >               >;
> >       };
> >
> > -     leds_pins: leds-pins {
> > -             pinctrl-single,pins =3D <
> > -                     OMAP3_WKUP_IOPAD(0x2a24, PIN_OUTPUT_PULLUP | MUX_=
MODE4) /* jtag_emu0.gpio_11 */
> > -                     OMAP3_WKUP_IOPAD(0x2a26, PIN_OUTPUT_PULLUP | MUX_=
MODE4) /* jtag_emu1.gpio_31 */
> > -             >;
> > -     };
> > -
> >       mmc1_pins: mmc1-pins {
> >               pinctrl-single,pins =3D <
> >                       OMAP3_CORE1_IOPAD(0x2144, PIN_INPUT_PULLUP | MUX_=
MODE0) /* sdmmc1_clk.sdmmc1_clk */
> > @@ -355,3 +348,12 @@ OMAP3430_CORE2_IOPAD(0x25e2, PIN_INPUT | MUX_MODE3=
)      /* etk_d3.hsusb1_data7 */
> >               >;
> >       };
> >  };
> > +
> > +&omap3_pmx_wkup {
> > +     leds_pins: pinmux_leds_pins {
>
> Come on... why moving it and changing the name to incorrect one? Isn't a
> move cut-paste?

I applied a patch from an older branch, so I didn't notice the name
convention changed.  Sorry about that.  I'll re-spin both patches with
the pin-mux naming conventions fixed.

adam
>
> Best regards,
> Krzysztof
>
