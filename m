Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58246754A7B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 19:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjGORbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 13:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjGORby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 13:31:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7FF10D1;
        Sat, 15 Jul 2023 10:31:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FC9360BE9;
        Sat, 15 Jul 2023 17:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F182C433C8;
        Sat, 15 Jul 2023 17:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689442312;
        bh=tDNr307WnluBGJn9xkRFpUnyj+2ZLZXNwdrZYJ/6JRw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dhxo7zOIFIH4+TSQ/Ll5S0QB0PKmTzA6mnHt+IaF6AtWuZNn/jnKyd6JCq/bnelEJ
         b3M9VprbK4DZuGpSUSdMXLmBWoTq2x9rryHKJ67BDNpxd8xeRZwrSTOjwa9ulX68ja
         5QzZ6Ga+NPR9LGN6UIBlEs+ue5XLEcOI+rmJjmi2/xYBYFMt3XLe2hUc/uBEUy6N/t
         MbGcPZMkqJ7WHmercReo+/+idPvI6cjDT0nU3kPBBA35THf03qVMilDt1+KOmRV9FA
         csYopv2wO2Fvn3DcWeYhwSZkRpejFEOG0LBS1+bvWvqd1iRX2IG4LAsNI7ceeQEyG4
         Vi0JI3k7q2a1A==
Date:   Sat, 15 Jul 2023 18:31:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     pangzizhen001@208suo.com
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio/adc: Fix comment typo
Message-ID: <20230715183147.26f961d0@jic23-huawei>
In-Reply-To: <943cc02207bbcc042fed163915a88ef4@208suo.com>
References: <20230712095719.32259-1-wangjianli@cdjrlc.com>
        <943cc02207bbcc042fed163915a88ef4@208suo.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 18:00:25 +0800
pangzizhen001@208suo.com wrote:

> Delete duplicate word "the"
> 
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
Please resend without the Fwd: prefix on the email.
That stops the b4 tool from picking this up automatically.

Thanks,

Jonathan

> ---
>   drivers/iio/adc/palmas_gpadc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/palmas_gpadc.c 
> b/drivers/iio/adc/palmas_gpadc.c
> index 27b2632c1037..76e0a4d8af3b 100644
> --- a/drivers/iio/adc/palmas_gpadc.c
> +++ b/drivers/iio/adc/palmas_gpadc.c
> @@ -458,7 +458,7 @@ static int palmas_gpadc_get_calibrated_code(struct 
> palmas_gpadc *adc,
>    *
>    * The gain error include both gain error, as specified in the 
> datasheet, and
>    * the gain error drift. These paramenters vary depending on device and 
> whether
> - * the the channel is calibrated (trimmed) or not.
> + * the channel is calibrated (trimmed) or not.
>    */
>   static int palmas_gpadc_threshold_with_tolerance(int val, const int 
> INL,
>                            const int gain_error,

