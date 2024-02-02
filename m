Return-Path: <linux-kernel+bounces-49071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0B0846584
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756E01C25143
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655A18BE2;
	Fri,  2 Feb 2024 01:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1meNNi5A"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B3E8824;
	Fri,  2 Feb 2024 01:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706838229; cv=none; b=LqBsEl5RemRfySKDswLVF2kFhxUvnwnUKLJ28hyhTRMR4ny7AUB4KYA5sUdFPmel/m76KYhPyJzBkDPyIEA/ikIAzNrGfyEa0nO9jAL2+y/ETkSQoZLC9c8iFMlLagTnB16s2qQX5FU0KgYVeMeNqNJbSSlJ/WCn3TtNo8bEIAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706838229; c=relaxed/simple;
	bh=jF7cqlsOLjqdYzWUfrDIRz33gJa1OHskriEj+F8t68s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VK2wUXyvCFW4OtOfuceerGaREafzfqF3YZ3//mlq6KEMLv1wqRmZtlQjtbrP4/qIMXnSWbVSxSmh0d1sDWz8AuJh16hB6omUCa9BZzKqNkxlujxxEy125yT4wzSRwjjw+dd/2tQv8mTdRMI/w5lS0uH5PfYDrN1XhLG64gIGKs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1meNNi5A; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bUBDi/m6vanSfN7M1l7jMTNcJUjKwJryfyB1BXudoSg=; b=1meNNi5AWyupGCEBpPG/qvE0jH
	qHT2flxVKXduJRVNGc1gJPVEMWbHDwndfrIv0O1PeGOqnnlYHAPZvjLWHN+041RvQJD61XXP2H4ob
	z0KuDS3B5b0uBdNL4Caud36vx4KSxonWgw4GwgG0ciql4H59CS3VGJ10jEwgCgA4o5KY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rViaf-006jmC-Ku; Fri, 02 Feb 2024 02:43:37 +0100
Date: Fri, 2 Feb 2024 02:43:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Rowand <frowand.list@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v5 9/9] net: phy: qca807x: add support for
 configurable LED
Message-ID: <46085abf-8e82-4fd9-95b8-95cbfde6e5c2@lunn.ch>
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
 <20240201151747.7524-10-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201151747.7524-10-ansuelsmth@gmail.com>

> +
> +			phydev->drv->led_brightness_set = NULL;
> +			phydev->drv->led_blink_set = NULL;
> +			phydev->drv->led_hw_is_supported = NULL;
> +			phydev->drv->led_hw_control_set = NULL;
> +			phydev->drv->led_hw_control_get = NULL;

I don't see how that works. You have multiple PHYs using this
driver. Some might have LEDs, some might have GPOs. But if you modify
the driver structure like this, you prevent all PHYs from having LEDs,
and maybe cause a Opps if a PHY device has already registered its
LEDs?

	Andrew

