Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B58B7DAC07
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 12:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjJ2LEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 07:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2LEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 07:04:34 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93ABCC0;
        Sun, 29 Oct 2023 04:04:31 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5b9390d6bd3so1822340a12.0;
        Sun, 29 Oct 2023 04:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698577471; x=1699182271; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eipiED5N5Zxq+cfbE7Nt7+p4CNXfmzDmQVeO71JBpOk=;
        b=CnHVpI+S+tUhB0QICZf9bK1XH8I+5We94hizl6JFZajQKlXcVTePnKBDPeyXLuKluz
         qqM0k4S1Jo2Z53K1SfwOGcVAdKXRUytvt46u0Hx+KIWuttuO84nM5KjwSaxNyk6zpfOZ
         dSn4vqy4VMFQ+kfnYygU3sf8ipIP2SNHAdnoCbNKZ7vwUujb6HILrJ6RwcwTUWUP7dXF
         nqkETZbZ/y+y7DktLwC+zxYyyQYd22XAMYa2JlG/EKiiGfDwFbopeOdVoYP6COtg7Tqn
         7Ljm8Uq/D0I1i64RLZJSUE148OjeQNhUu9WheXFArNQu2XwsOi+nhFwipdKWPffTwBMH
         MyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698577471; x=1699182271;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eipiED5N5Zxq+cfbE7Nt7+p4CNXfmzDmQVeO71JBpOk=;
        b=n45o6MzzvvZH2pebzq6K8WYJwgouA7Ez0CRnXb52LRBKlhm/IfabbqOY/KuWt/caY7
         UIpY0CBmU8UdRqPuEEG2vjzqkLdvLE9acYQP1w3OhCoj1bq2rIII9wp5AQjb+JaUIv52
         up+QoHtKfwA6wsk8GebQtDQG9z1G32zM3L3J1VrDEhrSQJrkrCDSE8x0ibKY048W/JO3
         bRzAi8bJhot0ZU0r3jAGQmVIIjUb9ebWqa6cpHufd/nBcAASEadkuUh7vDLMFdLeZoTT
         HgHr3HMK+opAZvn2Wr/j2vC2CKBEuVxkZXqC0Roit/JJ/6MKoiM1i/5X2g9G9RyBgr2N
         zq4A==
X-Gm-Message-State: AOJu0YwQQy/uc/y3Zxne5udDjige/UO5RmQxY2mYdgDFA4f+ARFqqL2/
        mHKodsAV/9eiK6bDILZU8zh5vNfTVqnMHC64CfBrtQjtKNA=
X-Google-Smtp-Source: AGHT+IHr4psGgXNsB0bVStvDoxnBk6i5SdbPIWiGxBaaF2NphlWQWrdx4NMwddymj0JG0CCldcVSn1/lCX3j637wpog=
X-Received: by 2002:a17:90a:f0c2:b0:280:299d:4b7e with SMTP id
 fa2-20020a17090af0c200b00280299d4b7emr4090103pjb.19.1698577470909; Sun, 29
 Oct 2023 04:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231025104457.628109-1-robimarko@gmail.com> <20231025104457.628109-2-robimarko@gmail.com>
In-Reply-To: <20231025104457.628109-2-robimarko@gmail.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Sun, 29 Oct 2023 12:04:19 +0100
Message-ID: <CAOX2RU4MBvDZZ767RPS9XKj0U2L3gviVG5cyR8NKyO4LD+sfYQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] clk: qcom: ipq6018: add USB GDSCs
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 at 12:45, Robert Marko <robimarko@gmail.com> wrote:
>
> IPQ6018 has GDSC-s for each of the USB ports, so lets define them as such
> and drop the curent code that is de-asserting the USB GDSC-s as part of
> the GCC probe.
>
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Unfortunately, after testing on multiple devices I hit the same GDSC
issue I had a long time ago
that was the reason I did not send this upstream.
It seems that USB3 port GDSC (USB0 GDSC in code) works just fine,
however the USB2 one
(USB1 GDSC in code) it is stuck off and USB2 port will fail due to this:
    1.607531] ------------[ cut here ]------------
