Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BA9771141
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 20:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjHESFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 14:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjHESFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 14:05:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D7A19B;
        Sat,  5 Aug 2023 11:05:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A332060DBC;
        Sat,  5 Aug 2023 18:05:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80FEC433C7;
        Sat,  5 Aug 2023 18:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691258733;
        bh=6ngnT+YpvhD93TEqzBDpiBPquP2+w46b9BGTWjyu8w0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ltdF/niLESAi+aozfLjIa4kbuIJibRedI0s7K6xJq4WCpejM8K0nuWsnKRFVtQmXT
         bh5uEipChE7m5I0WIVZY/LqNHWKYVOcC067ocbBGMcePhrmbZA4OOMKkx2g/41CsMt
         wubx6QngdGf/sGnMeUxZIjqv8ltjliF1eh+udig+gI/vCqOLqfXU3wywGd4PuVLcR7
         QF/SbUyQ/hmzYtHViN9wVgVuXMiHslBRxFE/h3jXj4UxkRCfxDrd6BXsdWY3oFfmh3
         Fj/qMb4sxyv9dnBTnOOvc8WGkJB1s/iW8ESC/apFjnq421auhVGFVUBTlSOSZYc1Qa
         qcE823d/JH3rA==
Date:   Sat, 5 Aug 2023 19:05:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-iio@vger.kernel.org, alexandre.torgue@foss.st.com,
        mcoquelin.stm32@gmail.com, lars@metafoo.de,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: Re: [PATCH v2] iio: trigger: stm32-lptimer-trigger: remove unneeded
 platform_set_drvdata()
Message-ID: <20230805190524.5dc00883@jic23-huawei>
In-Reply-To: <20230802133509.29381-1-aboutphysycs@gmail.com>
References: <20230802133509.29381-1-aboutphysycs@gmail.com>
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

On Wed,  2 Aug 2023 16:35:09 +0300
Andrei Coardos <aboutphysycs@gmail.com> wrote:

> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Also,
> the private data is defined in this driver, so there is no risk of it being
> accessed outside of this driver file.
> 
> Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>

Oops. Missed there was a v2.  Ah well, end result the same ;)

Thanks,

Jonathan

> ---
> 
> Changelog V1->V2:
> 
> * https://lore.kernel.org/linux-iio/CAH3L5QpuoDYU6qvWH7_z5Yx0cW2qPMbCA8AFEYAPsiEkSzCiwQ@mail.gmail.com/T/#t
> * Adjusted the returning values of the function
> 
> 
>  drivers/iio/trigger/stm32-lptimer-trigger.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/trigger/stm32-lptimer-trigger.c b/drivers/iio/trigger/stm32-lptimer-trigger.c
> index df2416e33375..ab1cc6a05f26 100644
> --- a/drivers/iio/trigger/stm32-lptimer-trigger.c
> +++ b/drivers/iio/trigger/stm32-lptimer-trigger.c
> @@ -88,11 +88,7 @@ static int stm32_lptim_trigger_probe(struct platform_device *pdev)
>  	priv->dev = &pdev->dev;
>  	priv->trg = stm32_lptim_triggers[index];
>  
> -	ret = stm32_lptim_setup_trig(priv);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return stm32_lptim_setup_trig(priv);
>  }
>  
>  static const struct of_device_id stm32_lptim_trig_of_match[] = {

