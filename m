Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B40E754A6A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 19:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjGORNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 13:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjGORNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 13:13:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931CBD3;
        Sat, 15 Jul 2023 10:13:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31B1560BEC;
        Sat, 15 Jul 2023 17:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BA8C433C8;
        Sat, 15 Jul 2023 17:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689441228;
        bh=1p/AukyvqBFfujmrDsB0r4g71V+ZKHoyhzwzCuFNHCA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BM2CGCDfP7E6HVkrvvHPGLDfcDjf9HKBnne9SoZKw8rJc+cGhvWSmYx4TTs3Pwh2q
         12CeMyAMapFp3//L1EDvlq9UyTo2q7oHpwkGuWda/vWrdYUUbsiO783mR1QvbEBdZ8
         NGCXe3FLdB/5l1nwbAzW9B8yKNw+SRiYqKjeHDw4JHznwMZyH6nn5SYFRZjno2pChL
         9YuAcWcpHhD33KJFuwVnVAtZawDgTqsfuN+vWahpL3nBIMDrR57i48i6P+X3KzAh4F
         fOo9DKSlItB44DRKLNemBOIWLvPnZCCtHr0ccvqBlD9eSDpMo2TJfw+fLKItCFcAn3
         zJm4Z40UfN5rw==
Date:   Sat, 15 Jul 2023 18:13:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Maksim Kiselev <bigunclemax@gmail.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v9 0/4] Add support for Allwinner GPADC on
 D1/T113s/R329/T507 SoCs
Message-ID: <20230715181338.55c4a942@jic23-huawei>
In-Reply-To: <20230715091816.3074375-1-bigunclemax@gmail.com>
References: <20230715091816.3074375-1-bigunclemax@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jul 2023 12:18:12 +0300
Maksim Kiselev <bigunclemax@gmail.com> wrote:

> This series adds support for general purpose ADC (GPADC) on new
> Allwinner's SoCs, such as D1, T113s, T507 and R329. The implemented driver
> provides basic functionality for getting ADC channels data.
> 
> Change History:
> v9:
> - Dropped fixes tag

I tweaked it on the tree to do this rather than dropping the series.

> - Reworded commits to remove 'This patch'
Treated this one as a nice to have and skipped it on the tree.

So v8 is queued up with the fixes tag dropped.

Thanks,

Jonathan

> 
> v8:
> - Added patch that changes Kconfig description for previous Allwinner GPADC
> - Changed Kconfig description for this GPADC driver
> - Fixed 'reg' range for gpadc node in 'sunxi-d1s-t113.dtsi'
> 
> v7:
> - Fixed typo in DT bindings property
> 
> v6:
> - Fixed DT bindings regexp for channel properties
> - Dropped checking the max number of channels from the drivers code
>   (This is redundant as we raly on DT bindings check)
> 
> v5:
> - Fixed DT bindings properties for child nodes
> 
> v4:
> - Fixed DT bindings warnings
> - Used GENMASK to clear the irq register
> - Minor formatting fixes
> 
> v3:
> - Added DT bindings dual license, fixed property order and example formatting
> - Added explanations comments for timeout and mutex
> - Dropped unnecessary regmap and used readl/writel instead
> - Added error message about getting channel number
> - Renamed labels and variables to make them self-explanatory
> 
> v2:
> - Added lastch flag to avoid addition work for already selected channel
> - Added reset assertion on module remove
> - Added dynamic channel allocation and dropped iio_chan_spec arrays
> - Changed IIO_CHAN_INFO_SCALE type to FRACTIONAL_LOG2
> - Dropped separate compatible strings and configs for T113s and R329
> - Fixed includes
> - Fixed Kconfig description
> - Removed duplicate probe error messages
> - Used FIELD_PREP for bit setup
> 
> v1:
> - Initial version
> 
> Maksim Kiselev (4):
>   iio: adc: Kconfig change description for Allwinner GPADC
>   iio: adc: Add Allwinner D1/T113s/R329/T507 SoCs GPADC
>   dt-bindings: iio: adc: Add Allwinner D1/T113s/R329/T507 SoCs GPADC
>   riscv: dts: allwinner: d1: Add GPADC node
> 
>  .../iio/adc/allwinner,sun20i-d1-gpadc.yaml    |  91 ++++++
>  .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  10 +
>  drivers/iio/adc/Kconfig                       |  12 +-
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/sun20i-gpadc-iio.c            | 276 ++++++++++++++++++
>  5 files changed, 389 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
>  create mode 100644 drivers/iio/adc/sun20i-gpadc-iio.c
> 

