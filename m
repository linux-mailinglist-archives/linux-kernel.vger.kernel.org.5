Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35E07B14C8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjI1H0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjI1H0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:26:04 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC5611F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:26:00 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32157c8e4c7so12437017f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695885959; x=1696490759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T1zwWE6Tost6V2Eimgm6IgNYAgd+hKcAiIDviQJCo6E=;
        b=hBEO0Qf35J+tTJgnRfqtX/HxPN3UIK5PP3YarmZBEUgw+X0Pg0dkhStX7gy46PkcEG
         2ic5SZok8tGlsq11+0Mq5W7GijQawVmQ2AVXq8kIkKkCDqndMOlnV2me6E4sXrFbA3BO
         WknLNgm+OghhsD5KGBuPG00uVGDpwTMPEs5GCTbXggX5goVVCK5OXHLweB9jGd9FCM9T
         kw+pHPxLYWJ0YE0iXss5y3JTapAl4EeGxS0CofFAauFSmPW9QMQ1pC0G7asL7SIuZ99h
         POzVD1czZgOJKiOcR5XbE2zTyipmweOb9xujeAvhUwh1gCLjAtf+yaws5ZjEni7Mr3Y8
         EcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695885959; x=1696490759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1zwWE6Tost6V2Eimgm6IgNYAgd+hKcAiIDviQJCo6E=;
        b=v0J8sOHZR9ek7aVyKSx18IPR+4LxzPs2+fk9aixknYuo/CUzHy3G3IZTwVntUbSIs6
         RBK0R7M8BHnpubIePRX5KwxD5a1TZyx2F4Z/uIPST1e/UV91EpXlPReMKivYn7OWHbVm
         egPvw8HTGxMtP1ruOnLwi37YKvfq6KY9y8yItV8GlgYw5CzTiTXqA77YSlYWTttDV8UP
         Wnp10x+XjetlCopEKy+71j7n2bCVmqvt2mHgeD+57PrTNyHCeB8MuZyfpnDLEdTJ0ZS+
         kDj2POTmI54JhkOwthn+ejluJefBRzZS6AAy9oV2yX9wlWAAN6rShH86GQQZA8AMeCHc
         6B8Q==
X-Gm-Message-State: AOJu0YxbdYp8UPUD/M7NLxJsriFvCw8zrguoXIzTf3/DmS0yMYgUETrH
        lkNye4GzcgfnS1IUc2plYA4HSQ==
X-Google-Smtp-Source: AGHT+IHtrtemWZL7OawPII6sSb2oZ6RkKjIwpNwqwDPXFEsITB3M9/Sz3GFCs24Sxx/kqqIzQZV2Ig==
X-Received: by 2002:adf:d0cc:0:b0:31d:da10:e471 with SMTP id z12-20020adfd0cc000000b0031dda10e471mr436228wrh.69.1695885958905;
        Thu, 28 Sep 2023 00:25:58 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id w10-20020adfd4ca000000b0031762e89f94sm18629720wrk.117.2023.09.28.00.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 00:25:58 -0700 (PDT)
Message-ID: <ca521ece-41b6-294a-81bd-eaf54a901335@linaro.org>
Date:   Thu, 28 Sep 2023 09:25:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 12/13] ACPI: thermal: Drop critical_valid and hot_valid
 trip flags
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <1957441.PYKUYFuaPT@kreacher> <2375603.NG923GbCHz@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2375603.NG923GbCHz@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2023 20:04, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The critical_valid and hot_valid flags in struct acpi_thermal_trips are
> only used during initialization and they are only false if the
> corresponding trip temperatures are equal to THERMAL_TEMP_INVALID, so
> drop them and use THERMAL_TEMP_INVALID checks instead of them where
> applicable.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

