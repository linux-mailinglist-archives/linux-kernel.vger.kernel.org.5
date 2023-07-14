Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B5B753963
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 13:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbjGNLSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 07:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbjGNLSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:18:18 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED922D63;
        Fri, 14 Jul 2023 04:18:12 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1b00b0ab0daso1397879fac.0;
        Fri, 14 Jul 2023 04:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689333490; x=1691925490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuYl6dCIknZy3pEG+UL4YUVY6+/QZzqXbjFQUObZGXw=;
        b=nhkOwTk9YifMtYKteO1Kq3wigRUgTDommOdBBtJwwiPhGQ3RozJUWEYN1GhcJR1Vka
         2P5gsVBABB4WN6oGs+c4PcxrrDSaDTNjKwRXJBi3v9vEHSSUJ+mIE+5Uu8cersg4bx4O
         bKs1BIT1K9A0L3fqtKZ1MK9157ou+bPD4uDCXKvQu4DYTDpJ9yblJBgSW9NYRWhD3ZFa
         uJHfx7e2WyRo8t68s6fsADklSR0PmZYD/L99BD8pJT3BVG3+cZt88UEil416HTsHo3b5
         D1S/MEEA3b3r02c7ObXKxWKnYeNuvyf94jsg2DfZMlB+4q3pwLBpIPxmzxSO/XyNVhVS
         z1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689333490; x=1691925490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DuYl6dCIknZy3pEG+UL4YUVY6+/QZzqXbjFQUObZGXw=;
        b=WrzaHFKdvKVYRh1cE8+NhdjSJGXF0wN0H8JXkZ30FnKZOZZOJ2D5KTDcObmdyR3YhG
         RkkUTAN1PiyWj3SNxZTYNpqk5VfVHh8a8v6TA4pj5xr0CdAbXNmKjj88id8112KLKvuG
         Brm8IVLFKIvGkZuQD+qzONU6T17L2rDhairbEc/EzhjEnjdfdlx17NuwLW42Xi8yua/A
         vdpxIFcqiETSczDdRhf9dB4fbqdN1u5JpRtoKgwpWFUoQH94bruICZmWxcCWOWoMcDd/
         Nb3XChWoI7Jkq1heOHlSQtPaLNM8LzDkVu77sIcQmbL0bITOtBJW0PIDEjRj44Sw3LAD
         T4TQ==
X-Gm-Message-State: ABy/qLakoeDUrxpb4DCWnfuD6mv1x69j50DoBLCQaLC34l+xG735yzy1
        oLgTl0nlNDJWm6jTHVQjLD4Gy6qEwTOQkwEC474=
X-Google-Smtp-Source: APBJJlHdNUAjTNtAhNO+eAbBQ+pFyE7d8pfHIMRz9h3zGtKhJRU7tiu+03iq2yjQP0WlPQmUS6r8tnd5CkXQLnBIxnM=
X-Received: by 2002:a05:6870:610b:b0:1b0:408a:1d05 with SMTP id
 s11-20020a056870610b00b001b0408a1d05mr5066660oae.38.1689333490449; Fri, 14
 Jul 2023 04:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAGUgbhCqOJaEPjS96o2au21uW4NhqFScm4Ayd8PzOQvqxQ94SQ@mail.gmail.com>
 <0b9dd5cf-f4ca-2e6b-624d-0b451bbc2f30@linaro.org> <0ba3767c-d481-6e2c-2d32-b79af0e1efd8@roeck-us.net>
 <CAGUgbhC34-pUp4ECULc0ScaN7hUF1L-z69h+ji-TiVrv4gKd3Q@mail.gmail.com> <7b198d57-ddec-3074-314a-3e5e5b8f48f9@roeck-us.net>
In-Reply-To: <7b198d57-ddec-3074-314a-3e5e5b8f48f9@roeck-us.net>
From:   =?UTF-8?B?6JSh5om/6YGU?= <billyking19920205@gmail.com>
Date:   Fri, 14 Jul 2023 19:17:59 +0800
Message-ID: <CAGUgbhDbFedVe-pc+muD_NtDpjHpGqMDdrS3A73C-QbxeHn4oQ@mail.gmail.com>
Subject: Re: [v6 2/4] dt-bindings: hwmon: Add ASPEED TACH Control documentation
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patrick@stwcx.xyz" <patrick@stwcx.xyz>,
        Billy Tsai <billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2023=E5=B9=B47=E6=9C=8814=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:26=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 7/14/23 03:18, =E8=94=A1=E6=89=BF=E9=81=94 wrote:
> > Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2023=E5=B9=B47=E6=9C=8814=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:59=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >>
> >> On 7/14/23 00:13, Krzysztof Kozlowski wrote:
> >>> On 14/07/2023 09:04, =E8=94=A1=E6=89=BF=E9=81=94 wrote:
> >>>
> >>>>           > This is because our register layout for PWM and Tach is =
not
> >>>> continuous.
> >>>>
> >>>>           > PWM0 used 0x0 0x4, Tach0 used 0x8 0xc
> >>>>
> >>>>           > PWM1 used 0x10 0x14, Tach1 used 0x18 0x1c
> >>>>
> >>>>           > ...
> >>>>
> >>>>           > Each PWM/Tach instance has its own controller register a=
nd is not
> >>>> dependent on others.
> >>>
> >>> Your email reply quoting style is very difficult to read.
> >>>
> >>>>
> >>>>
> >>>>
> >>>> Hi Guenter,
> >>>>
> >>>>
> >>>>
> >>>> Did you receive a response to my previous email?
> >>>>
> >>>> I would like to inquire if you have any further concerns regarding t=
he PWM
> >>>> and Tach with 16 instances.
> >>>
> >>> But isn't like this in all PWMs in all SoCs?
> >>>
> >>
> >> Correct, pretty much every fan controller is implemented that way.
> >> I don't understand the logic.
> >>
> >
> > Hi Krzysztof and Guenter,
> >
> > Apologies for any confusion earlier.
> > So, you think that the implementation with 16 instances of TACH/PWM
> > device nodes in dts instead of one is ok to you, right?
> >
>
> Did I say that ? No, it is not ok with me. It is confusing and doesn't ma=
ke
> sense to me. This is one fan controller with 16 channels, not 16 separate
> controllers.
>

This patch serial doesn't use to binding the fan control h/w. It is
used to binding the two independent h/w blocks.
One is used to provide pwm output and another is used to monitor the
speed of the input.
My patch is used to point out that the pwm and the tach is the
different function and don't need to
bind together. You can not only combine them as the fan usage but also
treat them as the individual module for
use. For example: the pwm can use to be the beeper (pwm-beeper.c), the
tach can be used to monitor the heart beat signal.

Thanks
