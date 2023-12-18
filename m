Return-Path: <linux-kernel+bounces-3493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6CA816D08
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2351C23073
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5973E2E3E3;
	Mon, 18 Dec 2023 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="olpcJOvX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD06A4D5BD;
	Mon, 18 Dec 2023 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702899716;
	bh=Ay7Tt9dce00P1AFvH+VR0Quwph8t7Z1Zn8abP+bDKl8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=olpcJOvXtTBBpVcYE8PqF5uNLFcLGnlrd77Yy4U2M1CVK1OMCU44ovp8ox0ABd+vx
	 vMMIhpPKRjVYneLkb/RvRi7d4oSroIqe2BjDHoHmIw7nn6GftbYRPI/M/z5ce+U1Ax
	 Xjff2yIbY3xKiaYY9fcWh7LjjHnDZPqbswmEj2DvPmFUBoLeqwQvBZaPBfs9rzAc0I
	 349sA3zHVM5n127CwidQ+I2ZWhl4UpVTusm8MpYA//tJrf50cwyXU1NSx6rkRG4hhi
	 9F77N0ItNtAnDrl7xx1QDhAZsFIdKxvgmdmQxMGqqKHZv7I9w2FZ/Ps3gPOjIvAivu
	 CLedaHr2oRvJg==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 84CA537814A3;
	Mon, 18 Dec 2023 11:41:54 +0000 (UTC)
Message-ID: <cb18617d-e34a-4c3e-a37a-1b051587f8b5@collabora.com>
Date: Mon, 18 Dec 2023 13:41:53 +0200
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
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
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
References: <20231215204050.2296404-1-cristian.ciocaltea@collabora.com>
 <20231215204050.2296404-6-cristian.ciocaltea@collabora.com>
 <CAJM55Z-bg0EGPaLHtxcu2AzqN59zfuiT0eE7oCShrx7dG_QK1g@mail.gmail.com>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <CAJM55Z-bg0EGPaLHtxcu2AzqN59zfuiT0eE7oCShrx7dG_QK1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/23 21:38, Emil Renner Berthing wrote:
> Cristian Ciocaltea wrote:
>> Add pinmux configuration for DWMAC found on the JH7100 based boards and
>> enable the related DT node, providing a basic PHY configuration.
>>
>> Co-developed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  .../boot/dts/starfive/jh7100-common.dtsi      | 85 +++++++++++++++++++
>>  1 file changed, 85 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
>> index 42fb61c36068..5cafe8f5c2e7 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
>> @@ -72,7 +72,92 @@ wifi_pwrseq: wifi-pwrseq {
>>  	};
>>  };
>>
>> +&gmac {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&gmac_pins>;
>> +	phy-mode = "rgmii-id";
>> +	phy-handle = <&phy>;
> 
> I'm not sure if it's a generic policy or not, but I don't really like adding a
> reference to a non-existant node here. I'd move this property to the board
> files where the phy node is actually defined.

Totally agree, I simply went too far while dropping duplicated code and
didn't realize the mistake.  Thanks for noticing!

