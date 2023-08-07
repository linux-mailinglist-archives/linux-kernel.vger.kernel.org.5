Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FC0773329
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 00:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjHGW5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 18:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHGW5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 18:57:49 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B87EA0;
        Mon,  7 Aug 2023 15:57:48 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so79041991fa.2;
        Mon, 07 Aug 2023 15:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449066; x=1692053866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L3owFGuUrYKgbER0In0IxSiiKAHIVv8B4Lb1yYzeOkw=;
        b=C8/1waoKYO/I3FWwreCIv0b/+Z+CKi2OkSTrypHbAypyZfPWvVWFbJonrv69bSQvTq
         sY1RCs1C/FsCGQCO6GZQhBgx/gi4pPXtk6kM473baug92HKSsPnEhk6TbGiC7QADE7X9
         0C8C42AUGHJUaAADZKllqC2j7zO9BM9mi3UmwIcbVyxoJvNH1CrEvXJrI+Hbj4RV9zAN
         UgHL9V5AinLPXsVzafA/8vzChkG95YsaJJyjy4dgnqEY1CnYj8dWabnysPCfqrz2GiZG
         uBanA3Ok3QkUMfQzyGcVHi7DtcmprEY4yVCesC7Qacfp56Plg28amKIQsokvfTpKGZYa
         fh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449066; x=1692053866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3owFGuUrYKgbER0In0IxSiiKAHIVv8B4Lb1yYzeOkw=;
        b=AohdDuHRb3+oxwlFP240zpRl40rwNDGrnjWdkbML4fvo0bmNDP/pMKIHh4Tmul+5BF
         7RxZqDInubPAYqGp9CyTBpTkvt57XtY6zqp4RT09kbeWzkkh2Nsu/4d9axXCTz4DUSOq
         5zTIS/O0SJEB6P6dSotNOluu3p70YIpbRo/q0UHGee+/ynIa+rE7dMrmQeg4UJpDxLkT
         Hy1siuiUjEm4su5Eo++V3UudOLc9hRM8I8qSi9S2Ff7gkhMzXXD3Ei6EyCexf8nbguHh
         QK25NPExyGMlyg9FiFPTX05vnBStsO8RPIx9hg73A4doov9EH6m7JU09i5cMtEWZE2tY
         T8sA==
X-Gm-Message-State: AOJu0YzYX/KueYKjqpUNcizxpu7KzoDtK6MOQIKoIgI+FAONZRojRdaj
        qcv0uc9oqH8tBjhiaN5GBn8=
X-Google-Smtp-Source: AGHT+IEaQ1FmnxR2Lcz8TY8hDBwvw624GGYtkaRY22vmXJrdxNAig+p4a2Y/7NmmCdfV94rYW3eUKg==
X-Received: by 2002:a05:6512:3e16:b0:4fa:e7e5:66e0 with SMTP id i22-20020a0565123e1600b004fae7e566e0mr9327282lfv.48.1691449066220;
        Mon, 07 Aug 2023 15:57:46 -0700 (PDT)
Received: from mobilestation (89-109-45-41.dynamic.mts-nn.ru. [89.109.45.41])
        by smtp.gmail.com with ESMTPSA id l27-20020ac2555b000000b004fa039eb84csm1633228lfk.198.2023.08.07.15.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 15:57:45 -0700 (PDT)
Date:   Tue, 8 Aug 2023 01:57:44 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dw: Set default value if reg-io-width isn't
 specified
Message-ID: <az7wvv5f42mnuuwkqzpfmwg4ngvl4jvpcfmns7d6lhzogc4qdi@ox64l6i7b44r>
References: <20230807001621.196776-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807001621.196776-1-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 09:16:21AM +0900, Kunihiko Hayashi wrote:
> According to the dt-bindings, the default value of reg-io-width is 4.
> However, the value becomes zero when reg-io-width isn't specified.

This semantic is implied by the dw_read_io_reg() and dw_write_io_reg()
methods. It doesn't seem like that much necessary duplicating it in the
property parse procedure, if not to say - redundant.

-Serge(y)

> 
> Should set the actual value to dws->reg_io_width, considering it
> referenced.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/spi/spi-dw-mmio.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index a963bc96c223..7eafc07ef7aa 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -369,7 +369,9 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
>  
>  	dws->max_freq = clk_get_rate(dwsmmio->clk);
>  
> -	device_property_read_u32(&pdev->dev, "reg-io-width", &dws->reg_io_width);
> +	if (device_property_read_u32(&pdev->dev, "reg-io-width",
> +				     &dws->reg_io_width))
> +		dws->reg_io_width = 4;
>  
>  	num_cs = 4;
>  
> -- 
> 2.25.1
> 