[    1.607559] usb1_gdsc status stuck at 'off'
[    1.607592] WARNING: CPU: 0 PID: 35 at gdsc_toggle_logic+0x16c/0x174
[    1.615120] Modules linked in:
[    1.621712] CPU: 0 PID: 35 Comm: kworker/u8:1 Tainted: G        W
       6.6.0-rc7-next-20231026 #5
[    1.624586] Hardware name: Wallys DR6018 v4 (DT)
[    1.633867] Workqueue: events_unbound deferred_probe_work_func
[    1.638556] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    1.644200] pc : gdsc_toggle_logic+0x16c/0x174
[    1.651052] lr : gdsc_toggle_logic+0x16c/0x174
[    1.655566] sp : ffffffc081a03a40
[    1.659990] x29: ffffffc081a03a40 x28: 0000000000000000 x27: 0000000000000000
[    1.663384] x26: ffffff8000156ac0 x25: 0000000000000000 x24: ffffffc081824c90
[    1.670502] x23: ffffffc081824840 x22: 0000000000000000 x21: 0000000000000001
[    1.677620] x20: 00000000ffffff92 x19: ffffffc081824840 x18: ffffffffffffffff
[    1.684738] x17: 00000000cdb32eee x16: 00000000d648a142 x15: fffffffffffc38ff
[    1.691855] x14: ffffffc0817994c0 x13: 00000000000000e0 x12: 00000000000000e0
[    1.698974] x11: 00000000ffffffea x10: ffffffc0817f14c0 x9 : 0000000000000001
[    1.706094] x8 : 0000000000000001 x7 : 0000000000017fe8 x6 : c0000000ffffefff
[    1.713211] x5 : 0000000000057fa8 x4 : 0000000000000000 x3 : ffffffc081a03840
[    1.720328] x2 : ffffffc081799400 x1 : ffffffc081799400 x0 : 000000000000001f
[    1.727448] Call trace:
[    1.734556]  gdsc_toggle_logic+0x16c/0x174
[    1.736815]  gdsc_enable+0x60/0x27c
[    1.740980]  genpd_power_on+0x180/0x22c
[    1.744367]  __genpd_dev_pm_attach+0x140/0x238
[    1.748188]  genpd_dev_pm_attach+0x60/0x70
[    1.752701]  dev_pm_domain_attach+0x20/0x34
[    1.756780]  platform_probe+0x50/0xc0
[    1.760859]  really_probe+0x148/0x2b8
[    1.764679]  __driver_probe_device+0x78/0x12c
[    1.768327]  driver_probe_device+0xdc/0x160
[    1.772667]  __device_attach_driver+0xb8/0x134
[    1.776660]  bus_for_each_drv+0x70/0xb8
[    1.781173]  __device_attach+0xa0/0x184
[    1.784905]  device_initial_probe+0x14/0x20
[    1.788725]  bus_probe_device+0xac/0xb0
[    1.792891]  deferred_probe_work_func+0x88/0xc0
[    1.796712]  process_one_work+0x158/0x2bc
[    1.801226]  worker_thread+0x2a0/0x4bc
[    1.805391]  kthread+0xe4/0xf0
[    1.809035]  ret_from_fork+0x10/0x20
[    1.812075] ---[ end trace 0000000000000000 ]---

Kathiravan, do you happen to have any docs or info if the USB1 GDSC is special
and its status bits are broken or?

Maybe the offset is even wrong as I based it on the current driver.

Regards,
Robert

