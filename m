Return-Path: <linux-kernel+bounces-111276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0EF886A00
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF70B1F267C9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BF63219F;
	Fri, 22 Mar 2024 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tgCGwem6"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C037282FE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711102456; cv=none; b=JqZTABh3N84wr7e3Z2o6wbdfeY02EmVzFXlDUcQgJDHMAoSbpIZoETHoGYwoiMa06x5pkOOMG6oR9jtDRM1gJV+55IHCG6EIDmZFzAjDkECqA4bpMamgthzp7f/0rOokcnskcO7KspBeopfBEukB9XGYIFoLW4Sv1EzyG2yRlO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711102456; c=relaxed/simple;
	bh=WMFeu+j2iiU36qC4wXma6HUaUVDLeBLZufALRk+rXWI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tBPcVWu3E4fFYkrfDYIJGejLsFbjL1j2kLos1Uabj3t/qvyLDhEpV8KX8NaQ7ZrQCRl+Okks4TTFMshAv/ABS56pNkYfwJNPrzvayLSLCTzmKPRT6jmTit5eEyYOzypGRM4mDydlElP061ZcCbCjCAEWQmQ2ZZs6GVjGGiQUIpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tgCGwem6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4146fe16a1aso15051425e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 03:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711102453; x=1711707253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DOf1xm2Wbn7WqqM5LpTuhpZlLrziWVP3OvZukZiG1Ck=;
        b=tgCGwem65dfK05lSIbTySzEQTk062HwlFplbgiK5/y0B8QX3guB2V+1FWOBimHCx4F
         ZTXB8VNZupZWMPf7dVXSMw7huCDxwIqjj6yvZknLExT8yZFQiMKga6VHsUWax++0Vb0w
         dbhs2nbARfTyP0wpbdkGAaXMzFC4aOHw3/sJlHFqRZIB72cmgo9MuG+2ToWbq5z40gKt
         V6fmLpVSXljNZ2XKAdV4x3Zj8YPiS92s+5Cu7gTzW3i7x4hhVNx0+vSMDvVHYnkimCEG
         xYIVp7IkCM0E1QBWZeoeFKV/mUNq4mwmtoXWX62RcUNqkF3jnm9/9ii5Gl3/DuIqJkHx
         OZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711102453; x=1711707253;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DOf1xm2Wbn7WqqM5LpTuhpZlLrziWVP3OvZukZiG1Ck=;
        b=fmaEINXk/8Rkzoatajpog9lS7S5IqHYWkcQWQ/85r5UdKKMb/t0ombMOA+3mQ5y4lJ
         y2R6eGV4SAjUx060P40Zab8ZY2jle+RuLgpNjgSJBv9G4JJhN/VHnp2XVGwnVev2GN9F
         iF0zAY7m06KsMSO2GqSmv9u3Mb40Iqe4Ze3d6prbck6QUMEwgD5YuTuI4V8zPMixtPsJ
         AhY2VTHY0M4MpqJh5+++5MScsQbM+VmauauuKN5HcoFs9fr54xJnIh884APhAUnE9zfD
         cOK8foCCHPMijJxvTFCNcsjUKHzGkNrVdP/rc3G8sdhmnyIZn0COe1ScC+8G8RqQN38z
         Nmag==
X-Forwarded-Encrypted: i=1; AJvYcCVEB/YbvhEcyGHXMHW53z9SZ7t/pMZC1Nw+UJ62e0hvfE2x9gF0FClZUQLhMebccDbHNFhRY6ibT06ZNRCJrw90sDteArm8qXkTBGsd
X-Gm-Message-State: AOJu0YzWrJTfned2jaxFclerL4WW7/6qfvuUC7JpQByo70SxPSvpzhxj
	uHKhTlPLn/NEiWvxKtbwSiH67AGAL4kMEzNERnflMIIsArGkDV5xNYCsO3n64cA=
