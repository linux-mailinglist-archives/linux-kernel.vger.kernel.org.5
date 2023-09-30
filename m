Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4537B40EE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 16:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbjI3Ofv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 10:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbjI3Oft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 10:35:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F117E5;
        Sat, 30 Sep 2023 07:35:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCD9C433C7;
        Sat, 30 Sep 2023 14:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696084546;
        bh=wrTl3YZsfTQZ6DL5MDfDMrDyvXvAClp5jEIT1WDYOoc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TivNxhRtxz9tV+llal+tEV44Uhb+Wla9YXA3W166fDeXLFWpedWQMTab/IL54D2HX
         gzE8HZA8H60t5PWO+Zx8EcfvsWOcqDfqv7+e5D6GsfQIcsT2ed/8YD2XeH/T7Y9tSc
         UPqsVX+8dJuFN7C8Qrt63vQddUIlbUR3nuBORnIrFvsGpZXLWZaisVbb1r0EJashrf
         rhOgVZSuMtROlaDh7ByTTdUjPNiz/asv+MA9jBGhIS+kGIGPEogt3tPkymX8Ow5miF
         ATpALcG0L8iPs++khJYTGQsZ+wyhn0wwEV6oMSN3/nJjjCCMOxDRfEEukFf2xx71Pg
         mUe0wRI4e97HQ==
Date:   Sat, 30 Sep 2023 15:35:44 +0100
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
Subject: Re: [PATCH v3 03/27] staging: iio: resolver: ad2s1210: remove call
 to spi_setup()
Message-ID: <20230930153544.711e4bce@jic23-huawei>
In-Reply-To: <20230929-ad2s1210-mainline-v3-3-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
        <20230929-ad2s1210-mainline-v3-3-fa4364281745@baylibre.com>
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

On Fri, 29 Sep 2023 12:23:08 -0500
David Lechner <dlechner@baylibre.com> wrote:

> From: David Lechner <david@lechnology.com>
> 
> From: David Lechner <dlechner@baylibre.com>
> 
> This removes the call to spi_setup() in the ad2s1210 driver.
> 
> Setting MODE_3 was incorrect. It should be MODE_1 but we can let the
> device tree select this and avoid the need to call spi_setup().
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Applied and pushed out as testing for all the normal reasons.

Thanks,

Jonathan

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
> index 3f08b59f4e19..8fde08887f7f 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -683,8 +683,6 @@ static int ad2s1210_probe(struct spi_device *spi)
>  		return ret;
>  
>  	st->fclkin = spi->max_speed_hz;
> -	spi->mode = SPI_MODE_3;
> -	spi_setup(spi);
>  	ad2s1210_initial(st);
>  
>  	return 0;
> 

