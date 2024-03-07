Return-Path: <linux-kernel+bounces-94787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B0787453D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1611F25C84
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B752F4A1C;
	Thu,  7 Mar 2024 00:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hoTrwCOd"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C4B4C61;
	Thu,  7 Mar 2024 00:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709772220; cv=none; b=SlIyeStSi47nSQxe8laz5MBvaStGk9etTvMRZy2+T4teWQPgaCAlLnAaB429RUHrfAx+cXFOwZWnkaB+0+Sa6C9n+cR9nrXtKl+ClXhk2JSjui8Sg05kYw8GXAWuYJkiVcIex1eJvyVz4ffwSsBp9bwj9Dcf47iurVHN7POP3z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709772220; c=relaxed/simple;
	bh=kICLgy5fS3zt0bLA8x8it0pE/DQMWVqNdsaAekk7NzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYSv2WmKlBVJN4Em3gom0wvMN7GUADMDHILpfDUI6l6XHkj528g9MoqXUoVCvdYgj0xtz1f+lsc63NKaiobacKyLQ/KLhmlbtXBsOOV2MwW+x2Bk4RaN4AIXqpCQqEDN0frlXwZbW1jy0+oNUvNZ8vak60l6Z61PnJQXqXIDovA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hoTrwCOd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wzCCuxsPBHXyXjRm5k2orXDzl3Uzi7tXXzCApNzY6Cs=; b=hoTrwCOdOWG9dzlrFUXg7GpQ2E
	abQbgLeREA0rh6a2A4JZHI3yI9dyJtPUqiNfONa5MERXDSrnO3VUCwdsQOoYQE8i1AkGqlDPW9Xxz
	BeInsjquEol0rJObi8PNjrDre/BAK7QmsBVfQsKAzQ1uQnHcr+aGyKFFRuBGaWaUGB6U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ri1rX-009XnQ-IA; Thu, 07 Mar 2024 01:43:55 +0100
Date: Thu, 7 Mar 2024 01:43:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
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
Subject: Re: [PATCH net-next v3 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Message-ID: <ea217697-fdb8-4112-ae84-62f566cdc375@lunn.ch>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-6-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306085017.21731-6-Parthiban.Veerasooran@microchip.com>

On Wed, Mar 06, 2024 at 02:20:10PM +0530, Parthiban Veerasooran wrote:
> This will unmask the following error interrupts from the MAC-PHY.
>   tx protocol error
>   rx buffer overflow error
>   loss of frame error

The standard seems to call it "Loss of framing". To me as a network
person, a frame is an L2 Ethernet packet. However, framing is
something completely different, being able to synchronise a bitstream
with some sort of markers, e.g. E1 to know where the 32 slots are.

In this context, we are not talking about packets, but the SPI bit
stream. So it would be good to use framing, not frame.

	Andrew

