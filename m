Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF867BA811
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjJERaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjJER30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:29:26 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCBA1FD0;
        Thu,  5 Oct 2023 10:26:57 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qoLZu-003lA3-Le; Thu, 05 Oct 2023 18:27:35 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 05 Oct 2023 18:27:38 +0800
Date:   Thu, 5 Oct 2023 18:27:38 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Alexey Romanov <avromanov@salutedevices.com>
Cc:     narmstrong@baylibre.com, neil.armstrong@linaro.org,
        olivia@selenic.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        conor@kernel.org, khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, f.fainelli@gmail.com,
        hkallweit1@gmail.com, lists@kaiser.cx,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-crypto@vger.kernel.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v5 0/3] Meson S4 HW RNG Support
Message-ID: <ZR6PmiHLLVdKAROb@gondor.apana.org.au>
References: <20230929102942.67985-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929102942.67985-1-avromanov@salutedevices.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 01:29:35PM +0300, Alexey Romanov wrote:
> Hello!
> 
> This patch series adds hwrng support for Amlogic S4-series.
> Now, S4 uses a new random number generation algorithm.
> This changes implemnents new algo and also adds description
> to meson-s4.dtsi.
> 
> V2:
> 
> - Use readl_relaxed_poll_timeout_atomic() function instead of loop.
> - Use two different functions: meson_rng_read() and meson_s4_rng_read().
> - Fix naming in DT schema (meson-s4-hwrng instead of meson-hwrng-s4).
> - A little code style fixes.
> 
> V3:
> 
> - Fix commit message in patch with dt-bindings schema changes.
> 
> V4:
> 
> - Drop struct meson_rng_priv field from struct meson_rng_data.
> 
> V5:
> 
> - Rebased over v6.7/arm64-dt (Amlogic repo).
> 
> Alexey Romanov (3):
>   drivers: rng: meson: add support for S4
>   dt-bindings: rng: meson: add meson-rng-s4 compatible
>   arch/arm64: dts: meson-s4: add hwrng node
> 
>  .../bindings/rng/amlogic,meson-rng.yaml       |  1 +
>  arch/arm64/boot/dts/amlogic/meson-s4.dtsi     |  5 ++
>  drivers/char/hw_random/meson-rng.c            | 80 ++++++++++++++++++-
>  3 files changed, 83 insertions(+), 3 deletions(-)
> 
> -- 
> 2.25.1

Patches 1-2 applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
