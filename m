Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CEE77EAFA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346237AbjHPUqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346245AbjHPUqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:46:04 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD28D1FCE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:46:01 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3198d2745feso1295611f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692218760; x=1692823560;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TkXb2WGp3h74munhQBcxJdaPjXLiOtVi3bcX2GvRbiM=;
        b=LnidPeWZ68hHT3vmVcrWLwEKcFkq4CDLvdUzfp+NwBdRsr9XftyyY8sjU5NiqaEzyx
         JtjKantdFtlrT1PmvexQZIm8pfBY9kYjLtnhOnvVlwNLbPKKZksZly9mmsZxYQrahmWf
         PdwrmHNfKwY4crutRgaYeGUCH/Wd+uW2V5/4uJk8fULsAb1vPg6v9MxHuCDuGZ9JCW+i
         XBcvpY8OJSiAUU/y767JR9wWz99jKRFR2HJu/XT1P8NGNlNpavXRY8XkxZvYgl6ThLkG
         BnNFEdhTj1JWmtKH5AuFzd7248fjW0pRn57++uI2elg/nkNzKQKJm5E3D3tjPpahwmEA
         DmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692218760; x=1692823560;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TkXb2WGp3h74munhQBcxJdaPjXLiOtVi3bcX2GvRbiM=;
        b=dxVuHjoT3nh0KE4uhhMO2ojvBZ6/sOOTu7FTtkAn5a57CEc5xQAdA5rDZS+3UWN3ba
         /nAd2HnDOGvKE60ppi75QzC8S3qJdL2Mide9ylnwuQFTMilKpJzh7OAMlU2tXMmTvK+4
         AkXuUnwN4OCVS6o7jOdvtYGLvPL8Zv1VSAPSyno70BMjnlv8Gjp4cqou9D/E8m6pOcov
         4089Wai5pcD59jZp3WaEiHT2gP4Iu+sJpg4zKJEb748tuexTu9NKD8y0pqzFafWExpbp
         TKye2qD+n2woMlZ69MhUxJj+Bb+lZRGuxcpSgSAiXUx+F1K6l10r/mKMQqyxVhpqBqZH
         DpSg==
X-Gm-Message-State: AOJu0Ywmlf/+6istUycn4YlES2woXFFQ9k98Qdnbn95+9r7FR7FQQ+9J
        kWBTsmv4J3bWzBApbsZsWjSJLw==
X-Google-Smtp-Source: AGHT+IESQMA85nb+JSfmJKhTWpUYk+N9FpiLZfwfyUrSPcDBPNyxrQUaYqAZtwGjVEqX1pP5dYPRPQ==
X-Received: by 2002:a5d:444b:0:b0:317:5f04:c3de with SMTP id x11-20020a5d444b000000b003175f04c3demr1871081wrr.4.1692218760145;
        Wed, 16 Aug 2023 13:46:00 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id x4-20020a5d4904000000b003143801f8d8sm22450450wrq.103.2023.08.16.13.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 13:45:59 -0700 (PDT)
Message-ID: <80324fb7-3d2a-ecd3-f1ca-9745a366eb0a@linaro.org>
Date:   Wed, 16 Aug 2023 22:45:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] thermal/drivers/imx_sc_thermal: return -EAGAIN when
 SCFW turn off resource
Content-Language: en-US
To:     Frank Li <Frank.li@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
References: <20230712210505.1536416-1-Frank.Li@nxp.com>
 <f1d4ed62-8d01-173f-6e41-4671228782fd@linaro.org>
 <ZLGDhOffQwh7xW/n@lizhi-Precision-Tower-5810>
 <7eacc4da-ab14-3df5-2864-44a7262bac27@linaro.org>
 <ZNz5Drb+EVLjWxRV@lizhi-Precision-Tower-5810>
 <dd42952c-4dea-ea57-7ad2-73fa159d265d@linaro.org>
 <ZN0CVa9or/FltHJM@lizhi-Precision-Tower-5810>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ZN0CVa9or/FltHJM@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2023 19:07, Frank Li wrote:
> On Wed, Aug 16, 2023 at 06:47:17PM +0200, Daniel Lezcano wrote:
>> On 16/08/2023 18:28, Frank Li wrote:
>>> On Wed, Aug 16, 2023 at 10:44:32AM +0200, Daniel Lezcano wrote:
>>>>
>>>> Hi Frank,
>>>>
>>>> sorry for the delay
>>>>
>>>> On 14/07/2023 19:19, Frank Li wrote:
>>>>> On Thu, Jul 13, 2023 at 02:49:54PM +0200, Daniel Lezcano wrote:
>>>>>> On 12/07/2023 23:05, Frank Li wrote:
>>>>>>> Avoid endless print following message when SCFW turns off resource.
>>>>>>>      [ 1818.342337] thermal thermal_zone0: failed to read out thermal zone (-1)
>>>>>>>
>>>>>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>>>>>> ---
>>>>>>>      drivers/thermal/imx_sc_thermal.c | 4 +++-
>>>>>>>      1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
>>>>>>> index 8d6b4ef23746..0533d58f199f 100644
>>>>>>> --- a/drivers/thermal/imx_sc_thermal.c
>>>>>>> +++ b/drivers/thermal/imx_sc_thermal.c
>>>>>>> @@ -58,7 +58,9 @@ static int imx_sc_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
>>>>>>>      	hdr->size = 2;
>>>>>>>      	ret = imx_scu_call_rpc(thermal_ipc_handle, &msg, true);
>>>>>>> -	if (ret)
>>>>>>> +	if (ret == -EPERM) /* NO POWER */
>>>>>>> +		return -EAGAIN;
>>>>>>
>>>>>> Isn't there a chain call somewhere when the resource is turned off, so the
>>>>>> thermal zone can be disabled?
>>>>>
>>>>> A possible place in drivers/firmware/imx/scu-pd.c. but I am not sure how to
>>>>> get thermal devices. I just found a API thermal_zone_get_zone_by_name(). I
>>>>> am not sure if it is good to depend on "name", which add coupling between
>>>>> two drivers and if there are external thermal devices(such as) has the
>>>>> same name, it will wrong turn off.
>>>>
>>>> Correct
>>>>
>>>>> If add power domain notification in thermal driver, I am not how to get
>>>>> other devices's pd in thermal driver.
>>>>>
>>>>> Any example I can refer?
>>>>>
>>>>> Or this is simple enough solution.
>>>>
>>>> The solution works for removing the error message but it does not solve the
>>>> root cause of the issue. The thermal zone keeps monitoring while the sensor
>>>> is down.
>>>>
>>>> So the question is why the sensor is shut down if it is in use?
>>>
>>> Do you know if there are any code I reference? I supposed it is quite common.
>>
>> Sorry, I don't get your comment
>>
>> What I meant is why is the sensor turned off if it is in use ?
> 
> One typical example is cpu hotplug. The sensor is located CPU power domain.
> If CPU hotplug off,  CPU power domain will be turn off.
> 
> It doesn't make sensor keep monitor such sensor when CPU already power off.
> It doesn't make sensor to keep CPU power on just because want to get sensor
> data.
> 
> Anthor example is GPU, if there are GPU0 and GPU1. Most case just GPU0
> work.  GPU1 may turn off when less loading.
> 
> Ideally, thermal can get notification from power domain driver.
> when such power domain turn off,  disable thermal zone.
> 
> So far, I have not idea how to do that.

Ulf,

do you have a guidance to link the thermal zone and the power domain in 
order to get a poweron/off notification leading to enable/disable the 
thermal zone ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

