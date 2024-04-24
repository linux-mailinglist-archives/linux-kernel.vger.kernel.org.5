Return-Path: <linux-kernel+bounces-157804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E7B8B1672
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31BB51F243BD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292C116EBE7;
	Wed, 24 Apr 2024 22:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1I3OVeZ"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB5E155A50;
	Wed, 24 Apr 2024 22:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713999057; cv=none; b=p9QndaSBpCKjFmXiKaBHw+e9sSfnD0NNrFFe4C3PMynxAYZk/0SXg3pgWhNuGwuU4SsB/X7TjQdwRe/m/OlzHDlX+2cH0KetrTod5cLwuUWcsBuJU7ATN95yo6pX+Lf7V1jtAps5X7/NuP+WTnKvd7N5r3v4d10HpHMNKUgzqs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713999057; c=relaxed/simple;
	bh=Ox2MB4MghcFgvvTU8MNU/H0/Uh51SmnpR/MUHfC8VJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1HpnIzNBr4x8MIjFdp8haYEO0nrKXqTI8hR+9hlyD29IzXkdeFe+itjVfDE6mjbuZOfzS31smclh1HhBpnPvDuqNUkPWbjnLS9Yxksr+T+SNk3Rf5MUzJoankM2xWeI5QcDSkW6hi8W4cequG2yeoJwL4XbcsyExZzzLC9HEyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1I3OVeZ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6eced6fd98aso436418b3a.0;
        Wed, 24 Apr 2024 15:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713999055; x=1714603855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2ABtMQID9pHiN7MdMijywVVKrrWz6KRhscU6sKi0tY=;
        b=h1I3OVeZS97+P73E3Uo/Jd7PrBTkTmZA2u6qv4FWIEUd7K3f0UHU4KJKwI10Gws0Fx
         qiCNBi2+tNU96MUX7UR8fEceQAmBtI0jQZr0VHe7j90v1aL3SwdNoglkKkFpgPRo3WR2
         tYm+/eyvB7/PDdpzgUxUm903GnQL92QVAwG2LEq7zj+OcplzSnl7XsQEGoa95+TmMdLL
         vTcaM3iwNfM0NA+VoW96S4n2kYu19o8SUB1qPpEGiCrlm+pZto517kcU/1JMlcSKQx1W
         kQ6wo4nr0jP7k2Hw7QHmnRtRqkP3DTYHdCOAmRD4UPtcAVGraqoTjl89stE3Bw3m1UMj
         TTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713999055; x=1714603855;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2ABtMQID9pHiN7MdMijywVVKrrWz6KRhscU6sKi0tY=;
        b=jvvhChr5dvSdohiPQRM0CNQcbatKMUGxQYWmTIoAttKSkaJkPSEg6iwZQwZtxPJp/a
         hCbkwTtHLBsE/A2QatHvR6HiDsiYUSwRo2g44+MYCSCphbqFOcrOz2LleisxENaflu2v
         3/mwrrnfvpdwpumBBb1sMZNaVKD3Z8y8hj5ngEQKG9D5wsZeSQbBAbQildG/HubvpvJ2
         Yu7Hmho0o4pRXTqDt9NrXxP3ms1aRXsk1ku/hbu9tqF4+TrKm5Q6sfnY239G0bWh1WgV
         1quGHUeuZumjCcSXGH38TnLnIguxyZlL2dsHRdJtPntOMkeFdAZxUljyyydt1IHLJXk1
         LNYA==
X-Forwarded-Encrypted: i=1; AJvYcCV2ZIGQLSXI2Pi1+e5gRnnR/i5JTpHBvEaOQHgh8aWiNDgZ61h472UPUyfniBA6lOnUIVUuVQtvPy2rhlsRvZM3NQP0ZBF1fD2b4kgYAJzA0kNIFTWzAmqUidWV1GfokVKh8hV2aN7/
X-Gm-Message-State: AOJu0YwvbFtbYtBZnHLHxKCtJMpqPp7dB6oaHmlvR3bIm9pcmHpzJNke
	AAdQLLIJZyOhG+6UCX5YkfTchVrAqTiTDZlIJY8uQsdnXVmHzHFA
X-Google-Smtp-Source: AGHT+IEOt2fq+BRQBbCAPRy7XK8QjrQ7hgTraUDyl1D8Ctwd/JqCleJi3utMFbw4cPjizQ9ubPAn+w==
X-Received: by 2002:a05:6a00:2e1a:b0:6ea:e841:5889 with SMTP id fc26-20020a056a002e1a00b006eae8415889mr6050205pfb.33.1713999055300;
        Wed, 24 Apr 2024 15:50:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b13-20020a056a000ccd00b006e6c61b264bsm11934743pfv.32.2024.04.24.15.50.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 15:50:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <eb4a61e9-ff00-459e-a6b5-63dae17ff83d@roeck-us.net>
Date: Wed, 24 Apr 2024 15:50:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: ohci: Prevent missed ohci interrupts
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20240424195951.3749388-1-linux@roeck-us.net>
 <0a29cc85-a79e-476d-aae6-0a054aad2e90@rowland.harvard.edu>
Content-Language: en-US
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
In-Reply-To: <0a29cc85-a79e-476d-aae6-0a054aad2e90@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/24 15:30, Alan Stern wrote:
> On Wed, Apr 24, 2024 at 12:59:51PM -0700, Guenter Roeck wrote:
>> Testing ohci functionality with qemu's pci-ohci emulation often results
>> in ohci interface stalls, resulting in hung task timeouts.
>>
>> The problem is caused by lost interrupts between the emulation and the
>> Linux kernel code. Additional interrupts raised while the ohci interrupt
>> handler in Linux is running and before the handler clears the interrupt
>> status are not handled. The fix for a similar problem in ehci suggests
>> that the problem is likely caused by edge-triggered MSI interrupts. See
>> commit 0b60557230ad ("usb: ehci: Prevent missed ehci interrupts with
>> edge-triggered MSI") for details.
>>
>> Ensure that the ohci interrupt code handles all pending interrupts before
>> returning to solve the problem.
>>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v2: Only repeat if the interface is still active
> 
> Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
> 
> Greg might insist that the patch be CC'ed to stable@vger.kernel.org since
> it contains a Fixes: tag.
> 

Sure, I'll be happy to send v3 and add it if he wants me to do that.
I never know if I should add it myself or if this is supposed to be
a maintainer privilege.

Thanks,
Guenter


