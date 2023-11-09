Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72897E66A3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbjKIJYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjKIJYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:24:17 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091691A8;
        Thu,  9 Nov 2023 01:24:15 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc3216b2a1so5400265ad.2;
        Thu, 09 Nov 2023 01:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699521854; x=1700126654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s9z5YMQfnjQ/GY0LeFlyZmhpmN5+9DIXygr9TI/NBP0=;
        b=VBE2VOdmlJ4YFwH1l/BOwFSk5U2rqxh/uGUs/M/Jfnsf/HJ4bLB+5LFHaUoD+AQrYv
         hzYwZaxruUl7dqPU89GaB14Ionndg72QrW1klvm9Rxd01iQqYbSb/krgaUkymaLhC9sG
         yD+vc6oO0QnjayXYE7KXfbvTAwr1AVFfLHBGTP0r9avghwgE0hl+33hr4ZEtUuoAaro1
         SusJ1XuYdQh9gRnW6UIKMSbwplx3ImQ8HEt6RgNlSIO9k7m8fM+3ytP2Pv5QSHFNloie
         TLWC2ZMpWSkC6ywmhSQKTPeudIVU38UMcRKtO0A6XyKRAByB/Sd8RIRxhtcpIRNCATG8
         Szyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699521854; x=1700126654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9z5YMQfnjQ/GY0LeFlyZmhpmN5+9DIXygr9TI/NBP0=;
        b=eAzN0qZqmUiYZObQlHwkJI9yP7s+F/j44Fk9S4xY4IKmROoDgwvxkqWlxikKVCNDr2
         EGKvu/elBj3+GgtyQsovpfy9EBYxX3ljrHou58PC5FfXRvWwmSWNqFc3fjXxB31zmUc6
         CtMydA7VHHqtg2f0pc+enShQRBH66RZFVZJvvy0KtEh3JY8iTfW421ZKzomiO9iUtbEe
         pOgxvjKZSO2my2LrFMaMY3hZDHMv4pXrZ2Ukis1FRQfvgpCRA6eGfNU8hd2QfXtEQewl
         KG8wsAlDncei0V5jFdjBXbJ2u8VMyjydi9/No3kQOAqyFbSzxQ/f9Ha5zT8QyVX6JqBl
         j3xQ==
X-Gm-Message-State: AOJu0YxVtKb6RRu9Un2Ri4SPYVlmqRTc0cKuXdjmDVCvJrHCdc6kqjdO
        Qd3wKnT6gkJ2lVbvhrUOx6kKROBZxjFfBRG6
X-Google-Smtp-Source: AGHT+IENlNBi+FriuTiTX+gb9LYPZEJOn3W+qGieoAr6eCO/lUZaRo1Awj8aaYwZJVxrv6apffV17Q==
X-Received: by 2002:a17:903:48f:b0:1ca:e4b:148d with SMTP id jj15-20020a170903048f00b001ca0e4b148dmr3491122plb.65.1699521854398;
        Thu, 09 Nov 2023 01:24:14 -0800 (PST)
Received: from ?IPV6:2401:4900:2353:8963:b940:1ac0:2fbc:6b6? ([2401:4900:2353:8963:b940:1ac0:2fbc:6b6])
        by smtp.gmail.com with ESMTPSA id h21-20020a170902eed500b001bf846dd2d0sm3066878plb.13.2023.11.09.01.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 01:24:13 -0800 (PST)
Message-ID: <1ceb75c6-e65c-4c82-ba7f-7eb5dfb65018@gmail.com>
Date:   Thu, 9 Nov 2023 14:52:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: light: driver for Lite-On ltr390
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20231109090456.814230-1-anshulusr@gmail.com>
 <20231109090456.814230-2-anshulusr@gmail.com>
 <CACRpkdYtawfonnkGXzTD65fx4CMbbTaXe359tm7=57saHSNfqA@mail.gmail.com>
Content-Language: en-US
From:   Anshul Dalal <anshulusr@gmail.com>
In-Reply-To: <CACRpkdYtawfonnkGXzTD65fx4CMbbTaXe359tm7=57saHSNfqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

On 11/9/23 14:49, Linus Walleij wrote:
> Hi Anshul,
> 
> thanks for your patch!
> 
> Overall this looks good to me.
> 
> On Thu, Nov 9, 2023 at 10:07 AM Anshul Dalal <anshulusr@gmail.com> wrote:
> 
>> Implements driver for the Ambient/UV Light sensor LTR390.
>> The driver exposes two ways of getting sensor readings:
>>   1. Raw UV Counts directly from the sensor
>>   2. The computed UV Index value with a percision of 2 decimal places
>>
>> NOTE: Ambient light sensing has not been implemented yet.
>>
>> Datasheet:
>>   https://optoelectronics.liteon.com/upload/download/DS86-2015-0004/LTR-390UV_Final_%20DS_V1%201.pdf
>>
>> Driver tested on RPi Zero 2W
>>
>> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
> (...)
> 
>> +#define LTR390_FRCTIONAL_PERCISION 100
> 
> This define is just too hard for me to read, can you rename it?
> 
> Does it mean LTR390_FRACTIONAL_PRECISION? It's fine to spell it out like
> that instead.

Yes indeed, that typo would be fixed in the next revision.

Thanks for the review.

Best wishes,
Anshul
