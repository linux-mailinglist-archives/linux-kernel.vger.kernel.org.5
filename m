Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8859F7A4046
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 07:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239472AbjIRFB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 01:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjIRFAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 01:00:55 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23BFAC;
        Sun, 17 Sep 2023 22:00:49 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-274c05edb69so473997a91.2;
        Sun, 17 Sep 2023 22:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695013249; x=1695618049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVNF5sAoH2+S/vs1X3i/qSh9lM2MoEqXJhGdzFOpd3Y=;
        b=EIplKW9LURVX+E4g1KdCgDxlQUbVjAoQvLJ14xk4IhauKfPzBhFkirWd/5U/TQ+XAi
         4Z1LEvrKTFbPq+3D7oWm2aFrAhzdRxufE4DFcQbfdK5FoMs29TCWxfxH6c9aDzN1Z3mL
         LMv9TtoqRX/8d6SRC98eW9aMxvtaA9Fvq2UsVLLMTNcfAABBt75uNElHz677b220dE3c
         NVaEZX13drF7hnLkBRFmgvedvaFXk9k0N+UOm7Qy5pzzIsUZ7tPMei8DtWNK5hmaXX6c
         kGT/ZY+rp8iuAftv2S6zcXM/5WvdrUVjxiS1jo+UOYxhLLtQ4IQ32WqNBUPC10vongHz
         57bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695013249; x=1695618049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVNF5sAoH2+S/vs1X3i/qSh9lM2MoEqXJhGdzFOpd3Y=;
        b=O/PMFFsH+zIIdXmjffJMFbYL5m2xeMbmD2p1EX/oIwwUzw/VkKMFSGle6BV640K+K7
         N/vOL+aM+fd6+N7T8MQavbOqw2BlqGcSU6q8qHdgsJVWsGyZu4+1z95Z6mOeQ9SNfjdb
         dFjzFNWt1VItNHEtFOrj9qZjBpIAm/wb905l9Qk4FhUeoh5LUXO8ZrNHUrc7+EbEk2Tu
         uDEQBsELFWVM76XXvo1lH89VcxN3NPWks0DetjxxSGHjW47jl3qpFG0pMXAD+H1/qk3C
         d/6A475dqzsWT74Cb1qgG4YJmyaxrhML4+VlNYG6zcByMxQhIMw8AFTKz9xjQPBiJUWW
         J+fw==
X-Gm-Message-State: AOJu0Yx0sUN8R9XQKg+ORL3kSgYZfz/UX830lcDl2LOLgiONfP/7+owJ
        F5FU6wdJ+nWgTvc09sP18sKOGxzq5T5JNY/zEJk=
X-Google-Smtp-Source: AGHT+IFI+iihCDqE8YIc6IjinrCImEQ/bsS70zAv7j9bLn5alZdsPVXi1Rds61BqWssOaMz8RfFx/UcWxVyd/5Ob+VE=
X-Received: by 2002:a17:90a:3ea5:b0:276:6b9d:7503 with SMTP id
 k34-20020a17090a3ea500b002766b9d7503mr995967pjc.28.1695013249158; Sun, 17 Sep
 2023 22:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com>
In-Reply-To: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 17 Sep 2023 22:00:37 -0700
Message-ID: <CAHCN7xJ8KrBd-532=gDE+82xo1ZNtoDT7pZsYwy9-9WiJvmkvw@mail.gmail.com>
Subject: Re: [PATCH 00/13] imx8mp: first clock propagation attempt (for LVDS)
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Frank Oltmanns <frank@oltmanns.dev>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2023 at 3:40=E2=80=AFPM Benjamin Bara <bbara93@gmail.com> w=
rote:
>
> Hi!
>
> Target of this series is to dynamically set the rate of video_pll1 to
> the required LVDS clock rate(s), which are configured by the panel, and
> the lvds-bridge respectively.
>
> Some background:
> The LVDS panel requires two clocks: the crtc clock and the lvds clock.
> The lvds rate is always 7x the crtc rate. On the imx8mp, these are
> assigned to media_disp2_pix and media_ldb, which are both
> clk-composite-8m. The rates are set by drm_client_modeset_commit() (and
> later by fsl_ldb_atomic_enable()), and the fsl-ldb driver, first crtc,
> then lvds. The parent is typically assigned to video_pll1, which is a
> clk-pll14xx (pll1443x).
>
> The main problem:
> As the clk-composite-8m currently doesn't support CLK_SET_RATE_PARENT,
> the crtc rate is not propagated to video_pll1, and therefore must be
> assigned in the device-tree manually.
>
> The idea:
> Enable CLK_SET_RATE_PARENT, at least for media_disp2_pix and media_ldb.
> When this is done, ensure that the pll1443x can be re-configured,
> meaning it ensures that an already configured rate (crtc rate) is still
> supported when a second child requires a different rate (lvds rate). As

