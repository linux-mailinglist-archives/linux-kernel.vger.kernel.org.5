Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805B2755EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjGQJBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjGQJBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:01:41 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B4AE54;
        Mon, 17 Jul 2023 02:01:40 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1b0606bee45so3323607fac.3;
        Mon, 17 Jul 2023 02:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689584499; x=1692176499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxldzEnqhxU11I1qenml6kr6jYXmqVdQ8A5TZLTLFXc=;
        b=YbJ2jFbuBvsxsq+FFnLBHzWtJWttbm0hbVvB1eIgpYvmPoezlwAfRDw3+SJ8ZGbUSF
         D32HEvc89R9TKCdMxLVLozQ9yFbCR5Dk09Ehy6X0RA2S9uvIWamDXLiZ2urXjvTwx+cv
         FcBr44cXJ/oAerRc1E0gcq7EMLZcUOKxz8hDBLM9CCdN6Lai6G8fIzqQO/5S8/z92YHP
         4M7ckb0YPjOcMVai8RnzdoJ8cqgqdj8nbfaUaPFf9zak0mx/H0Do5C9BonfGe5h+6pYI
         jAhno5X0mJ9eViSgtmH6Mr6hHOYwDrEA+I0d7n+23O70odDsHeXw7X1ZSZS+JFeDlcRk
         176g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689584499; x=1692176499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxldzEnqhxU11I1qenml6kr6jYXmqVdQ8A5TZLTLFXc=;
        b=NHvjOwoOfWoOmP0tESvhT2zkmilNF99yAP6izgW9ggYh46Tnf6NxZjsMgx99zkbcfR
         va15+a8BWah02w+eweqoNcwlcVSuo09uXMzfVIs1cOhUV1zX5zY2eehsCsbXYrZu88UQ
         xxpg9PzW1W57mEEMTvbOj4GlOdmez0nbei5X7iShuecYlzDOSXcwdeQxf0t1SgyXqv1r
         uNLm4kKvk3POuhGmCf2IIXC5Dm3CqVR16Xm2z34JZWeylsSP2e9yPhnPcWXl9TYDiExy
         e9jEtIw8S0FsJ4ytGS29HQxxtuDI8bFX/iQsbgkSfOVrt5YmFopwiT1L8sE4Kb5KRiLa
         z9XA==
X-Gm-Message-State: ABy/qLYdudGaRZWnB8lrviNMuO/4/wxHauSM/k4X1pm6ImJgLmWoRQA8
        NsAI8YkqnEt7ATIgllCmUsDLvMTQGHn0BFCm7WzZnLfo+vYnl2Qb
X-Google-Smtp-Source: APBJJlHgS3n1gQn4Oax9fTF+hYKgAcdQqB9afBeR6x0UgGsHhp289g1cgQIuZwJ37pl3ns1pDcKlMFedVXvZ0dTUDmg=
X-Received: by 2002:a05:6870:589b:b0:1b0:40b0:114c with SMTP id
 be27-20020a056870589b00b001b040b0114cmr12150916oab.43.1689584499214; Mon, 17
 Jul 2023 02:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAGUgbhCqOJaEPjS96o2au21uW4NhqFScm4Ayd8PzOQvqxQ94SQ@mail.gmail.com>
 <0b9dd5cf-f4ca-2e6b-624d-0b451bbc2f30@linaro.org> <0ba3767c-d481-6e2c-2d32-b79af0e1efd8@roeck-us.net>
 <CAGUgbhC34-pUp4ECULc0ScaN7hUF1L-z69h+ji-TiVrv4gKd3Q@mail.gmail.com>
 <7b198d57-ddec-3074-314a-3e5e5b8f48f9@roeck-us.net> <CAGUgbhDbFedVe-pc+muD_NtDpjHpGqMDdrS3A73C-QbxeHn4oQ@mail.gmail.com>
 <cf91edc9-1093-495b-48eb-6b05198c2541@linaro.org> <7a69bda1-5f4c-5b1f-8eb6-6fd58917a9b1@roeck-us.net>
