Return-Path: <linux-kernel+bounces-8097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A04781B225
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38181F251E0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412834C606;
	Thu, 21 Dec 2023 09:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OfzQ+ypJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCEF4C3DD;
	Thu, 21 Dec 2023 09:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D18CB60005;
	Thu, 21 Dec 2023 09:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703150034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wHNg0+IPAbNxP2IwWFqfBhWUeZ9oQWypKm/SCO/8EJo=;
	b=OfzQ+ypJt2+Ay8YJbRhwHqyhv7uq4kuuvyHx6hjUc2/VSJyTKS4Dy+t6AmTtUHva92dnpI
	yn0KQyk0tBbOipnmbLwVRnGmmKlsIH5qJzAI4qOLwt8J815Y+icUTnOYGWJetMw52bsVI0
	KmZM8dbdxjMhmrKS9+2+WGJqGDuYG4J/mrjAv7dkSzg0yksW0JTloyzXCahc68NdfJNfeV
	bRYAlgqYRp4pvUEHcA87OI3J7NzXl4+7OVBSzhJVRxblO9+vTHfp/3T0tNRH+5h/DHdYR2
	Tus15f+qcHrC//oAMXrc37KAZ2qjr9FgJlt2ZcBftfaRV82bK89yjvZBeomxvw==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>, linux-mips@vger.kernel.org, Jiaxun
 Yang <jiaxun.yang@flygoat.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vladimir
 Kondratiev <vladimir.kondratiev@mobileye.com>, Tawfik Bayouk
 <tawfik.bayouk@mobileye.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, =?utf-8?Q?Th=C3=A9o?= Lebrun
 <theo.lebrun@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 00/22] Add support for the Mobileye EyeQ5 SoC
In-Reply-To: <87frzwasxo.fsf@BL-laptop>
References: <20231212163459.1923041-1-gregory.clement@bootlin.com>
 <878r5vctdg.fsf@BL-laptop> <ZYNhbQjMbAH6I0kI@alpha.franken.de>
 <87frzwasxo.fsf@BL-laptop>
Date: Thu, 21 Dec 2023 10:13:53 +0100
Message-ID: <87cyuzc3zi.fsf@BL-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com

Gregory CLEMENT <gregory.clement@bootlin.com> writes:

[...]

>>> 
>>> A few weeks ago, you were concerned about the introduction of the
>>> specific kconfig CONFIG_USE_XKPHYS to support EyeQ5, and you wanted us
>>> to set up a new platform instead. Since then, Jiaxun proposed a series
>>> that was merged here to provide more generic support.
>>
>> well, there is more to improve and stuff I don't like in Jaixun series.
>> For example misusing CONFIG_PHYSICAL_START to force a load address via config
>> (IMHO it's already a hack for CRASH_DUMP).
>>
>> As there is your series and Jiaxun series, where should I comment more
>> detailed ?
>
> I think you could start on Jiaxun series but the one merged in my
> series, because I already had a few fixes for it.

This sentence was not very clear, let me rephrase it: I recommend
starting the review with Jiaxun's series, specifically examining the
code that has been incorporated into my series. This is important as I
have already made several modifications to his original code


>>
>>> I had other issues in the initial series, and I think that now I've
>>> fixed all of them. So, I would like to know what your opinion is now
>>> about this series.
>>> 
>>> Will you accept it, or do you still think that a new platform has to be
>>> set up?
>>
>> things have improved, but I'm still in favor to use a new platform.
>> And my main point stays. A "generic" kernel compiled for EyeQ5 will
>> just run on that platform, which doesn't sound generic to me.
>
> I do not oppose the addition of a new platform, even though, like
> Jiaxun, I would prefer to avoid duplicating code. The only thing
> preventing the use of the same kernel for EyeQ5 and other platforms is
> the starting address. Therefore, if it were possible to have a
> relocatable kernel, this issue would disappear.
>
> However, while waiting for your feedback on Jiaxun's part, I will
> attempt to add a new platform to assess exactly what the implications
> are.

Is it possible for you to apply the first patch of this series, which is
only a fix? This would enable me to have a slightly shorter
series. Additionally, it would facilitate dividing the entire series
into two parts: the first part for XKPHYS support and the second part
for EyeQ5 support.

Gregory

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

