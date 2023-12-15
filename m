Return-Path: <linux-kernel+bounces-1648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8127F81517F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B408D1C23321
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562C847F52;
	Fri, 15 Dec 2023 21:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="STVO7dLP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4842630120;
	Fri, 15 Dec 2023 21:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702674002;
	bh=XmjdsnypmM0sVMOODNg7bU4x4gIm/6EultPACYo535g=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=STVO7dLPIsVi6rpyepTxq9ZaRTHmDDoUxqtPx0GKDDsoI6kKYuT5kVY9Ej1rdZ31z
	 7skxZyTGnWDhXRx3ivcTrWcTn9pS4jn15bf5IuuHF7TKOhf7CjaCQAsFLUqgG+OQw3
	 TmbB7SYbpCKErLSC8pj0EX7CX9QLnILzsRBE/ohiUJbIFE1IMg/cjGBGPtPajrXG4f
	 sNECYsMCQOlfv1P7YiowMjwE7S+4WEgZ3Ta/BBENvi3lzY5/pUGpbmzJcRRt17LLTu
	 pvJjE5GpakAoU7lTRzhh1ydC3vC2/ToA4s4IC0aoo60dOSNzUN2jT4plhHgrw2rMwr
	 McF7U6Ymc8nDQ==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6EFBA3781FD5;
	Fri, 15 Dec 2023 21:00:00 +0000 (UTC)
Message-ID: <a9a3a7c5-7ee9-4b28-9abb-f1194054dfef@collabora.com>
Date: Fri, 15 Dec 2023 23:00:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] dt-bindings: net: starfive,jh7110-dwmac: Add
 JH7100 SoC compatible
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Jessica Clarke <jrtc27@jrtc27.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
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
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-riscv <linux-riscv@lists.infradead.org>, linux-clk@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20231215204050.2296404-1-cristian.ciocaltea@collabora.com>
 <20231215204050.2296404-3-cristian.ciocaltea@collabora.com>
 <A7C96942-07CB-40FD-AAAA-4A8947DEE7CA@jrtc27.com>
 <491f1a89-aabd-4c38-b33a-a298add1bdb3@collabora.com>
In-Reply-To: <491f1a89-aabd-4c38-b33a-a298add1bdb3@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/15/23 22:56, Cristian Ciocaltea wrote:
> On 12/15/23 22:47, Jessica Clarke wrote:
>> On 15 Dec 2023, at 20:40, Cristian Ciocaltea <cristian.ciocaltea@collabora.com> wrote:
>>>
>>> The Synopsys DesignWare MAC found on StarFive JH7100 SoC is mostly
>>> similar to the newer JH7110, but it requires only two interrupts and a
>>> single reset line, which is 'ahb' instead of the commonly used
>>> 'stmmaceth'.
>>>
>>> Since the common binding 'snps,dwmac' allows selecting 'ahb' only in
>>> conjunction with 'stmmaceth', extend the logic to also permit exclusive
>>> usage of the 'ahb' reset name.  This ensures the following use cases are
>>> supported:
>>>
>>>  JH7110: reset-names = "stmmaceth", "ahb";
>>>  JH7100: reset-names = "ahb";
>>>  other:  reset-names = "stmmaceth";
>>>
>>> Also note the need to use a different dwmac fallback, as v5.20 applies
>>> to JH7110 only, while JH7100 relies on v3.7x.
>>>
>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>> ---
>>> .../devicetree/bindings/net/snps,dwmac.yaml   |  3 +-
>>> .../bindings/net/starfive,jh7110-dwmac.yaml   | 74 +++++++++++++------
>>> 2 files changed, 55 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>> index 5c2769dc689a..c1380ff1c054 100644
>>> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>> @@ -95,6 +95,7 @@ properties:
>>>         - snps,dwmac-5.20
>>>         - snps,dwxgmac
>>>         - snps,dwxgmac-2.10
>>> +        - starfive,jh7100-dwmac
>>>         - starfive,jh7110-dwmac
>>>
>>>   reg:
>>> @@ -146,7 +147,7 @@ properties:
>>>   reset-names:
>>>     minItems: 1
>>>     items:
>>> -      - const: stmmaceth
>>> +      - enum: [stmmaceth, ahb]
>>>       - const: ahb
>>
>> I’m not so well-versed in the YAML bindings, but would this not allow
>> reset-names = "ahb", "ahb"?
> 
> Yes, as I already pointed out in [1], I wasn't able to come up with a
> proper solution to avoid that.

Sorry, I've sent the previous email too early..

[1]: https://lore.kernel.org/lkml/564503dd-b779-4e9f-851d-f34d9ea5fa65@collabora.com/

> Thanks,
> Cristian
> 
>> Jess
>>
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

