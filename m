Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD23C77C7DA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbjHOGdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbjHOGcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:32:53 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1811173F;
        Mon, 14 Aug 2023 23:32:51 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b9cf1997c4so4322903a34.3;
        Mon, 14 Aug 2023 23:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692081171; x=1692685971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXyT0KU7mlgwdolM1slTRqIWpl1oaIGWyvpE5anceUg=;
        b=k84xQmkASS5F995UZgmnC6LbbGavBDa7l2s9k71XK0MokU0Qt+6LsX3YVqLfZi1sy8
         9762VTUxfE5Fbb0ihlzt24vTXZN+/L9ALcGOqEA30ICl/wTG7v7jOJ1DgQzAl3UXwvfb
         FNKzHLSZbgRH3VqIk6Y4PiVVrESUj0vD4vURekRVtRKDBrUbFaYC61v0PwBzHpO6gNPP
         fZwj3xVxkKnE4kTULo87nbBix6VsmWcIDgyw1F3len1VXb2LEsum71Hnm5q0nRgVFIkJ
         SSGC5RKiHuxDCfAtBbbnH0XK+CuE31RCgN7CxL6wGMyCzgg784NwznNRYdKjmwZTAGEp
         EXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692081171; x=1692685971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXyT0KU7mlgwdolM1slTRqIWpl1oaIGWyvpE5anceUg=;
        b=CLt1mQ4AxPa23K/n+DYjCcFHSaoo/6lVEotkUm6ED7NXv/33OznS4gpTFoOmz7N3SA
         pr51RrJbT91nXa/xaHEwnfD71oNQSkQjG7ONqPwxbAhgXFL22hTlOHTdpnrHvg9xskbK
         EDXgXp/EPJQfZkBUTlY6ULG4S8lzP9uJ2e4PJOFbQge9RtzKDTIvXbqYnVmqJ9/AV+l0
         7jN2VhdY6UbuPva8FRoSivayH68gBRvKDC+YlSC8Ct9fOBnLNOLGPDdfwH1CfbtHcikM
         gUPxU8ULaKbIGhQ3jqPUePAYgSL+9n5TK9EVhuKvBdfpcThDbIy2QK68EzUWiULrysVg
         AFVg==
X-Gm-Message-State: AOJu0Yx8ST4KkdtjVjglyuOg6K6KK/HM6XyY04zzO/Lw8yjZ3+sFsAQd
        oJ7ZnrbZp+WOtoYxp8nu1lXHKL/g/8X6NiJSY0s=
X-Google-Smtp-Source: AGHT+IFDi2OxwWt6jyRqikG/vM1XoLDHRV3Fww5fww8bst+rx3w3FUWw8m3l8Y9ihCnHJUb0Wd3U2xhBp2AnXxvVCpg=
X-Received: by 2002:a05:6870:9343:b0:1bf:43d2:526c with SMTP id
 j3-20020a056870934300b001bf43d2526cmr11907847oak.15.1692081171162; Mon, 14
 Aug 2023 23:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <7b198d57-ddec-3074-314a-3e5e5b8f48f9@roeck-us.net>
 <CAGUgbhDbFedVe-pc+muD_NtDpjHpGqMDdrS3A73C-QbxeHn4oQ@mail.gmail.com>
 <cf91edc9-1093-495b-48eb-6b05198c2541@linaro.org> <7a69bda1-5f4c-5b1f-8eb6-6fd58917a9b1@roeck-us.net>
 <CAGUgbhCTDPGt_vpbfaEreX+iuLJ3WUBqt4kppxyaFZQus9Zf0Q@mail.gmail.com>
 <b22b2ccc-6760-0db6-067b-109c3864d2e8@linaro.org> <CAGUgbhDmXnyxYCL9h9C0P4ByDSTstWnGqW=uFoDVVHeK3BerHA@mail.gmail.com>
 <3756dffd-1407-d656-485a-9cf1eefd9ae1@linaro.org> <ZLYziWcIWcNnzMXR@orome>
 <709d738c-3bf3-d808-4172-468d7ad947d7@roeck-us.net> <ZLY779Bc4LpJ0TER@orome>
