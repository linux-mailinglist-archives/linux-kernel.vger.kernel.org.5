Return-Path: <linux-kernel+bounces-133462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454DF89A40F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA9FBB214DE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792F2172789;
	Fri,  5 Apr 2024 18:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaVIHfRR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7C0171E47;
	Fri,  5 Apr 2024 18:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712341171; cv=none; b=DRZnOq3tOWH01iEnUHVd673SFoQkJM6oQ185V65g00q7q7TcEIHohAIYwwrAlr5AXGiVbp5VxiCop8DFQ52TfMKXUWzM5sb9ClCXfZwp2dDxC9wQMpreoxceWUPQDyWBqY2peLhHkXtp3nLJf56jZfz430Sce3aIuhHoc/r+fK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712341171; c=relaxed/simple;
	bh=pkDOSMewe08pcAP9M1/PTIFoF8WysSzcLDTJHP7OJds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3UEsWmWRGfT8rSh+ce+x+XFVNaTT/wbIMHWlECs4UVmWooaYAWuMrT5QU8Z+8VAQPAkimcLCm6oXEsjibsEwEdg0iecKbLIsXa6S/h5u+SwTPCpX0/+eVoHrKi3C2pI/rvsRiOt60ZepBtIhpvg2hiZnXSbIsgHv3v15HPqV3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaVIHfRR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19569C43390;
	Fri,  5 Apr 2024 18:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712341171;
	bh=pkDOSMewe08pcAP9M1/PTIFoF8WysSzcLDTJHP7OJds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UaVIHfRRwO/hECHY2ZT6je8Rc6zZmOSF5sfCPAsupkazhQPi3EiTzb3FbxJFfTuJT
	 OdcfkN22ftyg9FEnIE2bs3VGK/dWBBdqsTk/jdyLYuZtUkd9RHWpoMkQ3NsuSR9WoA
	 RSEy5VRKKJpMcxcw8WiUwsTP0f73Mp4lIKdr1RoMYDP1ZfVrKws4ZSI2h4Tj4gXgXd
	 WGi0rQgZLbAMb4q6447yM2YrckMUxQoblDl0OiVzsOM3LXxlvS5h+2KyOF/0kog+eE
	 ll6PD8jbiHIZprDO3SxVDoB9/zYwQzE2s9IyMa7NceyHo3Jb4qO9OAarHJXQpynzqa
	 IzySon7oUU0Uw==
Date: Fri, 5 Apr 2024 19:19:25 +0100
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>
Subject: Re: [PATCH net-next v2 6/9] net: dsa: microchip: dcb: add special
 handling for KSZ88X3 family
Message-ID: <20240405181925.GT26556@kernel.org>
References: <20240403092905.2107522-1-o.rempel@pengutronix.de>
 <20240403092905.2107522-7-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403092905.2107522-7-o.rempel@pengutronix.de>

On Wed, Apr 03, 2024 at 11:29:02AM +0200, Oleksij Rempel wrote:

..

> diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
> index 0ead198bacb2c..a520352d5b93e 100644
> --- a/drivers/net/dsa/microchip/ksz8795.c
> +++ b/drivers/net/dsa/microchip/ksz8795.c
> @@ -179,6 +179,21 @@ static int ksz8_port_queue_split(struct ksz_device *dev, int port, int queues)
>  	return ksz_prmw8(dev, port, reg_2q, mask_2q, data_2q);
>  }
>  
> +int ksz8_all_queues_split(struct ksz_device *dev, int queues)
> +{
> +	struct dsa_switch *ds = dev->ds;
> +	const struct dsa_port *dp;
> +	int ret;
> +
> +	dsa_switch_for_each_port(dp, ds) {
> +		ret = ksz8_port_queue_split(dev, dp->index, queues);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return ret;

nit: Probably it can't occur, but if dsa_switch_for_each_port() iterates
     zero times then ret is used uninitialised here.

     In any case, perhaps it is slightly nicer to reduce the scope
     of ret to inside the loop, and simply return 0 here.

> +}
> +
>  void ksz8_r_mib_cnt(struct ksz_device *dev, int port, u16 addr, u64 *cnt)
>  {
>  	const u32 *masks;

..

