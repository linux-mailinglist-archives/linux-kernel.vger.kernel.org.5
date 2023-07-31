Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A192F76A1C6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjGaUQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGaUQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:16:17 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE17810FB;
        Mon, 31 Jul 2023 13:16:16 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bb14015560so4216977a34.2;
        Mon, 31 Jul 2023 13:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690834576; x=1691439376;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CDKlY8V+cHTPGD1DkrqwQ0nVjgb58psQ3QjqyDNSrN8=;
        b=Fvk0g7ch9QhxO+6FjH4aGV1vWCANUxATkoanpesXzKgs3Yl17dWtrfhklERpQUeuUr
         FYRFQql+R02ovC3iEyYlWZ+C9d0IliZ1syRTEDw3de2RucLWNoF8Ud67HnoQIH7x1tKJ
         1G42wFg1t1FX1zlXOB5mQ3UKIfhPpiwZcWAFnYMVfNDVp4wifYcz7yAlHEWdNg6kF2CC
         9eyPWceAF5DHvL74+LIOgVs0/U6Zoz5Z00++A5e2fuPTQ8sKJyR5FRYzvEwDuDaqupDz
         RWjFANFKnR6yXQ3OpEmuvuuQLX+qm1XzGWPePmpEtqi8xD1dM6MdHZJpRNi20fCjfI+h
         T86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690834576; x=1691439376;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CDKlY8V+cHTPGD1DkrqwQ0nVjgb58psQ3QjqyDNSrN8=;
        b=lVibBlov2Hj3dvPLQJHQCkCxTUNOU28BBTnpXxTLpRCN0YrFMkcfK96ydvu0ET8WZY
         oMxU0jh7u+Nt+2EUvGXuxDjSsMWdhEB+uOAKfUTMUN3mhMKuGKLFiLD5JcYd1zZ0Y5Ql
         nEVKFemsgNd7n2PlYoM6oja479pzTmECYUMyEwungaWiTJ2D5YdgooGPpBDUCXe1eYJt
         yM84v0vHijXMO+xj+4RWyZaW+hI95ajm57psHwZrc/8glNQ+01DffvcvXyM5sF95TNt/
         VOkhQn9rJfzU6dENPPrv+bTGU0IrolFbFjwYoWAYHvlS9lHO3Ua1v5eBFr7pZDwvLwh2
         nU6Q==
X-Gm-Message-State: ABy/qLYfhRQz6V43oXiriBbDI8+buFJeNIX2mO3xbbc0JvJkqGZ2fF5U
        yioXoJRkZmf+lSYU3XTU4TI=
X-Google-Smtp-Source: APBJJlGRn4QydxSKWRcYeN8JEAsSwNVlHgsYgqNsvqcqaeERmxxtbH+Y495h9EX/V5rIxa8P8C4Orw==
X-Received: by 2002:a05:6830:3a0e:b0:6af:7760:f2d0 with SMTP id di14-20020a0568303a0e00b006af7760f2d0mr11405500otb.32.1690834575997;
        Mon, 31 Jul 2023 13:16:15 -0700 (PDT)
Received: from errol.ini.cmu.edu ([72.95.245.133])
        by smtp.gmail.com with ESMTPSA id w10-20020a0cb54a000000b0063d47a29e6fsm3366510qvd.55.2023.07.31.13.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 13:16:15 -0700 (PDT)
Date:   Mon, 31 Jul 2023 16:16:13 -0400
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/62] mmc: litex_mmc: Convert to platform remove
 callback returning void
Message-ID: <ZMgWjQK5pFLmWZtU@errol.ini.cmu.edu>
References: <20230727070051.17778-1-frank.li@vivo.com>
 <20230727070051.17778-4-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230727070051.17778-4-frank.li@vivo.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 02:59:53PM +0800, Yangtao Li wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Acked-by: Gabriel Somlo <gsomlo@gmail.com>

Thanks,
--Gabriel 

> ---
>  drivers/mmc/host/litex_mmc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
> index 9af6b0902efe..4ec8072dc60b 100644
> --- a/drivers/mmc/host/litex_mmc.c
> +++ b/drivers/mmc/host/litex_mmc.c
> @@ -629,12 +629,11 @@ static int litex_mmc_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int litex_mmc_remove(struct platform_device *pdev)
> +static void litex_mmc_remove(struct platform_device *pdev)
>  {
>  	struct litex_mmc_host *host = platform_get_drvdata(pdev);
>  
>  	mmc_remove_host(host->mmc);
> -	return 0;
>  }
>  
>  static const struct of_device_id litex_match[] = {
> @@ -645,7 +644,7 @@ MODULE_DEVICE_TABLE(of, litex_match);
>  
>  static struct platform_driver litex_mmc_driver = {
>  	.probe = litex_mmc_probe,
> -	.remove = litex_mmc_remove,
> +	.remove_new = litex_mmc_remove,
>  	.driver = {
>  		.name = "litex-mmc",
>  		.of_match_table = litex_match,
> -- 
> 2.39.0
> 
