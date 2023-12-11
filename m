Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5140A80D426
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344770AbjLKRjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbjLKRjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:39:23 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E17C7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:39:29 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c3fe6c1b5so19398005e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702316368; x=1702921168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yy7vRtXjcFGxV/6rqekBGURy24lF8v5udfGSmbUqfVE=;
        b=kxUlaD6MHALeF0TXjcg/MsmXW6BqiUE3f19p/0t5ZQvt8fMTYlJrIq8F6QXyAIFg4U
         ZH3EiUSKp7ZcVaEGL/GCHInNvE8MJubUOJ9g5jmYjULWfITvgg0TDhkhctvq4zTVkpQX
         uLC4GgwWIds3s+uOKw9CLDvIM1NHeaCXlNRQ7GIwJou24Pd8JqRYxJPjt+yhTBt9kXNS
         3u93ui9giAsyuLmXTUQmzqZK9mfUPzfyd65LJSW8A0orwIsY846p/zohLYjLkrscds9H
         /Ep+IfgLoPpQYr9ZssAqSA2AmoavqVXKKajydT1yjP6jrNa9Ltw/NOVZmj5/rwnFhQ0f
         ERXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702316368; x=1702921168;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yy7vRtXjcFGxV/6rqekBGURy24lF8v5udfGSmbUqfVE=;
        b=Dw66HMsCWU/jc+a+V+sB0b+F/xzObR47jET6oM/XYyHVo5N1VgjZaUxPHRhULDct6Y
         RaxhX4j/1/Ex8rxexLcrvZOmzgBpTiELMH8FOoeNV1a3pnINbpYlvMV+dYvYoI4MiPXH
         WvHktSko7VQl1YPjJRGOs24t43Lv8M9IWgXLIvTdcUoTN7WvhNT4I5UXIqS5lLVHJHj4
         DII+XOjbX2YqWn/22kwEv7fiNbmfeDaS9DOihwaDc7COJSKF0iLZvT+fQ1At1c9SUNUb
         uklQ3X+neOEqyjMBTkWowLBWgXpIBBNn3dbYpD0rZlsa0BYUTQRo6Ph71YR44MivqaPy
         YRCg==
X-Gm-Message-State: AOJu0YxjPvMa4qCfJGIF2fjexVEGPGTNpZTWWTOZSWWiBAjvyMbdYnoq
        U4vYThjGemOq+d6CEutxZj+wBA==
X-Google-Smtp-Source: AGHT+IFKKn02YZnDQaXPtO1z5yFKVke+da9MLmnSbQKfW/EzVDLPVXpfXt9JqlrR/nH7qZ06w8nOzQ==
X-Received: by 2002:a05:600c:4f11:b0:40b:5e21:cc29 with SMTP id l17-20020a05600c4f1100b0040b5e21cc29mr2351948wmq.84.1702316367804;
        Mon, 11 Dec 2023 09:39:27 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id a19-20020a05600c349300b004064cd71aa8sm13606491wmq.34.2023.12.11.09.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 09:39:27 -0800 (PST)
Message-ID: <03944e4e-d57d-4442-b38d-e36e20cb5ae3@linaro.org>
Date:   Mon, 11 Dec 2023 18:39:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] thermal: Drop redundant and confusing
 device_is_registered() checks
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <1880915.tdWV9SEqCh@kreacher> <8315317.T7Z3S40VBb@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <8315317.T7Z3S40VBb@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2023 20:19, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Multiple places in the thermal subsystem (most importantly, sysfs
> attribute callback functions) check if the given thermal zone device is
> still registered in order to return early in case the device_del() in
> thermal_zone_device_unregister() has run already.
> 
> However, after thermal_zone_device_unregister() has been made wait for
> all of the zone-related activity to complete before returning, it is
> not necessary to do that any more, because all of the code holding a
> reference to the thermal zone device object will be waited for even if
> it does not do anything special to enforce this.
> 
> Accordingly, drop all of the device_is_registered() checks that are now
> redundant and get rid of the zone locking that is not necessary any more
> after dropping them.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

[ ... ]

> @@ -132,11 +120,6 @@ trip_point_temp_store(struct device *dev
>   
>   	mutex_lock(&tz->lock);
>   
> -	if (!device_is_registered(dev)) {
> -		ret = -ENODEV;
> -		goto unlock;
> -	}
> -
>   	trip = &tz->trips[trip_id];
>   
>   	if (temp != trip->temperature) {
> @@ -162,23 +145,12 @@ trip_point_temp_show(struct device *dev,
>   		     char *buf)
>   {
>   	struct thermal_zone_device *tz = to_thermal_zone(dev);
> -	int trip_id, temp;
> +	int trip_id;
>   
>   	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) != 1)
>   		return -EINVAL;
>   
> -	mutex_lock(&tz->lock);
> -
> -	if (!device_is_registered(dev)) {
> -		mutex_unlock(&tz->lock);
> -		return -ENODEV;
> -	}
> -
> -	temp = tz->trips[trip_id].temperature;
> -
> -	mutex_unlock(&tz->lock);
> -
> -	return sprintf(buf, "%d\n", temp);
> +	return sprintf(buf, "%d\n", tz->trips[trip_id].temperature);

Without the lock, could the trip_temp_store() make the value change 
while we read it?

[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

