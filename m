Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C09D7F15F6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjKTOp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjKTOpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:45:55 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C23110;
        Mon, 20 Nov 2023 06:45:51 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5c9cdc78c37so10731737b3.3;
        Mon, 20 Nov 2023 06:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700491550; x=1701096350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hUfxoxNPRZuOPOH01mDDtEy1MldhPQH0SK1HxKKSFbs=;
        b=DPZvKcawN3c4G9tw/LpqgfR0kSHzne9JTk/o4hFhObbXFyMtKmZ+tx11sRUPisoYT8
         uj6GbKuQpQWiBu5Mjy/KLpQEfccgqkMUL6M/Dqpu+A1DVF25ksoqv888C50MHO40Ne+L
         41Gk0KXRxMnxUQY2F5prYo2nlrFxch6woTPxk8PCzlJMaSZq1wve4TYLY2cR01ri04n2
         izdlZXDr5Am+gvuWuvY+ErkN/0b+dMO86e+zwjlkwwEkLKppra9dsoZsLzX4coOunCpc
         PbrvEn052ZM+MxdAAjPyl5ah3UMvGi+Yzkw5EDB38q8vGGYg9w/E4DIDM+p9SuTdv+Mq
         ppbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700491550; x=1701096350;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hUfxoxNPRZuOPOH01mDDtEy1MldhPQH0SK1HxKKSFbs=;
        b=dogG3guhoG/j5xfXdQc9y6Dv3G42CpNfZgCxM/CyguqOkCGbGCYAX5ZDpN1smk8FZ8
         r7TJlWc3pB3Fx7PDCTidm69+kSHXwgOCTpY+jrggJ49gYZLK1+0v1zlly172oYHmtmt5
         tX+9Y5ppophYusFOjeL+Ir+QTooyEw/pNmoTgL8cUgwKF2qlJZqiEI/RvbDkwL4Yt/VS
         qXr679JETnbYWBQWxn5ENwqkV7JSuZhLpunJQ2jkfDWkr7nirPRjRWc5zYmNkWzgT8CJ
         ie+GCn+P5a760SBGICK1ocobLHDXz+n3vihYNFmWDMYOSccKyWxcXHD6YzdkKnxu2uWg
         jDVA==
X-Gm-Message-State: AOJu0YxFbVRkX3eC+LXKJ+L0A5ErQkk1nmsPVfNf4uLs+pfbf5FI7eJG
        Yd2KuNtnAsU+KzsqZCpuASo=
X-Google-Smtp-Source: AGHT+IFxTZgmllIGTA/XNK+yOk50HuCc66UBLD9OdHr/NJ1P1gF/wXigob7JnpU/O2WpmHaOfHDttg==
X-Received: by 2002:a81:af55:0:b0:5cb:4841:dc40 with SMTP id x21-20020a81af55000000b005cb4841dc40mr284470ywj.13.1700491550467;
        Mon, 20 Nov 2023 06:45:50 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v13-20020a81480d000000b005af81610bdbsm2391078ywa.122.2023.11.20.06.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 06:45:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5edd658e-afcc-4a7b-b730-374f7d9c3be3@roeck-us.net>
Date:   Mon, 20 Nov 2023 06:45:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hwmon: (nct6775) Fix incomplete register array
Content-Language: en-US
To:     Xing Tong Wu <xingtong_wu@163.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     xingtong.wu@siemens.com, tobias.schaffner@siemens.com,
        gerd.haeussler.ext@siemens.com
References: <20231120081542.3174-1-xingtong_wu@163.com>
 <20231120081542.3174-2-xingtong_wu@163.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20231120081542.3174-2-xingtong_wu@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/20/23 00:15, Xing Tong Wu wrote:
> From: Xing Tong Wu <xingtong.wu@siemens.com>
> 
> The nct6116 specification actually includes 5 PWMs, but only 3
> PWMs are present in the array. To address this, the missing 2
> PWMs have been added to the array.
> 
> Signed-off-by: Xing Tong Wu <xingtong.wu@siemens.com>
> ---
>   drivers/hwmon/nct6775-core.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
> index d928eb8ae5a3..c24b2c312911 100644
> --- a/drivers/hwmon/nct6775-core.c
> +++ b/drivers/hwmon/nct6775-core.c
> @@ -844,6 +844,9 @@ static const u16 NCT6116_REG_FAN_PULSES[] = { 0xf6, 0xf6, 0xf6, 0xf6, 0xf5 };
>   static const u16 NCT6116_FAN_PULSE_SHIFT[] = { 0, 2, 4, 6, 6 };
>   
>   static const u16 NCT6116_REG_PWM[] = { 0x119, 0x129, 0x139, 0x199, 0x1a9 };
> +static const u8 NCT6116_REG_PWM_MODE[] = { 0xf3, 0xf3, 0xf3, 0xf3, 0xf3 };
> +static const u8 NCT6116_PWM_MODE_MASK[] = { 0x01, 0x02, 0x04, 0x04, 0x04 };

No, this isn't correct. Chapter 8.4.4 in the datasheet says that auxfanout1 and
auxfanout2 are always in pwm mode, so those register addresses and bit positions
need to be 0 in the array. Also, please just extend the NCT6106 arrays.

> +static const u16 NCT6116_REG_PWM_READ[] = { 0x4a, 0x4b, 0x4c, 0xd8, 0xd9 };

Please just extend the nct6106 array.

Thanks,
Guenter

