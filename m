Return-Path: <linux-kernel+bounces-1650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13A681518F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CA96B22A15
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA0547F54;
	Fri, 15 Dec 2023 21:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Fs/HaoOn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039FB30132;
	Fri, 15 Dec 2023 21:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702674207;
	bh=fWUcyTSvl9HkzhbEm2R9p6yElA555rA8toz5mjYvtR8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Fs/HaoOn6SjZTGGcdUHfgvof1ag/gLuno1cJmOXOX8v2Mr/oGxLTYh8xd4Ju11DlS
	 07D2Y6ZaCj9MasIAmOM5lRGp7y1k1osx5lCBzcihDN0lI0oD6WYloE6Ah132R2CDwN
	 ExwWYzVW6REs3ogTVC7ys8oxbR+B8Wq5LhBmWRqHVdkU29ZkHwm6U1JwIkIwZEFiDB
	 0mHdZeUJsAv5xtXJO89pm1Xu3lRCb8332T86FidfU/XlTkDU/jcVul2g9PScZVabG8
	 xL3yhH+JzwcZOxVKRCi+CDz1pkSzJxElChYxhgcaPDo4hO/LLydHjz0sPzX3gEc7mk
	 P4XKIW1PNHMlQ==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 354E83781FD5;
	Fri, 15 Dec 2023 21:03:25 +0000 (UTC)
Message-ID: <6c62e3b2-acde-4580-9b67-56683289e45e@collabora.com>
Date: Fri, 15 Dec 2023 23:03:24 +0200
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
To: Samuel Holland <samuel.holland@sifive.com>,
 Jessica Clarke <jrtc27@jrtc27.com>
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
 <65fd52f1-6861-42b0-9148-266766d054b1@sifive.com>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <65fd52f1-6861-42b0-9148-266766d054b1@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/15/23 22:59, Samuel Holland wrote:
> On 2023-12-15 2:47 PM, Jessica Clarke wrote:
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
> Yes, it would. You need something like:
> 
> reset-names:
>   oneOf:
>     - enum: [stmmaceth, ahb]
>     - items:
>         - const: stmmaceth
>         - const: ahb

Oh yes, I always forget about the "oneOf" thing. Thanks!

> Regards,
> Samuel
> 

