Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60F275CFD4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjGUQkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjGUQkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:40:25 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F13A3C3B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:39:51 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-3456fda4ed1so10457575ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689957573; x=1690562373;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+Axq9Y518vexv+QN4O7WGt6ZETmpKKo9hOSmvIWS5SQ=;
        b=ggxGIdkf7lTgwnmgdOGKXFBocbn/eBgNs01maInDePkixTULUWJdFT4IzzRAlhuwpY
         f7D4G+H36MeDlZoMP5OspZS7i3PefyR72tWZeT1uOy5vakVRZnqP8LVvkhF8tIcfpBjb
         /RtoluN5eBGzu9TIflo2aGuhTUg/yu3EETshCDiBpjW52sxypvluTzwmk+FBGFtJRXPI
         TrqG/mpCisKLFjnPtf+ErYA2CNseDBFiUUIhjr3bGyMl+hUb/iW0PLipHqTSIXAWphyz
         a8fh45McYzDz+WyGDFsGD5qo3Q7M8qG0p8LSK2qnxoNyfGMTU71vMQTI8OTE/fokEiCJ
         s3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689957573; x=1690562373;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Axq9Y518vexv+QN4O7WGt6ZETmpKKo9hOSmvIWS5SQ=;
        b=FUVWZhXrnGpoLM2nu3LIoBdaF/8SdlqsiCBeDjrVI9LPZ4rBcWYAdG+chXt4zfU/GT
         rb6dftVamz3IkYXUo4xI3ntCSp2DhXxIc4RsMbRhBpXP+Rp+3W3fHCFJD34IgNyt8AwZ
         kvhKWEzvGEQABXR1prgQuHuR00Ocon8MX0OLAoG879cgYT4WVIaZOfRD2yROHTajjoDx
         dcQv5Y6n3KGiCp7UlyUzaWdFV8iKd9EO8LmH1gVfay/wCS/nwr8C/DDkJDbZSxSABjpW
         l1GFKui7j+V8a2Hdkoy4zjEQX7ShPJF+PsaAfnDfFbbYMGJ9f2HBqaHuGg3cREzVIrgT
         XmyA==
X-Gm-Message-State: ABy/qLb4RJVNi/BH1eGxKkhsuUXESh5E2d2C4Z5umMGzVWDqxzrl9eKB
        FSHcckmOiDPWrf0tjxjGj0s=
X-Google-Smtp-Source: APBJJlEX1WECLQbsp/StiFPkisfxxOp6agASeOzxARGU38I8s1GpdfZRgd0/i/VSNWYN1jC5C10fxw==
X-Received: by 2002:a05:6e02:168e:b0:348:8da5:879e with SMTP id f14-20020a056e02168e00b003488da5879emr581964ila.29.1689957573419;
        Fri, 21 Jul 2023 09:39:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h13-20020a02cd2d000000b0042b2501485csm1098420jaq.111.2023.07.21.09.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 09:39:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <09c05570-bb4b-1bbd-a835-363b77d1c930@roeck-us.net>
Date:   Fri, 21 Jul 2023 09:39:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] regmap: Remove dynamic allocation warnings for rbtree and
 maple
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org
References: <20230721-regmap-enable-kmalloc-v1-1-f78287e794d3@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230721-regmap-enable-kmalloc-v1-1-f78287e794d3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/23 09:31, Mark Brown wrote:
> Thanks to Dan and Guenter's very prompt updates of the rbtree and maple
> caches to support GPF_ATOMIC allocations and since the update shook out
> a bunch of users at least some of whom have been suitably careful about
> ensuring that the cache is prepoulated so there are no dynamic
> allocations after init let's revert the warnings.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/base/regmap/regmap.c | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
> index 6c637b18d6b0..8b37451fa931 100644
> --- a/drivers/base/regmap/regmap.c
> +++ b/drivers/base/regmap/regmap.c
> @@ -723,15 +723,6 @@ struct regmap *__regmap_init(struct device *dev,
>   	} else {
>   		if ((bus && bus->fast_io) ||
>   		    config->fast_io) {
> -			/*
> -			 * fast_io is incompatible with REGCACHE_RBTREE and REGCACHE_MAPLE
> -			 * since both need to dynamically allocate memory.
> -			 */
> -			if (config->cache_type == REGCACHE_RBTREE ||
> -			    config->cache_type == REGCACHE_MAPLE) {
> -				ret = -EINVAL;
> -				goto err_name;
> -			}
>   			if (config->use_raw_spinlock) {
>   				raw_spin_lock_init(&map->raw_spinlock);
>   				map->lock = regmap_lock_raw_spinlock;
> 
> ---
> base-commit: b0393e1fe40e962574613a5cdc4a470d6c1de023
> change-id: 20230721-regmap-enable-kmalloc-2e2d0d018cef
> 
> Best regards,

