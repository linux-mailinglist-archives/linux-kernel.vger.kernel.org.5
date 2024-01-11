Return-Path: <linux-kernel+bounces-23961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A4582B483
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2385F1F2560B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D65553807;
	Thu, 11 Jan 2024 18:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="k15I3w8q"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293CF537E3;
	Thu, 11 Jan 2024 18:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704996431;
	bh=lv5L2wbjPc1YW+bfBQ2xAmvYm+GCTmQkkdH8Qjc9HRw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k15I3w8q1Xt6+sO+soQbwSrQPfh0RCgowNT2FUnLnjHfgzEghTstoGgHA4O9JIbRZ
	 4ghe80QPeXKCGlKmaV/VCtqhawWXnRUrUwCbqmYdk3IHFJ/nlFNUqox206qYmftSt1
	 NWC3/vhnl5q3AFfcQKUV2vNUsDoRd1QBR2E7J6/iHsKiNZ4cFFn2ZKVoISuu2Kf2Sx
	 /U3YJ4N5DwnBp5EeOgMf60+7nhZgOS/r7gFl95KJDIqXZJi5KnRvJZUOkf4xP3at5u
	 8egkGmktDDfQtE3ySHf6ZqrmdhV1I4gZqfGTP6hi4L0dEnHF4k4PI4aLDv1P7q5Zc2
	 Z4/kZvag02TxQ==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 82F463781FCF;
	Thu, 11 Jan 2024 18:07:09 +0000 (UTC)
Message-ID: <59bb488f-f2ad-44b0-87fa-206ae3b1c33f@collabora.com>
Date: Thu, 11 Jan 2024 20:07:08 +0200
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
To: Tan Chun Hau <chunhau.tan@starfivetech.com>,
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
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20240111025531.2875-2-chunhau.tan@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/24 04:55, Tan Chun Hau wrote:
> Add StarFive JH8100 dwmac support.
> JH8100 dwmac has one reset signal instead of 2 resets as in JH7110.
> 
> Signed-off-by: Tan Chun Hau <chunhau.tan@starfivetech.com>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
>  .../bindings/net/starfive,jh7110-dwmac.yaml   | 50 +++++++++++++------
>  2 files changed, 37 insertions(+), 14 deletions(-)

[...]

Please note this is going to conflict with the about-to-be-merged changes
in [1], so probably it makes sense to wait for that to be picked up before
sending a new revision.  

[1]: https://lore.kernel.org/lkml/20231222101001.2541758-2-cristian.ciocaltea@collabora.com/

Regards,
Cristian

