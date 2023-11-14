Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18A27EB04F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjKNMxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbjKNMwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:52:54 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87E7D68
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 04:52:49 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-dafe04717baso1382357276.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 04:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699966369; x=1700571169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dm5tIBxlFob9g4Fl4wFAfi9oUFoS3/1CELy15DVM1mI=;
        b=IUva1w1nEizlrvNSoUb3UCdQBfVmQ5Q4YZp7nEJb92vakCXDD3tvM56YuNFWj73t56
         TOoZ95mU9fpkZD2KzIW51MFjmpbE6+hIE3T+so0B1GAhA59XFPmZTZSjSDtLr8mydiBn
         Ef9QF2o6CrkfgsAZcZmj+S4j8KOM99mRlpubKhiM/m53A3QLZcc5PUzMkjqGMDY8tRdu
         PS8vjaJPg0kpvBHmKGd8zxZQbZXG+Bwl+WJuQcx5XkAv1XEgI7/vnmvOcFgAVwjfcR2L
         th8L1YtixZdLUKGq3erttfLhik3qL8eBf1l3jQIVwmRRUC1q/x+O6K6Hk1CZ3y4DfDHl
         jIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699966369; x=1700571169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dm5tIBxlFob9g4Fl4wFAfi9oUFoS3/1CELy15DVM1mI=;
        b=JkudenA5/07ZKFnP4YbIx72BJNJjh+RcTSBFb1LkvIQg8qbx+2XVXHo93DXoHld6dC
         FxGPRbnk/aj0jIAu7nAm+z1Fsj7fTGQrTHQBBCxXXtNg0SnCExnOHJ2w9U1XGYWpht2O
         QnkO5xqampzFPIpjVoUkSXkqzxTsWNrQg/dmNUCc80vjm8NHfbyBR4qCbSzulWlDSfx7
         PG8E+X4NRhcM48EoGDsvGIZu/EpG6sDpilsgqEekFUAhHYRyfx6m63Lg9rO5FCUgo7wB
         c4YZTIffTRxDZ/zpfEpj8p0XREvnqj7tMOdYTQDy/k3tCWA1ocgRczrZ1yKTilQ9VPH4
         yc/Q==
X-Gm-Message-State: AOJu0Ywxgf3JnUoj6D82KV3+D3QqfH7ToMCKFDFwS3ThFM5vMlxRMp+m
        Dn1mAkoGu6w1DOccCEbUTTug7ul6YROv5va2U+L4ig==
X-Google-Smtp-Source: AGHT+IHb5y2/nAMzpAAbpcAqsc2332J3Hl+TEbnJYw6VgROQL9pFrDJMQLjA7DxF+w42E0bHCOIHzfYDBAjoO7yaXoA=
X-Received: by 2002:a25:6951:0:b0:da3:ab41:2fc8 with SMTP id
 e78-20020a256951000000b00da3ab412fc8mr8347458ybc.16.1699966368706; Tue, 14
 Nov 2023 04:52:48 -0800 (PST)
MIME-Version: 1.0
References: <CGME20231031095014epcas2p2814fa2bb5f940ccb0d0951667df34f98@epcas2p2.samsung.com>
 <20231031094852.118677-1-jaewon02.kim@samsung.com> <CACRpkdZRMJgWkLwKstpN_9=VGutbE1wBv+X_a15RJ=7ddNtbHw@mail.gmail.com>
 <15d9340a-dd4f-43fc-96c6-f6a8daf76e11@linaro.org>
In-Reply-To: <15d9340a-dd4f-43fc-96c6-f6a8daf76e11@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Nov 2023 13:52:36 +0100
Message-ID: <CACRpkdYrJMnJLHa1+Vtga3WdYySx9ioGzqmnf1uZKGdBxEWa_Q@mail.gmail.com>
Subject: Re: [PATCH 00/10] Introduce ExynosAutov920 SoC and SADK board
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 8:59=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 13/11/2023 15:11, Linus Walleij wrote:
> > Hi Jaewon,
> >
> > thanks for your patches!
> >
> > On Tue, Oct 31, 2023 at 10:50=E2=80=AFAM Jaewon Kim <jaewon02.kim@samsu=
ng.com> wrote:
> >
> >>   dt-bindings: pinctrl: samsung: add exynosautov920 pinctrl binding
> >>   pinctrl: samsung: add exynosautv920 pinctrl
> >
> > It is best if I can apply these two separately once Krzysztof is happy
> > with them. I hope that would work? I don't see any specific dependencie=
s.
>
> That's fine. I might have conflicting pieces in-flight, but then I'll
> funnel these through you as well. I can apply these to my
> samsung-pinctrl tree and send them to you as usual, unless you prefer to
> apply yourself.

Oh that's best of course, you take them when you think they are ready.

I was more referring to that we should be able to merge the two pin control
patches apart from the rest of the series.

Yours,
Linus Walleij
