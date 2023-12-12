Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC5580F8D4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377462AbjLLVCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377304AbjLLVCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:02:31 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20539B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:02:36 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3363880e9f3so48545f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702414955; x=1703019755; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fP3PBbkg+dGDRbq07rpkl3oLoeUyahhiYf75aZTkbF0=;
        b=J0zWqfWHzdG+QeTl4U+QZKt5y8Efwcr4V31Lrl3e2GJf9dHb9GaTPdMyz9JWAq6VFf
         qwjugv9cp6cXnOKMsJX4dkdYNwVtyK3ihlzxWykY+6lv6lX0XKlUcaoc4LQhxOk03BSE
         Z2lq3HU73JzInRDo6yWRUEOzljFsx8PuopvbtC5DJL9L/BZNYSCx9zeMcOeWeHcIyCIJ
         RUHOSlo9YUfIiee931XMpbikEp5vt0vESB+XgtxVNRJDmWW4G5rrBkErAcjZO2btQqE0
         tm2DiZrPWCTb17j9l1YEpMknlNafOFe5rbY3r5fpnwEfqpC2oXfgwlyOUHI5NnQcZHSM
         CliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414955; x=1703019755;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fP3PBbkg+dGDRbq07rpkl3oLoeUyahhiYf75aZTkbF0=;
        b=qhFowRlE7ojdmY6ey5ejTG3KZQPwPV7wrRTMhtpzuzOk8AA31vDjmnwindc0MAf4Hx
         Es3K1D8RkwnseIr6H+f2rKljmAOMNL0UAPXbPW0KywfyOYrPuk48wLQCWeOvE8r+Zn+q
         Jgi8JvWuF8woFO3MDEJGkVQhUKZ6jTlPbm44Oy1B8clJoJmNpXjvjIMJ5dHy6U0cgjCZ
         UR2HRre22VnnVVEqY02TqpTDvwGNr57+i1KojKIYqu02ilGWdDb/Gs1/4K+plp2gZBb4
         Ri77Q7uNfebSWr8zvziP7YvMA/gxIKx/F3omFqnS4jxCx61L5ngFVkWsUDJfSngBgiLq
         nbGA==
X-Gm-Message-State: AOJu0YzPuepaFYp2dhjL+i/D8TN2yGx4MQxGBJduWnBaJdRLE2VAYD2D
        YJVcqZwyYQzNBysEeBNgM50lCg==
X-Google-Smtp-Source: AGHT+IGzx824ZUtMwg2ZMXI/wufgirctkBfjm6aqgGXizgPzjydfwsIPAaND7CNMU2RbzjzhH/Jlzw==
X-Received: by 2002:adf:e34a:0:b0:332:de0f:d7be with SMTP id n10-20020adfe34a000000b00332de0fd7bemr3284238wrj.18.1702414955022;
        Tue, 12 Dec 2023 13:02:35 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id n4-20020a5d6b84000000b0033634aef014sm1746153wrx.104.2023.12.12.13.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 13:02:34 -0800 (PST)
Message-ID: <1e2b5100-f40d-47f2-880b-121704c0c8e2@linaro.org>
Date:   Tue, 12 Dec 2023 22:02:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: trip: Send trip change notifications on all
 trip updates
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <5737811.DvuYhMxLoT@kreacher>
 <cf055d45-8970-4657-ab86-d28636645c81@linaro.org>
 <CAJZ5v0ic_=2wvge1T7YmGe5icR5dPxrvKy2N4gXP+KMievobmA@mail.gmail.com>
 <CAJZ5v0gkBZh42obB-g95T2DBFntYrnidjAeUoFN+e-CqGrSQCw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gkBZh42obB-g95T2DBFntYrnidjAeUoFN+e-CqGrSQCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2023 20:04, Rafael J. Wysocki wrote:
> On Wed, Dec 6, 2023 at 5:01 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> Hi Daniel,
>>
>> On Wed, Dec 6, 2023 at 3:38 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>
>>>
>>> Hi Rafael,
>>>
>>> On 05/12/2023 20:18, Rafael J. Wysocki wrote:
>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>
>>>> The _store callbacks of the trip point temperature and hysteresis sysfs
>>>> attributes invoke thermal_notify_tz_trip_change() to send a notification
>>>> regarding the trip point change, but when trip points are updated by the
>>>> platform firmware, trip point change notifications are not sent.
>>>>
>>>> To make the behavior after a trip point change more consistent,
>>>> modify all of the 3 places where trip point temperature is updated
>>>> to use a new function called thermal_zone_set_trip_temp() for this
>>>> purpose and make that function call thermal_notify_tz_trip_change().
>>>>
>>>> Note that trip point hysteresis can only be updated via sysfs and
>>>> trip_point_hyst_store() calls thermal_notify_tz_trip_change() already,
>>>> so this code path need not be changed.
>>>
>>> Why the ACPI driver is not calling thermal_zone_device_update() after
>>> changing the trip point like the other drivers?
>>
>> It calls that function, but because it may update multiple trips in
>> one go, it does that after all of the updates are done, via
>> acpi_thermal_check_fn().
>>
>>> It would make sense to have the thermal framework to be notified about
>>> this change and check if there is a trip violation, no ?
>>
>> It is notified as noted above, but not synchronously.
> 
> I believe that the question above has been answered, so are there any
> other comments or concerns regarding this patch?

No, it is fine. Thanks for the clarification

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

