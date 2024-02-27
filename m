Return-Path: <linux-kernel+bounces-83147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F889868F7B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 400ED1C2310D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C6F13A257;
	Tue, 27 Feb 2024 11:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="uA9GZEu+"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE7E1386C3;
	Tue, 27 Feb 2024 11:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709034878; cv=none; b=bF1XvnzA7qLBVjaH4dmDTG/Jwc5tALPqgJE4M3Yu9/pGBh2h4p0i56bEqOduSyt0aykAtEnXU4lcTJHcAnvlcMJ3nSswJe95IROdpVpn1cidlFGmCi8W/wwrBxP7bvdQJKVNmo0xBVNHjp0A3PR0sAz83KMSgIVMdIkaKh68UWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709034878; c=relaxed/simple;
	bh=VZ9Rjqf5D/gy+R9Y+MTa3mzy8ZRUWGvxwXfxWHRoepM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOx6BgxQn4ML73z6d2Y1bH8DxGu8eCFICLz+RzgcM8OOrHyusdG73PprXYUIdoCp8Z1QdhEnNUI7LI4Mka4evpY2fEsHN6h05YEnu68hTb/oe7XOfAUDXxJZxhfLlVVeRAzkBD/RGEFhrTzca/Osp1dPLYek8nCmGi/TYee7g2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=uA9GZEu+; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 929592074F;
	Tue, 27 Feb 2024 12:54:33 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vk_j11-XYB_f; Tue, 27 Feb 2024 12:54:33 +0100 (CET)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 1B45020190;
	Tue, 27 Feb 2024 12:54:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 1B45020190
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1709034873;
	bh=fXF1dOEZbO19a6vXcblB4Cq2Xvv4zWKbK7s9IvVHto4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=uA9GZEu+DpQUxfnDGpNDsodPd0EF78qy8WLsMHMjMAYdPaZ1lqkZeILFmt6nhpjzt
	 g1EZY/w4XjS4n9afx6nOhaWLbW6xEsVDL5r1iMySw/NW5/B+c4dNmndwUu0/v0uh2z
	 I0sK0o11HsKsV0VONddaOm829d+ZjEO9FxDGhsYp67gimLUHcI6f/TNhqdMjGdWfzw
	 XbpyDYLBAm1lwahRflHIZYKo8f5px0L+b9iLtC979zsK/R2ajn80pltZr7y3HPaCl+
	 ThXJtu+WmYiEhg6D02zaaez4obzaaBV8yzSZSRI7m/gHy5OjwxJ8N+sfFxK15e0egL
	 9h1tLh4W9hQog==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 0BB7780004A;
	Tue, 27 Feb 2024 12:54:33 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 12:54:32 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 12:54:32 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 6274B318297D; Tue, 27 Feb 2024 12:54:32 +0100 (CET)
Date: Tue, 27 Feb 2024 12:54:32 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Breno Leitao <leitao@debian.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
	<edumazet@google.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <horms@kernel.org>
Subject: Re: [PATCH net-next] xfrm: Do not allocate stats in the driver
Message-ID: <Zd3NeDB9PbWlrhNe@gauss3.secunet.de>
References: <20240222144117.1370101-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240222144117.1370101-1-leitao@debian.org>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, Feb 22, 2024 at 06:41:17AM -0800, Breno Leitao wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> Remove the allocation in the xfrm driver and leverage the network
> core allocation.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Applied to ipsec-next, thanks Breno!

