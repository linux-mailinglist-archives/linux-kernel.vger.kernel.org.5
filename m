Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F637C71B3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379382AbjJLPjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347155AbjJLPjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:39:13 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0877EC9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:39:11 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4064867903cso13603945e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697125149; x=1697729949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Wg3EaV0LyOJdSGTmlTY0VxnIGoAeFlp+VouKoS5lNQ=;
        b=qam4t52zhOlQYvHEQkXqZfHl4olMDg4/jI68jmOciD/tv32vxvVoxCeP34yi+dGqS8
         xn4Eh8UKujgMLRqU/HM2arJnh6LvEdmxxyp4roKRHUQtzWbSQXBM4zQoIrRA6lEhDlcT
         mznqKrnQA4zsgkQ/7dqsOmDJBrDkUHc1XFDUtz8HRWl1g2A5EXhpL15igk+sYDg4lqop
         KiED5Hi820TZ9ENGH4EKKYMA7mDVkSbAVFNb0rU3Pw3c03ovbQVbpuNAbqez52P6RChf
         DBJY/2GrJvZIWP5jzehdgyhc44iuK3rXv6XK7Mg0Zw5lEia/Z8/NNWAUw1YQZSjh7R+n
         K/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697125149; x=1697729949;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Wg3EaV0LyOJdSGTmlTY0VxnIGoAeFlp+VouKoS5lNQ=;
        b=TMX/6SSGUaRgvE+wiwYJ7+kxM5YHF6u2uMuND5XAUngZ36EOSfwoQ0z+BJTJ04pmqa
         wllvsSwI9GGzezI1dIgd5GR0mUUBHrkXVsDI+izekdF0K1DOGg8J714IYp9QFhEpRVjj
         qeqaZmvCC3QHYT4WZw4yAJGmC9vUiGuseJuqCr4PvbqXLBBmzygZWbuJ/fcSlyIX/5fB
         zpz57COpBxhgTUC06WL6HTuZlmU73N+BaylM8BUrHF6bEXPdUe/Q2ZOi0aCQDFjv9OiH
         2J4Zy4ibJ0NnSwGm+uhWyGoTR66bK4pO9tPwGgaKKpP/yudsP6VFLBfr+0wL8VPRLUfm
         5kLQ==
X-Gm-Message-State: AOJu0YwFWb2tq/fxQ6jLfzofa+raPUfEX1oItaTIEg1qIK4htrXTOEAi
        9jdvl1uSK8cZj71EUQDuEGWTog==
X-Google-Smtp-Source: AGHT+IHijqQwPNdUCGMZLUhukz1Vn3a+qjqDBNhrhGPBsyvXuCmqOgvZ6RIuMv02qW+CQW/fPpew8A==
X-Received: by 2002:a5d:5f04:0:b0:32d:8872:aacb with SMTP id cl4-20020a5d5f04000000b0032d8872aacbmr4751690wrb.53.1697125149337;
        Thu, 12 Oct 2023 08:39:09 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id f8-20020adfe908000000b0032d8ce46caasm2778956wrm.93.2023.10.12.08.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 08:39:08 -0700 (PDT)
Message-ID: <a3255da4-b2af-4403-af68-3067a5fd49bf@linaro.org>
Date:   Thu, 12 Oct 2023 17:39:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Subject: thermal: Fix potential race condition in
 suspend/resume
Content-Language: en-US
To:     Bo Ye <bo.ye@mediatek.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     yugang.wang@mediatek.com, yongdong.zhang@mediatek.com,
        browse.zhang@mediatek.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230916113327.85693-1-bo.ye@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230916113327.85693-1-bo.ye@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2023 13:33, Bo Ye wrote:
> From: "yugang.wang" <yugang.wang@mediatek.com>
> 
> Body:
> This patch fixes a race condition during system resume. It occurs if
> the system is exiting a suspend state and a user is trying to
> register/unregister a thermal zone concurrently. The root cause is
> that both actions access the `thermal_tz_list`.

I'm not sure the tasks are already thawed during POST_RESTORE, so no 
user can unload a driver and then reaching the race window.

Is that an observed issue?


> In detail:
> 
> 1. At PM_POST_SUSPEND during the resume, the system reads all thermal
>     zones in `thermal_tz_list`, then resets and updates their
>     temperatures.
> 2. When registering/unregistering a thermal zone, the
>     `thermal_tz_list` gets manipulated.
> 
> These two actions might occur concurrently, causing a race condition.
> To solve this issue, we introduce a mutex lock to protect
> `thermal_tz_list` from being modified while it's being read and
> updated during the resume from suspend.
> 
> Kernel oops excerpt related to this fix:
> 
> [ 5201.869845] [T316822] pc: [0xffffffeb7d4876f0] mutex_lock+0x34/0x170
> [ 5201.869856] [T316822] lr: [0xffffffeb7ca98a84] thermal_pm_notify+0xd4/0x26c
> [... cut for brevity ...]
> [ 5201.871061] [T316822]  suspend_prepare+0x150/0x470
> [ 5201.871067] [T316822]  enter_state+0x84/0x6f4
> [ 5201.871076] [T316822]  state_store+0x15c/0x1e8
> 
> Change-Id: Ifdbdecba17093f91eab7e36ce04b46d311ca6568
> Signed-off-by: yugang.wang <yugang.wang@mediatek.com>
> Signed-off-by: Bo Ye <bo.ye@mediatek.com>
> ---
>   drivers/thermal/thermal_core.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 8717a3343512..a7a18ed57b6d 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1529,12 +1529,14 @@ static int thermal_pm_notify(struct notifier_block *nb,
>   	case PM_POST_HIBERNATION:
>   	case PM_POST_RESTORE:
>   	case PM_POST_SUSPEND:
> +		mutex_lock(&thermal_list_lock);
>   		atomic_set(&in_suspend, 0);
>   		list_for_each_entry(tz, &thermal_tz_list, node) {
>   			thermal_zone_device_init(tz);
>   			thermal_zone_device_update(tz,
>   						   THERMAL_EVENT_UNSPECIFIED);
>   		}
> +		mutex_unlock(&thermal_list_lock);
>   		break;
>   	default:
>   		break;

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

