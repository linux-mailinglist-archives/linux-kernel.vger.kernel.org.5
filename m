Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF774786074
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 21:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238288AbjHWTOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 15:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238078AbjHWTOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 15:14:32 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0797A10C3;
        Wed, 23 Aug 2023 12:14:31 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-63f7c242030so29963826d6.3;
        Wed, 23 Aug 2023 12:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692818070; x=1693422870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4T+N5RAAw1c+yhIr8G224Fh/GWReWEnbHuSJmvVHpR8=;
        b=Py+Ka0YgJJI55CI/55kjB0+4PQkBPF3GQgAuJUAqO4ig52oDxp1+Q2HtF7Bs7MVpPa
         JGJWKVPWP98KkG/DuYmsEZH7w4OYxYmeUV0kIeoXuXH88zMkWvdPGM4Y/75cou2Zq5ha
         IVK92eLt6RN9is7zkKdMXp+nuFoPPXBHT0NvkXLfSwvZRLskD+q6D/0cA/FgFZeIkN/h
         MZoJRhayq9qgNDFZjRXHNBaai/WJDbY6Z5KEW5sXFZ/S80+iTiu6rVVx9eQDKL5uVVUU
         rW+8MJEVWOoeml9aVU34eTFofr5cD2A5LWmDADxBZVQfAnn8OGiWkvhYqmlzVABEtkQ1
         EdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692818070; x=1693422870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4T+N5RAAw1c+yhIr8G224Fh/GWReWEnbHuSJmvVHpR8=;
        b=cDrUkh8mqAt4pT+goLdNngNWAvzQhnCcTqPj4AMDwLTmnVNu5mqnLYmSk1AtWXw9tA
         hsGwUkOW0gChkAQQ6Bhr3t3hrBvxhew05BUtKt0r+RdR2LkteRx8VAaNJLXX/e/gJ4nC
         xYNAlcdcRtUKGjz+MB9r5xIbqqqwerC7do4FOSHBCFhviMHWz3CKsiPVpAjorX1PlsfP
         dr9oNpCfAKX26o5/Ap/8vmA+o/VkgN6Lu4XaY/Op2FhwZB8BA2W+Jv/osAz/6tOh//Il
         dlmuW+RHAcaAPDY0O783G7y6l4m2sRKKeFLwhyvJo7ogaNosgx7zstHy/Do50RfbtK/1
         PRpA==
X-Gm-Message-State: AOJu0YzRaKeJ4D5O8VyMXb8hAUBQ9BHcnZLm6LCkzkVxPaWnN/io7tZ3
        DaEC3OV1Ex0d6Sw3sMxBNUo=
X-Google-Smtp-Source: AGHT+IHjkNNR2fn0UGX+mTk/BvbjJYYuXYQhN4C4weV6FoUiL+6dbLGDrjNJAn3RzeH/HKIytzSaxg==
X-Received: by 2002:a0c:f154:0:b0:64f:50e9:a08a with SMTP id y20-20020a0cf154000000b0064f50e9a08amr4971913qvl.52.1692818070001;
        Wed, 23 Aug 2023 12:14:30 -0700 (PDT)
Received: from shaak (modemcable063.135-226-192.mc.videotron.ca. [192.226.135.63])
        by smtp.gmail.com with ESMTPSA id p5-20020a0ce185000000b0064730b8bc65sm4730455qvl.75.2023.08.23.12.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 12:14:29 -0700 (PDT)
Date:   Wed, 23 Aug 2023 15:14:27 -0400
From:   Liam Beguin <liambeguin@gmail.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com
Subject: Re: [PATCH 2/3] clk: lmk04832: Don't disable vco clock on probe fail
Message-ID: <20230823191427.GB2572839@shaak>
References: <20230802064100.15793-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.37b21939-e4ca-460d-8656-25f90de74f6b@emailsignatures365.codetwo.com>
 <20230802064100.15793-2-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802064100.15793-2-mike.looijmans@topic.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 08:40:59AM +0200, Mike Looijmans wrote:
> The probe() method never calls clk_prepare_enable(), so it should not
> call clk_disable_unprepare() for the vco.clk in the error path. Fixes
> a "lmk-vco already disabled" BUG when probe fails.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

Reviewed-by: Liam Beguin <liambeguin@gmail.com>

> ---
>  drivers/clk/clk-lmk04832.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/clk-lmk04832.c b/drivers/clk/clk-lmk04832.c
> index 188085e7a30b..dd1f0c59ee71 100644
> --- a/drivers/clk/clk-lmk04832.c
> +++ b/drivers/clk/clk-lmk04832.c
> @@ -1505,21 +1505,21 @@ static int lmk04832_probe(struct spi_device *spi)
>  		ret = clk_set_rate(lmk->vco.clk, lmk->vco_rate);
>  		if (ret) {
>  			dev_err(lmk->dev, "failed to set VCO rate\n");
> -			goto err_disable_vco;
> +			goto err_disable_oscin;
>  		}
>  	}
>  
>  	ret = lmk04832_register_sclk(lmk);
>  	if (ret) {
>  		dev_err(lmk->dev, "failed to init SYNC/SYSREF clock path\n");
> -		goto err_disable_vco;
> +		goto err_disable_oscin;
>  	}
>  
>  	for (i = 0; i < info->num_channels; i++) {
>  		ret = lmk04832_register_clkout(lmk, i);
>  		if (ret) {
>  			dev_err(lmk->dev, "failed to register clk %d\n", i);
> -			goto err_disable_vco;
> +			goto err_disable_oscin;
>  		}
>  	}
>  
> @@ -1528,16 +1528,13 @@ static int lmk04832_probe(struct spi_device *spi)
>  					  lmk->clk_data);
>  	if (ret) {
>  		dev_err(lmk->dev, "failed to add provider (%d)\n", ret);
> -		goto err_disable_vco;
> +		goto err_disable_oscin;
>  	}
>  
>  	spi_set_drvdata(spi, lmk);
>  
>  	return 0;
>  
> -err_disable_vco:
> -	clk_disable_unprepare(lmk->vco.clk);
> -
>  err_disable_oscin:
>  	clk_disable_unprepare(lmk->oscin);
>  
> -- 
> 2.17.1
> 
> 
> Met vriendelijke groet / kind regards,
> 
> Mike Looijmans
> System Expert
> 
> 
> TOPIC Embedded Products B.V.
> Materiaalweg 4, 5681 RJ Best
> The Netherlands
> 
> T: +31 (0) 499 33 69 69
> E: mike.looijmans@topicproducts.com
> W: www.topic.nl
> 
> Please consider the environment before printing this e-mail
