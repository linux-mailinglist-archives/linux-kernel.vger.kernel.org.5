Return-Path: <linux-kernel+bounces-54252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4DC84ACD7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3218BB23CFE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14296745C3;
	Tue,  6 Feb 2024 03:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFxLB2C3"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF156E2B0;
	Tue,  6 Feb 2024 03:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707189969; cv=none; b=sQe1BHLI8rrkuI5buQlvXe89Dnm15NZ8MqptzYAnWyla0WXBijPTh8P+UuEKecaae//XfdE+VvAIXS0gc/k/xC1RZrT3AYYxUvwJ3E2JGl7uYquaQVYTKR+nOY5Q/ZSQXYeBpcT2drayZPPgqUXSVtTEvmXlZg8WauvIOi9G0FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707189969; c=relaxed/simple;
	bh=umEb0BhqMX8QgLQWlM++IWcTd98YG6V+w+9Y6bL6Kz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UWeT/jdtyHVGo0YQ6OmOjXa52TT0HTqudqRw05Ppu14bqekAaKbCAkOllp2aSzSbut99YSEgSUkXqhn7nLy1aqhvqUpVuAtUVtonPj7cmcT8KlOY4DWOrntYTqFZGzGNCxaZ1jFhimR2WnzL/esy/+3PmiwJzFglW/1VFc+vdpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFxLB2C3; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so387736a12.0;
        Mon, 05 Feb 2024 19:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707189967; x=1707794767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=XZfzzDXmxicnToftyCXmWq7bV7IDNDJptxpK3iKTrk4=;
        b=VFxLB2C3auGDmBYnck2VQxQ0zp/pWl61WhynTTrh5CIUGtu9gIr1FWHYU9QuBafYkL
         hv39wGvaX8oMGrlGUt3tdDD5Khy5Gsup/SwddFk8g+8AwCb+roN3MnYnTEzlbpH4gMgs
         JGwdTCiGmBWx91IvF996riEB3hBod5vJM8HPk3COk/hM4WgYz+aJ9HYw2MYqZi5dNAoI
         SKWbwfNgZvlUwoF2+Zo1nbFLCE4IaktVtDCnveNdl7FWvWUHYZ6OHXHF1CR1eLox3vdW
         hATpv1H8IntFJtAcshCpr4sC2jOytVWf4RwmWp3hisMN6p/j4h18pY4TFmCgLT2pzJPb
         afXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707189967; x=1707794767;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZfzzDXmxicnToftyCXmWq7bV7IDNDJptxpK3iKTrk4=;
        b=XFOUX2XE9syaY7qnrbKWhBsxPInlUHNhdfwJWnfRvat0GZqxGdGmiyfRaD80l6EZec
         jlPLCi724VTQuuuRLKq3W2VXMRk1RWeGjttgxysTymFuzYkLY5YK2B1as93oVCu3Zut/
         KlM2U6/Pk2n6pCzSGymIdnfGuhcF6yP2YdE8O0fj2VAOUNhu/4btrSHZ239L8ty7mAvl
         xhMu1H0Kbz99U7CxacmSLDUuWGUE/0cNHIqBrkjOVX+tSAtw0Gq1lY8FB2qG4Q1C1sZq
         /7iXt0ODFTJ6yGDaY0fbcRluKMPZUKmP0u9N0XUSd3pu0mzGmRY4iwvChhBIexqFtLkI
         GTRQ==
X-Gm-Message-State: AOJu0YxbtZte8CMU5LZsN7b6vzta2fqXNtH6tDk0qBAvV+xS8QZkB9Iu
	MkFuo0bozqNFw4YLwEyh/Z6jwtR+77hapJMD7HZdTQGdx9I3PgmJ
