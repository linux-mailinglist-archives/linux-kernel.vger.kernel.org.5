Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2672775B72C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjGTSze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjGTSzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:55:32 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A00510FC;
        Thu, 20 Jul 2023 11:55:30 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbc0609cd6so9323045e9.1;
        Thu, 20 Jul 2023 11:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689879328; x=1690484128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IHAsFL2xFeH6dIbXrH4rs7Rw43cZEw/nHrY87+X9P8w=;
        b=M/Hy5wjGjpYdCaV1gWP14+9QhIcwCrD8LxTFGWxQ9ul9OqFRCJgsCnE6JYX5F7WU59
         wd2vnPhXAgtwiIrwVMYDI1Bd4OLhJCqt24GjD9nZe9Osb3usOaiJ2sM+i5+45aUJx/U6
         eXtBJxtsl8bEM6uK5+nugkR+J+ylFlG8UjcKGFbuJ5+rprMQ03DrpeVd/dlxG34JXHgd
         5rJZQ4bw94XXZEtBSTcu3H3om53PeP+Jea+ODKn/rhLbKBRe4lYWuEGh8cIhdOlk+6JA
         Vr+4OxxiM7OedgVNZ1grbr1fUoDkSzf6db7haCd1YK8vkHtl6/KZzOwzVaDCwzqAhpO8
         MyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689879328; x=1690484128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IHAsFL2xFeH6dIbXrH4rs7Rw43cZEw/nHrY87+X9P8w=;
        b=dObL9BeaisNkbgqcYuu42gh8qfasWSqXa7Cg5f9zotDQ0LbTZkm3MZfW0lgzvl86Yg
         LYLw/s/9MCIJyU4U/gj6I+itT32JicXxjxakIJ6Sh8dvJfyrtmy6iI8wk0C5W80dIIco
         ReiCOqZd2YzsMvEgpHr3t0irJfWjZ+/7EIPMqVcp9QNlc2RWeGP5BVMmdvHLrjbEoC2y
         f/8v8PhRJZdVViWro+tppt2FOH3CJiZ7LcR8nfarg4AyJwSJXqYM7ZNVeSRuI2yUhzZS
         XjOSaTgAcCoqoEQILXLUL86PI0S1ZxLkvEMAiNgVmPCi73iPvsKBGWHwsByD/p+d0MEd
         HHpw==
X-Gm-Message-State: ABy/qLYTstzJP2kWgD2a4guS8b5J+UYBauENe1T79Fl7yn1lt2sys3UL
        OtNgS0KudPyDhJSP5OCFKaQ=
X-Google-Smtp-Source: APBJJlGOeasb3e7RZk+f4OtzpsQtOBcpuUDgw8hLHWviGL9qQrid91/Lk+MdjyHWW52L3IRFkwJQ1g==
X-Received: by 2002:a7b:c3cd:0:b0:3fc:f9c:a3e9 with SMTP id t13-20020a7bc3cd000000b003fc0f9ca3e9mr4965128wmj.37.1689879328401;
        Thu, 20 Jul 2023 11:55:28 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id d15-20020a5d644f000000b003143c06135bsm2056400wrw.50.2023.07.20.11.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 11:55:28 -0700 (PDT)
Message-ID: <72c0359a-eda6-30ea-0ec0-b7e9b804b87b@gmail.com>
Date:   Thu, 20 Jul 2023 20:55:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] firmware: qcom_scm: Clear scm pointer on probe
 failure
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230528230351.168210-1-luzmaximilian@gmail.com>
 <20230528230351.168210-3-luzmaximilian@gmail.com>
 <ZJwXgqmu_zpV46lu@hovoldconsulting.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <ZJwXgqmu_zpV46lu@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First off, sorry again for the long delay and thanks for being patient
with me (and for the review of course). I'm finally getting back to
finding some time for Linux things again, so I think I've mostly settled
in by now.

On 6/28/23 13:20, Johan Hovold wrote:
> On Mon, May 29, 2023 at 01:03:49AM +0200, Maximilian Luz wrote:
>> When setting-up the IRQ goes wrong, the __scm pointer currently remains
>> set even though we fail to probe the driver successfully. Due to this,
>> access to __scm may go wrong since associated resources (clocks, ...)
>> have been released. Therefore, clear the __scm pointer when setting-up
>> the IRQ fails.
>>
>> Fixes: 6bf325992236 ("firmware: qcom: scm: Add wait-queue handling logic")
>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
>> ---
>>
>> Patch introduced in v4
>>
>> ---
>>   drivers/firmware/qcom_scm.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>> index fde33acd46b7..d0070b833889 100644
>> --- a/drivers/firmware/qcom_scm.c
>> +++ b/drivers/firmware/qcom_scm.c
>> @@ -1488,8 +1488,10 @@ static int qcom_scm_probe(struct platform_device *pdev)
>>   	} else {
>>   		ret = devm_request_threaded_irq(__scm->dev, irq, NULL, qcom_scm_irq_handler,
>>   						IRQF_ONESHOT, "qcom-scm", __scm);
>> -		if (ret < 0)
>> +		if (ret < 0) {
>> +			__scm = NULL;
> 
> This looks fragile at best. Clients use qcom_scm_is_available() to see
> if __scm is available and do not expect it to go away once it is live.

Hmm, you're right. The whole situation is probably not ideal and that
fix is really just a bad band-aid.

> It looks like you can hold off on initialising __scm until you've
> requested the interrupt, either by using IRQ_NOAUTOEN or fixing
> qcom_scm_waitq_wakeup() so that it doesn't use __scm directly.
> 
> That would also take care of the previous branch which may also leave
> __scm set after the structure itself has been released on errors.

Agreed.

> You'll have similar problems when registering qseecom which currently
> depend on __scm being set, though. Clearing the pointer in that case is
> clearly broken as you currently rely on devres for deregistering the aux
> clients on errors (i.e. the clients using __scm are still registered
> when you clear the pointer in patch 3/4).

Oh right, I hadn't thought of that. I'll have to rework that.

>>   			return dev_err_probe(scm->dev, ret, "Failed to request qcom-scm irq\n");
>> +		}
>>   	}
>>   
>>   	__get_convention();
> 
> Johan
