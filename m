Return-Path: <linux-kernel+bounces-145264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8B38A5197
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF681F24ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A4E73535;
	Mon, 15 Apr 2024 13:28:50 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC3673509;
	Mon, 15 Apr 2024 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187729; cv=none; b=RE671WWKxyURMQBJgFPvSdV9ir+mToDFP2V7/nqAxl2KTrUEZFB708eCHD2xouElpejWLgDp6zipX5Dw72fcAenoapE7OtOifkefwKPfTIwXTNcNvTQnd32G7giMuBV4D8lpP78DkVMGa6Acd9ExoXsmP3yqIMgEslOmnzS77Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187729; c=relaxed/simple;
	bh=Hkc/i5fQRWMyNfp/pkPP3vmKRGqAhBx5bs5wguZTaPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Phuy1Z2jJsKVlLYe+PEn/kaU84E7tj3sB77mdsSAQAXsRI0YUq98TbkityUeUxFtcbFKmmArRNnAjgybgIAVyY03kOhzZ+1u4xTsHlqz98yjqxpWqkjQ56niRGKmY5gUnt31nSghh6faQl3q8Opq0NjUK+JmWsFiD+A3plpxwvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-346b94fa7ecso3105004f8f.3;
        Mon, 15 Apr 2024 06:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187726; x=1713792526;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lrgrGzjjgYNJJjfx46YZRyvfOQXPcVBXxjVFNNCm2M=;
        b=XPgnxqT6dhAdZGCap2IOvCJwyeZx2+G8pQFnK10sp1nCOroPLNZvV3+IhUafXNHhUJ
         HozAVvAxJlj3ZxN90asL1WqYArXSy93tWiew6/zvvqWeev6bQoZ1baXtK4luJHB6Ggde
         yvEXrj5xFHQ8itmpvviI+npk/04OzH+OYTIv3Gjxhhwf7mtiQ6SCzQe1Gllave81GauH
         OBRxChR1aa3MsSxBAAM/jcqUx2QT1/wrxdoFlvfNC6c8WKAYjBtZGP5kAzVuRiC8JhN/
         8dTlKoO5yjpjNXrBu3xohYrotLe28hSgzqr6o/CDwwsqb3psUXo4A30Uuaj/Y4MIqBmi
         Plog==
X-Forwarded-Encrypted: i=1; AJvYcCXvlQ9vf9YW2owSrMoQ59H0vmDA4V4Gn6U17ANhr6+SWeY65q1TgH7Xzpp/f5WO31h6Kgb1SFjG7V4VwZbIuJq+K2L6IUaTqXdSiYKKI7HX+0tqqOe/zJRkNPD1Ay8HrjJ2+6Ns1tRL0yod3w==
X-Gm-Message-State: AOJu0YxOSINSKQDoP670G5VsnqUQ9thQFjJ9I/6JX9LrBve209B+hyBI
	UJvHsJtI6rwqkRr9xNMmkLhynF85H5Yy7APpdjlCYFtxqZCbFbOl
X-Google-Smtp-Source: AGHT+IEnVEco3CbkMrPnlNwXMvP9q4ttl9SGzT8tNl6Ytwu7CS/s3vEsYwkX2DFq4d51oKk++f2Lzw==
X-Received: by 2002:a5d:64e3:0:b0:346:4151:12c4 with SMTP id g3-20020a5d64e3000000b00346415112c4mr11291238wri.10.1713187726032;
        Mon, 15 Apr 2024 06:28:46 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id t7-20020adfe447000000b00343eac2acc4sm12148705wrm.111.2024.04.15.06.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 06:28:44 -0700 (PDT)
Message-ID: <d70049d5-d0fe-465f-a558-45b6785f6014@kernel.org>
Date: Mon, 15 Apr 2024 15:28:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] tty: serial: switch from circ_buf to kfifo
To: Marek Szyprowski <m.szyprowski@samsung.com>, gregkh@linuxfoundation.org,
 linux-amlogic@lists.infradead.org,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20240405060826.2521-1-jirislaby@kernel.org>
 <20240405060826.2521-13-jirislaby@kernel.org>
 <CGME20240415125847eucas1p2bc180c35f40f9c490c713679871af9ae@eucas1p2.samsung.com>
 <91ac609b-0fae-4856-a2a6-636908d7ad3c@samsung.com>
Content-Language: en-US
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
In-Reply-To: <91ac609b-0fae-4856-a2a6-636908d7ad3c@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15. 04. 24, 14:58, Marek Szyprowski wrote:
> Dear All,
> 
> On 05.04.2024 08:08, Jiri Slaby (SUSE) wrote:
>> Switch from struct circ_buf to proper kfifo. kfifo provides much better
>> API, esp. when wrap-around of the buffer needs to be taken into account.
>> Look at pl011_dma_tx_refill() or cpm_uart_tx_pump() changes for example.
>>
>> Kfifo API can also fill in scatter-gather DMA structures, so it easier
>> for that use case too. Look at lpuart_dma_tx() for example. Note that
>> not all drivers can be converted to that (like atmel_serial), they
>> handle DMA specially.
>>
>> Note that usb-serial uses kfifo for TX for ages.
>>
>> omap needed a bit more care as it needs to put a char into FIFO to start
>> the DMA transfer when OMAP_DMA_TX_KICK is set. In that case, we have to
>> do kfifo_dma_out_prepare twice: once to find out the tx_size (to find
>> out if it is worths to do DMA at all -- size >= 4), the second time for
>> the actual transfer.
>>
>> All traces of circ_buf are removed from serial_core.h (and its struct
>> uart_state).
>>
>> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
>> ...
> 
> This patch landed in linux-next as commit 1788cf6a91d9 ("tty: serial:
> switch from circ_buf to kfifo"). Unfortunately it breaks UART operation
> on thr Amlogic Meson based boards (drivers/tty/serial/meson_uart.c
> driver) and Qualcomm RB5 board (drivers/tty/serial/qcom_geni_serial.c).
> Once the init process is started, a complete garbage is printed to the
> serial console. Here is an example how it looks:

Oh my!

Both drivers move the tail using both kfifo and uart_xmit_advance() 
interfaces. Bah. Does it help to remove that uart_xmit_advance() for 
both of them? (TX stats will be broken.)

Users of uart_port_tx() are not affected.

This is my fault when merging uart_xmit_advance() with this series.

thanks,
-- 
js
suse labs


