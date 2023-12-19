Return-Path: <linux-kernel+bounces-5269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0668188BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34CCB1F22884
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F32199C1;
	Tue, 19 Dec 2023 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rr/fsctI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0661B267;
	Tue, 19 Dec 2023 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702993021;
	bh=FnY6knylJ3x5vm9CnT/Sy6SqYuEWSlZ8nKY07PB5N7Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rr/fsctIrfTYaB6wwgAqsttKJXuqFEYeaGHdO+RJUJx6mCnkUHNcbAmTsAv6hHtz6
	 HWU/k63GGZPmCPkoC9UHuhiYM/WE4xnxpAp9lY7KOp/yy/aHG59CzEK6ae141k4iy2
	 ylfrB0Sl7xcYDxL0qJ/RiVjxDqBMokBKDX9oRNhd7F/jrw+TEr6sObE7JXzSWliHDG
	 O8B1yPGN20H3Pr4IuFPnN0jlNyfrnNfBFI0AtX2LFY6lPtKGxF1oOlnKYl60VAjjJL
	 BfCwuad1t7Mz4l63tcJxsvYvM7a+iquoBaxInwxx8kFCelNCoxO0SfT/b0kM9q/E7x
	 agTbnn5KDVMWQ==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A413B378145A;
	Tue, 19 Dec 2023 13:36:59 +0000 (UTC)
Message-ID: <50f0a002-f602-4cdb-ab18-e085adbf09bc@collabora.com>
Date: Tue, 19 Dec 2023 15:36:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] dt-bindings: net: starfive,jh7110-dwmac: Add
 JH7100 SoC compatible
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>,
 Samin Guo <samin.guo@starfivetech.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Hal Feng <hal.feng@starfivetech.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20231218214451.2345691-1-cristian.ciocaltea@collabora.com>
 <20231218214451.2345691-3-cristian.ciocaltea@collabora.com>
 <c9225053-78f8-40b7-9453-dc3dabe44500@linaro.org>
 <d030f5b7-8d32-4a80-a3c0-98cfa1c0fe4f@collabora.com>
 <15077e1f-c13b-4424-9918-df441b56b695@linaro.org>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <15077e1f-c13b-4424-9918-df441b56b695@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/23 15:19, Krzysztof Kozlowski wrote:
> On 19/12/2023 13:49, Cristian Ciocaltea wrote:
>>>>    reg:
>>>>      maxItems: 1
>>>> @@ -46,23 +50,6 @@ properties:
>>>>        - const: tx
>>>>        - const: gtx
>>>>  
>>>> -  interrupts:
>>>> -    minItems: 3
>>>> -    maxItems: 3
>>>> -
>>>> -  interrupt-names:
>>>> -    minItems: 3
>>>> -    maxItems: 3
>>>> -
>>>> -  resets:
>>>> -    minItems: 2
>>>> -    maxItems: 2
>>>
>>> What is the point of your previous patch if you immediately remove it?
>>> It is a no-op. Just mention in this commit msg, that both resets and
>>> reset-names are coming from snps,dwmac so they can be removed from
>>> top-level entirely.
>>
>> This has been discussed during v2 review [1], where I also provided the
>> rational behind not updating reset-names. So the code was not deleted,
>> but moved under an if clause.
>>
>> Thanks for reviewing,
>> Cristian
>>
>> [1]: https://lore.kernel.org/lkml/f4d0b216-5bdc-4559-aabb-8af638d33721@collabora.com/
> 
> I don't see it being addressed:
> 
> https://lore.kernel.org/lkml/35556392-3b9a-4997-b482-082dc2f9121f@linaro.org/
> 
> Repeating the same and the same :/

I think this was just a misunderstanding, sorry for the confusion.  I
kept two sets of changes which were not directly related into separate
patches, so I'm going to squash them in v5.

Thanks,
Cristian

