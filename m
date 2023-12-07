Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA2E80926D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443904AbjLGUfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbjLGUfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:35:05 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4FE171C;
        Thu,  7 Dec 2023 12:35:03 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c2718a768so13996305e9.0;
        Thu, 07 Dec 2023 12:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701981302; x=1702586102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GSDMwDwuR5idPA4yAqUVjkE38lvDI/clGFKdPtgI5Ao=;
        b=hSTGjmM5V7ARJkE+xO86aRZjuIiNKG8Oa36foC9lTcR820xqFLgoISy4ER2fh3l+y8
         UCxiiqi3eN69XhurugL9BZaBbYYvsJmmfCsnQuYtInSL4bDPjJa0xS3pP3dObhEqGDQD
         7xX7o/tquBMWtoq1Rw4FBVh0T49l0w4piG+IS3Uo3njAp/hOdHCUATHIuoBGBPWx1aw5
         czWJ1mFncHm3tvTi6+73MPGnldYkFrt3uVnCdvGXfX3X6aAQAR2ReVjqzwOvhnUktsEm
         4Ifl4Z8mr22o433C4lIPodyiw7El9zJRsXaTMqLDe4xPhYh1N1rR/lKZMlLC119whSFf
         NoVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701981302; x=1702586102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GSDMwDwuR5idPA4yAqUVjkE38lvDI/clGFKdPtgI5Ao=;
        b=bGk9Bm5B6gSUiLks0sJQzp83C+Kiq9Zss8dp4Py4456wf1cD9ftbsgZISu+Obgn4Sd
         koJKQxkqz8DpwFLl7l8CodmAsTBOYa/d2MuVe5tjwWY9D81u3J5zbHcZibeScUE02wdN
         m4BZe3QBSdolIxWwsqi16ZtswFpzuF0ybpsit+YDNHt1ueLvEAbdEcqDDJ3P2wKCD84t
         NO73HWHvlGwG8JVy/FS+TBYxpRiI71xC/Wx3lNJEpAHcKSxQT4LW7njw8yNx+vcg03s0
         KsO7wR3QNLvMJJMM4edITsqIE09ar9mhw0Q6nZA3Fu1U8rcMQksm0w67pJyq0hZD2PmR
         88IQ==
X-Gm-Message-State: AOJu0YybnJEbEsYYRdP1bm+MHWeymhZBtf4deneLdJgCK0JOf3NGunK9
        DFsUET0rrtbFYAUk8bA6zXI=
X-Google-Smtp-Source: AGHT+IFsY0uVZUeLGUIGhIhqlu+QFmzoZPGoy6xXNQq6DfeECVKZ8fqAbkAL3rcCWHG3neVjjNFw0g==
X-Received: by 2002:a7b:cbc6:0:b0:40b:5e22:98e with SMTP id n6-20020a7bcbc6000000b0040b5e22098emr2269971wmi.125.1701981301642;
        Thu, 07 Dec 2023 12:35:01 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:18e7:4dee:8ee0:df02? (2a02-8389-41cf-e200-18e7-4dee-8ee0-df02.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:18e7:4dee:8ee0:df02])
        by smtp.gmail.com with ESMTPSA id u21-20020a05600c139500b00405d9a950a2sm2964254wmf.28.2023.12.07.12.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 12:35:01 -0800 (PST)
Message-ID: <5b62afcb-254d-4dfc-8332-7979c62ea2c2@gmail.com>
Date:   Thu, 7 Dec 2023 21:34:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] hwmon: Add support for Amphenol ChipCap 2
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20231020-topic-chipcap2-v3-0-5b3bb50a5f0b@gmail.com>
 <20231020-topic-chipcap2-v3-5-5b3bb50a5f0b@gmail.com>
 <04475f91-bdce-4677-894c-74c2bb8233d9@sirena.org.uk>
Content-Language: en-US
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <04475f91-bdce-4677-894c-74c2bb8233d9@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.12.23 21:05, Mark Brown wrote:
> On Thu, Dec 07, 2023 at 08:44:55PM +0100, Javier Carrasco wrote:
> 
>> +       if (regulator_is_enabled(data->regulator)) {
>> +               ret = regulator_disable(data->regulator);
>> +               if (ret < 0)
>> +                       return ret;
>> +
>> +               msleep(CC2_POWER_CYCLE_MS); /* ensure a clean power cycle */
>> +       }
>> +
>> +       ret = regulator_enable(data->regulator);
>> +       if (ret < 0)
>> +               return ret;
> 
> This is very buggy.  A consumer should only disable a regulator if it
> itself enabled that regulator (or it *requires* an exclusive regulator
> which isn't a good fit here), and there's no guarantee that disabling a
> regulator will actually result in a power off.  Either the board might
> not physically or through constraints permit the state to change or
> another user may have enabled the regulator.  The driver needs to keep
> track of if it enabled the regulator and only disable it as many times
> as it enabled it.
The idea is actually that if alarms are required, an exclusive regulator
will be necessary to trigger power cycles and enter the command mode.

In summary there would be two options: either a regulator is defined and
can be controlled to trigger the command mode or no regulator was
defined for this device and therefore no command mode is available i.e.
interrupts cannot be configured. That would be the case for example when
the supply is always on.
> 
> For this usage with trying to bounce the power of the regulator you can
> keep track of the actual power state of the supply by listening to
> notifications, and should possibly just keep the regulator disabled when
> it's not actively in use (if no alarm is active or measurement in
> progress?).
> 
>> +	data->regulator = devm_regulator_get_optional(dev, "vdd");
> 
> Does the device *really* work without power?  The datasheet appears to
> suggest that the device has a non-optional supply Vdd
> 
>    https://f.hubspotusercontent40.net/hubfs/9035299/Documents/AAS-916-127J-Telaire-ChipCap2-022118-web.pdf
> 
The vdd is a non-optional supply and the device cannot run without it.
What is optional is the controllable regulator to enter the command
window. Hence why I used _optional() functions.

I could ban any use without a controllable regulator to make things
simpler, but if no alarms are required, the device should work fine
without command mode. Either way the driver must have some control over
a regulator for the mentioned command window.
> (there's also a Vcore pin but that appears to be for connecting a
> decoupling capacitor rather than a supply).
> 
> In general _optional() should only be used for supplies which may be
> physically absentIn the end I need a way to control a regulator to enter in command mode,
but still offering measurement functionality if there is no regulator to
control.
The current approach is that there must be a supply, but the regulator
might be controllable or not.

Thank you for your feedback and best regards,
Javier Carrasco
