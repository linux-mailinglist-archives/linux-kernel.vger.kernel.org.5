Return-Path: <linux-kernel+bounces-37733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD33183B497
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173B51F243B2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B47135A55;
	Wed, 24 Jan 2024 22:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0uFhgPeh"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B9E51021;
	Wed, 24 Jan 2024 22:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706134996; cv=none; b=lP2JAx19GaBSMtPbWMDFwvEbBP5Wk7wiaXzsW02JMPvovZjUl87HvcTvs+SihVaaSaVdJBrQPHIjlalGDG1ClTZghvrXNXF7rr1jGMnzRC/hQu0Pbpo8KXffEN1Isx6w0C8eXlI/xKACqBWH6FqjOZnWY/8QLpiZ8rUw3EMwaqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706134996; c=relaxed/simple;
	bh=4KWawv5j4pKYQY/3k4HM7ergA7lUvMlesIDP7T6CFEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEVHUNT2uLiwRCXGTsJ5kmZKoECpDMQJoBghgW6DHzrS4re+1PYg5CL/dilo3fjDMkhL/a+5u5CjB4SUUV2Oll/YecvWXHjR4zHKO0POweeLKN1fcLcCyCQrQuIWWf0K/6aes4hg4Ccl62yJ8upPI2CorZhxrpty5URgDDvAG/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0uFhgPeh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WhEirDxAudvAnH2DY4Ix5qMYIV0QQ+MAj/GV7ofEVzA=; b=0uFhgPeh3dbtl5MzMakZPzBKk0
	9WQ3VD0g1ORmSTUdXxwesZvj3LarlN9FWwA15mIQOFA9jS8B5mRC1sts+yrWXZlMLoGRkkPmVHK56
	SRAMp4qftQB5zcWq0JqZI4kNVCNO6juUuCNG3Zz9ABpoKkMpZBRmTxgD3TFrjr5vqnd8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rSleD-0062G8-2i; Wed, 24 Jan 2024 23:23:05 +0100
Date: Wed, 24 Jan 2024 23:23:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Robert Marko <robert.marko@sartura.hr>,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/3] dt-bindings: net: ipq4019-mdio: document
 now supported clock-frequency
Message-ID: <010becc5-51f6-44c1-863e-f5092ca5018c@lunn.ch>
References: <20240124213640.7582-1-ansuelsmth@gmail.com>
 <20240124213640.7582-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124213640.7582-2-ansuelsmth@gmail.com>

> +  clock-frequency:
> +    description:
> +      The MDIO bus clock that must be output by the MDIO bus hardware, if
> +      absent, the default hardware values are used.
> +
> +      MDC rate is feed by an external clock (fixed 100MHz) and is divider
> +      internally. The default divider is /256 resulting in the default rate
> +      applied of 390KHz.
> +    enum: [ 390625, 781250, 1562500, 3125000, 6250000, 12500000 ]

Hi Christian

802.3 says the clock should be up to 2.5MHz by default. So the nearest
would be 1562500. Please document that if not set, it defaults to
this. And make the driver actually default to that.

	Andrew

