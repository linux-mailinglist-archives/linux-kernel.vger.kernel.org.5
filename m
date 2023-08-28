Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1137178B52F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjH1QNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbjH1QN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:13:28 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368E7123
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:13:25 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-564b8e60ce9so1562947a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693239204; x=1693844004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oQ/TCI9qAhTdz1RnC/RmkKq0FRQb+BPnyluK4WRQ50=;
        b=Kmcrk3aH0HjSMgWDmTHoTFhaDyI2hXAnoy97ZjirBfh3VI1BDVvSuiTnk6SZv0gb91
         730hKvS5W4d9EB60QxjdzMMBYM1ZEWzZcrS3Kkv9TD2fpp0mqqsRyyjQpjc08NPx8NZE
         1NINecCOCTx55Mp867L2PWJ3HbNx9jh3aTg1cCjcEci55sf325MmXofUEA8zRrK8Yiq2
         TH5/gNH55uI3bD9dFcCq7aFJ6+LuMlEMX95FK5nPzEZ/NMVK6S0hV/+gjHPql6JCKhPF
         NhCLnU368McvQGVWQcHGt3nREYikRUW85sR7NfrSCNCb9W5H9rmr97hjWvye/R94E4nh
         IC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693239204; x=1693844004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oQ/TCI9qAhTdz1RnC/RmkKq0FRQb+BPnyluK4WRQ50=;
        b=bV1FHrcm8x+ryUQOvyWGfkS8c1Hw6cPmS15yITW+iT4zKmMdsfX1DlIpgAzjhLKwAj
         haboOXM1ccIFdJSgtbRMtbOr/y2raUrh0EHg/N3TdkJaM+EPw8IVTDtpXWSpZ27yLwWy
         o6E7SwlZovzaQEvHA2clj3RvnDd/9afsSCZqOp1hTEcHkiId5xOn0mHSZdI8DNLoTLRL
         R5g0VlxufObh8FrGu4lpI2CUPac1UrhIQfKcuPouMvfV04Fk83H3cAVzBgJs81cGENYi
         dzjuYJ/m7TPNdyF4lsCX+lvvQx0vMx6TROh1fXf3ghADyVw/mpREsfnCOZ5a7R0rO8a7
         1aJw==
X-Gm-Message-State: AOJu0YxumrhTZKsN12vrDhpG7cFOp7TR6vEEGQTfSCn/0KNaHb38flhP
        nYrMaJZXCzqZX5GiYzyJPr5lwHyU2BQuCZR1jn0=
X-Google-Smtp-Source: AGHT+IE9WVbZFA6VKXRmZQwd4Bsd5eKMBQnzQdi9z46AyWjOq/Y9acDDQWCRhGYzvWCIA4p+5VK3oj+YN+T+bFwlSgU=
X-Received: by 2002:a17:90b:124a:b0:26d:1f85:556 with SMTP id
 gx10-20020a17090b124a00b0026d1f850556mr20280538pjb.45.1693239204465; Mon, 28
 Aug 2023 09:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230818-samsung-dsim-v1-0-b39716db6b7a@pengutronix.de>
In-Reply-To: <20230818-samsung-dsim-v1-0-b39716db6b7a@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 28 Aug 2023 11:13:13 -0500
Message-ID: <CAHCN7xKasndWCkvU31Lqftty0Y1aDD370WJhaZio+_E4oajLrg@mail.gmail.com>
Subject: Re: [PATCH 0/5] drm/bridge: samsung-dsim: fix various modes with
 ADV7535 bridge
To:     Michael Tretter <m.tretter@pengutronix.de>
Cc:     Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, kernel@pengutronix.de,
        Marco Felsch <m.felsch@pengutronix.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
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

