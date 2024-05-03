Return-Path: <linux-kernel+bounces-167655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D658BACD6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A01B41C21994
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6A5153580;
	Fri,  3 May 2024 12:53:16 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5753A14267;
	Fri,  3 May 2024 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714740795; cv=none; b=BMkQOUayaN0FU8nqhbkKSspSpg9RNJXs2KvKpywyGqpnz3rsXhXBEhzskBOQMExamiS105lOhXPji1osOV49LPfvHcr1U+lp6c2zMRoKekZrbnEGcN7UeR7WHWWuHLXG1eMDS9K+1zgeH0ygzKwV6vaVWr9MdmV/hXMRGGr0JAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714740795; c=relaxed/simple;
	bh=83h6SpBSPjYfy0/mQXm1ihvyDTeo+XyvUt4VfNZyGT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qhoO431E5+aA3wNe6nBX9W2lM3Qrirni9ZOgY9z0Wl4h2c/S//J+gfG8j5EFGcpNlJJ2c6je1uMgZRUBELKe9Ae/Z1Z0wUuZ/gp4XOYF63L0cDD3rf/FrAUq2YHxb1qNwVGJ3JfEeFZmI4B+FduHQ3Pf1zB47jKJ+fX2ql5eXNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b01.versanet.de ([83.135.91.1] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1s2sPR-0000tz-Kq; Fri, 03 May 2024 14:53:05 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: linux-rockchip@lists.infradead.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 0/2] arm64: dts: rockchip: Add Radxa ROCK 3C
Date: Fri, 03 May 2024 14:53:04 +0200
Message-ID: <15481689.tv2OnDr8pf@diego>
In-Reply-To: <171473602992.3469033.3176474743011728197.b4-ty@sntech.de>
References:
 <20240428123618.72170-1-amadeus@jmu.edu.cn>
 <171473602992.3469033.3176474743011728197.b4-ty@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 3. Mai 2024, 13:38:19 CEST schrieb Heiko Stuebner:
> On Sun, 28 Apr 2024 20:36:16 +0800, Chukun Pan wrote:
> > Changes in v2:
> >   Collected Acked-by.
> >   Drop cd-gpios for sdhci.
> >   Add mmc-hs200-1_8v to eMMC.
> >   Correct the spi max frequency.
> >   Update model name and compatible.
> >   Update regulator according to the schematic.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/2] dt-bindings: arm: rockchip: add Radxa ROCK 3C
>       commit: c0c153e341d2a82241bf0a0b78117ceeb29be3eb
> [2/2] arm64: dts: rockchip: Add Radxa ROCK 3C
>       commit: ee219017ddb50be14c60d3cbe3e51ac0b2008d40

Forgot to add, I've dropped the rk809-sound node, as well as the sound-related
properties from the rk809 pmic that got flagged by the binding check
and which I could reproduce here too.

So please submit these as follow up patches, once the necessary changes
to the pmic to allow its codec use are merged.


Thanks
Heiko



