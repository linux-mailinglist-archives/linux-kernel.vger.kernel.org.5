Return-Path: <linux-kernel+bounces-139309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A628A013C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F1B1C24A7D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C097181BAD;
	Wed, 10 Apr 2024 20:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAxFe44W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C5F1836D8;
	Wed, 10 Apr 2024 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712780575; cv=none; b=EWSYAMWiyvvkGL+77UTeAEvAtQ9HgjKsCevp5UhPom5o+fe5izq6gBBm9spX1B2d3JpUMYgT6BEo4TGXTwOHaTMPbuqpmj99R09yEXgP2g3hkfyCry+rzbYE0APMOGqtuIbjsE292GvXRgOay78vUQSrYj7jfYxVGwlaqwBg25k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712780575; c=relaxed/simple;
	bh=zvb47o4mf8GUH8SVKa0m5GiIb1eeKuKunwVjqMtmuhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/WU2SLFYdPINbqqPOWlP0CF9Dzkli8br1yc/1m8bcicWCsSSOzKmh/sxO7dabVtpRV9Lnxl+1i1LKmWtCuDx8rn5TwZHGQnfpRGjS7LZtUqjNERSojjZoFnTuMjVuGCPagCuH8Qmm/CCBzFvuRlasiLUe4t5bAScihBTnKmJK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAxFe44W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759F2C43394;
	Wed, 10 Apr 2024 20:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712780575;
	bh=zvb47o4mf8GUH8SVKa0m5GiIb1eeKuKunwVjqMtmuhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WAxFe44Wo9BGnqrVxsazyCzHllK6MSAnUlKym5Kj51SsjK0vgNjrmieVANrt6HX+G
	 qQLEKWx5FAWHk42/PSn8UCU0XiCsvKwv1Cq1RSNJUoLiAFYldoa/naDB8idGENz8Cn
	 7oaS8fmWVd8LGC+mpBxWyO9BkTmLMG2xmtXojemYJ2E8ZuB5gv7BUjUJkUXZjsQuTi
	 8hfn7TaJBDH9fQGzY4heUCmkhNs7SP6C5BcAUavExJ3xURQKb5RfB7P5FtiJsckTuB
	 Av0L+T7ZKoZJ3/W/1a7E40itpF9Rznpyxv9yEZNFHQ9IL/FCJMS9TEDk01ZV6G6XbU
	 BcF363w7Bc0Ug==
Date: Wed, 10 Apr 2024 15:22:53 -0500
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Vaishnav Achath <vaishnav.a@ti.com>, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-mips@vger.kernel.org
Subject: Re: [PATCH v3 3/9] spi: dt-bindings: cdns,qspi-nor: make
 cdns,fifo-depth optional
Message-ID: <171278057106.1281345.946727466928284923.robh@kernel.org>
References: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
 <20240410-cdns-qspi-mbly-v3-3-7b7053449cf7@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240410-cdns-qspi-mbly-v3-3-7b7053449cf7@bootlin.com>


On Wed, 10 Apr 2024 11:29:06 +0200, Théo Lebrun wrote:
> Make cdns,fifo-depth devicetree property optional.
> Value can be detected at runtime.
> 
> Upper SRAMPARTITION register bits are read-only. Procedure to find FIFO
> depth is therefore to write 0xFFFFFFFF and read back to get amount of
> writeable bits.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


