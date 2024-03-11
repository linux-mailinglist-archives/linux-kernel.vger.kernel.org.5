Return-Path: <linux-kernel+bounces-99330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D6F8786B4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDF51B225C6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DE153E00;
	Mon, 11 Mar 2024 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckarETY5"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02C751C44;
	Mon, 11 Mar 2024 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710179542; cv=none; b=LkFcs5r4vyrMTpxzC1nSXwmqgMzOHGZWcCJPGaGeMDQzOLxRapDVYl4wMvwtB8frpX3H1znXSAssQPs0ry1e/aIGLiMkJDliVfPO1SzCi0Qv5jVwrztDcv5tKTHuBQQcP2jQIuKrtISBieoVDPhPQrigkSGDJp3KpjQHmrvntM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710179542; c=relaxed/simple;
	bh=Xrv0dABVXXv4GEWp9IPeh5FXsytwQhZ/bsWNsDG+eRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6SPAPny7r/jb8/U2L3DzOHM0LmLuVr8GRR1MVWtAOeYzZoeFO50ojCNE5f36eQcknRLqAx38M2jUzfh5DGJmxUvEB24w9JY1JZV6ZfkfSgkZmIt7Gh5ZfT9B2NgZeseSfHb8bc1248NvWs3cIezPw/Aj2qFoYTsoMaJh3PqCUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckarETY5; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso4166554a12.3;
        Mon, 11 Mar 2024 10:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710179540; x=1710784340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=L2tY/E430NCe7kRmBjFBHLfm67T+ajJLTfs/LE+RHXA=;
        b=ckarETY5+VF3j+OnhMs7/NKh+oBgSgFmr86b4sSf9Edm49YwodyjPmd1/lyWMHSKLo
         Qn6jnzsaDgEIGovSbEZCdK081XpVsPjimueiTK02k5L0BSuXfzVat6ZBI/B5KD7KJ6tO
         2tEWCIwEKfgW8FwvHUzwfPdHDyzrlvdT3OzukUv9H/D+Et+clE8FN0T6XWAQPsnK3MVl
         1j3P++/6qY6+3YWB/qAczq1tmRUhTcTdmalGWFQXhqSFzNXUN0JgyoKmc2f79T6z/NNZ
         S7u+Y2l2FsCLL05UQVdmuxxxEBzPdhcKqUlnu86UUxstM9gfmXVfdXfF46s7jJROR248
         4oVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710179540; x=1710784340;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L2tY/E430NCe7kRmBjFBHLfm67T+ajJLTfs/LE+RHXA=;
        b=qWYyDF8Coa+q7u77diZn0Aa9kSBS/KBqwGgOwCDj2VZcmaqBiXj6os6MNFSfaHZ4sl
         y2kbpG0YdlfoUv4tkbEHtUaJ7Cv28/B+lgDtIVyngGKRuGOYirokBnF45+DsuqdJD2Fd
         xjbOlzoLopgJdM1E6QwDk7vKCZQqaLE/WI76xuZjIBYPKrmsYUk5h1D1tTF6Fh+WBKoU
         JcUTXn8YV253vUsFDN8qU/2AE+RjUUbjhQHs68cN8IobyzTb8n2mio6f6Ew7lAlpsu+f
         DDhbO4oheGcPg2Ih4ZgdYD41PCKmonA/IMMx2s0Ei3VedL8eRaKEcdSBVAkxP+jH4Pr7
         rMBg==
X-Forwarded-Encrypted: i=1; AJvYcCXjNZp5tKHd1M66FIcKGJleJsdHO/wadmhOok17Hgwo3hLLV/1V6PRpskcWyLi54pXdWatIGAh7hJ+/+QA8SJ2pg9e8dwnm2Q3KNcIbBMGxckMdALb86oqAm+zdhdRLWBT3QuPOUPmhN7We6HJdQ0RePanlA+GSqwRHli/+SebYgX7TP/NK
X-Gm-Message-State: AOJu0YxpRNzcCWgYQD8OxjXkFxlE3ffCf9xTF5QxKMuw2YTGu6rQ5/QZ
	5Z/T96egbjEqlUwl6/g3MUJv7SfuvKr/BcTZiZL8ABZu1QB+Aj1m
X-Google-Smtp-Source: AGHT+IFhKz1KBzwu85R3MraDbxd0ltmVEZ/orXLFCq5w86CSXv/IBnHrVbN+yaefP8akBy3IDwkjfA==
X-Received: by 2002:a17:90b:350d:b0:29a:be15:9c90 with SMTP id ls13-20020a17090b350d00b0029abe159c90mr1460953pjb.34.1710179539949;
        Mon, 11 Mar 2024 10:52:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gz8-20020a17090b0ec800b0029baf24ee51sm5850404pjb.48.2024.03.11.10.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 10:52:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <43f62612-bd16-4d66-b1ee-26932f6ab2f7@roeck-us.net>
Date: Mon, 11 Mar 2024 10:52:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dt-bindings: hwmon: max31790: Add
 pwmout-pin-as-tach-input property
Content-Language: en-US
To: Rob Herring <robh@kernel.org>, Chanh Nguyen <chanh@os.amperecomputing.com>
Cc: Jean Delvare <jdelvare@suse.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Justin Ledford
 <justinledford@google.com>, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Open Source Submission <patches@amperecomputing.com>,
 Phong Vo <phong@os.amperecomputing.com>,
 Thang Nguyen <thang@os.amperecomputing.com>,
 Quan Nguyen <quan@os.amperecomputing.com>
References: <20240311111347.23067-1-chanh@os.amperecomputing.com>
 <20240311111347.23067-4-chanh@os.amperecomputing.com>
 <20240311173438.GA1451467-robh@kernel.org>
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
In-Reply-To: <20240311173438.GA1451467-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/11/24 10:34, Rob Herring wrote:
> On Mon, Mar 11, 2024 at 06:13:47PM +0700, Chanh Nguyen wrote:
>> Add pwmout-pin-as-tach-input property.
>>
>> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
>> ---
>>   Documentation/devicetree/bindings/hwmon/max31790.yaml | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/max31790.yaml b/Documentation/devicetree/bindings/hwmon/max31790.yaml
>> index 5a93e6bdebda..447cac17053a 100644
>> --- a/Documentation/devicetree/bindings/hwmon/max31790.yaml
>> +++ b/Documentation/devicetree/bindings/hwmon/max31790.yaml
>> @@ -25,6 +25,16 @@ properties:
>>     reg:
>>       maxItems: 1
>>   
>> +  pwmout-pin-as-tach-input:
>> +    description: |
>> +      An array of six integers responds to six PWM channels for
>> +      configuring the pwm to tach mode.
>> +      When set to 0, the associated PWMOUT produces a PWM waveform for
>> +      control of fan speed. When set to 1, PWMOUT becomes a TACH input
>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>> +    maxItems: 6
>> +    minItems: 6
> 
> Seems incomplete. For example, fan tachs have different number of
> pulses per revolution, don't you need to know that too?
> 

Per Documentation/ABI/testing/sysfs-class-hwmon:

What:           /sys/class/hwmon/hwmonX/fanY_pulses
Description:
                 Number of tachometer pulses per fan revolution.

                 Integer value, typically between 1 and 4.

                 RW

                 This value is a characteristic of the fan connected to the
                 device's input, so it has to be set in accordance with the fan
                 model.

                 Should only be created if the chip has a register to configure
                 the number of pulses. In the absence of such a register (and
                 thus attribute) the value assumed by all devices is 2 pulses
                 per fan revolution.

We only expect the property (and attribute) to exist if the controller
supports it.

Guenter


