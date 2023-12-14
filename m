Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C068135C0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443576AbjLNQJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjLNQJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:09:48 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CAC112
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:09:54 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-28b012f93eeso934218a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702570194; x=1703174994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZVsCOUCWp3r2s6KA7Me5wHvSzIEdtAlQPG+T626S2w=;
        b=EXhPnKduL+YxpIbEonb/Oym2yrGu1klih9TiqIHlsADbwGh3c08Ir4iMvAmReP4z4/
         RAf2DFc/1EtO3FIzAy90pqnehUoRlRNaLkgx4ulY5vC+3SxNB3kyB91Y9H/o7nvRLEWB
         7A1pbKved1g9/TgINRxgZzoU2UT4duJN69BbcDyaNYeAyHuoN3EUOwFI5SKXbmC6oDz6
         4FSqRbfadx2no25NAGLfhiGXmjwME3oIpkgl6Q56HginK0dvRt66KxpVlY+/jkDZhQ0b
         fNuT5D7NAAh5ZtAXZ3dmWOmSYl+8I4T0xRkv72j3WDHMfJ3dgYzjM9sxb0/Pdkg2WULR
         VnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702570194; x=1703174994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZVsCOUCWp3r2s6KA7Me5wHvSzIEdtAlQPG+T626S2w=;
        b=q7KCG1xrFZ0QQWjVYof7ObUq7G88+yNVQVHlSqXLXfX4ZkLsV2TjSpiBJaA/OQ6Wj/
         qmGjyL3+Ox333TrFKsrjuq+4aoA4/VQyn3IXjpTFURxWrdUgbS5BtBK0dlpa2Q3PHqq/
         Lk6SlU8rqUoM+19OdkQ6pHfGt5g+HIc51nkjqOTJL4TvTDoqMRx9wCkgiaxCqhLU2RrH
         HuNYjiLTVDbZUpGgqi+JtlOpzP3aXlhM4K0U/qKzHNxxRP/7lcfexVN8KbHmVpZeiAwH
         IKJf0S9I7qZTgwAD1Kes5YUWwRSVAjes1mWFwarKhXvB/OdEb8nBl3KXZFDG7MbYVXFH
         gW9Q==
X-Gm-Message-State: AOJu0YxGvkCs1VYAbTfamx2gLSYvUClKtrNAvRIgmQq7ZEBesfab2wzd
        dXJ7Tsc5Es+S0/eZVn6tT4Lte1vMQ9G/f2bPi+amEQ==
X-Google-Smtp-Source: AGHT+IHgafXcl6uWTefWFIJRyeqXdrYGV5RXS8+kJHFhH0PuyZUdD/H20OtjnIZrJjKb8ef0Vtp3nDt4ll1PDFL+Jro=
X-Received: by 2002:a17:90b:46:b0:28b:9a5:d159 with SMTP id
 d6-20020a17090b004600b0028b09a5d159mr527734pjt.50.1702570193686; Thu, 14 Dec
 2023 08:09:53 -0800 (PST)
MIME-Version: 1.0
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
 <20231214105243.3707730-8-tudor.ambarus@linaro.org> <CAPLW+4mNjCbJ+VbKR66DFSkiXHyxdjgvwjN7azxjJQ6UxQikEw@mail.gmail.com>
 <f3d61c49-1a46-476c-b7a5-6cc6a06a33ed@linaro.org>
In-Reply-To: <f3d61c49-1a46-476c-b7a5-6cc6a06a33ed@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 14 Dec 2023 10:09:42 -0600
Message-ID: <CAPLW+4=tyr8Pcoe6Wm0Wtmkk4udDpuAiOKy7+C+Fwa6mvt3VoQ@mail.gmail.com>
Subject: Re: [PATCH 07/13] clk: samsung: gs101: mark PERIC0 IP TOP gate clock
 as critical
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     peter.griffin@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org, andi.shyti@kernel.org,
        alim.akhtar@samsung.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        s.nawrocki@samsung.com, tomasz.figa@gmail.com,
        cw00.choi@samsung.com, arnd@arndb.de, andre.draszik@linaro.org,
        saravanak@google.com, willmcvicker@google.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 10:01=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linar=
