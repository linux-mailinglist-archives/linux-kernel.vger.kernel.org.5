Return-Path: <linux-kernel+bounces-54279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBD684AD39
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E831C228D4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F88B745F7;
	Tue,  6 Feb 2024 04:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pr7sqp79"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32A92F46;
	Tue,  6 Feb 2024 04:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707192154; cv=none; b=WEQXV8gQccXNZtqH1g2fXG2f3SfFlDfFPEyP8RQVWouxu3+WhUl8wuFXiz5XRub1moXpHuHQPu13WIaUDug8tzGN9gCewgC64+1BM1CDzRiuSrN0QGqjZEQMGuyiIjwCuwJozxQ73g+lVp4b1foVDL6xOWdnc+txMCq7wxsbwfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707192154; c=relaxed/simple;
	bh=mQ3804mPdAZpVPuClVV838v71nXIi73L3/VXWTKOTaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TW9KhA0zIUSxGSyRyZw+Uz9ZeaAOBlpfKdiztOWRW7HaoNmNki70A62FZw7LMKjVZ4Uwx43OgdmFNFs5KaPJBtJ862z4cN//0PT3VK0f93QHTWCqNaJKbvq5EoKHAtDFIrwc62TEMYnJO6VaSDdNZPSijwYU1FiHU8C/uK3JcBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pr7sqp79; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e04d24bd39so1054542b3a.0;
        Mon, 05 Feb 2024 20:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707192152; x=1707796952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dFJlrRMXwnDezdLQg2hDFWTpcTb5Yg1delD02OSNw98=;
        b=Pr7sqp79/Bzfg5OzxK6xTBI1oecTqNWoEElFTUDYWoivI3IqAMwGtQ8NgraSmKt/9i
         KXwk5F8ocMCFw7QRdWsW4lN/0f9J3mXKEEtHBcICwRjYX/FDz5Ths10jtUasDdTGZcnS
         /zLRiFngO/phxdsjw9tXGvQruxjMiToqeggZzoNaDaAwMDCasdl/qpRCn7y6xRFJDoy8
         C8GaneQzqhiUfRz5KytqVVKFZv+OxzcrZeUsL01HeP4UsHTOG1UR2jvkEdctdDNqoxwl
         mMzjP/29a5o/alScMy0lor5uIjfPD2FaEdC6+b+IrJHHCVbuDJqOBBx4hBcOVrXRiRiw
         bBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707192152; x=1707796952;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFJlrRMXwnDezdLQg2hDFWTpcTb5Yg1delD02OSNw98=;
        b=oYKwR+ezA0MPjLN+rou4HJRMx5NNj4tJqCSYn1WzEkL6jvJoyy1lQi2j9RgK/njzyb
         vAhfgZycZkvZoy6EaZjl6eHRbzWH98hD6K89LesUkaffZOeXmOpJ9yXIuVQA/NncN6Cu
         R1209vlJISSqO9NIh/GNm04zH/Ih0rwe/G/p2jtTcszbcW/YYeMD0ahpP+tXlmVbhK5q
         KzUHhvS0QsvM47hQPVzPI+DWjd2t/IejNLYXQalXLrWCmV10vkqhmmVcMfL8uS+AKEI3
         8Nl9iiqALvN0GHZrl/YI1WP24u4CATk5qD664z+75QrTm4MrOXQSvhd+omGe0FjYghJc
         K2fw==
X-Gm-Message-State: AOJu0Yzc3nSP5Go3nedk7HbPTUNQKxb3U9waJJfJlWs1WRcEvfYmxfhv
	8WATWSkcOTEMygChHpWW5sRsc9hba2wkQAYhmFbVj7qV1wLqoPZW
X-Google-Smtp-Source: AGHT+IFtxAHI0HNnOfFhurDHo1H1nqzz1aNXLH9HsvkH+vNPigKzml505fu56/pHGoEaqkTV7oqiHg==
X-Received: by 2002:aa7:87d9:0:b0:6d9:b4e6:ffb with SMTP id i25-20020aa787d9000000b006d9b4e60ffbmr1107836pfo.0.1707192151989;
        Mon, 05 Feb 2024 20:02:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXlHusBya25b4qSr7PRCgdsQ4g7IhjdeojDBoDqPgZvvI9Lz95Jy1+7AZBkqQ4YkY0f+RS8jMXNVmLxlLR8vYmxMLlTMbBC8esMln5cj8ExglFFx2vY7wKcXm76l8hB5RjSIvEJ9bCv83fHXNx4pbKUw5uCIBsYUzVmo5QF1PQFYupca25rpsrsGH+VJ7fvTpd/RANf/ez+KFkJ7YZs61DGNSmnLWI8vRq8eiOTVRCXaE47MUfjKIMUupWGGY816MVRFSqDwhn4xNbMaVjZIYyqxGL6f9WauG6+YoTs1qCWlF8mD2Vtg8rg2cmVdQaQCEGTLpTnzR756KVerPv1o73GhECSly3yyg4iMs6BP6oiyhSwcgzEa4SpHeNqMd/4CwNUpi6jPFaGwFRkWJgI4cjQ8kyG0GUOUnog7Rvlci+qyT7blYjyStZZj9QF35qjurpZ/n5/+tHr1O1Y2cx1v6N8X2g6BZhM87/19QYgbJtvHxHJ3/+rS3iFjzXGxU1wWLiJ8fL92r3x7BLh8/6B8BXfxge/Kzah4fJVJ8vJJDfi9Kw9FMHMPWRbnL78VVYN/NwNcj17UAdnjOY37c0fRiT4eDOWCXanzJvW5HIKr1wM0LEKS+9LJTYZ3uCHknbQ4KztlleaCnZsVFyI03VJsHqvKv+/C7+hB4l+NzQpGB8rqVw0LdXX17vTsiandAIbYuiHe+wbty9sjO5HNJhj3JWpmrFo3vlL9NjP45CxXHz1TRRuUwr2PsIOVOvDys8tyCnrDafKeYJcfhYI8JEcjLHabeNwaDKvnEPy7zxvW2sBYAMaquI/LpU=
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gx22-20020a056a001e1600b006e03e29e67esm696795pfb.204.2024.02.05.20.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 20:02:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cfc51210-4ef1-4df4-bb57-499316fb18fd@roeck-us.net>
Date: Mon, 5 Feb 2024 20:02:28 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] hwmon: Add driver for Astera Labs PT5161L retimer
Content-Language: en-US
To: Cosmo Chou <chou.cosmo@gmail.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, jdelvare@suse.com, corbet@lwn.net, broonie@kernel.org,
 naresh.solanki@9elements.com, vincent@vtremblay.dev,
 patrick.rudolph@9elements.com, luca.ceresoli@bootlin.com,
 bhelgaas@google.com, festevam@denx.de, alexander.stein@ew.tq-group.com,
 heiko@sntech.de, jernej.skrabec@gmail.com, macromorgan@hotmail.com,
 forbidden405@foxmail.com, sre@kernel.org, linus.walleij@linaro.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 cosmo.chou@quantatw.com
