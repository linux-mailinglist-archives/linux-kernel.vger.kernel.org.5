Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A127B1457
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjI1HOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjI1HNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:13:52 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F3A2101
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:10:29 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40572aeb673so97571475e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695885027; x=1696489827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VkIBE+TCRLRjYetF+cyx1hJuGQDYf3kDYmaiNSOiVj8=;
        b=ToJAxIDp6VFXWlWb9DUZLg5P7nRl9fmM4fKmYEhYvJCfiPil3rk7zNjn1yA8z1WpHc
         gfT09oiqoHSOsb29kRx0tFs9gDqPCQ7PiR+S7rdgM/+BxJp7W+avKLgHFZ33STC14Q6Z
         PVZZA/PTN6jS0DC/MCcjgEX5rkPK3YAwmkaT51xs03yu6MZKPxgtBx9mAK8G96voUFGd
         tSAXJU6Pp8lswGLUf3f7Yhf2UQ+n2DEPz/6N5natsNnZvKF7+Sq7JGzAlJDvSs7bX+k7
         O73fuvtNp0mNN666XKwMFE3zgV3GFG1JbkqHl3Tgyv6+4LnggB0CJ0rRTSKXpC1Hh7Vo
         gkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695885027; x=1696489827;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VkIBE+TCRLRjYetF+cyx1hJuGQDYf3kDYmaiNSOiVj8=;
        b=vR8PYy3qY5Q5BOHQtCbGotjTRVZQ4nrUsbu8/xes5EaOK2P/bztR39dgBS+e3U7FJg
         al4Q5o667CBCsU90wpL1690NtHykNeO5id+WjWOvBanfOp6MPEPprqGen81DSfl14Aar
         LrtSCVFJbDBh3rBUjZSwEF/B1Ui4joLSQVmLi5tRhgmDAPtrDPv5a89PCps21NRyeT+u
         ZPLx8g8XJnvKYgFVC6+C/Y2Vt+2ouHObBGqq5VpDchbq+5vNPdshdieLmB2McHcwc3o7
         bd174Sbtj5UrwlLIatkZL8+LDJR/oCkoYATB8HncLhrilAvZDa7HlJLsMpS+M5x2U7/D
         q3yQ==
X-Gm-Message-State: AOJu0Yw5Ah6pbjk/B+cFHD+9pTAJQs8rEi9Jg2h4NxoCtlO7YFHtDp5U
        JfN4pJujtMQThBC0sQ5fdxFHIg==
X-Google-Smtp-Source: AGHT+IGNaZcVgF8TWexpbmorAxSeNepOwNaCRGtwfaC9auOLiO/MLnnmv7ZMk5XMR5I+ZC87mTNoRQ==
X-Received: by 2002:a05:600c:b4e:b0:402:95a0:b2ae with SMTP id k14-20020a05600c0b4e00b0040295a0b2aemr405295wmr.32.1695885027206;
        Thu, 28 Sep 2023 00:10:27 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id a24-20020a05600c225800b004063c9f68f2sm5664262wmm.26.2023.09.28.00.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 00:10:26 -0700 (PDT)
Message-ID: <065636fa-e6ac-4fcb-5d78-b3f281ac4609@linaro.org>
Date:   Thu, 28 Sep 2023 09:10:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 10/13] thermal: core: Allow trip pointers to be used
 for cooling device binding
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <1957441.PYKUYFuaPT@kreacher> <45837158.fMDQidcC6G@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <45837158.fMDQidcC6G@kreacher>
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

On 21/09/2023 20:01, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add new helper functions, thermal_bind_cdev_to_trip() and
> thermal_unbind_cdev_from_trip(), to allow a trip pointer to be used for
> binding a cooling device to a trip point and unbinding it, respectively,
> and redefine the existing helpers, thermal_zone_bind_cooling_device()
> and thermal_zone_unbind_cooling_device(), as wrappers around the new
> ones, respectively.
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

