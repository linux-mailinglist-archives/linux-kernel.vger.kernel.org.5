Return-Path: <linux-kernel+bounces-39547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E789783D29E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AE22B26BEF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D868F6D;
	Fri, 26 Jan 2024 02:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OrN8QdyZ"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EA267C66;
	Fri, 26 Jan 2024 02:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706236694; cv=none; b=g97IhEiLfqZJCun+THJw0eESgAvrme9olMMOXug5beYiGf1Q3drypj+0Yg+GmLY1YuV83B2fuKKECEoyx8+2+UxGNi9X2EXWX46Djyn7SEGtWx50QcwO7PdsUFIyad8cVKCZAP9l64uMg3mWC3hNJJbXAlphox6cbeaJhze4J2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706236694; c=relaxed/simple;
	bh=nWa2dEMXl6ypPEqUGRQ2M3mnbCfR2mDPSDM2usegB3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrWqEBnXrv9TNLuCnFE7KRvm/Fm3L1W7Sesr7xW1aDUKoFs2GjuYV9KlbtqGVPxwPTB5+SA3cUP8iAuJz4mZCjCsWx67yFvEgmYayHJ6NVyHKtIVHzAupJV444lOUBz18601x792hKKCsQFzMdsG0bizeIuKL0Gs1m/nfsubYYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OrN8QdyZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Qd3nlym//LAlFHkady1BwwInKwCk8mDwSQ8io13WFIE=; b=OrN8QdyZszp6d1b56uObl4eelP
	V9TYkudRghzXlSB2hJe1teeqmEyEONz51wj6fvf+Roy490GD/qwhhTWop1afWX4ulECwMyG2bB04I
	7m8BaOdmGj9k2kRaFQskcfSI11CXRguxZUdUVbOz3U3WrwHjaCDB/df5JPXObcutKvVM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rTC6a-0068q8-4r; Fri, 26 Jan 2024 03:38:08 +0100
Date: Fri, 26 Jan 2024 03:38:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	sbhatta@marvell.com, gakula@marvell.com, sgoutham@marvell.com
Subject: Re: [net-next PATCH] octeontx2-pf: Add support to read eeprom
 information
Message-ID: <1c39b3eb-0616-4214-bcfa-aaba1bd4e4a4@lunn.ch>
References: <20240125112133.8483-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125112133.8483-1-hkelam@marvell.com>

On Thu, Jan 25, 2024 at 04:51:33PM +0530, Hariprasad Kelam wrote:
> Add support to read/decode EEPROM module information using ethtool.

It looks like you have a very primitive firmware here, which can only
return the first page of the SFPs EEPROM. What are your plans to make
this fully featured? Ideally you should not be using this API, but the
newer API which indicates what page you would like to read.

> Signed-off-by: Christina Jacob <cjacob@marvell.com>
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>

These seem to be in the wrong order.

      Andrew

