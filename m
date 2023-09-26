Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB8F7AEE34
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 15:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbjIZNrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 09:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjIZNrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 09:47:37 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4303FC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 06:47:29 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31f71b25a99so8715584f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 06:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695736048; x=1696340848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tUZoMLnKwsOq3aRDz3SQyOis9iaqsJSI3quNHiMxzyw=;
        b=zzVesboSwQ66H+eSPvGYQlKK+AxGLJu7YJm6g5ArfznDMTAU+lJ8YGkjX90cdKkW2M
         w6U9amZ+aGUJGAGvxsJZdvpTgLqKVg0N9hi1ynhEQPs8ibOsb8Pu1Ds5DhLeXjoAh6Uz
         7EgO+k9OxuqjmQ/91Lwd8pg1q8Z8SIeipsqyJCeSHzLv75XsrIOE9NRnThR20gLlwfBp
         Hcyx2Aa1fOLgEf6jAcCgd6i7BVvCCUXAAM15+5q9pNhX9eXrNZaEBM84AET27+7eKcZL
         daQ26suBm9JAkM39Un578FepC1Qe0jXIuN+MP3JO2z1gDRGAqkfk4Un0vaSHX/v/yzVW
         aa9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695736048; x=1696340848;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUZoMLnKwsOq3aRDz3SQyOis9iaqsJSI3quNHiMxzyw=;
        b=bjv8ZgDFDeY2To+k7sGxQS0lWMRQbhoFGj22VnTj/cvvRvCbL21K/AcOzEpktdqBl4
         Xuk7y9XSN8NNgh5SwTJAneEfupcwzneFIXDxIydU4SkuoYw7qIUjvA89JZdt5nbDPZaq
         pgofRfMnUDuUpPEt2EY4h2X9e5AQa7chdBpnk8Fbc5rGZj4spRgqBnqCBBkzNio/pNtY
         OawWPsJwkrL8UapTMTY4d1XT6nTAb1AXYh0nYr58F1PUvqq0SMFSJVwlUovgupfejG5c
         6AydVZ6LEBB+5VpwhvpJym7MijX5bPooyoGfqXUd5DfSdOO8BIYQB6vWQCqc8SSKPLyX
         FsBA==
X-Gm-Message-State: AOJu0YzQW5EbUiq5Wv/NbTKmUw5mey3iAUpORdYAFxEI0kKhLXISdg2q
        QqZHe9T4qYb8Ym2r+nwojQVvSQ==
X-Google-Smtp-Source: AGHT+IFvaxin1673zlwprQP4SWnLVcctslXPms1at5HtCDaXdk2NYjuV3/YZ8ECXZqwv+B7HcAX/nw==
X-Received: by 2002:a05:6000:1d0:b0:319:7abf:d8e2 with SMTP id t16-20020a05600001d000b003197abfd8e2mr8005672wrx.24.1695736048279;
        Tue, 26 Sep 2023 06:47:28 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id l24-20020adfa398000000b003232e5de745sm4351819wrb.55.2023.09.26.06.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 06:47:27 -0700 (PDT)
Message-ID: <c5eb5bea-264b-0084-af6c-2d95580c8f33@linaro.org>
Date:   Tue, 26 Sep 2023 15:47:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 9/9] ACPI: thermal: Drop valid flag from struct
 acpi_thermal_trip
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <5708760.DvuYhMxLoT@kreacher> <9162925.CDJkKcVGEf@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <9162925.CDJkKcVGEf@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 20:47, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notice that the valid flag in struct acpi_thermal_trip is in fact
> redundant, because the temperature field of invalid trips is always
> equal to THERMAL_TEMP_INVALID, so drop it from there and adjust the
> code accordingly.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

