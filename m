Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDFD76BC87
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjHASaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjHASao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:30:44 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF421BC3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 11:30:42 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe3678010eso4026208e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 11:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690914640; x=1691519440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qtcJ9ghphdBZwkfQ1OoT+M+9vhYvFrLEL4xzG7btVFo=;
        b=sP/ptIqwzq320rciKX8vLog6wBk7RDLYTE+D2RCyPHxqlK+WP+Zr0gtrPLUsOPp/En
         GAU2ZTWtxKHHeCaeAS5RBPwslOHggZ7261InGNiNAQwC3tyCM4OpIKYcK0IDCY3AW4e1
         5c1+a5OnTt7s2N7Vx3CldBTDMJkLQ8eLJs67u6BImvvOPdLqEhJtDzZiRU3ASaLIPKFA
         0TXRsFif89XW7wkt9qq+NG1mQwU1D7bPstys7ftjTaDBpKtLdlQOTUnDZw3r5J7ow6d0
         NcHTrBkqDJ7gtlwxSkqf1Er+bURNcrmFg+uOso1zrQF4hDzcNQuR5WRv4c7+JrK3i53R
         Bm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690914640; x=1691519440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qtcJ9ghphdBZwkfQ1OoT+M+9vhYvFrLEL4xzG7btVFo=;
        b=J5y0cQsRtlxj8mSdSdSN1L3POCp7RfdNWlFlGI4dLL1vnoH3KalhmCpsKwwvx+NGGp
         kc9+iO1zapP4fPpV7HlC9HcldBlyKXs3sa2OcxQqz3WP9H5UgcfR+JB8fq+mYrS4fiEH
         ND0elZij+oVAMltpfYWvUJTLTvlNAqbMvW3HWU7JfzbKDZlj9tA4hLHDauiqdHbJL8Vd
         nrExqO0RStjq6r5dksHcauysfwr8j2p21wiDitpFRrShMGjv8jsZIzGfuZKf/InBgawD
         7cTwHIaFynqJidgKw7U+Op+BCB8ueEnr3viE8C4etVN8FNoQ4gOe1twosefrr3Plbh4N
         5m/w==
X-Gm-Message-State: ABy/qLYfFklxZ1t9jd+se8F3ZA2vAakQfEQDqRaDvU1aejCOV9HINLJ1
        0yIq6fohF4/XG9R6kX0eqUUqaw==
X-Google-Smtp-Source: APBJJlE2365H9e6lqf+5QGIJDxUQh6Xp3nD1293dtzbYsxhmqK3rrV1Plt88EzoY6SllBKcNm8NIsg==
X-Received: by 2002:a19:644c:0:b0:4fc:3756:754e with SMTP id b12-20020a19644c000000b004fc3756754emr2513770lfj.56.1690914640049;
        Tue, 01 Aug 2023 11:30:40 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id m7-20020a05600c280700b003fe1afb99a9sm8646959wmb.11.2023.08.01.11.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 11:30:39 -0700 (PDT)
Message-ID: <fee918ad-792c-f4e7-935d-1af9540b7274@linaro.org>
Date:   Tue, 1 Aug 2023 20:30:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/8] thermal: core: Add routines for locking and
 unlocking thermal zones
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13318886.uLZWGnKmhe@kreacher> <12254967.O9o76ZdvQC@kreacher>
 <2154273.irdbgypaU6@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2154273.irdbgypaU6@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,


On 25/07/2023 14:08, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add thermal_zone_device_lock() and thermal_zone_device_unlock() for
> acquiring and releasing the thermal zone lock, respectively.
> 
> They will be used by the ACPI thermal driver to protect trip point
> temperature updates against races with accesses from elsewhere.

This change goes to the opposite direction of the previous thermal zone 
cleanup and encapsulation we have done recently.

Here we give the possibility to a driver to act on the thermal core 
internals.

Ideally, we should see tz->lock only in thermal_core.c


> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v2 -> v3: No changes.
> 
> v1 -> v2: New patch.
> 
> ---
>   drivers/thermal/thermal_core.c |   13 +++++++++++++
>   include/linux/thermal.h        |    2 ++
>   2 files changed, 15 insertions(+)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -497,6 +498,18 @@ void thermal_zone_device_update(struct t
>   }
>   EXPORT_SYMBOL_GPL(thermal_zone_device_update);
>   
> +void thermal_zone_device_lock(struct thermal_zone_device *tz)
> +{
> +	mutex_lock(&tz->lock);
> +}
> +EXPORT_SYMBOL_GPL(thermal_zone_device_lock);
> +
> +void thermal_zone_device_unlock(struct thermal_zone_device *tz)
> +{
> +	mutex_unlock(&tz->lock);
> +}
> +EXPORT_SYMBOL_GPL(thermal_zone_device_unlock);
> +
>   static void thermal_zone_device_check(struct work_struct *work)
>   {
>   	struct thermal_zone_device *tz = container_of(work, struct
> Index: linux-pm/include/linux/thermal.h
> ===================================================================
> --- linux-pm.orig/include/linux/thermal.h
> +++ linux-pm/include/linux/thermal.h
> @@ -336,6 +336,8 @@ int thermal_zone_unbind_cooling_device(s
>   				       struct thermal_cooling_device *);
>   void thermal_zone_device_update(struct thermal_zone_device *,
>   				enum thermal_notify_event);
> +void thermal_zone_device_lock(struct thermal_zone_device *tz);
> +void thermal_zone_device_unlock(struct thermal_zone_device *tz);
>   
>   struct thermal_cooling_device *thermal_cooling_device_register(const char *,
>   		void *, const struct thermal_cooling_device_ops *);
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

