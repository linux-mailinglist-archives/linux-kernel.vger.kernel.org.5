Return-Path: <linux-kernel+bounces-42489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B11840213
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94DD1F22661
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C4455E50;
	Mon, 29 Jan 2024 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jVYbEqyD"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A7055E49;
	Mon, 29 Jan 2024 09:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521765; cv=none; b=gwAKoDNm4IawnrqHXy+IqLVYC8LcploCQ6uS/qFR+VqKMkglQMJDZrbY1ru0W/B9edoOx0mfXrWkw91MGXtWlrCpwm0V3kUrNYqzYDUFAw0w4OQYl0S/i2wcETH8433TWarnOWrVkBjs0sbnuSfwkM6bz9NLvS+SKg5rDEoEfvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521765; c=relaxed/simple;
	bh=BcsHhEXWi5xMJWTtz5/c5ki18Idpl9aWenNr9qUQymg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IckgAX2NK5cd/1HquhtETzj7DN1iJaKiymdhNomnlkuAkA8J0eY7cMzWPWCmo1TyiMtD6WDq1bQNLSFMPjTlX5SNjasnuF8/r0ZacK7kAu65YNDGCpEUTrnn2g406uqz4Fg+2yOC7+yoAbFmJgqqyA3iUXXK2ZQA0xUKc/paJUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jVYbEqyD; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706521762;
	bh=BcsHhEXWi5xMJWTtz5/c5ki18Idpl9aWenNr9qUQymg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jVYbEqyDuZW+HE+sdCpLKAAKTpOEi8F0b29iUJ0QWx1IxYqdkztJpU1N1zHnOqtUQ
	 xmcF2ZVfLMveGB5RbvT+pDLrpIjqKuiBuXyEWbI8NZKNN8qrendUhDEum03NJ1QAPW
	 jSd79i5YCAy4XBVBNNcGbYQPUSJE/6l2YZ74nImp7ljO2RSpRdc+xoHViHElBzo5l4
	 xx7L0RssUdwqXf55PCqO6cHGyIrceKkwCl9Qy8iDuSN2adxhfufQed1930I9dc87mE
	 aGWiAgewzYzk3kvftAPR0BwGLrd+3DlBGfxc6cxOXMz2D1GTAQJYisqlGIka15by4n
	 AXSbspLqZMO6g==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 23AF13781F92;
	Mon, 29 Jan 2024 09:49:21 +0000 (UTC)
Message-ID: <e29ae12b-5823-4fba-8029-e8e490462138@collabora.com>
Date: Mon, 29 Jan 2024 11:49:20 +0200
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
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>,
 Samin Guo <samin.guo@starfivetech.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, Andrew Lunn <andrew@lunn.ch>,
 Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20240126191319.1209821-1-cristian.ciocaltea@collabora.com>
 <20240126191319.1209821-2-cristian.ciocaltea@collabora.com>
 <0a6f6dcb-18b0-48d5-8955-76bce0e1295d@linaro.org>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <0a6f6dcb-18b0-48d5-8955-76bce0e1295d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 1/29/24 10:26, Krzysztof Kozlowski wrote:
> On 26/01/2024 20:13, Cristian Ciocaltea wrote:
>> The Synopsys DesignWare MAC found on StarFive JH7100 SoC is mostly
>> similar to the newer JH7110, but it requires only two interrupts and a
>> single reset line, which is 'ahb' instead of the commonly used
>> 'stmmaceth'.
>>
>> Since the common binding 'snps,dwmac' allows selecting 'ahb' only in
>> conjunction with 'stmmaceth', extend the logic to also permit exclusive
>> usage of the 'ahb' reset name.  This ensures the following use cases are
>> supported:
>>
>>   JH7110: reset-names = "stmmaceth", "ahb";
>>   JH7100: reset-names = "ahb";
>>   other:  reset-names = "stmmaceth";
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thank you for the review!

Could you please apply it to the RESEND version [1] instead, as this one 
had an issue collecting the latest tags, as indicated in [2].

Regards,
Cristian

[1] https://lore.kernel.org/lkml/20240126192128.1210579-2-cristian.ciocaltea@collabora.com/
[2] https://lore.kernel.org/lkml/920e764c-4fa3-4298-bb49-d31416fc3dd6@collabora.com/

