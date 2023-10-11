Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F40D7C576C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbjJKOvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbjJKOvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:51:36 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FD4A4;
        Wed, 11 Oct 2023 07:51:34 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-49b289adca9so2836873e0c.3;
        Wed, 11 Oct 2023 07:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697035894; x=1697640694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tdMCYsnm0eBDCU0m6bekJGqM2rj9J3VQsaI4tQwRDOc=;
        b=edu/cdznfFM1hy5xpJcPzaOJAouaPK/SO1tnMuK7DwKBoXTFy0BtjZjCBWZGApwxnr
         zrPmci5y+EKdS3VIdPYabvHZpBaWD79EchdwBxUuHNnncn3Gv8uSWcnEYcDlccLcNyS6
         F+5PH0ZrUj3M9g2R1+GZoOS51MNWT5X2RWkph5ABRGI6y6yoQbhWOMB7xuO+Ev8vkGsq
         g/jy4UOcqvu6NX1kZOCbq/7cfv+ot9GbL+MfMlO+bLwmUVZkEQSV1dfJ4s8mmofVZive
         d8rHNg7EQNgAa+ik74sXD6rhVcWn+Be3J6JxRYRJzCmp8TW5B9CghZhUyIgTLvNIAsiO
         PdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697035894; x=1697640694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdMCYsnm0eBDCU0m6bekJGqM2rj9J3VQsaI4tQwRDOc=;
        b=ZuisqSE8tNe+RmAUHd7v4Qn5SWytW/SDn11NkWFyHlLk4CA+csfp+MSOkv48BwkSSo
         IvLMsW7NtP0jx0qDSE7c41UV/TFMMIXNl27ps3bL6muzNz8nqSsdfxG32kXB3WCV34Uo
         xTK1lxOqMoDj46876lINxr7EkCiSqBQd6S+HK/iEtrh+UP0MKCwHNC71jtzvt/gewLZn
         ZoQAFTuFK1q5XzycmN70zu6lSNx1TFhvvvFLpviZZxbldtH8bvZ61bUjO/AjAftB+M5T
         /AWhqdiwtyh+GTSdmvW8W9Rp/3tDS1QcP7BEZcU+wiJBgGtWCaG0U9jDQQPnOtQMA8G/
         W5GQ==
X-Gm-Message-State: AOJu0YwAr1LoaHnftCn9cxZy8Drt5BesHOrP+6CVpvPcP/+c5g2bQ3Jx
        +H2gwD0tCNIuYR7qqBQhYLE=
X-Google-Smtp-Source: AGHT+IGqirDGgHiwrRgzh60qr0fN64HGJtZdtf2Im7Q6UclJncqti4lvs967evnbmLDifcd6D/7cLA==
X-Received: by 2002:a1f:e203:0:b0:495:ec90:997e with SMTP id z3-20020a1fe203000000b00495ec90997emr16267895vkg.7.1697035893879;
        Wed, 11 Oct 2023 07:51:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l21-20020ac5cc55000000b0049d705614d1sm2530498vkm.17.2023.10.11.07.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 07:51:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 11 Oct 2023 07:51:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Bharat Bhushan <bbhushan2@marvell.com>
Cc:     wim@linux-watchdog.org, inux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        George Cherian <george.cherian@marvell.com>
Subject: Re: [PATCH 2/2] drivers: watchdog: marvell_gti: Program the
 max_hw_heartbeat_ms
Message-ID: <aa76d1fd-dfd5-438b-9a77-9d1d74d65a25@roeck-us.net>
References: <20231009044037.514570-1-bbhushan2@marvell.com>
 <20231009044037.514570-2-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009044037.514570-2-bbhushan2@marvell.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 10:10:37AM +0530, Bharat Bhushan wrote:
> From: George Cherian <george.cherian@marvell.com>
> 
> Program the max_hw_heartbeat_ms value so that the watchdog_pretimeout
> worker is activated. This kernel worker thread makes sure to ping the
> watchdog in case the userspace is unable to do so. This kernel worker
> ping will be done only till the full watchdog timeout there by
> maintaining the watchdog functionality in case of a real hang.
> 
> Signed-off-by: George Cherian <george.cherian@marvell.com>
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/marvell_gti_wdt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/marvell_gti_wdt.c b/drivers/watchdog/marvell_gti_wdt.c
> index 25b7ce0f0738..bfe0c819248c 100644
> --- a/drivers/watchdog/marvell_gti_wdt.c
> +++ b/drivers/watchdog/marvell_gti_wdt.c
> @@ -299,6 +299,7 @@ static int gti_wdt_probe(struct platform_device *pdev)
>  
>  	/* Maximum timeout is 3 times the pretimeout */
>  	wdog_dev->max_timeout = max_pretimeout * 3;
> +	wdog_dev->max_hw_heartbeat_ms = max_pretimeout * 1000;
>  	/* Minimum first timeout (pretimeout) is 1, so min_timeout as 3 */
>  	wdog_dev->min_timeout = 3;
>  	wdog_dev->timeout = wdog_dev->pretimeout;
> -- 
> 2.34.1
> 
