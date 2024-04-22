Return-Path: <linux-kernel+bounces-153125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75ADE8AC9D7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0336B1F21EE7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3B5143C6A;
	Mon, 22 Apr 2024 09:47:59 +0000 (UTC)
Received: from 3.mo575.mail-out.ovh.net (3.mo575.mail-out.ovh.net [46.105.58.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E788143C58
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.58.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713779279; cv=none; b=rfFuBJoQki2D1vf50+HyX2ZutX5TH7Kv10DLOT7eJOg2bnW9B9rden6HvvWCbBlw3U1n3rlfdHCA1PiQjC8ibRWxYxB70JQvULi3K3zEZTBlYu9ca+J7vB4lljKnVAOBBGJXaNjGzQ/R+ZNEPFnfOZiFAKvq5xg75Ddrf6cL/E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713779279; c=relaxed/simple;
	bh=xDSmU42HwR7p82VHSVrC1r6JVxcHqDX7Wo5kVPyv4Ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJK3lNlvIYO5U5jlTyAE7xJ9VgA2SJklEQrQBA5XajRfNuipI4+5pVwrcf1szRctl8xN8NiLld0vz1XM1abfCm3T0IBi6iXUCxKvLwgCr9gWLXaD5fNGNXsT5N2jT4S1AKyeypDVIJMVPVl4fUyuQ7ZwEsV/tdH6epx9GE7pMV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armadeus.com; spf=pass smtp.mailfrom=armadeus.com; arc=none smtp.client-ip=46.105.58.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armadeus.com
Received: from director4.ghost.mail-out.ovh.net (unknown [10.109.148.29])
	by mo575.mail-out.ovh.net (Postfix) with ESMTP id 4VNKg04Dwhz1D7T
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:28:12 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-rl684 (unknown [10.110.113.68])
	by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 920A11FE65;
	Mon, 22 Apr 2024 09:28:09 +0000 (UTC)
Received: from armadeus.com ([37.59.142.101])
	by ghost-submission-6684bf9d7b-rl684 with ESMTPSA
	id qQDTHKktJmYMfgAAjN946g
	(envelope-from <sebastien.szymanski@armadeus.com>); Mon, 22 Apr 2024 09:28:09 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-101G004c9d7feca-c54e-499e-ad96-007dd4ebdda3,
                    A64A67AECC9DB63596043E25B5FC1CC6B28F39B0) smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp:92.148.253.243
Message-ID: <f01d49cf-5955-405c-9c2b-05b0c7bb982c@armadeus.com>
Date: Mon, 22 Apr 2024 11:28:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] arm64: mx93: etherrnet: set TX_CLK in RMII mode
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Clark Wang <xiaoning.wang@nxp.com>,
 Linux Team <linux-imx@nxp.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20240422-v6-9-topic-imx93-eqos-rmii-v1-0-30151fca43d2@pengutronix.de>
