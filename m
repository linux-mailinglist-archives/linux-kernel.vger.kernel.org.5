Return-Path: <linux-kernel+bounces-65462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C75C854D63
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED5B628E35C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE475FDAA;
	Wed, 14 Feb 2024 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="D05EMrWb"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCA75D49C;
	Wed, 14 Feb 2024 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925941; cv=none; b=Jp8pdAy2bUEaztSDgvMxbuxRK2d8ua4ZLjjuCs96WVhH5AnbyBhrQWQfTuOI1bz9pr+XS8pj0eH3uanJI1WfMBFFfQn8V7t5BmkPFpS+EjfDIFt+pBKGQ7rDQgBOJbLFP3SlBnnuIeBaiUDYPorxyL4C4TDfw5cUqiUNRvNiNfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925941; c=relaxed/simple;
	bh=oIt2R5ozzovt5W95A5qZS3pK8eRloeE7VOKKKmgQgkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kb3ojvgQUWZe+0lh0EJNFdd+YxL+9eP9swdEvgMX9NpQoAnNMppursQDheTZTlP94ZbcfVIDOhZUN+OX8BNg6SwvhhPFsLzHcJKV20gkc8SJ1EmFqKVj0xDVwOsHJoEZ7qTyJ6J7pMURRWGkm+MHUtmvlhujNYg4mSrCQVGircI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=D05EMrWb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Wdft4jqBOOjcXjgBJyUm+xdDlgM5W5ZXDKdM0nLksJ4=; b=D05EMrWb6UWIyRZstTpv3osTeD
	3RX+mGbqYZiLnm/RlOcEAt023JobhtgunjdgSprZB3G5ReKbscQpw/gQCFmW8kcGOennTdBgUJW3k
	Uehj9hL4y3eKUfV+2oQN589bgV0jPeTlcLCfMWnXspoPtxlgA8WbKNj4m/uqVsFqHg1o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raHYT-007niX-TG; Wed, 14 Feb 2024 16:52:13 +0100
Date: Wed, 14 Feb 2024 16:52:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, horms@kernel.org
Subject: Re: [PATCH net v2 6/7] net: fill in MODULE_DESCRIPTION()s for
 mdio_devres
Message-ID: <ace91887-8c82-4df9-a62c-99d30e1b28e4@lunn.ch>
References: <20240214152741.670178-1-leitao@debian.org>
 <20240214152741.670178-7-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214152741.670178-7-leitao@debian.org>

On Wed, Feb 14, 2024 at 07:27:40AM -0800, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the PHY MDIO helpers.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

