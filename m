Return-Path: <linux-kernel+bounces-121977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FB388F01B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00CDF1C2C250
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EE0152E0D;
	Wed, 27 Mar 2024 20:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="C0WAxq46"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0993315219F;
	Wed, 27 Mar 2024 20:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711571324; cv=none; b=ZKhn93LtHs3Hy70oRzuYxe4iWgmEOfJK6JdmOC6Bs0hGTd13KupwdbN37fdtTRSQf+wzB8qu3osIPWrEqlEtYj6S5WRT3ejfZ5bxp/sAVvUuhL8ilH4ivNvYJKdvqDrIiGBD58bsO4y0xSGzAk2KwEl3Oj4Bz/lt8RrwizL1Njk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711571324; c=relaxed/simple;
	bh=aonojdmQzvLRtH+U+Hy1KesphHjqIdhuAzMqQM8S8tw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=WJXY3BKXsiLXq6Fcn5PoU69jhT/DYQ0rYRl2xrVhwEBBd5GCqHNWC3Y5F3d6Os1/Ft9SrZopBqR/k7OwwrEhwaBdL1heRhBKNiT/fLlsnpAuMIYxhqv/AALkl3jsfbXp+ZPRQpi7AcUehJBUbo+5OjHhOlquxsuBCs46wto8TQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=C0WAxq46; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711571312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rgWZAPKKvj7qqanrCLdSrwL14cWosCAVk9cs/TL+9RM=;
	b=C0WAxq46JpAfxaOMiH1lQSZjMLfUsJvBZwddwICZ9V3X0zmkEkjZTFkT1srbZelkod2ruy
	1iX6hkuwF3Nw6nlHDhEjN2cu7Xn/b2rKNH7NtzmGqNBz9t1E+Z2I4lKln8831sxu079Qh4
	JssB7tAb8ioAEn/VRq+1o28BmlCldrahd6evNu6Hw311O1RPiXod+9OC/JUSs0QmkZfJ28
	8ScY1OTJrrNVDgHIZhN/HYo435dKepgYT4awwm898z3IBLxHJwRYslFMzEGd95Q+qsPPPA
	Elz3zBIGhcxMUMY7cxY3618LH7eOEwwD9qa935u/rzSbFkYOfHn4P0mSfhsPJA==
Date: Wed, 27 Mar 2024 21:28:31 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 boris.brezillon@collabora.com, linux-kernel@vger.kernel.org,
 kernel@collabora.com, sebastian.reichel@collabora.com
Subject: Re: [PATCH] arm64: dts: rockchip: quartzpro64: Enable the GPU
In-Reply-To: <6007945.alqRGMn8q6@diego>
References: <0f3759ee390f245dac447bbee038445ddfecbec0.1711383286.git.dsimic@manjaro.org>
 <6007945.alqRGMn8q6@diego>
Message-ID: <e6cb0dea9ea79f989d5a502b5ea6366e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Heiko,

On 2024-03-27 11:29, Heiko Stübner wrote:
> Am Montag, 25. März 2024, 17:19:04 CET schrieb Dragan Simic:
>> Following the approach used to enable the Mali GPU on the rk3588-evb1, 
>> [1]
>> do the same for the Pine64 QuartzPro64, which uses nearly identical 
>> hardware
>> design as the RK3588 EVB1.
>> 
>> The slight disadvantage is that the regulator coupling logic requires 
>> the
>> regulators to be always on, which is also noted in the comments.  This 
>> is
>> obviously something to be improved at some point in the future, but 
>> should
>> be fine for now, especially because the QuartzPro64 isn't a 
>> battery-powered
>> board, so low power consumption isn't paramount.
>> 
>> [1] 
>> https://lore.kernel.org/linux-rockchip/20240325153850.189128-5-sebastian.reichel@collabora.com/
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> 
> as lore.kernel.org and therefore b4 seems to be on vacation today, you
> get a very personal "applied" message ;-) .
> 
> So, applied for 6.10 after the core rk3588-gpu-series from Sebastian.

Oh, thank you very much for this special message. :)