In-Reply-To: <ZLY779Bc4LpJ0TER@orome>
From:   =?UTF-8?B?6JSh5om/6YGU?= <billyking19920205@gmail.com>
Date:   Tue, 15 Aug 2023 14:32:39 +0800
Message-ID: <CAGUgbhCPhG1q-VXihaPbASkkigdmhd8Lo6ynCTEayLV83Y+=VQ@mail.gmail.com>
Subject: Re: [v6 2/4] dt-bindings: hwmon: Add ASPEED TACH Control documentation
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thierry Reding <thierry.reding@gmail.com> =E6=96=BC 2023=E5=B9=B47=E6=9C=88=
18=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:14=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Mon, Jul 17, 2023 at 11:54:26PM -0700, Guenter Roeck wrote:
> > On 7/17/23 23:39, Thierry Reding wrote:
> > > On Tue, Jul 18, 2023 at 08:04:24AM +0200, Krzysztof Kozlowski wrote:
> > > > On 18/07/2023 06:01, =E8=94=A1=E6=89=BF=E9=81=94 wrote:
> > > > > >
> > > > > > On 17/07/2023 11:01, =E8=94=A1=E6=89=BF=E9=81=94 wrote:
> > > > > > > Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2023=E5=B9=B47=
=E6=9C=8817=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=881:00=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > > > > > >
> > > > > > > > On 7/16/23 09:08, Krzysztof Kozlowski wrote:
> > > > > > > >
> > > > > > > > [ ... ]
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > This patch serial doesn't use to binding the fan contro=
l h/w. It is
> > > > > > > > > > used to binding the two independent h/w blocks.
> > > > > > > > > > One is used to provide pwm output and another is used t=
o monitor the
> > > > > > > > > > speed of the input.
> > > > > > > > > > My patch is used to point out that the pwm and the tach=
 is the
> > > > > > > > > > different function and don't need to
> > > > > > > > > > bind together. You can not only combine them as the fan=
 usage but also
> > > > > > > > > > treat them as the individual module for
> > > > > > > > > > use. For example: the pwm can use to be the beeper (pwm=
-beeper.c), the
> > > > > > > > > > tach can be used to monitor the heart beat signal.
> > > > > > > > >
> > > > > > > > > Isn't this exactly the same as in every other SoC? PWMs c=
an be used in
> > > > > > > > > different ways?
> > > > > > > > >
> > > > > > > >
> > > > > > > > ... and in every fan controller. Not that it really makes s=
ense because
> > > > > > > > normally the pwm controller part of such chips is tied to t=
he fan input,
> > > > > > > > to enable automatic fan control, but it is technically poss=
ible.
> > > > > > > > In many cases this is also the case in SoCs, for example, i=
n ast2500.
> > > > > > > > Apparently this was redesigned in ast2600 where they two bl=
ocks are
> > > > > > > > only lightly coupled (there are two pwm status bits in the =
fan status
> > > > > > > > register, but I have no idea what those mean). If the block=
s are tightly
> > > > > > > > coupled, separate drivers don't really make sense.
> > > > > > > >
> > > > > > > > There are multiple ways to separate the pwm controller part=
 from the
