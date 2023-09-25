Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7F77AD246
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjIYHre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjIYHrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:47:31 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059EFFB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:47:23 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-401187f8071so39516315e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695628042; x=1696232842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DF70GKTjx6OLz0gFCNQLYyT2r+1t8lkHa2HhGDhuGTc=;
        b=hH8gFqZOWsojPUw1Tjmrk6tsefZj7JMeYJJIH0rK5JkNn0N4LBht/rIJBU5IFwT7Vr
         QQ8fPBFK59pYfKyRxNXuenXx0+7wsMeQcJgzXRZJ1hSgC6Cdj/Bw79oBtpOVG9Kli4F/
         JAvq7Ki+SDrqQFMUn5hIwyTz6wfpJHs2tljWED2R2LZ8C02tDda+GrM5TQ5f2nPSwoZK
         5yeMxD6h3Cg1Z0GQ4E6INB0n1KXX2QiGv6fS+DJSvVMKIbCvaIDf5J5LV+6Q8IogWUNO
         F2T+VkgitHPf/HWraqb+Ai2rKarFudGPvIDYeFW4BeDUVP1pwNXvZugShmIZq3VtVlJ/
         HVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695628042; x=1696232842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DF70GKTjx6OLz0gFCNQLYyT2r+1t8lkHa2HhGDhuGTc=;
        b=EMrUgA31ewrP1nmvgV+kEh0reHZP8TKpfhL+T20i+jxqlOlrMVTB3MaIMgb1rCkoY0
         YPAqppXDkeBke4KhRP/zstwfOXLHDCtyj25I61+KTD5DG9HPL4beWOGFmR8A1HHSXTwF
         L5ttELm8TFAkqo0yaCGq+aRpqJb0MVm+kaRyH5UCbzaHLTfKnNrEWArote1NNB+gMHf3
         UvKVmAv7NVluVlalFsNjgkcryswnYCUEQJpdIs3y9qJgeczEN0aI94yRofkRIaA2ou4N
         FClSLfhI1HXpvsoY360VNCJ2eCY7weVIXjFWW3tDsISQMfSEffWf2JGSpGyWc+TxALm3
         AE5Q==
X-Gm-Message-State: AOJu0YzEha1XN9ZyQ+sdtDzFiiC9CoMnDxOpQtTnxoePP8M6U8KOfC92
        s/v7PwmR2y3OPxoQORMo0BAOsg==
X-Google-Smtp-Source: AGHT+IFFYN1bv/ZG/uHXr8B5tLK175aKWONDiwgbeX6drpT5TaaaoFZ8hUkT0yfaRVtHZrnkUY4RpQ==
X-Received: by 2002:a1c:6a1a:0:b0:403:c70b:b688 with SMTP id f26-20020a1c6a1a000000b00403c70bb688mr4857963wmc.6.1695628042233;
        Mon, 25 Sep 2023 00:47:22 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:a927:1e5c:85b4:9da1? ([2a05:6e02:1041:c10:a927:1e5c:85b4:9da1])
        by smtp.googlemail.com with ESMTPSA id iw7-20020a05600c54c700b003fc16ee2864sm9882636wmb.48.2023.09.25.00.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 00:47:21 -0700 (PDT)
Message-ID: <883b0780-1f89-40a4-fbd0-a3d4845c2826@linaro.org>
Date:   Mon, 25 Sep 2023 09:47:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] thermal: imx8mm_thermal: Fix function pointer declaration
 by adding identifier name
Content-Language: en-US
To:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        rafael@kernel.org, rui.zhang@intel.com, amitk@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230917083443.3220-1-bragathemanick0908@gmail.com>
 <786d197a-a2b5-2507-f5d7-24e8224a3922@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <786d197a-a2b5-2507-f5d7-24e8224a3922@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2023 11:31, Bragatheswaran Manickavel wrote:
> 
> On 17/09/23 14:04, Bragatheswaran Manickavel wrote:
>> Added identifier names to respective definitions for fix
>> warnings reported by checkpatch.pl
>>
>> WARNING: function definition argument 'void *' should also have an 
>> identifier name
>> WARNING: function definition argument 'int *' should also have an 
>> identifier name
>> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
>> ---
>>   drivers/thermal/imx8mm_thermal.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/imx8mm_thermal.c 
>> b/drivers/thermal/imx8mm_thermal.c
>> index 14111ccf6e4c..5dc6c18f12df 100644
>> --- a/drivers/thermal/imx8mm_thermal.c
>> +++ b/drivers/thermal/imx8mm_thermal.c
>> @@ -78,7 +78,7 @@
>>   struct thermal_soc_data {
>>       u32 num_sensors;
>>       u32 version;
>> -    int (*get_temp)(void *, int *);
>> +    int (*get_temp)(void *data, int *temp);
>>   };
>>   struct tmu_sensor {
> 
> Hi Team, Could someone help in reviewing it.

Please no more "gentle reminder"

Read:

https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/Documentation/process/submitting-patches.rst

Especially, the section _9_

Thanks

    -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

