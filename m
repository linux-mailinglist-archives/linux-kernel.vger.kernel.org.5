Return-Path: <linux-kernel+bounces-3501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB37A816D1E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60B6E1F22CBC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E209F1C694;
	Mon, 18 Dec 2023 11:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QZ+3xWuH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506F11C6AD;
	Mon, 18 Dec 2023 11:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702900104;
	bh=cGR57+CiG5a+3zirrKt+CQiAa44aj9FUBj5+rhcA9VM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QZ+3xWuH+hzguRihJ5wfmGV6IBQ4oy3RSHlbf/lRB2c+dNBkK6gAFqaUQ6BHgsYTP
	 B71E+s4hEd5cGoywoTQOe1kbaeb2ZZuJRNEKc7xVtBI27NWEjkyIprI5ph/sYpBynk
	 56SgJde7fgS+77iBGFoeFNn7K5bG3pw6727TJnyesSfgPpImLp45fRHI5h4eRxU/zG
	 F6znNG4DSGdyhKHM9Wol9Wj3ctEOWFnE/hDUofqYmpfQZzBPAc2CgfOhUgo5hgl4nV
	 RdaygF1EqXYMma/47DjheC66X6nCo4j7osbBxylPw3DRkgwlk6LH5UVhMd1Ip2MxKc
	 st6Q66gdTlKSA==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1609037814A3;
	Mon, 18 Dec 2023 11:48:22 +0000 (UTC)
Message-ID: <11f7fbee-4795-4d5f-a5f8-901bc17683eb@collabora.com>
Date: Mon, 18 Dec 2023 13:48:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] riscv: dts: starfive: jh7100-common: Setup pinmux
 and enable gmac
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
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
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20231215204050.2296404-1-cristian.ciocaltea@collabora.com>
 <20231215204050.2296404-6-cristian.ciocaltea@collabora.com>
 <CAJM55Z-bg0EGPaLHtxcu2AzqN59zfuiT0eE7oCShrx7dG_QK1g@mail.gmail.com>
 <20231217-rippling-galleria-904152e41f95@spud>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20231217-rippling-galleria-904152e41f95@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/23 23:03, Conor Dooley wrote:
> On Sat, Dec 16, 2023 at 11:38:53AM -0800, Emil Renner Berthing wrote:
>> Cristian Ciocaltea wrote:
>>> Add pinmux configuration for DWMAC found on the JH7100 based boards and
>>> enable the related DT node, providing a basic PHY configuration.
>>>
>>> Co-developed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>>> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>> ---
>>>  .../boot/dts/starfive/jh7100-common.dtsi      | 85 +++++++++++++++++++
>>>  1 file changed, 85 insertions(+)
>>>
>>> diff --git a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
>>> index 42fb61c36068..5cafe8f5c2e7 100644
>>> --- a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
>>> +++ b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
>>> @@ -72,7 +72,92 @@ wifi_pwrseq: wifi-pwrseq {
>>>  	};
>>>  };
>>>
>>> +&gmac {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&gmac_pins>;
>>> +	phy-mode = "rgmii-id";
>>> +	phy-handle = <&phy>;
>>
>> I'm not sure if it's a generic policy or not, but I don't really like adding a
>> reference to a non-existant node here. I'd move this property to the board
>> files where the phy node is actually defined.
> 
> FWIW, I don't like the reference-in-the-wrong-place thing either.

Yeah, as I already mentioned this was unintentional, will fix in v4.

Thanks,
Cristian

