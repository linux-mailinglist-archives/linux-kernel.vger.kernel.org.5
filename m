Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC5E79FCC0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbjINHG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjINHGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:06:55 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30388CCD;
        Thu, 14 Sep 2023 00:06:51 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-649c6ea6e72so3931136d6.2;
        Thu, 14 Sep 2023 00:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694675210; x=1695280010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdMJftDb2abTrZue0NcN+6ucPSI/cjbXwCs/rx5nuBI=;
        b=hQRzmlq4SSkgJttp420bVdRQiQyknp+1iX/YZFHAU3p1t/Y8hAp5IOtTffAybKtO/a
         iv6gsiS2qemJGeY+259GUXt2WFN/Y92/lv5CvpkXaRHEqWvA2aprE3XHi3ZXlwd46YB3
         vsmwXINw2kckZiujE1zdp6mhscuNGyKO0JN8VoMZJne5gA3i2qrd1eePU9vo3oNod98C
         H9lKPIlp3RH9sIhS0vL/xnHK0bORBgcnw1AtCrZiwLTY3NG/dHhj1c6xo+HikzFwXXWS
         1j4TlfQy8LnYnxnF86OLNfll4b5OG9Jeq6lQokw6ZI0JHN6ooT6IwvOkkOFbUQPD8hhE
         S2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694675210; x=1695280010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdMJftDb2abTrZue0NcN+6ucPSI/cjbXwCs/rx5nuBI=;
        b=upgAxDEb2CTZ0gABU9YV7r0NBMOrv5ESW0WjLHlqu95IoNwligNL9J9hxxlehVFQkD
         DXE46yRcexuil4lNv4Pi9RnHyfwI57xOB9cZ3r7dUqewZCKI2T7nsuvULVut2EQM64YR
         XJP5rB5cIZsk5Z4dXEVuEkrTVuSF1YdqZh9flP7fd8JQYKSG1D3GG3YUXPjpcoGxpT4j
         lKosDXWqZuClxYxL6W14rSFcMo4J1sLpphlwSlzDNGiKdjWzV1O21IyXj65HrSwCnuio
         +rAI3CJh5ejiD/5L4T1IJJhqyMoh7kLJcUKLx/DR28mTt62SO8k5M5yth7lg/bE+CP6v
         SLrg==
X-Gm-Message-State: AOJu0YzLBkTcRmUoOWklXGVI8qkgod0C7dYTu6T5Dfvq2Kp9BXRzPFQx
        f6YbybhKQ0aAUiDIE63dz5mDXSlr/7vjBQSP+Pw=
X-Google-Smtp-Source: AGHT+IFqMtl/34KkZbegI6c9ryJlkvbUxhils7C7k7j6r6kOxcF5Y/+mKtx4G0fmvBIO0rSFFwBDjSW6Gw84IZF5D14=
X-Received: by 2002:a05:6214:c83:b0:655:ddd7:fcab with SMTP id
 r3-20020a0562140c8300b00655ddd7fcabmr6324953qvr.49.1694675210300; Thu, 14 Sep
 2023 00:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230912140532.3797736-1-yangchen.openbmc@gmail.com>
 <20230912140532.3797736-3-yangchen.openbmc@gmail.com> <1bfdc230-e358-6aa4-7d60-03b5477a6be9@linaro.org>
 <CALFa7M_GvCgmEZxvo_ZSYoCPOe+9-tQt3KHn=_cu3n7psP+PTA@mail.gmail.com> <11c822f3-96f1-17d6-6c2a-feaa950aeea1@linaro.org>
In-Reply-To: <11c822f3-96f1-17d6-6c2a-feaa950aeea1@linaro.org>
From:   Yang Chen <yangchen.openbmc@gmail.com>
Date:   Thu, 14 Sep 2023 15:06:39 +0800
Message-ID: <CALFa7M-9N=J-WKOU=ZbLsFfXvw7=Gmw28DXdKuvuQ7Kyf=5x9g@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: Minerva: Add Facebook Minerva CMC board
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        joel@jms.id.au, andrew@aj.id.au, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        patrick@stwcx.xyz, Jerry.Lin@quantatw.com, Eddie.Chen@quantatw.com,
        EasonChen1@quantatw.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 6:04=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 12/09/2023 16:05, yangchen.openbmc@gmail.com wrote:
> > From: Yang Chen <yangchen.openbmc@gmail.com>
> >
> > Add linux device tree entry related to the Minerva Chassis Management
> > Controller (CMC) specific devices connected to the Aspeed SoC (AST2600)=
.
> >
> > Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
> > ---
> >  arch/arm/boot/dts/aspeed/Makefile             |   1 +
> >  .../aspeed-bmc-facebook-minerva-cmc.dts       | 265 ++++++++++++++++++
> >  2 files changed, 266 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerv=
a-cmc.dts
> >
> > diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/
>
>
> > +
> > +&i2c15 {
> > +     status =3D "okay";
> > +
> > +     eeprom@50 {
> > +             compatible =3D "atmel,24c128";
> > +             reg =3D <0x50>;
> > +     };
> > +};
> > +
> > +&adc0 {
> > +     ref_voltage =3D <2500>;
>
> There is no such property in the bindings.

Hi Krzysztof,

I will change this property to the "aspeed,int-vref-microvolt" which
is defined in the binding that can choose the ADC internal reference
voltage is 1200000 or 2500000 =C2=B5V, and will add these changes to the v2
patches.

>
> > +     status =3D "okay";
> > +     pinctrl-0 =3D <&pinctrl_adc0_default &pinctrl_adc1_default
> > +             &pinctrl_adc2_default &pinctrl_adc3_default
> > +             &pinctrl_adc4_default &pinctrl_adc5_default
> > +             &pinctrl_adc6_default &pinctrl_adc7_default>;
> > +};
> > +
> > +&adc1 {
> > +     ref_voltage =3D <2500>;
>
> NAK, there is no such property.

I will change this property to the "aspeed,int-vref-microvolt" which
is defined in the binding that can choose the ADC internal reference
voltage is 1200000 or 2500000 =C2=B5V, and will add these changes to the v2
patches.

Thanks,
Yang Chen
