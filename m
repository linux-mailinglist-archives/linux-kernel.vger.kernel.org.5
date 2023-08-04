Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FFA77043B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjHDPTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjHDPTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:19:43 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E2D49C1;
        Fri,  4 Aug 2023 08:19:42 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-686f1240a22so2033505b3a.0;
        Fri, 04 Aug 2023 08:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691162382; x=1691767182;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BaqCsI7AY0zmNrHetOQcMygPdo4X9HEaAfXsdJ+uoQ4=;
        b=g2UqdsXofSv7CLwaGbiAeEpWIzmZb8C7iYiD9ZNUqrRzxRgZ/cbORe7W/CEACigDAK
         D1MMvrueo++w+wK7+mUCo/hLnuI3ZNzmXdPfIroNWB976sHm2b1k0lQzDzythM2rtSFr
         +zQJsCxu7jBbSHiIVIWhG8kAsrwZY1uP4fW5fQEPEUoQYbJegKtJdvAN6LvZ/6ywkhKL
         iSde0BQGVglQP66Bq+ywngm+IrkpYo4fpErC+oXoYpelUoAE8NRMSk4vuFRtibFljSpF
         t3XqvryfzXBMb7BLqECsf+Qq1IeCdBO7u6hv+GtyHoZQPxpo1DrV+iktFflfABvARn0Q
         HYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691162382; x=1691767182;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BaqCsI7AY0zmNrHetOQcMygPdo4X9HEaAfXsdJ+uoQ4=;
        b=Z/vqtWu0apeRfR9XidyEycKg22AYx0ECAo8z4HGJZOK91h3A8qYnOThw4JxLilJ7Ni
         7Tt3R1XHYNFJkkfQPrmAhxH7V4YAdMIAV1X7eAnctCWhhZLFWaHQIAq8wQjZP1RbwxqC
         hy0SWn6INm/amQWhisnC9LKtTG6VuRZW2aE9d//hUulTOyDpPrllhcuSFOiq/8Bne6ci
         Lyz73kkWL8+6ZHgqNqTRKka/Aw7N1hg/mKEuFfvt4uz7s71DVQkeGHtpqgPR7EF9JgQt
         ggNPR0l/XKNl0Ig5VuP/8CtT/fyj9TwTWYWZvt37kS3sGTR6QGqk6oMgXj/TuOVKE24C
         5Wbw==
X-Gm-Message-State: AOJu0YxyYg7fC5ecXp0Y7y8JNLoWQfQn9qI1P4OhYSlnkWbHO3ssc6ic
        r1apzOz9jkx1116bKcqeJ5Q=
X-Google-Smtp-Source: AGHT+IE7mpdbv0N3KOlhp2Mm9yQ1avyvSBGUZXWJYtk2nsvViDBfs/p+Wsg/LQ7nnrJqrjxOFANIYw==
X-Received: by 2002:a05:6a00:2288:b0:687:82f9:3d89 with SMTP id f8-20020a056a00228800b0068782f93d89mr2751811pfe.24.1691162381972;
        Fri, 04 Aug 2023 08:19:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g12-20020a62e30c000000b006870814361bsm1724812pfh.114.2023.08.04.08.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 08:19:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <eaff724f-fceb-c50e-3ff5-58f61b396d02@roeck-us.net>
Date:   Fri, 4 Aug 2023 08:19:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     rentao.bupt@gmail.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        taoren@meta.com
References: <20230803235536.798166-1-rentao.bupt@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hwmon: (pmbus/bel-pfe) Enable PMBUS_SKIP_STATUS_CHECK for
 pfe1100
In-Reply-To: <20230803235536.798166-1-rentao.bupt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/23 16:55, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> Enable PMBUS_SKIP_STATUS_CHECK flag for both pfe1100 and pfe3000 because
> the similar communication error is observed on pfe1100 devices.
> 
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> ---
>   drivers/hwmon/pmbus/bel-pfe.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/bel-pfe.c b/drivers/hwmon/pmbus/bel-pfe.c
> index fa5070ae26bc..8280d274da3f 100644
> --- a/drivers/hwmon/pmbus/bel-pfe.c
> +++ b/drivers/hwmon/pmbus/bel-pfe.c
> @@ -17,12 +17,12 @@
>   enum chips {pfe1100, pfe3000};
>   
>   /*
> - * Disable status check for pfe3000 devices, because some devices report
> + * Disable status check for pfexxxx devices, because some devices report
>    * communication error (invalid command) for VOUT_MODE command (0x20)
>    * although correct VOUT_MODE (0x16) is returned: it leads to incorrect
>    * exponent in linear mode.
>    */

Rephrase to something like

  Disable status check because some devices ... linear mode.
  This affects both pfe3000 and pfe1100.

We don't know if other pfe devices will be supported by the driver in the
future, and we don't know if those will be affected, so we should not make
any claims about such devices.

> -static struct pmbus_platform_data pfe3000_plat_data = {
> +static struct pmbus_platform_data pfe_plat_data = {
>   	.flags = PMBUS_SKIP_STATUS_CHECK,
>   };
>   
> @@ -94,6 +94,7 @@ static int pfe_pmbus_probe(struct i2c_client *client)
>   	int model;
>   
>   	model = (int)i2c_match_id(pfe_device_id, client)->driver_data;
> +	client->dev.platform_data = &pfe_plat_data;
>   
>   	/*
>   	 * PFE3000-12-069RA devices may not stay in page 0 during device
> @@ -101,7 +102,6 @@ static int pfe_pmbus_probe(struct i2c_client *client)
>   	 * So let's set the device to page 0 at the beginning.
>   	 */
>   	if (model == pfe3000) {
> -		client->dev.platform_data = &pfe3000_plat_data;
>   		i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);
>   	}
>   

{ } is no longer needed.

Thanks,
Guenter

