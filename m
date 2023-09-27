Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A67C7B0718
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 16:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjI0OiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 10:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjI0OiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:38:20 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842D6F4;
        Wed, 27 Sep 2023 07:38:19 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c44c0f9138so83145935ad.2;
        Wed, 27 Sep 2023 07:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695825499; x=1696430299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wg9JCAMjvjZwbC735OPsJLUGNr3Ze8+WvpWD8+0Wa8Y=;
        b=jpcgxuRwqxFjr3h3My4JqjBkjrZcuYEjrA3ic5txRZbv0C2C+qa7Gu2vnyDADd1dvk
         DK7OPM6JH7gv/duqGM2E4aQ2WXma0UI5zg08+3FomoLPbC2dMuCFBwmJSlYntMOYKph6
         ou7Gt8BXFW3GHDDnJ/K9dLAwtvM2ihOxa/Lrqrimf+sECb3qHq+IkkLO4PGJJ96XmQ73
         lyVHl+NqoQMMVabWx7H0IgI2rdZs66I1iJjfVsc5GyIOn5IfwynbNPXzvP3rgXAIlVHN
         F7PbXtKNZpVqxft6VcNT0f7jEpfWA496Qa2pixw9h1PhjN0hGUGW4CtsJ9r47IF8vvOS
         YAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695825499; x=1696430299;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wg9JCAMjvjZwbC735OPsJLUGNr3Ze8+WvpWD8+0Wa8Y=;
        b=wScD5+Juo2cA1mUtfkWt0ueW6wtLqHJIvNOx9SaJzCh2x2xf0OQlVQr2lnce6n7dnO
         NhqA1eyzwzChctg+Kz4hHPjbpBIAqO79mqCtUzC/2FJaZuzI4CTZYoX6Bmao09L2Wvys
         ttzlaFDhjal8Ol6bqK3BSo3g6aHWmzYK1nkE8cOv20nA1Cybb6ZQPSlGoOafkM1VyIbP
         3opkyVuUbqbj4NTm4ot1kvMAfSO8pIwmz0MnbyQHAhqFdz4mNqKKsTUlM/UkU06pjVWM
         A410C/lIoXhqkgAvfOje1cJ82o0e9R+Jlqct30hTCmBuI4cmGZNLm1G027fILQjWX+G2
         eBFQ==
X-Gm-Message-State: AOJu0YzugNXTyIHezz6VNKot0p8iQFr0u5yLix+UFmFJ3S1Nwqe+sVYW
        ZChNej7MN6ls48UHZQKMrD4=
X-Google-Smtp-Source: AGHT+IH+Pf7ytQ1lXJUd1H3FhkjrBQE6vNLJh0Hp56wth1H0Rau/gwGEsi4MFg9ftJk0alyE/L26jA==
X-Received: by 2002:a17:903:1109:b0:1b9:e937:9763 with SMTP id n9-20020a170903110900b001b9e9379763mr2282601plh.12.1695825498846;
        Wed, 27 Sep 2023 07:38:18 -0700 (PDT)
Received: from [192.168.31.134] ([27.4.138.218])
        by smtp.gmail.com with ESMTPSA id z13-20020a170903018d00b001b8062c1db3sm13141034plg.82.2023.09.27.07.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 07:38:18 -0700 (PDT)
Message-ID: <2ada40ae-f11b-9ac5-a493-6ae2383fac2a@gmail.com>
Date:   Wed, 27 Sep 2023 20:08:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] thermal: imx8mm_thermal: Fix function pointer declaration
 by adding identifier name
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org,
        rui.zhang@intel.com, amitk@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230917083443.3220-1-bragathemanick0908@gmail.com>
 <786d197a-a2b5-2507-f5d7-24e8224a3922@gmail.com>
 <883b0780-1f89-40a4-fbd0-a3d4845c2826@linaro.org>
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
In-Reply-To: <883b0780-1f89-40a4-fbd0-a3d4845c2826@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/09/23 13:17, Daniel Lezcano wrote:
> On 22/09/2023 11:31, Bragatheswaran Manickavel wrote:
>>
>> On 17/09/23 14:04, Bragatheswaran Manickavel wrote:
>>> Added identifier names to respective definitions for fix
>>> warnings reported by checkpatch.pl
>>>
>>> WARNING: function definition argument 'void *' should also have an 
>>> identifier name
>>> WARNING: function definition argument 'int *' should also have an 
>>> identifier name
>>> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
>>> ---
>>>   drivers/thermal/imx8mm_thermal.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/thermal/imx8mm_thermal.c 
>>> b/drivers/thermal/imx8mm_thermal.c
>>> index 14111ccf6e4c..5dc6c18f12df 100644
>>> --- a/drivers/thermal/imx8mm_thermal.c
>>> +++ b/drivers/thermal/imx8mm_thermal.c
>>> @@ -78,7 +78,7 @@
>>>   struct thermal_soc_data {
>>>       u32 num_sensors;
>>>       u32 version;
>>> -    int (*get_temp)(void *, int *);
>>> +    int (*get_temp)(void *data, int *temp);
>>>   };
>>>   struct tmu_sensor {
>>
>> Hi Team, Could someone help in reviewing it.
>
> Please no more "gentle reminder"
>
> Read:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/Documentation/process/submitting-patches.rst 
>
>
> Especially, the section _9_
>
> Thanks
>
>    -- Daniel
>

Hi Daniel,

Understood. Will wait for this to get reviewed.

Thanks,
Bragathe

