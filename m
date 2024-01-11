Return-Path: <linux-kernel+bounces-23973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A881282B4B2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5453B22327
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A8453E1B;
	Thu, 11 Jan 2024 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="f5f17p5i"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C1552F74;
	Thu, 11 Jan 2024 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704997198;
	bh=rdyPLDn+13S8BwUHnP7YxTnuD0iUYoq80Xm8fz63qzo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f5f17p5iX/IKt6UN9Jwhpvty5sF74a26euidP8Pxt2/AltKRl6P2rYTZeD83Ejeds
	 /dMXSUYZNHdOLM6nKJPpCgQhPvzM0eBkPkFgeTBinDrx6Vs+BQbIbEkBoj0W3VVxR3
	 agxPbZcpLNRMMfn2q/p85xQq9cgf1sHxDs36uqkaW1DGrPl1hqnKf3bjEAti51u+IB
	 5JKTT4TlxopMAwm2pQ7vhXLIdpsdF6Lp17eVWH70y/matvJbG46IP3s3JkGtk+PEp2
	 oLqifpP4etBYdVOMdXc4kp4M64NZp7d8obqjLFjqFk0fz8qWtN+fg6x2JNi2n2yiXG
	 L7oJjibzUlfsA==
Received: from [IPV6:fd00::3:29cf] (cola.collaboradmins.com [IPv6:2a01:4f8:1c1c:5717::1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 587143781184;
	Thu, 11 Jan 2024 18:19:49 +0000 (UTC)
Message-ID: <e821e651-2074-41c2-82c1-0fc88b3f5664@collabora.com>
Date: Thu, 11 Jan 2024 20:19:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] dt-bindings: net: starfive,jh7110-dwmac: Add
 StarFive JH8100 support
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Tan Chun Hau <chunhau.tan@starfivetech.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Simon Horman <horms@kernel.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Andrew Halaney <ahalaney@redhat.com>, Jisheng Zhang <jszhang@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Russell King <rmk+kernel@armlinux.org.uk>
Cc: Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 Jee Heng Sia <jeeheng.sia@starfivetech.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
References: <20240111025531.2875-1-chunhau.tan@starfivetech.com>
 <20240111025531.2875-2-chunhau.tan@starfivetech.com>
 <59bb488f-f2ad-44b0-87fa-206ae3b1c33f@collabora.com>
 <3c552324-2ebf-41c2-b310-70341ebfdd9a@linaro.org>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <3c552324-2ebf-41c2-b310-70341ebfdd9a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/24 20:15, Krzysztof Kozlowski wrote:
> On 11/01/2024 19:07, Cristian Ciocaltea wrote:
>> On 1/11/24 04:55, Tan Chun Hau wrote:
>>> Add StarFive JH8100 dwmac support.
>>> JH8100 dwmac has one reset signal instead of 2 resets as in JH7110.
>>>
>>> Signed-off-by: Tan Chun Hau <chunhau.tan@starfivetech.com>
>>> ---
>>>  .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
>>>  .../bindings/net/starfive,jh7110-dwmac.yaml   | 50 +++++++++++++------
>>>  2 files changed, 37 insertions(+), 14 deletions(-)
>>
>> [...]
>>
>> Please note this is going to conflict with the about-to-be-merged changes
> 
> They weren't picked up, so how they can be merged? If you mean applied,
> then you suggest your patchset has some kind of preference, but this
> needs explanation why.

I just meant they got reviewed and should be ready to be applied.

> Best regards,
> Krzysztof
> 

