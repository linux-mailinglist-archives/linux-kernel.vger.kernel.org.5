Return-Path: <linux-kernel+bounces-3497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 900C5816D14
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4557C1F23D9B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3405531747;
	Mon, 18 Dec 2023 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NnoaSKie"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E6F2C841;
	Mon, 18 Dec 2023 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702899835;
	bh=+AE8FG87JjGXQZ7aKx+tpmHcDvNM6DDRUxk5MZqAb4U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NnoaSKieHR6swMS1aHrusYDqLIPoqpaqKP+0jC7/bOhu9uyCuIBbR7GbjLOTqnVFQ
	 aofCGeAjJ4cerVlSp1kZIzTq3bqOY0m+r49v5ciHgqgMaU5T6cU4vZbLZG4vXANCbv
	 zuSyGf1s3hLfzDH5RWG9MP/vR06o1sHfa11g1uWVzclCVDk0a3F4hQgZhBx416FP3f
	 OL9eePgwTzMG11Djscu2MGXa5b2LVFdYhFoA757KG6Ink9K5ft8lu/cm6CSkRraR8x
	 aJFsfpEgK3Lr/z3MHNYgU1KRhR1N55mIB4UMHLrQrKHmqq4PRcinmK5BZCvn2yRC3H
	 OxPAyW3dxhFkA==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 696FF37814A3;
	Mon, 18 Dec 2023 11:43:53 +0000 (UTC)
Message-ID: <b65393f1-1c36-40e5-96f6-1e7f978cc185@collabora.com>
Date: Mon, 18 Dec 2023 13:43:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] riscv: dts: starfive: visionfive-v1: Setup
 ethernet phy
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
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
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
References: <20231215204050.2296404-1-cristian.ciocaltea@collabora.com>
 <20231215204050.2296404-7-cristian.ciocaltea@collabora.com>
 <f8f9d454-6155-4b1c-b4b2-daf98267be14@lunn.ch>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <f8f9d454-6155-4b1c-b4b2-daf98267be14@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/23 19:55, Andrew Lunn wrote:
> On Fri, Dec 15, 2023 at 10:40:45PM +0200, Cristian Ciocaltea wrote:
>> The StarFive VisionFive V1 SBC uses a Motorcomm YT8521 PHY supporting
>> RGMII-ID, but requires manual adjustment of the RX internal delay to
>> work properly.
>>
>> The default RX delay provided by the driver is 1.95 ns, which proves to
>> be too high. Applying a 50% reduction seems to mitigate the issue.
>>
>> Also note this adjustment is not necessary on BeagleV Starlight SBC,
>> which uses a Microchip PHY.  Hence, there is no indication of a
>> miss-behaviour on the GMAC side, but most likely the issue stems from
>> the Motorcomm PHY.
> 
> I suggest you make a similar comment in the .dts file, just to explain
> the odd setting.

Sure, will do, we need a v4 anyway.

Thanks,
Cristian

