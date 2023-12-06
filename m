Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCDB807A3D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379659AbjLFVVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379534AbjLFVVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:21:09 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444E8D5B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 13:21:15 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54da61eb366so300965a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 13:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701897674; x=1702502474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6eHL/dN/qRcrKzFWjeWh9PSQOYj5S62HkgJQDrTF094=;
        b=F/UIDWYYvkwgRW/g4H4VCgNJnooVoPAX7Ws2YHmoX8xyhvQsnztByB+rd3q9p/aPiw
         lk6IUzSX/Zwf5kfwcdVhdDBhql1UYwiAIHZ+omAxTxJnbMICRF7SYcMOxNlqvVQKBXMf
         RrOsP94OuBW9Cb/Zg+uUqgJIF6lJe9Xqd7b8j/ihEucJ7AdruP7PIlqDTZeKgH8rpK9I
         fal03+LzIg16hkdKqsIs4crVVNWrN0LaBJFw2jhDpv9ezWRok/pUbMampyJv72+mibnS
         RIaiCVEqYTQB83l+m1CluYRwvx8Z6ZRb+8y1MK55yQxsLfS7zNJf0g8HWzB5w8P74y63
         Glzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701897674; x=1702502474;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6eHL/dN/qRcrKzFWjeWh9PSQOYj5S62HkgJQDrTF094=;
        b=njj8asLvU6x+EixKwRkPQKYHRq7Zh4zIrv8haTJ1xYp42FRFWEj8o4FkEJ42MR8oet
         VDBcwrp5Sh/fGJP0X8Bc0RZmBXO3AXVoLVZ4bybh/C6vyXwFdA3McGYfh1iu5fKvNq+4
         sydltoN8BiHUkin9ePZyr9Ku1erXV+B/CIg4dtxETTexs4A3ss8VAa10LLHtmmV7+NIi
         1w/aJmyoADEjcnD8GUSYgqh0zfMgbNbouXfGZXcv1NyyhTZ+6BldVCqVN8Fp659LlGOo
         NXJ/odNkHB2K7YEezD7fmVqEfY/W0dpwWlZkSZYclKSPlEz+f6KHRnPxlnKjR+sFMHLO
         R5qA==
X-Gm-Message-State: AOJu0YwxPjm4hZVxg3uGfrqib4nq44+bD1VbLLCE1YohUZRXEdLxuzLd
        b5GLhUWLmk6z+uGvJKM0RMGwOw==
X-Google-Smtp-Source: AGHT+IGc+dDMW9dkb1ZkmEGUnnVdZSMIE832JsEWrrD5zfx3lvPWRNCWR48Ww5HEZRT+9SQfWvkV0A==
X-Received: by 2002:a05:6402:17c5:b0:54c:e632:e629 with SMTP id s5-20020a05640217c500b0054ce632e629mr881004edy.44.1701897673701;
        Wed, 06 Dec 2023 13:21:13 -0800 (PST)
Received: from ?IPV6:2001:1c06:2302:5600:366d:ca8f:f3af:381? (2001-1c06-2302-5600-366d-ca8f-f3af-0381.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:366d:ca8f:f3af:381])
        by smtp.gmail.com with ESMTPSA id f11-20020aa7d84b000000b0054c7dfc63b4sm385980eds.43.2023.12.06.13.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 13:21:13 -0800 (PST)
Message-ID: <a058827a-b025-4ee5-b2a4-d6c8963a6b73@linaro.org>
Date:   Wed, 6 Dec 2023 22:21:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: qcom-pmic: add CONFIG_OF dependency
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>
References: <20231206172037.12072-1-rdunlap@infradead.org>
 <d0323841-a3a7-45b7-b702-0a08f9250c55@roeck-us.net>
 <0c1bb5e8-1ad2-4bda-b038-456d9791f9b7@infradead.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <0c1bb5e8-1ad2-4bda-b038-456d9791f9b7@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2023 20:46, Randy Dunlap wrote:
> 
> 
> On 12/6/23 10:49, Guenter Roeck wrote:
>> On Wed, Dec 06, 2023 at 09:20:37AM -0800, Randy Dunlap wrote:
>>> DRM_AUX_BRIDGE depends on CONFIG_OF, so that is also needed here
>>> to fix a kconfig warning:
>>>
>>> WARNING: unmet direct dependencies detected for DRM_AUX_HPD_BRIDGE
>>>    Depends on [n]: HAS_IOMEM [=y] && DRM_BRIDGE [=y] && OF [=n]
>>>    Selected by [y]:
>>>    - TYPEC_QCOM_PMIC [=y] && USB_SUPPORT [=y] && TYPEC [=y] && TYPEC_TCPM [=y] && (ARCH_QCOM || COMPILE_TEST [=y]) && (DRM [=y] || DRM [=y]=n) && DRM_BRIDGE [=y]
>>>
>>
>> All but impossible for me to determine if this patch or
>> https://lore.kernel.org/all/20231205-drm_aux_bridge-fixes-v1-2-d242a0ae9df4@kernel.org/
>> is more appropriate.
>>
>> Guenter
> 
> I guess that Bryan is the person to ask about that.
> 
> I don't see anything wrong with Nathan's patch. It should clear up the kconfig warning,
> so as long as it builds cleanly, it seems OK.
> 

So, I see both versions of this fix

Nathan's
drivers/gpu/drm/renesas/rcar-du/Kconfig

Yours
drivers/gpu/drm/tve200/Kconfig

and virtually equivalent commit text. I think we agree its 1:1

So, maybe stick with Nathan's since he posted first.

---
bod
