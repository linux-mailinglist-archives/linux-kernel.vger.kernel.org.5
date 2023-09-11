Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCEB79A25F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 06:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjIKEXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 00:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjIKEXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 00:23:39 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678BA106;
        Sun, 10 Sep 2023 21:23:34 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7950fac19f2so154553639f.3;
        Sun, 10 Sep 2023 21:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694406213; x=1695011013; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZwezSlz+P0+Z2mHsdJjGRZIZ23KKBUbArptodkuCCLA=;
        b=DSh+3ypCeDiXkYqFcSQbHWFVV+zM+aKANtHGzr8K+egYS0pTFagFZUeQFA5Hx+NB92
         X9Z2w31JldD5SFq81vPkJzMaTk79xbcsAYEM7JSSlUWKoiD/xSQ1ux1C/mY+MBUHHp9V
         vuh4rirfn4MQ9gt0aZfy1gkCudQyI887wo37do/N1hlxH8yEK5+j7W767eLF30Bcpqjc
         +N/FUY8lciBD75NO9jilM8sxrURHPfJB/fj/ceGo9vKGEjIa9QlPQt900uwN90gIcA4h
         mTdislaY1zZbZdpRGJw32LXlxDbwA0xfe4ZRdZvK47iMi34vq5hqgub2D1YHLDwEG9sa
         5jUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694406213; x=1695011013;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwezSlz+P0+Z2mHsdJjGRZIZ23KKBUbArptodkuCCLA=;
        b=X+Mlx29aSyHD2054czN45w2aQTVpk3DGQCiP288/oNnVGPp0Bi4vP5b4Rl16CR3MYs
         AyJ6vKdXMiI3GO3vzxjjaK6aRY7heXMKK5eQBfmaFZKBvpRgL0iM4Wr5BoEymfj44oeZ
         G+ET5ZXceHiss3uqZ48rGlSQDvFVV5Y4paY/MTQfU+yYkbnMqIuzEgXLyKQ1a8nd+4BY
         Vy4xBSRvfyQNII/lytCWTYvwMtgCeGMs1Wlx37gsNWrP2UEi9aTGLD29TEBR4CsLH1PL
         2BZQjkbQuclfxSgWeNlmTTbwDe2HSM+UN7xXqRz5ipVarliY+3epaO0vNPKzIGeBYY++
         Jdgw==
X-Gm-Message-State: AOJu0YyYsEjSLCDw0hB50RXCHHnqF/lHdfGCz8vm4RbcbPpr8dmzuw2k
        mjdaKFa/CJMjiQBvf0K0NiQ=
X-Google-Smtp-Source: AGHT+IFPotVSX268QJNoA1xH2Nf34ADPSLxJtflUJsCH7TRnOtT7edLvJ2am/yD7hGinw2WC2yPt8A==
X-Received: by 2002:a92:c568:0:b0:34f:784f:f214 with SMTP id b8-20020a92c568000000b0034f784ff214mr2238827ilj.9.1694406213616;
        Sun, 10 Sep 2023 21:23:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r6-20020a92c506000000b0034ab4a2e0d5sm2136172ilg.70.2023.09.10.21.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 21:23:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5acb9307-2be1-dcd2-fdb7-b2842c7ff24d@roeck-us.net>
Date:   Sun, 10 Sep 2023 21:23:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To:     Saravanan Sekar <saravanan@linumiz.com>, sravanhome@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jdelvare@suse.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20230911034150.181880-1-saravanan@linumiz.com>
 <20230911034150.181880-4-saravanan@linumiz.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 3/3] hwmon: (pmbus/mpq2286) Add a support for mpq2286
 Power Management IC
In-Reply-To: <20230911034150.181880-4-saravanan@linumiz.com>
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
> The MPQ2286 is a programmable, high frequency synchronous buck regulator
> designed to power a variety of Automotive system peripherals. Single buck
> converters with hardware monitoring capability is configurable over PMBus
> interface.
> 
> Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
> ---
>   drivers/hwmon/pmbus/mpq7932.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/mpq7932.c b/drivers/hwmon/pmbus/mpq7932.c
> index af3e5e9590c8..3ffeece28e2d 100644
> --- a/drivers/hwmon/pmbus/mpq7932.c
> +++ b/drivers/hwmon/pmbus/mpq7932.c
> @@ -21,6 +21,7 @@
>   #define MPQ7932_N_VOLTAGES		256
>   #define MPQ7932_VOUT_MAX		0xFF
>   #define MPQ7932_NUM_PAGES		6
> +#define MPQ2286_NUM_PAGES		1
>   
>   #define MPQ7932_TON_DELAY		0x60
>   #define MPQ7932_VOUT_STARTUP_SLEW	0xA3
> @@ -130,12 +131,14 @@ static int mpq7932_probe(struct i2c_client *client)
>   
>   static const struct of_device_id mpq7932_of_match[] = {
>   	{ .compatible = "mps,mpq7932", .data = (void *)MPQ7932_NUM_PAGES },
> +	{ .compatible = "mps,mpq2286", .data = (void *)MPQ2286_NUM_PAGES },
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, mpq7932_of_match);
>   
>   static const struct i2c_device_id mpq7932_id[] = {
>   	{ "mpq7932", },
> +	{ "mpq2286", },

Please keep alphabetic order.

>   	{ },
>   };
>   MODULE_DEVICE_TABLE(i2c, mpq7932_id);

This is one of those super-secret automotive chips where almost no information
is available to the public. I'll need authoritative confirmation that all the
various parameters (b. m, output voltage format, minimum and maximum output
voltage, step size) match mpq7932 exactly. That is rarely the case, so consider
me skeptic.

Guenter

