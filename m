Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B78C7B4107
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 16:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbjI3Oi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 10:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbjI3Oi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 10:38:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5898C2;
        Sat, 30 Sep 2023 07:38:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76923C433C7;
        Sat, 30 Sep 2023 14:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696084705;
        bh=I0KTPUlwzWHVqIbGSTe18Oam3i4/Q2G6ohNiPZBa7GU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bcMcd9rWSu3b170BQ62dfMfDf4DCOO3GMBc8Kdk8Dn8JYqj2g9T42aM2Rz982NWpB
         64giCiQ/nl5Say9/g9Ou+Tx/I4uWinDuoy6a2riZyYWlLIGkvp4MNgIwKGXRLfTQCd
         bYEN/pNRYUG4Et1YRGFMrNNQmTEJHBFmdhK9d5I3yHHXcNxxUxY+6Os2QQHiaSdz+A
         LSh+KLC2XmmFaGLwixc7ElkHPJyE1MJNURmbGNXIYstRJvaofTR++5WflFtfRuHsYP
         Nl1SNfoFMJMkv+/IMFmRXqitBPyG07U07mK5sVhCgkxKO+Qhc9jrnlwbv0e/aCzO+R
         Y6ebLBBkomzGw==
Date:   Sat, 30 Sep 2023 15:38:24 +0100
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
Subject: Re: [PATCH v3 05/27] staging: iio: resolver: ad2s1210: remove
 spi_set_drvdata()
Message-ID: <20230930153824.6e2601ca@jic23-huawei>
In-Reply-To: <20230929-ad2s1210-mainline-v3-5-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
        <20230929-ad2s1210-mainline-v3-5-fa4364281745@baylibre.com>
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

On Fri, 29 Sep 2023 12:23:10 -0500
David Lechner <dlechner@baylibre.com> wrote:

> From: David Lechner <david@lechnology.com>
> 
> From: David Lechner <dlechner@baylibre.com>
> 
> Since we never call spi_get_drvdata(), we can remove spi_set_drvdata().
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied.

> ---
> 
> v3 changes:
> * This is a new patch split out from "staging: iio: resolver: ad2s1210:
>  fix probe"
> 
>  drivers/staging/iio/resolver/ad2s1210.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index b5e071d7c5fd..28015322f562 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -659,8 +659,6 @@ static int ad2s1210_probe(struct spi_device *spi)
>  		return -ENOMEM;
>  	st = iio_priv(indio_dev);
>  
> -	spi_set_drvdata(spi, indio_dev);
> -
>  	mutex_init(&st->lock);
>  	st->sdev = spi;
>  	st->hysteresis = true;
> 

