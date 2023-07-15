Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF647754A52
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 19:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjGORBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 13:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGORBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 13:01:49 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3732211F;
        Sat, 15 Jul 2023 10:01:47 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6686708c986so3087696b3a.0;
        Sat, 15 Jul 2023 10:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689440507; x=1692032507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dw+eoPoIl4WIKQoi7mqkPxMf2lZDlf/tWVipPCRQAg8=;
        b=NC55uBLUfK5ne801vham6DNzUo/4JkQjmlgzRQDLA707GvHz9U6Kb3irR1ePYxTmsf
         0IQ7PKH/BXrQYU0o18s2xem58yBgDr2e7dyBQKeuDgLwBu4omwG4ELhLOVrNfX/qL4SJ
         9Gi9+3z+jHyiXxlq7T3LULUaDX1N69N2+qw6gGEQN7iq0JunyGz/Qq+44soVWrftYZvk
         Vfbg6iAj4sP1uEqb1jqriRYtWnYr0lHILGHAjHWzJIg9qnR/kmj6arSEV58CIMz47Hjf
         YNGV+6mxIoaii0bLsg3n3c907dKcb1pfTLg4C1wyu4kxqFT6azVBtn1x+CdFIs3Bu69n
         5OLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689440507; x=1692032507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dw+eoPoIl4WIKQoi7mqkPxMf2lZDlf/tWVipPCRQAg8=;
        b=RByhgreFtWrXh1wX+IuoHSy3WmowE+N99KN/9UlGT6yxmWsE12hs64RBg8VeIyGp29
         csytGVEm+Ew5ZicpLaMZ1NOWJ84zwrIHrBEPoNNN/QWwfRqt6l/5lXyUg86jPE16BA32
         ZBFrnD2JsH7HA6xXb0FWQT6EABcR2Nqn1oI1p/1BIkjw7Jsx6GwOPTvAOg1jVROA/157
         8fNTDCtz0lcrfPnsJvTB0M+h4K87jDPEDWTd4KgSP8lqNpq5t8YJYYfWA/qP5BZ22K+m
         E5IQmTL9Eutgb4jfkp6qgJ25SMXb/gvZdH13NAzwUGg7fbHaK9u2jZIcE6GVb3GG7Uej
         WtGA==
X-Gm-Message-State: ABy/qLZaWbg1Q1xpVMqRV7pcCDjPSHYU06zkHXj4CLiX3EkxypAwHWVz
        HPmLAbDBO/P9pMkn/8QH/2H3QvKpp2U=
X-Google-Smtp-Source: APBJJlGBabrwPs81eXRpURpIhIooj7BgKoOPst9/16pmUGvxnMe1oZ7JQppBcpbDJ+KQcpiYtaaW4w==
X-Received: by 2002:a05:6a00:9a0:b0:668:8545:cbeb with SMTP id u32-20020a056a0009a000b006688545cbebmr11867620pfg.15.1689440507285;
        Sat, 15 Jul 2023 10:01:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m19-20020aa79013000000b0067b384d5955sm8972768pfo.26.2023.07.15.10.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 10:01:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 15 Jul 2023 10:01:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: bt1-pvt: Convert to
 devm_platform_ioremap_resource()
Message-ID: <e0408d4f-3569-4a60-8cf6-8fdd40c3cbf7@roeck-us.net>
References: <20230704094306.21933-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704094306.21933-1-frank.li@vivo.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 05:43:06PM +0800, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/bt1-pvt.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/bt1-pvt.c b/drivers/hwmon/bt1-pvt.c
> index 8d402a627306..b77ebac2e0ce 100644
> --- a/drivers/hwmon/bt1-pvt.c
> +++ b/drivers/hwmon/bt1-pvt.c
> @@ -891,15 +891,8 @@ static struct pvt_hwmon *pvt_create_data(struct platform_device *pdev)
>  static int pvt_request_regs(struct pvt_hwmon *pvt)
>  {
>  	struct platform_device *pdev = to_platform_device(pvt->dev);
> -	struct resource *res;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		dev_err(pvt->dev, "Couldn't find PVT memresource\n");
> -		return -EINVAL;
> -	}
> -
> -	pvt->regs = devm_ioremap_resource(pvt->dev, res);
> +	pvt->regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(pvt->regs))
>  		return PTR_ERR(pvt->regs);
>  
