Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6306F7B410A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 16:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbjI3OjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 10:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbjI3OjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 10:39:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEE4B7;
        Sat, 30 Sep 2023 07:39:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB533C433C8;
        Sat, 30 Sep 2023 14:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696084752;
        bh=aazhK1w8i4OYoWEnWiGKNvPFcp+PLHalOhO8AaFTEJQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CXo6P2QNMemW1hTY4HKlp+yDv6uxrCKap8ThqCNjhFcxSlakoaGIG0FE5Qco99V0a
         ygddMpQ8Dde04TjD1aq9wD3ZZOOucuFVvBbGPpyxRBKoJZ0semJTdAQwcYc7+iF8Qz
         S/EcKYTtt2lRF4kx7nkRXQE9NMm75KJjMtiiuUsM7dHQTNYlTg3mTC6qMtGbNxLbcq
         aWaZVkOUnp2l0T8c3/TtBHInBJKIKn0kymaXaAl7EF1SV70SpmAWeWiF7PfZap6Cvj
         3KZCVcfFnJsKH+RAaEwHhxVKkGHh4ebVexKTC5dPi7Lk6tfS/Dh8Ld5F+pFCI9gg4I
         hGXzx+ULzJRWw==
Date:   Sat, 30 Sep 2023 15:39:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev,
        David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/27] staging: iio: resolver: ad2s1210: sort imports
Message-ID: <20230930153911.2a687532@jic23-huawei>
In-Reply-To: <20230929-ad2s1210-mainline-v3-6-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
        <20230929-ad2s1210-mainline-v3-6-fa4364281745@baylibre.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2023 12:23:11 -0500
David Lechner <dlechner@baylibre.com> wrote:

> From: David Lechner <david@lechnology.com>
> 
> From: David Lechner <dlechner@baylibre.com>
> 
> There are quite a few imports and we will be adding more so it will
> make it easier to read if they are sorted.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied

> ---
> 
> v3 changes:
> * This is a new patch split out from "staging: iio: resolver: ad2s1210:
>  use devicetree to get fclkin"
> 
>  drivers/staging/iio/resolver/ad2s1210.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index 28015322f562..832f86bf15e5 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -4,16 +4,16 @@
>   *
>   * Copyright (c) 2010-2010 Analog Devices Inc.
>   */
> -#include <linux/types.h>
> -#include <linux/mutex.h>
> +#include <linux/delay.h>
>  #include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/of.h>
> -#include <linux/spi/spi.h>
>  #include <linux/slab.h>
> +#include <linux/spi/spi.h>
>  #include <linux/sysfs.h>
> -#include <linux/delay.h>
> -#include <linux/gpio/consumer.h>
> -#include <linux/module.h>
> +#include <linux/types.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> 

