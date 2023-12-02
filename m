Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5917E801D85
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 16:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbjLBPmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 10:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjLBPmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 10:42:22 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DB9125;
        Sat,  2 Dec 2023 07:42:28 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b8958b32a2so1362233b6e.2;
        Sat, 02 Dec 2023 07:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701531748; x=1702136548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3+opO/o6H8X5h9YIqxOkFEYJFaw/tb3YgQ7SBUtQ9XM=;
        b=K2ydP6VIiO4PoaM+3j92Xbj0HS66XajiEs5mfIP3edmdP+Sl/akTkKSMQ13WNtbnqX
         ytN0s4Z7LUbv0R9VBh3EsBOe8QlkQP4b2ojtT8313KueFDxn05u3Pi7e3q7UMUvt8Qoi
         q8zPdfILrgBgu3Sy6pg/dCnYP/xWiDQ4n5ihhsWyX2Eix1Q5cjN76tVpiqfCJT6+5u+Y
         Zl8nyBYBTHFgfwkD/PMyrkqdaiGgrR74406NYuomBPdUSnWZsPkLRTH2/t+kxF1hmicu
         Ubp0g+NeDQf5/QuYNRBWo4SN+pV8epYn7lpKt2fpHzRW1sDWrIl76Y4nu1UeJhfEqwog
         wWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701531748; x=1702136548;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+opO/o6H8X5h9YIqxOkFEYJFaw/tb3YgQ7SBUtQ9XM=;
        b=CpSfQ3DvJbo+bnQUflRIvKfsHtllUSPMMX3lg1l4d4KDKXEHUkC2AM5rU7heGDEPWp
         SgGobsly4hZbVbQ3P9lwKkuxG9X0j5NG9YNhwDFK3Tp6sMzkxIvPMqIqsQJ10s+H2ba+
         qmsiAJnHAWP3I3ohnsGq6Zo/Zr+w2ZUEcIssW7suxDFJuUMFrzHwq7+Hl+iDOOp7KX2A
         3jJkmGg92Asj/HxJkGNIAWMQ83dK7X5y8tYGlDNPw7dR1lrGdNBKnbZZ8oDY1vPLzNTn
         rDGZ4PuGxFx2FllUxAGzXEY4ddXYTgFWGoYt2LokFhNV50k2wRn10C55h8KOMN7hDFLJ
         re/w==
X-Gm-Message-State: AOJu0YyCivTR60Poqhsd/9XQbH7vWv6nywEcer36oCM+AsYKEkxF1gVD
        vK2/KywOGRSWhvVxk460/I7CV/V61SU=
X-Google-Smtp-Source: AGHT+IGukfnCVrUEf/PEVeHn9rmrr23Pzpn795d1bI+BE3y5IefYW9fd8JHQNgwOqEKzVzOWWjr+TQ==
X-Received: by 2002:a05:6808:1382:b0:3b2:dd49:4e9d with SMTP id c2-20020a056808138200b003b2dd494e9dmr1828365oiw.6.1701531748228;
        Sat, 02 Dec 2023 07:42:28 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x19-20020a056808145300b003b6caf2accfsm918317oiv.22.2023.12.02.07.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Dec 2023 07:42:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0b76e7b5-a693-41e9-bf8c-531735c57337@roeck-us.net>
Date:   Sat, 2 Dec 2023 07:42:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: Add driver for Gigabyte AORUS Waterforce AIO
 coolers
Content-Language: en-US
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231020130212.8919-1-savicaleksa83@gmail.com>
 <45484650-4975-4f66-971d-7599681b1538@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <45484650-4975-4f66-971d-7599681b1538@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/23 07:01, Aleksa Savic wrote:
> On 2023-10-20 15:02:08 GMT+02:00, Aleksa Savic wrote:
>> This driver exposes hardware sensors of the Gigabyte AORUS Waterforce
>> all-in-one CPU liquid coolers, which communicate through a proprietary
>> USB HID protocol. Report offsets were initially discovered in [1] and
>> confirmed by me on a Waterforce X240 by observing the sent reports from
>> the official software.
>>
>> Available sensors are pump and fan speed in RPM, as well as coolant
>> temperature. Also available through debugfs is the firmware version.
>>
>> Attaching a fan is optional and allows it to be controlled from the
>> device. If it's not connected, the fan-related sensors will report
>> zeroes.
>>
>> The addressable RGB LEDs and LCD screen are not supported in this
>> driver and should be controlled through userspace tools.
>>
>> [1]: https://github.com/liquidctl/liquidctl/issues/167
>>
>> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
>> ---
>>   Documentation/hwmon/gigabyte_waterforce.rst |  47 +++
>>   MAINTAINERS                                 |   7 +
>>   drivers/hwmon/Kconfig                       |  10 +
>>   drivers/hwmon/Makefile                      |   1 +
>>   drivers/hwmon/gigabyte_waterforce.c         | 439 ++++++++++++++++++++
>>   5 files changed, 504 insertions(+)
>>   create mode 100644 Documentation/hwmon/gigabyte_waterforce.rst
>>   create mode 100644 drivers/hwmon/gigabyte_waterforce.c
> 
> Hi Guenter,
> 
> Any thoughts on the patch? I'll fix the issues kernel bot reported
> in v2.
> 

I was waiting for that. In general, I am too busy to review patches if
0-day reports a problem, and wait for those to be resolved.

Guenter

