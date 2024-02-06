Return-Path: <linux-kernel+bounces-55227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A64984B95B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D53861F26BF5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AAA1E48E;
	Tue,  6 Feb 2024 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LL9W02Ic"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1929133424;
	Tue,  6 Feb 2024 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232762; cv=none; b=t1Cy1xbt/GqWzk+If5Gwg4kRmoEG1ax+ClhiPLND8PjMZg9XRvwr44RergiIXaomLk7IDAqNWQiVtmpUCUuAsF5TBRljKAM8lPakzg8qW7eTd464jk96JxIJVI8MiNWiGn+2YUOtM+LNChirdsoiQrYbKhv5f1eoXLU+D0k+Xmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232762; c=relaxed/simple;
	bh=xJGB+7srefq3wP/QouS+voPpa5cGHrkHxOsv5UEZqfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9QM8aPP1npttR1Ylyl1Abi9h/1SWh9CUgS66VgzmZaIeq9RLVfTFJC3GU0D3SyA23bv5oVnLfpw+ASUaQ05DbkPBsOfibuAw7RLK9no3/lbT41wQ03FrEacEbMNOW0ALHF7oUeG7TABGtS06wFaoAeQRr9RTeVxSFKc1ZVvVW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LL9W02Ic; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso4781131a12.2;
        Tue, 06 Feb 2024 07:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707232760; x=1707837560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=VoZK7Hq3Jn7l/cY+m/wVGoxbjgscYBvxr8QICpwqhd4=;
        b=LL9W02IckeOX6P6Fy3IZzHRK2Thi++PPyLAtbCvo6H3R/Lk/rYNeINl9IPQIwHFGaZ
         5KnqaKYR7/eBEhObFbAcKnMalOo8nxL51oNCBh4PthSybxFnirSh0FxlJUvzMdd/FYxq
         cnh8SvQJl40k0wBokLazI63fSPafGHkRDGpbYI0hSzdqAAWt1MqzF5/99endfnLt4TgG
         fGwuTPQGeqrINIAqfntOY2orwbcGxFANis0fB32rbpXuOPB3zXXGANcy0pWioEFIdJCx
         GKFF+KtSKNe65ul3TNLYHCdRzdsBSQ0zl/zCGQAQwgaES0efPhBE/a6GQpr1wLcuxrS8
         jzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707232760; x=1707837560;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VoZK7Hq3Jn7l/cY+m/wVGoxbjgscYBvxr8QICpwqhd4=;
        b=oTshDBmYElyci+3p42s/M2DjCFYQYEwkiOIQD8bhqLghLnimvSkOu524PJdmk4YUCb
         PvIZawZ9yI82VnhYFPjYX1wNDQFhwkjBC2dBmZrIpvqBvJd+ukiJcwn/L66RxsjK6P75
         vKkVxeFAz46NubDOP6QnZi1GPyjxwVLarTm9ec0p1lVCdR12ZVYPkHvYaiGw+J/yH4VD
         hMgXkHE2pMf2PC9/KuOaAbsJbvFm4Eb/mwlNp0+i8DKb312FQlSFLVxZafk3knrBg8/y
         tcCQ5KSN7OYby3n6lqhPZkE+c+FbgITJ698bk6OHHjOubCrJez7tgwlohP6FOWGdhEix
         NZQw==
X-Gm-Message-State: AOJu0YxnIJlBgjaSSobAzS6HIcK2GImntSipiPiLN3cRBgOwspIdSI42
	YKevmqg+DToAHoS5WbV4QRgmQjyqG4+GdX9ldjBX5cowmK4Wk6wZ
