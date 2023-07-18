Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737287572A7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 06:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjGREBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 00:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGREB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 00:01:26 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D43194;
        Mon, 17 Jul 2023 21:01:25 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a43cbb4326so2466140b6e.2;
        Mon, 17 Jul 2023 21:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689652885; x=1692244885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFDsYeU09QyX9nMGiHdFlrICPlkCawySijwdpTw5NLM=;
        b=fCpfi36ddfNUO4DxSsb38t1Gm9qcZ2cyxe1ho9CTdR0NF3RYOvfxRFg8sjudYuMA35
         YbfxUYupQDgG7zx/tJKMpfhNlAXcnXKnKu1xoxJeOd362zxKXkWrBRU1KfqYzmif3OuM
         yaNzfCWTnY5jtYBCPD8/LkyjZIgn1wuVPT6F5YHmK4DWR/VkTpeXKdunCmjQIxdZVknY
         g9x+RMMYiTVo243FOHcCk/5Jy98HLDIzKYer4s9KRVaLv3052hDn3acFvxHfSrMDlK0t
         f7vauHUJk9r0tJqPad+Iv4P+drE/i5dirMTQfBoPV+8/VkfMy62mQxYR2YHYrR0Y+2M0
         F5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689652885; x=1692244885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFDsYeU09QyX9nMGiHdFlrICPlkCawySijwdpTw5NLM=;
        b=li1lho2sIO894N4aZBZ/Fk8nXEET5W4AXkHLabgGT2xIykiaXyDW9fne4S7joIr7az
         Zq20r7kycRo9NdAZC6kcXHUVc9KuMa52tVqv4GQoGPNNWURxAJRZw8q1umeI7cDjdExv
         kcs1dVefOk46jOreqP3z5JhFnaRnReAArtGSIVbqILHkjJHkqI5DoeY2vhkaUXGAqiW9
         d8nBGtr8e4pjRcge0MUhQ7AIpsG8Le7pNk/LxNUMV4+nPvLbk+K2pi2K+XsvxHo/nNqy
         F7acRRtQ5LICAq9Et1HKS1RDaKk3dRB7Wo8M8D75zb9bpyLHxH/lLOHQ90X97RYvCNUC
         EtiQ==
X-Gm-Message-State: ABy/qLZSIeFTsL3BjxdWpNmb0oMF4FeSGZZek/eXvVFLo5rMpYe7nqeM
        /ya9Wf0INmdJAcG3v8fbyvnsnYTVX2o0tZHekysEOnvkEdq5ry4+
X-Google-Smtp-Source: APBJJlFei5nTsv62G4RI+NBkc29pl0jchtNvubF4SKpPkRcKNsh9fO5zwyBsd/MW55rbHWgSub5On7KihHxl/Remrv4=
X-Received: by 2002:a05:6808:199c:b0:3a3:ac49:77dc with SMTP id
 bj28-20020a056808199c00b003a3ac4977dcmr15295760oib.1.1689652884633; Mon, 17
 Jul 2023 21:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAGUgbhCqOJaEPjS96o2au21uW4NhqFScm4Ayd8PzOQvqxQ94SQ@mail.gmail.com>
 <0b9dd5cf-f4ca-2e6b-624d-0b451bbc2f30@linaro.org> <0ba3767c-d481-6e2c-2d32-b79af0e1efd8@roeck-us.net>
 <CAGUgbhC34-pUp4ECULc0ScaN7hUF1L-z69h+ji-TiVrv4gKd3Q@mail.gmail.com>
 <7b198d57-ddec-3074-314a-3e5e5b8f48f9@roeck-us.net> <CAGUgbhDbFedVe-pc+muD_NtDpjHpGqMDdrS3A73C-QbxeHn4oQ@mail.gmail.com>
 <cf91edc9-1093-495b-48eb-6b05198c2541@linaro.org> <7a69bda1-5f4c-5b1f-8eb6-6fd58917a9b1@roeck-us.net>
 <CAGUgbhCTDPGt_vpbfaEreX+iuLJ3WUBqt4kppxyaFZQus9Zf0Q@mail.gmail.com> <b22b2ccc-6760-0db6-067b-109c3864d2e8@linaro.org>
