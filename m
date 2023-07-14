Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2902753154
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbjGNFer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbjGNFeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:34:25 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36863593
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:33:23 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-579ef51428eso14122387b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20221208.gappssmtp.com; s=20221208; t=1689312803; x=1691904803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cO93OCrQNlLCZA+MMbVD/bFScGU9EicCldb08idSeGU=;
        b=xBgejHrRR1ZPmQWWVcZZ13sWt5Ofu+iTDPRYzWWl6gJKPsKmamGqKOT/8OjniwAsTG
         JjQGYJuscLmU4kpmBNcnYXKhZs8Jr8q2rjUAr2LtgDJaAhl2iiy0xdlkRji58y7/TJGg
         L9lcnSnB4aTCrtEtVgibS9vJQgbLuXedWyf885FAUqc0pL3v7IWG2uEXuJxbbPINw19E
         eGQzj46HD2NmBOzuNuPjKVmsjRyFTnqN/vDTXI61n22KtcjIfHoijhgmwopUxo7s2548
         HOk3lrefVTcJCZmSqpp+nnBUpnaViPJUAbHnVCdiLq3GznGvRN5fkwwKOtKlecebFJ3M
         dyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689312803; x=1691904803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cO93OCrQNlLCZA+MMbVD/bFScGU9EicCldb08idSeGU=;
        b=Um8gxJ32DeUhiwCZTPzpKXbvscV635Qyq9F99ZPzZ3Saq52ltLs2bhh05wKpwufPrl
         jHnXOMpbrr25tS2t+UkzvA8M0U0MkP5DMSI79spMSh+fzIeW/8C63QyVuMVDUY++qqHA
         nhDgzv+BUU8/FsQMDVqFi5lPnP8zUT7tUw3dO1AX+ZtB3JLEpBuIzvQMOe9RCzlSrrCY
         jy9WOzhaBp1o7b2KGUJB5AcE8bibweMFC1qW97P4VsgX7HKtY56+J7cTLkvfQRe+u2O5
         35MQhJBrL1vNeDZb24PyGnlVvFudxeRLroCXtWd9o3NiXIZ46XXd2O7rb1Od9fjMQJ7q
         K60w==
X-Gm-Message-State: ABy/qLaSog5CyNCepSsckNaHR2sZ4diBPyRUFiu6Cmz5Jfi2T6GFA1Q/
        3iaKIxcHQSJdUbxJNopBVAaZ3nIvNS3+DVQnpQ1aXOIWN4ljyAUx4he/Og==
X-Google-Smtp-Source: APBJJlER1ImBn8SyF4nvZFu6jfUXHV0RYVHgsrGbzlXI/WqrC2ZszrwiB0XPgpV3SfHRs1CKdVmSZ5f1SuUUQOe0xkE=
X-Received: by 2002:a81:ab50:0:b0:56d:9b15:72a with SMTP id
 d16-20020a81ab50000000b0056d9b15072amr3845945ywk.33.1689312802990; Thu, 13
 Jul 2023 22:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230403193250.108693-1-sebastian.reichel@collabora.com>
 <20230403193250.108693-2-sebastian.reichel@collabora.com> <CA+VMnFz4USPcXmQMyUB9n5EVmvQrJARDvnpO7iBrXZ8q2xcyAA@mail.gmail.com>
 <20230713193812.px7q4sdfdppuywsg@mercury.elektranox.org>
In-Reply-To: <20230713193812.px7q4sdfdppuywsg@mercury.elektranox.org>
From:   Jagan Teki <jagan@edgeble.ai>
Date:   Fri, 14 Jul 2023 11:03:12 +0530
Message-ID: <CA+VMnFwjFx5+h9=KGR-1o0ejSaxbE=-5wH3iqEEkn6k4q_he7Q@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] clk: rockchip: rk3588: make gate linked clocks
 ignore unused
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Vincent Legoll <vincent.legoll@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Fri, 14 Jul 2023 at 01:08, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hello Jagan,
>
> On Thu, Jul 13, 2023 at 08:25:03PM +0530, Jagan Teki wrote:
> > On Tue, 4 Apr 2023 at 01:03, Sebastian Reichel
> > <sebastian.reichel@collabora.com> wrote:
> > [...]
> > > + * Recent Rockchip SoCs have a new hardware block called Native Interface
> > > + * Unit (NIU), which gates clocks to devices behind them. These effectively
> > > + * need two parent clocks.
> > > + *
> > > + * Downstream enables the linked clock via runtime PM whenever the gate is
> > > + * enabled. This implementation uses separate clock nodes for each of the
> > > + * linked gate clocks, which leaks parts of the clock tree into DT.
> > > + *
> > > + * The GATE_LINK macro instead takes the second parent via 'linkname', but
> > > + * ignores the information. Once the clock framework is ready to handle it, the
> > > + * information should be passed on here. But since these clocks are required to
> > > + * access multiple relevant IP blocks, such as PCIe or USB, we mark all linked
> > > + * clocks critical until a better solution is available. This will waste some
> > > + * power, but avoids leaking implementation details into DT or hanging the
> > > + * system.
> > >   */
> >
> > Does it mean the clk-link topology in the downstream kernel can be
> > reused the same as normal clock notation?
>
> Yes.
>
> > For example, I'm trying to add HCLK_VO1 directly to VO1 syscon instead
> > of routing to pclk_vo1_grf(done downstream)
> >       vo1_grf: syscon@fd5a8000 {
> >                compatible = "rockchip,rk3588-vo-grf", "syscon";
> >                reg = <0x0 0xfd5a8000 0x0 0x100>;
> >              clocks = <&cru HCLK_VO1>;
>
> You need PCLK_VO1 (which is currently not exposed; I somehow missed
> it).
>
> >       };
> >
> > This seems breaking syscon for vo1_grf and observed a bus error
> > while accessing regmap.
>
> I investigated the issue you are seeing some weeks ago when my
> co-workers started to work on HDMI RX and TX. You are probably
> just missing this patch:
>
> https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/commit/ecc6415344957fa88356cec10f8b75a9da603a7b

In fact, I tried this solution as well, by connecting the PCLK_VO1GRF.

        vo1_grf: syscon@fd5a8000 {
                compatible = "rockchip,rk3588-vo-grf", "syscon";
                reg = <0x0 0xfd5a8000 0x0 0x100>;
                clocks = <&cru PCLK_VO1GRF>;
        };

But the result seems the same, accessing vo1_grf triggers an abort [1]

[1] https://gist.github.com/openedev/e241da8180341ffbf4dc6a26de7efa31

Thanks,
Jagan.
