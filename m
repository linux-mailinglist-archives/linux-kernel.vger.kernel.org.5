Return-Path: <linux-kernel+bounces-43130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D49840BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BD4DB25E9F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA00015B112;
	Mon, 29 Jan 2024 16:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ryz3Ho7x"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4A715B0F2;
	Mon, 29 Jan 2024 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706546313; cv=none; b=hSc6g1K29+8Q690elht+kvtbP+2trJBUIPjwVFnxcOvTWMvu8prXZy8DxoIXsMIV9IzaMyVvqUo1vL/JRXE4IcPIQiCsDhkGn0zcfFJhzPQaWJTglnmOJSgEUm58zJi8zcxskvT/DoAbo18eXcGxL+icW7lQ4jxfmbJo+k2060c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706546313; c=relaxed/simple;
	bh=W9vkODe01nZU/vsOeFljqJlU/NDJWJCqj+YoON9Vw/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZjcoSz1WFGJJ/zq4S4Gv7NygwAkGVPIoGpLwHSfiQHkxsEoBRcAVgymx4cLMOktB4V3hzfiRIpOO50G25XSG97eqR5e3F6b5ZYv9JQ7Ag/1wybYCDoEmrhYxiJMQJPZhwQqEskLBCErYApjvFilN8BoktH05BO7xMBhC8r6BerU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ryz3Ho7x; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706546309;
	bh=W9vkODe01nZU/vsOeFljqJlU/NDJWJCqj+YoON9Vw/o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ryz3Ho7xG3VZ/wYLhKXp90cwOJ07dcV0//QRevsVQw8Xk0DtIqZGGQdQcypWEi4XG
	 z1El1hlesOFhFoSVgKKoHlv624qElDryQM6P5lya85UF6Rxx/KE6eqnJySdWy58WHc
	 xFs6ZZwU35BmBX2WDySf9HfHmT2M3muyPPPqv1sBN8Y5UmFaB6FJRd/3dhJUldcOAZ
	 HuexK+dRwRxiTuYcLf19UIojelxUE+Sh9CSU0hJvghURFGURV5hDC3gJpj8qxaVRpU
	 GMLvuQtpHIU9Pka/aHWBNDN2gAsxE8yshklBkgotL+a8D++UbLwz2EGGRDGqx2r7Nj
	 9rxbPS3qdnHJQ==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 30A6C37814A4;
	Mon, 29 Jan 2024 16:38:28 +0000 (UTC)
Message-ID: <8c4cfc54-bd23-4d56-a4ae-9f3dd5cedb59@collabora.com>
Date: Mon, 29 Jan 2024 18:38:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: net: starfive,jh7110-dwmac: Add
 JH7100 SoC compatible
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>,
 Samin Guo <samin.guo@starfivetech.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20240126191319.1209821-1-cristian.ciocaltea@collabora.com>
 <20240126191319.1209821-2-cristian.ciocaltea@collabora.com>
 <0a6f6dcb-18b0-48d5-8955-76bce0e1295d@linaro.org>
 <e29ae12b-5823-4fba-8029-e8e490462138@collabora.com>
 <56f3bd3c-c099-405b-837b-16d8aeb4cc4b@lunn.ch>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <56f3bd3c-c099-405b-837b-16d8aeb4cc4b@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/29/24 15:34, Andrew Lunn wrote:
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> Thank you for the review!
>>
>> Could you please apply it to the RESEND version [1] instead, as this one 
>> had an issue collecting the latest tags, as indicated in [2].
>>
>> Regards,
>> Cristian
> 
> Hi Cristian
> 
> IT is your job as developers to collect together such reviewed-by:
> tags add apply them to the latest version. So long as there are no
> major changes, they are still consider applicable.

Hi Andrew,

Jakub requested a rebase, but I missed a tag and that's why I submitted
the RESEND.  Now we got this new tag which is not on the RESEND
submission, that's why I asked Krzysztof if he could add his R-b on that
one.  Unless the maintainers' tooling is able to fetch tags from both
submissions?!

Thanks,
Cristian

