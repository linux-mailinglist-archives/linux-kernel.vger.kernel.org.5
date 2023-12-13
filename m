Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D97810E55
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbjLMKYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbjLMKYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:24:17 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BEAD0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:24:23 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c3984f0cdso52689395e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702463061; x=1703067861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sdrs03dZMZiQjD0oDQJ6lCq5E+UmKxE9fUWhvfdFRB0=;
        b=Voitf75rAfwH4wQjCm+dU8nY0YYtgZAAqqPR6+RkOCfXRI5/QPzwPkeOYQFD1nIz66
         wjfEiTmXd2ZtiHPqYLl/XlFPDP4jYublBjmEDMf7stg/wXSwgvOeIwqipl1H9ELBO5Qv
         sKx7M6rY9hxKct1i0GHGFYz4yGLHvHuJF0ANAiN19KpgsDw88oFHbr8Bd+FPNlNYvE34
         vJ8dU+l9t4q5F8zsignRSOPQIJS8CyStrNOszV3AQGDYC6GgzgUOmF73O8d1Vzi0bsd/
         cIFepa1jghrKKYffbAjBWzQUth1Ft6+Gp3Vq1q5kWpN9GW1vrZE1q32JJfztGcPu1uvc
         DFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702463061; x=1703067861;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sdrs03dZMZiQjD0oDQJ6lCq5E+UmKxE9fUWhvfdFRB0=;
        b=hkMJEIaCvpSAkgsFZBQXRFgomfIQBJeF7aOp0MftRtdLIrCiiIna/wqiPe9w2hwhQT
         FXwaJ6XWZd8abqn0ytwuYUJJQrTfksnXTje+4Zzv0ZY5Ok4nDoQGBfsYEyRhaFhCjiCg
         899kzztlAKW6L7Rwkc24x5TKsv2MdtCU7Yi9vk6szydCpEbCpr/OnYXJPz2Bx10eWryS
         SgkWHkVFos4PHw6PwguE70XZNpb/8MLZkhHimqmzq1jG6kaBPq8gt9zGwnoFOCfH7uF0
         bqlT4gtR/e47SALDPGJUy5ciexanog6EWX3zx38D8rZPnumVM1BESZb4UzCR8s/QBztr
         JL7Q==
X-Gm-Message-State: AOJu0YzRFVvo1OGh0nITh/VxEOUYtz6H9RBTtw4uGQfEXbHy8eSlCsMc
        YaFCJT1EbDwDhzK+TsExBNTbvA==
X-Google-Smtp-Source: AGHT+IFX4fs4ufacmpEdPsPXZ/eEfffGxElU825KC7qFU3UvOmmnsGFuPVBISkJvfQdybiOSxXEV6Q==
X-Received: by 2002:a05:600c:4711:b0:40b:5e21:dd36 with SMTP id v17-20020a05600c471100b0040b5e21dd36mr3800419wmo.100.1702463061580;
        Wed, 13 Dec 2023 02:24:21 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id w7-20020a05600c474700b0040c41846919sm13705500wmo.41.2023.12.13.02.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 02:24:21 -0800 (PST)
Message-ID: <5b76f719-2e19-4e73-8635-081974bf0c01@linaro.org>
Date:   Wed, 13 Dec 2023 11:24:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] thermal: helpers: Use for_each_trip() in
 __thermal_zone_get_temp()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
References: <5733564.DvuYhMxLoT@kreacher> <1871840.tdWV9SEqCh@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1871840.tdWV9SEqCh@kreacher>
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

On 04/12/2023 20:46, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make __thermal_zone_get_temp() use for_each_trip() instead of an open-
> coded loop over trip indices.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

