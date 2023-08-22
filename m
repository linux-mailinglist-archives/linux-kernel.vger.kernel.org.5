Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DDF783C4C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjHVI5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbjHVI5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:57:04 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435BFCD0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:56:34 -0700 (PDT)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 622163F18D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1692694589;
        bh=KsZAGBK8aBuJlkQpPFqYx4eAjZW/EbO7+eNh4lzjUK8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=LV4GQONUCJ8gUyyrkN2uF/mUVPdpAVRlQm7zqwb7WwdqkEPHJ6UkP8gX5XYwdAmGL
         RQIJadYuhYIw+cNkYtCXRVrfV5VeKp8jqbAIhq6N6/xfli6gaMMTOOCTff/YegMEbC
         GU4vA5ZjbolgUwmaHpnpmftImAK3KlqJugZvXOzCPYLNw9ESjJAm8sOmzTRR1Au3dv
         Wm0k26dGOFkLM6+VVV8MDcEX5pVRvjf9SrcV3dZadnF0LNPeV3X7QvTShxMzIiTWYl
         +5XbBp3TsELh6VbpXqk9kxehNrlyz0fF0cW/b2N1e0J/eBmGo9boc4CdvMZxsdf9nR
         t84in+VeqeFcw==
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-41087c90290so41889071cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692694588; x=1693299388;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KsZAGBK8aBuJlkQpPFqYx4eAjZW/EbO7+eNh4lzjUK8=;
        b=h7zRvu9Wy0mzmUC/YZPI+jZ6e7C8hHhdA5zF5Y46JOoso0dygx17t1rWXOHNXzSf9l
         Aigr5eCPxASayz7GHk4LC6A7ajkzGjXlMYKIuy0q65fiz1cmNdtlTZqnnpOMLz6s9er3
         yB3iw3+VLCPZwkEDA/xinYuNfu6Yb5zLfKxounHqaC5JKbcXMbUJTkhM7c4szbjkQHH/
         mw12d0Ufoy64foDkM8CTBa4ASGU18GRewSL+9hyQjSOFTresqAKurN10RBEWx+EEt4LO
         ZQq54WtAf0TUQ9l8EqtgYRSQTwk6xnQW4Jfz7fq14UnTdUYZmap8a+FYSa7MDnIT+0rW
         GNDg==
X-Gm-Message-State: AOJu0YxxZPKKo7vwT4KIKfH5F7kNOdiRvrgJi9HqCTj1U/MYeWsKZuXR
        k1vuWBZVYCalzX1o6q9XFfM+1iQHtgn2DiHb9UhMEyzZ2TuYDzVMwFX0bAb2BI17lRStJVuXmkf
        S/yS4hmsHF9PMWWP/BhUpL5ZW/aowplPFnNZKv5e7YyW5cQAN0G2OwOSjNA==
X-Received: by 2002:ac8:5787:0:b0:410:8c5f:52d6 with SMTP id v7-20020ac85787000000b004108c5f52d6mr12939352qta.14.1692694588421;
        Tue, 22 Aug 2023 01:56:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz+XeobfYaXTqusfmnM3w4yzTZ61pr2mb1iYxs26jyO6SMQfQwD2LuF4RCO/YSbJLBRAYjMwZ79K959JxrgqU=
X-Received: by 2002:ac8:5787:0:b0:410:8c5f:52d6 with SMTP id
 v7-20020ac85787000000b004108c5f52d6mr12939341qta.14.1692694588195; Tue, 22
 Aug 2023 01:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230821152915.208366-1-xingyu.wu@starfivetech.com>
 <CAJM55Z_XxHeC-X2d4qcsRK6THLyqWV4SsSW3S+cC8yszpPD9Og@mail.gmail.com> <07ddac3c-eb6e-d187-b942-102f117f8d13@starfivetech.com>
