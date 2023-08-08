Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90FE77407B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbjHHRD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjHHRDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:03:07 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D7B61A9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:01:30 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51e429e1eabso8014319a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510448; x=1692115248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ZQkFeH22rjTDOEpDXIam8py5vjasCP991vagA65hZQ=;
        b=AOsrMQjJAfs5ddeNPYvJ4eHpvHowbyy1zOvW/3H1neixR9X8Zi1grEv6aeAZR1xIzv
         xc/rqCy4b8HSwl53broXpVQl/BpfG1BFO00i01uWwSTUHKVsLkpIO+Lhgk8f0B1uQl7p
         kU1xOVOpJ33WqpO1Vhnc8yw8JIOxlWDOAlAR8Xg+E4ZgFR+XEJmSW9lrn71UXfeGqJ02
         TeP7DVhcL92Ku7FpOtjC9kttiHKdxcq6q1j6aYYb0hUUyZJsU3nLCHOb57gS1LaLA4S1
         aNjY5Cr/UUN/Fw4gLcw/1FS3RqNdKS1bDkJoPukfanHb3Ucip9zhEdgKWcMviM0wy4/O
         IfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510448; x=1692115248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZQkFeH22rjTDOEpDXIam8py5vjasCP991vagA65hZQ=;
        b=bCwUS3xAERcZFXvcL2l5vgLBe6cjT4a/IdzYl+BIw77fQPtwo403XdymRDrW4DgiWn
         5M/3KSjk9eB+cRKWNhDEqd/Dp2YUiZBf8xqtpZEdhuAN81doGSqVPiUQ6p3LPx7eh0Hf
         YFdAsHN4qQOJmbDoFHrZL0DX9bXtDs+GVgflPVcGkzbD+rLmHG2g2iWeWsN0JFX1N4Ox
         3VFH7vlNZVhWcBxmZkMAUOwG7f+WXfty17McvWYHkorko+GrN/FcdAGtkuY941L6RSCb
         c1gcGx8bAhdNnuyVQMsBSNhn+XOwwTJWyNbJnRwlfypDn/cUqfPyYVHbHrzkh+pECpbi
         Mi5g==
X-Gm-Message-State: AOJu0YwHk6eDWZsOUxiypxE2o4X6+6IYtOf4EKqPviwM9ZnnsmoIfj0C
        kV/9U7biDkpw2B0CqYBi0uDjFKAiFdwQik69rEw=
X-Google-Smtp-Source: AGHT+IEo7S+8nR13x0qahPJ9gWZcNJ3NhjAypGM5gy+WGA3BCrSbM6b2KbLKMlyxDEpOfoYuWWmQqQ==
X-Received: by 2002:a05:600c:c7:b0:3fb:b890:128e with SMTP id u7-20020a05600c00c700b003fbb890128emr7355183wmm.33.1691477811483;
        Mon, 07 Aug 2023 23:56:51 -0700 (PDT)
Received: from [192.168.100.33] ([185.201.60.217])
        by smtp.googlemail.com with ESMTPSA id r15-20020adff70f000000b0031763fd36c4sm12640925wrp.104.2023.08.07.23.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 23:56:50 -0700 (PDT)
Message-ID: <b49f8d07-9de9-48b5-27bd-fce02a82c515@linaro.org>
Date:   Tue, 8 Aug 2023 07:56:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v9 1/7] nvmem: core: Create all cells before adding the
 nvmem device
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20230808062932.150588-1-miquel.raynal@bootlin.com>
 <20230808062932.150588-2-miquel.raynal@bootlin.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230808062932.150588-2-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/08/2023 07:29, Miquel Raynal wrote:
> Let's pack all the cells creation in one place, so they are all created
> before we add the nvmem device.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>   drivers/nvmem/core.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 3f8c7718412b..48659106a1e2 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -998,12 +998,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   	if (rval)
>   		goto err_remove_cells;
>   
> -	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
> -
> -	rval = device_add(&nvmem->dev);
> -	if (rval)
> -		goto err_remove_cells;
> -
>   	rval = nvmem_add_cells_from_fixed_layout(nvmem);
>   	if (rval)
>   		goto err_remove_cells;
> @@ -1012,6 +1006,12 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   	if (rval)
>   		goto err_remove_cells;
>   
> +	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
> +
> +	rval = device_add(&nvmem->dev);
> +	if (rval)
> +		goto err_remove_cells;

All the error handling paths are now messed up with this patch, 
put_device() in error path will be called incorrectly from multiple places.


--srini
> +
>   	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
>   
>   	return nvmem;
