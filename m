Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE6578A498
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 04:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjH1CZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 22:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjH1CZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 22:25:25 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB45D8;
        Sun, 27 Aug 2023 19:25:23 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5298e43bb67so5695835a12.1;
        Sun, 27 Aug 2023 19:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693189521; x=1693794321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uCqSe5BtqveCUXWZraiTGYO03+jzgwg7ae/wj5X+p4=;
        b=Rs3o3lwnQlpCEgSLIhsuXQgDmYUY4nedQrR0H5FZ8oTW0MZRjTIwXBAPZ+XJu3G+TE
         5KjGSKsVuufTscOJKZYMJ0KS9kzz7Xyep4wKl3+TVKixZzHm9nNNmppNSYgB6pYYp8wo
         2RELcBP24h5WR7o6jlsDO44dmgK9Rx1V/rHeb5kqpg0aMZd+1c1fYnPO/kg2TIDgRiRO
         F6FsxT3p+yiDRZpYEihMKhJw4/CBMdGfU1djfnZwE5niVYTe2vjJramAzelc7971T3gV
         Ybsa3YcfCZr8kK6KmUBRZmdwfO/lSvmWuPcvibJK6pARqe0eHe8I8aasMcaQku+BGBpB
         lOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693189521; x=1693794321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3uCqSe5BtqveCUXWZraiTGYO03+jzgwg7ae/wj5X+p4=;
        b=loty176zXbuvP1FUdD2B1stkbLL0mY3Dp6/W4Dax59XfsQIx9KI1fvl9Hd7v+U2zf3
         P5Fk3eLauCjbOUumb7/uU20oDfsC/Rn0Rf9JljhIGe2W/OiM/omjVV56GHMV6xMmEWKL
         SV2fNBvmNVUID61rZ+5ruB2P9x5KsYHtRrTSadHXVt6vbAQe8IWkknhgtVgLMtsr38EC
         5dhc9UBJhfUxJT1qYMEKMcu33YSXJkaqjdPAA57DTpDY96eQe6Y/MYchMKv3pN+LqJHz
         hdYEJ/dfymUli/75E/ZVZL+JPXNj+ijGCWClZh8Bk5+uVK6+Ukmjr8F6ws2ABrte6NCY
         p99Q==
X-Gm-Message-State: AOJu0Yz1xr+hAK7NfWqvF5uvLyHKF8bW4Kp6Mj5Qm694KGyr9FizFjTB
        gg4tjUhVhK5s+Wt07EC2zMKTt8a74NLbJ1xce98=
X-Google-Smtp-Source: AGHT+IFjV4c6iPT2oORQcm92nmX2L7ZxJD/Ip41JWUNWiITPNAyX6af0+kocn3phLX4sb40+kQJXCmdDRW8aRdq8dR4=
X-Received: by 2002:a05:6402:d56:b0:525:4d74:be8c with SMTP id
 ec22-20020a0564020d5600b005254d74be8cmr21355835edb.14.1693189521348; Sun, 27
 Aug 2023 19:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230822082750.27633-1-yu.tu@amlogic.com> <70b3ba82-0920-4613-9480-919a3df6833c@linux.com>
In-Reply-To: <70b3ba82-0920-4613-9480-919a3df6833c@linux.com>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Mon, 28 Aug 2023 10:24:45 +0800
Message-ID: <CAJhJPsWASjw-QiTocaJZCF5HYHUnF7xVf-o7Ohj0Mgjq0OpsLA@mail.gmail.com>
Subject: Re: [PATCH V10 0/4] Add S4 SoC PLLs and Peripheral clock
To:     Lucas Tanure <tanure@linux.com>
Cc:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        kelvin.zhang@amlogic.com, qi.duan@amlogic.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 1:34=E2=80=AFAM Lucas Tanure <tanure@linux.com> wro=
te:
>
> On 22-08-2023 09:27, Yu Tu wrote:
> > 1. Add S4 SoC PLLs and Peripheral clock controller dt-bindings.
> > 2. Add PLLs and Peripheral clock controller driver for S4 SOC.
> >
> >
> > Yu Tu (4):
> >    dt-bindings: clock: document Amlogic S4 SoC PLL clock controller
> >    dt-bindings: clock: document Amlogic S4 SoC peripherals clock
> >      controller
> >    clk: meson: S4: add support for Amlogic S4 SoC PLL clock driver
> >    clk: meson: S4: add support for Amlogic S4 SoC peripheral clock
> >      controller
> >
> > V9 -> V10:
> > 1. Change the relevant S4 CLK patch based on Neil's recently modified
> > patch.
> > 2. Change patch 0003/0004 clocks comment, format and clock flags sugges=
ted
> > by Jerome.
> >
> > V8 -> V9: Add patch 0001/0002 dt-bindings tag. Suggested by Krzysztof.
> > V7 -> V8:
> > 1. Change patch 0001/0002 dt-bindings title description, remove "meson"=
.
> > Suggested by Dmitry, Neil.
> > 2. Change patch 0003/0004 clocks comment, format and clock flags sugges=
ted by
> > Dmitry, Neil, Jerome.
> >
> > V6 -> V7: Change send patch series as well change format and clock flag=
s
> > suggested by Jerome. Change dt-bindings suggested by Krzysztof.
> > V5 -> V6: Change send patch series, as well change format and clock fla=
gs.
> > V4 -> V5: change format and clock flags and adjust the patch series
> > as suggested by Jerome.
> > V3 -> V4: change format and clock flags.
> > V2 -> V3: Use two clock controller.
> > V1 -> V2: Change format as discussed in the email.
> >
> > Link:https://lore.kernel.org/linux-amlogic/20230517070215.28463-1-yu.tu=
@amlogic.com/
> >
> >   .../clock/amlogic,s4-peripherals-clkc.yaml    |   96 +
> >   .../bindings/clock/amlogic,s4-pll-clkc.yaml   |   49 +
> >   drivers/clk/meson/Kconfig                     |   23 +
> >   drivers/clk/meson/Makefile                    |    2 +
> >   drivers/clk/meson/s4-peripherals.c            | 3787 ++++++++++++++++=
+
> >   drivers/clk/meson/s4-peripherals.h            |   57 +
> >   drivers/clk/meson/s4-pll.c                    |  867 ++++
> >   drivers/clk/meson/s4-pll.h                    |   38 +
> >   .../clock/amlogic,s4-peripherals-clkc.h       |  236 +
> >   .../dt-bindings/clock/amlogic,s4-pll-clkc.h   |   43 +
> >   10 files changed, 5198 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4=
-peripherals-clkc.yaml
> >   create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4=
-pll-clkc.yaml
> >   create mode 100644 drivers/clk/meson/s4-peripherals.c
> >   create mode 100644 drivers/clk/meson/s4-peripherals.h
> >   create mode 100644 drivers/clk/meson/s4-pll.c
> >   create mode 100644 drivers/clk/meson/s4-pll.h
> >   create mode 100644 include/dt-bindings/clock/amlogic,s4-peripherals-c=
lkc.h
> >   create mode 100644 include/dt-bindings/clock/amlogic,s4-pll-clkc.h
> >
> >
> > base-commit: bd0f6c57c2b324b6f92ccfe13a8005ff829287b8
> How similar is T7 and S4 regarding the clocks?
> Can S4 clock driver be used by T7 without modifications?
>
Unfortunately not.
But don't worry! The T7 clock driver is coming soon.

> Thanks
> Lucas



--=20
Best regards,

Keguang Zhang
