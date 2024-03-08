Return-Path: <linux-kernel+bounces-96683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3411E875FF3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E243B230F9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7515554900;
	Fri,  8 Mar 2024 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="i9+FQsaY"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAB954776;
	Fri,  8 Mar 2024 08:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887343; cv=none; b=RmGngrbsbtkYewznxKYAOYub+grlxwGhiDTsOrJ9yoSkhskLD2rHIkyQv3wx552YRoZFgJyvpduRP3ihXWJU04/mSOkUDty5ftOtsxa1q3zDblmYn0H4sfYh9NhiIDd+xdNrFSESvv6RyMr6qXZLx+Czy/aA9RCyyqU/MDVjytI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887343; c=relaxed/simple;
	bh=s88irfz7m+sRHWvnmgLwOPyx6mqYwlkGAi77IMc7hR0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdHKNvXJbu2ByUJ5bLvPgzVu7+5He//xxegfX7yD9RLiINjmzLvmo3u+NLPmbCGBSaOpS9swTryyGP9L2u81dVpWYG9eJ7EG1fVtHQYPE5OpbYG5IfsPEfcGqCb3ugAtRAY7oodqDRe530ZdBPVuQL9XvMNvRc1Ki2YmHTJsxmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=i9+FQsaY; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 6FC3220799;
	Fri,  8 Mar 2024 09:42:12 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 72PgWZLeFruj; Fri,  8 Mar 2024 09:42:11 +0100 (CET)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 0C753201A1;
	Fri,  8 Mar 2024 09:42:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 0C753201A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1709887331;
	bh=h+QvIqcEOBZeX3HX3jXFcru8qdY9Nqf6U5ZFLW+/S2g=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=i9+FQsaY5oKqrd/LN9XIiEpRHIFSSfxLQf0QsZbXTDN5/PBBf9Bx2fwpo/E+BtQpm
	 VqYstTpRiLnJVKmsWozA5txWtj47LuMYh6fNr8nsUl8ewDB02LHmZs5H4gwqNbIQbC
	 CyBFcVIb2LlI6GDrW+QJWIXGIXgcu//oeGRdZ8qvVWAVPtS+toUPsR5Nk1jpY/zG2L
	 e5it12+5PGCW8eXrE2UZvU8HnzG7Z4tsXdcAk0O3p/8kE1BmKXqpcHcaCbn8oA3Vkm
	 VYW1tlMDdlTV5gohaqX5Zkyh+5pbpuBOS+FsZPFdTfP5c6Vkg4r9jldmgzK2fj/Ag/
	 a38ZyaPWsvCMA==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id EF23380004A;
	Fri,  8 Mar 2024 09:42:10 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 09:42:10 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 8 Mar
 2024 09:42:10 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 2511F3184110; Fri,  8 Mar 2024 09:42:10 +0100 (CET)
Date: Fri, 8 Mar 2024 09:42:10 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
CC: <almasrymina@google.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David
 S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Matteo
 Croce" <mcroce@microsoft.com>, Jesper Dangaard Brouer <brouer@redhat.com>,
	<leonro@nvidia.com>, <gal@nvidia.com>, <stable@vger.kernel.org>, "Anatoli N .
 Chechelnickiy" <Anatoli.Chechelnickiy@m.interpipe.biz>, Ian Kumlien
	<ian.kumlien@gmail.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net v2] net: esp: fix bad handling of pages from page_pool
Message-ID: <ZerPYroeK/pltA9I@gauss3.secunet.de>
References: <20240307182946.821568-1-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240307182946.821568-1-dtatulea@nvidia.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, Mar 07, 2024 at 08:28:58PM +0200, Dragos Tatulea wrote:
> When the skb is reorganized during esp_output (!esp->inline), the pages
> coming from the original skb fragments are supposed to be released back
> to the system through put_page. But if the skb fragment pages are
> originating from a page_pool, calling put_page on them will trigger a
> page_pool leak which will eventually result in a crash.
> 
> This leak can be easily observed when using CONFIG_DEBUG_VM and doing
> ipsec + gre (non offloaded) forwarding:

..

> The suggested fix is to introduce a new wrapper (skb_page_unref) that
> covers page refcounting for page_pool pages as well.
> 
> Cc: stable@vger.kernel.org
> Fixes: 6a5bcd84e886 ("page_pool: Allow drivers to hint on SKB recycling")
> Reported-and-tested-by: Anatoli N.Chechelnickiy <Anatoli.Chechelnickiy@m.interpipe.biz>
> Reported-by: Ian Kumlien <ian.kumlien@gmail.com>
> Link: https://lore.kernel.org/netdev/CAA85sZvvHtrpTQRqdaOx6gd55zPAVsqMYk_Lwh4Md5knTq7AyA@mail.gmail.com
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>

This patch does not apply to the ipsec tree. Can you please rebase onto:

git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git

Thanks!

