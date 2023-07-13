Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F95A751D4B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjGMJd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbjGMJdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:33:15 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056821FD7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:33:14 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b734aea34aso6994471fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689240792; x=1691832792;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G5UzfOtLvyn4gYvPINaMV9TQwoxkWSzdLVBlS0y6+XU=;
        b=W0p9IbmegpWUv8OXtwrLdPy7ZxB/U9RYAzjCZwhEVv0Ox7K8VXyEXhYLQ7EPVYa3Zh
         K8F+meCtgcUe1l5MCKkJI7cEe02u53AlNbfTG4UwZRw9+F6QXup6RoddzR+MSP5SAopD
         mWUVNelLF5gvNViHZvw0VQwbREAzKGah2ZkCpp+YT2lmIjhmLaBSZ/OtjkUh5kpX11gP
         mWfq/jgjYU5nhKPu+p/TzTCgvg+LPWKUOd+YN5oZveaqUVDX01256fpAo1uVuRzMX7ZM
         aeENHbinZQ2+sfv9WuUGYalHdPehQBQLUlfiFooDJJdDyflf3aNf3A1Z9c+s1olJ0+RP
         3x0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689240792; x=1691832792;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G5UzfOtLvyn4gYvPINaMV9TQwoxkWSzdLVBlS0y6+XU=;
        b=B1bFEJ4V0ZZNSBnI6p9kKl+5RBM9RA6t7IJ1+8+Rabn8KVJREIMBPgn761LpOIV7F4
         ArZkpYF6sNmiRipLVNlHcEy5t66JQNQVLbbuTkz0xU3Hrpi7DVha5V8IzioCNPCG0zQB
         c2tRkFo5dZJbpy8vSTAxNPXYCDdR+TVsl+TJw6zMi+bTt+GfBm+Pf8FrvGjaYzW0mHo+
         J1Ec7AjuoEGRQvKyQ2t/s/Y3N0i1EL2eAerK4EBCpE/9TgkuWTRFZYgC00aEi2iZVuwM
         ythqPqsorkYj3Fvrdr4DYcc0+RedXa+JDfVG+1I12Wzz/n+Cd/TiHKE7gcEWlPHv3J93
         tHtQ==
X-Gm-Message-State: ABy/qLbZ1HUlzM81wxDdIJ0XwjtNC3k7crkMBccaU5uzyPDLE/8e8og1
        2/JELGs6lYIvyCJE1e5U/lbCGw==
X-Google-Smtp-Source: APBJJlG9Q9cBBQ0Rc9j3nnbOfBbeuD8MVicJK+CwkhedXGqK9odfpLCqOVAoEplsX/2ttniuYS2uUg==
X-Received: by 2002:a2e:9ac5:0:b0:2b6:de52:35a with SMTP id p5-20020a2e9ac5000000b002b6de52035amr1053896ljj.9.1689240792087;
        Thu, 13 Jul 2023 02:33:12 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id l21-20020a05600c1d1500b003f7f475c3bcsm2772346wms.1.2023.07.13.02.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 02:33:11 -0700 (PDT)
Message-ID: <82b2d4dc-4583-925a-9e3c-77ae30d0d261@linaro.org>
Date:   Thu, 13 Jul 2023 11:33:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/4] One more step to the thermal zone structure
 encapsulation
Content-Language: en-US
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, thierry.reding@gmail.com,
        linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com
References: <20230707203731.848188-1-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230707203731.848188-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2023 22:37, Daniel Lezcano wrote:
> The series provides more changes to self-encapsulate the thermal zone device
> structure in order to protect wild accesses to the thermal zone device
> internals, especially the trip points and the locks.
> 
> The first patch adds a macro to warn at compilation time if the
> thermal_core.h is included in a file not belonging to the thermal core
> code. One warning will happen with the nvidia drivers but this is in
> the way to be solved.
> 
> The second patch reorders the headers inclusion in the core code.
> 
> The next patches makes the int340x drivers to use the thermal trip
> update above and the different accessors for thermal zone structure.
> 
> Daniel Lezcano (4):
>    thermal/core: Hardening the self-encapsulation
>    thermal/core: Reorder the headers inclusion
>    thermal/drivers/int3400: Use thermal zone device wrappers
>    thermal/drivers/int340x: Do not check the thermal zone state
> 
>   drivers/thermal/gov_bang_bang.c               |  1 +
>   drivers/thermal/gov_fair_share.c              |  1 +
>   drivers/thermal/gov_power_allocator.c         |  7 +--
>   drivers/thermal/gov_step_wise.c               |  1 +
>   drivers/thermal/gov_user_space.c              |  1 +
>   .../intel/int340x_thermal/int3400_thermal.c   | 44 +++++++++----------
>   drivers/thermal/thermal_acpi.c                |  1 +
>   drivers/thermal/thermal_core.c                |  7 +--
>   drivers/thermal/thermal_core.h                |  4 ++
>   drivers/thermal/thermal_helpers.c             |  1 +
>   drivers/thermal/thermal_hwmon.c               |  1 +
>   drivers/thermal/thermal_netlink.c             |  1 +
>   drivers/thermal/thermal_of.c                  |  1 +
>   drivers/thermal/thermal_sysfs.c               |  1 +
>   drivers/thermal/thermal_trip.c                |  1 +
>   15 files changed, 45 insertions(+), 28 deletions(-)

Applied

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

