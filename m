Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9F4771173
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 20:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjHESbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 14:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHESbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 14:31:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBDDB7;
        Sat,  5 Aug 2023 11:31:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 549BB60DEC;
        Sat,  5 Aug 2023 18:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6F2C433C7;
        Sat,  5 Aug 2023 18:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691260260;
        bh=8A0dIW8Ncx95axIcP4Bjov5VDnhG33vLjWhpY8dE0f4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i5PiXd4rnGVWyam+yeyRvqSbBy3qYS7ih/44/RmHm2/i2s143mEYoP33L7gw8s7wy
         OOSTE/BRpZx5rRk3GrKogKm+fHMTc95gdpl5Z+gLtyOIAz/2lpr0zKSGu1I5Tphauh
         1jJaStj2FWU5/6DSrabMJe/8M3H/dNCmL/h0fqAuqK3ozaDcXWsBPsTHJ2OwrTxjsn
         Cn2IhSjU+iJNBwb4KRkV/OP8ilu5COn1KNfLDuoaWvPHpXdHYv5AXaCCt7yduvSKJ1
         sX2ZqPsH1bl8DJDr+VLIIx72d7IPCfVJWMmIU4BNmLyXvcCEM/XCbqdZvm9hM5DKI/
         nmA4Gw5RZdd1Q==
Date:   Sat, 5 Aug 2023 19:30:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-iio@vger.kernel.org, alexandre.torgue@foss.st.com,
        mcoquelin.stm32@gmail.com, lars@metafoo.de,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: Re: [PATCH v2] iio: trigger: stm32-lptimer-trigger: remove unneeded
 platform_set_drvdata()
Message-ID: <20230805193052.690c87e8@jic23-huawei>
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
Both of us failed to notice ret isn't used any more.  Anyhow, I cleaned that
up after spotting the build warning.

Jonathan

>  }
>  
>  static const struct of_device_id stm32_lptim_trig_of_match[] = {

