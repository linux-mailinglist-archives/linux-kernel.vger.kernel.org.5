Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5E57A5170
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjIRR7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjIRR7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:59:36 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C51DB;
        Mon, 18 Sep 2023 10:59:30 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so6173706a12.0;
        Mon, 18 Sep 2023 10:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695059968; x=1695664768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2z+YfEIrjX3pGh98erEY2L625u+oUnPZE1jx6jpqjps=;
        b=mm/LoWXaXRxm27XEHEwGWRp9Ej/ppCSH5ewljKttRPsRH+I0rq95QyU+g7EM8qH9r8
         truc/e/gYlsrkakVr6hVCEP13oOoi5qyZJ3l7RlA8SwMFRrdkN2+HWZrkO9wQf7PNNOg
         RBonJ+PC7L3A83MXyThWGhix5a8sayEJQS1zPpNc83i/MQB+WYtY5pa1kbLO6JGzCYxq
         rW1UMJ5UHDtWB6Ho0psNG2zXcGY3+G18DFBQyVRrW3yJXjSAC4g1jpiGIzN+q3XC5Tgj
         7cmpkTiRFn9VvmHkqI92KiPM68UT123RGcPJtoRCX9/81cz1R1llkCX3Z/PLK0IHsX5H
         wPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695059968; x=1695664768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2z+YfEIrjX3pGh98erEY2L625u+oUnPZE1jx6jpqjps=;
        b=VUTLWqB5WGrK0MLxlyDW4uCbyK6p1DvFG0zLdot/OHGHfMWhdq/ZDxCSa8LTnrrxkk
         jevrh+ZyW6haTuR2LFmJkKfZWEwjdlhx2NIciqBSDJBtV/h/8CidjYveBz7GeaVRVJ1c
         Rrx/dz9do0oRJhXXjBky82+Hemb5JU1EOl8sFjo+LrciQSiUD0MWgZTgPR907r9v5IIC
         93yGQcjYCbNfoRMF6OGlzhAIh2wGfeh+799+e5WvA5ggZ9sRuZPcm7IWnwo8EYQcFtbO
         BvknXEvsmJwngBinEBGILdu71uWm2DZke8anF7I7jXoZ7P9SANahO0OUQ7bUa6MInyqs
         Sbnw==
X-Gm-Message-State: AOJu0YzdiaF32aJIbSQKZIVDcqvyxATyDFwSmVymt1r8ZriQYZzgItru
        c7TbrSQEnnwC/8Ry6e2SKqLcsGd7rM79foGnzak=
X-Google-Smtp-Source: AGHT+IG/RyMpqq1hOq1M/e4gKRaB7kZ9lH1Ca1G70SneQICLUr0RT6KxkeqMMhs2bB3VSBrO3ofPIT1Y4DbuBjAUIjo=
X-Received: by 2002:aa7:d3d6:0:b0:51e:2e39:9003 with SMTP id
 o22-20020aa7d3d6000000b0051e2e399003mr6614828edr.40.1695059968144; Mon, 18
 Sep 2023 10:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com> <CAHCN7xJ8KrBd-532=gDE+82xo1ZNtoDT7pZsYwy9-9WiJvmkvw@mail.gmail.com>
In-Reply-To: <CAHCN7xJ8KrBd-532=gDE+82xo1ZNtoDT7pZsYwy9-9WiJvmkvw@mail.gmail.com>
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Mon, 18 Sep 2023 19:59:16 +0200
Message-ID: <CAJpcXm6OWNODOz5gEWVhOJjKTazwzE7XV6ZR1H06zpECrivZig@mail.gmail.com>
Subject: Re: [PATCH 00/13] imx8mp: first clock propagation attempt (for LVDS)
To:     Adam Ford <aford173@gmail.com>
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

Hi Adam!

On Mon, 18 Sept 2023 at 07:00, Adam Ford <aford173@gmail.com> wrote:
> On Sun, Sep 17, 2023 at 3:40=E2=80=AFPM Benjamin Bara <bbara93@gmail.com>=
 wrote:
> > The idea:
> > Enable CLK_SET_RATE_PARENT, at least for media_disp2_pix and media_ldb.
> > When this is done, ensure that the pll1443x can be re-configured,
> > meaning it ensures that an already configured rate (crtc rate) is still
> > supported when a second child requires a different rate (lvds rate). As
>
> Have you tested with the DSI as well?  If memory servers, the DSI
> clock and the LVDS clock are both clocked from the same video_pll.  At
> one time, I had done some experimentation with trying the DSI
> connected to an HDMI bridge chip connected to a monitor and the LVDS
> was connected to a display panel with a static resolution and refresh
> rate.  For my LVDS display, it needs 30MHz to display properly, but
> various HDMI resolutions needed values that were not evenly divisible
> by 30MHz which appeared to cause display sync issues when trying to
> share a clock that was trying to dynamically adjust for two different
> displays especially when trying to change the resoltuion of the HDMI
> display to various values for different resolutions.

Unfortunately I haven't. I think if you have the use case to support
different "run-time-dynamic" (HDMI) rates in parallel with a static
(LVDS) rate, it probably makes sense (for now) to just use a LVDS panel
which can be feeded from one of the static PLLs directly and do a manual
re-parenting in the dt. The manual re-parenting could be replaced by an
automated re-parenting in the composite driver. When I think about it,
it might make sense to extend clk-divider's clk_divider_bestdiv()[1]
(which is currently used by the composite-8m) with a "find the best
parent" implementation, something like:
1. are we in range if we divide the active parent with all possible
   dividers? (already existing)
2. are we in range if we switch to a different parent and divide it with
   all possible dividers?
3. are we in range if we re-configure a possible parent (and switch to
   it)?

Steps 2 & 3 are e.g. implemented by at91's clk-master[2]. There are
maybe also "smarter" solutions to the problem beside trying every
possibility. Anyways, we already have a CLK_SET_RATE_NO_REPARENT which
would indicate if we are allowed to do so.

For static use cases involving both, I would probably (for now) go with
a hard-assigned, tested clock rate in the dt. IMHO, this should always
work as fall-back.

Regards,
Benjamin

[1] https://elixir.bootlin.com/linux/v6.5.3/source/drivers/clk/clk-divider.=
c#L304
[2] https://elixir.bootlin.com/linux/v6.5.3/source/drivers/clk/at91/clk-mas=
ter.c#L586
