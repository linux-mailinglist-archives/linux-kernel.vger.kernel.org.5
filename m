Return-Path: <linux-kernel+bounces-3461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD28816CA6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52F31F22C2C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FED347AC;
	Mon, 18 Dec 2023 11:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lFn6oaU5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591D121364;
	Mon, 18 Dec 2023 11:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702899493;
	bh=V5PA5oyxCd5DFK291fOQmsy6Q17j3UOvBS6drZZobsg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lFn6oaU5/zBXfw/lfDzsQZdCaZFrqBfttjH8fN5pBpC+x9ugq0uF/v0dGZEiFXRc6
	 +7oyXTScJk0y2/u+13P+FgCN9xo9hOk0ujzwxI2YY2XRVgOAS3UHZbgaQf3b/Nyyn8
	 x9KWS4ulLJGO2JJ/FNGyadTdjybGHs7OxL+L7IeijvJf5RQvh9tMcINNbnZ5A9aGYP
	 0tQfFgU/lZk8ls4dofDxlacunvvIR+6USPl7W0C7WeZQ9UPXms/MR1v5xiZfdnFQWA
	 UXhwYOJolTHy+09ThqcCCwO1/J2c1p0e6rjcTtFXobbHcUK49iLD+meFAW+xXeGU3F
	 nALQ2xfxXz1Rg==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8A206378149C;
	Mon, 18 Dec 2023 11:38:11 +0000 (UTC)
Message-ID: <a06aaab5-b433-44a6-89a4-bdf713d5e1a9@collabora.com>
Date: Mon, 18 Dec 2023 13:38:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] [UNTESTED] riscv: dts: starfive:
 beaglev-starlight: Enable gmac
Content-Language: en-US
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>,
 Samin Guo <samin.guo@starfivetech.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
 <20231029042712.520010-13-cristian.ciocaltea@collabora.com>
 <CAJM55Z9e=vjGKNnmURN15mvXo2bVd3igBA-3puF9q7eh5hiP+A@mail.gmail.com>
 <2f06ce36-0dc1-495e-b6a6-318951a53e8d@collabora.com>
 <698fbb5d-0750-4f2a-857f-5429e5f589f9@collabora.com>
 <CAJM55Z-e8mkjac-nCF9_w6EmMVbL9ued0mAcjwTMF=pKDLkMsA@mail.gmail.com>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <CAJM55Z-e8mkjac-nCF9_w6EmMVbL9ued0mAcjwTMF=pKDLkMsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/23 21:24, Emil Renner Berthing wrote:
> Cristian Ciocaltea wrote:
>> On 11/28/23 02:40, Cristian Ciocaltea wrote:
>>> On 11/26/23 23:10, Emil Renner Berthing wrote:
>>>> Cristian Ciocaltea wrote:
>>>>> The BeagleV Starlight SBC uses a Microchip KSZ9031RNXCA PHY supporting
>>>>> RGMII-ID.
>>>>>
>>
>> [...]
>>
>>>> You've alse removed the phy reset gpio on the Starlight board:
>>>>
>>>>   snps,reset-gpios = <&gpio 63 GPIO_ACTIVE_LOW>
>>>>
>>>> Why?
>>>
>>> I missed this in v1 as the gmac handling was done exclusively in
>>> jh7100-common. Thanks for noticing!
>>
>> Hi Emil,
>>
>> I think the reset doesn't actually trigger because "snps,reset-gpios" is
>> not a valid property, it should have been "snps,reset-gpio" (without the
>> trailing "s").
>>
>> However, this seems to be deprecated now, and the recommended approach
>> would be to define the reset gpio in the phy node, which I did in [1].
>>
>> Hopefully this won't cause any unexpected behaviour. Otherwise we should
>> probably simply drop it.
>>
>> [1]: https://lore.kernel.org/lkml/20231215204050.2296404-8-cristian.ciocaltea@collabora.com/
> 
> Oh, nice catch! With your v3 patches the Starlight board still works fine and
> GPIO63 is correctly grabbed and used for "PHY reset".

Great, thanks a lot for retesting this!