Have you tested with the DSI as well?  If memory servers, the DSI
clock and the LVDS clock are both clocked from the same video_pll.  At
one time, I had done some experimentation with trying the DSI
connected to an HDMI bridge chip connected to a monitor and the LVDS
was connected to a display panel with a static resolution and refresh
rate.  For my LVDS display, it needs 30MHz to display properly, but
various HDMI resolutions needed values that were not evenly divisible
by 30MHz which appeared to cause display sync issues when trying to
share a clock that was trying to dynamically adjust for two different
displays especially when trying to change the resoltuion of the HDMI
display to various values for different resolutions.

> the children have divider, the current approach is straight forward by
> calculating the LCM of the required rates. During the rate change of the
> PLL, it must ensure that all children still have the configured rate at
> the end (and maybe also bypass the clock while doing so?). This is done
> by implementing a notifier function for the clk-composite-8m. The tricky
> part is now to find out if the rate change was intentional or not. This
> is done by adding the "change trigger" to the notify data. In our case,
> we now can infer if we aren't the change trigger, we need to keep the
> existing rate after the PLL's rate change. We keep the existing rate by
> modifying the new_rate of the clock's core, as we are quite late in an
> already ongoing clock change process.
>
> Future work:
> The re-configuration of the PLL can definitely be improved for other use
> cases where the children have more fancy inter-dependencies. That's one
> of the main reasons I currently only touched the mentioned clocks.
> Additionally, it might make sense to automatically re-parent if a
> different possible parent suits better.
> For the core part, I thought about extending my "unintentional change
> check" so that the core ensures that the children keep the configured
> rate, which might not be easy as the parent could be allowed to "round",
> but it's not clear (at least to me yet) how much rounding is allowed. I
> found a similar discussion posted here[1], therefore added Frank and
> Maxime.
>
> Thanks & regards,
> Benjamin
>
> [1] https://lore.kernel.org/lkml/20230825-pll-mipi_keep_rate-v1-0-35bc435=
70730@oltmanns.dev/
>
> ---
> Benjamin Bara (13):
>       arm64: dts: imx8mp: lvds_bridge: use root instead of composite
>       arm64: dts: imx8mp: re-parent IMX8MP_CLK_MEDIA_MIPI_PHY1_REF
>       clk: implement clk_hw_set_rate()
>       clk: print debug message if parent change is ignored
>       clk: keep track of the trigger of an ongoing clk_set_rate
>       clk: keep track if a clock is explicitly configured
>       clk: detect unintended rate changes
>       clk: divider: stop early if an optimal divider is found
>       clk: imx: pll14xx: consider active rate for re-config
>       clk: imx: composite-8m: convert compute_dividers to void
>       clk: imx: composite-8m: implement CLK_SET_RATE_PARENT
>       clk: imx: imx8mp: allow LVDS clocks to set parent rate
>       arm64: dts: imx8mp: remove assigned-clock-rate of IMX8MP_VIDEO_PLL1
>
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi |  14 +--
>  drivers/clk/clk-divider.c                 |   9 ++
>  drivers/clk/clk.c                         | 146 ++++++++++++++++++++++++=
+++++-
>  drivers/clk/imx/clk-composite-8m.c        |  89 +++++++++++++++---
>  drivers/clk/imx/clk-imx8mp.c              |   4 +-
>  drivers/clk/imx/clk-pll14xx.c             |  20 ++++
>  drivers/clk/imx/clk.h                     |   4 +
>  include/linux/clk-provider.h              |   2 +
>  include/linux/clk.h                       |   2 +
>  9 files changed, 261 insertions(+), 29 deletions(-)
> ---
> base-commit: e143016b56ecb0fcda5bb6026b0a25fe55274f56
> change-id: 20230913-imx8mp-dtsi-7c6e25907e0e
>
> Best regards,
> --
> Benjamin Bara <benjamin.bara@skidata.com>
>
