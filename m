Return-Path: <linux-kernel+bounces-131936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1A7898DB9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE67D1C2884B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2BE13048C;
	Thu,  4 Apr 2024 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ANFstrtt"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0AACA62;
	Thu,  4 Apr 2024 18:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712254101; cv=none; b=uoE+/yYR0TeC0Y6oYWKVjdNvT5OWYWwPL/kewIP5qFjFp6w7wdv/EwOfIulQsKoFoJWenqIOd3n2WAP9AEekTIsPzr/y+U6Eht8Vcbkdyabj3uVnTtoNb/RzPkGrKTAlYpo0AB/wbi06Ih4TehcRu57MQZ0rDgjs6Myu6md+H3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712254101; c=relaxed/simple;
	bh=XXhkLvlipZC9vuZG9nlfl4S432fYIS4buCNhFBxeYSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiUEOquHZ6ELkoMbKeSNiEKeLjmcJqieR/yv4XWvs3UCa5aR3jY/r+/IvIdKR5Fm7wjmxdZb7gRGH337JoNQKFD1vFYpSGr7t/KEghNGHXCSFjrzpkudnN1v42L6JsR6L5HgjQumOp3jwoy3YvJySgXS7Km4urcIpwnSCoqjCRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ANFstrtt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1ruQKKaJmmhjNAExsmwbE1tn+abJTydnJmlH4K18vq8=; b=ANFstrttTBiZ4fnJjUYO4Cfx0y
	GO6GJqEEGZMcXyaGUu2RTgR7k17iewWFoNfIl+RsHx7yfKQEr53wOBfXKGG7lpoRB9gwE7ECNFmDc
	+mnjWxP5Tjw6ZQlueQyXnwMP15w13CXcDcg/4mienTZJBVFwLXPBCdcQB5aN2ZdUWGpA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rsRVY-00CCrF-9Q; Thu, 04 Apr 2024 20:08:16 +0200
Date: Thu, 4 Apr 2024 20:08:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] net: mdio-gpio: Use
 device_is_compatible()
Message-ID: <9204dcf2-0332-4cc0-a76d-f22d8d60e0be@lunn.ch>
References: <20240404175557.2470008-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404175557.2470008-1-andriy.shevchenko@linux.intel.com>

On Thu, Apr 04, 2024 at 08:55:57PM +0300, Andy Shevchenko wrote:
> Replace open coded variant of device_is_compatible().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

