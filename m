Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4686277DC9E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243033AbjHPIpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243037AbjHPIoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:44:37 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D074926A1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:44:35 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe2ba3e260so61496705e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692175474; x=1692780274;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xe/UwXa7u0CWcjyoh0v35FKyr6fZ9x/+oxwDuoHVhQ0=;
        b=xw5v4qIFM/M/24ziFWbPQFmjO8TjY+ux+Do1XjzQ4S8Z9HoTnwipgQUXgVfunzJMdu
         hrDRyelb9VxTDtjuEkIcH1QqOhIpv32ypN0A/o1xs/9bzq/ntLWQdVGBcl5qc/G6JtKV
         EhHlQ1O+GYyrstcBEkdq+OmwBG0wDKAhvOXhbrendaj1Ra1qlL/5isQDFM6coMz7+Z8q
         DwljMHgsCzuOGay31qbzFwTWRrx4cAUsudHr73TsGq8tv7oIy76YIrnWvH5VrVLhVjTJ
         Qi4X6Sd/2ry5jKs0gXV23UVRTlSI4u3VyJ/UHXmE1iTkCDfyYo+aY2TuljoRNxBNXhaq
         jLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692175474; x=1692780274;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xe/UwXa7u0CWcjyoh0v35FKyr6fZ9x/+oxwDuoHVhQ0=;
        b=fi30lbxnT68Txj9LufTIxAvDg8Tq32oBA/WqY10k/WlIx0vQD024k14LwAMN2Rmjql
         u5CnlFwS/PeW8DoFUNyf77myjWwQDBaMgFZT8JYHvbH2AwwbNYa1L+PIXVQnZnXQSU9j
         qXm1ePexpBTRCQkhUO9inKulK6UMdM8zrpWvBFgVLMNNcpIvV1O5dJzuwGNlTRYJHMo5
         4jFpKTAzUeSElKTZONYXfVL5Xcx7wejLuTXU9awVi07PnPjEtbZpeCR4XaE8z9YDbR40
         Lfx4vId/GHGGdHlNXo4b28iL0+oGCVp6viuwEOHJH+UqT803Az0hAs3tdlbwJAJdcbrq
         7EEg==
X-Gm-Message-State: AOJu0YzWM5IXWRDCB5gQX5s6LX1sWPwnUcl0imOg8Evju3hd/ch1nHVU
        705+6xzQcXI4QtlqdLErbyI1kM5u8HEqposC9r4=
X-Google-Smtp-Source: AGHT+IG4lzGhTLI0TTDkdQGMuT6y2+MKtgzOPm0u6FrXMl4H1IFTQBkgLQzFztfEMh2FPQy9L12vrQ==
X-Received: by 2002:a1c:750a:0:b0:3fe:1af6:6542 with SMTP id o10-20020a1c750a000000b003fe1af66542mr865969wmc.33.1692175474218;
        Wed, 16 Aug 2023 01:44:34 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id x16-20020a05600c2a5000b003fe13c3ece7sm23279148wme.10.2023.08.16.01.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 01:44:33 -0700 (PDT)
Message-ID: <7eacc4da-ab14-3df5-2864-44a7262bac27@linaro.org>
Date:   Wed, 16 Aug 2023 10:44:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] thermal/drivers/imx_sc_thermal: return -EAGAIN when
 SCFW turn off resource
Content-Language: en-US
To:     Frank Li <Frank.li@nxp.com>
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
        open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20230712210505.1536416-1-Frank.Li@nxp.com>
 <f1d4ed62-8d01-173f-6e41-4671228782fd@linaro.org>
 <ZLGDhOffQwh7xW/n@lizhi-Precision-Tower-5810>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ZLGDhOffQwh7xW/n@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Frank,

sorry for the delay

On 14/07/2023 19:19, Frank Li wrote:
> On Thu, Jul 13, 2023 at 02:49:54PM +0200, Daniel Lezcano wrote:
>> On 12/07/2023 23:05, Frank Li wrote:
>>> Avoid endless print following message when SCFW turns off resource.
>>>    [ 1818.342337] thermal thermal_zone0: failed to read out thermal zone (-1)
>>>
>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>> ---
>>>    drivers/thermal/imx_sc_thermal.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
>>> index 8d6b4ef23746..0533d58f199f 100644
>>> --- a/drivers/thermal/imx_sc_thermal.c
>>> +++ b/drivers/thermal/imx_sc_thermal.c
>>> @@ -58,7 +58,9 @@ static int imx_sc_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
>>>    	hdr->size = 2;
>>>    	ret = imx_scu_call_rpc(thermal_ipc_handle, &msg, true);
>>> -	if (ret)
>>> +	if (ret == -EPERM) /* NO POWER */
>>> +		return -EAGAIN;
>>
>> Isn't there a chain call somewhere when the resource is turned off, so the
>> thermal zone can be disabled?
> 
> A possible place in drivers/firmware/imx/scu-pd.c. but I am not sure how to
> get thermal devices. I just found a API thermal_zone_get_zone_by_name(). I
> am not sure if it is good to depend on "name", which add coupling between
> two drivers and if there are external thermal devices(such as) has the
> same name, it will wrong turn off.

Correct

> If add power domain notification in thermal driver, I am not how to get
> other devices's pd in thermal driver.
> 
> Any example I can refer?
> 
> Or this is simple enough solution.

The solution works for removing the error message but it does not solve 
the root cause of the issue. The thermal zone keeps monitoring while the 
sensor is down.

So the question is why the sensor is shut down if it is in use?



>>
>>> +	else if (ret)
>>>    		return ret;
>>>    	*temp = msg.data.resp.celsius * 1000 + msg.data.resp.tenths * 100;
>>
>> -- 
>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

