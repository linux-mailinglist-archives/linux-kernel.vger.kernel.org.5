Return-Path: <linux-kernel+bounces-41241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6118183EDE3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C537D1F21EEA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF2928DDA;
	Sat, 27 Jan 2024 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="er16ZyBh"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7D5200A8;
	Sat, 27 Jan 2024 15:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706369049; cv=none; b=aCRdwNVDrqETCzRIDxcL4fusyzURu+QWjqQRPzzEER6JnJXg7g8XhsHmmf96JiujLOtNru2k43DqYX759xUgZ7YIxj7kmiaxx8MAVjcSM/oeaSlXH4S8VDRKedHvKGdHdDxDZP5/kP5UNRd8fvyygZ0BszRqX0A8o88vzDryLoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706369049; c=relaxed/simple;
	bh=K2VeuDd4mRfpzkcKQFHum0Quyfo70GsfmikUSqBBEeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPgLa1Cqo5Tnx6+EgMpt2hp1kPQFRQUSxXes7ldYlUz4sZO2hbsqygKBVmZ6Sg1ORggLD6P7vb6hbID8kh8v6oLrPRoY0v+bAExu0sRINKQk4eLewAuy6xb4ZhhlifaTjn7R2XHKyghy/bXq6+3JvNR+xKq/YacKzzG08YWxb6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=er16ZyBh; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d71c844811so7160075ad.3;
        Sat, 27 Jan 2024 07:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706369046; x=1706973846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=QpnGBBNar5l03MU9RgyEjF2qQ9HN+i6J9QDtg2pFE0Y=;
        b=er16ZyBhvn33cwASFAG0/zEaxmag/u+q+S86uqC03gtgNSQGygTpbJxnDHQNHDX30L
         xQghWYUE0eiVfGV0a6VyXH7LDLfr1hHoCHGclRlmteAusxwCKEkINGbg7wb6hdNqGBEV
         BqezBAhyM+hIJTgiqdkQBiV3O1YdXgG6hcsnyC2KPrQ6iX+ODsLDzg0TL/adTzLMHcdr
         KP1Z4SqQECe+k9qVVz9TiDcD2jQz4LmjFI3B+FLqk8UJTRow9cDPMIMwLHTaiVosWVjY
         oOEt/mDjap7g0rCiPOBKqma4AHb06fROc0wkiPb0OaEO6KVCW5X9cBeGAZotpI7P+LqL
         Iv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706369046; x=1706973846;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QpnGBBNar5l03MU9RgyEjF2qQ9HN+i6J9QDtg2pFE0Y=;
        b=of2x7hlkuAD6FhVJMfHAOVozx0H4ogQB5qkr9O+iClU8tbLdThUQYEV+pF+JuDf8QH
         s7oiXmbgNYBhAOIc6hlCO1AeFIO1Ogcjmr2FXHKbRin4CSiqJ3Um+teWbsrMbi4eB8ya
         IKik8dczCHApgkzUImdxJCpYVFRGWCI3VpLRims6zpR39eJtYwgKtJcK+XUiV0jvZAhh
         CQ0DPF4P9TZtgh4FAqbqDKK5+q/+W2Q0d4YCJsGN6HuSlJiJNPnhOeoYW9WyeihVi18w
         Jaw1x7BMvvagm8zNPGs3uqfSu8qGoTEuDsdt60ZVUHqfULeWTLAvoWFxOMgHSlEbXdCp
         8bzA==
X-Gm-Message-State: AOJu0YzFLJGZRh8N+UdfWvQE2Uw7M5YqMmtvQ5Z0ZBBbMFgkM6mN9CBL
	MvNiC0mwwo6KsdixQd4wl9mjyzU5yhUpsmLImRSrIMPDT/mBCWMXishYff39
X-Google-Smtp-Source: AGHT+IFc/fYGR7BB2NzAiKZrJnOkk7rkWCvnnMiGYqHVJNix2972AJfFSk9WAer9xKkewvbCfRkP7Q==
X-Received: by 2002:a17:903:2347:b0:1d8:b6d1:be2d with SMTP id c7-20020a170903234700b001d8b6d1be2dmr293930plh.36.1706369046247;
        Sat, 27 Jan 2024 07:24:06 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090282cb00b001d7505fd14csm2546520plz.215.2024.01.27.07.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jan 2024 07:24:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c853502f-230b-47b3-9c93-28d99f4d83b8@roeck-us.net>
Date: Sat, 27 Jan 2024 07:24:05 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hwmon: (pmbus/mp2975) Fix driver initialization for
 MP2975 device
Content-Language: en-US
To: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Konstantin Aladyshev <aladyshev22@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>,
 Naresh Solanki <Naresh.Solanki@9elements.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240126205714.2363-1-aladyshev22@gmail.com>
 <CALNFmy2KVbiwvuEz=qjcB1vL82OOPSsZMuYWze56siCHLQ8JgQ@mail.gmail.com>
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
In-Reply-To: <CALNFmy2KVbiwvuEz=qjcB1vL82OOPSsZMuYWze56siCHLQ8JgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/27/24 00:56, Patrick Rudolph wrote:
> Hi Konstantin,
> Thank you for fixing this regression.
> 
> The comment is no longer true as the driver doesn't internally convert
> from VID to direct,
> but rather configures READ_VOUT using MFR_DC_LOOP_CTRL.
> 
> The comment thus should read as the following:
> 
> Report direct format as configured by MFR_DC_LOOP_CTRL.
> Unlike on MP2971/MP2973 the reported VOUT_MODE isn't automatically
> internally updated,
> but always reads as PB_VOUT_MODE_VID.
> 
> Regards,
> Patrick

Please don't top-post.

This patch has already been applied. Please send a follow-up to that patch
to update it.

Thanks,
Guenter


