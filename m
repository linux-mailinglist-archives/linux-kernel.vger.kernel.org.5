Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A62B805601
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345453AbjLENdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345446AbjLENc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:32:59 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA78BA;
        Tue,  5 Dec 2023 05:33:05 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c09dfd82aso32000245e9.0;
        Tue, 05 Dec 2023 05:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701783183; x=1702387983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bzyRrGgr1xyIRTuSlVez/WAzJTF9ClcbFo3elgDY4gM=;
        b=EAq6WQzwsDRvTk22tp64BfGgIqdcjY0CvBM0bBV4nYWsihZ9KrXlzhDdEYaZyVw51o
         SZvICwupz5+4mMiXvozvqr6M2gK89BZt0QWzKqsgrDJC0wnA7zsWfYQBGU1hJFjofkY3
         nbu2pK+0p0RSYX9Za2NBPDVpfRsNtaBVzdtHbK3stVQi3g/Ta62jKH2wXrpyKBruP/bo
         e/f3FTzHid2kMMww4CJ9JkkFAMZCMj3HRRUcEDeiCr7ncKf8ZZysB53Yqwz8pZw1gSfw
         9lesUIbxvaLztsUdp87zuSntXRObEe1ahcJNLC0drmVdLH9fMLJM8s5LAn4/pG4cMT07
         aO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701783183; x=1702387983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bzyRrGgr1xyIRTuSlVez/WAzJTF9ClcbFo3elgDY4gM=;
        b=bYGJUXdqCKG3KfXvksavyD/CnUTAhj8X99uS/fKA77SX2Gt6lNE5H/tSubHJg9CMuy
         DzlO2WO6dGff375Rn0TiseluHjl2cQYbp8RB+HS+jyBHeN6uqp7GA4qHMeYklp5WCKBr
         qVEsyiOxe7zA4u6y8QYthRZAIH8vGRFAPYQguxdtPyTJ1nYybNKly0QRZWFYhGWIrcLi
         T2iv1YJFjDE6VzbsjPWPVtU+v5d+OhyUwW++u1We9sGJRv7OvhhILkM6dKg+chFQ5Xl/
         OACBfZjDRyRKo/KSKAPGVj0oX7dxh47IzSkl69zVX4YQcGOHHTi5lRsUaY4SKhhoGu7J
         V/xw==
X-Gm-Message-State: AOJu0YwwMrOdKv9A5wE7YydiJQPrOUPhy0vZZngqp/TA+Vd9EiQRUEjI
        2KtA/OuPVxjo+uDofexWrA==
X-Google-Smtp-Source: AGHT+IFy0DaIbKCeHYeWS6jUVuiNuwPqwgmtFOSPV4fT2Ct/kGDs1iBXqYgPiOiyj8ufYthmHzVEyA==
X-Received: by 2002:a05:600c:1f0c:b0:40b:5e59:ccaf with SMTP id bd12-20020a05600c1f0c00b0040b5e59ccafmr555401wmb.144.1701783183295;
        Tue, 05 Dec 2023 05:33:03 -0800 (PST)
Received: from ?IPV6:2a02:810b:f40:4300:4583:8031:1ebd:143b? ([2a02:810b:f40:4300:4583:8031:1ebd:143b])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c310e00b0040b481222e3sm22564748wmo.41.2023.12.05.05.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 05:33:02 -0800 (PST)
Message-ID: <7bc1ba43-98cc-47ce-8d58-b4f4081c84b7@gmail.com>
Date:   Tue, 5 Dec 2023 14:33:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Move core bus and gpio aliases to SoC dtsi for RK3128
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org
References: <20231202130506.66738-2-knaerzche@gmail.com>
 <170173468934.501889.12474504620278418598.b4-ty@sntech.de>
Content-Language: en-US
From:   Alex Bee <knaerzche@gmail.com>
In-Reply-To: <170173468934.501889.12474504620278418598.b4-ty@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

Am 05.12.23 um 01:05 schrieb Heiko Stuebner:
> On Sat, 2 Dec 2023 14:05:04 +0100, Alex Bee wrote:
>> Following up the recent discussion [0] about where aliases can be/should be
>> placed this series moves gpio, i2c and uart aliases to SoC dtsi for RK3128.
>>
>> Note: This patches are based on maintainter's repo.
>>
>> [0] https://lore.kernel.org/all/b0c637f5-5abf-420b-8b02-839eba68799e@linaro.org/T/#m94aebb23a29b015d94b250a70b675febdaa902ea
>>
>> [...]
> Applied, thanks!
>
> [1/3] ARM: dts: rockchip: Move gpio aliases to SoC dtsi for RK3128
>        commit: 3b0422a4ce59d8afb84bd7516bf71a3c1caa7925
> [2/3] ARM: dts: rockchip: Move i2c aliases to SoC dtsi for RK3128
>        commit: 39732a49803cf271454416341549df09c4a2fd2f
>
> I also applied patch 3 ... though had to pick it manually from the list
> as the subject was a bit garbled (missing 3/3), so b4 did not pick it up.

Thanks and sorry for the mess.

Not sure how I managed to get this done :) Will double check next time 
before submitting.

Alex

>
> Best regards,
