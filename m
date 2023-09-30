Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC717B402C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 13:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjI3L6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 07:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjI3L6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 07:58:21 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10640D6;
        Sat, 30 Sep 2023 04:58:19 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3513c435465so3772715ab.0;
        Sat, 30 Sep 2023 04:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696075098; x=1696679898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U4B8cqh/E8dvMkxyYDZyl7ZQqxhx7sl7i0aMKMFX1cc=;
        b=YyeaufnBSFIDMckrtNx7qIhq2XMXZD63Z7NQKyOvypoc6LquZDwSYKvZtqOhYjt5Zb
         6BE8Cn8pl0hNZgWTh9ZwHowNLaDClDZW+cpq6TsKhvo72Rwi8X/s7uemZkac1FaXXd5d
         i8QUz6gBb+6HAfufAeZ3v6MYLtXwB6BEkKdHx2PI2gdTcyZBUG0cTWYnm27GYmdjSoHN
         zElWlPg2t2eH0OxK959TOTbPnnR3L+tAMU3j49qJeKvmZcXwgJzP8n3DRiKlnhAYnF7W
         tqbfqjGtmxQgkPeS6pMKnhFRju/UrnzKddgd/zwqGQP9cFZUu2VcjhhFZd7ADKJAbkUB
         hnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696075098; x=1696679898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4B8cqh/E8dvMkxyYDZyl7ZQqxhx7sl7i0aMKMFX1cc=;
        b=dEAHuhGMnB7GKlnsIbRjrA7uAwlEZVwryU9517HobXtdafSD7yxgHuLV7s+NeQZjDk
         tVnE51VpzI9C1ZCbTWELxvCM4BKO1BrDGqirDiS2ib2jlKk8lGB6ua3vAB5r9v5C8ll0
         S6PQf4EpfqwBqEsLxOYuDxreHqy5bhab4k5O6KVjUKmyc/pKayZ++ARa1dAvuv7pO5Ct
         BxsPXIe22+GR/Kj+XtBI97VguHDxsaCXDBTXffYHd8IFN0+XwyItoHutktkic5fzKiHm
         5c2QP56R6nRKbTRDRXx/H+77YfLhUknWTZ1VQ7zvXsdyQC9v8sqrL4/H26yTp/juodoE
         XmbA==
X-Gm-Message-State: AOJu0YyRM2V6668r9f5liQZoOiXgPDm3A7WIAsXjaG/ntr73XuvVOG+H
        tuXtCgSMi8+p0yOjOgEvyJXcb5kCmjo=
X-Google-Smtp-Source: AGHT+IFL9BXm3OjXoEc4q3qMpme4S27UurE4+d4CiPM6lBLR5DAmOgKh529unCKKqYs5hUwLo0WcvA==
X-Received: by 2002:a05:6e02:974:b0:352:682c:1b91 with SMTP id q20-20020a056e02097400b00352682c1b91mr2764724ilt.4.1696075098275;
        Sat, 30 Sep 2023 04:58:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q14-20020a056e02078e00b003514edd0415sm3330299ils.67.2023.09.30.04.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 04:58:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 30 Sep 2023 04:58:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     j@jannau.net
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: apple: Deactivate on suspend
Message-ID: <e0a6f9f3-b472-4fda-829c-5d8f29234a4f@roeck-us.net>
References: <20230930-apple-watchdog-suspend-v1-1-1998c0be9fd7@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230930-apple-watchdog-suspend-v1-1-1998c0be9fd7@jannau.net>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 10:19:26AM +0200, Janne Grunau via B4 Relay wrote:
> From: Janne Grunau <j@jannau.net>
> 
> The watchdog remains active after putting the system into suspend. Add
> PM callbacks to deactivate the watchdog on suspend an re-activate it on
> resume.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  drivers/watchdog/apple_wdt.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/watchdog/apple_wdt.c b/drivers/watchdog/apple_wdt.c
> index eddeb0fede89..2167e0ba705e 100644
> --- a/drivers/watchdog/apple_wdt.c
> +++ b/drivers/watchdog/apple_wdt.c
> @@ -173,6 +173,8 @@ static int apple_wdt_probe(struct platform_device *pdev)
>  	if (!wdt->clk_rate)
>  		return -EINVAL;
>  
> +	platform_set_drvdata(pdev, wdt);
> +
>  	wdt->wdd.ops = &apple_wdt_ops;
>  	wdt->wdd.info = &apple_wdt_info;
>  	wdt->wdd.max_timeout = U32_MAX / wdt->clk_rate;
> @@ -190,6 +192,28 @@ static int apple_wdt_probe(struct platform_device *pdev)
>  	return devm_watchdog_register_device(dev, &wdt->wdd);
>  }
>  
> +static int __maybe_unused apple_wdt_resume(struct device *dev)
> +{
> +	struct apple_wdt *wdt = dev_get_drvdata(dev);
> +
> +	if (watchdog_active(&wdt->wdd) || watchdog_hw_running(&wdt->wdd))
> +		apple_wdt_start(&wdt->wdd);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused apple_wdt_suspend(struct device *dev)
> +{
> +	struct apple_wdt *wdt = dev_get_drvdata(dev);
> +
> +	if (watchdog_active(&wdt->wdd) || watchdog_hw_running(&wdt->wdd))
> +		apple_wdt_stop(&wdt->wdd);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(apple_wdt_pm_ops, apple_wdt_suspend, apple_wdt_resume);

Comments above that define say

/* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */

and with that the __maybe_unused is no longer necessary.

> +
>  static const struct of_device_id apple_wdt_of_match[] = {
>  	{ .compatible = "apple,wdt" },
>  	{},
> @@ -200,6 +224,7 @@ static struct platform_driver apple_wdt_driver = {
>  	.driver = {
>  		.name = "apple-watchdog",
>  		.of_match_table = apple_wdt_of_match,
> +		.pm = pm_sleep_ptr(&apple_wdt_pm_ops),
>  	},
>  	.probe = apple_wdt_probe,
>  };
> 
> ---
> base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
> change-id: 20230930-apple-watchdog-suspend-7f73831130fb
> 
> Best regards,
> -- 
> Janne Grunau <j@jannau.net>
> 
