Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D222478321D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 22:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjHUUUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjHUUUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:20:39 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A206CE3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:20:37 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68a3cae6e1eso1226800b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692649237; x=1693254037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PJzS96kMorSHcInyTnYW6Eub6rGk1Addu59Qv90D7BM=;
        b=UFKHdM3hyYjf0/QyShd749nOd5v65vukEEJzaNxswmyTx26BTeCZum7NuLOyDB9+fk
         lmVTnsgSqV4u0O/XKzVR3PLwCDfa79wQvoGvsSkQpjesXQHwoWi8JIzmFUDwmmQuajM+
         hvXbb0Dm09SEPLF3eErYTEXcP7D4nTrMb9V3caY2/N/s8JGjJUziR8bR3Q4e0pS3y9hC
         55k/zBAZPBSqA7218bpkXWTQv1yeej8MzRcCJ77APGz/omaadx2xuHQ8EV7OjpjBHVV9
         9giy3kgKeRDe5VsqNXtEQv7JOtn/Ke2J6Qbajei8XyKXGNja4pLsHK2ER7Opyg4avcpE
         SjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692649237; x=1693254037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJzS96kMorSHcInyTnYW6Eub6rGk1Addu59Qv90D7BM=;
        b=Nl8ihyk+pQXmt5pfGkxL8Gt82MkS+ZO+yPdpZ2IfaVaXavPiIIlCVuA4+q1D8menp+
         TsUOPRVomLzn1Jwn6hhKtKAZfn3srODSZJ9CUqf6yq9e/sT1ZHoQU8ZW+kOkocukT7AZ
         WqNZMBbBeEJB8jpxD2ANJ9z4wcrKnabRXdYFWFt0t2gJF0+beym3smBNxTpyBQoGWsev
         mB/CVr7xT87z66njsqbnKH5BtP1R8bSzb4Xsz/poP2ioifnM9eCZlH2x70IVSMZ0m1SB
         NV64JRTBuHmd7+S8ojAJxLwLTVw4sI512UpU1vmliIxh0cthkX6qsEVr8k+qCcoksQFS
         1qzw==
X-Gm-Message-State: AOJu0YylbPEl13/1D/hA0lCTgOfrVR+Dle/tBH3bPtLei3l+KPegnhaU
        FIW8FuTBlSWXE5x5cIbtEaCOfw==
X-Google-Smtp-Source: AGHT+IEuRV2LPIg5opv4ffRpSuXdwrxTeyThcglAzmosQIGFbR+27zcpzc0KAqZXKHd6c1spz2/hGg==
X-Received: by 2002:a05:6a20:7f8f:b0:135:38b5:7e58 with SMTP id d15-20020a056a207f8f00b0013538b57e58mr6622091pzj.37.1692649237041;
        Mon, 21 Aug 2023 13:20:37 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:2289:93a7:5faa:cd11])
        by smtp.gmail.com with ESMTPSA id s15-20020aa7828f000000b006877a2e6285sm6472296pfm.128.2023.08.21.13.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 13:20:36 -0700 (PDT)
Date:   Mon, 21 Aug 2023 14:20:33 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        linux-remoteproc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: stm32: fix incorrect optional pointers
Message-ID: <ZOPHEUQYzbYsFS7Y@p14s>
References: <20230724195704.2432382-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724195704.2432382-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 09:56:49PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Compile-testing without CONFIG_OF shows that the of_match_ptr() macro
> was used incorrectly here:
> 
> drivers/remoteproc/stm32_rproc.c:662:34: warning: unused variable 'stm32_rproc_match' [-Wunused-const-variable]
> 
> As in almost every driver, the solution is simply to remove the
> use of this macro. The same thing happened with the deprecated
> SIMPLE_DEV_PM_OPS(), but the corresponding warning was already shut
> up with __maybe_unused annotations, so fix those as well by using the
> correct DEFINE_SIMPLE_DEV_PM_OPS() macros and removing the extraneous
> __maybe_unused modifiers. For completeness, also add a pm_ptr() to let
> the PM ops be eliminated completely when CONFIG_PM is turned off.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307242300.ia82qBTp-lkp@intel.com
> Fixes: 03bd158e1535e ("remoteproc: stm32: use correct format strings on 64-bit")
> Fixes: 410119ee29b6c ("remoteproc: stm32: wakeup the system by wdg irq")
> Fixes: 13140de09cc2d ("remoteproc: stm32: add an ST stm32_rproc driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/remoteproc/stm32_rproc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 

Fixed 13-character SHAs and applied.

Thanks,
Mathieu


> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> index 98234b44f0389..9d9b13530f78a 100644
> --- a/drivers/remoteproc/stm32_rproc.c
> +++ b/drivers/remoteproc/stm32_rproc.c
> @@ -921,7 +921,7 @@ static void stm32_rproc_remove(struct platform_device *pdev)
>  	rproc_free(rproc);
>  }
>  
> -static int __maybe_unused stm32_rproc_suspend(struct device *dev)
> +static int stm32_rproc_suspend(struct device *dev)
>  {
>  	struct rproc *rproc = dev_get_drvdata(dev);
>  	struct stm32_rproc *ddata = rproc->priv;
> @@ -932,7 +932,7 @@ static int __maybe_unused stm32_rproc_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int __maybe_unused stm32_rproc_resume(struct device *dev)
> +static int stm32_rproc_resume(struct device *dev)
>  {
>  	struct rproc *rproc = dev_get_drvdata(dev);
>  	struct stm32_rproc *ddata = rproc->priv;
> @@ -943,16 +943,16 @@ static int __maybe_unused stm32_rproc_resume(struct device *dev)
>  	return 0;
>  }
>  
> -static SIMPLE_DEV_PM_OPS(stm32_rproc_pm_ops,
> -			 stm32_rproc_suspend, stm32_rproc_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(stm32_rproc_pm_ops,
> +				stm32_rproc_suspend, stm32_rproc_resume);
>  
>  static struct platform_driver stm32_rproc_driver = {
>  	.probe = stm32_rproc_probe,
>  	.remove_new = stm32_rproc_remove,
>  	.driver = {
>  		.name = "stm32-rproc",
> -		.pm = &stm32_rproc_pm_ops,
> -		.of_match_table = of_match_ptr(stm32_rproc_match),
> +		.pm = pm_ptr(&stm32_rproc_pm_ops),
> +		.of_match_table = stm32_rproc_match,
>  	},
>  };
>  module_platform_driver(stm32_rproc_driver);
> -- 
> 2.39.2
> 