X-Google-Smtp-Source: AGHT+IEt6oykrf0PDpMVT9qDaE9akvUwe33dM2NY9Sa84AvoA2lfeOaEHLIuX5/yXhRC6aGi+gLocg==
X-Received: by 2002:a05:6a20:8fa5:b0:19c:9b48:6982 with SMTP id k37-20020a056a208fa500b0019c9b486982mr296790pzj.46.1707189966735;
        Mon, 05 Feb 2024 19:26:06 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUUpP4a1dvLNnp4PIyWXb8YzcC8C7liV6E8lGOx66DxbyKcVVPnNiMihI+PK5G3zy1qXsHDgG6/ArXcxWIXxqICYhpSasJXxiArNHfGFWmHHyI8wrXuepUCMqfMyOiqyQtzwai1pfJUlVof7ZyzBX9S3zx59hqEmaILLynyM7gGatFUBbdpisNZ/erR9MRNwnkBYiJfBwBb52HmRlhC56GIBdeZI5qEmFNzaWB6uW1adCJW3nVywmB4ErjJObvjj6E3EQ+qacZ1dqhcgx9VbgDTyD9/ff2sHTEH+V/TlvjtVijHu3i9AwL+kJQUZSI1QyIWgcesO8qWsM8oX9d0rXaCF6VFKyzCg5L9vVuel98RSC+sySGJsLoYeu+3gVXh6qGAiIg0mc+/8Cp/72hdnMe/rTY+sj78lUSWQXMV5dlwRZUmt6Z8JFc3wn9KShuSx7iSFNaBDeDH6Aqj83nkaePS4dNIBxw5vXpL1RLZtLy9XRilFFkhQKAoKVeOHpfrx4t+dLeyrlp4GHmqSRuLtDP0lGjyMOlLJbJpeSGUtJYPvnmR4HbwqoFpmSWPuUSITL5gxepdigFOFTEMn/oTfOwk8qJpfZBkgU6z/YFjznf1uFRPFeQV+fwh/xBV9QZUs14TsXvNslgpZ54biUhllHteBlFbUf46phPtdQd/PXXnnxvqXSLnj4ZZlnXl7NTHHm5sfhYrdeifEd04TMr29vmX5Zid+QVw7lAcA7qpgB+fNZSKCgZD3CM2fkC2HiD4gPUWz2jJGakQBQfOhCwQZ7ESEveYhbt2x8A/y+hGTW8qSQ+Neap2xlc=
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d51200b001d986ce6893sm636562plg.198.2024.02.05.19.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 19:26:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a05ec2fe-cfe4-48d8-bff4-9f3689c585d3@roeck-us.net>
Date: Mon, 5 Feb 2024 19:26:04 -0800
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
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAOeEDysSZEeKt==zyexLE1GhE5ZpeDHS7sDLRfcC=4JgiogLKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/5/24 19:05, Cosmo Chou wrote:
> On Tue, Feb 06, 2024 at 3:43 AM +0800, Guenter Roeck wrote:
>>
>> On Mon, Feb 05, 2024 at 11:20:13PM +0800, Cosmo Chou wrote:
>>> This driver implements support for temperature monitoring of Astera Labs
>>> PT5161L series PCIe retimer chips.
>>>
>>> This driver implementation originates from the CSDK available at
>>> Link: https://github.com/facebook/openbmc/tree/helium/common/recipes-lib/retimer-v2.14
>>> The communication protocol utilized is based on the I2C/SMBus standard.
>>>
>>> Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
>>> ---
>> [ ... ]
>>
>>> +static ssize_t pt5161l_debugfs_read_fw_ver(struct file *file, char __user *buf,
>>> +                                        size_t count, loff_t *ppos)
>>> +{
>>> +     struct pt5161l_data *data = file->private_data;
>>> +     int ret;
>>> +     char ver[32];
>>> +
>>> +     mutex_lock(&data->lock);
>>> +     ret = pt5161l_fwsts_check(data);
>>> +     mutex_unlock(&data->lock);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     ret = snprintf(ver, sizeof(ver), "%u.%u.%u\n", data->fw_ver.major,
>>> +                    data->fw_ver.minor, data->fw_ver.build);
>>> +     if (ret < 0)
>>> +             return ret;
>>> +
>>
>> You almost got me here ;-). snprintf() never returns a negative error code,
>> so checking for it is not necessary.
>>
> Oh! You're right.
> 
>>> +     return simple_read_from_buffer(buf, count, ppos, ver, ret + 1);
>>
>> Number of bytes written plus 1 ? Why ?
> It's just to include the string terminator '\0'.
> 

If that was needed, it would be risky. snprintf() truncates the output
if the buffer is not large enough. You might want to consider using
scnprintf() instead. But then I am not sure if that is needed in the first
place. Almost all code I checked doesn't do that, and it seems to be likely
that the few drivers who do that are simply wrong. Can you explain why the
string terminator needs to be added to the output ?

Thanks,
Guenter


