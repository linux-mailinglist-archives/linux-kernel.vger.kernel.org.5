Return-Path: <linux-kernel+bounces-83918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED1B86A01E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9F61C232F5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF84E14D44A;
	Tue, 27 Feb 2024 19:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0ZxkKI2y"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839D114831E;
	Tue, 27 Feb 2024 19:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709061775; cv=none; b=TCPXvEwSWxT0F+dhS6l63pfqw4/mfWDpI2hYg08yCY4OwftstuHZWcZTkr7h6AVPOSS1sqxlm4GnpgT7RXHEMV7b39VBNPUYh1sL5ffzksGc+gPg6LvUNd7/RBcBVJZqDyukYVbRlkcgGBcRlNry+tkW5FuEno8ZZCSqgRiskRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709061775; c=relaxed/simple;
	bh=pqCwl9n0iZDVvOyx9l5q+MZxMdmVELWJgIvun5XHgtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnmneRxxtqURiaCJA0HHDHQhPAnOlnZNxhFiVHeCbzeisGcZjsobH636lW6dxRoBv7EydO23Qqxf3+0brIXVlUFIyVkpeeLOXhZk14Yppva+rTF18HgefQmpWSzkacsCdlST+hHA7ngfTLHs84b4UlNcNCptkyLZCR7Y/SZr798=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0ZxkKI2y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=q0M+3OpEAKpGRzvgH378lrI4p8oL9B1i6eRD2Ub9zm8=; b=0ZxkKI2y4zC0+6eiZjSAQwxdI+
	KZiYm4si4+G37m31+llOftgq+Vf7RJYk2qCsb2qdysVmaBg5z5jnILzEd3ufde9YyqEAEBQXsqBrt
	8ABBTdEEqlqN7/aayVG9mf1vh5ZlN4sJ07wYbhkgXudEjkw7yUlgrjcbZwL/96NkRCPQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rf32b-008spb-Lw; Tue, 27 Feb 2024 20:23:01 +0100
Date: Tue, 27 Feb 2024 20:23:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Robert Marko <robimarko@gmail.com>
Cc: f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: dsa: mv88e6xxx: rename
 mv88e6xxx_g2_scratch_gpio_set_smi
Message-ID: <a9c03fc9-7805-4d16-b3c5-8dd3064f7378@lunn.ch>
References: <20240227175457.2766628-1-robimarko@gmail.com>
 <20240227175457.2766628-2-robimarko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227175457.2766628-2-robimarko@gmail.com>

On Tue, Feb 27, 2024 at 06:54:21PM +0100, Robert Marko wrote:
> The name mv88e6xxx_g2_scratch_gpio_set_smi is a bit ambiguous as it appears
> to only be applicable to the 6390 family, so lets rename it to
> mv88e6390_g2_scratch_gpio_set_smi to make it more obvious.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

