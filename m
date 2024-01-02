Return-Path: <linux-kernel+bounces-14786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AB3822256
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19C48B225DE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0477616406;
	Tue,  2 Jan 2024 19:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hD49ufOu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8AC168A4;
	Tue,  2 Jan 2024 19:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a279ce3aab9so356709066b.0;
        Tue, 02 Jan 2024 11:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704225381; x=1704830181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aI7spMTV6CKlgvG4WBtP/EUsuNOkjp9RFAnmt60+P4g=;
        b=hD49ufOuXoEL7Qy0xM/p8drlRVWPEnaDABJNeg9+ZgaD8jjl7zsRNy0hQU+F/Frr21
         NvvrFRQ6CN8xAxnS/VZA2tESc+ss2WbnPFLAtKaSMP2zgWcT1op/Mvh7DgGDF4jk+V2z
         HWUFNjheEZutkj9wvHKCLExVt6biYmX1tbN5FBbruxVcRMmYYUf0V99c4Gg9grv4oBK6
         LNFM/FDKrZIWfCw5M3mwdnrROIsRsmQvn1LPbO1wPlqfNiBb/gYrSIL1rcN2/2nZRLeD
         rXf6v8qECuZVHs0QY7I+RNImNMU58J5cc1fb+XYXeQTqQY3uL70iddhNHA67yEzzzlVV
         Ro9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704225381; x=1704830181;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aI7spMTV6CKlgvG4WBtP/EUsuNOkjp9RFAnmt60+P4g=;
        b=mlPXoZsbGCedjSyO8LHMx1BjHx/Fh8ya6EEcBId1eL0PgYZwMvT/qPI+PGG92hvzLP
         8bTLiQg5uV2zJnnjWavbUm9Cifbk9fw5aHyCWrFbHtY4gCFtI1jw9n6woSg0rGGgBVQg
         nVswMpTQ84Xdcexn5iUng1+pjtJn2ErV17obdMnxABmY7g3F29Hxn7ko1auqpmiUfaxA
         T96LTYdQs3NRBhec8JS2UKpnjJotmSSNQhD9GSgvDZ6/c57VW6flEsRdc2zgcrK/uOjR
         DXin+rzDh4tRrA6NPEL9rWOUWcLGgPxI/pgyW6Qn+WRG5SJXu/0H2j9d76+lw8g01xnj
         y/Gw==
X-Gm-Message-State: AOJu0YypXCNnhVa+KfnItM2fLLexHky3cTrJEu73hJDN5hDBSPnD5EAZ
	t/B00CXDgU6qAsO/hxEk7go=
X-Google-Smtp-Source: AGHT+IFtvZpVbiuj4pGgF1iExi9HBdS5n2jo7O3KbABu/XLr1aQneJT/WWv7ACIrbWDWtQn1uqSy9g==
X-Received: by 2002:a17:906:88d:b0:a22:ebed:863 with SMTP id n13-20020a170906088d00b00a22ebed0863mr3400516eje.207.1704225380939;
        Tue, 02 Jan 2024 11:56:20 -0800 (PST)
Received: from ?IPV6:2a01:c23:c1df:9400:e9d7:fbcb:4065:ab66? (dynamic-2a01-0c23-c1df-9400-e9d7-fbcb-4065-ab66.c23.pool.telefonica.de. [2a01:c23:c1df:9400:e9d7:fbcb:4065:ab66])
        by smtp.googlemail.com with ESMTPSA id vz16-20020a17090704d000b00a2471bb0d11sm11982894ejb.31.2024.01.02.11.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 11:56:20 -0800 (PST)
