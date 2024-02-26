Return-Path: <linux-kernel+bounces-81799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D5D867A35
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789A31F23095
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EEE12AAE1;
	Mon, 26 Feb 2024 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ynvz/lPN"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB013219E3;
	Mon, 26 Feb 2024 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961279; cv=none; b=OfkLrOrCyFXwKCN/mgXLhgCtuQUTr6Nzqa0h/C/Kb/WTOFUygtXHZRlmcj8Do0+7oBxtsrYipknnDnmKLLRZ4XQb3aEAPKji9LahFnfhaa+hLe/NTT4Rr5DKzOLBhIZ5EE7T8cQNdzIEnZksW3QlKTSuYOTcjRRBcjeLzaysjs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961279; c=relaxed/simple;
	bh=XaHk1CGkgz44435i/fuj0zT7LXSXHOspkU3pxQTrO7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tV+AkCwA1feSp8Ik7yXEXQvKwYUkxdT2voDifpi8UQYaqxoIpYuYehqHYzTMn8c+rYT2qY7/B4PAKs3qv2dmgG69BoeZ922xg74qsZVi3UVbE7PsZ4qwc8TbIxuVBzFzpuVObNXdZ45O7Y1gmwiUMseziQImw/0IBsLI2hQ0iv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ynvz/lPN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=OgvLF2sxTIfRPsS3ujCyxTkAmer7UG07rXHGb61zVMk=; b=Yn
	vz/lPN+xCrwZAx6sK9e2RXXTIp3hv4HL8OFQfR7MnxY3UjQduln30YkNamCCzJ0o42bBHvEFtllBx
	vzKle+N6NDcL+EW8WGvWMAY6doakPbVNU7YW4oDOf7My5yKjskwawrGDneBIAGmWLHV4xSIz5K4Ks
	5ws1ipWzW/2e1TQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1recte-008jix-Df; Mon, 26 Feb 2024 16:28:02 +0100
Date: Mon, 26 Feb 2024 16:28:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?J=E9r=E9mie?= Dautheribes <jeremie.dautheribes@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Andrew Davis <afd@ti.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	Yen-Mei Goh <yen-mei.goh@keysight.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: dp83822: support
 configuring RMII master/slave mode
Message-ID: <d14ba685-dc7e-4f99-a21e-bae9f3e6bc79@lunn.ch>
References: <20240222103117.526955-1-jeremie.dautheribes@bootlin.com>
 <20240222103117.526955-2-jeremie.dautheribes@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240222103117.526955-2-jeremie.dautheribes@bootlin.com>

On Thu, Feb 22, 2024 at 11:31:15AM +0100, Jérémie Dautheribes wrote:
> Add property ti,rmii-mode to support selecting the RMII operation mode
> between:
> 	- master mode (PHY operates from a 25MHz clock reference)
> 	- slave mode (PHY operates from a 50MHz clock reference)
> 
> If not set, the operation mode is configured by hardware straps.
> 
> Signed-off-by: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
> ---
>  .../devicetree/bindings/net/ti,dp83822.yaml      | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,dp83822.yaml b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
> index 8f4350be689c..8f23254c0458 100644
> --- a/Documentation/devicetree/bindings/net/ti,dp83822.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
> @@ -80,6 +80,22 @@ properties:
>             10625, 11250, 11875, 12500, 13125, 13750, 14375, 15000]
>      default: 10000
>  
> +  ti,rmii-mode:
> +    description: |
> +       If present, select the RMII operation mode. Two modes are
> +       available:
> +         - RMII master, where the PHY operates from a 25MHz clock reference,
> +         provided by a crystal or a CMOS-level oscillator
> +         - RMII slave, where the PHY operates from a 50MHz clock reference,
> +         provided by a CMOS-level oscillator

What has master and slave got to do with this?

Sometimes, the MAC provides a clock to the PHY, and all data transfer
over the RMII bus is timed by that.

Sometimes, the PHY provides a clock to the MAC, and all data transfer
over the RMII bus is timed by that.

Here there is a clear master/slave relationship, who is providing the
clock, who is consuming the clock. However, what you describe does not
fit that. Maybe look at other PHY bindings, and copy what they do for
clocks.

	Andrew

