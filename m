Return-Path: <linux-kernel+bounces-96718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF4C87608E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC541C209D4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F0952F84;
	Fri,  8 Mar 2024 09:01:22 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBF822626;
	Fri,  8 Mar 2024 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709888482; cv=none; b=ffSBJWSQNvUkjFSL6RrMq0LkP/L8LLAjSoKC32qMVG8JZ356A2ExquYLBdGJ/+7aJ1+iP809+sqZIYWoV1+T41QbA8QKxQ7EkoBEjVcrMalOfZQ+uIV6zHtqQJ6SjvVtxdb5CzSVQYHqXhq8T5Q9Vt43NvIBYGt7euFFTebCgmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709888482; c=relaxed/simple;
	bh=4WtSez7y1sqvueVAuL6wTOF2ze6LwK0nsEL149t47kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hD8DoPtOUiERZfA5BctWMGw2rHkSBKzTZQs70HK4QYPNKzaFwAHuTb1dy8hWi5Uv+mWLMQH6zk93NoMRMerFiuNX9F1q5pY22vf/vGDtrtxiQ+v45kAddLrLjt0SqcXclgpZoiF6ldAaHVaKq3lmgGcqzFT079fOsU/vqEqEuqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5131c48055cso2082313e87.1;
        Fri, 08 Mar 2024 01:01:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709888478; x=1710493278;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LvXW3E9+jESnoQTbwbLGyAfHW50wx/fOEE3g4YMyjXc=;
        b=RU5zSw/679YNqyjWwXc78/VIIm97gF3debG8wUjQS4gsHjkxX73ldglE2uFJXpFg4s
         tx8IZff5Mq3kik36FgUyKos1VozEF/Hko4uzZbPiPDo+ndENo2JR4AO/tiIA9lIn4WDr
         CU5V0z/Kb86Br45LZYjp1KqQObOmemwrrprynpF+5P+R7JKkNaHtOP2KKxxopd4AXqj6
         Ius0K7EOw8X3mpKnyhXCCBpcXX0SpRMtKhBsOU8Z7jPV9aN7DUlQXyVvIMVkXOr/lhD6
         qETWPVC9mN1SWJOM3Prbzq0fThiXdl4cc9wl40X876R3EX2OHg+Q7YQHLhhE/pnugLPS
         wD1g==
X-Forwarded-Encrypted: i=1; AJvYcCUm34+yIA8Dt1O38UGg5DfWD8p8qd2paUmfYgvDJ5m/Bdevy7yrsI+yprxVXj56CkmDKLtPmlk4/9G+Y286FjAOM2iULCLqqeZCnw==
X-Gm-Message-State: AOJu0YyDUbrKSg3npG72pK4IEDjReWfi0KsVqEbYl4rEZIsVbkCiiR69
	AmUGd4PJhif+PyOSu7pmWNv7WEtaGE5L3UnY6EIix/ExpQN7g9nYU8GjrGoYppc=
X-Google-Smtp-Source: AGHT+IEpfi//nVxJAnor4NCJHc24VK9+4TcCXQ2ack4X582bj8gaaQgw+Y6kEUma9tpfLA4BKEz5TA==
X-Received: by 2002:ac2:47ea:0:b0:512:d88a:3a8f with SMTP id b10-20020ac247ea000000b00512d88a3a8fmr2867729lfp.25.1709888477500;
        Fri, 08 Mar 2024 01:01:17 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c444900b00412f8bf2d82sm5183960wmn.28.2024.03.08.01.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 01:01:16 -0800 (PST)
Message-ID: <c46cc960-1b7c-4e61-977a-f22ea5fdd944@kernel.org>
Date: Fri, 8 Mar 2024 10:01:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] EDAC: remove unused structure members
Content-Language: en-US
To: bp@alien8.de
Cc: linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
 Bjorn Andersson <andersson@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
 Douglas Thompson <dougthompson@xmission.com>,
 James Morse <james.morse@arm.com>, Jan Luebbe <jlu@pengutronix.de>,
 Johannes Thumshirn <morbidrsa@gmail.com>,
 Khuong Dinh <khuong@os.amperecomputing.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, linux-edac@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Ralf Baechle
 <ralf@linux-mips.org>, Robert Richter <rric@kernel.org>,
 Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
 Tony Luck <tony.luck@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>