In-Reply-To: <b22b2ccc-6760-0db6-067b-109c3864d2e8@linaro.org>
From:   =?UTF-8?B?6JSh5om/6YGU?= <billyking19920205@gmail.com>
Date:   Tue, 18 Jul 2023 12:01:13 +0800
Message-ID: <CAGUgbhDmXnyxYCL9h9C0P4ByDSTstWnGqW=uFoDVVHeK3BerHA@mail.gmail.com>
Subject: Re: [v6 2/4] dt-bindings: hwmon: Add ASPEED TACH Control documentation
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
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

>
> On 17/07/2023 11:01, =E8=94=A1=E6=89=BF=E9=81=94 wrote:
> > Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2023=E5=B9=B47=E6=9C=8817=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=881:00=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >>
> >> On 7/16/23 09:08, Krzysztof Kozlowski wrote:
> >>
> >> [ ... ]
> >>
> >>>>
> >>>> This patch serial doesn't use to binding the fan control h/w. It is
> >>>> used to binding the two independent h/w blocks.
> >>>> One is used to provide pwm output and another is used to monitor the
> >>>> speed of the input.
> >>>> My patch is used to point out that the pwm and the tach is the
> >>>> different function and don't need to
> >>>> bind together. You can not only combine them as the fan usage but al=
so
> >>>> treat them as the individual module for
> >>>> use. For example: the pwm can use to be the beeper (pwm-beeper.c), t=
he
> >>>> tach can be used to monitor the heart beat signal.
> >>>
> >>> Isn't this exactly the same as in every other SoC? PWMs can be used i=
n
> >>> different ways?
> >>>
> >>
> >> ... and in every fan controller. Not that it really makes sense becaus=
e
> >> normally the pwm controller part of such chips is tied to the fan inpu=
t,
> >> to enable automatic fan control, but it is technically possible.
> >> In many cases this is also the case in SoCs, for example, in ast2500.
> >> Apparently this was redesigned in ast2600 where they two blocks are
> >> only lightly coupled (there are two pwm status bits in the fan status
> >> register, but I have no idea what those mean). If the blocks are tight=
ly
> >> coupled, separate drivers don't really make sense.
> >>
> >> There are multiple ways to separate the pwm controller part from the
> >> fan inputs if that is really necessary. One would be to provide a
> >> sequence of address mappings, the other would be to pass the memory
> >> region from an mfd driver. It is not necessary to have N instances
> >> of the fan controller, even if the address space is not continuous.
> >>
> >
> > Hi Guenter,
> >
> > May I ask about the meaning of the sequence of address mappings? It app=
ears
> > to consist of multiple tuples within the 'reg' property, indicating
> > the usage of PWM/Tach
> > registers within a single instance. After that I can use the dts like f=
ollowing:
> >
> > pwm: pwm@1e610000 {
> > ...
> > reg =3D <0x1e610000 0x8
> > 0x1e610010 0x8
> > 0x1e610020 0x8
> > 0x1e610030 0x8
> > 0x1e610040 0x8
> > 0x1e610050 0x8
> > 0x1e610060 0x8
> > 0x1e610070 0x8
> > 0x1e610080 0x8
> > 0x1e610090 0x8
> > 0x1e6100A0 0x8
> > 0x1e6100B0 0x8
> > 0x1e6100C0 0x8
> > 0x1e6100D0 0x8
> > 0x1e6100E0 0x8
> > 0x1e6100F0 0x8>;
>
>
> Uh, no... I mean, why? We keep pointing out that this should not be done
> differently than any other SoC. Open any other SoC PWM controller and
> tell me why this is different? Why this cannot be one address space?

Hi Krzysztof,

This is because the register layout for PWM and Tach is not continuous.
Each PWM/Tach instance has its own set of controller registers, and they
are independent of each other.

For example:
PWM0 uses registers 0x0 and 0x4, while Tach0 uses registers 0x8 and 0xc.
PWM1 uses registers 0x10 and 0x14, while Tach1 uses registers 0x18 and 0x1c=
.
...

To separate the PWM controller part from the fan inputs, Guenter has
provided two methods.
The first method involves passing the memory region from an MFD
driver, which was the
initial method I intended to use. However, it seems that this method
does not make sense to you.

Therefore, I would like to explore the second method suggested by
Guenter, which involves providing
a sequence of address mappings.

Thanks

Best Regards,
Billy Tsai
