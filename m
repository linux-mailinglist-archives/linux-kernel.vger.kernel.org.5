Return-Path: <linux-kernel+bounces-46693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9E48442BF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38221F22526
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B470484A51;
	Wed, 31 Jan 2024 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="siJRZxDZ"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6653E84A25;
	Wed, 31 Jan 2024 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706713977; cv=none; b=h97MEoj6t6nRhBHZZRuCS+GEFvSPEq9VO4MiaZg4vus0ro/H7dGMhvpRn8FZlx6j4UWLcvAR7pnEgU0+6/2Bx/mBdvXYFgbcG8s86qBCez+xhRoYRZhGdOpoXOSeFC8VQdmormw58FGt/3dodrTezNIdc+jDU9AnQAfbN5SQ/LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706713977; c=relaxed/simple;
	bh=RuB3d2iK2n59++rlUBCD8y1Rnrd57ZLrZNNozh23/XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEpGJ+47LSBAlQb8S8c2KkqSkAyyy0pXxiLslDoGD5DT8HJ18pZFiMUNCtIgpbjaYsNIcr1EjZNc962/+2X4bvn3XhSpJ1pwRdheUf2Q15NOI0788toLQuYoWUdny3Dehfno+pcceddBaTvzh86gJ6ZJDtVlXuLIWJmcQlugbKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=siJRZxDZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gEjtk7FmgCd+zH7N27wDyMUO04kBPrVBqkN0zpmbIcQ=; b=siJRZxDZwDrF8y8x6NRhDz58NQ
	D8vNHQojfXv0kSmuUdC3FWLO6tIAQc4/ptyf1ZCznP+eaJNpzZFZbdHZo3ILBMPStS7YsVMJi++mi
	sFlECh27NNeZf/DuinQHPssBep0AyUoBfRl53F7g3p39EH8H6DQNQiu4vIT67NGir7Qk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVCGe-006amp-Dq; Wed, 31 Jan 2024 16:12:48 +0100
Date: Wed, 31 Jan 2024 16:12:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 net-next 07/13] net: phy: marvell-88q2xxx: add suspend
 / resume ops
Message-ID: <7d286437-d8d4-446c-9efe-37c124737596@lunn.ch>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
 <20240122212848.3645785-8-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122212848.3645785-8-dima.fedrau@gmail.com>

On Mon, Jan 22, 2024 at 10:28:40PM +0100, Dimitri Fedrau wrote:
> Add suspend/resume ops for Marvell 88Q2xxx devices.
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

