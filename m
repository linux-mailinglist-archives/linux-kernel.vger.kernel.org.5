Return-Path: <linux-kernel+bounces-75576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A73E85EB71
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68302B25DA7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9632C127B70;
	Wed, 21 Feb 2024 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sZM9OvrJ"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A0786AF4;
	Wed, 21 Feb 2024 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708552559; cv=none; b=uSssqPqjinRql5qYzP/YzZC8SA/9+7v12pAotCVK2BzZqIY3IObmEpOfF4we9sWew4QHNXd5pRgeb+0opiD/DQzWPMkPMaefq1RuYPiyF0UiFFTMpc4//clWzHLnEvyarInymgVwzuu08h6AlF9Htq7VcTtPmF8Y/gVlJy/rX+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708552559; c=relaxed/simple;
	bh=nTuc8LKTvKZXgaBo7OkNjdEx8ZgVIB8lvaDsj+8oJD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcfIOKyOOg2NpfUnecrYbQa/QNYeVT2C4scjyBMQcx8tXhhG69e2f2PmNcRLmZN9FrCaqBld1HBp3PQHab9vQ5Hi6vtvvG6RrqdSlXR5RMsNWqBqbw3WXbbRSuBZwD1nUJMt6wSX6bG9tQCuN4sgpctYGzKLggRV7U863KCsVlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sZM9OvrJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AXSy1sSCudHSwTEsn2KeZXdnhJZE8cqzG9gRyWLU2So=; b=sZM9OvrJSdjCAxoqaP9CdiOxJZ
	qqTlAAsic6d43gCucAaDjaJzjFWSAc+4m0GfOGfB5crWz32LcV41tDABNbZwingayB1sFTKKTW2cx
	npA3FEbLuZjUIfRc0nohlNmlU0KwLFmphVlKXMQoJ++t/Plq1nEWNSC4asMOclBUmRsk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rcuZS-008Ohp-82; Wed, 21 Feb 2024 22:56:06 +0100
Date: Wed, 21 Feb 2024 22:56:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] power: reset: restart-poweroff: convert to module
Message-ID: <6964c19f-6ffb-4d9a-bc02-ffaf52aa23b5@lunn.ch>
References: <20240221174610.3560775-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221174610.3560775-1-alexander.sverdlin@siemens.com>

On Wed, Feb 21, 2024 at 06:46:07PM +0100, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> The necessity of having a fake platform device for a generic, platform
> independent functionality is not obvious.
> Some platforms requre device tree modification for this, some would require
> ACPI tables modification, while functionality may be useful even to
> end-users without required expertise. Convert the platform driver to
> a simple module.

> @@ -47,15 +45,8 @@ static const struct of_device_id of_restart_poweroff_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, of_restart_poweroff_match);
>  
> -static struct platform_driver restart_poweroff_driver = {
> -	.probe = restart_poweroff_probe,
> -	.remove = restart_poweroff_remove,
> -	.driver = {
> -		.name = "poweroff-restart",
> -		.of_match_table = of_restart_poweroff_match,
> -	},
> -};

of_restart_poweroff_match now seems to be disconnected from the
driver.

kirkwood-linkstation.dtsi:		compatible = "restart-poweroff";
kirkwood-lsxl.dtsi:		compatible = "restart-poweroff";
orion5x-linkstation.dtsi:		compatible = "restart-poweroff";
orion5x-lswsgl.dts:		compatible = "restart-poweroff";

How do these devices get this driver loaded?

This appears to be another reason to NACK it.

	Andrew

