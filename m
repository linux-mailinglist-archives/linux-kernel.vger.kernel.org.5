Return-Path: <linux-kernel+bounces-162239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BBA8B5864
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC811F21496
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F0A83A0B;
	Mon, 29 Apr 2024 12:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qLUQsOww"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A906A348;
	Mon, 29 Apr 2024 12:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714393190; cv=none; b=cnFBj/9+l/Jkz46bMijV7TWSXLNGN1L2cyZUo9HZ3MidcJI8dW4H+71AXCyiZp+LolmsNeOjxzOSVRV6D9o87MfBOUckOt6fpNIyILUH+Uh5moJnNKKrKSub9PPYyOwAUV5yxVrAc5oWEcql+LKA0C5wb6GG8jdyogUH4HS+EGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714393190; c=relaxed/simple;
	bh=Fl9BhUxNImaCXdVN/1n68+3txGl5bOMxWJDJ36ZX+3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jjhw8Bk8RcPoUiq4zCrRFb2yaZspbaWGZngDcYiqqndUUcSOScmmKr2Jyq/TVy6POKlbVzWt8jeuRSjcIVyQAP/yHpU6ypcvrgVZDlMMFHT+Z7PQTMsdzRi5GX2LmiYTHkSwgpJFH18beehwottDMD6TFt0gYKuFO9Xzof7VHIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qLUQsOww; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=55Zi9dSPjmV6EHr7HXJBBK0GAS5n6uFRNxp94MfZdBU=; b=qLUQsOwwolipCNVXpGEyEnoXAw
	PQUEuVzOIPv1Xra3ZcnQ8/4vEmqxgy17IPjhTjhQlOJTL2tEL7Fhbg/mCN86z+XXuvKN9k3VJznlQ
	u867a5LQb+Ba7RbPrkr+dhEgP2nj8UsgbIz8Syvjx4H/92JStHWIIaNVUZUf+kKZJbg8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s1Pyo-00EFN7-Sg; Mon, 29 Apr 2024 14:19:34 +0200
Date: Mon, 29 Apr 2024 14:19:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
Cc: Parthiban.Veerasooran@microchip.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, saeedm@nvidia.com, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	corbet@lwn.net, linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, Horatiu.Vultur@microchip.com,
	ruanjinjie@huawei.com, Steen.Hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 13/12] net: lan865x: optional hardware reset
Message-ID: <eaa4eb3e-d82a-4b52-a375-1fc84be7225a@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <Zi68sDje4wfgftyZ@builder>
 <dd9da345-e056-4f34-8e39-6901bf9c1636@microchip.com>
 <Zi94jdVg8a5MaB3E@builder>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zi94jdVg8a5MaB3E@builder>

> Additionally I figured out why my setup did not work without the HW
> reset, I had missed a pull resistor in the schematic that held the IC in
> reset.

Having a reset controlled by software is a pretty common
design. Something needs to ensure the device is out of reset. It could
be the bootloader, but i don't particularly like that, hiding away
critical things where they are hard to see. So i think having it in
the Linux driver is better.

There is an open question of does the driver need to actually reset
the device, or is it sufficient to ensure it is out of reset? The
wording of the standard suggests a hardware reset cycle is probably
not required, but why did Microchip provide a reset pin?

	Andrew

