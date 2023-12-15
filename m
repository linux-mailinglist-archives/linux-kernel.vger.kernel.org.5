Return-Path: <linux-kernel+bounces-1663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574938151B8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100C52868A0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136AC47F77;
	Fri, 15 Dec 2023 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aQQW59io"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1040F3E49F;
	Fri, 15 Dec 2023 21:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702674794;
	bh=4Z0A8i3BQDX4XSWXqY1AsxNZ2UXBxVUatce/rv4lcqQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=aQQW59ioaNIQdMzt2vbe1pPJEASAIpZfAf6FHXhPw68vkAGU+ykS3yUhdCPVM1NSb
	 9wwk6IO6HDR5/myECbvSXLfKm5Tu1Iabzgg5CNmFx4rW+jmjwj80FBF83uWeDme4E6
	 1tGMZeRLjHm0LxPxHWvry3YxYPwwEWoHSeQ6LPFtKaDgt7FqT1Ls1jV3RGzxpIXezZ
	 vDrQdzgzA2tZNIFtHVeEXRklDATFU6vLymVPKRTOAIMhrGbCxZsXxCzX8B/wwE5wnL
	 SjuVBwV09aKtYTSaLrHp/5ZV+wzmPZtj2vSaXlJ30rCvmJRVYltyXoTaZsyioLFSMq
	 jNgqz9s408vhw==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 66C133781489;
	Fri, 15 Dec 2023 21:13:13 +0000 (UTC)
Message-ID: <698fbb5d-0750-4f2a-857f-5429e5f589f9@collabora.com>
Date: Fri, 15 Dec 2023 23:13:12 +0200
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
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
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
In-Reply-To: <2f06ce36-0dc1-495e-b6a6-318951a53e8d@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/23 02:40, Cristian Ciocaltea wrote:
> On 11/26/23 23:10, Emil Renner Berthing wrote:
>> Cristian Ciocaltea wrote:
>>> The BeagleV Starlight SBC uses a Microchip KSZ9031RNXCA PHY supporting
>>> RGMII-ID.
>>>

[...]
 
>> You've alse removed the phy reset gpio on the Starlight board:
>>
>>   snps,reset-gpios = <&gpio 63 GPIO_ACTIVE_LOW>
>>
>> Why?
> 
> I missed this in v1 as the gmac handling was done exclusively in
> jh7100-common. Thanks for noticing!

Hi Emil,

I think the reset doesn't actually trigger because "snps,reset-gpios" is
not a valid property, it should have been "snps,reset-gpio" (without the
trailing "s").

However, this seems to be deprecated now, and the recommended approach
would be to define the reset gpio in the phy node, which I did in [1].

Hopefully this won't cause any unexpected behaviour. Otherwise we should
probably simply drop it.

[1]: https://lore.kernel.org/lkml/20231215204050.2296404-8-cristian.ciocaltea@collabora.com/ 