References: <20240205152013.3833940-1-chou.cosmo@gmail.com>
 <20240205152013.3833940-2-chou.cosmo@gmail.com>
 <4a504043-e24d-4119-8c5d-107f0d371110@roeck-us.net>
 <CAOeEDysSZEeKt==zyexLE1GhE5ZpeDHS7sDLRfcC=4JgiogLKQ@mail.gmail.com>
 <a05ec2fe-cfe4-48d8-bff4-9f3689c585d3@roeck-us.net>
 <CAOeEDyscobVHaAe+72P2wEiucgWUDX=2H2W5dq0P1q8RB=7tzg@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAOeEDyscobVHaAe+72P2wEiucgWUDX=2H2W5dq0P1q8RB=7tzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/5/24 19:53, Cosmo Chou wrote:
> On Tue, Feb 06, 2024 at 11:26 AM +0800, Guenter Roeck wrote:
>>
>> On 2/5/24 19:05, Cosmo Chou wrote:
>>> On Tue, Feb 06, 2024 at 3:43 AM +0800, Guenter Roeck wrote:
>>>>
>>>> On Mon, Feb 05, 2024 at 11:20:13PM +0800, Cosmo Chou wrote:
>>>>> This driver implements support for temperature monitoring of Astera Labs
>>>>> PT5161L series PCIe retimer chips.
>>>>>
>>>>> This driver implementation originates from the CSDK available at
>>>>> Link: https://github.com/facebook/openbmc/tree/helium/common/recipes-lib/retimer-v2.14
>>>>> The communication protocol utilized is based on the I2C/SMBus standard.
>>>>>
>>>>> Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
>>>>> ---
>>>> [ ... ]
>>>>
>>>>> +static ssize_t pt5161l_debugfs_read_fw_ver(struct file *file, char __user *buf,
>>>>> +                                        size_t count, loff_t *ppos)
>>>>> +{
>>>>> +     struct pt5161l_data *data = file->private_data;
>>>>> +     int ret;
>>>>> +     char ver[32];
>>>>> +
>>>>> +     mutex_lock(&data->lock);
>>>>> +     ret = pt5161l_fwsts_check(data);
>>>>> +     mutex_unlock(&data->lock);
>>>>> +     if (ret)
>>>>> +             return ret;
>>>>> +
>>>>> +     ret = snprintf(ver, sizeof(ver), "%u.%u.%u\n", data->fw_ver.major,
>>>>> +                    data->fw_ver.minor, data->fw_ver.build);
>>>>> +     if (ret < 0)
>>>>> +             return ret;
>>>>> +
>>>>
>>>> You almost got me here ;-). snprintf() never returns a negative error code,
>>>> so checking for it is not necessary.
>>>>
>>> Oh! You're right.
>>>
>>>>> +     return simple_read_from_buffer(buf, count, ppos, ver, ret + 1);
>>>>
>>>> Number of bytes written plus 1 ? Why ?
>>> It's just to include the string terminator '\0'.
>>>
>>
>> If that was needed, it would be risky. snprintf() truncates the output
>> if the buffer is not large enough. You might want to consider using
>> scnprintf() instead. But then I am not sure if that is needed in the first
>> place. Almost all code I checked doesn't do that, and it seems to be likely
>> that the few drivers who do that are simply wrong. Can you explain why the
>> string terminator needs to be added to the output ?
>>
>> Thanks,
>> Guenter
>>
> It's just in case someone reads and prints this, but with a dirty
> buffer and doesn't handle the terminator.

That needs a better reason. It is not conceivable that 99% of drivers
don't do this but this one would need it for some reason. I am not going
to accept this unless you can show that debugfs files are supposed to
include a terminating '\0' in the response. This is like claiming that
printf() should include a terminating '\0' in the output just in case
the output is read by a broken application which needs to see the
terminator.

Guenter


