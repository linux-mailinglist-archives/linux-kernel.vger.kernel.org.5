Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B72C78A0F7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 20:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjH0S1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 14:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjH0S0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 14:26:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D47123;
        Sun, 27 Aug 2023 11:26:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40C5661D77;
        Sun, 27 Aug 2023 18:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDFDC433C9;
        Sun, 27 Aug 2023 18:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693160805;
        bh=JuAYU9hIhM7oTRmtD69g4zVEgqOo78rbGFmt5nednD4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m+7PteK8xvmnBKMpq3vdpSLqOJN3Tu5Bq+g8//WwTxpuSiyS31fjgIAvKpThdwPgV
         EyS7OC8yRmcaS566jUN4AM0aY781y9CWcU5f2fyBlTvzF/rwnya8xxcBNJpAHS3xt5
         rAdnf2yRr1VHeXjSLRn/7vo7HBvDeAT6TwzG2CLFJXW7PXHVkWkyKWg2+hX6fCXD12
         hK0icbpyU8dxFUJ3bIUwdfX91iBvr/eTz5giufb2lesXysRvcAZy79eDa8CJITkz54
         FbCsYryelQI5rrpHoK2ejsqh0RWKqXAKdHahLjXsp2QCkipYbTpFa2cR7ysSuAevrE
         kkeCiw1UjgGKQ==
Date:   Sun, 27 Aug 2023 19:27:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/6] Add support for the whole MCP39xx family
Message-ID: <20230827192701.30bfd1be@jic23-huawei>
In-Reply-To: <20230822192259.1125792-1-marcus.folkesson@gmail.com>
References: <20230822192259.1125792-1-marcus.folkesson@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2023 21:22:53 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> The main goal with this patchset is to add support for all similar
> MCP39xx ADC chips.
> During all patch iterations we ended up with a few cleanup patches.
> 
> See version notes in each patch.
> 
> Marcus Folkesson (6):
>   dt-bindings: iio: adc: mcp3911: add support for the whole MCP39xx
>     family
>   iio: adc: mcp3911: make use of dev_err_probe()
>   iio: adc: mcp3911: simplify usage of spi->dev
>   iio: adc: mcp3911: fix indentation
>   iio: adc: mcp3911: avoid ambiguity parameters in macros
>   iio: adc: mcp3911: add support for the whole MCP39xx family
> 
>  .../bindings/iio/adc/microchip,mcp3911.yaml   |   6 +
>  drivers/iio/adc/Kconfig                       |   6 +-
>  drivers/iio/adc/mcp3911.c                     | 562 ++++++++++++++----
>  3 files changed, 462 insertions(+), 112 deletions(-)
> 
> 
> base-commit: b320441c04c9bea76cbee1196ae55c20288fd7a6

Series applied.

Thanks to both Marcus (for working through the iterations) and Andy for
providing the detailed feedback.

Jonathan
