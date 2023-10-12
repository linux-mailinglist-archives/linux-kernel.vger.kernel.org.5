Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C504D7C7A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 01:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbjJLXvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 19:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjJLXvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 19:51:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE48BB8;
        Thu, 12 Oct 2023 16:51:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFFDC433C7;
        Thu, 12 Oct 2023 23:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697154708;
        bh=7ci+m7+x7XXxdQsME2tkoDD8RgVXYZGHP0UltC3GUjk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ULBz4pFZ8+loGkL1DAGx8tp/a1sgOMFS1Vd65ppgTiHyt5v6y7xrxc+ARZx4h+OX0
         FCMuS4Dq11+teVUo/2d30vo7lUcIlN94VGlhao2iXD/Zl7qY/6UjTDhuQ2DrGgpMp3
         IjHaK02zo6QQg7brR+0FakpeqdpqB24DuvEvrFR7FHhMOtebZq3tZPeRpsgiMpOEvX
         F53EfpzVH+ERjrG/3hf3cRXAB07vniyOzos6tZxdezzL1l+ENItPPS4/ZzEyNF1yE0
         ygOeJpPjJd46aGe5L1Jsg6CnE83kbTK4VFm9lXgnFrWjzeKHvtSaU2QyP9x4jcW/oW
         X4tFweO6hr15A==
Message-ID: <5e0bd4bba88701dd1a7a3e89d18412f0.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231010062917.3624223-5-xianwei.zhao@amlogic.com>
References: <20231010062917.3624223-1-xianwei.zhao@amlogic.com> <20231010062917.3624223-5-xianwei.zhao@amlogic.com>
Subject: Re: [PATCH V2 4/4] clk: meson: c3: add c3 clock peripherals controller driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chuan Liu <chuan.liu@amlogic.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 12 Oct 2023 16:51:44 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Xianwei Zhao (2023-10-09 23:29:17)
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index 76be4bbd2afb..c8d59d28c8ff 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -140,6 +140,19 @@ config COMMON_CLK_C3_PLL
>           Say Y if you want the board to work, because PLLs are the paren=
t of most
>           peripherals.
> =20
> +config COMMON_CLK_C3_PERIPHERALS
> +       tristate "Amlogic C3 peripherals clock controller"
> +       default y

Why are these default y? They should depend on something like ARM64 and
even then I don't see why we want to enable them by default if we're
building the ARM64 kernel.
