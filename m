Return-Path: <linux-kernel+bounces-39234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFB983CD35
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74D2A1F26C6D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86DE137C23;
	Thu, 25 Jan 2024 20:12:56 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49732134730;
	Thu, 25 Jan 2024 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706213576; cv=none; b=Mc+lb4eZo2RVJJuqDdmB2g7Jug9A4m+oX/56lipUdT387SbAmbAExBtARd/kYj+kregjc4eoasFF2ppZyfI0DDA/kT6tASCgh6NZ4ZDxxWEtJ/pU+HFqd/Gf+lvPd/J4fDaY/RFnnrQ7LoQoEamV6GLeuzkDJ1e31/IWak2exw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706213576; c=relaxed/simple;
	bh=SPInEJ3VDLMNhJYNeCiPbmOKLBD/E9BpkK6CTvaMt9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UskZS++RZLQlyiDcu7qoNE4bFcmhNhkOn5jAk18i4zMpaA6SGpRY3K2DvzR/MWgngzmmhZSPldsXkOQ8cQoTCzCnu1FaiOCl1L2BFnCltsBSqmVNGfAxndnB22ojoKgrDkIkA+PYeiH1uxA7j5lviUgY9j88fNAaYQyeK1KpTuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [194.95.143.137] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rT65f-0001TY-4Y; Thu, 25 Jan 2024 21:12:47 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Jonas Karlman <jonas@kwiboo.se>, Trevor Woerner <twoerner@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject:
 Re: [PATCH 2/2] arm64: dts: rockchip: rock-pi-e: fix location of snps
 properties
Date: Thu, 25 Jan 2024 21:12:46 +0100
Message-ID: <1976352.usQuhbGJ8B@phil>
In-Reply-To: <20240118230312.GB14779@localhost>
References:
 <20240116204103.29318-1-twoerner@gmail.com>
 <df78489b-7546-46ea-b09f-39a80692a962@kwiboo.se>
 <20240118230312.GB14779@localhost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Am Freitag, 19. Januar 2024, 00:03:12 CET schrieb Trevor Woerner:
> On Thu 2024-01-18 @ 08:31:30 AM, Jonas Karlman wrote:
> > On 2024-01-17 09:15, Jonas Karlman wrote:
> > I have just sent out a U-Boot series that fix ethernet on the v1.21
> > revision of the ROCK Pi E board, see [2].
> 
> Thank you! I have tested your patches both in U-Boot and Linux and they work
> perfectly.

if I'm reading this correctly, this patch is not needed anymore, right?

I'm not yet sure about the first patch, as it really is
just a cosmetic ;-)


Heiko