> > > > > > > > fan inputs if that is really necessary. One would be to pro=
vide a
> > > > > > > > sequence of address mappings, the other would be to pass th=
e memory
> > > > > > > > region from an mfd driver. It is not necessary to have N in=
stances
> > > > > > > > of the fan controller, even if the address space is not con=
tinuous.
> > > > > > > >
> > > > > > >
> > > > > > > Hi Guenter,
> > > > > > >
> > > > > > > May I ask about the meaning of the sequence of address mappin=
gs? It appears
> > > > > > > to consist of multiple tuples within the 'reg' property, indi=
cating
> > > > > > > the usage of PWM/Tach
> > > > > > > registers within a single instance. After that I can use the =
dts like following:
> > > > > > >
> > > > > > > pwm: pwm@1e610000 {
> > > > > > > ...
> > > > > > > reg =3D <0x1e610000 0x8
> > > > > > > 0x1e610010 0x8
> > > > > > > 0x1e610020 0x8
> > > > > > > 0x1e610030 0x8
> > > > > > > 0x1e610040 0x8
> > > > > > > 0x1e610050 0x8
> > > > > > > 0x1e610060 0x8
> > > > > > > 0x1e610070 0x8
> > > > > > > 0x1e610080 0x8
> > > > > > > 0x1e610090 0x8
> > > > > > > 0x1e6100A0 0x8
> > > > > > > 0x1e6100B0 0x8
> > > > > > > 0x1e6100C0 0x8
> > > > > > > 0x1e6100D0 0x8
> > > > > > > 0x1e6100E0 0x8
> > > > > > > 0x1e6100F0 0x8>;
> > > > > >
> > > > > >
> > > > > > Uh, no... I mean, why? We keep pointing out that this should no=
t be done
> > > > > > differently than any other SoC. Open any other SoC PWM controll=
er and
> > > > > > tell me why this is different? Why this cannot be one address s=
pace?
> > > > >
> > > > > Hi Krzysztof,
> > > > >
> > > > > This is because the register layout for PWM and Tach is not conti=
nuous.
> > > > > Each PWM/Tach instance has its own set of controller registers, a=
nd they
> > > > > are independent of each other.
> > > >
> > > > Register layout is not continuous in many other devices, so again -=
 why
> > > > this must be different?
> > > >
> > > > >
> > > > > For example:
> > > > > PWM0 uses registers 0x0 and 0x4, while Tach0 uses registers 0x8 a=
nd 0xc.
> > > > > PWM1 uses registers 0x10 and 0x14, while Tach1 uses registers 0x1=
8 and 0x1c.
> > > > > ...
> > > > >
> > > > > To separate the PWM controller part from the fan inputs, Guenter =
has
> > > > > provided two methods.
> > > > > The first method involves passing the memory region from an MFD
> > > > > driver, which was the
> > > >
> > > > I have no clue how can you pass memory region
> > > > (Documentation/devicetree/bindings/reserved-memory/) from MFD and w=
hy
> > > > does it make sense here.
> > > >
> > > > > initial method I intended to use. However, it seems that this met=
hod
> > > > > does not make sense to you.
> > > > >
> > > > > Therefore, I would like to explore the second method suggested by
> > > > > Guenter, which involves providing
> > > > > a sequence of address mappings.
> > >
> > > At the risk of saying what others have said: given that there's a sin=
gle
> > > reset line and a single clock line controlling all of these channels =
and
> > > given what I recall of how address demuxers work in chips, everything
> > > indicates that this is a single hardware block/device.
> > >
> > > So the way that this should be described in DT is:
> > >
> > >     pwm@1e610000 {
> > >             reg =3D <0x1e610000 0x100>;
> > >             clocks =3D ...;
> > >             resets =3D ...
> > >     };
> > >
> > > That'd be the most accurate representation of this hardware in DT. It=
 is
> > > then up to the driver to expose this in any way you see fit. For Linu=
x
> > > it may make sense to expose this as 16 PWM channels and 16 hardware
> > > monitoring devices. Other operating systems using the same DT may cho=
ose
> >
> > It is single chip. It should be a single hardware monitoring device wit=
h
> > 16 channels. I don't even want to think about the mess we'd get if peop=
le
> > start modeling a single chip as N hardware monitoring devices, one for
> > each monitoring channel supported by that chip. It would be even more m=
essy
> > if the driver supporting those N devices would be marked for asynchrono=
us
> > probe, which would result in random hwmon device assignments.
>
> Sorry, I badly worded it. What I meant to say was: one hardware
> monitoring device with 16 channels.
>
> > > to expose this differently, depending on their frameworks, etc. A sim=
ple
> > > operating system may not expose this as separate resources at all but
> > > instead directly program individual registers from this block.
> > >
> > > I'd also like to add that I think trying to split this up into multip=
le
> > > drivers in Linux is a bit overkill. In my opinion, though I know not
> > > everyone shares this view, it's perfectly fine for one driver to expo=
se
> > > multiple types of resources. There's plenty of use-cases across the
> > > kernel where tightly coupled devices like this have a single driver t=
hat
> > > registers with multiple subsystems. Going through MFD only because th=
is
> > > particular hardware doesn't split registers nicely along Linux subsys=
tem
> > > boundaries.
> > >
> > > So FWIW, I'm fine carrying hwmon code in a PWM driver and I'm equally
> > > fine if PWM code ends up in a hwmon driver (or any other subsystem
> > > really) if that makes sense for a given hardware.
> > >
> >
> > I am fine either way as well, as long as we are talking about a single
> > hwmon device and not 16 of them.
>
> Excellent. Should make it pretty clear in which direction this should
> go.
>
Hi Thierry,

Thank you for organizing and providing guidance on this patch series.
I'd like to
confirm my understanding of the next steps. Based on the previous discussio=
ns,
I should proceed by combining the PWM and TACH drivers into a single driver=
.
This consolidated driver would then be exposed to both the hwmon and
pwm subsystems.
Base on this driver the dts node of this would like following:

pwm_tach: pwm-tach-controller@1e610000 {
compatible =3D "aspeed,ast2600-pwm-tach"
reg =3D <0x1e610000 0x100>;
clocks =3D <&syscon ASPEED_CLK_AHB>;
resets =3D <&syscon ASPEED_RESET_PWM>;
#pwm-cells =3D <3>;
#address-cells =3D <1>;
#size-cells =3D <0>;
fan@0 {
aspeed,fan-tach-ch =3D /bits/ 8 <0x00>;
};
fan@1 {
aspeed,fan-tach-ch =3D /bits/ 8 <0x01, 0x02>;
};
};

The subnode of the fan is utilized to create the hwmon interface,
which facilitates monitoring
the speed of the input tach pin.
If users wish to employ PWM for fan or beeper control, they can create
the necessary configuration
through the following DTS declaration:
fan0: pwm-fan0 {
compatible =3D "pwm-fan";
pwms =3D <&pwm_tach 0 40000 0>; /* Target freq:25 kHz */
cooling-min-state =3D <0>;
cooling-max-state =3D <3>;
#cooling-cells =3D <2>;
cooling-levels =3D <0 15 128 255>;
};

buzzer {
compatible =3D "pwm-beeper";
pwms =3D <&pwm_tach 1 500000 0>;
};

Thanks
Best Regards,
Billy Tsai