o.org> wrote:
>
>
>
> On 12/14/23 15:37, Sam Protsenko wrote:
> > On Thu, Dec 14, 2023 at 4:52=E2=80=AFAM Tudor Ambarus <tudor.ambarus@li=
naro.org> wrote:
> >>
> >> Testing USI8 I2C with an eeprom revealed that when the USI8 leaf clock
> >> is disabled it leads to the CMU_TOP PERIC0 IP gate clock disablement,
> >> which then makes the system hang. To prevent this, mark
> >> CLK_GOUT_CMU_PERIC0_IP as critical. Other clocks will be marked
> >> accordingly when tested.
> >>
> >> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> >> ---
> >>  drivers/clk/samsung/clk-gs101.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk=
-gs101.c
> >> index 3d194520b05e..08d80fca9cd6 100644
> >> --- a/drivers/clk/samsung/clk-gs101.c
> >> +++ b/drivers/clk/samsung/clk-gs101.c
> >> @@ -1402,7 +1402,7 @@ static const struct samsung_gate_clock cmu_top_g=
ate_clks[] __initconst =3D {
> >>              "mout_cmu_peric0_bus", CLK_CON_GAT_GATE_CLKCMU_PERIC0_BUS=
,
> >>              21, 0, 0),
> >>         GATE(CLK_GOUT_CMU_PERIC0_IP, "gout_cmu_peric0_ip", "mout_cmu_p=
eric0_ip",
> >> -            CLK_CON_GAT_GATE_CLKCMU_PERIC0_IP, 21, 0, 0),
> >> +            CLK_CON_GAT_GATE_CLKCMU_PERIC0_IP, 21, CLK_IS_CRITICAL, 0=
),
> >
> > This clock doesn't seem like a leaf clock. It's also not a bus clock.
> > Leaving it always running makes the whole PERIC0 CMU clocked, which
> > usually should be avoided. Is it possible that the system freezes
> > because some other clock (which depends on peric0_ip) gets disabled as
> > a consequence of disabling peric0_ip? Maybe it's some leaf clock which
> > is not implemented yet in the clock driver? Just looks weird to me
> > that the system hangs because of CMU IP clock disablement. It's
> > usually something much more specific.
>
> The system hang happened when I tested USI8 in I2C configuration with an
> eeprom. After the eeprom is read the leaf gate clock that gets disabled
> is the one on PERIC0 (CLK_GOUT_PERIC0_CLK_PERIC0_USI8_USI_CLK). I assume
> this leads to the CMU_TOP gate (CLK_CON_GAT_GATE_CLKCMU_PERIC0_IP)
> disablement which makes the system hang. Either marking the CMU_TOP gate
> clock as critical (as I did in this patch) or marking the leaf PERIC0
> gate clock as critical, gets rid of the system hang. Did I choose wrong?
>

Did you already implement 100% of clocks in CMU_PERIC0? If no, there
is a chance some other leaf clock (which is not implemented yet in
your driver) gets disabled as a result of PERIC0_IP disablement, which
might actually lead to that hang you observe. Usually it's some
meaningful leaf clock, e.g. GIC or interconnect clocks. Please check
clk-exynos850.c driver for CLK_IS_CRITICAL and CLK_IGNORE_UNUSED flags
and the corresponding comments I left there, maybe it'll give you more
particular idea about what to look for. Yes, making the whole CMU
always running without understanding why (i.e. because of which
particular leaf clock) might not be the best way of handling this
issue. I might be mistaken, but at least please check if you
implemented all clocks for PERIC0 first and if making some meaningful
leaf clock critical makes more sense.

> Thanks,
> ta
> >
> >>         GATE(CLK_GOUT_CMU_PERIC1_BUS, "gout_cmu_peric1_bus",
> >>              "mout_cmu_peric1_bus", CLK_CON_GAT_GATE_CLKCMU_PERIC1_BUS=
,
> >>              21, 0, 0),
> >> --
> >> 2.43.0.472.g3155946c3a-goog
> >>
