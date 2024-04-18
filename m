Return-Path: <linux-kernel+bounces-150439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C1F8A9F59
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75EA01C2100A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376EB16F84D;
	Thu, 18 Apr 2024 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="gVWBrhR9"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04D81607B1;
	Thu, 18 Apr 2024 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455939; cv=none; b=Fr4xD68wu+4rW6FhRpRwxkwmMjiDIAFhtgm+6V0hZoL/hqKMfeUmejDRE4kBL3dvzCagwjIUjSWAMtb//qes4G+/Yxki02RSopvuKUs83QZlOgnHz30S6Irs0Vt0mOrkCGjwgUo9i++SLwU4X8Slxkolme804rayLDMdEnzXy84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455939; c=relaxed/simple;
	bh=+uB7/UsaUGKlCCqX7X+DXQT1L/e3kM05JcWb60PdCMg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=lLKyWAl0KN+PxOiNU3SKiTSbC5CouJEnYZ/EPqEwgT0gONFZNr3jtRaRxfNx3S5O56ASiBBPiGnkdS5hY31D8/sJwkCHoK3a3ZhbEtIq7gGBUCmOleTp7jvApv7TD4nTgmLo+x+SrJzsblW8MCO4B20yCLiL19PyaKC5aV+X+ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=gVWBrhR9; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713455935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kiW4f7FdjCXio2Csij/Fy9C8DuPPxHwY5d9PSj9jra0=;
	b=gVWBrhR9O0t7sklMHJuPowAW1JBqpbiO8lYTO9h8bpzXNPbNpEZdPVIS0hj2+p5LfHdJOG
	I/PfMNf3g7pxY8TQwqMpGH90aMbSRxhvdkQzFn3G5WlSf0S91lQ1KtzXThs2wTkAo1enCv
	XvXUkinDb5WOjpTzU0S/EMCIXP8juYJ1+wwRyPSoEyGI0Ua7CauQ4tk8KIXbcrUucwqs6d
	HBzhMKQBZ9JslLFCX+S+Iair2HZbq73twNykIJ1RNkF4vsMHXI6Jz7AFwFwmr5wFoKUmwr
	/bDSyBEIk3eXXFsFPZDZ/z4rz9HhoMwbMsEEPFH2ovHUO0yBIVt7X6zQxRgX/Q==
Date: Thu, 18 Apr 2024 17:58:54 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Conor Dooley <conor@kernel.org>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, Heiko Stuebner <heiko@sntech.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, FUKAUMI Naoki
 <naoki@radxa.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: correct the model name
 for Radxa ROCK 3A
In-Reply-To: <20240418-skinless-aptitude-245665a7c757@spud>
References: <20240418130120.67663-1-amadeus@jmu.edu.cn>
 <d00953aab0f1c978e3720885a6844caa@manjaro.org>
 <20240418-drove-boasting-d189ee3e22e0@spud>
 <7fec3e2f4e16b1aca6cd08e1882bd885@manjaro.org>
 <20240418-skinless-aptitude-245665a7c757@spud>
Message-ID: <865d70eea51c18570d94a4fc86dcb5b5@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-18 17:57, Conor Dooley wrote:
> On Thu, Apr 18, 2024 at 05:46:30PM +0200, Dragan Simic wrote:
>> On 2024-04-18 17:37, Conor Dooley wrote:
>> > On Thu, Apr 18, 2024 at 05:21:18PM +0200, Dragan Simic wrote:
>> > > On 2024-04-18 15:01, Chukun Pan wrote:
>> > > > According to https://radxa.com/products/rock3/3a,
>> > > > the name of this board should be "Radxa ROCK 3A".
>> > > > Also update compatible to match the model name.
>> > > >
>> > > > Suggested-by: FUKAUMI Naoki <naoki@radxa.com>
>> > > > Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
>> > >
>> > > Looking good to me.  I'll send the remaining naming cleanup patches
>> > > a bit later.
>> >
>> > What remaining patches?
>> 
>> The same naming cleanups need to be performed for the Radxa
>> ROCK 5 boards. [1]  I had some more cleanups for the ROCK 4
>> boards in mind, but I'll drop them after your NAK. [2]
>> 
>> Though, I'm not really sure why the NAK?  Those names aren't
>> used anywhere, neither in the Linux kernel, nor in U-Boot.
> 
> There may well be other users outside of those two projects that are
> actually looking at it - I don't think that adding a hyphen is worth
> disrupting anyone for, it seems perfectly clear without it what board
> this is.

I see, it's perhaps better to stay on the safe side.