On Mon, Aug 28, 2023 at 10:59=E2=80=AFAM Michael Tretter
<m.tretter@pengutronix.de> wrote:
>
> I tested the i.MX8M Nano EVK with the NXP supplied MIPI-DSI adapter,
> which uses an ADV7535 MIPI-DSI to HDMI converter. I found that a few
> modes were working, but in many modes my monitor stayed dark.
>
> This series fixes the Samsung DSIM bridge driver to bring up a few more
> modes:
>
> The driver read the rate of the PLL ref clock only during probe.
> However, if the clock is re-parented to the VIDEO_PLL, changes to the
> pixel clock have an effect on the PLL ref clock. Therefore, the driver
> must read and potentially update the PLL ref clock on every modeset.
>
> I also found that the rounding mode of the porches and active area has
> an effect on the working modes. If the driver rounds up instead of
> rounding down and be calculates them in Hz instead of kHz, more modes
> start to work.
>
> The following table shows the modes that were working in my test without
> this patch set and the modes that are working now:
>
> |            Mode | Before | Now |
> | 1920x1080-60.00 | X      | X   |
> | 1920x1080-59.94 |        | X   |
> | 1920x1080-50.00 |        | X   |
> | 1920x1080-30.00 |        | X   |
> | 1920x1080-29.97 |        | X   |
> | 1920x1080-25.00 |        | X   |
> | 1920x1080-24.00 |        |     |
> | 1920x1080-23.98 |        |     |
> | 1680x1050-59.88 |        | X   |
> | 1280x1024-75.03 | X      | X   |
> | 1280x1024-60.02 | X      | X   |
> |  1200x960-59.99 |        | X   |
> |  1152x864-75.00 | X      | X   |
> |  1280x720-60.00 |        |     |
> |  1280x720-59.94 |        |     |
> |  1280x720-50.00 |        | X   |
> |  1024x768-75.03 |        | X   |
> |  1024x768-60.00 |        | X   |
> |   800x600-75.00 | X      | X   |
> |   800x600-60.32 | X      | X   |
> |   720x576-50.00 | X      | X   |
> |   720x480-60.00 |        |     |
> |   720x480-59.94 | X      |     |
> |   640x480-75.00 | X      | X   |
> |   640x480-60.00 |        | X   |
> |   640x480-59.94 |        | X   |
> |   720x400-70.08 |        |     |
>

Nice!

> Interestingly, the 720x480-59.94 mode stopped working. However, I am
> able to bring up the 720x480 modes by manually hacking the active area
> (hsa) to 40 and carefully adjusting the clocks, but something still
> seems to be off.

Checkout my

branch: https://github.com/aford173/linux/commit/183cf6d154afeb9b0300500b09=
d7b8ec53047a12

I found that certain resolutions don't properly round, and it seemed
to be related to the size of HFP.  HFP of 110 when divded between 4
lanes, required a round-up, but then I had to recalculate the rest of
the horizontal timings to compensate.

I was going to push that as an RFC, but I will investigate your patch
series first.  With my small rounding correction, I am able to get
720x480 and 720p on my imx8mp, but not my mini/nano, so I am hoping
your patch series fixes that issue for me.

>
> Unfortunately, a few more modes are still not working at all. The NXP
> downstream kernel has some quirks to handle some of the modes especially
> wrt. to the porches, but I cannot figure out, what the driver should
> actually do in these cases. Maybe there is still an error in the
> calculation of the porches and someone at NXP can chime in.

Hopefully the comment in my above patch explains how the calculation
is corrected and adjusted to get some of the missing resolutions.

> Michael
>
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>

I'll try to reivew this week and respond with my feedback.

adam

> ---
> Marco Felsch (1):
>       drm/bridge: samsung-dsim: add more mipi-dsi device debug informatio=
n
>
> Michael Tretter (4):
>       drm/bridge: samsung-dsim: reread ref clock before configuring PLL
>       drm/bridge: samsung-dsim: update PLL reference clock
>       drm/bridge: samsung-dsim: adjust porches by rounding up
>       drm/bridge: samsung-dsim: calculate porches in Hz
>
>  drivers/gpu/drm/bridge/samsung-dsim.c | 42 +++++++++++++++++++++++++----=
------
>  include/drm/bridge/samsung-dsim.h     |  1 +
>  2 files changed, 31 insertions(+), 12 deletions(-)
> ---
> base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> change-id: 20230818-samsung-dsim-42346444bce5
>
> Best regards,
> --
> Michael Tretter <m.tretter@pengutronix.de>
>
