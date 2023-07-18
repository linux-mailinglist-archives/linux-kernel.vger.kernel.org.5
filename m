Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF1775748F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjGRGop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjGRGon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:44:43 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8BB18B;
        Mon, 17 Jul 2023 23:44:42 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b9cd6a0051so32873785ad.1;
        Mon, 17 Jul 2023 23:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689662682; x=1692254682;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uMbh7jwllIPwgM4IzbUdrwGGhGzCBdzcMfm0+YMOsBQ=;
        b=n2mLG0KL2ihGcfqYmy/W4LpF0ikS0Y7uHyca66GLdIMjNo0QURJbqbD8PAp4quHib2
         ibwxKvgLh8bo6uhLomTFZMiShj+69ILXmIVgK+853EXiCU90+sJLxypIrszFXtcTswHn
         QhcPidKpMN9R1i0tTlparvKkEXm7gle3eh87R3GYjrAitFmw0VwD5QlkHiBtpxWrxl0u
         fNY8B/wyvh1Q4lbvmZJvtP52qBNL/51wIHB5uyYgY99gtlkqSu7ygNwC9pY08ZyknLKm
         tCnC8um4cR/5z4sUIZAV6woEuIphIoEom3JruojiHDWItg8Qqa7yW5JoUWaNJwH1/f1e
         wJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689662682; x=1692254682;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMbh7jwllIPwgM4IzbUdrwGGhGzCBdzcMfm0+YMOsBQ=;
        b=bZ1hkETDnF0TZtXcNnsBe/q5puUbEQqwGsz7+SQMLHurTnxMpirsFw4NMDqtTZcC5h
         Z2nY17oVpiLmKGFCCcye/yOloMhbxpII7e5YYHvtJiInTv8Yh1bd8OPKC2Up/D24N6xR
         4BiUOKQxXYq4PwJOkDet5ZLbic8yxfiEK5RBzUBThO5WYOX+StzGbzDw7srqbFMsqaDp
         ItyrwpO4STd/0kHErfb8q1lTsldmScArQDwVw0Ka/8k/VQbftytl0r6MbmtDdtIzUFMN
         161lpLAbBAtlSZHRfeRddHMvVsXNo5Qhs5kO1KSiECscR6hH2YyZTTDH5MUza4sUd0k6
         SZUQ==
X-Gm-Message-State: ABy/qLaVL2zbNlCjbtRPKuELjo0P+EKDmMuRPXiH6kOIuFrPoafTCW13
        XT0UehtAMCcyFXfsOORXiuPycHi0nb5qNQ==
X-Google-Smtp-Source: APBJJlHOfx9e0WaPUjZq/XKAtbpMLN4AzYozC28MkcvV3Xx+6n8p8TUCO8QWWcBAWRgHxGo00V90Ag==
X-Received: by 2002:a17:903:22c5:b0:1b9:e399:4c8d with SMTP id y5-20020a17090322c500b001b9e3994c8dmr1618230plg.3.1689662681863;
        Mon, 17 Jul 2023 23:44:41 -0700 (PDT)
Received: from ?IPV6:2601:1c2:980:9ec0::2764? ([2601:1c2:980:9ec0::2764])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902e54800b001acae9734c0sm969627plf.266.2023.07.17.23.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 23:44:41 -0700 (PDT)
Message-ID: <f0586356-c7f2-c8dd-fbac-ab874dc94f23@gmail.com>
Date:   Mon, 17 Jul 2023 23:44:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] pwm: fi pwm-rz-mtu3.c build errors
Content-Language: en-US
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
References: <8a4de6c6-8d7c-a115-2a14-d264d6d28ccf@gmail.com>
 <d31387c2-7411-ae98-93d3-418b9d5b87f6@gmail.com>
 <OS0PR01MB5922C3D065F47297A9620A4A8638A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Randy Dunlap <rd.dunlab@gmail.com>
In-Reply-To: <OS0PR01MB5922C3D065F47297A9620A4A8638A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 23:42, Biju Das wrote:
> 
> 
>> -----Original Message-----
>> From: Randy Dunlap <rd.dunlab@gmail.com>
>> Sent: Tuesday, July 18, 2023 7:38 AM
>> To: linux-kernel@vger.kernel.org; linux-pwm@vger.kernel.org
>> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>; Thierry Reding
>> <thierry.reding@gmail.com>; Biju Das <biju.das.jz@bp.renesas.com>
>> Subject: Re: [PATCH] pwm: fi pwm-rz-mtu3.c build errors
>>
>> On 7/17/23 22:59, Randy Dunlap wrote:
>>> From: Randy Dunlap <rdunlap@infradead.org>
>>>
>>>
>>> Fixes: 254d3a727421 ("pwm: Add Renesas RZ/G2L MTU3a PWM driver")
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>
>> Oops, I should resend that with corrected email addresses. Sorry.
> 
> Also typo in patch header "pwm: fi pwm-rz-mtu3.c build errors" ??

Yes, I saw & fixed that one.

> Not sure fixes tag should be
> b8b28b718ddd ("mfd: Add module build support for RZ/G2L MTU3a")
> or
> 254d3a727421 ("pwm: Add Renesas RZ/G2L MTU3a PWM driver")

It's the PWM Kconfig entry that is incorrect AFAICT.

thanks.
-- 
~Randy

