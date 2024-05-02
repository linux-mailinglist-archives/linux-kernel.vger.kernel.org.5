Return-Path: <linux-kernel+bounces-166529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDAC8B9BDE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78FC1283DB7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A9013C67F;
	Thu,  2 May 2024 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="L7qM0Yeh"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07523219F6;
	Thu,  2 May 2024 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714657701; cv=none; b=Keq0FTLwNFdiltC87+RTl1PLBb38LPgQ18/8dzdlMNtMXF7ZURUIkHK7AGI7CD5Lz0aNO5YeSZsLHEr2+Tc7ClzNlKKlmywU4Mve3yHZ1Xl05hPl0Yt7XH23T3E5NY6M49EbvjxtYHUgoz/oDmnVfUHiJtdeR0RVfhkGJnhYUtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714657701; c=relaxed/simple;
	bh=Nb9QG/hiF4MCc1aGpGBZ5sembeHGyI0PvBzQgIMebIg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=G0uCKUTbgfJzGJmlt6oH8HJkUS9mrRb/pZn8AgPyFGA5QbbN88IlSmIyl/7DjaRNF7jndX/8o4f1POL7VqFSckm4BgzXcrvi7VZnnTaaQyE8C03xzoBlxQ0ZGuotpIyr0wag4pI/P98RoTGIzI3Sl4NsZqIu+3cLmcG0bUE8PZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=L7qM0Yeh; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714657694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LEqxNv/ZEWBiZkoBrhIM8aPkJu0KWOsw1ID/dBB65tg=;
	b=L7qM0YehjtUFSjdsa58JGuf67lT/LgsRo+SnwLmVUAMtYfNhGU6+yCYcuael2rf3nes9hG
	cXsFKLRIXvDezfO42WqVeDJp4Amob1ZuUvkRMJUoJLhQoW/FH687xnPKvsHCM9Ph48pkNn
	qa+w3eUZd90UfecMfb0k0tEfgGLYZ2UI4PevXFXo/SV8bw5Pxlo1N15nCrELahXO2Om/Lq
	icahHzdrzA39F/izxMeItIC6R0wCCjx3jzixI7IWXwfaWlpdz+uPXFK0DRr09YoxX26WLH
	8kc8GgUzimVuXZOMzDK5I4fIBYwrNCITx5MM9jfdyen2grhWwO4x08kzTkBwsg==
Date: Thu, 02 May 2024 15:48:09 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Folker Schwesinger <dev@folker-schwesinger.de>, Chukun Pan
 <amadeus@jmu.edu.cn>, Heiko Stuebner <heiko@sntech.de>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring
 <robh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: Add Radxa ROCK 3C
In-Reply-To: <832d6c37-a6c5-4468-9a23-1637b2affb90@kwiboo.se>
References: <20240428123618.72170-1-amadeus@jmu.edu.cn>
 <20240428123618.72170-3-amadeus@jmu.edu.cn>
 <D0X7UJELGST3.2IL1AFDJ89N07@folker-schwesinger.de>
 <ded928414323ef4be51f2575d00ba7d1@manjaro.org>
 <832d6c37-a6c5-4468-9a23-1637b2affb90@kwiboo.se>
Message-ID: <afa32c669ded2d37a4c11a54f1fc05b0@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Jonas,

On 2024-05-02 14:17, Jonas Karlman wrote:
> On 2024-05-02 03:28, Dragan Simic wrote:
>> On 2024-04-30 07:42, Folker Schwesinger wrote:
>>> On Sun Apr 28, 2024 at 2:36 PM CEST, Chukun Pan wrote:
>>>> [...]
>>>> +&sdhci {
>>>> +	bus-width = <8>;
>>>> +	max-frequency = <200000000>;
>>>> +	mmc-hs200-1_8v;
>>> 
>>> Out of curiosity, does this board also support HS400? From a very 
>>> brief
>>> look this board seems quite similar to Rock 4 series boards, that do
>>> support HS400.
>> 
>> In a word, no, unfortunately.  In more detail, the Rockchip RK3566
>> and RK3568 SoCs support the eMMC modes up to and including HS200, but
>> not the HS400 mode.
> 
> The datasheet for RK3568 only mention HS200 mode, however, HS400 mode 
> is
> working in U-Boot after adjusting tap number for transmit clock [1].
> Linux may need similar adjustment to make HS400 mode work on RK3568.
> 
> RK3566 that this board use only support HS200, as specified in 
> datasheet.

Oh, that's very interesting, thanks for pointing it out!

What makes me a bit worried about enabling the undocumented HS400 mode
on the RK3568 is that neither the RK3568 Hardware Design Guide (HDG),
version 1.2, [2] mentions HS400 support.  I mean, the RK3568 datasheet
may be wrong about not mentioning HS400, but what are the chances for
the RK3568 HDG to also be wrong there?

In other words, maybe there are some hard-to-trigger hardware issues
in the RK3568 that made the HS400 mode, although actually present in
hardware, officially unsupported for the RK3568?  Maybe there's even
some non-public errata from Rockchip, who knows.

[1] 
https://source.denx.de/u-boot/u-boot/-/commit/5c053f3adc69eaf83645b5d44c6adbb2d49a3fa7
[2] https://dl.xkwy2018.com/downloads/RK3568/RK356X/Hardware/