> ---
>  drivers/clk/qcom/Kconfig       |  1 +
>  drivers/clk/qcom/gcc-ipq6018.c | 33 ++++++++++++++++++++++++---------
>  2 files changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index ad1acd9b7426b..2aefa2231b51b 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -164,6 +164,7 @@ config IPQ_GCC_5332
>
>  config IPQ_GCC_6018
>         tristate "IPQ6018 Global Clock Controller"
> +       select QCOM_GDSC
>         help
>           Support for global clock controller on ipq6018 devices.
>           Say Y if you want to use peripheral devices such as UART, SPI,
> diff --git a/drivers/clk/qcom/gcc-ipq6018.c b/drivers/clk/qcom/gcc-ipq6018.c
> index cc20a16d8973c..9d5ee2ac012a1 100644
> --- a/drivers/clk/qcom/gcc-ipq6018.c
> +++ b/drivers/clk/qcom/gcc-ipq6018.c
> @@ -23,6 +23,7 @@
>  #include "clk-alpha-pll.h"
>  #include "clk-regmap-divider.h"
>  #include "clk-regmap-mux.h"
> +#include "gdsc.h"
>  #include "reset.h"
>
>  enum {
> @@ -4691,6 +4692,22 @@ static struct clk_branch gcc_dcc_clk = {
>         },
>  };
>
> +static struct gdsc usb0_gdsc = {
> +       .gdscr = 0x3e078,
> +       .pd = {
> +               .name = "usb0_gdsc",
> +       },
> +       .pwrsts = PWRSTS_OFF_ON,
> +};
> +
> +static struct gdsc usb1_gdsc = {
> +       .gdscr = 0x3f078,
> +       .pd = {
> +               .name = "usb1_gdsc",
> +       },
> +       .pwrsts = PWRSTS_OFF_ON,
> +};
> +
>  static const struct alpha_pll_config ubi32_pll_config = {
>         .l = 0x3e,
>         .alpha = 0x6667,
> @@ -5138,6 +5155,11 @@ static const struct qcom_reset_map gcc_ipq6018_resets[] = {
>         [GCC_Q6_AXIM_ARES] = {0x59110, 4},
>  };
>
> +static struct gdsc *gcc_ipq6018_gdscs[] = {
> +       [USB0_GDSC] = &usb0_gdsc,
> +       [USB1_GDSC] = &usb1_gdsc,
> +};
> +
>  static const struct of_device_id gcc_ipq6018_match_table[] = {
>         { .compatible = "qcom,gcc-ipq6018" },
>         { }
> @@ -5160,6 +5182,8 @@ static const struct qcom_cc_desc gcc_ipq6018_desc = {
>         .num_resets = ARRAY_SIZE(gcc_ipq6018_resets),
>         .clk_hws = gcc_ipq6018_hws,
>         .num_clk_hws = ARRAY_SIZE(gcc_ipq6018_hws),
> +       .gdscs = gcc_ipq6018_gdscs,
> +       .num_gdscs = ARRAY_SIZE(gcc_ipq6018_gdscs),
>  };
>
>  static int gcc_ipq6018_probe(struct platform_device *pdev)
> @@ -5170,15 +5194,6 @@ static int gcc_ipq6018_probe(struct platform_device *pdev)
>         if (IS_ERR(regmap))
>                 return PTR_ERR(regmap);
>
> -       /* Disable SW_COLLAPSE for USB0 GDSCR */
> -       regmap_update_bits(regmap, 0x3e078, BIT(0), 0x0);
> -       /* Enable SW_OVERRIDE for USB0 GDSCR */
> -       regmap_update_bits(regmap, 0x3e078, BIT(2), BIT(2));
> -       /* Disable SW_COLLAPSE for USB1 GDSCR */
> -       regmap_update_bits(regmap, 0x3f078, BIT(0), 0x0);
> -       /* Enable SW_OVERRIDE for USB1 GDSCR */
> -       regmap_update_bits(regmap, 0x3f078, BIT(2), BIT(2));
> -
>         /* SW Workaround for UBI Huyara PLL */
>         regmap_update_bits(regmap, 0x2501c, BIT(26), BIT(26));
>
> --
> 2.41.0
>
