Return-Path: <linux-kernel+bounces-30951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033368326B1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290BA1C231CA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992043C06B;
	Fri, 19 Jan 2024 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1ET+SY7K"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD3E3BB3B;
	Fri, 19 Jan 2024 09:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705656515; cv=none; b=Il83y/2jQ6BuQEAFX1PCKAY3Bnau+u0EJBM+A8u61xlMURa5A4bp9yCe27KI/NwbxryC69v0Wijaxuwzzm26ZOcsWDbsfV8/P843RvR0gpFl0gGdKcGABCrhwIXYHeOna/MHrZaPxSU3F9STOFFsRHzW3E1yqdmRiWRGd6yLyRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705656515; c=relaxed/simple;
	bh=Lhbql/RT2O/SWJDfGJ70KFwReffC1OnjFnXgYb8Q0nI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBdZj1KnAHjMaj4FCHRpPfVsLZ0EqHMDsdoK8CR5+8/Bn3IDtmHKWbNcCtvJYNnKsLvsFsSb/fmOKqcjh17JXyYdPFx/lePoQQd8im8JfpkPV3qPuavzvMrdr2QcdVgC3ZfZ2kRUD1lARz652Z6EBVqqI8/tfNEMJZovx/+K8Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=1ET+SY7K; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705656512;
	bh=Lhbql/RT2O/SWJDfGJ70KFwReffC1OnjFnXgYb8Q0nI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=1ET+SY7K7XySrZyuXVekgjjQz1L29u/gNLqq8DRykljix0PWXmKfCEhw7nx8qOQ9T
	 qsth7UfW62Bg7siz/4nbAHpv/9b+QzVskY/tbaGfAIDKdBtFM8s8gPGfeH30eaWBMT
	 p78Or/RanDDOJ9pVaJRFXez0D/eQCOMTI0CkMcNft+Y+EAEz6uARYxmzOGvXdQUa+K
	 wbBxmjxAnSCk+77vnE2m6CaqGTCBEf9BiVcAPHvhTf4X/43ayWEOiT576soOJy1bvV
	 pN/d0B4adJc+4EPa2Mbo14esown6eDPApaz2KdD3h8gFT+VWGFcO+ZrqnI95sa5Wa9
	 NC7iCNCmReOYg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4B65837811F1;
	Fri, 19 Jan 2024 09:28:31 +0000 (UTC)
Message-ID: <43f946cc-07e1-48c5-9b31-40fc9bc93037@collabora.com>
Date: Fri, 19 Jan 2024 10:28:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Aw: Re: [PATCH v3 1/2] dt-bindings: reset: mediatek: add MT7988
 reset IDs
Content-Language: en-US
To: Frank Wunderlich <frank-w@public-files.de>,
 Conor Dooley <conor@kernel.org>
Cc: Frank Wunderlich <linux@fw-web.de>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Sam Shih <sam.shih@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20240117184111.62371-1-linux@fw-web.de>
 <20240117184111.62371-2-linux@fw-web.de>
 <20240118-calcium-krypton-3c787b8d1912@spud>
 <trinity-afc4f48e-65e1-46ee-a78b-1d670cc0f310-1705615200900@3c-app-gmx-bap21>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <trinity-afc4f48e-65e1-46ee-a78b-1d670cc0f310-1705615200900@3c-app-gmx-bap21>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/01/24 23:00, Frank Wunderlich ha scritto:
>> Gesendet: Donnerstag, 18. Januar 2024 um 17:49 Uhr
>> Von: "Conor Dooley" <conor@kernel.org>
>> On Wed, Jan 17, 2024 at 07:41:10PM +0100, Frank Wunderlich wrote:
>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>
>>> Add reset constants for using as index in driver and dts.
>>>
>>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>>> ---
>>> v3:
>>> - add pcie reset id as suggested by angelo
>>>
>>> v2:
>>>   - add missing commit message and SoB
>>>   - change value of infrareset to 0
>>> ---
>>>   include/dt-bindings/reset/mediatek,mt7988-resets.h | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/include/dt-bindings/reset/mediatek,mt7988-resets.h b/include/dt-bindings/reset/mediatek,mt7988-resets.h
>>> index 493301971367..0eb152889a89 100644
>>> --- a/include/dt-bindings/reset/mediatek,mt7988-resets.h
>>> +++ b/include/dt-bindings/reset/mediatek,mt7988-resets.h
>>> @@ -10,4 +10,10 @@
>>>   /* ETHWARP resets */
>>>   #define MT7988_ETHWARP_RST_SWITCH		0
>>>
>>> +/* INFRA resets */
>>> +#define MT7988_INFRA_RST0_PEXTP_MAC_SWRST	0
>>> +#define MT7988_INFRA_RST1_THERM_CTRL_SWRST	1
>>
>> These are just "random" numbers, why not continue the numbering from the
>> ETHWARP?
> 
> i can do...basicly these consts are used in DTS and driver only as index.
> 
> @angelo what do you think? I though also in leaving some space to allow grouping RST0 and RST1
> when more consts are added, else the numbers are mixed up.
> 
> so e.g. let RST0 start at 20 and RST1 at 40 (or even higher, because RST0 and RST1 can have up to 32 resets).
> That will allow adding more reset constants between my values and having raising numbers.

The resets are organized on a per-reset-controller basis, so, the ETHWARP
reset controller's first reset is RST_SWITCH, the second one is RST_something_else,
etc. while the first reset of the INFRA reset controller is PEXTP_MAC_SWRST.

That's why ETHWARP has a reset index 0 and INFRA also starts at 0.
I think that the numbering is good as it is, and having one driver start at index 5
while the other starts at index 12 would only overcomplicate registering the resets
in each driver, or waste bytes by making unnecessarily large arrays, for (imo) no
good reason.

This is one header, but it should "in theory" be more than one... so we would have
one for each hardware block - but that'd make the reset directory over-crowded, as
other MediaTek SoCs have got even more resets in even more hardware blocks than the
MT7988. That'd be something like ~4 reset headers per SoC (and will increase with
newer ones)...
..and this is why we have one binding header for resets.

On the topic of leaving space to allow grouping RST0/RST1: -> No. <-
The indices have to start from zero and have to be sequential, with no holes.

Cheers,
Angelo


