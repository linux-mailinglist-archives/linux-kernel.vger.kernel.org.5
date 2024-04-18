Return-Path: <linux-kernel+bounces-150416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99CF8A9EE2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070AD1C220B6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B9016EBEA;
	Thu, 18 Apr 2024 15:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="KZ46A4kC"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382E84D9E8;
	Thu, 18 Apr 2024 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455195; cv=none; b=KEMFTuyCnmbYSk2H/dbi1bRT01+YlOcfDHfhKpxszP4/Ua/AQcErkfDo6yVckgbdWwfovfDgiHndiz4bXaNu9qEhoMkFRwy6eiD74fCuAEL+k8vFPaDyOQ3xODiZ0TsacIo6bSlZDsG+WFI9GEmw2kdJGWMgaleZ9zec+WbjJuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455195; c=relaxed/simple;
	bh=NgY60Jm642tJfiFrdyzn4Mu50PHSmRd7nqrYLF5xtHQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=T4DNUqtIXtWLcdGXJRNZ8qhpDGgt9ol2NDt22jgtxqDAb5wRvOZdsOr3O4Tm3R7hoQtrOgjJ4W1//km2aFfhWmCXYb2NgaLktRNkumuXD2ZiWbTS00AEwmfiZWENynXAhNRuhjnLwiKCG8jghCaSMgciDcffJOdbp8ZqPTA6yE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=KZ46A4kC; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713455190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HM7rYIk76bCGMzcR/q0QxvkvY1vzyCqN0RtGYsrgTuI=;
	b=KZ46A4kCUWKwYCT75IN2Rnng31/8njvn4+Idy4CiAthEl4S+nyvttUR1zIF2uHOYskzfaa
	5aJNhDAvG4qS+1t5fSO+dNctp2W7sYCWPSpJWRMHD6z3OG52vBBP4nVHOAPn29+IX60AM0
	Ys9DxZ58ucHiWGmQMz/MNPQWOmtBnF0EZDrYEZuqHQL6dgD3F/o28LhTbRPRmI0/7d9KKy
	fDp0pbiAaKzkC3hVS1m5GGRR0QWkR+aC2GSwRqzfSxOfSYZ7WCjJJiDJAXBA1Jxuk6B7Ge
	X08/YFhKgkOex5duU3qGJKLSuvxwit9l+WDJ6inUkp5u0L1TELeTqfFBAMdAIA==
Date: Thu, 18 Apr 2024 17:46:30 +0200
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
In-Reply-To: <20240418-drove-boasting-d189ee3e22e0@spud>
References: <20240418130120.67663-1-amadeus@jmu.edu.cn>
 <d00953aab0f1c978e3720885a6844caa@manjaro.org>
 <20240418-drove-boasting-d189ee3e22e0@spud>
Message-ID: <7fec3e2f4e16b1aca6cd08e1882bd885@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Conor,

On 2024-04-18 17:37, Conor Dooley wrote:
> On Thu, Apr 18, 2024 at 05:21:18PM +0200, Dragan Simic wrote:
>> On 2024-04-18 15:01, Chukun Pan wrote:
>> > According to https://radxa.com/products/rock3/3a,
>> > the name of this board should be "Radxa ROCK 3A".
>> > Also update compatible to match the model name.
>> >
>> > Suggested-by: FUKAUMI Naoki <naoki@radxa.com>
>> > Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
>> 
>> Looking good to me.  I'll send the remaining naming cleanup patches
>> a bit later.
> 
> What remaining patches?

The same naming cleanups need to be performed for the Radxa
ROCK 5 boards. [1]  I had some more cleanups for the ROCK 4
boards in mind, but I'll drop them after your NAK. [2]

Though, I'm not really sure why the NAK?  Those names aren't
used anywhere, neither in the Linux kernel, nor in U-Boot.

[1] 
https://lore.kernel.org/linux-rockchip/B26C732A4DCEA9B3+282b8775-601b-4d4a-a513-4924b7940076@radxa.com/
[2] 
https://lore.kernel.org/linux-rockchip/20240418-liberty-pry-d270065a544f@spud/

