Return-Path: <linux-kernel+bounces-161462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1E78B4C4B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 17:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A77C2B210DD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 15:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5256B6EB41;
	Sun, 28 Apr 2024 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="raNQShi9"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F621EB2C;
	Sun, 28 Apr 2024 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714316394; cv=none; b=bRv/9YTS8SA1niNPlaIeAMmFEUId5z8OkqEO67wvjvEGpuOGYbFL1WwsKZV2acn+AOW5Lqm8FK93od9ENtI0lfTr+9BLLlwgY5KktiYH9nf9j1UbsClPZjBk/sxoRbGny1X2asgpFgtLAN+eTQyjaCRsPJMBvaMLqNOkVvZePNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714316394; c=relaxed/simple;
	bh=2HXWv+oO6mi7iiAFeXK5e3ntyuc98kfi34Ka5nCyn3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQJEs3HuXdPzfJ8Qy8a+VHrZtr617i5lHym45Vupy9HbZ3FOuccfGQtvSqVlqT+ktM8sLT0rF/634q/DkppfZ8jlmC1D3TQSWcUzFv1kFGZgaa/Gaux0ERWB932Dw1NGKf57wPiEkkY55v48urVBQn87xiUEA+q/0AswdwP34S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=raNQShi9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YLxb0x4FrND/0FR9KaFczjg3H4SAZkyUWJ+1D4HM91c=; b=raNQShi92LlU5lNoq8qXwThBcX
	VQQwRqf2fhlhVGRjqBXYeGVwIXYfEkSD3ch1gatPiP8pb+0XFbddRs/geUGdOcLft8amJDqgcEb7u
	YyHIQ4Fwmn4IJ4n2+w09i5kKx/uFeQM8airzcTbB1wIg0jcRdJ2QCJ0LcrjV5z8gNmgk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s160C-00EC2M-TB; Sun, 28 Apr 2024 16:59:40 +0200
Date: Sun, 28 Apr 2024 16:59:40 +0200
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
Subject: Re: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Message-ID: <874654d4-3c52-4b0e-944a-dc5822f54a5d@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-6-Parthiban.Veerasooran@microchip.com>
 <Zi1Xbz7ARLm3HkqW@builder>
 <77d7d190-0847-4dc9-8fc5-4e33308ce7c8@lunn.ch>
 <Zi4czGX8jlqSdNrr@builder>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zi4czGX8jlqSdNrr@builder>

> n  |  name     |  min  |  avg  |  max  |  rx dropped  |  samples
> 1  |  no mod   |  827K |  846K |  891K |      945     |     5
> 2  |  no log   |  711K |  726K |  744K |      562     |     5
> 3  |  less irq |  815K |  833K |  846K |      N/A     |     5
> 4  |  no irq   |  914K |  924K |  931K |      N/A     |     5
> 5  |  simple   |  857K |  868K |  879K |      615     |     5

That is odd.

Side question: What CONFIG_HZ= do you have? 100, 250, 1000?  Try
1000. I've seen problems where the driver wants to sleep for a short
time, but the CONFIG_HZ value limits how short a time it can actually
sleep. It ends up sleeping much longer than it wants.

	Andrew

