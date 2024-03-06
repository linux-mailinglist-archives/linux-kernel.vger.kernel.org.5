Return-Path: <linux-kernel+bounces-93970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C95F8737A7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E807BB21BE4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BBB130E4F;
	Wed,  6 Mar 2024 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nyCCt4HJ"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585487FBBB;
	Wed,  6 Mar 2024 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709731377; cv=none; b=PwQNB1gTWCvEi3oYa8Sc6fwPmYq7zvjKRovqGJKcGrdlCMhSHbghsRsKFGO5yZui60K07qlN13cxIL2eOCzEAFiZkjGIuYiMG5lWWqS1E+4+1CF9xLrwyYEL5yN2przessVyRi6nb1O/APdhCVtYtnzKa7x3v8qVpIIKaWdpeTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709731377; c=relaxed/simple;
	bh=AiC9AW9SlEeYPoT4eBcY70QfneOuJXIcLXtUT44gtgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PE6HhuHDBfTMUPm4/Jt598effEKXiIEkIKigfIXTnrKInXnwR2e/i13Qq/OQHtcYkWito6BQ3u3QQsZkO3bnZ8VVDoWo8CCbm6M66Ze6Qw5/f7hUgY9jIIFxaV1zvaprHCO7lr51UvTZ27WDVN3J2r8ltZs1E0/keOcylybqtlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nyCCt4HJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=CyliuXx5jnaQWNIcwxFiT//xnk7QUNFAbqcqIZ2t6/I=; b=ny
	CCt4HJxGljBZAXdQf+XQ1u+xTvbL6XtnsqPRMNOu7SF3y1j/VD5gIlLAp9mAYVbNFXoxamtgHPCjt
	sJiPEIB25kyJLDgtAw15fdQNKafWz6RDTdNJrVHb6ZKPMC143xqCn2VQ5H+SHvpnIwQl/GWsk/oW6
	p+MO9H+n9vaZAC4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rhrEj-009VBP-II; Wed, 06 Mar 2024 14:23:09 +0100
Date: Wed, 6 Mar 2024 14:23:09 +0100
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
Subject: Re: [PATCH net-next v3 01/12] Documentation: networking: add OPEN
 Alliance 10BASE-T1x MAC-PHY serial interface
Message-ID: <a9c8a5b1-866e-4ade-ad07-af715042ec9c@lunn.ch>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-2-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240306085017.21731-2-Parthiban.Veerasooran@microchip.com>

> +NORX (Bit 29) - No Receive flag. The SPI host may set this bit to prevent
> +                the MAC-PHY from conveying RX data on the MISO for the
> +		current chunk (DV = 0 in the footer), indicating that the
> +		host would not process it. Typically, the SPI host should
> +		set NORX = 0 indicating that it will accept and process
> +		any receive frame data within the current chunk.
> +
> +RSVD (Bit 28..24) - Reserved: All reserved bits shall be ‘0’.
> +
> +VS (Bit 23..22) - Vendor Specific. These bits are implementation specific.
> +                  If the MAC-PHY does not implement these bits, the host
> +		  shall set them to ‘0’.
> +
> +DV (Bit 21) - Data Valid flag. The SPI host uses this bit to indicate
> +              whether the current chunk contains valid transmit frame data
> +	      (DV = 1) or not (DV = 0). When ‘0’, the MAC-PHY ignores the
> +	      chunk payload. Note that the receive path is unaffected by
> +	      the setting of the DV bit in the data header.

There is some odd indentation going on here. Maybe tab vs spaces?

Otherwise, this is nice documentation. Thanks.

	Andrew

