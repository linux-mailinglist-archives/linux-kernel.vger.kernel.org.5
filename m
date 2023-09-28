Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57417B1E71
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjI1Nby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjI1Nbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:31:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213D91A2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 06:31:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so12357283f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 06:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695907908; x=1696512708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T08S6IcvTtc7N9BV5LzOKgOD0pjFqX9HyRFqWGAYhhs=;
        b=qGH/yx6ELOmDQYM0Abt2n1QZA96NjkfJMKJyHfyBwpZiwuqVb8bbycg8PXJeItdsoc
         +nt1l8AXdgWdi7IH1o0Ftmo5pgeedRS6uMwb8TYIo5KzIGaJV/ltwrAYcBJd32j8YOvo
         DfeW9ZBsGNYn/jL15Fwa91eF/bGiRwqiJCIoJySN8Ef6A1zOp5/xBwozTrhf8sZzYskC
         942akULqN/7f2q2icjPoiOc01fx8J1wFL//YzdrVm/Pzt7Dq9W1Q5AyDFmYhVGIcnkJI
         UYfBJfqLLwraTNn7lYAhWV7jdbCTdn55hL36ObPEBYktvCBUq7+Jnr7OmPR69CEJKwXJ
         lQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695907908; x=1696512708;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T08S6IcvTtc7N9BV5LzOKgOD0pjFqX9HyRFqWGAYhhs=;
        b=w4QYkPDYvHf/YiiykV0hesHxcENIxHpFHLILjo502ylXgMAv+Pd0X79SNEpgl6Yy0y
         tPkMPYOb/283fE5erzL8vklAzGJ4dzQnm7X3/PNUz8DtYCx1oBxMFOy1uM5/4DCzalhj
         RVgNLZHzsrBk9R0KtJivcLjF9IsdMUjO1k1xn/kVvcIEcUdU5mjbpFWdg3g83+g8fsux
         Gd8KA9p6nXiHdzDiaaNVG78CN6ayo9n2yr48yOu6tB5DtUa7ndQSk1Dd6T+8eTtR751A
         CVkGwYsMoNAeKtOEjyTKQ9ywdcP/gDLX40FghYGGzLsQ/WLRXu/z+A/1UoAO7jIeNBI/
         BDbQ==
X-Gm-Message-State: AOJu0YzpI8YQYiz5sDqH8afokUlKfu2KWivEhVinyDruBO9XgItU5YsX
        NgtOrMCTWQ78ZyAJKZKvqFhtfA==
X-Google-Smtp-Source: AGHT+IEaDyRoeJfIh3W2+KNnYk9x6itUo1Xk6uJTmTcRoir3MfVwImO36qIbE00OsPNbngLtxbPUzg==
X-Received: by 2002:adf:cd0a:0:b0:31f:f982:5395 with SMTP id w10-20020adfcd0a000000b0031ff9825395mr1408904wrm.35.1695907908443;
        Thu, 28 Sep 2023 06:31:48 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id c10-20020a5d4f0a000000b0031f3ad17b2csm19426288wru.52.2023.09.28.06.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 06:31:48 -0700 (PDT)
Message-ID: <11eac712-b9aa-3c46-11bc-70c2f4f9935c@linaro.org>
Date:   Thu, 28 Sep 2023 15:31:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 10/13] thermal: core: Allow trip pointers to be used
 for cooling device binding
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <1957441.PYKUYFuaPT@kreacher> <45837158.fMDQidcC6G@kreacher>
 <065636fa-e6ac-4fcb-5d78-b3f281ac4609@linaro.org>
 <CAJZ5v0gjGL_4Fs=_iO086tmBP6E+oQoo+Jix_PH0dspbZ9yn2g@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gjGL_4Fs=_iO086tmBP6E+oQoo+Jix_PH0dspbZ9yn2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2023 12:38, Rafael J. Wysocki wrote:
> On Thu, Sep 28, 2023 at 9:10 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 21/09/2023 20:01, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Add new helper functions, thermal_bind_cdev_to_trip() and
>>> thermal_unbind_cdev_from_trip(), to allow a trip pointer to be used for
>>> binding a cooling device to a trip point and unbinding it, respectively,
>>> and redefine the existing helpers, thermal_zone_bind_cooling_device()
>>> and thermal_zone_unbind_cooling_device(), as wrappers around the new
>>> ones, respectively.
>>>
>>> No intentional functional impact.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>
>> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Thanks so much for all of the reviews!

You are welcome. Thanks for cleaning up the ACPI code

> I'll now apply the patches for which you have given tags and respin
> the rest (governor changes) as a separate series on top of them.

Sounds good, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

