Return-Path: <linux-kernel+bounces-117196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3261288A889
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626C81C60388
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D5B142E82;
	Mon, 25 Mar 2024 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GxTPaohn"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76031487B0;
	Mon, 25 Mar 2024 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711375305; cv=none; b=Jg8CsoELbdmRoWMSlaigs9TVp4OQHiNlfqbtW6ccZNXbk1XEMlMCewjfRjPHb8ipn7oDjp/iyGvhLDJ8yZqg35kJLUWbcMM3+m+QGQf1jnHuoxJBKx3FvruQHg8P1bYdy6n76FPXcG5Yg1Os4SVMaJWaCl+97jGk9h1VzuA3C5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711375305; c=relaxed/simple;
	bh=jic4dEs8qGsio8MRj+nClTAlffSFOdO5OYSuzJb0Mk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8IDPI/lE3V/w5j7Hol8a4mcjqLvr9fw8Jnl3F+KXSyyQeUFeuGnxWY500rAt/Y8IQGqLvNUpZvgEUoj9eGYApIraVPI6nniTaxTTyt/Vv9FDGoyBvZWNu5dIOrZWGMaQAhoSsBj0+YicWF6L8YHgWqPV50w5lhrTDaB8wfY39w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GxTPaohn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OMnmBgEXlYGv7NxzAxb6sjFL3aSygoBc4+Czs1kWAds=; b=GxTPaohnB/8VcBvkR5EJk4Sxfg
	EJJ7gU7vLNXQuAmdpI6IobENPvd8RzUDq4lG/YyoFCB4XTkZhYsBsWQiIx6BlorK1v30Hc7zRNQiU
	A1+T2F3lwJbapZ11ZSHJeDtgbRVDsu/gVuL/WGlcA9e7NU2T9NgC61lK0omv1MWmNPWU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1roktL-00B9zr-AO; Mon, 25 Mar 2024 15:01:35 +0100
Date: Mon, 25 Mar 2024 15:01:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban.Veerasooran@microchip.com
Cc: benjamin@bigler.one, netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Horatiu.Vultur@microchip.com, Woojung.Huh@microchip.com,
	Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, corbet@lwn.net, Steen.Hegelund@microchip.com,
	rdunlap@infradead.org, horms@kernel.org, casper.casan@gmail.com
Subject: Re: [PATCH net-next v2 0/9] Add support for OPEN Alliance 10BASE-T1x
 MACPHY Serial Interface
Message-ID: <b1e87ca5-f126-4381-a530-75217894cc4a@lunn.ch>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <ea86159bb555336ae21311770e3a1a6374092e64.camel@bigler.one>
 <0596fce8-223b-494e-907e-f13d75f211cd@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0596fce8-223b-494e-907e-f13d75f211cd@microchip.com>

> It looks like the IRQ is asserted on RESET completion and expects a data
> chunk from host to deassert the IRQ. I used to test the driver in RPI 4
> using iperf3. For some reason I never faced this issue, may be when the
> network device is being registered there might be some packet 
> transmission which leads to deliver a data chunk so that the IRQ is
> deasserted.

If you have IPv6 enabled, the network stack will try to add a link
local IPv6 address to the interface, which means performing a
Duplicate Address Detection. That means sending a few packets.

Try disabling IPv6 if you want to reproduce the problem.

	  Andrew

