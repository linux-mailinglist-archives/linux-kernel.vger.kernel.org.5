Return-Path: <linux-kernel+bounces-152894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62918AC5DA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D570283E92
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1714F881;
	Mon, 22 Apr 2024 07:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LFyOavKO"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D644E1C8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713771845; cv=none; b=hixUg8KgLU0Vgplg386QelREienHYEd2zFi3PHGBn1+5TKIzIXwox2yXUsLJub51t/xq3vnvC+l+ds4xOPMw7oeBLJAyFl7xRvwNjRzJqNP6v0FFZ0R4xUxmNnpwMaeXlKb/3Msrkh6qBeovTtG079J+hcGUeNB0R6b00yx/8oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713771845; c=relaxed/simple;
	bh=ffLRdcaZUgrUwWcFf3srztERpUaDnshkDyUkPvhByj0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AhHGMpqEbeE9dx518ZxvkKPdkko8eGCeaw/DRUQDfJkgHBs7QLZs8fomKe1NctpWEbvdEQpWghstQlGDsImO9kQoN/QZPD8ezO+5c6G+IjxDpoST8ezk92URf+cmaddF/KIVcuoIQT7ik66GBHCaB2VRGck3dT9jEdZb/KykR7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LFyOavKO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41a7aa24c4fso1546035e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 00:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713771842; x=1714376642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8EACDU5ZIYK9Tlo7z1R2GyLFJTNAKhZcDGfQ+M5Qfec=;
        b=LFyOavKOWubM6eMsVFDgd84jWBEwl/EQW6AmgpK+yrjEng2xcCiRGCpmKCmqZh9wlE
         NvYoflA6IbYuKGm6KSQTDkkKiTMveWaTsecZk/KkxiROQdkBv9j82dpaM8kX7UsF/kvN
         +neGtfX9yLbbsotmS91pECZhS6ITSloDzMbrRZwezGsjwDnLpU9msegC06W4XCB1PpJ2
         m0Pq32+tME2go7tyn4+lf0rCiouglR0mROqowdr1sy3x3c+GqkbDMUHIm93vcXMNQEJ5
         ZfQvtpWog5/NwBhdzEZ3X0R+DbssXpaF2cJfHGQolnkqFPkB5KUd1Xkj1x8ANHYcF2sa
         pv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713771842; x=1714376642;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8EACDU5ZIYK9Tlo7z1R2GyLFJTNAKhZcDGfQ+M5Qfec=;
        b=LSfprk3zBkkFDcZ9h31JGmviTz222RJlIRq4JLH7cszykaKiZwqk/7lUpn+jWbW4Q5
         XMfJm3bswcrm2gJfFrWgLTYYjFcsGXJhsCYkAMfylSwf7KJLVb7jh5WdTsAYPIgYpFyC
         b9KWydoArXgkkGe0BuDKhsIDKp/x5QyQ+54i7HSpK+9o2KhNS2BqqQy1coFHrB0oEj59
         S4BErfUJ7RgZPStoOsVcV13VgS/HfxLvwXEpg6wp69V09uEjPPn36NnlZWbi3ea7XHor
         FEnKUhHU1n1xd90p19dMcT+iUc7qxhM4i0APui7PrDHqv+BMtRM+yNNjCknllONshSzv
         +g6A==
X-Forwarded-Encrypted: i=1; AJvYcCUu0j+rHPkN125pJ/DKVCcus4LnFcz61Kr3VgAezgz0Q7bkh0zd0srGG2CDuuD2bdZ6P0x4dm95uZAYvscrY97sAVlbdG4WCnmPFJi3
X-Gm-Message-State: AOJu0YyLmNpaXpxuwNLpRPlyY93boOHa9EZ3adXyeOcLUIfXdw4eJZfV
	MiO3FqfyHv0t9vQTP8XJkP/mTZx9rYo4OSeOXUfr75SA3IRi4/DttiVRP/UF4nM=
X-Google-Smtp-Source: AGHT+IEobCAD1woSZ5EJiB0NRH7BEjZlQI+0HXHHE4nnOPzWe+XQOjOdqoLZt1DsJbBVAkn1X3/8fw==
X-Received: by 2002:a05:600c:358c:b0:41a:3150:cbe7 with SMTP id p12-20020a05600c358c00b0041a3150cbe7mr2136856wmq.28.1713771842235;
        Mon, 22 Apr 2024 00:44:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e5e5:892f:e81f:7cad? ([2a01:e0a:982:cbb0:e5e5:892f:e81f:7cad])
        by smtp.gmail.com with ESMTPSA id a12-20020a056000100c00b00349ceadededsm11300565wrx.16.2024.04.22.00.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 00:44:01 -0700 (PDT)
