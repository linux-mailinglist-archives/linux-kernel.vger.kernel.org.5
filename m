Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41310757FCA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjGROjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjGROjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:39:42 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256A2EC;
        Tue, 18 Jul 2023 07:39:41 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b9ecf0cb4cso34988145ad.2;
        Tue, 18 Jul 2023 07:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689691180; x=1692283180;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9YjbH/cYJ2PSUK6dxbLLOnKRzrSg51mtuQEdl2JaXwE=;
        b=gL0tFQjNN8biOJamPJJfy44kw7s40tsXNw9jqPr7YfxT22wzc3ofdkm+F+GH4Q9QSE
         s7neCAqGR/hs1OhMFFAH9siFxoPGlrVPC+0obIBN0p4hffwOAVt/l+zoENXEBc7EaVeC
         eYdKQq8nlK3bafoOVWRZjthIQ0mThb6POY4dYJEFOwh07BOTYdj0cbticuDrqJLJR+Dh
         FZyx+bizRqAoGme9gwzp0Pc+DzRHymL84H0sftKzvDspikiVzcnCZE+LTRq5l3SnTtcq
         hF0QbkfFpXU1p8JYzY7YbPspVSCu0aFwymMSaUW5aLp2ysqsENbAJ0tw4hoX+V3ZMHuR
         SxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689691180; x=1692283180;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9YjbH/cYJ2PSUK6dxbLLOnKRzrSg51mtuQEdl2JaXwE=;
        b=RvpIFTd04LG7iPZ2u5ETiLASoDp3HaW3NZwvTrNMWpFIHKB/e38GUn7lP+0twq5GyV
         s+ej9/KYUf1EY03jWrKormeR70lk5e1zI1abxNggfFp9NAKXufYPRvYB09ZPw+1/+QQR
         9/5BAElkgNtqHccX5VRmvkFP996HPuzN/Zt7Ut2n/0hCTxIcg13ta7r9hmmMMBgeMLa1
         xYRKzuGRbnT3D7GR8aVD1jneV8YCV6nwJKvDg+V5Y8d1X/1ZgbCg94HEgQxR5mrC4XR5
         /noIP+2OCg35e72MMZrWkUQoKiae//oNjK6lpAfCFjpcuG9LbTyHWe54U3CyCOKJzwqJ
         N5ag==
X-Gm-Message-State: ABy/qLYaCQAW9KdicZk+uhuk1CENegMaar96uQaulvldE7exuTVEQPUv
        aorQBJ9wjxJwxuOqKBl0wn4=
X-Google-Smtp-Source: APBJJlHI97bUK0iK9LMlvLm46mZIfpEdRIHdjU2Cg78mA1CdqVmN/EQn9jS5vsQwIC6Jzwmy/RywGw==
X-Received: by 2002:a17:902:f681:b0:1b6:bced:1dc2 with SMTP id l1-20020a170902f68100b001b6bced1dc2mr34502plg.0.1689691180518;
        Tue, 18 Jul 2023 07:39:40 -0700 (PDT)
Received: from ?IPV6:2601:1c2:980:9ec0::2764? ([2601:1c2:980:9ec0::2764])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902b7cb00b001a24cded097sm1936371plz.236.2023.07.18.07.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 07:39:40 -0700 (PDT)
Message-ID: <364507a5-ea2e-6280-cc9e-394e09d6edf7@gmail.com>
Date:   Tue, 18 Jul 2023 07:39:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] pwm: fix pwm-rz-mtu3.c build errors
Content-Language: en-US
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <ac8d6190-06ae-b538-1293-07efedbfe94e@gmail.com>
 <TYWPR01MB877550F95CF000B63E9AD022C238A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
From:   Randy Dunlap <rd.dunlab@gmail.com>
In-Reply-To: <TYWPR01MB877550F95CF000B63E9AD022C238A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/23 05:13, Fabrizio Castro wrote:
> Hi Randy,
> 
>> From: Randy Dunlap <rd.dunlab@gmail.com>
>> Subject: [PATCH v2] pwm: fix pwm-rz-mtu3.c build errors
>>
>> From: Randy Dunlap <rd.dunlab@gmail.com>
>>
>> When (MFD) RZ_MTU3=m and PWM_RZ_MTU3=y, there are numerous build
>> errors:
>>
>>
>> Modify the dependencies of PWM_RZ_MTU3 so that COMPILE_TEST is
>> still allowed but PWM_RZ_MTU3 depends on RZ_MTU3 if it is being built
>> but also allow the latter not to be built.
>>
>>  drivers/pwm/Kconfig |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff -- a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -505,7 +505,8 @@ config PWM_ROCKCHIP
>>
>>  config PWM_RZ_MTU3
>>  	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
>> -	depends on RZ_MTU3 || COMPILE_TEST
>> +	depends on COMPILE_TEST
>> +	depends on RZ_MTU3 || RZ_MTU3=n
> 
> Isn't this a tautology?

Not at all. It's used in Kconfig quite a bit.
This is tristate logic.

It says that if RZ_MTU3 is y/m, PWM_RZ_MTU3 is limited by that.
But if RZ_MTU3 is n, PWM_RZ_MTU3 can be y or m.

Is that clearer?

-- 
~Randy

