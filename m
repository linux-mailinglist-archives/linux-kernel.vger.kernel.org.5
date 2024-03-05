Return-Path: <linux-kernel+bounces-92622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A3F8722FE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03AD41F25E57
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0056E128366;
	Tue,  5 Mar 2024 15:39:26 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BA6127B49;
	Tue,  5 Mar 2024 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709653165; cv=none; b=B3lwTel7O3BAcP+3zsMbO7a4dEHHjaoe1wB24538B698mz2/WrXJw/5INkZ60tRJjq6qDVx8t9FpxI3+XkMWiOkSUBi/rdq9YBohgBhqwP61AgeC+wZ/cAYGV4bqbw4pK/rE3OKayD6kM9nqyF2MMRxRTaavunLGPqVmbn5DQI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709653165; c=relaxed/simple;
	bh=UVNTCyFwYrdoLrekrYMqAFlJa0vOC448V5qUI+AcIl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFAQkzkp9YZr+snl6XnMDpStRKhfsuavCxWtQFzFaXjB/lfe/+9nx4mU3UQTzStrgnokok50ea2TRRKOV2U19KV0rKqBLCO6ROyOR5ImMeK1xH7qhk4xQw+wbVSDDVxpGoEaa687RpOf7DhHW65SUnn8Ws/EIhI7fD4Ouq/2Cm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.33.11] (port=59622 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1rhWsx-00E3FT-7j; Tue, 05 Mar 2024 16:39:21 +0100
Date: Tue, 5 Mar 2024 16:39:18 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Breno Leitao <leitao@debian.org>
Cc: Harald Welte <laforge@gnumonks.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	horms@kernel.org, dsahern@kernel.org,
	"open list:GTP (GPRS Tunneling Protocol)" <osmocom-net-gprs@lists.osmocom.org>
Subject: Re: [PATCH net-next 3/3] net: gtp: Move net_device assigned in setup
Message-ID: <Zec8pmBvl6r3wQUB@calendula>
References: <20240305121524.2254533-1-leitao@debian.org>
 <20240305121524.2254533-3-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240305121524.2254533-3-leitao@debian.org>
X-Spam-Score: -1.9 (-)

On Tue, Mar 05, 2024 at 04:15:23AM -0800, Breno Leitao wrote:
> Assign netdev to gtp->dev at setup time, so, we can get rid of
> gtp_dev_init() completely.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>

