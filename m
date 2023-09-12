Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D2B79C3ED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241788AbjILDRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242551AbjILDRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:17:36 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56B01A1E83;
        Mon, 11 Sep 2023 19:02:07 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4cbso6394352a12.1;
        Mon, 11 Sep 2023 19:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694484126; x=1695088926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epewbgX/K4Am+Kd8gRoNoUs4L1M4qxFvFXC2iZuyWec=;
        b=dHAqaRrtTgSxfnCA+aftkMLs2aTMarlKe461hzIuaPro3M9PHJK5eiqebv6anfuTVV
         OwYt886F68mFRxh66kBDv5QFDrjTWlrh5AeY27FoFws31Zsb+yWYo5ZBP4gtIWPxu7hm
         KcCdMcRSypHiVWTH3KcrGIcC8cwI4xP+pwXTSQ+hUpCAWV1bvqYSHXSrswy33GN16LfU
         rZZDoKWZiqI9AOg0ghgc2Q+aHFMfIUxkRensdNfo12/se6asyONPl/RRQ00XrPleZtWo
         O8NOfalBHiFu7kSRq5HLgSSw5nAJF7xq6Vl6J/srPFVGuHT/FPIPYLb4wzsQgkZaa+2j
         344g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694484126; x=1695088926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epewbgX/K4Am+Kd8gRoNoUs4L1M4qxFvFXC2iZuyWec=;
        b=duWFJH5/lVjLnjHof+3IAC4GeM6lY6GazBl3EOgbYHRi5tyPU7BissTzsFlG1wUSE7
         5tZg7cy9PeKhQ4dAaSbyynvH/nf2zkuNDexDUH4/3dbaZFOj8xnse3v3G2BVi03E5lnU
         RV2grPp4Gfzlnz0i0SyxeJuxqmCh+2/ToIS8pi6eWJs3hQ6y74NhYfTX0slSTtX5QKyC
         8bqksHjqgbqOtz4dWvSxuVi+uku6z7YRa/KmBhpdJVsDtHK3uSK/IM4S5jMYmElYSIUC
         G/NogBPH49wKRTIzc5zak74AO7p9cYnt+eZXMq/89QkWntOymcnhnsKA+9j3X1J4U0cC
         pD9g==
X-Gm-Message-State: AOJu0YxlXFeixC2801z0s3SHL9znoNtfLvQcMn6QHb6ckI6s25FS4L1N
        Kguze6v0+xUdXcmNLT2zO7JItmJc2bG8cV3jmkw=
X-Google-Smtp-Source: AGHT+IFcEC5FSLG0o3s5Gs7rQBUMqOFyC1Wk1Hg7h/6eVgO6bM2HrtCt2SGgE00CKQap/7WAzhPco5bNsePPtv/4CVs=
X-Received: by 2002:aa7:d9c8:0:b0:525:6666:3551 with SMTP id
 v8-20020aa7d9c8000000b0052566663551mr8738406eds.27.1694484126041; Mon, 11 Sep
 2023 19:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230830134241.506464-1-keguang.zhang@gmail.com>
 <20230830134241.506464-4-keguang.zhang@gmail.com> <c94138d2-1bfa-2815-a766-b7904e35a86f@linaro.org>
In-Reply-To: <c94138d2-1bfa-2815-a766-b7904e35a86f@linaro.org>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Tue, 12 Sep 2023 10:01:29 +0800
Message-ID: <CAJhJPsV6BomVsZRYHNwvVzWJCWzssfcHzWBwGdYZ5Csh2oaoow@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] net: stmmac: Add glue layer for Loongson-1 SoC
To:     =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 6:48=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 30/8/23 15:42, Keguang Zhang wrote:
> > This glue driver is created based on the arch-code
> > implemented earlier with the platform-specific settings.
> >
> > Use syscon for SYSCON register access.
> >
> > Partially based on the previous work by Serge Semin.
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> > V3 -> V4: Drop ls1x_dwmac_syscon definition and its instances
> >            Drop three redundant fields from the ls1x_dwmac structure
> >            Drop the ls1x_dwmac_init() method.
> >            Some minor improvements
> > V2 -> V3: Determine the device ID by physical
> >            base address(suggested by Serge Semin)
> >            Use regmap instead of regmap fields
> >            Use syscon_regmap_lookup_by_phandle()
> >            Some minor fixes
> > V1 -> V2: Fix the build errors due to CONFIG_OF being unset
> >            Change struct reg_field definitions to const
> >            Rename the syscon property to "loongson,dwmac-syscon"
> >            Add MII PHY mode for LS1C
> >
> >   drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
> >   drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
> >   .../ethernet/stmicro/stmmac/dwmac-loongson1.c | 219 +++++++++++++++++=
+
> >   3 files changed, 231 insertions(+)
> >   create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson=
1.c
>
> Squash:
>
> -- >8 --
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ff1f273b4f36..2519d06b5aab 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14344,9 +14344,12 @@ MIPS/LOONGSON1 ARCHITECTURE
>   M:    Keguang Zhang <keguang.zhang@gmail.com>
>   L:    linux-mips@vger.kernel.org
>   S:    Maintained
>   F:    Documentation/devicetree/bindings/*/loongson,ls1x-*.yaml
>   F:    Documentation/devicetree/bindings/net/loongson,ls1*.yaml
>   F:    arch/mips/include/asm/mach-loongson32/
>   F:    arch/mips/loongson32/
>   F:    drivers/*/*loongson1*
> +F:     drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
> ---

Will do.
Thanks!

--=20
Best regards,

Keguang Zhang
