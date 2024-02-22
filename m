Return-Path: <linux-kernel+bounces-75989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0074585F19D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DB60B23A75
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48A6125D7;
	Thu, 22 Feb 2024 06:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VBZDJuzs"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5204C7489;
	Thu, 22 Feb 2024 06:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708584440; cv=none; b=MeT1B74UhO8cMsPPQR2ZD+GluiXqJ6BRZyi5Jf8YRCEvrbo0wLDKWkUrub0zPzXbtyAVjGJ1weH9fkbRS5U1nlx7AtrfDK4daAnMO4eUZScHURKfgM5MEviOxLpo117Slr/UYfYFd4JTo9zPbgD7Yf/2qU5C1baZS5anLdpJckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708584440; c=relaxed/simple;
	bh=gm1YyITNKFhzWb4PEnhpoKmXDAg71x3xLzlQfBVgs7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SdAl9R7zdvCizrb+ugHJIiJnZGxMoa+pBQLxPexS22VHcbI9KI0QoumRS+pZRGVJxBQk5LVCRjTDsSy4TMIpMMfrTEqKMVslL8rIdJwoKh7uWwECtqd2qyEk9/I5bLwBXF418S8f8Bevt3eJNYCwdhG5Zf0AFGru5pM/xj4DCu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VBZDJuzs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=rZbhMbCG8na1XzrA8SgUnorhUdAmwCpVkilueFdja2A=; b=VBZDJuzsukWHN+QHTUI6uCR5Ay
	HXvBsyRp7TGoJnVIZ3SYim5+1gDT5WK9l001H20rVeYTKU21Fn4HpiQdV/lr6IODiBC0fotwwgxwA
	JNEdN4wvNQ2AoFXofV3nPCB+eM01Nmm2yepcxFKe55OIEHvPiMqLjgfOFSULzM+C+mRTiR9J2IVO8
	/Wl7xa3heRxDir30+T4xzAgOxl8am2QrZZkxPy8qDxquORzXB1sdnh0PQfFsa2SgYMzGrk5qCQEPL
	L6CUIHQUgd3qFS9qtXZs2TA94pvPKSIWeCJufh3XOGf9tfJfvEjDBn+UO9DXaFdxD3EwQZXSztr8C
	k8PgLfOw==;
Received: from 124x35x135x198.ap124.ftth.ucom.ne.jp ([124.35.135.198] helo=[192.168.2.109])
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd2qy-00000002ppU-0Tu0;
	Thu, 22 Feb 2024 06:46:44 +0000
Message-ID: <25d3b356-f44e-4b20-a6d8-9c2a3f839182@infradead.org>
Date: Thu, 22 Feb 2024 15:46:34 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net] ps3/gelic: Fix possible NULL pointer dereference
To: Dan Carpenter <dan.carpenter@linaro.org>, Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Jeff Garzik <jeff@garzik.org>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20240221-ps3-gelic-null-deref-v1-1-f4fe159c7cb0@kernel.org>
 <d8cfc517-f597-420b-a164-1d33f3117b93@moroto.mountain>
Content-Language: en-US
From: Geoff Levand <geoff@infradead.org>
In-Reply-To: <d8cfc517-f597-420b-a164-1d33f3117b93@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/22/24 03:32, Dan Carpenter wrote:
> This driver is PPC so I have never looked at the code before.  I noticed
> another issue that was introduced last December in commit 3ce4f9c3fbb3
> ("net/ps3_gelic_net: Add gelic_descr structures").
> 
> net/ethernet/toshiba/ps3_gelic_net.c
..
>    375  static int gelic_descr_prepare_rx(struct gelic_card *card,
>    376                                    struct gelic_descr *descr)
>    398          descr->skb = NULL;
>                 ^^^^^^^^^^^^^^^^^^
> NULL
> 
>    399  
>    400          offset = ((unsigned long)descr->skb->data) &
>                                          ^^^^^^^^^^^^
> Dereferenced here.

There is a fix, see '[PATCH v6 net] ps3/gelic: Fix SKB allocation':

  https://lore.kernel.org/netdev/20240221172824.GD722610@kernel.org/T/

-Geoff

