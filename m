Return-Path: <linux-kernel+bounces-119080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E3988C3F9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87D471C3E64A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802E18626B;
	Tue, 26 Mar 2024 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jI+XzbRe"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0060E8625E;
	Tue, 26 Mar 2024 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711460535; cv=none; b=gjDFrERoW8jrcqtTGeajdZuC7jCG6iqw16++RMl7HPEZjRowUyNWeqgH8QJEPdDr9xgvqxmJzDbud08PwVfF2PnSYUwv2fo2gmJIBv732l6sm9JOrtMtlFpSllyJfQ1k2fge+W1YtuxCR8QZhNbJgHSv8EFQHJeUUUHMU9MSWoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711460535; c=relaxed/simple;
	bh=GE384zJ2zl0wxnEset36cttK55sE59MZHr6t9/cvvFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJD69VgJUPl4UMl66B/Tl6Z3AM93lJLBcNDy9TERGfy5f5gAa7+9AhCaEYAfhKo9cEfYlhCH9eP9/aZhODEIJgQ7/3RsG4Hn5iYvTvo8D2rh+M0cyqB/ZJopLJpAI+HMvom3KyVLdoencNOVlHIJvaMf6ACZYss7Lt5GScae4iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jI+XzbRe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0H0SVVafNEIHPuTghJFK0QlcgLMitktxgy/wCbUNVnk=; b=jI+XzbRe3qobLyb6lupSjHudZo
	aXoopCP6oLAOqjRZeEWIpOv5wKAbu0Pui5EbWnOuxDN0TUQKnN6xVnLVttK50Vi/knvYDAMNr2HOY
	kzNU7wiCFigHmXgKw7OMJV/om0qEa8IZdtwKXbE3nMNaGPEuYNg2glwoKHGNKc7C+69o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rp73z-00BHWB-Ri; Tue, 26 Mar 2024 14:42:03 +0100
Date: Tue, 26 Mar 2024 14:42:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: radhey.shyam.pandey@amd.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, git@amd.com, harini.katakam@amd.com
Subject: Re: [PATCH net-next RESEND] net: axienet: Fix kernel doc warnings
Message-ID: <70fdb9ac-f532-49fc-9966-a0dab0ced56b@lunn.ch>
References: <20240326055347.8919-1-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326055347.8919-1-suraj.gupta2@amd.com>

On Tue, Mar 26, 2024 at 11:23:47AM +0530, Suraj Gupta wrote:
> Add description of mdio enable, mdio disable and mdio wait functions.
> Add description of skb pointer in axidma_bd data structure.
> Remove 'phy_node' description in axienet local data structure since
> it is not a valid struct member.
> Correct description of struct axienet_option.
> 
> Fix below kernel-doc warnings in drivers/net/ethernet/xilinx/:
> 1) xilinx_axienet_mdio.c:1: warning: no structured comments found
> 2) xilinx_axienet.h:379: warning: Function parameter or struct member
> 'skb' not described in 'axidma_bd'
> 3) xilinx_axienet.h:538: warning: Excess struct member 'phy_node'
> description in 'axienet_local'
> 4) xilinx_axienet.h:1002: warning: expecting prototype for struct
> axiethernet_option. Prototype was for struct axienet_option instead
> 
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> 
> ---
> Note: Earlier version didn't reached to mainline due to my email
> configuration issues. So again sending out with resend tag.
> 
> 
>  drivers/net/ethernet/xilinx/xilinx_axienet.h  |  4 ++--
>  .../net/ethernet/xilinx/xilinx_axienet_mdio.c | 23 ++++++++++++++++---
>  2 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> index 807ead678551..d0d1ae3b4e2c 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> @@ -359,6 +359,7 @@
>   * @app2:         MM2S/S2MM User Application Field 2.
>   * @app3:         MM2S/S2MM User Application Field 3.
>   * @app4:         MM2S/S2MM User Application Field 4.
> + * @skb:	  Pointer to SKB transferred using DMA

There looks to be some sort of tab vs spaces issue here?

      Andrew

