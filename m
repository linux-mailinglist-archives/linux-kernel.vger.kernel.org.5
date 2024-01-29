Return-Path: <linux-kernel+bounces-43494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 486F68414BE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F4901F25547
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541D8157E6B;
	Mon, 29 Jan 2024 20:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fNPsd+c9"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E0476C9C;
	Mon, 29 Jan 2024 20:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706561837; cv=none; b=enGmp1rPtn7Ulz55lUh8eX1Y4bbNhAhLV588x2homdMPP6CHH5a3632tlQj8+31IXkqQWVXIOEgIe2NbhQmsiK6pdV3yIWMG+JvmaU3GLtJ77FcOVB2X6GpgHPUw8hkcIMfH+oyDSCz3Q0kHl6QLkbj/tkYbNSox/npzBHoDw4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706561837; c=relaxed/simple;
	bh=qcJpG79JPZcEjWGYou9yoHVaf2EMWDbrknOF51CSKAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QvEXveNsywA3nX9HsJlhBzuuBPKU+9r3fV8Urd3tA30teIGD7RW4wzSihkUk9b38uEy6L9qUojE4Niy1zPbzgsMA0XouCrXlJR08ZbB9+K1h5q4pmZx/LXG1OgiSm2vejN3P/nxH1k0mMjxo3B1Qp2APooCtri47pEW7TPcUUOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fNPsd+c9; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706561833;
	bh=qcJpG79JPZcEjWGYou9yoHVaf2EMWDbrknOF51CSKAQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fNPsd+c9QFzNFRwnRJzFZv8f7hAw1lDKtripO47elLs6ZWrOuXLzrMjVu3oxsbZIl
	 pVFY/+5qIyKOlLKXyNIVVDWrqfTzPWLFQcBzhA1dCtNHSV8IInOroQygRxAre52YRx
	 pD0OcitGB+pFzt+91dhOrCCh2DOjF+fFQhTaSrrzWRzQ0fWXDRfCKGuJRE6yLxvFo0
	 BsrEfXLF65A31fr2l6rymqDF57dFWTwwNE7hodX1sPxUAAka5nzljsWNqQ4IgdxmHk
	 hxObDeHh4pJ7U6paOSO88pflC+z3STfE1zTukYmSGHQ2VkzEEC8x43yrrQinwGOUyc
	 LZ/Bn5vfDjzSg==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 893B23781F9C;
	Mon, 29 Jan 2024 20:57:12 +0000 (UTC)
Message-ID: <1fa5aeee-a205-438a-a0fa-54643ffa41d0@collabora.com>
Date: Mon, 29 Jan 2024 22:57:11 +0200
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
 <f113c4b6-a074-4566-b69b-f25c9590d23f@collabora.com>
 <20240129122651.4b3c7b8e@kernel.org>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20240129122651.4b3c7b8e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/29/24 22:26, Jakub Kicinski wrote:
> On Mon, 29 Jan 2024 20:51:43 +0200 Cristian Ciocaltea wrote:
>>> Well, b4 can do that:
>>>
>>> https://b4.docs.kernel.org/en/latest/contributor/trailers.html
>>>
>>> But i've no idea if the netdev tooling actual does.  
>>
>> Jakub, please let me know how should we proceed further!
>>
>> The problem is that we ended up with a RESEND to include a missing R-b
>> tag from Rob, but afterwards we also got this new R-b from Krzysztof
>> here.  If it's not possible for you to collect both tags, I could
>> prepare a v5 to avoid having another RESEND.
> 
> First off, have another read of our rules:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr
> :)

Oh, net/net-next suffix is required, will make sure to add it next time!

The 24h period restriction is still applicable for a RESEND that is
meant to quickly fix a previous submission issue?

> IMHO forwarding the review tag to a newer version of the set yourself
> (like I just did) is fine. None of the tooling I know checks if that
> the person posting the tag matches the From:

Hmm, I didn't actually test, but according to the link Andrew posted
above, for b4 it might be necessary to make use of the
`--sloppy-trailers` flag:

"Accept trailers where the email address of the sender differs from the
email address found in the trailer itself."

Thanks,
Cristian

