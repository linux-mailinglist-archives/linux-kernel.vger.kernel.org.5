Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3499879A263
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 06:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbjIKEYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 00:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjIKEYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 00:24:44 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A932D10D;
        Sun, 10 Sep 2023 21:24:39 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76ef80a503fso247056885a.1;
        Sun, 10 Sep 2023 21:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694406279; x=1695011079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kgyKAOzGQAorCpKqtt6VuyYkMPJvHbgZanCQraUC9To=;
        b=TtLmdwimmzNreyl9LBuQS0Ut69ublRSloGtvyy3rq5DHHwEAavCP02hads5E1NXJ8T
         t2dRZGD1E+B5Z6B58WZ60x7EhgJhyiGRXgf0VSDAg1tNVhA+W2LXJG9EHKT1UZLlv4Z6
         E3rumtPJrOzhVvNjTsiMQLIlrazetvkpjbJG5GFPYkASM420UORHUKbptXmNuQIOQpwA
         4d5B4etn0S2kfne++aFqaehJ9W0P7dTOtgmr0zqIKr7ti73lXCV40nODGLgi9YqzZNB8
         HVMY2dwnntpSlNjXa9IxbyopgNfz3LNVVrp3dMJtZd2baiVeYscC+1cZwIv0/QBsINka
         /g+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694406279; x=1695011079;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kgyKAOzGQAorCpKqtt6VuyYkMPJvHbgZanCQraUC9To=;
        b=YvbktxYeZfE8hdNIe2nKu4RFo59GU9mzedTGSkrJzzyVnA9wAQiNYSwe9diPz/DUZV
         kQnSRAM09PX/aE2SgFoNFp6dprD9BU9Pk3nDcMwhuj6f3tHMCRLfyKrv4wE+/IEB199E
         Sw7y2kCRxDMyjSCCU4GTS/2V56Tue1g2dzQYdcJULiSZ86nSLb+s8EoOXCSWu9yq2HSP
         pQfwrjEBy46XM6+pCLRgIa8JFqwEBRx3I+8P5WYqJlwxdAePuCJJNBApTxi1f2fqACcx
         THZmS/4UFlO4I6j2+RIPCwso1eIW3SoTCUhWIr4ik6zjjI5a69v7nmZCUiPJkcMh0ed+
         oi7A==
X-Gm-Message-State: AOJu0YyJNla/pEuXsLzPoCjcYLknsxK9ntjTST/STzbVLuqZ4bR97bw/
        WDa1Yu6CifyWYsg78rgndwg=
X-Google-Smtp-Source: AGHT+IG9qNQECCcNwSO9WsEyWgyRxZuSJJPrVCKXdoBvIIa+AiDYUpnzsRMO3eRSTHj55dWZXHBpgg==
X-Received: by 2002:a05:620a:1003:b0:76f:1742:2f6c with SMTP id z3-20020a05620a100300b0076f17422f6cmr8891254qkj.66.1694406278713;
        Sun, 10 Sep 2023 21:24:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id dp41-20020a0566381ca900b0042bb2448847sm1907602jab.53.2023.09.10.21.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 21:24:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b6054cbd-ca4e-43d1-83a8-ad6bdf89c0cf@roeck-us.net>
Date:   Sun, 10 Sep 2023 21:24:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/3] hwmon: (pmbus/mpq7932) Get page count based on chip
 info
Content-Language: en-US
To:     Saravanan Sekar <saravanan@linumiz.com>, sravanhome@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jdelvare@suse.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20230911034150.181880-1-saravanan@linumiz.com>
 <20230911034150.181880-2-saravanan@linumiz.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230911034150.181880-2-saravanan@linumiz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/23 20:41, Saravanan Sekar wrote:
> Get page count using compatible match to support the series of chipsets
> which differs in number of regualator/page.
> 
> Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
> ---
>   drivers/hwmon/pmbus/mpq7932.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/mpq7932.c b/drivers/hwmon/pmbus/mpq7932.c
> index 865d42edda1a..af3e5e9590c8 100644
> --- a/drivers/hwmon/pmbus/mpq7932.c
> +++ b/drivers/hwmon/pmbus/mpq7932.c
> @@ -105,7 +105,7 @@ static int mpq7932_probe(struct i2c_client *client)
>   		return -ENOMEM;
>   
>   	info = &data->info;
> -	info->pages = MPQ7932_NUM_PAGES;
> +	info->pages = (int)device_get_match_data(&client->dev);

I kind of doubt that this works without generating a compiler warning.

Also, does this work with CONFIG_OF=n ?

Guenter

>   	info->format[PSC_VOLTAGE_OUT] = direct;
>   	info->m[PSC_VOLTAGE_OUT] = 160;
>   	info->b[PSC_VOLTAGE_OUT] = -33;
> @@ -115,7 +115,7 @@ static int mpq7932_probe(struct i2c_client *client)
>   	}
>   
>   #if IS_ENABLED(CONFIG_SENSORS_MPQ7932_REGULATOR)
> -	info->num_regulators = ARRAY_SIZE(mpq7932_regulators_desc);
> +	info->num_regulators = info->pages;
>   	info->reg_desc = mpq7932_regulators_desc;
>   #endif
>   
> @@ -129,7 +129,7 @@ static int mpq7932_probe(struct i2c_client *client)
>   }
>   
>   static const struct of_device_id mpq7932_of_match[] = {
> -	{ .compatible = "mps,mpq7932"},
> +	{ .compatible = "mps,mpq7932", .data = (void *)MPQ7932_NUM_PAGES },
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, mpq7932_of_match);

