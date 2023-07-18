Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15789757D27
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjGRNTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjGRNTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:19:14 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A677D1;
        Tue, 18 Jul 2023 06:19:13 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-cae0ad435b6so5953210276.0;
        Tue, 18 Jul 2023 06:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689686352; x=1692278352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9BGs7xI1AaJFp00lJtBHCoa+K3WPXj0QFbQu1Le0FU=;
        b=QPpWpaLveDkg243J973nDhKq8ZJtdvedq9X3flX6x8LNllZ7kA9fOKmvwgJv5ZONep
         58Wnjibdnk8mflSLJzZR3s0ZBke+3pZAfFcjZOebavDtprFO89g8F2cRBlcLOW5W8mwz
         2MSZAFVgZ3H92m9mULMu/d/ID33eAt5o7zL4BySGzO86t6vYRn2mxIx+baolOr1ElhJ6
         QFdHu70Eyc5K8IV/j/e22qs4sGQdUhRfZVmGIDfGsK70+yXqxeSQeSmGzrmDro8uupLf
         BPvKdQYYzdqYjM1l+WRM8up+Zl9y7yK4YlBLr77QNhhzqM7mMY0sXEbvzF7+w/Z8hBvq
         X/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689686352; x=1692278352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9BGs7xI1AaJFp00lJtBHCoa+K3WPXj0QFbQu1Le0FU=;
        b=IsJAN+hXBElp2p++7eWOE6vwlJSpv4Cxfcfs5Oys1sA+gGmun6I7+cFt0yzCytCGe6
         kwDW/PepjX7CYYG5/2e744V245g18IlABXM625Ni0RY2l9wewP8r3Voyem+qYkBSjuaH
         gzbzCPImHlj8Z2Vp0dDhnqz33R72tYjVnfdkc019A3v2Il7F3OZS3Kt1HNGRuU2XLHDj
         Apb21QEdGQ8BNZ0l/MVNM32TnJ4JabLd+TXEVut4p5RWXafCzV8xY/o1lStt+tvz9tUz
         htx1m6xRvAN5CFrNHTeF0XaLV8x/zL0SWgr3z174BKQzWOjpz4XZpDKh2jkXZaLYf6Dt
         HjSA==
X-Gm-Message-State: ABy/qLYRsshMOg2wVsVbwJeA8QsL1cmpmU6QZZKk/m20+aKCLlODewZo
        /r+MgPwkKPUrS4oZJTX7OSl1jlB9BnY06I9mwvs=
X-Google-Smtp-Source: APBJJlGawmRv8zoQzo3nfFjxiQUi7804ixGt8T7mFLMLzmF8j1hYkyXfHDRw/w+W17EyqjdZSbmYCeEbn7IF/6LPLQ0=
X-Received: by 2002:a25:4091:0:b0:c39:50fe:79be with SMTP id
 n139-20020a254091000000b00c3950fe79bemr13253934yba.61.1689686352401; Tue, 18
 Jul 2023 06:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230714174525.4055475-1-robh@kernel.org>
In-Reply-To: <20230714174525.4055475-1-robh@kernel.org>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Tue, 18 Jul 2023 15:19:01 +0200
Message-ID: <CABgxDoJ_t0QF=XTy2zJn4rbv5X95c6+ABsvtCF=3rWcbYVUnPQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: Explicitly include correct DT includes
To:     Rob Herring <robh@kernel.org>
Cc:     Alban Bedel <albeu@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Doug Berger <opendmb@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Daniel Palmer <daniel@thingy.jp>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Nandor Han <nandor.han@ge.com>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le ven. 14 juil. 2023 =C3=A0 19:45, Rob Herring <robh@kernel.org> a =C3=A9c=
rit :
>
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

For the mstar part,
Acked-by: Romain Perier <romain.perier@gmail.com>

Regards,
