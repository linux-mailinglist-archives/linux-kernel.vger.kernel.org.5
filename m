Return-Path: <linux-kernel+bounces-45584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8219F8432B5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E52287A18
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50FC1C10;
	Wed, 31 Jan 2024 01:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cAnxPAOd"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC161366;
	Wed, 31 Jan 2024 01:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706664402; cv=none; b=AKusg0fRPyv6xdz2rzhDlAoAhLDrUHMcI9d4OUKxboQrhq92bwtW/fu60tHpFiO+oQBLqkvQfKe0mYECG8xyQ/GnmGmt2OsN0h8D8q8KdfJlJmjzmb4T8VnZ8QwnLj65l0W5qDN5jk1iXmbLW/aTARHGg1znbbKXRfukBKwjCE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706664402; c=relaxed/simple;
	bh=y/w2o0K99J5lhMm3nbPifN6jz4SsD7/L8rq9AFM/jXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sylkvNmmhbTnFZEuuonycNIG19tAa6SDlAoZNO+0A/ycGvhZ6ikDruKXPX0xnJRtl+zSvKiX+rJT7uJXQN79sPHJHQqtzYIm1VMba8pcKTboF2n1+Szo7b66XFhf3esXXAIAzARijT7fcnEC9A5IehlBoy1Ag0gRrTxfB7ivl1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cAnxPAOd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=64H+AS77GSweExe9sdGygbTFKGZ9x1KjAbkYtG8yLv0=; b=cAnxPAOdsYELZmcpp19XvdrmD2
	8w8xq5uq1IVwgd4wEATNllDFMYlMsFedZF8z/MqLg6lYdsFy3CRyS3wSEolqn9ijNbqMMRHFNyXXu
	qZsMYVffFIewzuxe2RusJfbt6vVR9v4dpEckBsPVmKYknpPzhvEzjX6rj6NsSLkB7PuE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rUzMl-006XdP-6w; Wed, 31 Jan 2024 02:26:15 +0100
Date: Wed, 31 Jan 2024 02:26:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux@armlinux.org.uk, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	git@amd.com
Subject: Re: [PATCH net-next 2/3] dt-bindings: net: cdns,macb: Add
 wol-arp-packet property
Message-ID: <824aad4d-6b05-4641-b75d-ceaa08b0a4e8@lunn.ch>
References: <20240130104845.3995341-1-vineeth.karumanchi@amd.com>
 <20240130104845.3995341-3-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130104845.3995341-3-vineeth.karumanchi@amd.com>

On Tue, Jan 30, 2024 at 04:18:44PM +0530, Vineeth Karumanchi wrote:
> "wol-arp-packet" property enables WOL with ARP packet.
> It is an extension to "magic-packet for WOL.

It not clear why this is needed. Is this not a standard feature of the
IP? Is there no hardware bit indicating the capability?

    Andrew