Message-ID: <17308e8f-59a1-40aa-9d44-2fb998b9f39c@linaro.org>
Date: Mon, 22 Apr 2024 09:43:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 00/15] tty: serial: switch from circ_buf to kfifo
To: Jiri Slaby <jirislaby@kernel.org>, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Al Cooper <alcooperx@gmail.com>, Alexander Shiyan <shc_work@mail.ru>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Baruch Siach
 <baruch@tkos.co.il>, Bjorn Andersson <andersson@kernel.org>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 "David S. Miller" <davem@davemloft.net>, Fabio Estevam <festevam@gmail.com>,
 Hammer Hsieh <hammerh0314@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Chunyan Zhang <zhang.lyra@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Kevin Hilman <khilman@baylibre.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
 Laxman Dewangan <ldewangan@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <michal.simek@amd.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Nicholas Piggin <npiggin@gmail.com>, Orson Zhai <orsonzhai@gmail.com>,
 =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Peter Korsgaard <jacmet@sunsite.dk>,
 Richard Genoud <richard.genoud@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Stefani Seibold <stefani@seibold.net>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Taichi Sugaya <sugaya.taichi@socionext.com>,
 Takao Orito <orito.takao@socionext.com>,
 Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
 Thierry Reding <thierry.reding@gmail.com>, Timur Tabi <timur@kernel.org>,
 Vineet Gupta <vgupta@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>
References: <20240405060826.2521-1-jirislaby@kernel.org>
 <daf06969-15fd-470e-88b8-a717066fe312@linaro.org>
 <cebad7f8-3f47-4e6a-93b7-32fcf2367874@kernel.org>
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
In-Reply-To: <cebad7f8-3f47-4e6a-93b7-32fcf2367874@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jiri,

On 22/04/2024 07:51, Jiri Slaby wrote:
> Hi,
> 
> On 19. 04. 24, 17:12, Neil Armstrong wrote:
>> On 05/04/2024 08:08, Jiri Slaby (SUSE) wrote:
>>> This series switches tty serial layer to use kfifo instead of circ_buf.
>>>
>>> The reasoning can be found in the switching patch in this series:
>>> """
>>> Switch from struct circ_buf to proper kfifo. kfifo provides much better
>>> API, esp. when wrap-around of the buffer needs to be taken into account.
>>> Look at pl011_dma_tx_refill() or cpm_uart_tx_pump() changes for example.
>>>
>>> Kfifo API can also fill in scatter-gather DMA structures, so it easier
>>> for that use case too. Look at lpuart_dma_tx() for example. Note that
>>> not all drivers can be converted to that (like atmel_serial), they
>>> handle DMA specially.
>>>
>>> Note that usb-serial uses kfifo for TX for ages.
>>> """
> ...
>> This patchset has at least broken all Amlogic and Qualcomm boards so far, only part of them were fixed in next-
> 
> So are there still not fixed problems yet?

My last ci run on next-20240419 was still failing on db410c.

> 
>> but this serie has been merged in v1
> 
> Ugh, are you saying that v1 patches are not worth taking? That doesn't fit with my experience.

In my experience, most of my patches are taken in v2, it's not an uncommon thing to have more versions, especially when touching core subsystems.

> 
>> with no serious testing
> 
> Sadly, everyone had a chance to test the series:
>    https://lore.kernel.org/all/20240319095315.27624-1-jirislaby@kernel.org/
> for more than two weeks before I sent this version for inclusion. And then it took another 5 days till this series appeared in -next. But noone with this HW apparently cared enough back then. I'd wish they (you) didn't. Maybe next time, people will listen more carefully:
> ===
> This is Request for Testing as I cannot test all the changes
> (obviously). So please test your HW's serial properly.
> ===

This RFT was sent during the merge window, only a few people looks at the list between those 2 weeks.

> 
>> and should've been dropped immediately when the first regressions were reported.
> 
> Provided the RFT was mostly ignored (anyone who tested that here, or I only wasted my time?), how exactly would dropping help me finding potential issues in the series? In the end, noone is running -next in production, so glitches are sort of expected, right? And I believe I smashed them quickly enough (despite I was sidetracked to handle the n_gsm issue). But I might be wrong, as usual.

So since it was ignored, it's ok to apply it as-is ??????

> 
> So no, dropping is not helping moving forward, actions taken by e.g. Marek Szyprowski <m.szyprowski@samsung.com> do, IMNSHO.

well thanks to Marek, but most of Qualcomm maintainers and myself were in EOSS in Seattle for the week and came back home in Saturday, and we were busy. Hopefully Marek was available.

> 
> thanks,

Neil



