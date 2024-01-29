Return-Path: <linux-kernel+bounces-43366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9FC8412BD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287672874C3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF8F2AD0F;
	Mon, 29 Jan 2024 18:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Y+JaK629"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997CE76C89;
	Mon, 29 Jan 2024 18:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554309; cv=none; b=PV2zDRK/7PbO4lnicTWezwMqYlMbDe+TPnMqs503dBsnmV9MONR3gMu5/dkaTzfOUMOIVBjJT7bOIIAgrtZ1mynoWxlwPJI+W1rJ6hrEkd9u9D0cx2sFq/50zTtmfzzdSoT+OCCbAdhXiH50+RAekB4K3XnSNb0UePCV4h6wy4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554309; c=relaxed/simple;
	bh=KNDPO1AK9Y+B5htTE+wIMRsWzJnfFIi+OJEvFCF6Slc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3x69Au3UxWX0L4Yi7O0n5Wp8/TlmseqGF2CYE8P6ev5KVTZzNffKk+jPp/17uawHmbC+5nLmOgehgTIlO8DOgXF+ltYk3PCW5z2WuJ9wGc/lnq+anozk98qTOdJ5pSf73023KMt/r28PpqE2H0glGGz2w1ABlx05V1jDAyyyHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Y+JaK629; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706554305;
	bh=KNDPO1AK9Y+B5htTE+wIMRsWzJnfFIi+OJEvFCF6Slc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y+JaK629Tyi3MjmzCnMFi0XgqXhkHCjFWan9e/FQM1J9xZdU6PwMPzgNWkgR7MZF2
	 dfYDFrle67cmZvgBzyO4sfQBCl7m6VFsQ0MnWv4uz+jOB5Ja6sPVuRejO+A2ddQ9Lx
	 p12wFEqLUAp4lHzFU5mV7jlX319uFXr4sh3ftrmyamQkgtrc9/lVnnFdBgZe4iffd7
	 fjZywJHWznoAFdqu9yA+CTwY/VdnGdU+FSTAA681QRX6Mo3vGDj+/fed/CVTpj0kIG
	 i6hGXCOK+ktnoSkv2S8KP3FtRszB7CQ/5XsnXqHeTzUcvPmk4F2w7Mf3EyTjsc+1pv
	 9LfV2WqdRvtbw==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 182853780EC6;
	Mon, 29 Jan 2024 18:51:44 +0000 (UTC)
Message-ID: <f113c4b6-a074-4566-b69b-f25c9590d23f@collabora.com>
Date: Mon, 29 Jan 2024 20:51:43 +0200
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
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
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
 <8c4cfc54-bd23-4d56-a4ae-9f3dd5cedb59@collabora.com>
 <e99e72b3-e0f6-4a80-82c8-bd60c36d180a@lunn.ch>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <e99e72b3-e0f6-4a80-82c8-bd60c36d180a@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/29/24 18:54, Andrew Lunn wrote:
> On Mon, Jan 29, 2024 at 06:38:27PM +0200, Cristian Ciocaltea wrote:
>> On 1/29/24 15:34, Andrew Lunn wrote:
>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>
>>>> Thank you for the review!
>>>>
>>>> Could you please apply it to the RESEND version [1] instead, as this one 
>>>> had an issue collecting the latest tags, as indicated in [2].
>>>>
>>>> Regards,
>>>> Cristian
>>>
>>> Hi Cristian
>>>
>>> IT is your job as developers to collect together such reviewed-by:
>>> tags add apply them to the latest version. So long as there are no
>>> major changes, they are still consider applicable.
>>
>> Hi Andrew,
>>
>> Jakub requested a rebase, but I missed a tag and that's why I submitted
>> the RESEND.  Now we got this new tag which is not on the RESEND
>> submission, that's why I asked Krzysztof if he could add his R-b on that
>> one.  Unless the maintainers' tooling is able to fetch tags from both
>> submissions?!
> 
> Well, b4 can do that:
> 
> https://b4.docs.kernel.org/en/latest/contributor/trailers.html
> 
> But i've no idea if the netdev tooling actual does.

Jakub, please let me know how should we proceed further!

The problem is that we ended up with a RESEND to include a missing R-b
tag from Rob, but afterwards we also got this new R-b from Krzysztof
here.  If it's not possible for you to collect both tags, I could
prepare a v5 to avoid having another RESEND.

Thanks,
Cristian

