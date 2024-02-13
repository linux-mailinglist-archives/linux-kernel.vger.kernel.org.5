Return-Path: <linux-kernel+bounces-63788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B3A853464
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C4E28250B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E285DF0E;
	Tue, 13 Feb 2024 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oC3rdy/M"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512AE58108;
	Tue, 13 Feb 2024 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707837272; cv=none; b=FcvioZDEBGbensA1S69xM/Txg73B2RvUI4mxtIuEhX/Rho/Z2EvgV0kr4M4Sa4vEtDH6OIWxCIABOiz4DKVf+84aWubhRlcDTixnuZ5l7IoHNotRK7DtOJjDo6IxBhr1Nec5lhegLneFZk/APiWFhiQXxWi7yAs8e37LAFQpUdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707837272; c=relaxed/simple;
	bh=HwNLTZsPflhxFoBYqc83PKw3Heyqe6HnjHfv8ZM6kR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWp/iZhi7LOnNYk7sNAyzn6exiT3H4j71PTuQSAmVlag8i/tvO+6IMbtbMO4ndbjYe45sAwGEAvWhgOfTZra4n9iRF91Eg95idVq+MpUjswh7r89mbMY4ePJVTd1fgmUygzCepjbC7vT7pesSZD4b3Y5wogJbodigMpUxEMtnL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oC3rdy/M; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=odnWc7O7r4ncyYnDFmZZqboiSqWBuGikw7FfDOHyOy8=; b=oC3rdy/MBX/widxIANuEdQxVf9
	v7UkeQP/F3UJRNUCS2k7VJW+dtAZQe7x0G6/rp5NbX8rHsgCZy1vNIiX5Vzh2x3NuHm0pnZBLw2wG
	kju38IEC91Yg2GmFOKOrlxTClpYagCS8jXwFUOzrrX4dh9msGY9PaZih5sHzq7L7gMnA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rZuUN-007h2Z-Ga; Tue, 13 Feb 2024 16:14:27 +0100
Date: Tue, 13 Feb 2024 16:14:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] net: mdio_bus: make mdio_bus_type const
Message-ID: <0e12d6bb-7338-4955-ac7e-488fbf4d4edc@lunn.ch>
References: <20240213-bus_cleanup-mdio-v1-1-f9e799da7fda@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213-bus_cleanup-mdio-v1-1-f9e799da7fda@marliere.net>

On Tue, Feb 13, 2024 at 11:48:00AM -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the mdio_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