In-Reply-To: <7a69bda1-5f4c-5b1f-8eb6-6fd58917a9b1@roeck-us.net>
From:   =?UTF-8?B?6JSh5om/6YGU?= <billyking19920205@gmail.com>
Date:   Mon, 17 Jul 2023 17:01:28 +0800
Message-ID: <CAGUgbhCTDPGt_vpbfaEreX+iuLJ3WUBqt4kppxyaFZQus9Zf0Q@mail.gmail.com>
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

Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2023=E5=B9=B47=E6=9C=8817=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=881:00=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 7/16/23 09:08, Krzysztof Kozlowski wrote:
>
> [ ... ]
>
> >>
> >> This patch serial doesn't use to binding the fan control h/w. It is
> >> used to binding the two independent h/w blocks.
> >> One is used to provide pwm output and another is used to monitor the
> >> speed of the input.
> >> My patch is used to point out that the pwm and the tach is the
> >> different function and don't need to
> >> bind together. You can not only combine them as the fan usage but also
> >> treat them as the individual module for
> >> use. For example: the pwm can use to be the beeper (pwm-beeper.c), the
> >> tach can be used to monitor the heart beat signal.
> >
> > Isn't this exactly the same as in every other SoC? PWMs can be used in
> > different ways?
> >
>
> ... and in every fan controller. Not that it really makes sense because
> normally the pwm controller part of such chips is tied to the fan input,
> to enable automatic fan control, but it is technically possible.
> In many cases this is also the case in SoCs, for example, in ast2500.
> Apparently this was redesigned in ast2600 where they two blocks are
> only lightly coupled (there are two pwm status bits in the fan status
> register, but I have no idea what those mean). If the blocks are tightly
> coupled, separate drivers don't really make sense.
>
> There are multiple ways to separate the pwm controller part from the
> fan inputs if that is really necessary. One would be to provide a
> sequence of address mappings, the other would be to pass the memory
> region from an mfd driver. It is not necessary to have N instances
> of the fan controller, even if the address space is not continuous.
>

Hi Guenter,

May I ask about the meaning of the sequence of address mappings? It appears
to consist of multiple tuples within the 'reg' property, indicating
the usage of PWM/Tach
registers within a single instance. After that I can use the dts like follo=
wing:

pwm: pwm@1e610000 {
...
reg =3D <0x1e610000 0x8
0x1e610010 0x8
0x1e610020 0x8
0x1e610030 0x8
0x1e610040 0x8
0x1e610050 0x8
0x1e610060 0x8
0x1e610070 0x8
0x1e610080 0x8
0x1e610090 0x8
0x1e6100A0 0x8
0x1e6100B0 0x8
0x1e6100C0 0x8
0x1e6100D0 0x8
0x1e6100E0 0x8
0x1e6100F0 0x8>;
...
};

tach: tach@
...
reg =3D <0x1e610008 0x8
0x1e610018 0x8
0x1e610028 0x8
0x1e610038 0x8
0x1e610048 0x8
0x1e610058 0x8
0x1e610068 0x8
0x1e610078 0x8
0x1e610088 0x8
0x1e610098 0x8
0x1e6100A8 0x8
0x1e6100B8 0x8
0x1e6100C8 0x8
0x1e6100D8 0x8
0x1e6100E8 0x8
0x1e6100F8 0x8>;
...
};

correct?

Thanks

> Guenter
>
> > Anyway, it is tricky to keep the discussion since you avoid posting
> > entire DTS. I already said:
> >
> > "I will start NAKing such patches without DTS user. It's like reviewing
> > fake code for some unknown solution and trying to get from you piece of
> > answers one by one, because you do not want to share entire part."
> >

Hi Krzysztof,

Do you mean the DTS example of the usage in the binding, like the
following right?
PWM:
pwm0: pwm0@1e610000 {
compatible =3D "aspeed,ast2600-pwm";
reg =3D <0x1e610000 0x8>;
#pwm-cells =3D <3>;
#address-cells =3D <1>;
#size-cells =3D <0>;
pinctrl-names =3D "default";
pinctrl-0 =3D <&pinctrl_pwm0_default>;
clocks =3D <&syscon ASPEED_CLK_AHB>;
resets =3D <&syscon ASPEED_RESET_PWM>;
};

TACH:
examples:
- |
tach0: tach0@1e610008 {
        compatible =3D "aspeed,ast2600-tach";
        reg =3D <0x1e610008 0x8>;
        #address-cells =3D <1>;
        #size-cells =3D <0>;
        pinctrl-names =3D "default";
        pinctrl-0 =3D <&pinctrl_tach0_default>;
        clocks =3D <&syscon ASPEED_CLK_AHB>;
        resets =3D <&syscon ASPEED_RESET_PWM>;
};

Thanks

> >
> >
> > Best regards,
> > Krzysztof
> >
>
