Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2119A752139
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjGMMYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbjGMMYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:24:51 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F06A19B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:24:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31441bc0092so778275f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689251088; x=1691843088;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YhIL5guWN6zrYbL2+DFxlG7/O9jYKZvZYqtrGd9BNHY=;
        b=PfkipBNr7iBAWN7Vr5tomfe5+E9TTO8mtzti8Tyil99CMspj+Q7gYJH6ydERk0tZFP
         +bdQd/g4ir4PQKktlCODX0iWPOVF0qzxtDxq8KU+HxmGZOPBVqVw3WsR8Y75oBDg63um
         Gy0E4u/JXt5z+pZr9Sfn+cYy6plx61iWSLkRMr1jsDy7Oahe9029u/s4TqLnONRQEHga
         Rdbfwh4dzU1qv3rBA5hDFZw6mewkJwVygADvQTksYAYBJafKO+hQH+UqP65IooKqwWT5
         HillHLVCzmZMFXqne9gqvBc4/sxfgRLx/rTBsYteFFP1sg8Bsi0HCdaihj4tm/MdyU1R
         074g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689251088; x=1691843088;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YhIL5guWN6zrYbL2+DFxlG7/O9jYKZvZYqtrGd9BNHY=;
        b=QJFSqqFFVX0d1MC0v/D/GChDb28ZB6Uf8vE7yWRXo5r7TM+DxuGa+53rHf8wbHpqLX
         TYdcYFeGhLn/oMYBJYHz+sJoZh8tpkkWNsn/uO1qwHL8ImJj/+v/kXq7RSjzg1azBCnb
         nldlsTj5JJoRM786g3KD0gbT9gP8rTDykN68wPQewuNwUEXtCusI/xFxOD87x2cb2J5e
         5Fd+jLmvHiFqXOFwu5zbrRgjm5kew+wfdPJsd//V6vLhrZOefD4iOMo+vGPNyWUKvQrW
         xJjLoclD6iEuTWloJOJ3OOkz4HndaEFiDNmqMCXYuZW1O3hwkJWmi/fETbuolpsmYXEr
         CCzw==
X-Gm-Message-State: ABy/qLbMnpl8B9SqBRohpyUDjMiWdpJ2XwcQ460BnSZs5Ul5HYA3hF7J
        73P4MVd2g9sI+jSHMd0fp04KFA==
X-Google-Smtp-Source: APBJJlGFOb5JDm5rhB/Cuv7x2z40VnxQBm2cKVopqR+aIDgwkbVnDOaE7q7jD8lgUVg8qLEp2D3YeQ==
X-Received: by 2002:adf:f649:0:b0:314:55cd:ec6b with SMTP id x9-20020adff649000000b0031455cdec6bmr1316860wrp.71.1689251088437;
        Thu, 13 Jul 2023 05:24:48 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id q14-20020a05600000ce00b003062b2c5255sm7855972wrx.40.2023.07.13.05.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 05:24:48 -0700 (PDT)
Message-ID: <032bda42-ba99-c207-c30d-a5f69bd10095@linaro.org>
Date:   Thu, 13 Jul 2023 14:24:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/4] One more step to the thermal zone structure
 encapsulation
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, thierry.reding@gmail.com,
        linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com
References: <20230707203731.848188-1-daniel.lezcano@linaro.org>
 <82b2d4dc-4583-925a-9e3c-77ae30d0d261@linaro.org>
 <CAJZ5v0iUyPjsyfcE6MB1gqeRvb8aM0d6TsrB1Oehw4p58SnFYQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0iUyPjsyfcE6MB1gqeRvb8aM0d6TsrB1Oehw4p58SnFYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2023 13:30, Rafael J. Wysocki wrote:
> On Thu, Jul 13, 2023 at 11:33 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 07/07/2023 22:37, Daniel Lezcano wrote:
>>> The series provides more changes to self-encapsulate the thermal zone device
>>> structure in order to protect wild accesses to the thermal zone device
>>> internals, especially the trip points and the locks.
>>>
>>> The first patch adds a macro to warn at compilation time if the
>>> thermal_core.h is included in a file not belonging to the thermal core
>>> code. One warning will happen with the nvidia drivers but this is in
>>> the way to be solved.
>>>
>>> The second patch reorders the headers inclusion in the core code.
>>>
>>> The next patches makes the int340x drivers to use the thermal trip
>>> update above and the different accessors for thermal zone structure.
>>>
>>> Daniel Lezcano (4):
>>>     thermal/core: Hardening the self-encapsulation
>>>     thermal/core: Reorder the headers inclusion
>>>     thermal/drivers/int3400: Use thermal zone device wrappers
>>>     thermal/drivers/int340x: Do not check the thermal zone state
>>>
>>>    drivers/thermal/gov_bang_bang.c               |  1 +
>>>    drivers/thermal/gov_fair_share.c              |  1 +
>>>    drivers/thermal/gov_power_allocator.c         |  7 +--
>>>    drivers/thermal/gov_step_wise.c               |  1 +
>>>    drivers/thermal/gov_user_space.c              |  1 +
>>>    .../intel/int340x_thermal/int3400_thermal.c   | 44 +++++++++----------
>>>    drivers/thermal/thermal_acpi.c                |  1 +
>>>    drivers/thermal/thermal_core.c                |  7 +--
>>>    drivers/thermal/thermal_core.h                |  4 ++
>>>    drivers/thermal/thermal_helpers.c             |  1 +
>>>    drivers/thermal/thermal_hwmon.c               |  1 +
>>>    drivers/thermal/thermal_netlink.c             |  1 +
>>>    drivers/thermal/thermal_of.c                  |  1 +
>>>    drivers/thermal/thermal_sysfs.c               |  1 +
>>>    drivers/thermal/thermal_trip.c                |  1 +
>>>    15 files changed, 45 insertions(+), 28 deletions(-)
>>
>> Applied

Sorry, I did not think you may wanted pull them in.

I can drop them from the tree if you prefer?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

