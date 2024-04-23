Return-Path: <linux-kernel+bounces-156007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8AD8AFC94
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6DB4282D82
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA81E5491E;
	Tue, 23 Apr 2024 23:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oG2uZ17X"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D78F535A8;
	Tue, 23 Apr 2024 23:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713914872; cv=none; b=sVsOEFIYp2kIpMpOt1Sc/b+Vc9LJI2cX+RzmsRKh3GzQawbc6lDMSerf+y0qFpNFpmlgoGfSbgYj/CGEy9gJNUlkb+EM767jq8lWJ+DTXk713nSaBLTE2+UjZkJWWdbHodSHSv22IxZ23Nhzh0cErHJQCoo3X0UUZD9vWEWma10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713914872; c=relaxed/simple;
	bh=Di0eUS6WREMzSyk4+6QnDiMIGNndSFqM4RTH15x9824=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8ppRcWSLv8UGMDqr//TUzy3J8r9ESpLrhfC9RnxWQm7x5MnOAAEvXOCXxMvFS7HRX/x1/pPFitkfl8P5il7XTbYM7ggGzR7qOWtcChki03lkBbNPToszrEMx/1/onLqI2b0trSZQ3l07PPdg45w7AfveAZUseCeD26tBTenL6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oG2uZ17X; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2wkn34TJloC4Y8deA3NUhgvA8IvVsAZmbGxActHIjqA=; b=oG2uZ17Xn75kmR3SkL9E50tdIM
	hr8ZqQQiFqK55NOlh7LuYZO0sOrabAHSbvBRevbhSFt9iKHyQQdxgayUhaQzzGg5Mqo7hgkNot8Z0
	gCWEqrHOjKkWkhoV9W2QEsVq+V0BOUtC1Mp6KO5sRwvj8YHbzYXlupdG/q+xYJcamkSI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rzPY6-00Dl56-Tz; Wed, 24 Apr 2024 01:27:42 +0200
Date: Wed, 24 Apr 2024 01:27:42 +0200
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
Subject: Re: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Message-ID: <307990fc-a196-427a-ac29-0b295bd024f7@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-6-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418125648.372526-6-Parthiban.Veerasooran@microchip.com>

On Thu, Apr 18, 2024 at 06:26:41PM +0530, Parthiban Veerasooran wrote:
> This will unmask the following error interrupts from the MAC-PHY.
>   tx protocol error
>   rx buffer overflow error
>   loss of framing error
>   header error
> The MAC-PHY will signal an error by setting the EXST bit in the receive
> data footer which will then allow the host to read the STATUS0 register
> to find the source of the error.
> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

