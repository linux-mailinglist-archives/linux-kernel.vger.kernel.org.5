Return-Path: <linux-kernel+bounces-136394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB2A89D393
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B6F9B230B6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EDC7E564;
	Tue,  9 Apr 2024 07:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LDR6LfN0"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF157D096;
	Tue,  9 Apr 2024 07:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712649142; cv=none; b=CtSbWhBnm6NwCIN3/1PABy///OQTCxJcPuN79peosidVFhkYTpk88cKH7PYo7e1tBcq2RSStWenRibtt0wlLE3NZrDCQW8Wu4juHGt2ih5XgODf28BNilDPT9q9Q8K58/0ovbgjcIDGTrgQ+u2dHiBRKHzSeb1f76xn2X6j0tDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712649142; c=relaxed/simple;
	bh=bEhSDx+vWHpXQlt+M7IjBoMc4qQqSypyklKcr1IXMf0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L0YGpSisb3ydNchckIPPEnMFNnn6zR4oERsTJyg/J9S08pOOWAh6SS0zRabPRs8ouIPBUlGiUMZqZBB3UVD6y3fVWiPZGo9uGLhgQqb7MZ2kewot/ASff+3C6zjrE2/0hbL5SSGZVE0EQqAqGy46sqHRAVVUyHma1EdNmv1kSjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LDR6LfN0; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B9A091C0007;
	Tue,  9 Apr 2024 07:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712649132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fv6RYLQFO+Neqn3UJOqdARRddJ1bSBwtGcUX7fOSOmY=;
	b=LDR6LfN0SwuGCykwpiBkJhA675YPhZc5smBYQgzhs2+vOL71choduSOtMKeCZ2zbteNJn0
	dGJwqyul7Z0JOPsG62iRy8pajSj5AEAeMSVy/lf4TLETXNF1+gDsC3OFpHo5nmtmXmRFzk
	aK/qznAU2TBbbDw3G/qIeT9fmNuBkNYfUFo8TPzXqqQq9ROFOWCt23M2DTALqh8KAfENcL
	39BBu5x5ef4Kx9BZzIoskU8FeKrLjpWy7qDStgYb/F9C9n6l7y2MGK3BfMeHJCtaxBVuKG
	yAT8KjC8HZjDZlX+o0rAr5v3PFUrw6zbXrRxMjPPvNY0tIJjA+f1xCEJ8KDrcw==
Message-ID: <7364e62f-b776-42c2-b063-319aa939da29@bootlin.com>
Date: Tue, 9 Apr 2024 09:52:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@bootlin.com, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: sophgo: add initial Milk-V Duo S board device
 tree
To: Inochi Amaoto <inochiama@outlook.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <20240409064504.4010353-1-michael.opdenacker@bootlin.com>
 <IA1PR20MB49532A8D4294ADCE0C33A654BB072@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <IA1PR20MB49532A8D4294ADCE0C33A654BB072@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: michael.opdenacker@bootlin.com

Hi Inochi

Thanks for the review and tips!

On 4/9/24 at 09:17, Inochi Amaoto wrote:
> On Tue, Apr 09, 2024 at 08:45:04AM +0200, michael.opdenacker@bootlin.com wrote:
>> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>>
>> This adds initial support for the Milk-V Duo S board
>> (https://milkv.io/duo-s), enabling the serial port and
>> read-only SD card support, allowing to boot Linux to the
>> command line.
>>
> Hi Michael,
>
> I think your patch losts the board binding and have wrong compatiable.
> Also, the SD can have rw support with proper property. See link [1]
> (need 'disable-wp').

Right, ""sophgo,sg2000" doesn't exist yet, so it will be indeed cleaner 
to use "sophgo,cv1812h" instead.

>
> I suggest you resubmitting this patch after applying clk patchs.
> This could reduce some unnecessary change. For now, you can just
> use the dts for huashan-pi (with changed memory size).
>
> [1]: https://lore.kernel.org/linux-riscv/IA1PR20MB4953B158F6F575840F3D4267BB7D2@IA1PR20MB4953.namprd20.prod.outlook.com/

Good to know. That was next on my list.
I'll submit a V2 in the next days.
Thanks again
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


