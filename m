Return-Path: <linux-kernel+bounces-151642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8FE8AB175
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7EA0282668
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344C212FF9C;
	Fri, 19 Apr 2024 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N7OnBW/U"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7801130481
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539571; cv=none; b=jHBkPg2b2J7m+0nGxvfzYEzcWAs+XVkAb0DwjnM+HjvoYJ+bkLaEaCfHHASj+YFgFr6eBz7zWsbKw8IhxLDUtpafX37tNf2MHFQtDMM+H2IxqB7bWeleFddVMLnbzZNdhay1atmejrAcEhL4QbyYJgNEyNolmwBFbsSf4veXHpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539571; c=relaxed/simple;
	bh=mvrrM+jr/Y8Xf+dCGXiUgKJZDiMoUWz8Taq5Ya9mM/M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Hfn1GGEuNzbDvoGzbXzqAK5/UZ2YPHg6/SbNCZFmbsAr0dPcJ8NBNMdOPI7TtyP2sdagVLR/L/BXcWIeaL3+IwYuH1t7FRoQUqycUDq505W5fVErlt/z1FIjCH97p7//Z0JoHqYTVYuCc4mEY4UacpRAQcJuiQtlS/1r1VQXLi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N7OnBW/U; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-415515178ceso15549375e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713539567; x=1714144367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5ZuguHl1WIthVgIS6SVDdUotl8VeoTv90hGCaxAnCA=;
        b=N7OnBW/UDfhzQu2pVKtXXHfW2Yt5r2QBgLV1JeSnAZUx8eWrqYqZGup40k8JlzGX17
         TVYd0vICCFukN9fvEBkmhMsxLZ2cmkqcvi5DC2EJZwXQ1J7rGg4SChHYFxs/oyVZhobD
         RVxsDBDeXkcu/BP0kRl8PSydacd+mBNyqyA65HzGC8EVbb5yezPVlYMf7mwxeQQskyav
         tQBzbgsw1wb1/2LrS6mH86HfroKh9HGAR0UO91u4nDQU88q9BUAsY/jWrl1uIQeTk+3Q
         snDQmAE/CnE1epdhz0tN18XKnxLCsPRnx8PTNHvO+Mvh/sl1bghNpVF58Fu4M4ToHm7q
         eZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713539567; x=1714144367;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G5ZuguHl1WIthVgIS6SVDdUotl8VeoTv90hGCaxAnCA=;
        b=bV2LMWdVSI98cUSwTeeZJJUUccv8h8VYRlSNOaS09Ln16Fp4bGU0ii8oMejxqPCrpm
         gsVmof4S9X0jmt5n58F7XyO5PdQxhGm5h/CU+RdWD0NBisC4CfGRys6+ychDCu1fncIC
         uqTNZM8SlozBdNNVukMOH7fMZ2dbVKgZyp4+fKgwk/mjQGYdJy85x/mD5EOcGIihzrnW
         YAUzZXa6Vv8UQZSdifZRSgiEWwKvuNU1CDmWgEtZgSNMe1pldHrYbNqVQn9MoXqYEKf6
         QKtTkxfZGLG3YQ4CYDgXVvbo0i/CzxLUixeqJCkSfyqxGE++k7EXh0vl6sG5JWO+wxWW
         NYCw==
X-Forwarded-Encrypted: i=1; AJvYcCW2qKuRG/13E+uU3gSm1uGQmVyoftwWshQ9GALyr60iln8+3WUz0EeDBApC+TQT7g0aMReIvEH1gBaU1dk1NM5QRpY0ba4FtYle4Heq
X-Gm-Message-State: AOJu0YxmLWDpWNT6rNq1JjAKmyvUuDLmgOKwI67mlI8H5+4RlzZrG3JQ
	srZ8Zn+qp/S/9SHWtBwuihQV5N0XZKGxWHNtJIQwbleQRDTPKOzQd7I3fX1JoXk=
