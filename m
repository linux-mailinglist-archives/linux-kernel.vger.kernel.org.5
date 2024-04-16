Return-Path: <linux-kernel+bounces-146377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9CA8A6477
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C2C1C214FB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1601373199;
	Tue, 16 Apr 2024 07:05:04 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFEF38FA1;
	Tue, 16 Apr 2024 07:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713251103; cv=none; b=EGNj6VCdfvNywEhMD9IfVG3TPJiqHwu3gg3DuO6KoFqys2bdExYDTZzrKmXPZbASzgm4tldNSsHZPPZITAzgjbEPZvJ9dFGqGGgnIdnbAyma7TiSWWgrdcUDx3Xv2D/nJJqUOczIYdNjodqJny3YTat5AJvRy+C2sZXEoNzLwaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713251103; c=relaxed/simple;
	bh=ndGLAr2AF7IFyaoZXHY3CTyQTRVAXE7lvX+9Y+E1qOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMF3gQkgjr/bMVrwUSfCMyKz1wgvEgKZ11ZFdWm62L0QHbVX1/lBpA/0I5/W34SPF2qln5jiI2Ly4KHNzPG+QIeQOkV/TLwSmmcwjUHQmdPjehD5NuZy2xGFfn44cOaIcwCIa4+WEOYigk1qv2/VK4L8nipDonNJq81R13s1YuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-417f5268b12so35568045e9.1;
        Tue, 16 Apr 2024 00:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713251100; x=1713855900;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jz8xW0hkNFPg+LOM+BMDp3CRmgqid89xE+lYmINvP6g=;
        b=SppUcMjWNjamUEM/+BLvjz6j8RyG6v6POKCK15K6u+zJK0ORyC6NWiznMwFtePsvGd
         7Vp4SKTXifx25N7jmFt89xVa69LiD3ueVg5+5KmMLAxtx0T1+mpmV21/06J/lxeAPR/U
         EePz+1yEQlIxXCQiVBaZjPkfNgnM/L6i11ljRKJW4kgMU47LD6mUx4e0AHBNFhvvLvE7
         K3z33ZztYFJXSugX2fpDlaPd/2q4VYSrPAX+YMZd4udjGeTC4wRUiZtKnisFgZigm/Hm
         Swdex9R+0dbfdNcLf3xIwxmVzbngvyhGdZ8Oq1lcfRe91zEpcWvprvn5i/tefYEQc4RY
         yE+w==
X-Forwarded-Encrypted: i=1; AJvYcCXJvvLrB9r5sSIQtGMXB138ZN2iusYY5z8VsPZbo9Rr6We2j6kuhVD1o3ltAUZRTWmvujxEM0IwpjCRhqxNXnsfgoQVlIaYY6diAmUOTllWXrtfebrdT0pl4ScngFdUvoFk7aHKXlFNFoOv
X-Gm-Message-State: AOJu0YwTYCQRKnaDUPq02JmXImKLvslsAL0mt90EuQaBqv6qdd1q5YWy
	x4grTwOsLn1ntm80zYxolBiviia5PwEEhRYzBgb4h349Vqp6hMnz
X-Google-Smtp-Source: AGHT+IHnDZ3Ga/UcpCNqMO8UMMhVtQfuNTN6VA8TiNJf2QAHbG6Q5VQF87rUI22+y/74TFU8h7Ltgg==
X-Received: by 2002:a05:600c:19cc:b0:416:4973:4d87 with SMTP id u12-20020a05600c19cc00b0041649734d87mr11228590wmq.3.1713251099929;
        Tue, 16 Apr 2024 00:04:59 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id h15-20020adff4cf000000b003432ffc3aeasm13953280wrp.56.2024.04.16.00.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 00:04:59 -0700 (PDT)
Message-ID: <c990e6a7-cd4b-4178-94da-79f4ef84bdd8@kernel.org>
Date: Tue, 16 Apr 2024 09:04:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] tty: serial: switch from circ_buf to kfifo
To: Pengfei Xu <pengfei.xu@intel.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
 Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
 Russell King <linux@armlinux.org.uk>, Vineet Gupta <vgupta@kernel.org>,
 Richard Genoud <richard.genoud@gmail.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Alexander Shiyan <shc_work@mail.ru>, Baruch Siach <baruch@tkos.co.il>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Taichi Sugaya <sugaya.taichi@socionext.com>,
 Takao Orito <orito.takao@socionext.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Laxman Dewangan
 <ldewangan@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 "David S. Miller" <davem@davemloft.net>, Hammer Hsieh
 <hammerh0314@gmail.com>, Peter Korsgaard <jacmet@sunsite.dk>,
 Timur Tabi <timur@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20240405060826.2521-1-jirislaby@kernel.org>
 <20240405060826.2521-13-jirislaby@kernel.org>
 <Zh3vY99GFFyKJF0B@xpf.sh.intel.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <Zh3vY99GFFyKJF0B@xpf.sh.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 16. 04. 24, 5:24, Pengfei Xu wrote:
> On 2024-04-05 at 08:08:23 +0200, Jiri Slaby (SUSE) wrote:
>> Switch from struct circ_buf to proper kfifo. kfifo provides much better
>> API, esp. when wrap-around of the buffer needs to be taken into account.
>> Look at pl011_dma_tx_refill() or cpm_uart_tx_pump() changes for example.
..
> Greeting!
> I used syzkaller and Internal v6.9-rc4 kernel which include Linux next kernel,
> and found deadlock in console_flush_all issue, bisected the commit is:
> "
> 1788cf6a91d9 tty: serial: switch from circ_buf to kfifo
> "
..
> [   17.841628] ======================================================
> [   17.841631] WARNING: possible circular locking dependency detected
> [   17.841632] 6.9.0-rc4-df0b4fecf9eb+ #1 Not tainted
> [   17.841636] ------------------------------------------------------
> [   17.841638] repro/726 is trying to acquire lock:
> [   17.841641] ffffffff86d6da80 (console_owner){....}-{0:0}, at: console_flush_all+0x51a/0xc40
> [   17.841665]
> [   17.841665] but task is already holding lock:
> [   17.841667] ffffffff89aa52b8 (&port_lock_key){-...}-{2:2}, at: uart_put_char+0x118/0x510
> [   17.841684]
> [   17.841684] which lock already depends on the new lock.
..
> [   17.842133] stack backtrace:
..
> [   17.842461]  handle_bug+0xa2/0x130
> [   17.842469]  exc_invalid_op+0x3c/0x80
> [   17.842479]  asm_exc_invalid_op+0x1f/0x30
> [   17.842487] RIP: 0010:uart_put_char+0x3ac/0x510

So you hit a "WARNING" (see below). And printing pretty much anything 
(like the WARNING report) from this point inside uart_put_char() will 
lead to this deadlock.

..
> [   17.879899] WARNING: CPU: 0 PID: 726 at drivers/tty/serial/serial_core.c:561 uart_put_char+0x3ac/0x510

This is the real thing/root cause of the above.

WARN_ON_ONCE(!state->port.xmit_buf)) was hit in uart_put_char().

Let me see how kfifo changed xmit_buf handling.

> Hope reproduced code and bisection is helpful.

Thanks, let me investigate.

-- 
js
suse labs


