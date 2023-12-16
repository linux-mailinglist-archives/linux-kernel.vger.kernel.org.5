Return-Path: <linux-kernel+bounces-2236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C050815A08
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFECA1C21656
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 15:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444CC14A85;
	Sat, 16 Dec 2023 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apmS61H7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80FC30108;
	Sat, 16 Dec 2023 15:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dbd1c2cbd79so68964276.2;
        Sat, 16 Dec 2023 07:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702741820; x=1703346620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=moYfas2L5mUo3NzusYW2YBdg+K9nUrua7NkeCjUxDJg=;
        b=apmS61H7yGRFxfLNN6fOL5S0kx5e88IpAljxAhOkad/quZapxfpQCA35RtZBEVNd7q
         jWR7kghRSfUFaSB0EMUbVnuHNq05NwyOorXGUb7UDy+thYEbLce5FVOlUJy6L81saNjk
         y/OsU/RpgbMqxwd8O2d+eF+9Oq/KO0tuJdcT8t8VmtLXyNaENOtRGu9ZyLhQzZXORRJ4
         WEQZEYsGc4UFa9yRX+HeDmMDWNqk6/QXfgBcTgUiDsNZP4cZde5GAmSpazacFk4z1muD
         Nt9TBxqCV0xqBm+GQT6La0NsaXD+pkLVAn+PJaj8nXMpvxLlEmguRAY7vTi9u76CeY2o
         93vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702741820; x=1703346620;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=moYfas2L5mUo3NzusYW2YBdg+K9nUrua7NkeCjUxDJg=;
        b=w7KMV8mF792AuwmHnDjnvJSqxYGxkvy8fvpodqLEj0Nyq80JS7jiJ/BLWW3QKCbBtY
         XRx5qrdarAQvI8ONZ7KlZMkI9CMJqWwDh6CmKHOLgyFOj4wY9i9Ls5mrxkdW+A15/5WD
         WYMTMDu83bOHr6+pWonl5/O+o06SwSBEW1XXBnwR8gd/1Ehsibic8sWS/ESZgHkQe01c
         vBbnnWEAFPeqnDFqXNWpyXX57CF3iPRpO8nxgXANuJ1VHsuhk7FWq/X0+3EBub+3NnlY
         aqCmkCPSgIAHM0sTzkTcHJwaMvcP+aKfPomTFHEu/Qi+HTWK8yXmnedQUHJuBtDBI83l
         3Lbw==
X-Gm-Message-State: AOJu0YwYNlY5uwmDgGTmn11QOt0Y7xPMRs/QZt0SYRlMQLnGUFZT8Jk0
	qoMeBDyYA0PChqHLSA4UDJQ=
X-Google-Smtp-Source: AGHT+IGUIQx7aXDa27rMHZvWcO2FnAmjzfJnoIp3WcF2GB3n4NucOZSWiSJxp+6NCaH5ZMn11bcf8g==
X-Received: by 2002:a25:e64b:0:b0:dbc:e097:6bc with SMTP id d72-20020a25e64b000000b00dbce09706bcmr2748826ybh.63.1702741820402;
        Sat, 16 Dec 2023 07:50:20 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o15-20020a056902010f00b00d8679407796sm6177404ybh.48.2023.12.16.07.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 07:50:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <403186ba-1caa-46f4-8550-0aae375bb2e8@roeck-us.net>
Date: Sat, 16 Dec 2023 07:50:17 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: reset: msm: Process register_restart_handler()
 error
Content-Language: en-US
To: Mukesh Ojha <quic_mojha@quicinc.com>,
 Nikita Kiryushin <kiryushin@ancud.ru>, Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Sebastian Reichel
 <sre@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>,
 Pramod Gurav <pramod.gurav@smartplayin.com>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <feeb1a89-59bd-4fd6-81a5-1d828f95b0f0@ancud.ru>
 <89ca6eb2-9a33-c37e-14ae-6181edb8626c@quicinc.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <89ca6eb2-9a33-c37e-14ae-6181edb8626c@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/16/23 00:15, Mukesh Ojha wrote:
> 
> 
> On 11/8/2023 10:57 PM, Nikita Kiryushin wrote:
>> If registering restart handler fails for msm-restart result is not checked.
>> It may be irrelevant now (as stated in comment to register_restart_handler,
>> the function currently always returns zero), but if the behavior changes
>> in the future, an error at registration of handler will be silently skipped.
>>
>> Add return error code and print error message too debug log in case of
>> non-zero result of register_restart_handler.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: 18a702e0de98 ("power: reset: use restart_notifier mechanism for msm-poweroff")
>>
>> Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
>> ---
>>   drivers/power/reset/msm-poweroff.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/power/reset/msm-poweroff.c b/drivers/power/reset/msm-poweroff.c
>> index b9a401bd280b..5877a1ba2778 100644
>> --- a/drivers/power/reset/msm-poweroff.c
>> +++ b/drivers/power/reset/msm-poweroff.c
>> @@ -35,11 +35,16 @@ static void do_msm_poweroff(void)
>>    static int msm_restart_probe(struct platform_device *pdev)
>>   {
>> +    int ret = -EINVAL;
> 
> This does not add up anything., no need to initialize.
> 
> -Mukesh
> 
> 
>>       msm_ps_hold = devm_platform_ioremap_resource(pdev, 0);
>>       if (IS_ERR(msm_ps_hold))
>>           return PTR_ERR(msm_ps_hold);
>>   -    register_restart_handler(&restart_nb);
>> +    ret = register_restart_handler(&restart_nb);

FWIW, checking this return value really do anything good either. The only possible
return value is -EEXIST, which would be returned if the restart handler was already
registered, and that can not really happen. On top of that, _if_ that happened,
the notifier core would dump a warning traceback, making the error message below
unnecessary.

>> +    if (ret) {
>> +        dev_err(&pdev->dev, "unable to register restart handler, %d\n", ret);
>> +        return ret;

On top of all the above, not registering the poweroff andler in the already
impossible case that the restart handler can not be registered seems like an
excessively bad idea to me.

Guenter

>> +    }
>>        pm_power_off = do_msm_poweroff;
>>   -- 2.34.1
>>