X-Google-Smtp-Source: AGHT+IHRLP6S0mUdUcN0F9X4Pq0SavKgYUpuMvZngvfiE+0cpypCkKXdK4U4AZQ0UCerLgWzaSST9A==
X-Received: by 2002:a05:600c:470b:b0:418:e6fc:3708 with SMTP id v11-20020a05600c470b00b00418e6fc3708mr1419715wmo.24.1713539567015;
        Fri, 19 Apr 2024 08:12:47 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c511300b00417e36953a0sm6812262wms.20.2024.04.19.08.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 08:12:46 -0700 (PDT)
Message-ID: <daf06969-15fd-470e-88b8-a717066fe312@linaro.org>
Date: Fri, 19 Apr 2024 17:12:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 00/15] tty: serial: switch from circ_buf to kfifo
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, gregkh@linuxfoundation.org
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
 Vineet Gupta <vgupta@kernel.org>
References: <20240405060826.2521-1-jirislaby@kernel.org>
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
In-Reply-To: <20240405060826.2521-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jiri,

On 05/04/2024 08:08, Jiri Slaby (SUSE) wrote:
> This series switches tty serial layer to use kfifo instead of circ_buf.
> 
> The reasoning can be found in the switching patch in this series:
> """
> Switch from struct circ_buf to proper kfifo. kfifo provides much better
> API, esp. when wrap-around of the buffer needs to be taken into account.
> Look at pl011_dma_tx_refill() or cpm_uart_tx_pump() changes for example.
> 
> Kfifo API can also fill in scatter-gather DMA structures, so it easier
> for that use case too. Look at lpuart_dma_tx() for example. Note that
> not all drivers can be converted to that (like atmel_serial), they
> handle DMA specially.
> 
> Note that usb-serial uses kfifo for TX for ages.
> """
> 
> Cc: Al Cooper <alcooperx@gmail.com>
> Cc: Alexander Shiyan <shc_work@mail.ru>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Alim Akhtar <alim.akhtar@samsung.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Baruch Siach <baruch@tkos.co.il>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Hammer Hsieh <hammerh0314@gmail.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> Cc: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: "Pali Rohár" <pali@kernel.org>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Peter Korsgaard <jacmet@sunsite.dk>
> Cc: Richard Genoud <richard.genoud@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Stefani Seibold <stefani@seibold.net>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Taichi Sugaya <sugaya.taichi@socionext.com>
> Cc: Takao Orito <orito.takao@socionext.com>
> Cc: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Timur Tabi <timur@kernel.org>
> Cc: Vineet Gupta <vgupta@kernel.org>
> 
> Jiri Slaby (SUSE) (15):
>    kfifo: drop __kfifo_dma_out_finish_r()
>    kfifo: introduce and use kfifo_skip_count()
>    kfifo: add kfifo_out_linear{,_ptr}()
>    kfifo: remove support for physically non-contiguous memory
>    kfifo: rename l to len_to_end in setup_sgl()
>    kfifo: pass offset to setup_sgl_buf() instead of a pointer
>    kfifo: add kfifo_dma_out_prepare_mapped()
>    kfifo: fix typos in kernel-doc
>    tty: 8250_dma: use dmaengine_prep_slave_sg()
>    tty: 8250_omap: use dmaengine_prep_slave_sg()
>    tty: msm_serial: use dmaengine_prep_slave_sg()
>    tty: serial: switch from circ_buf to kfifo
>    tty: atmel_serial: use single DMA mapping for TX
>    tty: atmel_serial: define macro for RX size
>    tty: atmel_serial: use single DMA mapping for RX
> 
>   drivers/tty/serial/8250/8250_bcm7271.c  |  14 +--
>   drivers/tty/serial/8250/8250_core.c     |   3 +-
>   drivers/tty/serial/8250/8250_dma.c      |  31 +++--
>   drivers/tty/serial/8250/8250_exar.c     |   5 +-
>   drivers/tty/serial/8250/8250_mtk.c      |   2 +-
>   drivers/tty/serial/8250/8250_omap.c     |  48 +++++---
>   drivers/tty/serial/8250/8250_pci1xxxx.c |  50 ++++----
>   drivers/tty/serial/8250/8250_port.c     |  22 ++--
>   drivers/tty/serial/amba-pl011.c         |  46 +++-----
>   drivers/tty/serial/ar933x_uart.c        |  15 ++-
>   drivers/tty/serial/arc_uart.c           |   8 +-
>   drivers/tty/serial/atmel_serial.c       | 150 +++++++++++-------------
>   drivers/tty/serial/clps711x.c           |  12 +-
>   drivers/tty/serial/cpm_uart.c           |  20 ++--
>   drivers/tty/serial/digicolor-usart.c    |  12 +-
>   drivers/tty/serial/dz.c                 |  13 +-
>   drivers/tty/serial/fsl_linflexuart.c    |  17 +--
>   drivers/tty/serial/fsl_lpuart.c         |  39 +++---
>   drivers/tty/serial/icom.c               |  25 +---
>   drivers/tty/serial/imx.c                |  54 ++++-----
>   drivers/tty/serial/ip22zilog.c          |  26 ++--
>   drivers/tty/serial/jsm/jsm_cls.c        |  29 ++---
>   drivers/tty/serial/jsm/jsm_neo.c        |  38 ++----
>   drivers/tty/serial/max3100.c            |  14 +--
>   drivers/tty/serial/max310x.c            |  35 +++---
>   drivers/tty/serial/men_z135_uart.c      |  26 ++--
>   drivers/tty/serial/meson_uart.c         |  11 +-
>   drivers/tty/serial/milbeaut_usio.c      |  15 +--
>   drivers/tty/serial/msm_serial.c         | 114 +++++++++---------
>   drivers/tty/serial/mvebu-uart.c         |   8 +-
>   drivers/tty/serial/mxs-auart.c          |  23 +---
>   drivers/tty/serial/pch_uart.c           |  21 ++--
>   drivers/tty/serial/pic32_uart.c         |  15 ++-
>   drivers/tty/serial/pmac_zilog.c         |  24 ++--
>   drivers/tty/serial/qcom_geni_serial.c   |  36 +++---
>   drivers/tty/serial/rda-uart.c           |  17 +--
>   drivers/tty/serial/samsung_tty.c        |  54 +++++----
>   drivers/tty/serial/sb1250-duart.c       |  13 +-
>   drivers/tty/serial/sc16is7xx.c          |  40 +++----
>   drivers/tty/serial/sccnxp.c             |  16 ++-
>   drivers/tty/serial/serial-tegra.c       |  43 ++++---
>   drivers/tty/serial/serial_core.c        |  56 ++++-----
>   drivers/tty/serial/serial_port.c        |   2 +-
>   drivers/tty/serial/sh-sci.c             |  51 ++++----
>   drivers/tty/serial/sprd_serial.c        |  20 ++--
>   drivers/tty/serial/st-asc.c             |   4 +-
>   drivers/tty/serial/stm32-usart.c        |  52 ++++----
>   drivers/tty/serial/sunhv.c              |  35 +++---
>   drivers/tty/serial/sunplus-uart.c       |  16 +--
>   drivers/tty/serial/sunsab.c             |  30 ++---
>   drivers/tty/serial/sunsu.c              |  15 +--
>   drivers/tty/serial/sunzilog.c           |  27 ++---
>   drivers/tty/serial/tegra-tcu.c          |  10 +-
>   drivers/tty/serial/timbuart.c           |  17 ++-
>   drivers/tty/serial/uartlite.c           |  13 +-
>   drivers/tty/serial/ucc_uart.c           |  20 ++--
>   drivers/tty/serial/xilinx_uartps.c      |  20 ++--
>   drivers/tty/serial/zs.c                 |  13 +-
>   include/linux/kfifo.h                   | 143 ++++++++++++++++------
>   include/linux/serial_core.h             |  49 +++++---
>   lib/kfifo.c                             | 107 +++++++++--------
>   61 files changed, 944 insertions(+), 960 deletions(-)
> 

This patchset has at least broken all Amlogic and Qualcomm boards so far, only part of them were fixed in next- but this serie has been merged in v1 with no serious testing and should've been dropped immediately when the first regressions were reported.

Thanks,
Neil

