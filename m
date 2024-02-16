Return-Path: <linux-kernel+bounces-68647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31406857DCD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4D64B24913
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9564112A17D;
	Fri, 16 Feb 2024 13:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OCUzo80m"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE6A129A9E;
	Fri, 16 Feb 2024 13:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708090670; cv=none; b=NI7BNIm1ahinUwTBGjVU2zDYXDeRV9jRGqXy6zR49A9sSkPlQIx3ZTjijNQiMiS0bGQz4lAi+GQkdtaFID+P0TO90XdyRN7J8+cgoSESXqMCWYlCx4f3B8X6XDBj59u2+ihqCSNp1u0Kdrg7TtL45yVEd/N9qf+hlyG5zaIXsow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708090670; c=relaxed/simple;
	bh=vH7xEsX0NNBIo/I8ClUIXfcTOAC82KH/cEP4b7c/PYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KL7dmraDipWuepqJL1z8xTlkFtwFtvjQUrJ4j8/kInDv58r/QdyGKZqwA9oyqAL72ChoZI/y4v9s1FfoaZ2Lkf+LOSdF91QBt0B5qPwODxt5pIgrIoyUJJ+2iwqX7n11XnfrI0ExQ4l7ylchHRalXsiU+dt4mFMZSF5JTOCT1Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OCUzo80m; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TulgIWvHACD1n5UVwi82AEpDnZqWUKgf3CRoyNp0MI8=; b=OCUzo80mqB9EmTzjoPWv/GZ5vD
	cN4VA71+BYcil09JRVb8Y8VWw2ImTSTk0SoFt5sIdK0Gkkt2xDESGEUF6k0MlcsXMqVAGwOMSv35V
	8nLc078YELPL7fl3uoSVLm7ij2qNx0l7+/SqIFGezS/IHZZ83UC+q3TfjIrJAUZy8Ky0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rayPO-007z27-PG; Fri, 16 Feb 2024 14:37:42 +0100
Date: Fri, 16 Feb 2024 14:37:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: forbidden405@outlook.com
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yang Xiwen <forbidden405@foxmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/6] net: hisi-femac: add support for Hi3798MV200,
 remove unmaintained compatibles
Message-ID: <254d3c4d-bc74-4a26-9c23-17b4399c3755@lunn.ch>
References: <20240216-net-v2-0-89bd4b7065c2@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216-net-v2-0-89bd4b7065c2@outlook.com>

On Fri, Feb 16, 2024 at 06:01:59PM +0800, Yang Xiwen via B4 Relay wrote:
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
> Changes in v2:
> - replace email.
> - hisi-femac: s/BUS/MACIF (Andrew Lunn)
> - hisi-femac: add "hisilicon,hisi-femac" compatible since the driver
>   seems generic enough for various SoCs
> - hisi-femac-mdio: convert binding to YAML (Krzysztof Kozlowski)
> - rewrite commit logs (Krzysztof Kozlowski)
> - Link to v1: https://lore.kernel.org/r/20240216-net-v1-0-e0ad972cda99@outlook.com

Generally, you wait for discussion to finish before posting a new
version. Also, netdev requests you wait a minimum of 24 hours between
versions.

Having discussion happening on two different versions of a patchset
at once just causes confusion.

    Andrew

---
pw-bot: cr