X-Google-Smtp-Source: AGHT+IGYrBe3Vq4QE2ZXQZOrGTMmqcaPZsfO1jDVJ1rojwgM26puufUzog+DlqMAHYYGf/xu2hoYdQ==
X-Received: by 2002:a05:6a20:9597:b0:19e:9c5f:d01d with SMTP id iu23-20020a056a20959700b0019e9c5fd01dmr1017562pzb.19.1707232760125;
        Tue, 06 Feb 2024 07:19:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU6getdF1ioqn5poAkjBomr/roUyyM3SPdA06kjTZU1tomul3HWCe6Ug03z6f9kG7fiIRKfazoSl9MF1EQSm/6iMVayZ8dNgA2T0S7dM4I9pZqO1jvn6tWNjbeDY36TOd+fN1vCqKSjixB0nGRtQzktaGF65ob+HdEE1wjoCAslQ5pEZJIu5BP9zrQPKl2ZyOvORmCmcRv34EotMawBbG2VbenlGFM6ILDD4yH/9p7G2BuTo2WtHiYEk0vqQ3ri52/9+JfVh0EmeroqO9OmfQfAtik7sYKuiOFuc1dZTfv+t26/x885m6VtYAMiLlwcyQrqJzTzzQ9KCcyMsJMYVRzUnS/+vS6jlL3vO8Mi6w3OAAy3M5WoMuErS53VoaQdN3k13wYE64zYZm8moik6zcMmMxOxtiI/xfR69zRAwif5+L8QRQ7KgGYV6jsnw64xrSQTx1Yk7SFJUfGBoH7onZo0mY/EhB8esaI+EOEsYXJ2G1SpjuaRgpLZG+wnIEvC4Sp0p6+qx7dBFfAaqAfWzqs7APiJ/nvrzmx2YU+BiLIqZYP2VXuuQgZKxPn37ANwFkGiNlI+4vUsJoCCYp77ytauXqQrm7dvP0DWp6cV8UPNaXChTuOlq6lmtrW9BKteEX+KQYs6GM//Raur/VO83ck+WTcFhRusqQefwsTx3SRk7uP6cGFulcdXm+PmPDfnDHog9cWcwkl5G5lHTLcG8QEPJUgpPzlHtZlOpfq2SSWf1bCJ/46bvW9TdeR/WqOD9h0Vy9lMff6VUKc9HcgfHUkpCOSRONnloKg=
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e3-20020a63db03000000b005d66caee3d0sm2231778pgg.22.2024.02.06.07.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 07:19:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b8c92781-cf41-45c5-ab25-b4e5a1b6d6b7@roeck-us.net>
Date: Tue, 6 Feb 2024 07:19:16 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] hwmon: Add driver for Astera Labs PT5161L retimer
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Cosmo Chou <chou.cosmo@gmail.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jdelvare@suse.com,
 corbet@lwn.net, broonie@kernel.org, naresh.solanki@9elements.com,
 vincent@vtremblay.dev, patrick.rudolph@9elements.com,
 luca.ceresoli@bootlin.com, bhelgaas@google.com, festevam@denx.de,
 alexander.stein@ew.tq-group.com, heiko@sntech.de, jernej.skrabec@gmail.com,
 macromorgan@hotmail.com, forbidden405@foxmail.com, sre@kernel.org,
 linus.walleij@linaro.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, cosmo.chou@quantatw.com
References: <20240205152013.3833940-1-chou.cosmo@gmail.com>
 <20240205152013.3833940-2-chou.cosmo@gmail.com>
 <99a1a309-41d6-448f-b622-b62dbabb2c52@linaro.org>
 <b932533c-d1fe-46bb-8187-b0560861e982@roeck-us.net>
 <027fddd4-d572-4f9f-bf7a-1980c73017fa@linaro.org>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <027fddd4-d572-4f9f-bf7a-1980c73017fa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/5/24 23:33, Krzysztof Kozlowski wrote:
> On 05/02/2024 17:15, Guenter Roeck wrote:
>> On Mon, Feb 05, 2024 at 04:26:08PM +0100, Krzysztof Kozlowski wrote:
>>> On 05/02/2024 16:20, Cosmo Chou wrote:
>>>> This driver implements support for temperature monitoring of Astera Labs
>>>> PT5161L series PCIe retimer chips.
>>>>
>>>> This driver implementation originates from the CSDK available at
>>>> Link: https://github.com/facebook/openbmc/tree/helium/common/recipes-lib/retimer-v2.14
>>>> The communication protocol utilized is based on the I2C/SMBus standard.
>>>>
>>>> Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
>>>> ---
>> [ ... ]
>>
>>>> +
>>>> +static int __init pt5161l_init(void)
>>>> +{
>>>> +	pt5161l_debugfs_dir = debugfs_create_dir("pt5161l", NULL);
>>>
>>> Drivers don't need initcalls. For sure any debugfs should not be handled
>>> here but in probe.
>>>
>>
>> Lots of hwmon drivers have init functions, for basic chip detection of
>> Super-I/O chips (example: drivers/hwmon/nct6775-platform.c) and to create
>> a parent debugfs subdirectory for the driver. The probe function then adds
>> subdirecties per chip instantiation. Example for pmbus, in
>> drivers/hwmon/pmbus/pmbus_core.c:
> 
> Core bus components are a bit different...
> 
>>
>> static int __init pmbus_core_init(void)
>> {
>>          pmbus_debugfs_dir = debugfs_create_dir("pmbus", NULL);
>>          if (IS_ERR(pmbus_debugfs_dir))
>>                  pmbus_debugfs_dir = NULL;
>>
>>          return 0;
>> }
>>
>> static void __exit pmbus_core_exit(void)
>> {
>>          debugfs_remove_recursive(pmbus_debugfs_dir);
>> }
>>
>> Are you saying this is all wrong ? What alternative would you suggest ?
> 
> Just create parent directory in probe and only keep remove in __exit.
> But you are right that might not be much better approach.
> 

That would just add more code and increase complexity since it would require
a mutex to protect against parallel probes. On the plus side, it would only
create the driver root directory if necessary, that is, if there is an
actual device. I am not sure if that would be worth the increased complexity.

That makes me wonder, though, if an API function such as
	struct dentry *hwmon_debugfs_get_root(char *name);
would make sense. That would move the complexity to the hwmon core and
unify its handling. I'll think about that. For the time being, I'll
accept the code as-is.

Thanks,
Guenter


