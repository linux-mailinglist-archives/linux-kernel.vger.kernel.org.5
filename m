Return-Path: <linux-kernel+bounces-161184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0CE8B4815
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 22:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5E91C20CAA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 20:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6847A145359;
	Sat, 27 Apr 2024 20:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eycmWNk8"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3671523A6;
	Sat, 27 Apr 2024 20:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714250481; cv=none; b=URVJnPP3ldFZd0qKbBPPAm/IBoSXlMZA5yCxTWtnPS2bZbe5t9YJ0AaM2srjxMdOAb5uZUMu5qFGpBqLD38j1Jmu5NbfAt7d2aT/WbZt3aEGwF9+XhKblkeQo1vH7IGEFZJcZ6lxwfvnCld3vim4CWZuIafsqQmZNZjixxmE0Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714250481; c=relaxed/simple;
	bh=4eyrROfeUeXZ1E/5bYqP9k5RTs62PAIZOFOjco+9aTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jts2RCbuixIODfRNHQKUJAeyB63ShqkWIhjBYoO51CL4Gd6ulCcl3SPDZFA1tjh4AaGgVSGG6hH8CKZX0GpaT58qHQDJXZKsTFArWS4jPv8lksfNppKQXCudANCTaQXI/NhQN3Kh+kHP+J8OBms2yqXudVvE+poOgnw2zRRZ9Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eycmWNk8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=ld+uHtgFt97ApwykW28eoE43v0b9A3xe0ERkCZIcfio=; b=ey
	cmWNk8M6OukDwEBLzO5aoM0hJir2pzjZuluS3gyTAoc/cLbBfhIDzVYJtcuHevMEganX+mXSogiUL
	rkIPdxmihbFIGFheEqjymAK/ZH6kQ0smN2+gceMjL6dpj9kNtBjST6X4mCH9iR9n32mqk5m/BtFsO
	GqcX6dUyDh8feGc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s0oqr-00E9yX-Vn; Sat, 27 Apr 2024 22:40:53 +0200
Date: Sat, 27 Apr 2024 22:40:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
Cc: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 11/12] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Message-ID: <e89272b1-7780-4a91-888d-27ae7242f881@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-12-Parthiban.Veerasooran@microchip.com>
 <Zi1PxgANUWh1S0sO@builder>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zi1PxgANUWh1S0sO@builder>

On Sat, Apr 27, 2024 at 09:19:34PM +0200, Ramón Nordin Rodriguez wrote:
> Hi,
> 
> For me the mac driver fails to probe with the following log
> [    0.123325] SPI driver lan865x has no spi_device_id for microchip,lan8651
> 
> With this change the driver probes
> 
> diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/net/ethernet/microchip/lan865x/lan865x.c
> index 9abefa8b9d9f..72a663f14f50 100644
> --- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
> +++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
> @@ -364,7 +364,7 @@ static void lan865x_remove(struct spi_device *spi)
>  }
> 
>  static const struct of_device_id lan865x_dt_ids[] = {
> -       { .compatible = "microchip,lan8651", "microchip,lan8650" },
> +       { .compatible = "microchip,lan865x", "microchip,lan8650" },
>         { /* Sentinel */ }
>  };

The device tree binding says:

+  compatible:
+    oneOf:
+      - const: microchip,lan8650
+      - items:
+          - const: microchip,lan8651
+          - const: microchip,lan8650

So your DT node should either be:

compatible = "microchip,lan8651", "microchip,lan8650";

or

compatible = "microchip,lan8650"

There is no mention of lan865x in the binding, so this patch is
clearly wrong.

What do you have in your DT node?

     Andrew

