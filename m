Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3347D7C4F92
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjJKKGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbjJKKG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:06:27 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E2FDB
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 03:06:23 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32c9f2ce71aso1473716f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 03:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697018781; x=1697623581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bcu8SH2nyw79dGr/lHHTOch/RopwLLp/av5OXKcyU8g=;
        b=i3iy7kfubYPSObP3K78GPcM2whq/r6YPezjDkKtPlfjWxlEzJYfDql47mhY9EF1DvR
         KqQQLjVvNOco2oaEmt5z/Af+Ef/w4Km/ur5vfaG2vluWTjlnIP/f/Q8gPZPE2Y4ZLozv
         JHf9ukrT7r8oCE0kxQVWPx4xohoRvSJ1tL65F5k5tkORy7tMNzn+a84QFxGLszFopt1Q
         BzWkjMYyel8QNHagH05ByIIkcU+s45XfW7umnj9enMbAtCyTj8OdX6G3KFuTl/QrSqeC
         i1LUII07ay0Fgq9cMw4rwZuEcoE0GG4BOXg92oFutjTcJcBDof4VuvjgAaZSLtEUeuqh
         w9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697018781; x=1697623581;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bcu8SH2nyw79dGr/lHHTOch/RopwLLp/av5OXKcyU8g=;
        b=QgZSGee4e/i4XEjH4DRwT+fekzL6FJhDY2c/o9tajJCmR6j46laRbgcAsPO7rV3+Lm
         mvdkYrVDT+VrZVLxByStvNQdrIb1fK2KgrD1t8QrBjSbSoF9EGVOvIe8uMMYF6nHVLeD
         +gCd5qET5/aMUiLYRVnyPydjWcgGbuNqKQfWLcXf1zeMuAHQgXM1P5gfIHUWdX6s4Gs+
         PtNN8B+Gaxr1XCx0mZrIBq9h3rzixHyHASGWidnnoeMF4Sdxhdd40iWbHRM7A8usEgCu
         fmTAvyKm/ALsdA0KDloi0n7rG5R1PRZYRRr3bpEInw9ITLX8vzd5sDbR4cIT6pfFEK9F
         8hcQ==
X-Gm-Message-State: AOJu0YzWIP7K9nRgIKTtn9QMxTYVoki++aqWE2f1qpB+sU4JPTCmDkkk
        no+Rw7A/fpQiwiwNFhNumYI0zw==
X-Google-Smtp-Source: AGHT+IEwV85pXWAtkZXgOk4jNUrmdXKW76O9Yh5qCRRQS1Jt+0DPvBycNIUwx0Ij6HMSyhg42mFyyA==
X-Received: by 2002:a05:6000:109:b0:320:1c6:628c with SMTP id o9-20020a056000010900b0032001c6628cmr18980219wrx.65.1697018781585;
        Wed, 11 Oct 2023 03:06:21 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:de95:eca9:6b1e:b330? ([2a05:6e02:1041:c10:de95:eca9:6b1e:b330])
        by smtp.googlemail.com with ESMTPSA id e14-20020adffd0e000000b00315af025098sm15162004wrr.46.2023.10.11.03.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 03:06:21 -0700 (PDT)
Message-ID: <500f7f18-65cf-4182-a174-5f0081456b3b@linaro.org>
Date:   Wed, 11 Oct 2023 12:06:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/drivers/arm_arch_timer: Initialize evtstrm
 after finalizing cpucaps
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, tglx@linutronix.de
References: <20230907133410.3817800-1-mark.rutland@arm.com>
 <a56ea45c-f1cb-4f9a-bfc9-d6af3282b13a@linaro.org>
 <ZSZsogqIgG863ucA@FVFF77S0Q05N>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ZSZsogqIgG863ucA@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2023 11:36, Mark Rutland wrote:
> Hi Daniel,
> 
> On Wed, Oct 11, 2023 at 10:30:39AM +0200, Daniel Lezcano wrote:
>> On 07/09/2023 15:34, Mark Rutland wrote:
>>> We attempt to initialize each CPU's arch_timer event stream in
>>> arch_timer_evtstrm_enable(), which we call from the
>>> arch_timer_starting_cpu() cpu hotplug callback which is registered early
>>> in boot. As this is registered before we initialize the system cpucaps,
>>> the test for ARM64_HAS_ECV will always be false for CPUs present at boot
>>> time, and will only be taken into account for CPUs onlined late
>>> (including those which are hotplugged out and in again).
>>>
>>> Due to this, CPUs present and boot time may not use the intended divider
>>> and scale factor to generate the event stream, and may differ from other
>>> CPUs.
>>>
>>> Correct this by only initializing the event stream after cpucaps have been
>>> finalized, registering a separate CPU hotplug callback for the event stream
>>> configuration. Since the caps must be finalized by this point, use
>>> spus_have_final_cap() to verify this.
>>>
>>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: Marc Zyngier <maz@kernel.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> ---
>>
>> Applied thanks
> 
> This got folded into a larger series that we were hoping to take through the arm64 tree:
> 
>    https://lore.kernel.org/linux-arm-kernel/20231010103139.3113421-1-mark.rutland@arm.com/
>    https://lore.kernel.org/linux-arm-kernel/20231010103139.3113421-2-mark.rutland@arm.com/
> 
> I think that won't conflict, since all that's changed is the commit text, but
> it might be worth dropping this patch for now to avoid the risk of a conflict.

Sure, thanks for letting me know. I was suspecting that was the case :)

I've dropped it

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

