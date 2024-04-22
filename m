Return-Path: <linux-kernel+bounces-154207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 521518AD94C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBC08B21F2A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821CC46441;
	Mon, 22 Apr 2024 23:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UHZDGDqB"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448C44594A;
	Mon, 22 Apr 2024 23:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713829696; cv=none; b=u86qN63pYzm07tWN7TLeXva83Ql1d36XzdSbIek2aM/NNOtQ/jG4AvUtt16W/nXqccDIrJzz3oiBPznT8uYhhjTdOcceKXSiZIQEyAqgfWJm4BLGMPNqeCG7XWNBIed33/+0GxPGVWxjBFZeZJ05nB/CB1ku8AAJmGJfe04zAJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713829696; c=relaxed/simple;
	bh=Yc7YfWV2OqvmkQgm70k9rhjjb7dMSGGm3abJbjnnWc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ghj9A/BVjpLOHggjWe4wncsYAehhdD5Vi8ZwD4brDl34VoUD70X5k7RxRFg6boBo1JP3WBSRQ9KZkrH1QhbExwSgSzXSt2hrOBMBNrv21weR8OOfu6yuXKFyV7qamaAsR7OCopcpeSipz3ndwy6PjCTS84wPaKNz07f0Z/pScL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UHZDGDqB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oV2rilDACRGG3Sdf0w7IaYABAzDPmTQsqLTOnBjeGwE=; b=UHZDGDqBNYq7P1mjDd30ejFhUc
	it+/XVOFbwFOFYcEmqzHgU5B+bQvioDGkQ4IZZk1iWQqglQo2sTpWVQrA7mZWdsC4l3SRu2hwyJkj
	lcht0YVXUDwGFNXyVsSlNuZjkr477iAxbt8wYUDY2gTQ+SDBZk8KCDDZaCsTXvbfmRic=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rz3OE-00DezN-Dt; Tue, 23 Apr 2024 01:48:02 +0200
Date: Tue, 23 Apr 2024 01:48:02 +0200
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
Subject: Re: [PATCH net-next v4 02/12] net: ethernet: oa_tc6: implement
 register write operation
Message-ID: <358658e7-70b8-41c3-8999-0d6ebbc8c9b8@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-3-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418125648.372526-3-Parthiban.Veerasooran@microchip.com>

> +/**
> + * oa_tc6_write_registers - function for writing multiple consecutive registers.
> + * @tc6: oa_tc6 struct.
> + * @address: address of the first register to be written in the MAC-PHY.
> + * @value: values to be written from the starting register address @address.
> + * @length: number of consecutive registers to be written from @address.
> + *
> + * Maximum of 128 consecutive registers can be written starting at @address.
> + *
> + * Returns 0 on success otherwise failed.
> + */

I think the static analyser tools are getting more picky, and what
'Return:' .

https://elixir.bootlin.com/linux/latest/source/Documentation/doc-guide/kernel-doc.rst#L86

All the examples use Return:

That document also says:

The documentation format is verified by the kernel build when it is
requested to perform extra gcc checks::

	make W=n

And if patchwork can apply your patches, it also checks for problems
like this.

    Andrew

