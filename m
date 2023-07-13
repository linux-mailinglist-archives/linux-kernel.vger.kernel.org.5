Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CEB7524E1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbjGMOQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbjGMOQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:16:06 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA35530FB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:15:46 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbdfda88f4so6788765e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689257745; x=1691849745;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sUgqDpBZ74sWqmYg8Ri9u/mrFE+UfDnQjDBviVPA/GM=;
        b=M72dTklmTZEaD8bUxRCy1+B5MZeS6wQPD06zuBz5+qPSMiUIqWW/uq3EOXmhZ36rp9
         UDbHW4N7Bdopy+shySfoH6lHrexf24cm6QxgeqWbiCdbuGUWO3CImFRH8GhDnNBfVqk4
         ZcoQlHnFG0h839YEaNCcULGW7wUVgvI0zEB3GNafb/eHf2Lxe/g2w78FvwWd6EgPSd7w
         g9tG4TrAW+Id9qdC1aNusbMieK6C5+JVZ0gmaQBZDAbpOFL8H8bhggqZKbCb/3qvtNE8
         M2Jj9oIj/6C88Xw594nTgEqMjSEyS0CJsZiPLKYMnakDY4vB70pZ8buSRXwzudxY1tUD
         ciDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689257745; x=1691849745;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sUgqDpBZ74sWqmYg8Ri9u/mrFE+UfDnQjDBviVPA/GM=;
        b=T0Vh821jNbdvc4QiUBbuFEiCPzmNWTarP1SRkBSJ351lOWpy92jDnYkITcsZXxXhrA
         Rd7IUSw6/BZU/OHOy0lpfTDiA9yyQ1Z9wvlkSxLGT42/Y+OXE/JQZvxuHOhogsSYL2+R
         lC6XAtdN2e8ZYc2R/7as/ORSIHAUBZaRQNiwPuGq3TnbE/uFYfsOdVxIRdkIcLGkTwpG
         +PZnM0KVcCUAQos3UOfnqmIBx+3FJn3R6eQmbUHjh8ED9TbvqB1Iv5bMG+k09rFF5QTD
         Ch/dax7a7YhQArXVXfZa/9+zKoDvveuED+gZvMK0hhn8IRdiW4/+tFM5ZaME0/O5aF0q
         Nd2Q==
X-Gm-Message-State: ABy/qLZHXbfT2LI95rFIPRiQRx05VPU/i+4AJiLUysy3OALmIB+aM2O3
        RTbasDXXLlcZ1/RwNTR2Avv2uw==
X-Google-Smtp-Source: APBJJlGoSXGuvKHOIQI1GqBXjHPVj6v0YlmcmoK5atedfHpyJWSdsumLjEWgglcnangDwwjqixo45g==
X-Received: by 2002:adf:e383:0:b0:314:dea:f1f8 with SMTP id e3-20020adfe383000000b003140deaf1f8mr1733806wrm.11.1689257745109;
        Thu, 13 Jul 2023 07:15:45 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id t16-20020a5d49d0000000b003143bb5ecd5sm8104610wrs.69.2023.07.13.07.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 07:15:44 -0700 (PDT)
Message-ID: <c77fa256-7aec-cc3b-b487-ee5c5deb74f3@linaro.org>
Date:   Thu, 13 Jul 2023 16:15:44 +0200
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
 <032bda42-ba99-c207-c30d-a5f69bd10095@linaro.org>
 <CAJZ5v0hvbKhqYu6epmr+vQ9xMe0CR3KWESjBRBGzaVxzwCLG3w@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0hvbKhqYu6epmr+vQ9xMe0CR3KWESjBRBGzaVxzwCLG3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2023 15:02, Rafael J. Wysocki wrote:
> On Thu, Jul 13, 2023 at 2:24 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 13/07/2023 13:30, Rafael J. Wysocki wrote:
>>> On Thu, Jul 13, 2023 at 11:33 AM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 07/07/2023 22:37, Daniel Lezcano wrote:
>>>>> The series provides more changes to self-encapsulate the thermal zone device
>>>>> structure in order to protect wild accesses to the thermal zone device
>>>>> internals, especially the trip points and the locks.
>>>>>
>>>>> The first patch adds a macro to warn at compilation time if the
>>>>> thermal_core.h is included in a file not belonging to the thermal core
>>>>> code. One warning will happen with the nvidia drivers but this is in
>>>>> the way to be solved.
>>>>>
>>>>> The second patch reorders the headers inclusion in the core code.
>>>>>
>>>>> The next patches makes the int340x drivers to use the thermal trip
>>>>> update above and the different accessors for thermal zone structure.
>>>>>
>>>>> Daniel Lezcano (4):
>>>>>      thermal/core: Hardening the self-encapsulation
>>>>>      thermal/core: Reorder the headers inclusion
>>>>>      thermal/drivers/int3400: Use thermal zone device wrappers
>>>>>      thermal/drivers/int340x: Do not check the thermal zone state
>>>>>
>>>>>     drivers/thermal/gov_bang_bang.c               |  1 +
>>>>>     drivers/thermal/gov_fair_share.c              |  1 +
>>>>>     drivers/thermal/gov_power_allocator.c         |  7 +--
>>>>>     drivers/thermal/gov_step_wise.c               |  1 +
>>>>>     drivers/thermal/gov_user_space.c              |  1 +
>>>>>     .../intel/int340x_thermal/int3400_thermal.c   | 44 +++++++++----------
>>>>>     drivers/thermal/thermal_acpi.c                |  1 +
>>>>>     drivers/thermal/thermal_core.c                |  7 +--
>>>>>     drivers/thermal/thermal_core.h                |  4 ++
>>>>>     drivers/thermal/thermal_helpers.c             |  1 +
>>>>>     drivers/thermal/thermal_hwmon.c               |  1 +
>>>>>     drivers/thermal/thermal_netlink.c             |  1 +
>>>>>     drivers/thermal/thermal_of.c                  |  1 +
>>>>>     drivers/thermal/thermal_sysfs.c               |  1 +
>>>>>     drivers/thermal/thermal_trip.c                |  1 +
>>>>>     15 files changed, 45 insertions(+), 28 deletions(-)
>>>>
>>>> Applied
>>
>> Sorry, I did not think you may wanted pull them in.
>>
>> I can drop them from the tree if you prefer?
> 
> Let me apply them directly.

Ok

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