X-Google-Smtp-Source: AGHT+IEpZLhHtN9no5st6JD8bO8E6gGN/hMjnnh806usH+5rVCCOArNkPL1sv8V/dFDNNeytPOVSQQ==
X-Received: by 2002:a05:600c:4690:b0:412:f015:6fa6 with SMTP id p16-20020a05600c469000b00412f0156fa6mr1370398wmo.28.1711102452932;
        Fri, 22 Mar 2024 03:14:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:3ee1:a278:2b57:55f7? ([2a01:e0a:982:cbb0:3ee1:a278:2b57:55f7])
        by smtp.gmail.com with ESMTPSA id e13-20020a05600c4e4d00b004146750314csm8493505wmq.3.2024.03.22.03.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 03:14:12 -0700 (PDT)
Message-ID: <3080f43a-1a10-4c63-8265-fda2284354e1@linaro.org>
Date: Fri, 22 Mar 2024 11:14:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 09/21] drivers: crypto: meson: process more than
 MAXDESCS descriptors
To: Corentin Labbe <clabbe.montjoie@gmail.com>,
 Alexey Romanov <avromanov@salutedevices.com>
Cc: clabbe@baylibre.com, herbert@gondor.apana.org.au, davem@davemloft.net,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, vadim.fedorenko@linux.dev,
 linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@salutedevices.com
References: <20240301132936.621238-1-avromanov@salutedevices.com>
 <20240301132936.621238-10-avromanov@salutedevices.com> <Zf1BAlYtiwPOG-Os@Red>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <Zf1BAlYtiwPOG-Os@Red>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/03/2024 09:27, Corentin Labbe wrote:
> Le Fri, Mar 01, 2024 at 04:29:24PM +0300, Alexey Romanov a écrit :
>> 1. The old alhorithm was not designed to process a large
>> amount of memory, and therefore gave incorrect results.
>>
>> 2. Not all Amlogic SoC's use 3 KEY/IV descriptors.
>> Add keyiv descriptors count parameter to platform data.
>>
>> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
>> ---
>>   drivers/crypto/amlogic/amlogic-gxl-cipher.c | 441 ++++++++++++--------
>>   drivers/crypto/amlogic/amlogic-gxl-core.c   |   1 +
>>   drivers/crypto/amlogic/amlogic-gxl.h        |   2 +
>>   3 files changed, 280 insertions(+), 164 deletions(-)
>>
> 
> Hello
> 
> I have started to test by adding patch one by one and when testing this one I got:
> [   21.674995] gxl-crypto c883e000.crypto: will run requests pump with realtime priority
> [   21.679686] gxl-crypto c883e000.crypto: will run requests pump with realtime priority
> [   21.704366] ------------[ cut here ]------------
> [   21.704480] DMA-API: gxl-crypto c883e000.crypto: device driver tries to sync DMA memory it has not allocated [device address=0x000000000264c000] [size=48 bytes]
> [   21.717684] WARNING: CPU: 1 PID: 263 at kernel/dma/debug.c:1105 check_sync+0x1d0/0x688
> [   21.725512] Modules linked in: meson_rng meson_gxbb_wdt rng_core amlogic_gxl_crypto(+) meson_canvas libphy(+) watchdog ghash_generic gcm xctr xts cts essiv authenc cmac xcbc ccm
> [   21.741211] CPU: 1 PID: 263 Comm: c883e000.crypto Not tainted 6.8.0-rc1-00052-g595d4248b127 #24
> [   21.749834] Hardware name: Libre Computer AML-S905X-CC (DT)
> [   21.755353] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   21.762252] pc : check_sync+0x1d0/0x688
> [   21.766047] lr : check_sync+0x1d0/0x688
> [   21.769842] sp : ffff8000820fbb40
> [   21.773119] x29: ffff8000820fbb40 x28: 0000000000000000 x27: 0000000000000000
> [   21.780192] x26: ffff800081d639d0 x25: 0000000000001327 x24: ffff00000288b010
> [   21.787265] x23: 0000000000000050 x22: 0000000000001327 x21: ffff800081c23a20
> [   21.794336] x20: ffff800080fe0bb8 x19: ffff8000820fbbc0 x18: 0000000000000006
> [   21.801410] x17: 645b206465746163 x16: 6f6c6c6120746f6e x15: ffff8000820fb540
> [   21.808482] x14: 000000000000000b x13: ffff800081002748 x12: 0000000000000249
> [   21.815554] x11: 00000000000000c3 x10: ffff80008105a748 x9 : ffff800081002748
> [   21.822626] x8 : 00000000ffffefff x7 : ffff80008105a748 x6 : 80000000fffff000
> [   21.829700] x5 : ffff00007d9abb08 x4 : 0000000000000000 x3 : 0000000000000027
> [   21.836772] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff00000b314ec0
> [   21.843844] Call trace:
> [   21.846260]  check_sync+0x1d0/0x688
> [   21.849710]  debug_dma_sync_single_for_device+0xb8/0xc0
> [   21.854885]  dma_sync_single_for_device+0xc0/0x11c
> [   21.859628]  meson_handle_cipher_request+0x49c/0x7c4 [amlogic_gxl_crypto]
> [   21.866356]  crypto_pump_work+0x160/0x2ac
> [   21.870324]  kthread_worker_fn+0xe4/0x300
> [   21.874291]  kthread+0x11c/0x120
> [   21.877483]  ret_from_fork+0x10/0x20
> [   21.881020] irq event stamp: 9880
> [   21.884296] hardirqs last  enabled at (9879): [<ffff800080988834>] _raw_spin_unlock_irqrestore+0x6c/0x70
> [   21.893698] hardirqs last disabled at (9880): [<ffff800080987ca0>] _raw_spin_lock_irqsave+0x84/0x88
> [   21.902668] softirqs last  enabled at (5638): [<ffff800080010674>] __do_softirq+0x494/0x4dc
> [   21.910947] softirqs last disabled at (5627): [<ffff8000800161f0>] ____do_softirq+0x10/0x1c
> [   21.919227] ---[ end trace 0000000000000000 ]---

