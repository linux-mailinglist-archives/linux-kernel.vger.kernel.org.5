Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BCA813464
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbjLNPO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjLNPOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:14:42 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F0F170E;
        Thu, 14 Dec 2023 07:14:22 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6da2e360861so299520a34.1;
        Thu, 14 Dec 2023 07:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702566861; x=1703171661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7fgmF837E/uNu2Txy17or72EnElLYhEPnc49U6CGCsg=;
        b=Rc1EvnrshddnAYJJWUo0EbayWilZNx9bTyimLQatlKikEghuJYm4cxtxSxVTiIogh6
         SzpF9UA6BYXPAGmcfsiyp1VhfF5wzioQ+Yy6qMjLgwxxKt8KCFSi1sCbpnGPHGMY2sQh
         Vbv8PXMBqr84OsDlyH6QPsApGN46cF9GfmJpMjyXkOlfNp+KOS1Zia3ForAv1Pw98yxD
         wF0dIsuM+yyQ68YObDoaJdxDVfvFbq+4q2CN16CXDciIztHYuCpxmpLQIAMa0C+uMkno
         a8Be1hPHH5QrMrwzmhYURKtlAatxw0C9n7dsA8VvGIo8ssfE0Qm/2pO7O+BKiBZamj1o
         4ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702566861; x=1703171661;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fgmF837E/uNu2Txy17or72EnElLYhEPnc49U6CGCsg=;
        b=vfqKul2T6XAr+p3sVb41Dz/oDZujuTGRUOLu7/fmOwRhgmE+T5J3blCdp1rq4g2WLr
         G9RoY3BQiaIef1G5RtfNTHaJ4sSF1hMZGyq1wAZzhBVvbTN3dcva4JdyceiXMSvGKUjf
         z8kIoPWq6k8KFp6q1Ntyl1WE39L82+UPtGZezlfbUD2iJiseI7euH1zrgJo6MxS4lt8/
         d5bVzIhGcEhf68/3yz3DfK+dNgt0Elkelde3AlqwZZ4ie7+aGfb0qjGfCAmG/tlmgj5G
         jXgV8oF4YhcRqwvHWHK3UG3qTeJ9y5ZcaQ4r34mz3Sasz8iHSTr/xfOHOGE1ztwzVwhJ
         zFQw==
X-Gm-Message-State: AOJu0Yx1gymyRML/zGkwQJ9oLoDzb8WVrcHYnUH+nTum3DykH0Ojqnq2
        50cF9NwfvjSVW4Bo7iCWNcA=
X-Google-Smtp-Source: AGHT+IGe3TDHZYvEOctwHxhRFK4MSZ9ZhUn6Nz/OvVWcyvXnu2e56bvn3cPoeG/b8B0zY4ZnJr7weQ==
X-Received: by 2002:a05:6808:130c:b0:3b8:6ae0:8aef with SMTP id y12-20020a056808130c00b003b86ae08aefmr5333292oiv.9.1702566861562;
        Thu, 14 Dec 2023 07:14:21 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v21-20020a4a3155000000b0059069b4442esm3508510oog.5.2023.12.14.07.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 07:14:20 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <937db277-1d3d-459a-a597-475bdc0229fe@roeck-us.net>
Date:   Thu, 14 Dec 2023 07:14:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hwmon: max31827: Compatible for adaq4224
Content-Language: en-US
To:     Daniel Matyas <daniel.matyas@analog.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20231214143648.175336-1-daniel.matyas@analog.com>
 <20231214143648.175336-3-daniel.matyas@analog.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20231214143648.175336-3-daniel.matyas@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/23 06:36, Daniel Matyas wrote:
> Compatible string "adi,adaq4224_temp" is accepted in device tree.
> When this string is seen in the device tree, the name of the device
> changes to "adaq4224_temp" and the default configuration of max31827
> is loaded.
> 
> This modification was requested by the costumer, so that whenever one

customer

> analyzes the available devices, one can know for sure, that max31827 is
> part of the adaq4224.
> 

There is (officially) no such chip. I have no idea if this is a new chip
or something else, and I have no idea how it relates to max31827.
Either case, the "_temp" in the chip name doesn't make sense to me.

> Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
> ---
>   drivers/hwmon/max31827.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
> index db93492193bd..c3500a5b2c29 100644
> --- a/drivers/hwmon/max31827.c
> +++ b/drivers/hwmon/max31827.c
> @@ -48,7 +48,7 @@
>   #define MAX31827_M_DGR_TO_16_BIT(x)	(((x) << 4) / 1000)
>   #define MAX31827_DEVICE_ENABLE(x)	((x) ? 0xA : 0x0)
>   
> -enum chips { max31827 = 1, max31828, max31829 };
> +enum chips { max31827 = 1, max31828, max31829, adaq4224_temp };
>   
>   enum max31827_cnv {
>   	MAX31827_CNV_1_DIV_64_HZ = 1,
> @@ -592,6 +592,7 @@ static const struct i2c_device_id max31827_i2c_ids[] = {
>   	{ "max31827", max31827 },
>   	{ "max31828", max31828 },
>   	{ "max31829", max31829 },
> +	{ "adaq4224_temp", adaq4224_temp },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(i2c, max31827_i2c_ids);
> @@ -620,6 +621,9 @@ static int max31827_init_client(struct max31827_state *st)
>   	res |= FIELD_PREP(MAX31827_CONFIGURATION_TIMEOUT_MASK, !prop);
>   
>   	type = (enum chips)(uintptr_t)device_get_match_data(dev);
> +	if (type == adaq4224_temp) {
> +		dev->driver->name = "adaq4224_temp";
> +	}
>   

No, sorry, we don't make such changes. The driver has a fixed name
which is independent of the device connected to it.

Guenter

