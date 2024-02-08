Return-Path: <linux-kernel+bounces-58219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E24584E2EE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D6B28934A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D3E6EB4B;
	Thu,  8 Feb 2024 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mh8QCLsI"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECEC763F4;
	Thu,  8 Feb 2024 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401674; cv=none; b=UCQLUXyQEoYJsWReCG3uYABBF7riCegaPOGYPZ4sLG/JK9GV7FBEWC2+lyqS8Sq8EjT5voAUOLk59NLNL52c9RqthPfaIrFzsxMLTyAoQupRwQqzsUPnruTbZGeQiogW8hPP64FEC3z27aQRWNkIgK2V5gY13Ek+1dKIn90/DLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401674; c=relaxed/simple;
	bh=uiBYLZn71C912vKTrlG4ZHjBTNMvmelWSNkzngeJ2cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rX7gnjlSsQQPr/XdYzDOgDjTKpJL85Sw/7gQp72zWfgHFmzThFm4jvOnI9wjdCtLvN5A4Zce6CMkao45XKlbUB1TAOG7lzqLVE7U8AvtxQ/doUOHixlgky+qvd8KCAF/rQdfjZ8eIcEtoohCJ3CHvmHduwqIU+NyUOP7v0VBAFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mh8QCLsI; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d7431e702dso17376405ad.1;
        Thu, 08 Feb 2024 06:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707401672; x=1708006472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=SXyeGT+gH+mH78CTuKkjJZRZDJJBus+fYz/W9jL1sXU=;
        b=mh8QCLsIMaeroFLxTE6A7HTRb40i3wBVqmZxueiR1HOYirLK1/632IkRWiPswUEv9i
         JGHexifdPgKAdxbC26fiYorVcg7vBfYGIq6PSCNZIlFz0fPniZbx/Pa0dWmZDZfNo6K2
         7DfQp48sxUrcZ2F8VFcD51Fwmkf6DXCDiOZQY8EDguI4q06z+EdwfiIVXTpm+fJlmdBH
         RILbPgprwB76qudXi6GBEyhYcx0isJ0Fp2fx6uCg7Qfr6OvKWTezO1HJdM8lDcIEuYTf
         /874jZl4Xf8KrZr2teIp/rhG7wo0Q3epYajM37YawnKacldxAz2sqgrEkOnbIc7Vpz+o
         XcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707401672; x=1708006472;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXyeGT+gH+mH78CTuKkjJZRZDJJBus+fYz/W9jL1sXU=;
        b=NpT2fMdApJcPAdQA3PvKcBxFvO1zq0dmJ3T0lEy6SMhtA3JactoeLC+FkRKvytrBRR
         nuNWFbjHArMoxKVkHR+4vsGd0B05MjSX1sJULnk777EyX6UHqCRTwXjm8MbeX14TRi6L
         vj9HW0NxbBpULxJLmz/Vm/v2UGhBFIAZ1rvIls1q3Exo03VFTAmDSOrHjy/5K8Hld+IW
         xLCcVeVJxaDUnpR3ARxY/YpKsK6J0RpCdnKkkXi+786C9QsNeuJiIytrrNZaNaF5/iB6
         Rw35sNy0BwTx/P93aGNAtUM6Ys7F5dGc50UQHeiDkzl0scS139HIaX/n7vq49FFw3JVm
         F0Hw==
X-Gm-Message-State: AOJu0YziJswK39ETm8cTsx3LUrFh3s9G6FToSwUZ4Cj6s10iC34CVpih
	QDHeVqNjt/08rNzFH7oT4PYqiL65Vxef9ytD3xfbaZ3+KUp60Va2
X-Google-Smtp-Source: AGHT+IFKGZk4ENmslw0jsLzBOdtMR18kpwbpb3WP2OiYSYSvhlX4UTwhgd3uqhnPwWJ/8zUf1rZV8g==
X-Received: by 2002:a17:90b:1d07:b0:296:e32:bd5f with SMTP id on7-20020a17090b1d0700b002960e32bd5fmr6039011pjb.30.1707401671558;
        Thu, 08 Feb 2024 06:14:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUO0S46Y2Q499c7UXohCudub7YHSC8lOQkqQS/xFux4vAYTrUvwFXMEBmq0YzaeOWCwI4pV/0LsOZylVQaV7QrieKY/iPux2JDxzQphnM4qCyb21u0kh4x2i9v81ojcVyzZpPnLKRug8XHa3p7yu8nahBVP57LAVHpZ9+dNpGSxPPif8V14WqfjoiCBavsXlRzz85YINIkV
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h7-20020a17090a604700b00296e2434e7esm1531789pjm.53.2024.02.08.06.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 06:14:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2a6ab115-9775-447b-adf5-d63043548c74@roeck-us.net>
Date: Thu, 8 Feb 2024 06:14:29 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add support for Ayaneo Air Plus 7320u.
Content-Language: en-US
To: Sebastian Kranz <tklightforce@googlemail.com>
Cc: samsagax@gmail.com, derekjohn.clark@gmail.com, jdelvare@suse.com,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240207084206.2204-1-tklightforce@googlemail.com>
 <099bc4e3-ec08-4604-90cf-5691a98441b2@roeck-us.net>
 <332FEE3F-E07C-4144-933B-E085C2CB4E57@googlemail.com>
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
In-Reply-To: <332FEE3F-E07C-4144-933B-E085C2CB4E57@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/8/24 04:25, Sebastian Kranz wrote:
> Subject: [PATCH] hwmon: (oxp-sensors) Add Ayaneo Air Plus 7320u
> 

Not sure I understand what you are trying to say here. Yes, obviously
your patch has a subject. It still needs a description. See
"Describe your changes" in Documentation/process/submitting-patches.rst.

Guenter