I confirm I see the same starting with this change with DMA_API_DEBUG=1

[    4.745240] ------------[ cut here ]------------
[    4.745295] DMA-API: gxl-crypto c883e000.crypto: device driver tries to sync DMA memory it has not allocated [device address=0x000000000a816030] [size=16 bytes]
[    4.758496] WARNING: CPU: 3 PID: 75 at kernel/dma/debug.c:1105 check_sync+0x1d8/0x690
[    4.766242] Modules linked in:
[    4.769258] CPU: 3 PID: 75 Comm: c883e000.crypto Not tainted 6.8.0-rc6-next-20240229-g99fbe5828431 #167
[    4.778576] Hardware name: Libre Computer AML-S905X-CC (DT)
[    4.784094] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    4.790993] pc : check_sync+0x1d8/0x690
[    4.794786] lr : check_sync+0x1d8/0x690
[    4.798581] sp : ffff800082563b90
[    4.801859] x29: ffff800082563b90 x28: ffff8000816ef298 x27: 0000000000000000
[    4.808934] x26: ffff0000041ed010 x25: 0000000000000018 x24: 0000000000004000
[    4.816006] x23: ffff8000816d1190 x22: 0000000000004000 x21: ffff800081539b50
[    4.823079] x20: ffff800082563c40 x19: ffff8000816ef2b0 x18: 0000000000000030
[    4.830151] x17: 645b206465746163 x16: 6f6c6c6120746f6e x15: 0720072007200720
[    4.837223] x14: ffff80008154f2c0 x13: 00000000000002a6 x12: 00000000000000e2
[    4.844296] x11: 0720072007200720 x10: ffff8000815a72c0 x9 : 00000000fffff000
[    4.851369] x8 : ffff80008154f2c0 x7 : ffff8000815a72c0 x6 : 0000000000000000
[    4.858441] x5 : 80000000fffff000 x4 : 000000000000aff5 x3 : 0000000000000000
[    4.865514] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000091a9100
[    4.872587] Call trace:
[    4.874999]  check_sync+0x1d8/0x690
[    4.878449]  debug_dma_sync_single_for_cpu+0x84/0x8c
[    4.883366]  dma_sync_single_for_cpu+0x58/0x10c
[    4.887851]  meson_handle_cipher_request+0x3b0/0x780
[    4.892767]  crypto_pump_work+0x15c/0x2bc
[    4.896734]  kthread_worker_fn+0xcc/0x184
[    4.900702]  kthread+0x118/0x11c
[    4.903893]  ret_from_fork+0x10/0x20
[    4.907430] ---[ end trace 0000000000000000 ]---

Thanks,
Neil

> 
> Regards


