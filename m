Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EAF7537D5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbjGNKTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbjGNKS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:18:56 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D49358C;
        Fri, 14 Jul 2023 03:18:40 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a40b756eb0so1075351b6e.2;
        Fri, 14 Jul 2023 03:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689329919; x=1691921919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5S/Su+LnonQlJtv6h9aSSkyuGTPnasq4Gs6B9RnTFM=;
        b=VNRWJ0vyETvMhGB3+48qAa5PT2NK/MARU30eKt5SIUMCo36TbT07+MGuFWUOU75kwn
         9N4ENPVsAiqeCos8lwVFUgNCbBqN4VghsOWOcMLGJU0C6eWmxpLLOFb5temWQPOvvnyf
         d+MBkEw/eV+X5Hy0BBNvVVLtTwavKPVuHAvJDEx2gksI45eodF27o+ZSmmXcF1WMEreI
         TqLFQ1l3LJdeF9wJgPds1M24aiNnAGP2CwN2KYO9TcIczutklkOTHFS5LlZbXNHPaOuy
         sifBZhHGvU1fviBCC4xY91oOZqMghBO6flASgNI9qJgpNGDp56Y6SyNqJCNkVHYpp8Tr
         GQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689329919; x=1691921919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5S/Su+LnonQlJtv6h9aSSkyuGTPnasq4Gs6B9RnTFM=;
        b=DIWftiVk3G0Jw465u9czy8fko4b0Bth8DLlUgnZemU6S9QOZ36tW4DM7NegeXKMReX
         fmSoIyuIRaSwke+Mn6bHVA22F6SN40IftAk1qEYhBa+ckkR2BUGK9MLfDC6FLAmsUvdL
         T78ZZ0UeNxOKZmDiA9vSM/wYNGPHc0PmfMaN9GIk/UcEEr7dSU8gdZZHNqpbLyPvAMjt
         FoDekVafzAnv5uyuciJS8iOg9LoG9MhIcDYe0dOpwnWFOP+X/2mxFY+bLKsHhmfF4nVE
         y2wfJNQamZgeLmJxztZt4QJXl3PU7SyOlGqYOjaJk7k+NLY+DtOmCI268LB+vEXYitml
         MVWw==
X-Gm-Message-State: ABy/qLYxlTLZp06wpA8xeLY2dfct76VDVXCuvNzXIHi52XrdtiGoBqjq
        MHK66tqdB3YQdIrcvcKdHxffFkQVDTpo+4EeBcA=
X-Google-Smtp-Source: APBJJlFnmD26TrqVTOxm7Zyo2EOzSV61byUJyWgGAvIuT7uv/IVd5NbGKL7x4j5UPbh+Zfun/v4Fdt3+B1C0/pI0qWQ=
X-Received: by 2002:a05:6808:13cf:b0:3a3:820e:2f05 with SMTP id
 d15-20020a05680813cf00b003a3820e2f05mr4930470oiw.1.1689329919411; Fri, 14 Jul
 2023 03:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAGUgbhCqOJaEPjS96o2au21uW4NhqFScm4Ayd8PzOQvqxQ94SQ@mail.gmail.com>
 <0b9dd5cf-f4ca-2e6b-624d-0b451bbc2f30@linaro.org> <0ba3767c-d481-6e2c-2d32-b79af0e1efd8@roeck-us.net>
In-Reply-To: <0ba3767c-d481-6e2c-2d32-b79af0e1efd8@roeck-us.net>
From:   =?UTF-8?B?6JSh5om/6YGU?= <billyking19920205@gmail.com>
Date:   Fri, 14 Jul 2023 18:18:28 +0800
Message-ID: <CAGUgbhC34-pUp4ECULc0ScaN7hUF1L-z69h+ji-TiVrv4gKd3Q@mail.gmail.com>
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
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:59=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 7/14/23 00:13, Krzysztof Kozlowski wrote:
> > On 14/07/2023 09:04, =E8=94=A1=E6=89=BF=E9=81=94 wrote:
> >
> >>          > This is because our register layout for PWM and Tach is not
> >> continuous.
> >>
> >>          > PWM0 used 0x0 0x4, Tach0 used 0x8 0xc
> >>
> >>          > PWM1 used 0x10 0x14, Tach1 used 0x18 0x1c
> >>
> >>          > ...
> >>
> >>          > Each PWM/Tach instance has its own controller register and =
is not
> >> dependent on others.
> >
> > Your email reply quoting style is very difficult to read.
> >
> >>
> >>
> >>
> >> Hi Guenter,
> >>
> >>
> >>
> >> Did you receive a response to my previous email?
> >>
> >> I would like to inquire if you have any further concerns regarding the=
 PWM
> >> and Tach with 16 instances.
> >
> > But isn't like this in all PWMs in all SoCs?
> >
>
> Correct, pretty much every fan controller is implemented that way.
> I don't understand the logic.
>

Hi Krzysztof and Guenter,

Apologies for any confusion earlier.
So, you think that the implementation with 16 instances of TACH/PWM
device nodes in dts instead of one is ok to you, right?

Thanks

Best regards,
Billy Tsai
