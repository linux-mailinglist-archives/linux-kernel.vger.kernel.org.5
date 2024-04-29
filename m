Return-Path: <linux-kernel+bounces-162203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8718B578C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23F88B2379B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175AC77F15;
	Mon, 29 Apr 2024 12:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RzZObxK1"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F8874BEB;
	Mon, 29 Apr 2024 12:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392579; cv=none; b=BNyteOcnaXLG1e1R1LFg28Ge1/gQIeZ0Q7VHEY7BY88DAJ0OezOMbZlh6gyqqbnFW541hIp9tFWi4Kw3l8Rat8n3npr6i9E/mwg1j94QodMTv1h5uaY4uZsmRiHACdXPjuWMRSIUSla3iOQoVq1MRoDQIa2KTXj6ql4Wty63kz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392579; c=relaxed/simple;
	bh=5rT0MW8a+Q608EQ2WOLBLIOLnw2hvDV6qV7Xa4L4Vvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKxUHqN3ftUmL+t014HtoIeDFW+hGzoVefoTekc/520ZAF4JZ4dV2smtVZNNbPA2k90Kn+f+s06O2wWO6nqiZLBv4y8MzU17/q93Mb+SW6AriRy2du9cqoMzm4ZxhGxZJIETXYjctG+aDKFVGUMNjFwbx2vV2Ou868nhiCLAGog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RzZObxK1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=h9t4XYnMZ7pWMVqItnio1QT6PeGN1g5MdB6mzR8+nTc=; b=RzZObxK1rl9M7ufGw2N+tp6YzK
	+qFKeH4uRQ85TfaQzaBViNMA+CX3XUu172Z2q6ZVrkq5Ri+gtgvfZrY4/z0JOI0/19V3B07Ylutge
	cPHzBbN/A0xqYbqTz1z/QRk4/+HcC1Fx4bOlDEANMrTQxRifPJ4cuurky6xxl829Zp64=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s1Poq-00EFGB-Ci; Mon, 29 Apr 2024 14:09:16 +0200
Date: Mon, 29 Apr 2024 14:09:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban.Veerasooran@microchip.com
Cc: conor@kernel.org, ramon.nordin.rodriguez@ferroamp.se,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, Horatiu.Vultur@microchip.com,
	ruanjinjie@huawei.com, Steen.Hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 11/12] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Message-ID: <243dab3b-ac07-4d88-8c43-aed53a34cea9@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-12-Parthiban.Veerasooran@microchip.com>
 <Zi1PxgANUWh1S0sO@builder>
 <20240427-vaporizer-pencil-be6a25030f08@spud>
 <1ae4f1d5-140b-41b1-9191-da14fd67d409@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ae4f1d5-140b-41b1-9191-da14fd67d409@microchip.com>

> Looks like, the below changes needed to work correctly,
> 
> lan865x.c:
> - compatible string to be changed like below as it is a fallback for all 
> variants,
> 	.compatible = "microchip,lan8650"
> - DRV_NAME to be changed like below,
> 	#define DRV_NAME                        "lan8650"
> 
> microchip,lan865x.example.dts for lan8650:
> - compatible string to be changed like below,
> 	.compatible = "microchip,lan8650";
> 	OR
> microchip,lan865x.example.dts for lan8651:
> - compatible string to be changed like below,
> 	compatible = "microchip,lan8651", "microchip,lan8650";
> 
> I tested with the above changes and there was no issues observed. Any 
> comments on this? Otherwise we can stick with these changes for the next 
> version.

As Conor said, this is probably relying on the fallback
mechanism. Please look at other SPI devices, e.g. hwmon, and see how
they probe for multiple different devices.

	Andrew

