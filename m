Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793B5774789
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjHHTP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbjHHTPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:15:22 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E0E3C237
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:38:12 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bf3f59905so857006666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691512689; x=1692117489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKnU9SGNhRXh7JQMi9LxA4Fhq6dBeuKxy6dhRmxZasE=;
        b=NdgbgFeopdFc9nyErGg9Tfd0ZjMqxt9PQjlMFDNqcn7e6e9meyZLkpuFjFmQUJB5AH
         0eerYrqXvyOIcBmrxg3EUoUtOBRRtMmBBAG1Bv2PJDK2L9DiXS6P6tJGFk5Syqo29NsQ
         /V9TlsBKlZDHhX0HTyWhEaZC9LgeUhXKBD8SiCc53KtfSOlFCE6b04l2Zl8Ijlk86whI
         iT/NkUTm3bhG1TSJiV52Vtbxwn1jDPxVHz3aCd3qicRn+qRSG7nEQKmTTaN9jxL2rwur
         KQy7+Zw4OeGdmOc6O3tLl57Fjfv7LKaWZgluvYzjJ668CXoD+jngSBcoZD2H9YnKMaBX
         IDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512689; x=1692117489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bKnU9SGNhRXh7JQMi9LxA4Fhq6dBeuKxy6dhRmxZasE=;
        b=lrbrT0yD3x9fulN7rYpmy8IjCqB4N0dNJCWXxgsocIshEEo3rKrocqrtewvsGmyRuk
         MCSmamqRlZdVP4MeWo/6mvaVT56UQ8qtyO9OQFQIZjbxFqSSNzNujUs4riGAMA7DE5F7
         /+3RhBc2jUud7zZqBFPT12n7Kdz6G0P5ecT1Bv8hmFOiZ1j2ovhBsDG+2Fp4dEZnzIo/
         lYN6zd+BfTDD1dwhMQgPuzcSOqfb7xTQNlEDv3uYdShsuDGX4Ex7NIG8XUfbopaR31v+
         JYBYsv2fmkZ1b6OWR9JFOAYybBlbV1/aRC8NiEhvww+4loV1tvud5kRRJlRnkxE8L6w3
         A8vA==
X-Gm-Message-State: AOJu0YxYfSrzSL04VsDSF8H/jNdJqXlylPawRz8c+bsGLIrmlLI2nvXi
        Kf3mTYU+GyTHHXybeXQFSpgUHbg9gYjnPJlH+t5/OM5pVKhHML8fY82PQA==
X-Google-Smtp-Source: AGHT+IElsjRa0J9HS7/2fBL75dvvl+iEtaAG/dD+slb4YkABigiWTNAI/wFojzqI+f99ltDUHAchU06wTWaLFbBWBQc=
X-Received: by 2002:a2e:a0cc:0:b0:2b9:b066:66a4 with SMTP id
 f12-20020a2ea0cc000000b002b9b06666a4mr9299821ljm.4.1691497023708; Tue, 08 Aug
 2023 05:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230807193507.6488-1-brgl@bgdev.pl> <20230807193507.6488-6-brgl@bgdev.pl>
 <siqiyihftz3musfjulpcqunhgi7npftumrfwfyh2pqnlx6zeb7@rrpwmkvjshfb>
 <da679b5e-6712-4849-b29c-6aa42022abc4@lunn.ch> <ld2j4llgfba6j43gesqxs6wz2baucka5scbj4nef5ehbex2cmt@d4dxsqp2vuoj>
In-Reply-To: <ld2j4llgfba6j43gesqxs6wz2baucka5scbj4nef5ehbex2cmt@d4dxsqp2vuoj>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 8 Aug 2023 14:16:50 +0200
Message-ID: <CAMRc=MdLky5sUbdFGFc+as906kr-J_XDmKmYtBBCHvETvqtAQA@mail.gmail.com>
Subject: Re: [PATCH 5/9] arm64: dts: qcom: sa8775p-ride: move the reset-gpios
 property of the PHY
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 12:27=E2=80=AFAM Andrew Halaney <ahalaney@redhat.com=
> wrote:
>
> On Mon, Aug 07, 2023 at 11:51:40PM +0200, Andrew Lunn wrote:
> > > > I have proposed a solution for this problem in 2020 but it never go=
t
> > > > upstream. Now we have a workaround in place which allows us to hard=
-code
> > > > the PHY id in the compatible property, thus skipping the ID scannin=
g).
> > >
> > > nitpicky, but I think that already existed at that time :D
> >
> > Yes, it has been there are long long time. It is however only in the
> > last 5 years of so has it been seen as a solution to the chicken egg
> > problem.
> >
> > > >           sgmii_phy: phy@8 {
> > > > +                 compatible =3D "ethernet-phy-id0141.0dd4";
> > > >                   reg =3D <0x8>;
> > > >                   device_type =3D "ethernet-phy";
> > > > +                 reset-gpios =3D <&pmm8654au_2_gpios 8 GPIO_ACTIVE=
_LOW>;
> > > > +                 reset-deassert-us =3D <70000>;
> > >
> > > Doesn't this need reset-assert-us?
> >
> > If i remember correctly, there is a default value if DT does not
> > provide one.
> >
>
> I've been trying to make sure I view devicetree properties as an OS
> agnostic ABI lately, with that in mind...
>
> The dt-binding says this for ethernet-phy:
>
>   reset-assert-us:
>     description:
>       Delay after the reset was asserted in microseconds. If this
>       property is missing the delay will be skipped.
>
> If the hardware needs a delay I think we should encode it based on that
> description, else we risk it starting to look like a unit impulse!
>

Please note that the mdio-level delay properties are not the same as
the ones on the PHY levels.

reset-delay-us - this is the delay BEFORE *DEASSERTING* the reset line
reset-post-delay-us - this is the delay AFTER *DEASSERTING* the reset line

On PHY level we have:

reset-assert-us - AFTER *ASSERTING*
reset-deassert-us - AFTER *DEASSERTING*

There never has been any reset-assert delay on that line before. It
doesn't look like we need a delay BEFORE deasserting the line, do we?

Bart
