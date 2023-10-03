Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F047B6A85
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbjJCN2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbjJCN2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:28:22 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A27A9;
        Tue,  3 Oct 2023 06:28:18 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-59f7f46b326so10620367b3.0;
        Tue, 03 Oct 2023 06:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696339698; x=1696944498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HP6btn0lk5FVltbvsnVKbaumo44S8WgmYE+LwmEZ6LY=;
        b=jDkDDYia0k4ESb/d9QzA7RG2lLtCbe26BU/7JjiOsvr5xH687gQaHk0bjdodbdg129
         0XC0+20ki+tatPKp3PjP1+Y0M5T7JPLvn2syaGGZfpxgHqwy0BIP2BDg0zrXZVhis3qQ
         e+XCG5o3NcCz80ddcplWawTEFNKsybTHPRG564DV2+nK+7oUUd4OIH2C8KfWcrA/bfGU
         ExPKpFu8pRwbj6+yElip/3CBHU1WLA3nIgn/GTCitMJE+1juT14ZBDAm2vvC51END7gb
         JKxXbyh33U/wnjCHaxLpUMc46pVLMbgtwa5MAa8I+PYYTpkTaHO9nxvB4tdci13QFCu0
         FfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696339698; x=1696944498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HP6btn0lk5FVltbvsnVKbaumo44S8WgmYE+LwmEZ6LY=;
        b=sQMK9d4YqroGWRnGbT68xdMYu0P8a3Oud0YVWBFBrAhijHKWghtNxSuRVTM3UhS9LU
         OdE+VE7yWfYgQJ0lO3d4LobfkHiXwVfBrxMnV8QFD9grWO3xyJoB7gUV6rEB9En58ZOz
         2P8L2aZ5bJ3BoeDyWHaURA/79XzgPZUVCCNLLXnttMTrgw4r6XNymHHEgelZlQ/OOKJa
         3jSg6dZjf6x2fenYNtnMftPaXl3Qclm1mzjFXTfRmodZeNY5n16yFhUN/mAlvJbknWUL
         YzuZ/V3/Iikb2Wj+2R1qfho8u4PUp90cmp44nujQekV9kVLhl/myU/v/KPmn3F4qJzvg
         0EHw==
X-Gm-Message-State: AOJu0Yy9WoqIVf6CJvSGqHXEQ48ZTqqxiYDvRZ2GdEn78BWbZjBOERPV
        I4S+nVc2aLWbfIGor9m/or0kNBIamnZcz7FHgBk=
X-Google-Smtp-Source: AGHT+IFGv3SPXI3BKDMQns8vlcIv9kiF1gXdNmUzLVPx5LoBJU2IKBwIf5mXUPQp1fC4FCkZFJ/Tkvtlmlx1hpkHNYw=
X-Received: by 2002:a81:6f05:0:b0:59f:6cbf:8902 with SMTP id
 k5-20020a816f05000000b0059f6cbf8902mr13509479ywc.33.1696339697846; Tue, 03
 Oct 2023 06:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com>
In-Reply-To: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 3 Oct 2023 08:28:05 -0500
Message-ID: <CAHCN7x+WesF5Dac=9THtHR7Y=LJwzAEsZ9aD1B7Lppc2vQSnJQ@mail.gmail.com>
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
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2023 at 5:40=E2=80=AFPM Benjamin Bara <bbara93@gmail.com> w=
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

Could the LDB driver be updated to take in the crtc clock as a
parameter, then set the media_ldb to 7x crct clock.  I wonder if that
might simplify the task a bit.

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

I still have concerns that the CLK_SET_RATE_PARENT may break the
media_disp1_pix if media_disp2_pix is changing it.

I think we should consider adding some sort of configurable flag to
the CCM that lets people choose  if CLK_SET_RATE_PARENT should be set
or not in the device tree instead of hard-coding it either on or off.
This would give people the flexibility of stating whether
media_disp1_pix, media_disp2_pix, both or neither could set
CLK_SET_RATE_PARENT.

I believe the imx8mp-evk can support both LVDS-> HDMI and DSI->HDMI
bridges, and I fear that if they are trying to both set different
clock rates, this may break something and the clocks need to be
selected in advance to give people a bunch of HDMI options as well as
being able to divide down to support the LVDS.

I think some of the displays could be tied to one of the Audio PLL's,
so I might experiment with splitting the media_disp1_pix and
media_disp2_pix from each other to see how well .


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
