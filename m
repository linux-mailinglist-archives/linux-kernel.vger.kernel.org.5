Return-Path: <linux-kernel+bounces-5215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A710D818811
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9C41C24107
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E3218AE0;
	Tue, 19 Dec 2023 12:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HsSQ14a8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C841B268;
	Tue, 19 Dec 2023 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702990505;
	bh=P2iu3HxAjX4PHABsZdyr9+nUD7MSsfRwCcOrLhUn4Ao=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HsSQ14a8Oao/Bw4hc5xP3VFQeqS8z+Xf/8ztCqd9FI7N9PIIUPBt7yHeQTMIzE8T3
	 shsvDXE6yuPaQ1WIlX2QCBkAgV3NIu7epB/d7hxLzll/95KqDiB3HawZ/2PdMLdaVu
	 Gg5VuXCGTDBGvo7TndZWSL7X1AmETN8NDdmKPw0XguDWSRlf2HQWG5ZpH1+ZInUtzI
	 1y/EoYISuYl24Gj8PkDSa5jJy9R79AOlSEidb1HPnewwGMPdcrkVcGEL+n1lrcKYjf
	 M+06ad84c6vKqHwQ8Jaeza2AO2tCj7y+XH7x5/Wr+zrip+jLYtl/hUDemcFp5j/fWT
	 dQUlZEKpYXo+g==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BE3DF37813EB;
	Tue, 19 Dec 2023 12:55:03 +0000 (UTC)
Message-ID: <5b6d78a6-4515-41c2-b94d-5c7df12dbb2d@collabora.com>
Date: Tue, 19 Dec 2023 14:55:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] dt-bindings: net: starfive,jh7110-dwmac: Drop
 redundant reset description
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
 <20231218214451.2345691-2-cristian.ciocaltea@collabora.com>
 <92eb5f85-1241-429c-aca9-7a6a17f19ae5@linaro.org>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <92eb5f85-1241-429c-aca9-7a6a17f19ae5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/23 09:24, Krzysztof Kozlowski wrote:
> On 18/12/2023 22:44, Cristian Ciocaltea wrote:
>> The reset description items are already provided by the referenced
>> snps,dwmac.yaml schema, hence replace them with the necessary
>> {min,max}Items.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  .../devicetree/bindings/net/starfive,jh7110-dwmac.yaml       | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
>> index 5e7cfbbebce6..d90cb82c1424 100644
>> --- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
>> +++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
>> @@ -55,9 +55,8 @@ properties:
>>      maxItems: 3
>>  
>>    resets:
>> -    items:
>> -      - description: MAC Reset signal.
>> -      - description: AHB Reset signal.
>> +    minItems: 2
>> +    maxItems: 2
> 
> Why changing only resets, but not reset-names?

Already answered in [1], but also discussed in the context of the 
next patch.

Thanks,
Cristian

[1]: https://lore.kernel.org/lkml/0ff7a905-d8f2-401b-a0ff-47947d12ce05@collabora.com/

