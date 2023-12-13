Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4449810EF8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377843AbjLMKw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377847AbjLMKw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:52:26 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC57099
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:52:32 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c339d2b88so52971705e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702464751; x=1703069551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qxIYzcVRWND5b4+SGdqxP3/bI43pIIDmR5zOk1xwKqI=;
        b=iZf7i6i+Ku5gz5OS4BKIkSqPCQb4vRO5e+vPMbWoXvnOue5sgwxjJ2jE+uv71WNjpr
         KlRiJ2HwZN3lBARAvUw99ZMP5xqbQ4foS4lw9FfUFwSzgs/qVBKnf8ZG7soegL9keJHL
         EXtAc6NNaAi/hyCoQTlvL4nNmS1l6NbNZr4Zwso/n9wgpYMYvWwz4tSwETNJZ6YUgpEd
         zpxAXQfII37OtahJ037QPczrMpBYd8nKvXC2Z6l1teA9pHeYxRtTk/yWo9UL5lKFL4Lx
         jtIucNmU6bdZXEVTR+fvJ/FwSgchyxUPsVfeeb7dV9cgJJaVvSOh6PGJPOHQXzn+h1CC
         zN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702464751; x=1703069551;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxIYzcVRWND5b4+SGdqxP3/bI43pIIDmR5zOk1xwKqI=;
        b=iWXONWxsRI1HMZHgUPvahGyldf1Ev8PJysBHHW8OOEVBispRSxqQQnhMsOO5a9Hzhf
         Js/8tYrP1oBXUtzHVHcdY+dNC5yRUevYiUUWiwHXqMIRmhez/SYLw14nj6FxSnpmpEs7
         RYw/D9UDP6GVaNNifbD5otrna8ZPxkmtM/NBi0vLY8qJB/CiWGc5azBoWcAKi0ycEIEE
         uS5Rn7wLNbEra8aX/TniV7iwZ+tYeDwQFLbOBxHi5ako7+7V+Dt+1CcGKN+7bU/AoSoN
         MVA8xIzMdLN4SOhzVAW8206jti5mS86XPCsujQYpp5neVlztFLoR6X7iuxf+YIRH+rCa
         aymg==
X-Gm-Message-State: AOJu0YyZYGtfgv0cD4lyPujwEdQKSwU3MXXUGdyEjqe/4DQo7HONQRxF
        9pf3RDS5janlgPUOwZ6bxOQmdQ==
X-Google-Smtp-Source: AGHT+IG7JfDcAFhdjtXhcIPZe9enkVB1Tw2aLM9KQNbGHj23a2G7fv6l1molZi/rwAwKLXbv+FeE7w==
X-Received: by 2002:a05:600c:8515:b0:40b:5e21:e285 with SMTP id gw21-20020a05600c851500b0040b5e21e285mr4067503wmb.114.1702464751264;
        Wed, 13 Dec 2023 02:52:31 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id f9-20020a7bcd09000000b0040c26a459b4sm652436wmj.0.2023.12.13.02.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 02:52:30 -0800 (PST)
Message-ID: <23ee1fee-dd1a-4797-8459-8c589c6dd9f6@linaro.org>
Date:   Wed, 13 Dec 2023 11:52:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: trip: Drop redundant
 __thermal_zone_get_trip() header
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
References: <2709306.mvXUDI8C0e@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2709306.mvXUDI8C0e@kreacher>
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

On 04/12/2023 20:36, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The __thermal_zone_get_trip() header in drivers/thermal/thermal_core.h
> is redundant, because there is one already in thermal.h, so drop it.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