References: <20240213112051.27715-1-jirislaby@kernel.org>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 xsFNBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABzSFKaXJpIFNsYWJ5
 IDxqaXJpc2xhYnlAa2VybmVsLm9yZz7CwXcEEwEIACEFAlW3RUwCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AACgkQvSWxBAa0cEnVTg//TQpdIAr8Tn0VAeUjdVIH9XCFw+cPSU+zMSCH
 eCZoA/N6gitEcnvHoFVVM7b3hK2HgoFUNbmYC0RdcSc80pOF5gCnACSP9XWHGWzeKCARRcQR
 4s5YD8I4VV5hqXcKo2DFAtIOVbHDW+0okOzcecdasCakUTr7s2fXz97uuoc2gIBB7bmHUGAH
 XQXHvdnCLjDjR+eJN+zrtbqZKYSfj89s/ZHn5Slug6w8qOPT1sVNGG+eWPlc5s7XYhT9z66E
 l5C0rG35JE4PhC+tl7BaE5IwjJlBMHf/cMJxNHAYoQ1hWQCKOfMDQ6bsEr++kGUCbHkrEFwD
 UVA72iLnnnlZCMevwE4hc0zVhseWhPc/KMYObU1sDGqaCesRLkE3tiE7X2cikmj/qH0CoMWe
 gjnwnQ2qVJcaPSzJ4QITvchEQ+tbuVAyvn9H+9MkdT7b7b2OaqYsUP8rn/2k1Td5zknUz7iF
 oJ0Z9wPTl6tDfF8phaMIPISYrhceVOIoL+rWfaikhBulZTIT5ihieY9nQOw6vhOfWkYvv0Dl
 o4GRnb2ybPQpfEs7WtetOsUgiUbfljTgILFw3CsPW8JESOGQc0Pv8ieznIighqPPFz9g+zSu
 Ss/rpcsqag5n9rQp/H3WW5zKUpeYcKGaPDp/vSUovMcjp8USIhzBBrmI7UWAtuedG9prjqfO
 wU0ETpLnhgEQAM+cDWLL+Wvc9cLhA2OXZ/gMmu7NbYKjfth1UyOuBd5emIO+d4RfFM02XFTI
 t4MxwhAryhsKQQcA4iQNldkbyeviYrPKWjLTjRXT5cD2lpWzr+Jx7mX7InV5JOz1Qq+P+nJW
 YIBjUKhI03ux89p58CYil24Zpyn2F5cX7U+inY8lJIBwLPBnc9Z0An/DVnUOD+0wIcYVnZAK
 DiIXODkGqTg3fhZwbbi+KAhtHPFM2fGw2VTUf62IHzV+eBSnamzPOBc1XsJYKRo3FHNeLuS8
 f4wUe7bWb9O66PPFK/RkeqNX6akkFBf9VfrZ1rTEKAyJ2uqf1EI1olYnENk4+00IBa+BavGQ
 8UW9dGW3nbPrfuOV5UUvbnsSQwj67pSdrBQqilr5N/5H9z7VCDQ0dhuJNtvDSlTf2iUFBqgk
 3smln31PUYiVPrMP0V4ja0i9qtO/TB01rTfTyXTRtqz53qO5dGsYiliJO5aUmh8swVpotgK4
 /57h3zGsaXO9PGgnnAdqeKVITaFTLY1ISg+Ptb4KoliiOjrBMmQUSJVtkUXMrCMCeuPDGHo7
 39Xc75lcHlGuM3yEB//htKjyprbLeLf1y4xPyTeeF5zg/0ztRZNKZicgEmxyUNBHHnBKHQxz
 1j+mzH0HjZZtXjGu2KLJ18G07q0fpz2ZPk2D53Ww39VNI/J9ABEBAAHCwV8EGAECAAkFAk6S
 54YCGwwACgkQvSWxBAa0cEk3tRAAgO+DFpbyIa4RlnfpcW17AfnpZi9VR5+zr496n2jH/1ld
 wRO/S+QNSA8qdABqMb9WI4BNaoANgcg0AS429Mq0taaWKkAjkkGAT7mD1Q5PiLr06Y/+Kzdr
 90eUVneqM2TUQQbK+Kh7JwmGVrRGNqQrDk+gRNvKnGwFNeTkTKtJ0P8jYd7P1gZb9Fwj9YLx
 jhn/sVIhNmEBLBoI7PL+9fbILqJPHgAwW35rpnq4f/EYTykbk1sa13Tav6btJ+4QOgbcezWI
 wZ5w/JVfEJW9JXp3BFAVzRQ5nVrrLDAJZ8Y5ioWcm99JtSIIxXxt9FJaGc1Bgsi5K/+dyTKL
 wLMJgiBzbVx8G+fCJJ9YtlNOPWhbKPlrQ8+AY52Aagi9WNhe6XfJdh5g6ptiOILm330mkR4g
 W6nEgZVyIyTq3ekOuruftWL99qpP5zi+eNrMmLRQx9iecDNgFr342R9bTDlb1TLuRb+/tJ98
 f/bIWIr0cqQmqQ33FgRhrG1+Xml6UXyJ2jExmlO8JljuOGeXYh6ZkIEyzqzffzBLXZCujlYQ
 DFXpyMNVJ2ZwPmX2mWEoYuaBU0JN7wM+/zWgOf2zRwhEuD3A2cO2PxoiIfyUEfB9SSmffaK/
 S4xXoB6wvGENZ85Hg37C7WDNdaAt6Xh2uQIly5grkgvWppkNy4ZHxE+jeNsU7tg=
