Return-Path: <linux-kernel+bounces-121610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD3788EB92
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95669B326BF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5416F1386DD;
	Wed, 27 Mar 2024 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKSzsCIZ"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC621304BF;
	Wed, 27 Mar 2024 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555696; cv=none; b=ONW3PCo4s0dU3tHUAdfomWb0JCcBcRZ0+zygFH0rm8T36Bd2+chexIGTVtzaTdCHDgYhZEpJbioW+2mniosn8EjOWk1xsMr0ncaDPMfCFrGl/FWbZoGELKHsx1x7Z3dPN0t4nanrqQOTFQlzFez1XXk+aNguruJXjTBOwFoNej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555696; c=relaxed/simple;
	bh=3J9oWvkrDOBZNCeoIPGbHWUfU8diyk8bQx/Xctp+3Nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gtku04tLxaURe3ES8LVeEqMq0YNRlkgNjSXpU6fdACvJAMgq87QA+xg0RODaL37UxSVtGsCTLZXFgbAYZu8h6ouOH/evCVLSdy+eA2JYM45POYZLOmyKnfuQSMSleeeWvqyHFr4K7D047oofDUWfH2NjrRhbKTcjvCD53SoirCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKSzsCIZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41488e17e1cso21199705e9.0;
        Wed, 27 Mar 2024 09:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711555693; x=1712160493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bT1raRNJeqKOym+LNB+gUSk7/A9iCImFlQwqZliyRIw=;
        b=mKSzsCIZZtW75FS1vxMQMnzNYam+rlgiCui/9nrqtWsFNcWbKwJ4T4NHg3YwoqYyhV
         Xo/JB/VXjoWqdKx065hiUeYiFBUauncK/+kB0H/ZYG6AnD/v6x+MhnFSjhJxmWf6fX4B
         hJUft4lQMUd5f45yL8XHNBlZPw759KzuGQOvyCJOx28xZ3v7e6kGZqQ5miHuWFJzbmZE
         7C9hiaRhx01DiDm6cT0oaTqHTlegbZWEpT97z8Jd6TjCwqWFydtZNtUZXYXJXc2YIx9T
         i0WB8dEmQWZhZlbWblKSzxJOVe8ehztdwNc2stXMCjVDDsg7ZGQnNIX++H7vXE1hBlGu
         Po0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711555693; x=1712160493;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bT1raRNJeqKOym+LNB+gUSk7/A9iCImFlQwqZliyRIw=;
        b=uugbDCqBAjG4ZlpsoN6S9IusOxSkv1fiRdyF1GJEzXyh+0EoeO/Cvci1goxsROiXMz
         UkNWPXEELc24NZkynF2YDv6RJEL59pycupkoJ4uam8qiHadxhTv3ovdBNRONlPFGhLok
         sZ2W2zQTVph0P3pD+VW0F06At8Rk8PuoDBn+3r59Gen1nGWB4yCfroWCy2KURUAY2yvX
         3Ra/vNA8bBZMjFKNqnbgnr2SPnOOwMk08np4xQMl/cNZOInS03HfyFbg5tT4N+Gakyte
         HLRNUB3y1GK1ewMAbn9lRrM3d82pUErwjVXy4GDbceVacH8tQ+R1w6CAtvM3WFQX4Wxl
         pN8g==
X-Forwarded-Encrypted: i=1; AJvYcCW6nJaDCqWvcDTkwQ49mPUDFj3wuXF4gs7q9R15/sHfjjYSYdBgXC8XuvuWSROnq7PIfanuTDb08aQNJXKV+Lvdt88sR7NKeiKDBooKnf8cdJ4CrH7tkGbfT3XyqBUQVFwHV2EifdEqU2qBAQ==
X-Gm-Message-State: AOJu0Yzzr0vcbQKMSfRV7Bj5xVR+pXQb/Q/liFm2n5N55r+bg5AiMhwi
	WPirPda+96LS8+WHWb5RcV1W/3PsHdkj/yQWZWymIjtnmf/SqEZE
X-Google-Smtp-Source: AGHT+IEXvy4Ta0nK+BLZfesQlwIb3cRLvbmhAGKfIRDppfcPcRXyU4g++og2mjweWhcQCI94BM3PQw==
X-Received: by 2002:adf:fd81:0:b0:341:b47f:e45a with SMTP id d1-20020adffd81000000b00341b47fe45amr225786wrr.50.1711555692968;
        Wed, 27 Mar 2024 09:08:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b? ([2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b])
        by smtp.gmail.com with ESMTPSA id y6-20020a5d4ac6000000b0033ec8739918sm15212344wrs.41.2024.03.27.09.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 09:08:12 -0700 (PDT)
Message-ID: <9f2ec032-20bd-46d0-959c-deeb9a3503ac@gmail.com>
Date: Wed, 27 Mar 2024 17:08:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT 00/15] tty: serial: switch from circ_buf to kfifo
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
 Alexander Shiyan <shc_work@mail.ru>,
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
 Neil Armstrong <neil.armstrong@linaro.org>,
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
References: <20240319095315.27624-1-jirislaby@kernel.org>
From: Richard Genoud <richard.genoud@gmail.com>
Content-Language: fr-FR
In-Reply-To: <20240319095315.27624-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 19/03/2024 à 10:52, Jiri Slaby (SUSE) a écrit :
> This series switches tty serial layer to use kfifo instead of circ_buf.
> Excerpt from the switching patch:
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
> This is Request for Testing as I cannot test all the changes
> (obviously). So please test your HW's serial properly.

Tested-by: Richard Genoud <richard.genoud@gmail.com> # on at91sam9g20-ek sama5d3_xplained and sama5d2_xplained

