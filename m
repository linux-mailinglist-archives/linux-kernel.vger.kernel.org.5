Return-Path: <linux-kernel+bounces-51184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B583848779
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4501F22007
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F1F5F84B;
	Sat,  3 Feb 2024 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rUfkdcRq"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCEA5F549;
	Sat,  3 Feb 2024 16:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706978010; cv=none; b=SsMKktbxOOZhcgHc76v1LsryxySUATpmNafOqDcUB6zo7ZTJ9DNxJ08FRJWUBS/s9YNeqara6hocjJRm5OLXFQ0wz/ZkR9yJcKJ13yD2EPc3vNw9Sl00GOw8QyHYG9Wzh2XO3ut0XgIYWhTaHMJa//IVDf21De5pm/DceJOYX9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706978010; c=relaxed/simple;
	bh=USwZi+tenL+zWd7YTIE6nRVnYZIbj6mmBnK2ukvZmXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJf4CvGpWyrh5wg9ggBBvLzWifQmoCI7iQs/SQAkkdYRXlk2cWg06XzdM02uVkP5krJcGYSm8Xzlgef3N4J53uei26GEquRm9kOQt8bahzFd3HGnAV+96LHLf70h9ftnd2Wm3JSB1pzBzXeJOeU0KZSIPydxSwMXZ52TaTWJ3bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rUfkdcRq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Dku+vMvtmnMGHoYUlJi5yCzjF20d0vv8EAcUcglE/uo=; b=rUfkdcRqK1MFKlWfPmBRiw97rP
	4H2AgjNN7ZfzBoore+qY8aMye9QASpSFoL09O/g0wvXKjiYo8RFT2pSbvXI31w8YZPUJ8PCy28Yqm
	pzkjax/zZ2wnl/NXyee1rOiNEBUnUm3pYSJ43I0f7/utE1XJrHEBAN9UZ6S4zKynEKMo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWIxD-006ugn-Tr; Sat, 03 Feb 2024 17:33:19 +0100
Date: Sat, 3 Feb 2024 17:33:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next] net: micrel: Fix the frequency adjustments
Message-ID: <5f123f39-efbd-44d6-b4cc-db33d175fa21@lunn.ch>
References: <20240201204203.2691424-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201204203.2691424-1-horatiu.vultur@microchip.com>

On Thu, Feb 01, 2024 at 09:42:03PM +0100, Horatiu Vultur wrote:
> By default lan8841's 1588 clock frequency is 125MHz. But when adjusting
> the frequency, it is using the 1PPM format of the lan8814. Which is the
> wrong format as lan8814 has a 1588 clock frequency of 250MHz. So then
> for each 1PPM adjustment would adjust less than expected.
> Therefore fix this by using the correct 1PPM format for lan8841.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

