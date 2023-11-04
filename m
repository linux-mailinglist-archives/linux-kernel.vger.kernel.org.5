Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B747E1068
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 18:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjKDQ3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 12:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKDQ3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 12:29:49 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6B9BD;
        Sat,  4 Nov 2023 09:29:45 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6c311ca94b4so2843805b3a.3;
        Sat, 04 Nov 2023 09:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699115385; x=1699720185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Xu+r35Am8kmZHwARoSIE5/xRcgENiFx5ysdiy/8GfOE=;
        b=KPWpjZlYWrkNneEiMQBbtRdOC37plTOaxeD6AQ0z+SSiaPJ6akKSUBtGnc33K7gDp+
         k6FmHQ7WDJb1Cp9d6/FbGYP8+RKts4yZkqb0Q3qN86OZXOCa8mO3ocF4pGjn7PxE0rW6
         VYEvD346Vtlt4SflHYdU4mdaSwvpRfMCSLIiQuZHcVjAwItg/tljpgBzZERBCGmQOV17
         KqWGvsc1mWRVdMnryJumtzcHAvZXrHdu8wfCixB/9QvK1e4LAytae4SDK7JtPtHbp4Ey
         q9Mk1MjAT+UQEN8kj44S2Rm3PFOMYKCvygxp7AucHO03imUtiRXZH7fY7fKygT/r7ywt
         Rzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699115385; x=1699720185;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xu+r35Am8kmZHwARoSIE5/xRcgENiFx5ysdiy/8GfOE=;
        b=DV0GQg1or0DkW6CGhbUE2H9Or8rqD/aHIytkEEk+S5TF6zIM5dlQkPwrf4UCctBl8J
         bQJgtyFXJ4zdsCWaK88CbxulTiYDIsIaBVyqR89CasQX656rSqp6WD9bVQkfBIr7nzoj
         jTW3XK1hba3Ik6RMdxef3/1ApiLqKj3vWwXPzmt8w3/HDMs5S+l3dgDexVfx/YLcn2Vf
         jNUxnMktoQyR5z6w1mt+RORr1wv+YrnpcBGYUWrf1/IwWi4QPe2+fuYd8ygUjmAeEa5h
         ApVInZuElJNCm7r/8U6TBe93MaOY5LXJKFncJmul31Ui6YMv/tmRei6aIEsZB8vGQfvV
         Ov0A==
X-Gm-Message-State: AOJu0YzCEx3pdHkIj7FN+LJA45//4B2IJIXsGUHq0Z8dpnZ1+jHpD/rF
        ZIartQbTPI4MonbLmyTRDbvPfs8Awug=
X-Google-Smtp-Source: AGHT+IEah8jXH94mQ/WJPV/M5ZCL1+VGfS5occoX8kW38UZpnI+2Y8tYDwwxmAn+25AmcK0L2cZ/xg==
X-Received: by 2002:a05:6a00:2356:b0:6bd:ca1d:c51e with SMTP id j22-20020a056a00235600b006bdca1dc51emr26443804pfj.16.1699115385136;
        Sat, 04 Nov 2023 09:29:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h15-20020a056a00218f00b00690ca4356f1sm3090495pfi.198.2023.11.04.09.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Nov 2023 09:29:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2b48b41d-7d82-470a-a40e-c8f3c9de94dd@roeck-us.net>
Date:   Sat, 4 Nov 2023 09:29:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] hwmon: (hp-wmi-sensors) Fix failure to load on EliteDesk
 800 G6
Content-Language: en-US
To:     James Seo <james@equiv.tech>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Lukasz Stelmach <l.stelmach@samsung.com>,
        Armin Wolf <W_Armin@gmx.de>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231103181931.677796-1-james@equiv.tech>
 <dec086cc-7403-4a06-b860-aae6daf8f0e7@roeck-us.net>
 <ZUZsPO9aN+E3qAng@equiv.tech>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZUZsPO9aN+E3qAng@equiv.tech>
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

On 11/4/23 09:07, James Seo wrote:
> On Fri, Nov 03, 2023 at 12:36:49PM -0700, Guenter Roeck wrote:
>> On 11/3/23 11:19, James Seo wrote:
>>> +static bool is_raw_wmi_string(const acpi_object_type property_map[], int prop)
>>> +{
>>> +	const char *board_name;
>>> +
>>> +	if (property_map != hp_wmi_platform_events_property_map ||
>>> +	    prop != HP_WMI_PLATFORM_EVENTS_PROPERTY_NAME)
>>> +		return false;
>>> +
>>> +	board_name = dmi_get_system_info(DMI_BOARD_NAME);
>>> +	if (!board_name)
>>> +		return false;
>>> +
>>> +	return !strcmp(board_name, HP_WMI_BOARD_NAME_ELITEDESK_800_G6);
>>
>> Would it be possible to use a dmi table and dmi_check_system() ?
>> That would make it easier to add more platforms later on if needed.
>>
>> Thanks,
>> Guenter
>>
> 
> Hi Guenter,
> 
> Sure, I can do something like this:
> 
> 
> #define HP_WMI_WSTR_INFO(name, wids) {					\
> 	.matches = {							\
> 		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),	\
> 		DMI_EXACT_MATCH(DMI_BOARD_NAME, (name)),		\
> 	},								\
> 	.driver_data = (void *)(wids),					\
> }
> 

Quite frankly, I dislike multi-line macros because they make it (more)
difficult to understand the code. If that is where you want to go,
I'd rather keep the current code (or wait until someone else maintains
the hwmon subsystem).

> struct hp_wmi_wstr_id {
> 	const acpi_object_type *property_map;
> 	int prop;
> };
> 
> static const struct hp_wmi_wstr_id elitedesk_800_g6_wstr_ids[] = {
> 	{
> 		.property_map = hp_wmi_platform_events_property_map,
> 		.prop = HP_WMI_PLATFORM_EVENTS_PROPERTY_NAME,
> 	},
> 	{ },
> };
> 
> static const struct dmi_system_id hp_wmi_dmi_wstr_table[] = {
> 	HP_WMI_WSTR_INFO("870C", elitedesk_800_g6_wstr_ids),
> 	{ },
> };
> 
> static bool is_raw_wmi_string(const acpi_object_type property_map[], int prop)
> {
> 	const struct hp_wmi_wstr_id *wstr_id;
> 	const struct dmi_system_id *id;
> 
> 	id = dmi_first_match(hp_wmi_dmi_wstr_table);
> 	if (!id)
> 		return false;
> 
> 	wstr_id = id->driver_data;
> 	for (; wstr_id->property_map; wstr_id++)
> 		if (property_map == wstr_id->property_map &&
> 		    prop == wstr_id->prop)
> 			return true;
> 
> 	return false;
> }
> 
> 
> Out of curiosity, how would you feel about just adding full raw WMI string
> support now? It wouldn't take much more work and for various small reasons
> it's starting to look like a better idea to me.
> 

I don't know; I would have to see the code.

Guenter