Content-Language: en-US
From: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Autocrypt: addr=sebastien.szymanski@armadeus.com; keydata=
 xsBNBFNfZLEBCACv1lqSePHJNpRgcnER+3emy+Arjz84zFax3XkogjY/e3ZneihIgWrVKe5M
 ql16pX4KTkzNgMUKz4bG/XwT3kjcrXshxFLlg7KrHMl287C+W+QOUjnjVeRi/su+SPmjz8VD
 yr11h+ZkVLAWhS+uQJ93jy1NwG8M4t1kBLAVHHD5Vw4FJ+3ouaVYIp1X1Cr8bVKQw33Q1aTd
 ro0kMBb96B9vNu7ciJZ3gvlaBzUEKOgNnq9KaywuLnqrqr4HUIn5JuxZjCjJzt9kTAKcTfp2
 cJM8qpp+2FF5qtbkse9fZ6M64qozgOPr9Tk4Amf9fZEUQ6UNw14mmBZuXSzoHe75gI7TABEB
 AAHNN1PDqWJhc3RpZW4gU1pZTUFOU0tJIDxzZWJhc3RpZW4uc3p5bWFuc2tpQGFybWFkZXVz
 LmNvbT7CwJAEEwEIADoCGyMHCwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgBYhBJwGygpYm/1C
 /GCmwbCaKeiBMmTiBQJdhIHLAAoJELCaKeiBMmTixXIH/2W3kbzRG0UF81jtRRnp0H83rjDT
 v0H+8fgFMRL/7HCJ1QPArkfRJlM2wlJkN+ChP09CCarYfUEHfRCHlTb7At6Yyrz1jziD7ZwX
 8IWHYRXnZkY5eZc5DsiUgq6JH49kt+GPzK8UVP9MTa6zkBpPCUf7LzZ4pD3FihdkT52BU3gI
 d9P49fSI0TYySlb/VKn815aOhvwEr7+Dh3mZUjSh7saofbRmVUOr7p+R3MvvGI19/IJZjeOE
 ZWliODDOt6HnBOtoGSXMcNIFF6snH52D5N5gY88njZjTwhgGGUBix1bsgf/EY0v4R5itZBXB
 B/Ze4Tm++YHaB75hZK6PQu/YRv7OwE0EU19ksQEIALo7jhXddrXBTRu5SAjelV53jyHBJTX/
 vN4nL/VbbW/saca+NJjDSxx5DBmotZbQdWIyZiSIjU/xnTREvtDrl6ZeSsKWd7ZqiuiY4fSR
 zwuQp9rd0yqRuxesrWeyJB1zCSdEvLyKASERt+nxkOA+IzJ4y1qLtvnWr+SL1AXgTMw+Tkyw
 KIDCRWHTIYas11ldGj82gOIpYeXnapeNLHfT4EQwg0NeWYHynJxAQWiX5aPlw0uSpAQSsBXQ
 FIe3fpoveMSnXK+PG2BBOzexYv7r4S70a6sF9sgTTPpfKqUaqqC+u1+bUX6alTAKhGKJywaF
 6ViqLlgY8PfwohSyAlqlTRMAEQEAAcLAdgQYAQgAIAIbDBYhBJwGygpYm/1C/GCmwbCaKeiB
 MmTiBQJdhIHSAAoJELCaKeiBMmTitU8IAK7NQM3fEwaF5XaKtepYWsVka44CD8A9e4r7NVK9
 ugirKvXirIxBSDmN/Db862NmVpITsZ6ERNSNZLm/7k55N+TexKYiFZeU7G92TEfAM6qPElvx
 DLEcrkNMq9r08YZeUloacsq31AL5fK4LW+xdvXudkdiKRMJsdTpmff3x5kIziGOHjwFP9wve
 ZgEH52gpbRsP8Whx/Z2lNX/BBRmFM8OnEXFsjjqDzYThdxTq85wGPpkgvvUGyPNRD7TpbB1C
 pajOUUkPxgj5LKt77HD1afeZNudWhgcdkbtT5PMQTT0WY6wvMEj9S1+bGPeXRGWLYB7gHQ+L
 JNoSD7Kz6Y9qnKo=
In-Reply-To: <20240422-v6-9-topic-imx93-eqos-rmii-v1-0-30151fca43d2@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3291005431560006571
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudekledgudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefurogsrghsthhivghnucfuiiihmhgrnhhskhhiuceoshgvsggrshhtihgvnhdrshiihihmrghnshhkihesrghrmhgruggvuhhsrdgtohhmqeenucggtffrrghtthgvrhhnpeeujeffheehvddtuefhjeevveffkeetfffgtedvjeekleelvdfhjeelfeeludduieenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeduvdejrddtrddtrddupdelvddrudegkedrvdehfedrvdegfedpfeejrdehledrudegvddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepshgvsggrshhtihgvnhdrshiihihmrghnshhkihesrghrmhgruggvuhhsrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeehpdhmohguvgepshhmthhpohhuth

Hello,

On 4/22/24 10:46, Steffen Trumtrar wrote:
> This series adds support for setting the TX_CLK direction in the eQOS
> ethernet core on the i.MX93 when RMII mode is used.
> 
> According to AN14149, when the i.MX93 ethernet controller is used in
> RMII mode, the TX_CLK *must* be set to output mode.

Must ? I don't think that is true. Downstream NXP kernel has an option 
to set TX_CLK as an input:

https://github.com/nxp-imx/linux-imx/blob/lf-6.6.y/Documentation/devicetree/bindings/net/nxp%2Cdwmac-imx.yaml#L69

https://github.com/nxp-imx/linux-imx/commit/fbc17f6f7919d03c275fc48b0400c212475b60ec

Regards,

> 
> Add a devicetree property with the register to set this bit and parse it
> in the dwmac-imx driver.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
> Steffen Trumtrar (3):
>        dt-bindings: net: mx93: add enet_clk_sel binding
>        arm64: dts: imx93: add enet_clk_sel
>        net: stmicro: imx: set TX_CLK direction in RMII mode
> 
>   .../devicetree/bindings/net/nxp,dwmac-imx.yaml     | 10 ++++++++
>   arch/arm64/boot/dts/freescale/imx93.dtsi           |  1 +
>   drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c    | 27 ++++++++++++++++++++++
>   3 files changed, 38 insertions(+)
> ---
> base-commit: 4cece764965020c22cff7665b18a012006359095
> change-id: 20240422-v6-9-topic-imx93-eqos-rmii-3a2cb421c81d
> 
> Best regards,

-- 
Sébastien Szymanski, Armadeus Systems
Software engineer