In-Reply-To: <07ddac3c-eb6e-d187-b942-102f117f8d13@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Tue, 22 Aug 2023 10:56:12 +0200
Message-ID: <CAJM55Z-gYpn_FjG2Zb__Nt=rbrNQN8QDNB=KEFdeVkz9Ptv72Q@mail.gmail.com>
Subject: Re: [PATCH v2] clk: starfive: jh7110-sys: Fix lower rate of CPUfreq
 by setting PLL0 rate to 1.5GHz
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2023 at 05:33, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
> On 2023/8/21 23:38, Emil Renner Berthing wrote:
> > On Mon, 21 Aug 2023 at 17:29, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
> >>
> >> CPUfreq supports 4 cpu frequency loads on 375/500/750/1500MHz.
> >> But now PLL0 rate is 1GHz and the cpu frequency loads become
> >> 333/500/500/1000MHz in fact.
> >>
> >> So PLL0 rate should be set to 1.5GHz. Change the parent of cpu_root clock
> >> and the divider of cpu_core before the setting.
> >>
> >> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> >> Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling for JH7110 SoC")
> >> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> >> ---
> >>
> >> Hi Stephen and Emil,
> >>
> >> This patch fixes the issue about lower rate of CPUfreq[1]
> >> and sets PLL0 rate to 1.5GHz. In order not to affect the cpu
> >> operation, the cpu_root's parent clock should be changed first.
> >> And the divider of the cpu_core clock should be set to 2 so they
> >> won't crash when setting 1.5GHz without voltage regulation.
> >
> > Hi Xingyu,
> >
> > It sounds like this is something the driver should handle
> > automatically whenever clk_set_rate() is called on the PLL0 clock.
> > Then we should be able to use regular assigned-clocks /
> > assigned-clock-rates stanzas in the device tree instead of having this
> > 1.5GHz rate hard-coded in the driver.
> >
> > /Emil
>
> Hi Emil,
>
> The frequency of PLL0 is set according to this process to avoid crash:
> 1. The divider of the cpu_core clock should be set to 2 if PLL0 is set to 1.5GHz.
> 2. The parent of cpu_root is changed from pll0 to osc.
> 3. The PLL0 is set to 1.5GHz.
> 4. The parent of cpu_root is changed from osc to pll0 back.
> I don't think assigned-clock-rates/assigned-clock-parents can do such a complicated job.

Right, but what I'm saying is that if calling clk_set_rate() on the
PLL0 clock causes a crash, that sounds like a bug in the driver. If
you fix that bug, and make clk_set_rate() on the PLL0 clock do the
procedure above when changing the rate, then the PLL0 clock can work
just like any other clock and assigned-clock-rates would work.

/Emil

>
> Best regards,
> Xingyu Wu
>
> >
> >> [1]: https://github.com/starfive-tech/VisionFive2/issues/55
> >>
> >> This patch is based on linux-next(20230818) which has merge PLL driver
> >> on the StarFive JH7110 SoC.
> >>
> >> Thanks,
> >> Xingyu Wu
> >>
> >> ---
> >>  .../clk/starfive/clk-starfive-jh7110-sys.c    | 47 ++++++++++++++++++-
> >>  1 file changed, 46 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> >> index 3884eff9fe93..b6b9e967dfc7 100644
> >> --- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> >> +++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> >> @@ -501,7 +501,52 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
> >>         if (ret)
> >>                 return ret;
> >>
> >> -       return jh7110_reset_controller_register(priv, "rst-sys", 0);
> >> +       ret = jh7110_reset_controller_register(priv, "rst-sys", 0);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       /*
> >> +        * Set PLL0 rate to 1.5GHz
> >> +        * In order to not affect the cpu when the PLL0 rate is changing,
> >> +        * we need to switch the parent of cpu_root clock to osc clock first,
> >> +        * and then switch back after setting the PLL0 rate.
> >> +        */
> >> +       pllclk = clk_get(priv->dev, "pll0_out");
> >> +       if (!IS_ERR(pllclk)) {
> >> +               struct clk *osc = clk_get(&pdev->dev, "osc");
> >> +               struct clk *cpu_root = priv->reg[JH7110_SYSCLK_CPU_ROOT].hw.clk;
> >> +               struct clk *cpu_core = priv->reg[JH7110_SYSCLK_CPU_CORE].hw.clk;
> >> +
> >> +               if (IS_ERR(osc)) {
> >> +                       clk_put(pllclk);
> >> +                       return PTR_ERR(osc);
> >> +               }
> >> +
> >> +               /*
> >> +                * CPU need voltage regulation by CPUfreq if set 1.5GHz.
> >> +                * So in this driver, cpu_core need to be set the divider to be 2 first
> >> +                * and will be 750M after setting parent.
> >> +                */
> >> +               ret = clk_set_rate(cpu_core, clk_get_rate(cpu_core) / 2);
> >> +               if (ret)
> >> +                       goto failed_set;
> >> +
> >> +               ret = clk_set_parent(cpu_root, osc);
> >> +               if (ret)
> >> +                       goto failed_set;
> >> +
> >> +               ret = clk_set_rate(pllclk, 1500000000);
> >> +               if (ret)
> >> +                       goto failed_set;
> >> +
> >> +               ret = clk_set_parent(cpu_root, pllclk);
> >> +
> >> +failed_set:
> >> +               clk_put(pllclk);
> >> +               clk_put(osc);
> >> +       }
> >> +
> >> +       return ret;
> >>  }
> >>
> >>  static const struct of_device_id jh7110_syscrg_match[] = {
> >> --
> >> 2.25.1
> >>
>