Message-ID: <d8fc6f4f-7458-4c67-a6e1-5a917ad95507@gmail.com>
Date: Tue, 2 Jan 2024 20:56:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Jan 2 (net/ethernet/realtek/r8169)
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 nic_swsd@realtek.com, Network Development <netdev@vger.kernel.org>,
 "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <20240102165725.6d18cc50@canb.auug.org.au>
 <a80c1568-7742-4938-a460-d8a5170ae24b@infradead.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 xsFNBF/0ZFUBEAC0eZyktSE7ZNO1SFXL6cQ4i4g6Ah3mOUIXSB4pCY5kQ6OLKHh0FlOD5/5/
 sY7IoIouzOjyFdFPnz4Bl3927ClT567hUJJ+SNaFEiJ9vadI6vZm2gcY4ExdIevYHWe1msJF
 MVE4yNwdS+UsPeCF/6CQQTzHc+n7DomE7fjJD5J1hOJjqz2XWe71fTvYXzxCFLwXXbBiqDC9
 dNqOe5odPsa4TsWZ09T33g5n2nzTJs4Zw8fCy8rLqix/raVsqr8fw5qM66MVtdmEljFaJ9N8
 /W56qGCp+H8Igk/F7CjlbWXiOlKHA25mPTmbVp7VlFsvsmMokr/imQr+0nXtmvYVaKEUwY2g
 86IU6RAOuA8E0J5bD/BeyZdMyVEtX1kT404UJZekFytJZrDZetwxM/cAH+1fMx4z751WJmxQ
 J7mIXSPuDfeJhRDt9sGM6aRVfXbZt+wBogxyXepmnlv9K4A13z9DVLdKLrYUiu9/5QEl6fgI
 kPaXlAZmJsQfoKbmPqCHVRYj1lpQtDM/2/BO6gHASflWUHzwmBVZbS/XRs64uJO8CB3+V3fa
 cIivllReueGCMsHh6/8wgPAyopXOWOxbLsZ291fmZqIR0L5Y6b2HvdFN1Xhc+YrQ8TKK+Z4R
 mJRDh0wNQ8Gm89g92/YkHji4jIWlp2fwzCcx5+lZCQ1XdqAiHQARAQABzSZIZWluZXIgS2Fs
 bHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPsLBjgQTAQgAOBYhBGxfqY/yOyXjyjJehXLe
 ig9U8DoMBQJf9GRVAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHLeig9U8DoMSycQ
 AJbfg8HZEK0ljV4M8nvdaiNixWAufrcZ+SD8zhbxl8GispK4F3Yo+20Y3UoZ7FcIidJWUUJL
 axAOkpI/70YNhlqAPMsuudlAieeYZKjIv1WV5ucNZ3VJ7dC+dlVqQdAr1iD869FZXvy91KhJ
 wYulyCf+s4T9YgmLC6jLMBZghKIf1uhSd0NzjyCqYWbk2ZxByZHgunEShOhHPHswu3Am0ftt
 ePaYIHgZs+Vzwfjs8I7EuW/5/f5G9w1vibXxtGY/GXwgGGHRDjFM7RSprGOv4F5eMGh+NFUJ
 TU9N96PQYMwXVxnQfRXl8O6ffSVmFx4H9rovxWPKobLmqQL0WKLLVvA/aOHCcMKgfyKRcLah
 57vGC50Ga8oT2K1g0AhKGkyJo7lGXkMu5yEs0m9O+btqAB261/E3DRxfI1P/tvDZpLJKtq35
 dXsj6sjvhgX7VxXhY1wE54uqLLHY3UZQlmH3QF5t80MS7/KhxB1pO1Cpcmkt9hgyzH8+5org
 +9wWxGUtJWNP7CppY+qvv3SZtKJMKsxqk5coBGwNkMms56z4qfJm2PUtJQGjA65XWdzQACib
 2iaDQoBqGZfXRdPT0tC1H5kUJuOX4ll1hI/HBMEFCcO8++Bl2wcrUsAxLzGvhINVJX2DAQaF
 aNetToazkCnzubKfBOyiTqFJ0b63c5dqziAgzsFNBF/0ZFUBEADF8UEZmKDl1w/UxvjeyAeX
 kghYkY3bkK6gcIYXdLRfJw12GbvMioSguvVzASVHG8h7NbNjk1yur6AONfbUpXKSNZ0skV8V
 fG+ppbaY+zQofsSMoj5gP0amwbwvPzVqZCYJai81VobefTX2MZM2Mg/ThBVtGyzV3NeCpnBa
 8AX3s9rrX2XUoCibYotbbxx9afZYUFyflOc7kEpc9uJXIdaxS2Z6MnYLHsyVjiU6tzKCiVOU
 KJevqvzPXJmy0xaOVf7mhFSNQyJTrZpLa+tvB1DQRS08CqYtIMxRrVtC0t0LFeQGly6bOngr
 ircurWJiJKbSXVstLHgWYiq3/GmCSx/82ObeLO3PftklpRj8d+kFbrvrqBgjWtMH4WtK5uN5
 1WJ71hWJfNchKRlaJ3GWy8KolCAoGsQMovn/ZEXxrGs1ndafu47yXOpuDAozoHTBGvuSXSZo
 ythk/0EAuz5IkwkhYBT1MGIAvNSn9ivE5aRnBazugy0rTRkVggHvt3/7flFHlGVGpBHxFUwb
 /a4UjJBPtIwa4tWR8B1Ma36S8Jk456k2n1id7M0LQ+eqstmp6Y+UB+pt9NX6t0Slw1NCdYTW
 gJezWTVKF7pmTdXszXGxlc9kTrVUz04PqPjnYbv5UWuDd2eyzGjrrFOsJEi8OK2d2j4FfF++
 AzOMdW09JVqejQARAQABwsF2BBgBCAAgFiEEbF+pj/I7JePKMl6Fct6KD1TwOgwFAl/0ZFUC
 GwwACgkQct6KD1TwOgxUfg//eAoYc0Vm4NrxymfcY30UjHVD0LgSvU8kUmXxil3qhFPS7KA+
 y7tgcKLHOkZkXMX5MLFcS9+SmrAjSBBV8omKoHNo+kfFx/dUAtz0lot8wNGmWb+NcHeKM1eb
 nwUMOEa1uDdfZeKef/U/2uHBceY7Gc6zPZPWgXghEyQMTH2UhLgeam8yglyO+A6RXCh+s6ak
 Wje7Vo1wGK4eYxp6pwMPJXLMsI0ii/2k3YPEJPv+yJf90MbYyQSbkTwZhrsokjQEaIfjrIk3
 rQRjTve/J62WIO28IbY/mENuGgWehRlTAbhC4BLTZ5uYS0YMQCR7v9UGMWdNWXFyrOB6PjSu
 Trn9MsPoUc8qI72mVpxEXQDLlrd2ijEWm7Nrf52YMD7hL6rXXuis7R6zY8WnnBhW0uCfhajx
 q+KuARXC0sDLztcjaS3ayXonpoCPZep2Bd5xqE4Ln8/COCslP7E92W1uf1EcdXXIrx1acg21
 H/0Z53okMykVs3a8tECPHIxnre2UxKdTbCEkjkR4V6JyplTS47oWMw3zyI7zkaadfzVFBxk2
 lo/Tny+FX1Azea3Ce7oOnRUEZtWSsUidtIjmL8YUQFZYm+JUIgfRmSpMFq8JP4VH43GXpB/S
 OCrl+/xujzvoUBFV/cHKjEQYBxo+MaiQa1U54ykM2W4DnHb1UiEf5xDkFd4=
In-Reply-To: <a80c1568-7742-4938-a460-d8a5170ae24b@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02.01.2024 18:02, Randy Dunlap wrote:
> 
> 
> On 1/1/24 21:57, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20231222:
>>
> 
> on ppc32:
> 
> when CONFIG_R8169=y and
> CONFIG_LEDS_TRIGGER_NETDEV=m, this part of the
> r8169 Makefile doesn't work as needed:
> 
> ifdef CONFIG_LEDS_TRIGGER_NETDEV
> r8169-objs += r8169_leds.o
> endif
> 
> causing
> 
> r8169_leds.c:(.text+0x97c): undefined reference to `devm_led_classdev_register_ext'
> 
> 
> Full randconfig file is attached.
> 
Thanks for the report. The issue is known and a fix has been submitted.
It's just not reviewed/applied yet.

https://lore.kernel.org/linux-leds/0f6f432b-c650-4bb8-a1b5-fe3372804d52@gmail.com/T/#u