In-Reply-To: <20240213112051.27715-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Any plans on looking into/commenting/merging this :)?

On 13. 02. 24, 12:20, Jiri Slaby (SUSE) wrote:
> Hi,
> 
> this series removes unused EDAC structure members as found by
> clang-struct (and manually checked by me).
> 
> I admit I could not even compile-test octeon files, hopefully
> kernel-test robot would catch mistakes in there.
> 
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Douglas Thompson <dougthompson@xmission.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Jan Luebbe <jlu@pengutronix.de>
> Cc: Johannes Thumshirn <morbidrsa@gmail.com>
> Cc: Khuong Dinh <khuong@os.amperecomputing.com>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Cc: linux-edac@vger.kernel.org
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Robert Richter <rric@kernel.org>
> Cc: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Jiri Slaby (SUSE) (7):
>    EDAC/amd64: Remove amd64_pvt::ext_nbcfg
>    EDAC/device: Remove edac_dev_sysfs_block_attribute::{block,value}
>    EDAC/device: Remove edac_dev_sysfs_block_attribute::store()
>    EDAC: Remove dynamic attributes from edac_device_alloc_ctl_info()
>    EDAC: Remove edac_pci_ctl_info::edac_subsys
>    EDAC: Remove edac_pci_ctl_info::complete
>    EDAC: Remove edac_device_ctl_info::removal_complete
> 
>   drivers/edac/altera_edac.c       |  8 ++---
>   drivers/edac/amd64_edac.h        |  1 -
>   drivers/edac/amd8111_edac.c      |  3 +-
>   drivers/edac/armada_xp_edac.c    |  2 +-
>   drivers/edac/cpc925_edac.c       |  2 +-
>   drivers/edac/edac_device.c       | 53 ++------------------------------
>   drivers/edac/edac_device.h       | 22 ++-----------
>   drivers/edac/edac_device_sysfs.c | 22 ++-----------
>   drivers/edac/edac_pci.h          |  5 ---
>   drivers/edac/highbank_l2_edac.c  |  2 +-
>   drivers/edac/mpc85xx_edac.c      |  2 +-
>   drivers/edac/octeon_edac-l2c.c   |  2 +-
>   drivers/edac/octeon_edac-pc.c    |  2 +-
>   drivers/edac/qcom_edac.c         |  1 -
>   drivers/edac/sifive_edac.c       |  3 +-
>   drivers/edac/thunderx_edac.c     |  6 ++--
>   drivers/edac/xgene_edac.c        | 10 +++---
>   drivers/edac/zynqmp_edac.c       |  2 +-
>   18 files changed, 26 insertions(+), 122 deletions(-)
> 

-- 
js
suse labs


