Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458397A0D80
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbjINSvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241925AbjINSvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:51:15 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6288B55BC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 11:46:25 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-404573e6c8fso10709465e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 11:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694717184; x=1695321984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kIZovquInIL74DbQjfgBZgPlunuh9zGf95Z8S/ooNDg=;
        b=QYHZqaNpezYBGk6OGK3K6m4VbH7SfnULqezfHtDvf7PB91oxxo1l2DDfY+/WWYqK8n
         6mfLwZ3sOx29Y5ezx//R3tocP9wvcDGk6+fT11e2PcHepox1cw3ZJGaguRpIUs+8GUfO
         7PeugPV3kwrp3TbmObDXlQN/98f3KQaKPFNKRAzsXqJNEGCmUJ1av0wr4aFLMDeXhjCf
         G6HloF/jhuocXimEvYWhPg5TfuNMLK7dZMyF6HMqno9nDLwY29BA7vGHC4UKP7qaZIN6
         3GQKhRvY1OHG+tZRrlsGdE0jeWEgrGDqG6TWGQqzu35znyYBWb+cRXf5H7IwBGJSa462
         WBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694717184; x=1695321984;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kIZovquInIL74DbQjfgBZgPlunuh9zGf95Z8S/ooNDg=;
        b=WOTpCY2xSLgN/GOmKHIkwmbQpw5XoQqJXmYO+AiXAibGXmR5UB8rCbUvEYMs8D7HsZ
         MuVKp/LiabQwYYA660cbp1CCflMV+oCx9N3MNmKJh/ma7Bq3rc4ycK4m3rTtUH7N6GE8
         jb3tywulvGLcPX1IpMQSFRiU1QE7NS1BC2VXxmoMcNiSMqEFL5qJzUFDHwauG1xIvqCi
         S8gSDgqT63DVp41uqZIPb4V9RF1ssug1T79vdQ9S3zQwFVlimPF5vEeN9mqK0EZ2spY5
         6US7uVktwYLpOsaaEusNC4SDN0tZS14rg+rwl7phToPdH8Ihwa+k4yNVB9lSwHe5s1a5
         dm9A==
X-Gm-Message-State: AOJu0YzS0fUMmAakWgDV7zAtrK0RlxORY5iIXHg8mDzvEVwvlYjU0xCb
        K017UM31YBTJLQu7gF8aFpdvLg==
X-Google-Smtp-Source: AGHT+IHepuPWdsuiYR2oi1IwB/1DPQW73hMmiXEXagum6xwLJRh7Tnno1d2aZCEgN4NgYG4HRn/k/w==
X-Received: by 2002:adf:f981:0:b0:319:8430:f80f with SMTP id f1-20020adff981000000b003198430f80fmr5343316wrr.49.1694717183627;
        Thu, 14 Sep 2023 11:46:23 -0700 (PDT)
Received: from [192.168.37.232] (178235177003.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.3])
        by smtp.gmail.com with ESMTPSA id g8-20020a50ee08000000b00521d2f7459fsm1232748eds.49.2023.09.14.11.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 11:46:23 -0700 (PDT)
Message-ID: <36287e2f-ddff-4323-bbc2-e7a07a9283e7@linaro.org>
Date:   Thu, 14 Sep 2023 20:46:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 3/3] power: supply: Introduce MM8013 fuel gauge
 driver
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230621-topic-mm8013-v2-0-9f1b41f4bc06@linaro.org>
 <20230621-topic-mm8013-v2-3-9f1b41f4bc06@linaro.org>
 <20230913154552.okinfq6gdxf2d7ab@mercury.elektranox.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230913154552.okinfq6gdxf2d7ab@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.09.2023 17:45, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Aug 23, 2023 at 04:36:15PM +0200, Konrad Dybcio wrote:
>> Add a driver for the Mitsumi MM8013 fuel gauge. The driver is a vastly
>> cleaned up and improved version of the one that shipped in some obscure
>> Lenovo downstream kernel [1], with some register definitions borrowed from
>> ChromeOS EC platform code [2].
>>
>> [1] https://github.com/adazem009/kernel_lenovo_bengal/commit/b6b346427a871715709bd22aae449b9383f3b66b
>> [2] https://chromium.googlesource.com/chromiumos/platform/ec/+/master/driver/battery/mm8013.h
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
[...]

> 
> Please use regmap.
Ack

[...]

>> +	switch (psp) {
>> +	case POWER_SUPPLY_PROP_CAPACITY:
> 
> this is in %, while the next two are in uAh. So the fuel gauge does
> not provide the current capacity in uAh
> (POWER_SUPPLY_PROP_CHARGE_NOW)?
Yes. Doesn't seem like raw values are supported.

[...]

> 
> this is just 'val->intval = (s16) ret;'.
> 
>> +		val->intval *= -1000;
Ack

> 
> and this seems to be the only property, that properly scales its
> values, assuming the hardware reports data in mA.
> 

[...]

> 
> that's in **micro** volts
Oh, I didn't read enough docs..

> 
>> +		ret = mm8013_read_reg(client, REG_VOLTAGE);
> 
> this effectively does i2c_smbus_read_word_data() and thus the
> maximum is is 65536. 65536uV = 65mV. I have serious doubts, that
> this code does what you want. The same is true for a couple of
> the other properties.
Ack

[...]

> With the next submission please include a dump of the uevent
> in sysfs in the cover letter or below the fold, so that its
> easy to validty check if the reported values look sensible.
State of what-will-be-sent in v(n+1), with additional fixups:

POWER_SUPPLY_NAME=mm8013
POWER_SUPPLY_TYPE=Battery
POWER_SUPPLY_CAPACITY=100
POWER_SUPPLY_CHARGE_FULL=7124
POWER_SUPPLY_CHARGE_FULL_DESIGN=7500
POWER_SUPPLY_CURRENT_NOW=-122000
POWER_SUPPLY_CYCLE_COUNT=27
POWER_SUPPLY_HEALTH=Good
POWER_SUPPLY_PRESENT=1
POWER_SUPPLY_STATUS=Full
POWER_SUPPLY_TEMP=324
POWER_SUPPLY_VOLTAGE_NOW=4407000


> 
> Thanks and sorry for the slow processing,
No worries

Konrad
