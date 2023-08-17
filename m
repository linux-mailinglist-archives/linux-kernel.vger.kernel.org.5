Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E47477FAA6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353177AbjHQPWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353266AbjHQPWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:22:46 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE513AA0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 08:22:18 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe8242fc4dso69510015e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 08:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692285736; x=1692890536;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N+m+PTw0k6AC8rmqKYLCDM9O9JDb4NfevxZn8zh7yzg=;
        b=DujAfsTIBytRQvSe7wUMxeQAWhB8J8q4GMWCEd6aq1KuZuR1vyJjvAFnEFU5C1RbWo
         coJvnnGga2H9mxqr4jbS6ugRQdWi0oXkVU7xIJKOa5EQai32yWIs8vUGSn8VrTH2eG9C
         ZhuiATj+KO1aho6UdtHbgx6OVt91iVHCVbh3c5gISwJvYtYwg4VwbNtlwToR6EyYh2UW
         goWndmKC5SHgs4hLpoOFKpbhngQmPq7yQjXrReHHjzDIywskylFoPN+UlhB7hQLxOAgr
         PfsfaDWtVTe2hESt9rwE8QzpqaU002LTDqHskQiXKAEIlKk1GerPeruOpwdM2yt/Zgon
         efGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692285736; x=1692890536;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N+m+PTw0k6AC8rmqKYLCDM9O9JDb4NfevxZn8zh7yzg=;
        b=Vkm1X5qncoQyYn8CcfArF8a78NNsGOH8cEZi3h95IjgSwWO3vRFGZ/zVRm1jv7PSLX
         ZRfMBK5TGyMzbQtbtwsgZC6CA3kzXD1h+3nWJQ2GeH/dR50xAdvDrfCDz5LvacGw1iDv
         NtPeMHMVTmtM/FO9hcoqyEY2tR4jFcNCzm5hCT7ZuzHE03Hm2Rc/8tyiJHi84CMFhHus
         MGJbNsQfqDaZcA/uVP72gIuxA62DJDj1SehRofenHWQXSTBMhTzstNincsddfs2WcR4I
         jD+Zc42NLhc63FOmaxw3vQHZuVzKmoi62qqFtOGg6hFe+1Y1++HArv+FAP3I008pCVZR
         TVtw==
X-Gm-Message-State: AOJu0Yx1EZeU+HsmsfQtf+a2JmEZD1AeQKKdTyAn7qIOfSTe/telrusv
        YYDAo7dOmwDbgO7gN0syilGLlQ==
X-Google-Smtp-Source: AGHT+IF5/0EH0rrwS5mRtnXkgEWcUUJYw6UaJ8JOTi2YZGRv05ycxeO+0VwPyIb9mw06hKSiDZV2Ew==
X-Received: by 2002:a05:600c:234a:b0:3fe:2120:a87a with SMTP id 10-20020a05600c234a00b003fe2120a87amr27260wmq.37.1692285735728;
        Thu, 17 Aug 2023 08:22:15 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id w17-20020adfee51000000b00317eee26bf0sm25088797wro.69.2023.08.17.08.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 08:22:15 -0700 (PDT)
Message-ID: <483b71f6-3812-81ad-a495-beda3f0bf034@linaro.org>
Date:   Thu, 17 Aug 2023 17:22:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] thermal/drivers/imx_sc_thermal: return -EAGAIN when
 SCFW turn off resource
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <frank.li@nxp.com>
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
 <80324fb7-3d2a-ecd3-f1ca-9745a366eb0a@linaro.org>
 <CAPDyKFp8-XwwHEt9dKeTMj0ZmoS6nzXrUYAFmpzZm16-Uf6=xw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAPDyKFp8-XwwHEt9dKeTMj0ZmoS6nzXrUYAFmpzZm16-Uf6=xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ulf,

thanks for your answer

On 16/08/2023 23:23, Ulf Hansson wrote:
> On Wed, 16 Aug 2023 at 22:46, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

[ ... ]

>>>>>>> If add power domain notification in thermal driver, I am not how to get
>>>>>>> other devices's pd in thermal driver.
>>>>>>>
>>>>>>> Any example I can refer?
>>>>>>>
>>>>>>> Or this is simple enough solution.
>>>>>>
>>>>>> The solution works for removing the error message but it does not solve the
>>>>>> root cause of the issue. The thermal zone keeps monitoring while the sensor
>>>>>> is down.
>>>>>>
>>>>>> So the question is why the sensor is shut down if it is in use?
>>>>>
>>>>> Do you know if there are any code I reference? I supposed it is quite common.
>>>>
>>>> Sorry, I don't get your comment
>>>>
>>>> What I meant is why is the sensor turned off if it is in use ?
>>>
>>> One typical example is cpu hotplug. The sensor is located CPU power domain.
>>> If CPU hotplug off,  CPU power domain will be turn off.
>>>
>>> It doesn't make sensor keep monitor such sensor when CPU already power off.
>>> It doesn't make sensor to keep CPU power on just because want to get sensor
>>> data.
>>>
>>> Anthor example is GPU, if there are GPU0 and GPU1. Most case just GPU0
>>> work.  GPU1 may turn off when less loading.
>>>
>>> Ideally, thermal can get notification from power domain driver.
>>> when such power domain turn off,  disable thermal zone.
>>>
>>> So far, I have not idea how to do that.
>>
>> Ulf,
>>
>> do you have a guidance to link the thermal zone and the power domain in
>> order to get a poweron/off notification leading to enable/disable the
>> thermal zone ?
> 
> I don't know the details here, so apologize for my ignorance to start
> with. What platform is this?

I will let Frank answer this

> A vague idea could be to hook up the thermal sensor to the
> corresponding CPU power domain. Assuming the CPU power domain is
> modelled as a genpd provider, then this allows the driver for the
> thermal sensor to register for power-on/off notifications of the genpd
> (see dev_pm_genpd_add_notifier()).
> 
> Can this work?

Yes indeed it sounds like what should be achieved. Assuming it is not 
modeled with genpd how would you describe those in order to have the 
sensor belonging to one specific power domain?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

