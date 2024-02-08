Return-Path: <linux-kernel+bounces-58268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D9184E3BD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33951B20ED7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49547B3CC;
	Thu,  8 Feb 2024 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TnM4qErz"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F147B3C5;
	Thu,  8 Feb 2024 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707404940; cv=none; b=vEU702/0OTT+VupshZl5GhkXh1opGf9yAqMCIDlHlFwiTxQZdoQ2o+gyjYHwipOe4XAxEORRNfORFYU6hWUt9EcKAczkTAmCks/qeIy2SxCeB5zx77mr9rnw8+gnIJbbnPznr6n2X9xYeOspB1qZoLtqlq6pr12812YZEzTFGeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707404940; c=relaxed/simple;
	bh=Ld8EAKSRvInh9ktUNVrRf6alZJ90rYxSW3KdkeAKH5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUFSYsfWjpBwl9VaVXJUMxlDtUcTAS51wIqOk+nUd+lSH9KFc+3I6YJ4rMbIVeRSor0HVkYZd7c9s4hJXIoBW3dBBye31g0gXnU9gDgsfzNp4f4n1EXLS5roA1b6B/Ih3NXBRrzUgyJuAUY4tVm53/faMcyjRMa7ISnIR6wKVOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TnM4qErz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NBIvefX2Ir9pu1UKoSP4NrxpiXFTIiuQt7Y5jzuUYI0=; b=TnM4qErzv0po/dpn6saHCUA4Zn
	m9QqyBfRcOBbwoTTd3fFNpCQVD3g22zfMRNNOKlP8Z2Ius6WimUVP9j6128Z1H2AkcqiVihmEL4Mi
	eMtf8UE0FdSlf4kxCuEbSFnsrii/yMtHMuIzzv3wbjBb5JpFt1yhpAvrADBmuaKH2Ibc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rY61D-007JpE-MA; Thu, 08 Feb 2024 16:08:51 +0100
Date: Thu, 8 Feb 2024 16:08:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alex Leibovich <alexl@marvell.com>,
	Stefan Chulski <stefanc@marvell.com>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH v2] arm64: dts: armada-ap807: update thermal compatible
Message-ID: <249b89ef-f520-4828-a575-471d805f8434@lunn.ch>
References: <20240208081413.7923-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208081413.7923-1-eichest@gmail.com>

On Thu, Feb 08, 2024 at 09:14:13AM +0100, Stefan Eichenberger wrote:
> From: Alex Leibovich <alexl@marvell.com>
> 
> Use the correct thermal coefficients for the Armada AP807 dies.
> 
> Signed-off-by: Alex Leibovich <alexl@marvell.com>
> Reviewed-by: Stefan Chulski <stefanc@marvell.com>
> Tested-by: Stefan Chulski <stefanc@marvell.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Stefan Eichenberger <eichest@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

